<?php
    $to = $_POST["to"];
    $subject = $_POST["subject"];
    $message = $_POST["message"];
    $from = "vovchara913@gmail.com";
    $headers = "From: $from";
    if (mail($to,$subject,$message,$headers)){
       echo "Successfully sent";
    }
    else{
       echo "sending error";
    }
?>