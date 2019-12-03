#Starting CLI for peer 2
# docker exec -e "CORE_PEER_LOCALMSPID=HP2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hp2.mavchain.com/peers/peer0.hp2.mavchain.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hp2.mavchain.com/users/Admin@hp2.mavchain.com/msp" -e "CORE_PEER_ADDRESS=peer0.hp2.mavchain.com:7051" -it cli bash

#orderer CA env variable
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/mavchain.com/orderers/orderer.mavchain.com/msp/tlscacerts/tlsca.mavchain.com-cert.pem
#Create inital blocks
peer channel join -b channelall.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HP2MSPanchors_channelall.tx --tls --cafile $ORDERER_CA
