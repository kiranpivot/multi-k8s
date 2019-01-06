docker build -t kiranpivot/multi-client:latest -t kiranpivot/multi-client:$SHA -f client/Dockerfile ./client
docker build -t kiranpivot/multi-worker:latest -t kiranpivot/multi-worker:$SHA -f worker/Dockerfile ./worker
docker build -t kiranpivot/multi-server:latest -f kiranpivot/multi-server:$SHA -f server/Dockerfile ./server

docker push kiranpivot/multi-client:latest
docker push kiranpivot/multi-worker:latest
docker push kiranpivot/multi-server:latest

docker push kiranpivot/multi-client:$SHA
docker push kiranpivot/multi-worker:$SHA
docker push kiranpivot/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kiranpivot/multi-server:$SHA
kubectl set image deployments/client-deployment client-kiranpivot/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kiranpivot/multi-worker:$SHA