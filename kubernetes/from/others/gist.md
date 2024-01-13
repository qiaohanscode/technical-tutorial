# `kubectl` commands and tips&tricks for [CKA](https://www.cncf.io/certification/cka/),  [CKAD](https://www.cncf.io/certification/ckad/) and [CKS](https://www.cncf.io/certification/cks/) exams<!-- {docsify-ignore-all} -->

## Quickly retrieve imperative commands to create k8s resources.

**Command:** `k run -h | grep '# ' -A2`

**When is it useful:** copy/paste command to notepad, edit values and execute to create desired resource

**Result:** list of different ways to create k8s resources imperatively using `kubectl`

## Check last 10 events on pod

**Command:** `k describe pod <pod-name> | grep -i events -A 10`

**When is it useful:** after creating/modyfing pod or during troubleshooting exercise check quickly if there are no errors in pod

**Result:** List of events in given pod

## Determine proper api_group/version for a resource

**Command1:** `k api-resources | grep -i "resource name"`

**Command2:** `k api-versions | grep -i "api_group name"`

**Example:**

`k api-resources | grep -i deploy` -> produces *apps* in APIGROUPS collumn

`k api-versions | grep -i apps` -> produces *apps/v1*

**When is it useful:** after creating/modyfing pod or during troubleshooting exercise check quickly if there are no errors in pod

**Result:** List of events in given pod

## Quickly find kube api server setting

**Command1:** `ps -ef --forest | grep kube-apiserver | grep "search string"`

**Example:**

`ps -ef --forest | grep kube-apiserver | grep admission-plugins` -> find admission plugins config

**When is it useful:** since on all the exams, kubernetes services are running as pods, it is faster to check settings with grep rather than move to folder and look at the file.

**Result:** results with settings

## Switch to namespace as default

**Command:** `kubectl config set-context --current --namespace=new namespace`

**When is it useful:** sometimes it is easier to switch to change namespace to default instead of appending namespace all the time

**Result:** kubeclt commands will be executed in new namespace by default

