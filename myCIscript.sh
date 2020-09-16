#!/bin/bash -eu

REPO="diezfx"

eval $(minikube -p minikube docker-env)
# build the build image
docker build -f build/docker/Dockerfile -t ${REPO}/dendrite:latest .

#compile and build the service
docker build -t ${REPO}/dendrite:monolith \
         --build-arg component=dendrite-monolith-server \
         -f build/docker/Dockerfile.component .
# push to repository
# docker push ${REPO}/dendrite:monolith

# create secrets
# may need a better mount
docker run  -v $PWD/.config:"/build/.config" \
  diezfx/dendrite:latest go run github.com/matrix-org/dendrite/cmd/generate-keys \
  --private-key=/build/.config/matrix_key.pem \
  --tls-cert=/build/.config/server.crt \
  --tls-key=/build/.config/server.key

#create configmap and secrets in kuberentes
cp dendrite-config.yaml .config/dendrite.yaml
kubectl delete configmap dendrite-config --ignore-not-found
kubectl create configmap dendrite-config --from-file ./.config/dendrite.yaml
kubectl delete secret dendrite-secret --ignore-not-found
kubectl create secret generic dendrite-secret --from-file .config/matrix_key.pem --from-file .config/server.crt  --from-file .config/server.key


#deploy backend and frontend to kubernetes
kubectl apply -f k8s/dendrite
kubectl apply -f k8s/element
