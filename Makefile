include .env

setup: create-cluster deploy

init: configure-docker create-docker-repository push-docker-image

create-cluster:
	gcloud container --project "${GCP_PROJECT}" \
	clusters create-auto "${CLUSTER_NAME}" \
	--region "${GCP_REGION}"

delete-cluster: delete-all-cluster-resources 
	gcloud container --project "${GCP_PROJECT}" \
	clusters delete "${CLUSTER_NAME}" \
	--region "${GCP_REGION}"

list-clusters:
	gcloud container --project "${GCP_PROJECT}" \
	clusters list

configure-docker:
	gcloud auth configure-docker ${GCP_REGION}-docker.pkg.dev

create-docker-repository:
	gcloud artifacts repositories create ${DOCKER_REPO} --repository-format=docker \
	--location=${GCP_REGION} --description="Docker repository for k8s(${CLUSTER_NAME})"

list-docker-repositories:
	gcloud artifacts repositories list

delete-docker-repository:
	gcloud artifacts repositories delete ${DOCKER_REPO} --location ${GCP_REGION}

build-docker-image:
	docker build -t ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${DOCKER_REPO}/${DOCKER_IMAGE} app

push-docker-image: build-docker-image
	docker push ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${DOCKER_REPO}/${DOCKER_IMAGE}

deploy:
ifndef ENV
	$(error ENV is undefined)
endif
	kubectl kustomize kustomize/overlays/${ENV} | kubectl apply -f -

delete-all-cluster-resources:
	kubectl delete deployments,services,ingress --all

teardown: delete-cluster