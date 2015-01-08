var _debug = true;
var _initLog = false;
var _debugFile = "C:/Users/admin/Desktop/debug.txt";

if (_initLog) stringToFile("", _debugFile);

function getLineChartName() {
	try {
		logMessage("INFO: " + "fff");
		return "COOL";
	} catch (err) {
		logMessage("ERROR: " + err.message);
		return "SORRY";
	}
}

function getLineChart(strPDF) {
	try {
		var u = "http://localhost/xpad3/PDFs/"+strPDF;
		var x = Packages.com.diy.FilefromHTTP.URLCopy();
		var b = x.getLocalFile(u, "C:/Temp");
		b = "file:///"+b;
		logMessage("INFO: " + b);
		return b;
	} catch (err) {
		logMessage("ERROR: " + err.message);
		return "";
	}
}

function logMessage(message) {
	if (_debug) {
		var m = "********************************************************************************\r\n";
		m += new Date();
		m += ": ";
		m += message;
		m += "\r\n";
		stringToFileAppend(m, _debugFile);
	}
}

function stringToFile(s, f) {
	var fos = new java.io.FileOutputStream(new java.io.File(f));
	var sx = new java.lang.String(s);
	fos.write(sx.getBytes());
	fos.flush();
	fos.close();
}

function stringToFileAppend(s, f) {
	var fos = new java.io.FileOutputStream(new java.io.File(f), true);
	var sx = new java.lang.String(s);
	fos.write(sx.getBytes());
	fos.flush();
	fos.close();
}