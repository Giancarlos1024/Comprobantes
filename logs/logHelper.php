<?php
// logHelper.php
function logMessage($message) {
    $logFile = __DIR__ . '/logs/app.log';
    $timeStamp = date("Y-m-d H:i:s");
    file_put_contents($logFile, "[$timeStamp] $message" . PHP_EOL, FILE_APPEND);
}
