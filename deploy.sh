docker build -t lijahthedev/multi-client:latest -t lijahthedev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lijahthedev/multi-server:latest -t lijahthedev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lijahthedev/multi-worker:latest -t lijahthedev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lijahthedev/multi-client:latest
docker push lijahthedev/multi-server:latest
docker push lijahthedev/multi-worker:latest

docker push lijahthedev/multi-client:$SHA
docker push lijahthedev/multi-server:$SHA
docker push lijahthedev/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=lijahthedev/multi-server:$SHA
kubectl set image deployment/client-deployment client=lijahthedev/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=lijahthedev/multi-worker:$SHA