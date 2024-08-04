## Helm
- package manager for kubernetes resources, like apt, dnf or Homebrew
- bundle of YAML files
- create your own Helm Charts with Helm
- Push them to Helm Repository
- available Helm Charts like database Apps, Monitoring Apps (prometheus)

### Three Big Concepts
- A `Chart` is a Helm package which contains all the resource definitions to run an application, tool or service inside K8s cluster.
- A `Repository` is the place where charts can be collected and shared.
- A `Release` is an instance of a chart running in a kubernetes cluster. One chart can be installed many times into the same cluster. Each time it is installed, a new `release` is created and each `release` has its own release name.

### Finding Charts `helm search`

search the Artifact Hub, which lists helm charts from dozens of different repositories.
```
helm search hub k8s-dashboard -o yaml
```

without filter, shows all the available charts
```
helm search hub
```

search the repositories hat have been added to the local helm client (with
helm repo add). The search is done over local data, and no public network
connection is needed. Find the names of the charts in repositories you have
already added.
```
helm repo update  # Make sure we get the latest list of charts
helm search repo dashboard 
```

### List Local Repositories
list installed chart repositories.
```
helm repo list
```

### Customizing the Chart Before Installing
To see what options are configurable on a chart, use the following command
```
helm show values k8s/dashboard
```

You can override any of these settings in a YAML formatted file, and then pass that file during installation
```
echo '{mariadb.auth.database: user0db, mariadb.auth.username: user0}' > values.yaml
helm install -f values.yaml k8s-dashboard/kubernetes-dashboard --generate-name
```

There are two ways to pass configuration data during install:
- `--values` or `-f`: specify a YAML file with overrides. The rightmost file will take precedence when multiple times
  specified.
- `--set`: specify overrides on the command line

If both are used, `--set` values are merged into `--values` with higher precedence.

Values that have been `--set` can be viewed for a given release with `helm get values <release-name>`

Values that have been `--set` can be cleared by running `helm upgrade --reset-values`

The `--set` option takes zero or more name/value pairs. It is used like `--set a=b,c=d`. The YAML equivalent of
that is:
```
a: b
c: d
```
More complex expressions are supported, `--set outer.inner=value` is translated into:
```
outer:
  inner: value
```

Lists can be expressed by enclosing values in `{` and `}`. For example
`--set name={a,b,c}`translates to:
```
name:
  - a
  - b
  - c
```

Certain name/key can be set to be `null` or to be an empty array `[]`.
For example, `--set name=[],a=null` translates
```
name: []
a: null
```

It is possible to access list items using an array index syntax. For example,
`--set servers[0].port=80,servers[0].host=example` becomes:
```
servers:
  - port: 80
    host: example
```

Special characters can be escaped with a backslash \;

`--set name=value1\,value2` becomes:
```
name: "value1,value2"
```

`--set nodeSelector."kubernetes\.io/role"=master` becomes:
```
nodeSelector
  kubernetes.io/role: master
```

Deeply nested data structure can be difficult to express using `--set`. Chart designers are encouraged to use `values.yaml`file.

The `helm install` command can install from several sources:
- A chart repository
- A local chart archive (`helm install foo foo-0.1.1.tgz`)
- An unpacked chart directory (`helm install foo path/to/foo`)
- A full URL (`helm install foo https://example.com/charts/foo-1.2.3.tgz`)

When you want to change the configuration of your release you can use `helm upgrade` command.
```
helm upgrade -f k8s-dashboard.yaml k8s-dashboard k8s-dashboard/kubernetes-dashboard
```
The `k8s-dashboard` release is upgraded with the same chart, but with a new YAML file.

Use `helm get values` to check whether new setting took effect.
```
helm get values k8s-dashboard
```

To roll back a previous release using `helm rollback [RELEASE] [REVISION]`
```
helm rollback k8s-dashboard 1
```
The above rolls back our k8s-dashboard to its very first release version. A release version is an incremental revision. Every time an install, upgrade or rollback happens, the revision number is incremented by 1. Use `helm history [RELEADE] to see revision numbers for a certain release.

The chart repositories change frequently, youu can update the repository by running
```
helm repo update
```

To show all the installed release
```
helm list --all-namespaces
```

Uninstall a release
```
helm uninstall k8s-dashboard
```

### Helm Feature 3 -- Release Management
- Helm 2, Helm Client (CLI) and Helm Server (TIller).
- Helm 3, only Helm Client (CLI), because Tiller has been removed due to security concerns
- 
### Creating your own chart