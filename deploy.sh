docker build -t e-shuster/multi-client:latest -t e-shuster/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t e-shuster/multi-server:latest -t e-shuster/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t e-shuster/multi-worker:latest -t e-shuster/multi-worker:$SHA -f ./worker/Dockrfile ./worker

docker push e-shuster/multi-client:latest
docker push e-shuster/multi-server:latest
docker push e-shuster/multi-worker:latest

docker push e-shuster/multi-client:$SHA
docker push e-shuster/multi-server:$SHA
docker push e-shuster/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eshsuter/multi-server:$SHA
kubectl set image deployments/client-deployment client=e-shuster/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=e-shuster/multi-worker:$SHA
