# Coverage collector

This repository contains a service which collects JavaScript code coverage 
metrics from different test runs and combines them into one coverage collection 
which can be used for coverage report generation or SonarQube upload.

## Installation and use

The coverage collector requires Node.js and npm. It works with Node.js LTS 16 
and with npm 7+. Run `npm install` in this directory in order to install the 
dependencies. Then you can run `node ./lib/index.js` to start the coverage 
collector server.

Another option is to build a Docker image. Assuming Docker is installed, 
`docker build -t gros-coverage-collector .` can be run to build the image. 
Next, you can use the image in a Docker Compose network with the other test 
instances and runners, as explained in the `visualization-site` repository, or 
run it solely using `docker run --rm -d -p 8888:8888 gros-coverage-collector`.

See the [nyc-middleware](https://www.npmjs.com/package/nyc-middleware) package 
for further usage of the endpoints.
