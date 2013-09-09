(:~
 : Copyright 2013 Dirk Kirsten
 :)

module namespace _ = 'http://basex.org/restxq/skeleton';

(:~
 : Main entry page.
 :)
declare
  %restxq:GET
  %restxq:path("/")
  %output:method("xhtml")
  %output:html-version("5.0")
  function _:template()
{
  <html lang="en">
    <head>
      <title>BaseX RestXQ Skeleton project</title>
      <script src="/static/scripts/angular.js" />
      <script src="/static/scripts/angular-route.js" />
      <script src="/static/scripts/controllers/controllers.js" />
      <script src="/static/scripts/app.js" />
      <link href="/static/styles/bootstrap.css" rel="stylesheet" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    </head>
    <body class="container" ng-app="exampleApp">
      <div class="row">
        <div class="col-xs-12">
          <div class="jumbotron">
            <img src="/static/img/basex.svg" width="130" style="float: left; margin-right: 50px;" />
            <h1>BaseX RestXQ Skeleton</h1>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-xs-3">
          <ul class="nav nav-pills nav-stacked">
            <li><a href="#/Welcome">Welcome</a></li>
            <li><a href="#/System">System Parameters</a></li>
            <li><a href="#/Form">Simple Form</a></li>
          </ul>
        </div>
        <div class="col-xs-9">
          <div ng-view="" />
        </div>
      </div>
    </body>
  </html>
};

declare
  %restxq:GET
  %restxq:path("/views/welcome")
  %output:method("xhtml")
  %output:html-version("5.0")
  function _:welcome()
{
  <div>
    <h1>Welcome</h1>
    <p>
      This is a BaseX skeleton web project. It uses:
      <ul>
        <li><a href="http://basex.org">BaseX 7.7</a></li>
        <li><a href="http://angularjs.org/">AngularJS 1.2.0 RC2</a></li>
        <li><a href="http://getbootstrap.com/">Bootstrap 3.0.0</a></li>
        <li><a href="http://maven.apache.org/">Maven 3</a></li>
      </ul>
      
      We use <a href="http://docs.basex.org/wiki/RESTXQ">RestXQ</a> for server-side XQuery execution.
    </p>
  </div>
};

declare
  %restxq:GET
  %restxq:path("/views/form")
  %output:method("xhtml")
  %output:html-version("5.0")
  function _:form()
{
  <div ng-controller="FormCtrl">
    <form name="form" role="form" ng-submit="save()">
      <div class="form-group">
        <label for="name">Your name</label>
        <input type="text" class="form-control" id="name" placeholder="Your name" ng-model="user.name" />
      </div>
      <div class="form-group">
        <label for="age">Your age</label>
        <input type="number" class="form-control" id="age" ng-model="user.age" />
      </div>
      <button type="submit" class="btn btn-primary">Save</button>
      <div class="label label-success" ng-show="form.$pristine &amp;&amp; saved">
        <span class="glyphicon glyphicon-ok" /> Saved
      </div>
    </form>
    <p />
    <div class="jumbotron">
      <p>
        Your name: {{{{user.name}}}}
      </p>
      <p>
        Your age: {{{{user.age}}}}
      </p>
    </div>
  </div>
};

declare
  %restxq:GET
  %restxq:path("/views/system")
  %output:method("xhtml")
  %output:html-version("5.0")
  function _:system()
{
  for $topic in db:system()/*
  return (
    <h1>{local-name($topic)}</h1>,
    <table class="table table-striped">
      <thead>
        <th>#</th>
        <th>Key</th>
        <th>Value</th>
      </thead>
      {
      for $e at $pos in $topic/*
      return
        <tr>
          <td>{$pos}</td>
          <td>{local-name($e)}</td>
          <td>{tokenize($e/string(), ",") ! <p>{.}</p>}</td>
        </tr>
      }
    </table>
  )
};
