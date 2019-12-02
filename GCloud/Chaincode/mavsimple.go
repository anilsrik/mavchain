package main

import (
	"bytes"
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// Define the Smart Contract structure
type SmartContract struct {
}

type PatientIdAsset struct {
	IdHash      string `json:"idHash"`
	ProviderId  string `json:"providerId"`
	Eligibility string `json:"eligibility"`
}

// Init is called during chaincode instantiation to initialize any
// data. Note that chaincode upgrade also calls this function to reset
// or to migrate data.
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

// Invoke is called per transaction on the chaincode. Each transaction is
// either a 'get' or a 'set' on the asset created by Init function. The Set
// method may create a new asset by specifying a new key-value pair.
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger appropriately
	if function == "queryPatientHPs" {
		return s.queryPatientHPs(APIstub, args)
	} else if function == "createPatientHpEligibility" {
		return s.createPatientHpEligibility(APIstub, args)
	} else if function == "createPatientProviderReq" {
		return s.createPatientProviderReq(APIstub, args)
	}
	return shim.Error("Invalid Smart Contract function name.")
}

func (s *SmartContract) queryPatientHPs(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	var hp_ids [2]string
	hp_ids[0] = "hp1"
	hp_ids[1] = "hp2"

	//{[{"HP": "hp1", "Eligibility":true}, }
	// buffer is a JSON array containing QueryResults
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for _, hp_id := range hp_ids {
		var patient_hp_key = args[0] + "-" + hp_id
		patient_eligibility_bytes, _ := APIstub.GetState(patient_hp_key)
		patient_eligibility := PatientIdAsset{}

		json.Unmarshal(patient_eligibility_bytes, &patient_eligibility)

		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"HP\":")
		buffer.WriteString("\"")
		buffer.WriteString(hp_id)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Eligibility\":")
		// Record is a JSON object, so we write as-is
		buffer.WriteString(string(patient_eligibility.Eligibility))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true

	}
	buffer.WriteString("]")
	fmt.Printf("- queryAllEligibility:\n%s\n", buffer.String())

	return shim.Success(buffer.Bytes())
}

func (s *SmartContract) createPatientHpEligibility(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	var patient_eligibility = PatientIdAsset{IdHash: args[1], ProviderId: args[2], Eligibility: args[3]}

	patient_eligibility_bytes, _ := json.Marshal(patient_eligibility)
	APIstub.PutState(args[1]+"-"+args[2], patient_eligibility_bytes)

	return shim.Success(nil)
}

func (s *SmartContract) createPatientProviderReq(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 2 {
		return shim.Error("Incorrect number of arguments. Expecting 2")
	}

	var patient_eligibility = PatientIdAsset{IdHash: args[1], ProviderId: args[2], Eligibility: ""}

	patient_eligibility_bytes, _ := json.Marshal(patient_eligibility)
	APIstub.PutState(args[1], patient_eligibility_bytes)

	return shim.Success(nil)
}

// main function starts up the chaincode in the container during instantiate
func main() {
	if err := shim.Start(new(SmartContract)); err != nil {
		fmt.Printf("Error starting MAV Simple Asset chaincode: %s", err)
	}
}
