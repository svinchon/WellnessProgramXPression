
Custom Code to generate Charts
- For xDW
	- Copy JARS from JAVA\jfc_lib to C:\Program Files (x86)\Common Files\xPresso\4.5SP1\xPRS\lib
	- Adjust ChartHelper.properties in JAVA\WellnessProgramJAVALibrary1.jar as needed
	- Copy JAVA\WellnessProgramJAVALibrary1.jar to to C:\Program Files (x86)\Common Files\xPresso\4.5SP1\xPRS\lib
	- Adjust xPresso.jar from C:\Program Files (x86)\Common Files\xPresso\4.5SP1\xPRS\lib to reference above JARs
- For Server
	- C:\xStuff\4.5SP1B13\jboss-as-7.1.1.Final\standalone\deployments\xPression.ear\lib

Custom Code to post-process HTML to embed images
- For Server
	- Copy content of
		C:\Users\admin\git\WellnessProgramEclipseProjects\xCustomize\bin\com\diy
		to
		C:\xStuff\4.5SP1B13\jboss-as-7.1.1.Final\standalone\deployments\xPression.ear\UniArch_Admin.war\WEB-INF\classes\com\diy
	- Copy JARs from
		C:\xStuff\4.5SP1B13\jboss-as-7.1.1.Final\standalone\deployments\xDocxa.war\WEB-INF\lib
		to
		C:\xStuff\4.5SP1B13\jboss-as-7.1.1.Final\standalone\deployments\xPression.ear\UniArch_Admin.war\WEB-INF\lib
