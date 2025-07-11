<?php
error_log("manual error log test");
trigger_error("Test error!", E_USER_ERROR);
echo "Hello, FPM!"; // 브라우저에서 보이도록

