docker build -t nikash19/multi-client:latest -t nikash19/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikash19/multi-server:latest -t nikash19/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikash19/multi-worker:latest -t nikash19/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikash19/multi-client:latest
docker push nikash19/multi-server:latest
docker push nikash19/multi-worker:latest

docker push nikash19/multi-client:$SHA
docker push nikash19/multi-server:$SHA
docker push nikash19/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikash19/multi-server:$SHA
kubectl set image deployments/client-deployment client=nikash19/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikash19/multi-worker:$SHA