#/bin/bash
#Written by Paul Swanson
#Systems Administrator FNSBSD
#Based off of the information here https://github.com/soberhofer/Firefox-RootCA
#2018-07-10

#FIRST FILE
CFG="/Applications/Firefox.app/Contents/Resources/mozilla.cfg"

#If it exists, back it up
if [ -f $CFG ]; then
   #File exists
   /bin/mv "/Applications/Firefox.app/Contents/Resources/mozilla.cfg" "/Applications/Firefox.app/Contents/Resources/mozilla.cfg.bak"
fi

#Populate the file
/bin/cat <<EOM >$CFG
//This file must start with a comment
var Cc = Components.classes;
var Ci = Components.interfaces;
var certdb = Cc["@mozilla.org/security/x509certdb;1"].getService(Ci.nsIX509CertDB);
cert1 = "MIIDdzCCAl+gAwIBAgIJAOu3HNNoWOxSMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRYwFAYDVQQKDA1TZWN1cmx5LCBJbmMuMRYwFAYDVQQDDA0qLnNlY3VybHkuY29tMB4XDTE1MDEyNjIzMjkzOVoXDTIwMDEzMDIzMjkzOVowUjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFjAUBgNVBAoMDVNlY3VybHksIEluYy4xFjAUBgNVBAMMDSouc2VjdXJseS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC1NJCxT8I0Muf3bDGeBXo2X0t7z4ZziKJmJUpOaeR48b+343bKvlg20o097GJopSnvi9rZZopzWVo3oVIkgs96m4DpQE+ShyAXNbnjQuuYb4vjGFJ130pZn9O3wlT2WLJhqn3ojYv49eKzXG3IuqYyAxyHgURoGB8hEjgxWkGA8k5/BpxmE1RTXQCl5X+hBIB/kQNzMzoKM2jI5nwhU8kj5o/D4X1a1RmfNl08u0JsMw+dFG9BzletiXdk8QaNnRg4KoSDb1Pl2RRxEAxzm/pY72rzRWh/AVjd5qbP3Rs7VDX1MQYVGol5ThEVH6cQH+xwJyZar3c4SqnCxSV/oAuvAgMBAAGjUDBOMB0GA1UdDgQWBBQW39BDC8Drcbo7+nmhvKMr8uPUdTAfBgNVHSMEGDAWgBQW39BDC8Drcbo7+nmhvKMr8uPUdTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQCZ1xAuCLrObR08XLr0fXbvazp+IZidemjb82z/eWeqdxmN5hCUAScMhszPlc8ySB66A5Uf8EoWCbuebmpf9LX5b4d88Ka6Xs2Ki6LO6SWkt6nNVwRJ7oFHJRKvLw+GDbR37YVxRkvKPZxeklc0X6dVmgUSGXrIVy2WSd5oIySKygH6K/Th8RvMWitOgXrIc5Lw8yYHgQvx8V2kU0axU/AjY28kRpi5iKfF251HpJuSrTD431GRQc1VnYid++ge80JJX+fQuw+DUi9s4DIbNiPczP6leh+DYpc0gcoHmaO8SXHU/jFGOonUU7nUehYOAILUkHN87zHrZ5N99QWi3sRi"; // This should be the certificate content with no line breaks at all.
certdb.addCertFromBase64(cert1, "C,C,C", "");
EOM

#Fix permissions
/usr/sbin/chown root:admin "/Applications/Firefox.app/Contents/Resources/mozilla.cfg"
/bin/chmod 777 "/Applications/Firefox.app/Contents/Resources/mozilla.cfg"

#SECOND FILE
JS="/Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js"

#If it exists, back it up
if [ -f $JS ]; then
   #File exists
   /bin/mv "/Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js" "/Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js.bak"
fi

#Populate the file
/bin/cat <<EOM >$JS
pref("general.config.filename", "mozilla.cfg");
pref("general.config.obscure_value", 0); // use this to disable the byte-shift
EOM

#Fix permissions
/usr/sbin/chown root:admin "/Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js"
/bin/chmod 777 "/Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js"
