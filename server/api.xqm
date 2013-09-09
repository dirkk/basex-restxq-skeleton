module namespace _ = 'http://basex.org/restxq/skeleton';

import module namespace session = "http://basex.org/modules/session";

declare
  %restxq:GET
  %restxq:path("/api/users")
  %output:method("json")
  function _:get-users()
{
  <json objects="json user" arrays="users" numbers="age">
    <users>
    {
      for $user in db:open("user", "user.xml")/users/user
      return
        copy $c := $user
        modify delete node $c/password
        return $c
    }
    </users>
  </json>
};

declare
  %restxq:GET
  %restxq:path("/api/user/{$id}")
  %output:method("json")
  function _:get-user($id as xs:string)
{
  <json objects="json" numbers="age">
   { 
     copy $c := db:open("user", "user.xml")/users/user[id = $id]
     modify delete node $c/password
     return $c
   }
  </json>
};

declare
  %updating
  %restxq:POST("{$user}")
  %restxq:path("/api/user")
  %output:method("json")
  function _:add-user($user)
{
  let $id := random:uuid()
  let $new :=
    <user>
      <id>{$id}</id>
      <password>{crypto:hmac($user/json/password, 'secretkey', 'sha1', 'base64')}</password>
      {$user/json/name}
      {$user/json/age}
    </user>
  return (
    insert node $new into db:open("user", "user.xml")/users,
    db:output(<json objects="json" numbers="age">{($new/id, $new/name, $new/age)}</json>)
  )
};

declare
  %updating
  %restxq:PUT("{$user}")
  %restxq:path("/api/user/{$id}")
  %output:method("json")
  function _:save-user($user, $id as xs:string)
{
  (
    replace node db:open("user", "user.xml")/users/user[id = $id] with <user>{$user/json/*}</user>,
    db:output(_:get-user($id))
  )
};

declare
  %updating
  %restxq:DELETE
  %restxq:path("/api/user/{$id}")
  function _:delete-user($id as xs:string)
{
  delete node db:open("user", "user.xml")/users/user[id = $id]
};

declare
  %restxq:GET
  %restxq:path("/api/login/{$name}/{$password}")
  %output:method("json")
  function _:log-in-user(
    $name as xs:string,
    $password as xs:string
  )
{
  <json objects="json" booleans="result">
  {
    let $hash := crypto:hmac($password, 'secretkey', 'sha1', 'base64')
    return
      if (count(db:open("user", "user.xml")/users/user[name = $name and password = $hash]) = 1)
      then (
        session:set("user", $name),
        <result>true</result>,
        <time>{session:created()}</time>
      )
      else <result>false</result>
  }
  </json>
};

declare
  %restxq:GET
  %restxq:path("/api/is-loggedin")
  %output:method("json")
  function _:logged-in()
{
  <json objects="json" booleans="result">
  {
    if (session:get("user"))
    then (
      <result>true</result>,
      <time>{session:created()}</time>
    )
    else <result>false</result>
  }
  </json>
};

declare
  %restxq:GET
  %restxq:path("/api/logout")
  %output:method("json")
  function _:logout()
{
  (
    session:close(),
    <json objects="json" booleans="result">
      <result>true</result>
    </json>
  )
};
