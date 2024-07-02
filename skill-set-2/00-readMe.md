## build docker image and push image to docker hub
# to be able to run require(ip) in js file locally, need to do "npm install ip". do the same in Dockerfile
npm install ip

# create Dockerfile as "app.dockerfile"

# build docker image with app.dockerfile
docker build -f app.dockerfile -t dlloihub36/demo-app:0.0.1 .

# run docker image locally with port forward and environment set
docker run -p 7123:7123 --env PORT:7123 -t dlloihub36/demo-app:0.0.1

# login docker hub
docker login

# push image to docker hub
docker push dlloihub36/demo-app:0.0.1

----------------------------------------------------------------------------------------------------------------------------
## to run app.js app with docker compose
# create docker compose file as "docker-compose.yml"
# run
docker-compose up -d

# stop
docker-compose down

------------------------------------------------------------------------------------------------------------------------------
## to deply created docker image into kubernetes (k8s) setup on local PC
# create deployment yaml file with command below
kubectl create deploy demo-app --image=dlloihub36/demo-app:0.0.1 --dry-run=client -o yaml > deploy-demo-app.yaml

# edit file "deploy-demo-app.yaml" to add env under container image
        env:
          - name: PORT
            value: "7123"

# create app.js container and start pod with command
kubectl apply -f deploy-demo-app.yaml

# create service yaml file with command
kubectl expose deploy demo-app --port=8080 --name=demo-app-svc --type=NodePort --dry-run=client -o yaml > demo-app-svc.yaml

# create service with command 
kubectl apply -f demo-app-svc.yaml

# check svc
```
agu88@MSI MINGW64 ~
$ k get svc
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
demo-app-svc   NodePort    10.104.78.97    <none>        8080:31082/TCP   4s
kubernetes     ClusterIP   10.96.0.1       <none>        443/TCP          52d
nginx-svc      NodePort    10.104.200.83   <none>        80:31607/TCP     52d
```
# open browser poiting to nodes IP:31082
http://192.168.0.100:31082/
http://192.168.0.8:31082/

# to scale replicas
kubectl scale --replicas=5 deploy demo-app