> HINT: Sometimes it is difficult to see what namespace is currently active, use [kube-ps1 plugin](https://github.com/jonmosco/kube-ps1) to show namespace and cluster in command line prompt

## Get help for different k8s resources

**Command:** `kubectl explain pods.spec.containers | less`

**Command variation 1:** `kubectl explain pods.spec.containers --recursive | less` (use to include info about all child resources as well)

**When is it useful:** sometimes when editing/creating yaml files, it is not clear where exaclty rsource should be placed (indented) in the file. Using this command gives a quick overview of resources structure as well as helpful explanation. Sometimes this is faster then looking up in k8s docs.

**Result:** Explanation of command

## Display all k8s resources

**Command:** `kubectl api-resources -owide`

**When is it useful:** check which resources are namespaced and also see what shortcuts to use to refer to a resource to save up on typing

**Result:** list of all resources available in the cluster

## Vim: Indent yaml after pasting yaml snipped

**Commands:**

```bash
# Set in .vimrc or on the file level
:set shiftwidth=2

# In the file insert new Line and position cursor at the start of the new line
o + Ecs

# Paste content
Shift + Insert

# Select what u want to intend
V + jjjj

# Intend block of text
>
```

**When is it useful:** Very often when pasting yaml from Kubernetes documentation, it's time consuming to manually intend text or worse, discover that you have spaces instead of tabs and got stuck unwinding it. These set of commands make it much easier

**Result:** quickly intend yaml in Vim

## Use for running utilities

[Busybox page](https://busybox.net/about.html)

>BusyBox: The Swiss Army Knife of Embedded Linux
BusyBox combines tiny versions of many common UNIX utilities into a single small executable. It provides replacements for most of the utilities you usually find in GNU fileutils, shellutils, etc. The utilities in BusyBox generally have fewer options than their full-featured GNU cousins; however, the options that are included provide the expected functionality and behave very much like their GNU counterparts. BusyBox provides a fairly complete environment for any small or embedded system.
BusyBox has been written with size-optimization and limited resources in mind. It is also extremely modular so you can easily include or exclude commands (or features) at compile time. This makes it easy to customize your embedded systems. To create a working system, just add some device nodes in /dev, a few configuration files in /etc, and a Linux kernel.

**Command:** `kubectl run -it --rm debug --image=busybox --restart=Never -- sh`

**When is it useful:** this command will create temporary busybox pod (--rm option tells k8s to delete it after exiting shell). Busybox contains lots of [utility commands](https://busybox.net/downloads/BusyBox.html)

## Verify pod connectivity

**Command:**
`kubectl run -it --rm debug --image=radial/busyboxplus:curl --restart=Never -- curl http://servicename`

**When it is useful:** when making changes to a pod, it is very important to veryify if it works. One of the best wayst to verify is to check pod connectivity. If succesfull this command will return a response.

## Get encoded csr in proper format

**Command:**
```bash
cat myuser.csr | base64 | tr -d "\n"
```

**When is it useful:** when manually creating csr, simply copying the encoded content does not properly format text and will result in parsing error.

**Result:** correctly encoded certificate key ready to be pasted in csr yaml

## Retrieve token from secret to access dashboard

**Command:**
```bash
kubectl -n kubernetes-dashboard get secret \
$(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") \
-o go-template="{{.data.token | base64decode}}"
```

**When is it useful:** when logging in to Kubernetes dashboard.

**Result:** token ready to be pasted in the token field of Kubernetes dashboard.

## Reolve service DNS

**Command**: `nslookup [SERVICE_NAME].[NAMESPACE].SVC`
**Example**: `nslookup service1.prod.svc`

## Identify field in a certificate

**Command**: `openssl x509 -noout -subject -in /path/cert.crt`
**Result**: This command outputs subject (CN) or a certificate, other fields are available in help

**Alternative Command**: `openssl x509 -in /path/cert.file -text`
**Result**: This command outputs all information about certificate

**When is it useful:** troubleshooting certificates names and paths.

## Create k8s resource on the fly from copied YAML

**Command:**
```bash
cat <<EOF | kubectl create -f -
<YAML content goes here>
EOF
```
**Command alternative:** alternatively use `cat > filename.yaml [enter] [Ctrl + Shift - to paste file content] [enter - adds one line to the file] [Ctrl + C - exit]` after that use vim/nano to edit the file and create resource based on it

**When is it useful:** sometimes it's quicker to just grab YAML from k8s documentation page and create a resource much quicker than writting YAML yourself

## Recreate pod from spec

**Command**: `kubectl replace -f file.yaml --force`

**When is it useful:** It is faster to use this command instead finding pod (often in different namespace), deleting it and creating new one

**Result**: Original pod deleted and new one created according to spec

## Save time on editing and re-creating running pods.

During the exams you are often asked to change existing pod spec. This usually requires:
- saving pod config as yaml file
- editing the file and making required changes
- deleting existing pod
- creating new pod from the file

For pods that are a bit larger it can take time to delete them and each minute counts during the exams! Here is one way to save a few seconds each time:

| step | command |
| ---- | ------- |
| saving pod config as yaml file | `kubectl get po <pod name> <optional -n namespace> -o yaml > <filename>.yaml` |
| check if file was correctly saves | `cat <filename>.yaml` |
| delete existing pod | `kubectl delete po <pod name> <optional -n namespace> --wait=false` - --wait=false flag tells kubeclt to return to shell immediatelly without watinng for pod to be deleted |
| edit the new file | `vim <or nano> <filename>.yaml` |
| create pod from the file | `kubectl create -f <filename>.yaml` |

## Useful Aliases

``` bash
alias k=kubectl
alias ks='k -n kube-system'
alias krun="k run -h | grep '# ' -A2"

export do="--dry-run=client -o yaml"

```