NAMESPACE=1475a9-test
TODAY=`date +"%Y-%m-%d"`

echo $TODAY
echo demo cronjob started

# login open shift
oc login --token=$OC_TOKEN --server=https://api.silver.devops.gov.bc.ca:6443

# print pods
for pod in `oc get pods -l app=ols-router-web -n ${NAMESPACE} | grep -v ^NAME | awk '{print $1}'`; do
    # print out pod name
    echo $pod;
done

echo demo cronjob ended
echo
