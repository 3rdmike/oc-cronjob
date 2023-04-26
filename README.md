# Template to build a cronjob server on Open Shift

This template project is intended for building a cronjob server on Open Shift. The demo Dockerfile also installed the Open Shift CLI binary for making scripts that manages Open Shift resources. 


## Quick Start

This template project contains Docker file, build configure, deployment config and crontab file. You can modify the Docker file to install additional dependencies and add shell scripts for the jobs. Crontab schedules are defined in the yacron.yaml file. In order to login Open Shift service account, a login token can be defined in the cronjob-secret.yaml file, or you can reference to existing token in the cronjob-deployment.yaml. Please read each file and replace the place holder with your custom params. Here is a list of steps:


1. Checkout the repository. Inspect the Dockerfile, cronjob-build.yaml, cronjob-deployment.yaml, cronjob-secret.yaml and yacron.yaml. Note the place holders in those files. Replace the namespace placeholder with real namespace value.
2. Write your bash scripts to run. The demo.sh is an example.
3. Modify the yacron.yaml. This is the crontab file to call the scripts in previous step. 
4. Modify Dockerfile. Add all dependencies to run the scripts in step 2.
5. Create an imagestream in Open Shift to store the image. Modify build cronjon-build.yaml to use the stream.
6. Commit your modified files to a new repository and add the URL to the cronjon-build.yaml.
7. Build the image. In Open Shift > Build, paste the build configure to build the image.
8. Modify cronjob-deployment.yaml. Use the image stream tag from the build. If you need to use OC CLI, use the cronjob-secret.yaml to add a service account token in Open Shift. (Or just modify the configure file to use an existing one)
9. deploy image in Open Shift or by this command
```oc apply -f cronjob-deployment.yaml```
10. check the image logs to confirm the cronjob contain is running
```
oc get pods
oc logs -f demo-cronjob-deployment-XXX
```