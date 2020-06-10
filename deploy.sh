docker build -t crank777/multi-client:latest -t crank777/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t crank777/multi-server:latest -t crank777/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t crank777/multi-worker:latest -t crank777/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push crank777/multi-client:latest
docker push crank777/multi-server:latest
docker push crank777/multi-worker:latest

docker push crank777/multi-client:$SHA 
docker push crank777/multi-server:$SHA 
docker push crank777/multi-worker:$SHA 

kubectl apply -f k8
kubectl set image deployments/server-deployment server=crank777/multi-server:$SHA 
kubectl set image deployments/client-deployment server=crank777/multi-client:$SHA 
kubectl set image deployments/worker-deployment server=crank777/multi-worker:$SHA 