# Author: Mike Zhou (mike.zhou@gov.bc.ca) 2023-04-25
# Description:
# This is a template Dockerfile to build your cronjob container
# Please modify it for your applications:
#
# 1. install any dependencies for your services
# 2. update the crontab file in the crontab.yaml file
# 3. remember to create the work directory  and grant permissions for randon OC user

FROM alpine:latest

# this is the default work directory. Remember to grant permisions if you change
# it to a different directory
WORKDIR /project

# install your lib and services.
# the code here installs python3 and oc cli as examples
# python3 is used to install cronjob service
RUN apk add --no-cache curl wget tar python3 py3-pip gcompat

# install Open Shift CLI (optional)
RUN wget https://downloads-openshift-console.apps.silver.devops.gov.bc.ca/amd64/linux/oc.tar
RUN tar -xvf oc.tar
RUN mv oc /usr/bin/.

# grant work directory write permission
RUN chgrp -R 0 /project && \
    chmod -R g=u /project &&\
    chmod -R 775 /project

# grant oc cli permission to write its config file (very important or you can't switch oc user)
RUN mkdir /.kube
RUN chgrp -R 0 /.kube && \
    chmod -R g=u /.kube && \
    chmod -R 775 /.kube

# install yacron
RUN python3 -m venv yacronenv
RUN . yacronenv/bin/activate
RUN pip install yacron

# copy custom script (optional)
COPY demo.sh .
RUN chmod 777 demo.sh

# copy cronmtab file
COPY yacron.yaml .

# Run the command on container startup
CMD ["yacron", "-c", "/project/yacron.yaml"]  