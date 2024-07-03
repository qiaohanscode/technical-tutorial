SERVICE_ACCOUNT=ekl-dev-jenkins

NAMESPACE=ekl-dev

CONTEXT=$(kubectl config current-context)

NEW_CONTEXT=ekl-dev-jenkins

KUBECONFIG_SA_FOLDER=ekl-dev-jenkins

KUBECONFIG_SA=${KUBECONFIG_SA_FOLDER}/config

SECRET_NAME=token-ekl-dev-jenkins

TOKEN_DATA=$(kubectl get secret ${SECRET_NAME} \
--namespace ${NAMESPACE} \
-o jsonpath='{.data.token}')

TOKEN=$(echo ${TOKEN_DATA} | base64 -d)

mkdir ${KUBECONFIG_SA_FOLDER}

kubectl config view --flatten --minify > ${KUBECONFIG_SA}

kubectl config --kubeconfig ${KUBECONFIG_SA} rename-context ${CONTEXT} ${NEW_CONTEXT} 

kubectl --kubeconfig ${KUBECONFIG_SA} \
config set-credentials ${SERVICE_ACCOUNT} \
--token ${TOKEN}

kubectl config --kubeconfig ${KUBECONFIG_SA} \
set-context ${NEW_CONTEXT} --user ${SERVICE_ACCOUNT} \
--namespace ${NAMESPACE}
