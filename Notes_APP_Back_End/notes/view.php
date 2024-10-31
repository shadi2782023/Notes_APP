<?php
include "../connect.php";

$notes_users      =  filterRequest ("notes_users");

$stmt = $con->prepare("SELECT * FROM notes WHERE `notes_users` = ?");
$stmt->execute(array($notes_users));
$count = $stmt->rowCount();  
$data =$stmt->fetchAll(PDO::FETCH_ASSOC);
if ($count > 0) {
    echo json_encode(array("status" => "Success", "data"=> $data));
} else {
    echo json_encode(array("status" => "Fail"));
}
