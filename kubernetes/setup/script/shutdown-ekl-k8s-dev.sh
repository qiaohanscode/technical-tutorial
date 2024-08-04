#!/bin/bash
ekl_nodes=( \
#"ekl-k8s-master-1.ponyworld.io" \
#"ekl-k8s-worker-1.ponyworld.io" \
#"ekl-k8s-worker-2.ponyworld.io" \
#"ekl-jenkins.ponyworld.io" \
"jenkins02.ponyworld.io" \
)

for node in ${ekl_nodes[@]}
do
  echo "============ Shut down $node ==============="
  ssh tim@$node
  #sudo shutdown now
done
