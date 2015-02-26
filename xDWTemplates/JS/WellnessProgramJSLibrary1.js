var _debug = true;
var _initLog = false;
var _debugFile = "C:/Users/admin/Desktop/debug.txt";
_debugFile = "C:/Users/admin/Desktop/Folders/Files/debug.txt";

if (_initLog) stringToFile("", _debugFile);

function getWeeklyReportGaugeChartFromValues(label, percentage, color) {
	logMessage("INFO - getWeeklyReportGaugeChartFromValues: " + label + ", " + percentage + ", " + color);
	try {
		var ChartHelper = Packages.com.diy.charthelper.GaugeChartHelper();
		var ImageLocation  = ChartHelper.generateWeeklyReviewGaugeChart(
			label,
			""+percentage,
			color
		);
		ChartHelper = null;
		logMessage("INFO - getWeeklyReportGaugeChartFromValues: " + ImageLocation);
		return ImageLocation;
	} catch (err) {
		logMessage("ERROR - getWeeklyReportGaugeChartFromValues: " + err.message);
	}
}

function getMonthlyReportLineChartFromXML(xml) {
	logMessage("INFO - getMonthlyReportLineChartFromXML: " + xml);
	try {
		var ChartHelper = Packages.com.diy.charthelper.XML2ChartHelper();
		var ImageLocation  = ChartHelper.generateTSChartFromXML(xml);
		ChartHelper = null;
		logMessage("INFO - getMonthlyReportLineChartFromXML: " + ImageLocation);
		return ImageLocation;
	} catch (err) {
		logMessage("ERROR - getMonthlyReportLineChartFromXML: " + err.message);
	}
}

function createBarChartValuesAndGetName(v11, v12, v21, v22) {
	if (v11.equals("null")) { v11 = 0; }
	if (v12.equals("null")) { v21 = 0; }
	if (v21.equals("null")) { v21 = 0; }
	if (v22.equals("null")) { v22 = 0; }
	try {
		var ChartHelper = Packages.com.diy.charthelper.BarChartHelper();
		var ImageLocation  = ChartHelper.generateWeeklyReviewBarChart(v11, v12, v21, v22);
		ChartHelper = null;
		logMessage("INFO - cbc: " + ImageLocation);
		return ImageLocation;
	} catch (err) {
		logMessage("ERROR - cbc: " + err.message);
	}
}

function getWeeklyReportLineChartFromXML(xml) {
	logMessage("INFO - getWeeklyReportLineChartFromXML: " + xml);
	try {
		var ChartHelper = Packages.com.diy.charthelper.XML2ChartHelper();
		var ImageLocation  = ChartHelper.generateTSChartFromXML(xml);
		ChartHelper = null;
		logMessage("INFO - getWeeklyReportLineChartFromXML: " + ImageLocation);
		return ImageLocation;
	} catch (err) {
		logMessage("ERROR - getWeeklyReportLineChartFromXML: " + err.message);
	}
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
		return ImageLocation;
	} catch (err) {
		logMessage("ERROR - glcn: " + err.message);
		return "KO";
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