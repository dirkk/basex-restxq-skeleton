module namespace _ = 'http://basex.org/app/skeleton';

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
            <li><a href="#/User">User Section</a></li>
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
    <form name="form" role="form" ng-submit="add()">
      <div class="form-group">
        <label for="name">Name</label>
        <input type="text" class="form-control" id="name" placeholder="Name" ng-model="user.name" />
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" placeholder="Password" ng-model="user.password" />
      </div>
      <div class="form-group">
        <label for="age">Age</label>
        <input type="number" class="form-control" id="age" placeholder="Age" ng-model="user.age" />
      </div>
      <button type="submit" class="btn btn-primary">
        <span class="glyphicon glyphicon-plus" /> Add
      </button>
    </form>
    <p />
    <div class="jumbotron" ng-repeat="user in users | orderBy:'age'">
      <p>
        Name: {{{{user.name}}}}
      </p>
      <p>
        Age: {{{{user.age}}}}
      </p>
      <button ng-click="delete()" class="btn btn-primary">
        <span class="glyphicon glyphicon-remove" /> Delete
      </button>
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

declare
  %restxq:GET
  %restxq:path("/views/user")
  %output:method("xhtml")
  %output:html-version("5.0")
  function _:user()
{
  <div ng-controller="UserCtrl">
    <form ng-show="!loggedIn" name="form" role="form" ng-submit="login()">
      <div class="jumbotron">
        <b>Hint:</b> Use the user login data you can add and delete at "Simple Form"
      </div>
      <div class="form-group">
        <label for="name">Name</label>
        <input type="text" class="form-control" id="name" placeholder="Name" ng-model="user.name" />
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" placeholder="Password" ng-model="user.password" />
      </div>
      <button type="submit" class="btn btn-primary">
        Login
      </button>
    </form>
    <div ng-show="loggedIn">
      <h1><span class="glyphicon glyphicon-ok" /> Logged In</h1>
      <p>Log-In time: {{{{time | date:'medium'}}}}</p>
      <button class="btn btn-default" ng-click="logout()">
        Logout
      </button>
    </div>
  </div>
};
