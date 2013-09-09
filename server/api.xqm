(:~
 : Copyright 2013 Dirk Kirsten
 :)

module namespace _ = 'http://basex.org/restxq/skeleton';

import module namespace session = 'http://basex.org/modules/session';

declare
  %restxq:GET
  %restxq:path("/api/name")
  %output:method("json")
  function _:get-name()
{
  <json objects="json">
   {
     try {
       let $user := db:open("user", "user.xml")/user
       return (
         $user/name,
         <age type="number">{$user/age/string()}</age>
       )
     } catch * { () }
   }
  </json>
};

declare
  %updating
  %restxq:POST("{$user}")
  %restxq:path("/api/name")
  %output:method("json")
  function _:save-name($user)
{
  (
    db:create("user", <user>{$user/json/*}</user>, "user.xml"),
    db:output(
    <json objects="json">
      <success />
    </json>)
  )
};
