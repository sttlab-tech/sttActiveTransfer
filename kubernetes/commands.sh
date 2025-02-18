kubectl create secret docker-registry dh-regcred --docker-server=${DH_CR_SERVER} --docker-username=${DH_CR_USERNAME} --docker-password=${DH_CR_PASSWORD} --docker-email=${DH_CR_EMAIL}

kubectl create secret docker-registry quay-regcred --docker-server=${QUAY_CR_SERVER} --docker-username=${QUAY_CR_USERNAME} --docker-password=${QUAY_CR_PASSWORD} --docker-email=${QUAY_CR_EMAIL}

kubectl create secret docker-registry sag-regcred --docker-server=${WM_CR_SERVER} --docker-username=${WM_CR_USERNAME} --docker-password=${WM_CR_PASSWORD} --docker-email=${WM_CR_EMAIL}

kubectl apply -f secrets.yaml

kubectl apply -f mft.yaml

