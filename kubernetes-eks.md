open an interactive terminal im pod

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
