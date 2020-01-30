# nsenter

## Info

`naviat/hnsenter` Docker image is a `scratch` image that contains only one statically linked `nsenter` file.

## Usage

Read the official `nsenter` [documentation](http://man7.org/linux/man-pages/man1/nsenter.1.html).

## How do I *use* `naviat/hnsenter`?

Enter the container:

```sh
# enter all namespaces of selected container
docker run -it --rm --privileged --pid=container:<container_name_or_ID> naviat/hnsenter --all --target 1 -- su -
```

Enter the Docker host:

```sh
# enter all namespaces of Docker host
docker run -it --rm --privileged --pid=host naviat/hnsenter --all --target 1 -- su -
```

## Enter Kubernetes node

Use helper script `nsenter-node.sh` to enter into any Kubernetes node by creating a new pod tolerated to the specified node.

```sh
# list Kubernetes nodes
kubectl get nodes

NAME                                            STATUS   ROLES    AGE     VERSION
ip-192-168-151-104.us-west-2.compute.internal   Ready    <none>   6d17h   v1.13.7-eks-c57ff8
ip-192-168-171-140.us-west-2.compute.internal   Ready    <none>   5d10h   v1.13.7-eks-c57ff8

# enter into selected node with default shell as superuser
./nsenter-node.sh ip-192-168-151-104.us-west-2.compute.internal

[root@ip-192-168-171-140 ~]#
```
