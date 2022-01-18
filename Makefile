include .env
create-cluster:
	gcloud container --project "${GCP_PROJECT}" \
	clusters create-auto "${CLUSTER_NAME}" \
	--region "${CLUSTER_REGION}"

delete-cluster:
	gcloud container --project "${GCP_PROJECT}" \
	clusters delete "${CLUSTER_NAME}" \
	--region "${CLUSTER_REGION}"

list-clusters:
	gcloud container --project "${GCP_PROJECT}" \
	clusters list
