## StatefulSet for stateful applications
- deployed using `StatefulSet`
- replicating stateful application is difficult
- replica pods are not identical
- sticky identity for each `Pod`
- data will lose when all Pods die
- use `PersistentVolume`
- contains master and worker pods
- only master pod is allowed to write, worker pod is only allowed to read
- individual service name, individual dns name
`Important:` `Stateful Application` is not suitable for containerized applications