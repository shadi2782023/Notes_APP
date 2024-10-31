<?php
define ('MB', 1048576);



function checkAuthenticate(){
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

        if ($_SERVER['PHP_AUTH_USER'] != "shadi" ||  $_SERVER['PHP_AUTH_PW'] != "shadiraghad"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
}


function filterRequest($requestname)
{
    return  htmlspecialchars(strip_tags($_POST[$requestname]));
}



function fileUpload($imageRequest)
{

    global $msgError;
    $notesFileName = rand(1000,10000).$_FILES[$imageRequest]['name'];
    $notesFileTmp = $_FILES[$imageRequest]['tmp_name'];
    $notesFileSize = $_FILES[$imageRequest]['size'];    

    $allowExt = array("jpg", "png", "gif", "pdf", "mp3", "txt");
    $strToArray = explode(".", $notesFileName);
    $ext = end($strToArray);
    $ext = strtolower($ext);

    if (!empty($imageName) && !in_array($ext, $allowExt)) {
        $msgError[] = "EXT";
    }
    if($notesFileSize > 2 * MB){
        $msgError[] = "SIZE";
    }
    if(empty($msgError)){
        move_uploaded_file($notesFileTmp, "../upload/".$notesFileName);
        return $notesFileName;
    }
    else{
        return "Fail";
    }
}

function deleteFile($dir, $notesFileName){
    if(file_exists($dir."/".$notesFileName)){
        unlink($dir."/".$notesFileName);
    }
}


