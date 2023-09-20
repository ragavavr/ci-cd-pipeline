[![Github Actions](https://github.com/ragavavr/ci-cd-pipeline/actions/workflows/python-app.yml/badge.svg)](https://github.com/ragavavr/ci-cd-pipeline/actions/workflows/python-app.yml)
[![Build Status](https://dev.azure.com/vigneshrsr/python-flask-webapp/_apis/build/status%2Fragavavr.ci-cd-pipeline?branchName=main)](https://dev.azure.com/vigneshrsr/python-flask-webapp/_build/latest?definitionId=9&branchName=main)

# Overview

This project hosts a python application that is designed to predict housing prices in Boston (app not created by me). This repo will enable you to:

* Deploy the app in Azure Cloud Shell
* Deploy it in Azure App Service as well

Commits to this GitHub repo triggers automated code linting and testing for Continuous Integration (CI) using GitHub Actions. A pipeline has been created in Azure DevOps, and the updated code is also automatically tested in Azure DevOps and deployed to the Azure App Service.

## Project Plan
A [Trello board](https://trello.com/b/wibwCRbG/building-a-ci-cd-pipeline) keeps track of the tasks to be completed which was created from a [spreadsheet](https://docs.google.com/spreadsheets/d/1HAEk1q2HCSWkx1qMwjzDKG0kIgvKobVZ/edit#gid=1040777021) that manages the project schedule.

## Instructions
Here is an architectural diagram showing how key parts of the system work:

![arch-diagram](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/5aa27fef-6de1-44a7-baaf-523030c376c5)

### Deploy the app in Azure Cloud Shell
In Azure Cloud Shell, clone the repo:
```
git clone https://github.com/ragavavr/ci-cd-pipeline.git
```
Change into the new directory, create a virtual environment and activate it:
```
cd ci-cd-pipeline
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate
```
Install dependencies in the virtual environment and run tests:
```
make all
```
![Screenshot 2023-09-15 125506](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/e2866b7f-6cec-4f63-a8f3-e17c8e4c7a65)

Start the application in the local environment:
```
python3 app.py
```
Open a separate Cloud Shell and test that the app is working:
```
./make_prediction.sh
```
The output should be as follows:

![Screenshot 2023-09-15 140439](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/fde13eb8-30f7-4245-8102-e36661e38547)

### GitHub Actions for Continuous Integration (CI)
Enable GitHub Actions in the GitHub UI and setup the work flow. Run the workflow to verify that the build is successful with tests passing:

![Screenshot 2023-09-16 104406](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/d7c5bc19-e0f2-4748-b2ce-03bcaae04a8f)

### Deploy the app to Azure App Service
The app was deployed to App Service through the Cloud Shell with the name ragava-webapp in the resource group flask-app:
```
az webapp up --name ragava-webapp --resource-group flask-app --runtime "PYTHON:3.8" --location canadacentral
```
![Screenshot 2023-09-16 104527](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/65e14aea-2087-45ee-8ca5-a04e8c070cf0)

To test that the app is running, edit line 28 of make_predict_azure_app.sh script with the DNS name of your app. Then run the script:
```
./make_predict_azure_app.sh
```
If it works, the output should be as follows:

![Screenshot 2023-09-15 145917](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/94b7595d-bbf6-4d61-b2e1-b10ce964b0fa)

And the app should be available at its URL:

![Screenshot 2023-09-15 144425](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/0e4e2fda-0824-4513-b12a-cd5d386ff91e)

View the app logs:
```
az webapp log tail --name ragava-webapp --resource-group flask-app
```
![Screenshot 2023-09-19 214728](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/23d8c461-c916-4f9b-afee-f53d8b5e15be)

### Azure Pipelines for Continuous Delivery
Next, create the pipeline in Azure DevOps. More information on this process can be found [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops&WT.mc_id=udacity_learn-wwl).

![Screenshot 2023-09-19 221304](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/b459a6ba-d8d4-414f-a2d6-dd432dd6b68f)

![Screenshot 2023-09-19 221457](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/cc0f68fc-667e-4d6f-838f-728d5a42db54)

![Screenshot 2023-09-19 221556](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/29b34dc2-b970-4ec5-bb30-00b6a6138bfe)

### Load Testing
We can use locust to do a load test against our application locally. Install locust:
```
pip install locust
```
Ensure the app is running:
```
python3 app.py
```
Start locust:
```
locust
```
Open a browser and go to http://localhost:8089. Enter the total number of users to simulate, spawn rate, set host to the web app URL, and click Start swarming:

![Screenshot 2023-09-19 114800](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/149f3d4a-c9be-42f9-8c92-f7965133caed)

You can then watch the load test:

![Screenshot 2023-09-19 114721](https://github.com/ragavavr/ci-cd-pipeline/assets/127974235/b0edee93-8818-4bb1-9022-c66071c70bd1)

### Enhancements
Currently, there is only a single branch in GitHub. In the future it would be good to create multiple branches, so that the code can initially be tested and deployed in a staging environment. If it works correctly in the staging environment, the changes could then be pushed into the production branch and the code deployed into the production environment.

## Demo
A video demo can be found [here](https://www.youtube.com/watch?v=sQWyrFV62Sk).















