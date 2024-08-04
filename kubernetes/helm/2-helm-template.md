### Heml Feature 2 -- Templating Engine
- define own chart with `{{.values}}`
  Helm Chart Structure
```
mychart/
  Chart.yaml
  values.yaml
  charts/
  templates/
  ....
 
 helm install <chartname>
 
 optionally README 
 
 #values.yaml, default
 imageName: myapp
 port: 8080
 version : 1.0.0
 
 
# my-values.yaml, override values
version: 2.0.0

helm install --values=my-values.yaml <chartname>
or
helm install --set version=2.0.0
```