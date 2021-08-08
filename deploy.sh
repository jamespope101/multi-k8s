docker build -t jamespope101/multi-client:latest -t jamespope101/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jamespope101/multi-server:latest -t jamespope101/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jamespope101/multi-worker:latest -t jamespope101/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jamespope101/multi-client:latest
docker push jamespope101/multi-server:latest
docker push jamespope101/multi-worker:latest

docker push jamespope101/multi-client:$SHA
docker push jamespope101/multi-server:$SHA
docker push jamespope101/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jamespope101/multi-server:$SHA
kubectl set image deployments/client-deployment client=jamespope101/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jamespope101/multi-worker:$SHA
