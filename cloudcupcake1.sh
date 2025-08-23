REGION=$(gcloud compute project-info describe \
  --format="value(commonInstanceMetadata.items[google-compute-default-region])")




cd continuous-deployment-on-kubernetes/sample-app

git checkout -b new-feature
rm Jenkinsfile html.go main.go

wget https://raw.githubusercontent.com/quiccklabs/Labs_solutions/refs/heads/master/Continuous%20Delivery%20with%20Jenkins%20in%20Kubernetes%20Engine/Jenkinsfile
wget https://raw.githubusercontent.com/quiccklabs/Labs_solutions/refs/heads/master/Continuous%20Delivery%20with%20Jenkins%20in%20Kubernetes%20Engine/html.go
wget https://raw.githubusercontent.com/quiccklabs/Labs_solutions/refs/heads/master/Continuous%20Delivery%20with%20Jenkins%20in%20Kubernetes%20Engine/main.go


sed -i "s/qwiklabs-gcp-01-2848c53eb4b6/qwiklabs-gcp-03-08cb53783f80/g" Jenkinsfile

sed -i "s/us-central1-c/us-west1-b/g" Jenkinsfile

git add Jenkinsfile html.go main.go

git commit -m "Version 2.0.0"

git push origin new-feature

git checkout -b canary

git push origin canary

git checkout master

git merge canary

git push origin master
