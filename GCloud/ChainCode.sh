peer chaincode instantiate -o orderer.mavchain.com:7050 --tls --cafile $ORDERER_CA -C channelall -c '{"Args":["hash1234", "request_type"]}'  -n sacc -v 1.0 -P "OR('HP1MSP.peer', 'HP2MSP.peer', 'Provider1MSP.peer')"
peer chaincode query -C channelall -n sacc -c '{"Args":["get","hash1234"]}'
peer chaincode query -C channelall -n sacc -c '{"Args":["get","hash1234"]}'



peer chaincode instantiate -o orderer.mavchain.com:7050 --tls --cafile $ORDERER_CA -C channelhp -c '{"Args":["hash1234-hp2", "yes"]}' -n sacc -v 1.0 -P "OR('HP1MSP.peer', 'HP2MSP.peer')"
peer chaincode query -C channelhp -n sacc -c '{"Args":["get","hash1234"]}'
