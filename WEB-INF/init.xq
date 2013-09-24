if (not(db:exists("user")))
then db:create("user", <users />, "user.xml")
else ()
