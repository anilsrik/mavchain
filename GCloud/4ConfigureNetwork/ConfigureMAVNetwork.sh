cd ~/mavtestfabric13/fabric-samples/multi-channel-network
echo COMPOSE_PROJECT_NAME=net > .env
../bin/cryptogen generate --config=./crypto-config.yaml
mkdir channel-artifacts
../bin/configtxgen -profile OrdererGenesis -outputBlock ./channel-artifacts/genesis.block
export CHANNEL_ONE_NAME=channelall
export CHANNEL_ONE_PROFILE=ChannelAll
export CHANNEL_TWO_NAME=channelhp
export CHANNEL_TWO_PROFILE=ChannelHP
##Channel ALL
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME
../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/HP1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg HP1MSP
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/HP2MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg HP2MSP
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Provider1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Provider1MSP

##Channel HPs
 ../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/HP1MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg HP1MSP
 ../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/HP2MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg HP2MSP

 #Docker Up
docker-compose -f docker-compose.yaml up -d
docker ps
