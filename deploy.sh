docker build -t eshuster/multi-client:latest -t eshuster/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eshuster/multi-server:latest -t eshuster/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eshuster/multi-worker:latest -t eshuster/multi-worker:$SHA -f ./worker/Dockrfile ./worker

docker push eshuster/multi-client:latest
docker push eshuster/multi-server:latest
docker push eshuster/multi-worker:latest

docker push eshuster/multi-client:$SHA
docker push eshuster/multi-server:$SHA
docker push eshuster/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eshsuter/multi-server:$SHA
kubectl set image deployments/client-deployment client=eshuster/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eshuster/multi-worker:$SHA
