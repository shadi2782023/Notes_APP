<?php
include "../connect.php";

$notes_id    =   filterRequest("notes_id");
$notes_image  =   filterRequest("notes_image");


$stmt = $con->prepare("DELETE FROM `notes` WHERE `notes_id` = ?");
$stmt->execute(array($notes_id));
$count = $stmt->rowCount();
if ($count > 0) {
    deleteFile("../upload" , $notes_image);
    echo json_encode(array("status" => "Success"));
} else {
    echo json_encode(array("status" => "Fail"));
}
