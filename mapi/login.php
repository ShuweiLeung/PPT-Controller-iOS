<?php

require("../config.php");
$db = mysql_connect($dbhost, $dbuser, $dbpassword);
mysql_select_db($dbdatabase, $db);
mysql_query("set names 'utf8'");

$username = $_GET['username'];
$password = $_GET['password'];

$sql = "select * from user where username = '$username'";
$rs = mysql_query($sql);
$check_password = mysql_fetch_assoc($rs);
if($check_password['password'] == $password){
  $json->resultCode = 1;
  $json->message = '登录成功';
} else {
  $json->resultCode = 0;
  $json->message = '登录错误';
}
echo json_encode($json);
?>

