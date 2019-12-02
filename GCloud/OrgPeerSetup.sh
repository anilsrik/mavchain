#org1
docker exec -it cli bash

#org2
docker exec -e "CORE_PEER_LOCALMSPID=HP2MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hp2.mavchain.com/peers/peer0.hp2.mavchain.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hp2.mavchain.com/users/Admin@hp2.mavchain.com/msp" -e "CORE_PEER_ADDRESS=peer0.hp2.mavchain.com:7051" -it cli bash

#provider1 - provider
docker exec -e "CORE_PEER_LOCALMSPID=Provider1MSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/provider1.mavchain.com/peers/peer0.provider1.mavchain.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/provider1.mavchain.com/users/Admin@provider1.mavchain.com/msp" -e "CORE_PEER_ADDRESS=peer0.provider1.mavchain.com:7051" -it cli bash

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/mavchain.com/orderers/orderer.mavchain.com/msp/tlscacerts/tlsca.mavchain.com-cert.pem



#Org1 terminal
peer channel create -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channelall.tx --tls --cafile $ORDERER_CA
peer channel join -b channelall.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HP1MSPanchors_channelall.tx --tls --cafile $ORDERER_CA

#ORg2 terminal
peer channel join -b channelall.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HP2MSPanchors_channelall.tx --tls --cafile $ORDERER_CA

#Org3 Terminal
peer channel join -b channelall.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/Provider1MSPanchors_channelall.tx --tls --cafile $ORDERER_CA


#Org1 - ChannelHP
peer channel create -o orderer.mavchain.com:7050 -c channelhp -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channelhp.tx --tls --cafile $ORDERER_CA

peer channel join -b channelhp.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelhp -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HP1MSPanchors_channelhp.tx --tls --cafile $ORDERER_CA


#Org2 - ChannelHP
peer channel join -b channelhp.block --tls --cafile $ORDERER_CA
peer channel update -o orderer.mavchain.com:7050 -c channelhp -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/HP2MSPanchors_channelhp.tx --tls --cafile $ORDERER_CA