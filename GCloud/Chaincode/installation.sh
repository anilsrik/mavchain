peer chaincode install -n mavsimple2 -p github.com/chaincode/mavsimple2 -v 1.0

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/mavchain.com/orderers/orderer.mavchain.com/msp/tlscacerts/tlsca.mavchain.com-cert.pem
peer chaincode instantiate -o orderer.mavchain.com:7050 --tls --cafile $ORDERER_CA -C channelall -c '{"Args": []}'  -n mavsimple2 -v 1.0 -P "OR('HP1MSP.peer', 'HP2MSP.peer', 'Provider1MSP.peer')"
peer chaincode invoke -C channelall -n mavsimple2 -c '{"Args":["createPatientProviderReq","hash1234", "provider1"]}'
peer chaincode invoke -C channelall -n mavsimple2 -c '{"Args":["createPatientHpEligibility","hash1234", "hp1", "true" ]}'
peer chaincode invoke -C channelall -n mavsimple2 -c '{"Args":["createPatientHpEligibility","hash1234", "hp2", "false" ]}'
peer chaincode invoke -C channelall -n mavsimple2 -c '{"Args":["queryPatientHPs","hash1234", "provider1"]}'




peer chaincode instantiate -o orderer.mavchain.com:7050 --tls --cafile $ORDERER_CA -C channelhp -c '{"Args":["hash1234-hp2", "yes"]}' -n mavsimple2 -v 1.1 -P "OR('HP1MSP.peer', 'HP2MSP.peer')"
peer chaincode query -C channelhp -n mavsimple2 -c '{"Args":["get","hash1234"]}'
