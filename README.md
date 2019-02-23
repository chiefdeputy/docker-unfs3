# UNFS3 for Docker (in Kubernetes)

Intended to provide an NFS service for a PersistentVolumeClaim in Kubernetes.

### Usage

#### Kubernetes Pod and Service example
````
apiVersion: v1
kind: Pod
metadata:
  name: unfs3
  labels:
    app: unfs3
  spec:
    containers:
    - name: unfs3
      image: nimbix/unfs3
      imagePullPolicy: Always
      volumeMounts:
      - mountPath: /export
        name: export-vol
  restartPolicy: Always
  volumes:
    - name: export-vol
  persistentVolumeClaim:
    claimName: mypvc
---
apiVersion: v1
kind: Service
metadata:
  name: unfs3
spec:
  type: ClusterIP
  ports:
  - name: tcp111
    port: 111
    targetPort: 111
    protocol: TCP
  - name: udp111
    port: 111
    targetPort: 111
    protocol: UDP
  - name: tcp2049
    port: 2049
    targetPort: 2049
    protocol: TCP
  - name: udp2049
    port: 2049
    targetPort: 2049
    protocol: UDP
  selector:
    app: unfs3
````
Mount the `/export` path from the service's `ClusterIP` after creation.  Note that the `PersistentVolumeClaim` must exist and should be referred to in the pod spec as whatever you named it.

### Credits
* [mitcdh/docker-unfs3](https://github.com/mitcdh/docker-unfs3)
