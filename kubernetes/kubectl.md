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

export configmap to yaml file
```
kubectl get configmap kube-proxy -n kube-system -o yaml > configmap-kube-proxy.yaml
```

apply a configuration to the namespace. The component will be created to the current active namespace if namespace is not specified
```
kubectl apply -f secret.yaml --namespace=my-namespace
```

scale a deployment
```
kubectl scale --replicas=2 deployment $DEPLOYMENT_NAME
```

show logs as a stream, the new logs will be showed in stream
```
kubectl logs -n kube-system --follow=true calico-node-b5d72
```

```
# list deployments of all namespaces
kubectl get deployment -A

# show pods with more details and watch for change
kubectl get pod -A -o wide --watch

# a list of global command-line options (applies to all commands)
kubectl options

# generate a deployment yaml file
kubectl create deployment nginx-deply --image nginx --replicas 3 --dry-run=client -o yaml > nginx-deply.yaml

# list all existing k8s ressources/components
kubectl api-resources --namespaced=true
kubectl api-resources

# print the client and server version information of the current context
kubectl version

# print the setting about replica
kubectl get replicasets

# print all resources of given namespace
kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --ignore-not-found --show-kind -n default|less -N

# Using kubectl api-resources and for Loop
for i in $(kubectl api-resources --namespaced --verbs=list -o name | tr "\n" " ");
do
kubectl get $i --show-kind --ignore-not-found;
done

# Retrieving a list of multiple resource types
kubectl get configmaps,pv,endpoints,ingress,serviceaccounts -n kubernetes-dashboard

# delete a component with configuration yaml
kubectl delete -f nginx-service

# create a secret
echo -n 'password' | base64

# print the configmap from public accessible namespace kube-public
kubectl cluster-info
kubectl edit deployment $DEPLOYMENT_NAME -o yaml

kubectl create deployment nginx-deply --image nginx

kubectl exec -it $POD_NAME -- /bin/bash
```

To see your configuration
```
kubectl config view
```