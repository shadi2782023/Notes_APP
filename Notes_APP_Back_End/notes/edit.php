<?php
include "../connect.php";

$notes_id       =   filterRequest("notes_id");
$notes_title    =   filterRequest("notes_title");
$notes_content  =   filterRequest("notes_content");
$notes_image  =   filterRequest("notes_image");

if (isset($_FILES['file'])) {
    deleteFile("../upload", $notes_image);
    $notes_image    =   fileUpload("file");
}

$stmt = $con->prepare("UPDATE `notes` SET `notes_title`= ?,`notes_content`= ?, notes_image = ? WHERE `notes_id` = ?");
$stmt->execute(array($notes_title, $notes_content, $notes_image, $notes_id));
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "Success"));
} else {
    echo json_encode(array("status" => "Fail"));
}
