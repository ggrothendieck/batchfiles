function toggleDoc() {
  var bodies = document.getElementsByTagName("tbody");
	var ntoggled = 0;
  var lastsig = "";
  var showall = document.getElementById("togglecheckid").checked;
	var display;
	if (showall) display = "";
	else display = "none";
	for (ibody in bodies) {
		var body = bodies[ibody];
		if (typeof(body) !="object") continue;
		var rows = body.getElementsByTagName("tr");
		for (i in rows) {
			if (typeof(rows[i]) !="object") continue;
			an = String(rows[i].getElementsByTagName("a")[0].innerHTML);
			// matching signatures are collapsed
			sig1 = String(rows[i].getElementsByTagName("td")[1].innerHTML);
			sig0 = an.match('([^\.]*).*')[1];
			sig = sig0+sig1;
			if (sig == lastsig || an.search(",") != -1) {
				ntoggled = ntoggled + 1;
				rows[i].style.display = display;
			}
			lastsig = sig;
		}
	}
	// hide control element if not used
	if (!ntoggled) {
   document.getElementById("togglecheck").style.display = "none";
	}
}
