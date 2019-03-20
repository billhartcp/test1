Test - PROD Branch
===================

A proof-of-concept to show how Docker containers can be versioned, built and deployed using a simple Apache2 image.

The process involves applying changes to a file or files in a Github repository. When committed and pushed, this
triggers a build process in Travis, which takes the build steps from the .travis.yml file, also in the repo. The
.travis.yml can contain 'conditional' build steps - in other words, instructions that will only be executed if the
changes are pushed to a particular branch in the repo.

So, for instance, if the branch pushed to is 'dev', then a test step is included. If the branche is 'prod', then a
deployment to the Kubernetes cluster is made.

In the example given, the first phase - the container build - is performed regardless of which branch is altered. This
step builds the container using the directives in the Dockerfile, logs onto Dockerhub and pushes the completed container
to the private artifact repo, giving it a 'tag' or version number. This version number is taken from the 'version.txt'
file in the Github repo, though in practice this would probably be from the pom.xml file used in compiling the binary
component.

In the deployment phase, Travis parses the version number into the apachetest-deployment.yml file, then runs the 
kubectl command to download the container from Dockerhub onto the K8s cluster and run it. The apachetest-service.yml
file defines the service ports (eg: 80,443) that the container uses to display the contents of the web page.

In this example, I've used the 'NodePort' option to expose the ports for the web server running in the container,
which sets a port (eg: 31080/TCP) on each slave node in the Kubernetes cluster that points back to port 80/TCP on the
internal Docker service for Apache. In a real-world scenario, a load balancer would then be set up in AWS to point
back to port 31080, with the normal port 80 set externally.
