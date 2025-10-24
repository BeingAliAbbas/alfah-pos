<?php

define('SITE_NAME', 'Alfah Tech International');
define('TAGLINE', 'Advanced Poultry Health Solutions');
define('LAHORE_CONTACT', '(042) 36-28-1111');
define('LAHORE_WHATSAPP', '0337-961-6356');
define('ISLAMABAD_CONTACT', '(051) 111-241-111');
define('ISLAMABAD_WHATSAPP', '0335-166-1111');
define('LAHORE_ADDRESS', '17-A Allama Iqbal Road, Cantt. Lahore');
define('ISLAMABAD_ADDRESS', 'House No. 43, Street No. 37 I-8/2 Markaz Islamabad');
define('DB_HOST', 'localhost');
define('DB_NAME', 'alfah_pos');
define('DB_USER', 'root');
define('DB_PASS', '');

session_start();

if (isset($_SESSION['user_id'])) {
    if (time() - $_SESSION['last_activity'] > 1800) { // 30 minutes
        session_unset();
        session_destroy();
        header('Location: login.php');
        exit;
    }
    $_SESSION['last_activity'] = time();
}

function generate_csrf_token() {
    if (!isset($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function validate_csrf_token($token) {
    return isset($_SESSION['csrf_token']) && hash_equals($_SESSION['csrf_token'], $token);
}

?>