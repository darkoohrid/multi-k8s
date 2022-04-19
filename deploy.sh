# Build all our images, tag each one 
docker build -t darkoohrid/multi-client:latest -t darkoohrid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t darkoohrid/multi-server:latest -t darkoohrid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t darkoohrid/multi-worker:latest -t darkoohrid/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# Push each to docker hub
docker push darkoohrid/multi-client:latest
docker push darkoohrid/multi-server:latest
docker push darkoohrid/multi-worker:latest

docker push darkoohrid/multi-client:$SHA
docker push darkoohrid/multi-server:$SHA
docker push darkoohrid/multi-worker:$SHA
# Apply all configs in k8s folder
kubectl apply -f k8s
# Imperatevely set latest images on each deployment
kubectl set image deployments/server-deployment server=darkoohrid/multi-server
