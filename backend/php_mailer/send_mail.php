<?php
// PHPMailer fallback endpoint using local PHPMailer package
require_once __DIR__ . '/PHPMailer/src/PHPMailer.php';
require_once __DIR__ . '/PHPMailer/src/SMTP.php';
require_once __DIR__ . '/PHPMailer/src/Exception.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $to = $data['to'] ?? '';
    $subject = $data['subject'] ?? '';
    $html = $data['html'] ?? '';
    try {
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host = 'smtp.example.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'youruser';
        $mail->Password = 'yourpass';
        $mail->SMTPSecure = 'tls';
        $mail->Port = 587;
        $mail->setFrom(
            'no-reply@toletkoi.com',
            'ToletKoi'
        );
        $mail->addAddress($to);
        $mail->Subject = $subject;
        $mail->msgHTML($html);
        $mail->send();
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
    exit;
}
echo json_encode(['error' => 'Invalid request']);
