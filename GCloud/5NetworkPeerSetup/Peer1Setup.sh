#Start CLI for Peer 1
# docker exec -it cli bash


#orderer CA env variable
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/mavchain.com/orderers/orderer.mavchain.com/msp/tlscacerts/tlsca.mavchain.com-cert.pem
#Org1 terminal
peer channel create -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channelall.tx --tls --cafile $ORDERER_CA
peer channel join -b channelall.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HP1MSPanchors_channelall.tx --tls --cafile $ORDERER_CA