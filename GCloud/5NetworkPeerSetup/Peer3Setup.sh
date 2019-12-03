#Starting CLI for peer 3
#provider1 - provider
# docker exec -e "CORE_PEER_LOCALMSPID=Provider1MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/provider1.mavchain.com/peers/peer0.provider1.mavchain.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/provider1.mavchain.com/users/Admin@provider1.mavchain.com/msp" -e "CORE_PEER_ADDRESS=peer0.provider1.mavchain.com:7051" -it cli bash

#orderer CA env variable
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/mavchain.com/orderers/orderer.mavchain.com/msp/tlscacerts/tlsca.mavchain.com-cert.pem
#Create inital blocks
peer channel join -b channelall.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/Provider1MSPanchors_channelall.tx --tls --cafile $ORDERER_CA
