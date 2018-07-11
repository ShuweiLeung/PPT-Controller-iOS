<?php

require("../config.php");

$db = mysql_connect($dbhost, $dbuser, $dbpassword);
mysql_select_db($dbdatabase, $db);
mysql_query("set names 'utf8'");

$name = $_GET['name'];
$sql = "select `filename`, `filepath` from data where name = '$name'";
$result = mysql_query($sql);

$resultArray = array();
$i = 0;
while ($row = mysql_fetch_array($result)) {
	$resultArray[$i]['filename'] = $row['filename'];
	$resultArray[$i]['filepath'] = $row['filepath'];
	$i++;
}
echo json_encode($resultArray);
?>

