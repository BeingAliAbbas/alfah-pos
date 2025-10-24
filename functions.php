<?php

function is_logged_in() {
    return isset($_SESSION['user_id']);
}

function require_login() {
    if (!is_logged_in()) {
        header('Location: login.php');
        exit;
    }
}

function has_role($role) {
    return isset($_SESSION['role']) && $_SESSION['role'] === $role;
}

function require_role($role) {
    if (!has_role($role)) {
        die('Access denied');
    }
}

function sanitize($data) {
    return htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
}

function format_currency($amount) {
    return 'PKR ' . number_format($amount, 2);
}

function validate_input($data, $rules) {
    $errors = [];
    foreach ($rules as $field => $rule) {
        if (!isset($data[$field]) || empty($data[$field])) {
            if (isset($rule['required']) && $rule['required']) {
                $errors[] = ucfirst($field) . ' is required';
            }
        } else {
            if (isset($rule['type']) && $rule['type'] == 'email' && !filter_var($data[$field], FILTER_VALIDATE_EMAIL)) {
                $errors[] = 'Invalid ' . $field;
            }
            if (isset($rule['min_length']) && strlen($data[$field]) < $rule['min_length']) {
                $errors[] = ucfirst($field) . ' must be at least ' . $rule['min_length'] . ' characters';
            }
            if (isset($rule['max_length']) && strlen($data[$field]) > $rule['max_length']) {
                $errors[] = ucfirst($field) . ' must be at most ' . $rule['max_length'] . ' characters';
            }
        }
    }
    return $errors;
}

?>