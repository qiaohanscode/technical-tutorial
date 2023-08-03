open an interactive terminal im pod, the option -i means "Pass stdin to the container", the option -t means "Stdin is a TTY"

```
kubectl exec amas-backend-prod-deployment-5757449dff-7852t -i -t -- bash -il
```

delete a pod forcely
```
kubectl delete pod foo --force
```
export secret to yaml file
```
kubectl get secret -o yaml my-secret-name > my-secret.yaml
```
apply a configuration to the namespace
```
kubectl apply -f secret.yaml
```
scale a deployment
kubectl scale --replicas=2 deployment $DEPLOYMENT_NAME
