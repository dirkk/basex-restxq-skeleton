This is a skeleton project for a BaseX powered RestXQ project with client-side AngularJS.

## Prerequisites

* Java 6
* BaseX 7.7

## Deploy using standalone version

To use the standalone version and a encapsulated Jetty container, please run the `basexskeleton` script.

    bin/basexskeleton


## Deploy using Maven

If you want to deploy using Maven, you will at least need Maven 3. The you can simply run

    mvn jetty:run

## Test it

Access the application with your web browser at

    http://localhost:8984
