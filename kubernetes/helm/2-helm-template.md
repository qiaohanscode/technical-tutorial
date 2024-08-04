### Heml Feature 2 -- Templating Engine
Details about Charts can be found [Helm Charts](https://helm.sh/docs/topics/charts/).

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
#### Chart.yaml File
The file `Chart.yaml` contains the information about the chart.

#### Chart Dependencies
In Helm, one chart may depend on any number of other charts. These dependencies can be dynamically linked
using `dependencies` field in `Chart.yaml` or brought into the `charts/` directory and managed manually

Managing Dependencies with `dependencies` field
```
dependencies:
  - name: apache
    version: 1.2.3
    repository: https://example.com/charts
  - name: mysql
    version: 3.2.1
    repository: https://another.example.com/charts
```
`Note: ` The repository needs to added with `helm repo add`.