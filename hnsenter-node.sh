#!/bin/sh
set -x

node=${1}
nodeName=$(kubectl get node ${node} -o template --template='{{index .metadata.labels "kubernetes.io/hostname"}}') 
nodeSelector='"nodeSelector": { "kubernetes.io/hostname": "'${nodeName:?}'" },'
podName=${USER}-nsenter-${node}

kubectl run ${podName:?} --restart=Never -it --rm --image overriden --overrides '
{
  "spec": {
    "hostPID": true,
    "hostNetwork": true,
    '"${nodeSelector?}"'
    "tolerations": [{
        "operator": "Exists"
    }],
    "containers": [
      {
        "name": "nsenter",
        "image": "naviat/hnsenter:2.35",
        "command": [
          "/nsenter", "--all", "--target=1", "--", "su", "-"
        ],
        "stdin": true,
        "tty": true,
        "securityContext": {
          "privileged": true
        },
        "resources": {
          "requests": {
            "cpu": "10m"
          }
        }
      }
    ]
  }
}' --attach "$@"
