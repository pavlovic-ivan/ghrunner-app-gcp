SHELL:=/bin/bash
stack=dev1
config=config.yaml
auto-approve?=
name=ghrunner-app-function
project=
service_account=

deploy:
	gcloud beta functions deploy ${name} \
		--runtime nodejs16 \
		--trigger-http \
		--entry-point probotApp \
		--quiet \
		--project ${project} \
		--service-account=${service_account} \
		--set-secrets 'APP_ID=APP_ID:latest,PRIVATE_KEY=PRIVATE_KEY:latest,WEBHOOK_SECRET=WEBHOOK_SECRET:latest'
	gcloud beta functions add-iam-policy-binding ghrunner-app-function \
		--member="allUsers" \
		--role="roles/cloudfunctions.invoker"