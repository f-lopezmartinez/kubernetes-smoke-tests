# Kubernetes Smoke Tests
Smoke tests for Linux and Windows container networking on Kubernetes.

Validate the following container communication scenarios:
- Linux to Linux
- Windows to Windows
- Linux to Windows
- Windows to Linux

The smoke tests validate that:
- Services are given a DNS name mapped to the service VIP
- Service VIP redirects to the correct container VIP
- The overlay network between two containers is working correctly

## Prerequisites

1) Kubernetes cluster with at least:
- 1 Manager node
- 1 Linux worker node
- 1 Windows worker node

2) Kubernetes cluster has Internet access to download images.

3) Kubectl installed locally.

4) Access to Kubernetes cluster using kubectl.

## Deploy Smoke Tests

Create configmaps from the test script files:

```
kubectl create configmap linux-tests --from-file=./bin/linux-tests.sh

kubectl create configmap windows-tests --from-file=./bin/windows-tests.ps1
```

Deploy the smoke tests:

```
kubectl apply -f tests-network-automated.yaml
```

Verify the pods are running (Windows will take longer):

```
kubectl get pods -o wide
```

The tests will run every 30 seconds on the `alpine` and `wscore` pods.

View the logs for test output e.g.

```
{
    "test":
    {
        "result": "SUCCESS",
        "name": "Linux to Linux DNS",
        "id":  "1.1"
    }
}
```

Configure your container monitoring to alert on `"result": "FAIL"`


## Manual Tests

It is also possible to run the tests manually for each scenario, for example:

Deploy the pods for a scenario e.g. Linux to Linux:
```
kubectl apply -f test-linux-networking.yaml
```
Verify the pods are running:
```
kubectl get pods -o wide
```
Run tests manually inside container:
```
> kubectl exec -it alpine -- sh

> nslookup nginx.default.svc.cluster.local

Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   nginx.default.svc.cluster.local
Address: 10.96.48.167

> curl nginx.default.svc.cluster.local

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
...

```

Exit the container
```
> exit
```

Remove the test pods and service:
```
kubectl delete -f test-linux-networking.yaml
```