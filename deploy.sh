docker build -t noemimancini/multi-client:latest -t noemimancini/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t noemimancini/multi-server:latest -t noemimancini/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t noemimancini/multi-worker:latest -t noemimancini/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push noemimancini/multi-client:latest
docker push noemimancini/multi-server:latest
docker push noemimancini/multi-worker:latest

docker push noemimancini/multi-client:$SHA
docker push noemimancini/multi-server:$SHA
docker push noemimancini/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=noemimancini/multi-server:$SHA
kubectl set image deployments/client-deployment client=noemimancini/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=noemimancini/multi-worker:$SHA
