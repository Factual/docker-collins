# when running in all-in-one mode, just get up and running for people with h2
evolutionplugin=enabled

db.collins.logStatements=false
db.collins.password=""
db.collins.driver=org.h2.Driver
db.collins.url="jdbc:h2:mem:play;IGNORECASE=TRUE;DB_CLOSE_DELAY=-1"
db.collins.user=sa

querylog.frontendLogging = true
# apply evolutions to H2 automatically
applyEvolutions.collins=true