var _debug = true;
var _initLog = false;
var _debugFile = "C:/Users/admin/Desktop/debug.txt";

if (_initLog) stringToFile("", _debugFile);

var LineChartValues;

function initLineChartValues() {
	logMessage("INFO: init");
	LineChartValues = [];
}

function addValueToLineChartValues(value) {
	logMessage("INFO: add");
	LineChartValues.push(value);
}

function displayLineChartValues() {
	logMessage("INFO: display");
	logMessage("INFO: " + LineChartValues.join(','));
}

function createLineChartValuesAndGetName(v1, v2, v3, v4, v5, v6, v7) {
	var ValuesArray = [];
	if (!v1.equals("null")) { ValuesArray.push(v1) }
	if (!v2.equals("null")) { ValuesArray.push(v2) }
	if (!v3.equals("null")) { ValuesArray.push(v3) }
	if (!v4.equals("null")) { ValuesArray.push(v4) }
	if (!v5.equals("null")) { ValuesArray.push(v5) }
	if (!v6.equals("null")) { ValuesArray.push(v6) }
	if (!v7.equals("null")) { ValuesArray.push(v7) }
	//logMessage("INFO - clcn: " + ValuesArray);
	var OutputFile = getLineChartFileName(ValuesArray)
	return OutputFile;
}

function getLineChartFileName(ValuesArray) {
	try {
		var ChartHelper = Packages.com.diy.charthelper.LineChartHelper();
		//var Values = ["10", "20", "15", "30", "50"];
		var Values = ("" + ValuesArray).split(",");
		var ImageLocation  = ChartHelper.generateWeeklyReviewLineChart(Values, "2015-01-08");
		ChartHelper = null;
		//logMessage("INFO - glcn: " + ImageLocation);
		//logMessage("INFO - glcn: " + ValuesArray);
		//logMessage("INFO - glcn: " + arguments.length);
		return ImageLocation;
	} catch (err) {
		logMessage("ERROR - glcn: " + err.message);
		return "KO";
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