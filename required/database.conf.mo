# when running in all-in-one mode, just get up and running for people with h2
evolutionplugin=disabled

db.collins.logStatements=false
db.collins.user="{{ COLLINS_DB_LOGIN }}"
db.collins.password="{{ COLLINS_DB_PASSWORD }}"
db.collins.driver="com.mysql.jdbc.Driver"
db.collins.url="jdbc:mysql://{{ COLLINS_DB_URL }}/collins?autoReconnect=true&interactiveClient=true"

querylog.frontendLogging = true
