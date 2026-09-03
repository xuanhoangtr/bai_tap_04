package vn.iotstar.util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Thong tin cau hinh SMTP Gmail
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    /*
     * Do not put a real Gmail password in source control.  Set these values
     * as environment variables (or JVM system properties) when real email
     * delivery is required:
     *   SMTP_EMAIL / SMTP_PASSWORD
     *
     * With no credentials configured the application stays in demo mode and
     * prints the OTP to the server console, which keeps local testing usable.
     */
    private static final String SENDER_EMAIL = getConfig("SMTP_EMAIL");
    private static final String SENDER_PASSWORD = getConfig("SMTP_PASSWORD");

    private static String getConfig(String key) {
        String value = System.getProperty(key);
        if (value == null || value.isBlank()) {
            value = System.getenv(key);
        }
        if (value == null) return "";
        value = value.trim();
        if ("SMTP_PASSWORD".equals(key)) {
            value = value.replace(" ", "");
        }
        return value;
    }

    public static boolean sendOtpEmail(String toEmail, String otp, String purpose) {
        String senderEmail = getConfig("SMTP_EMAIL");
        String senderPassword = getConfig("SMTP_PASSWORD");

        System.out.println("==================================================");
        System.out.println("[EMAIL SERVICE] Dang gui ma OTP den: " + toEmail);
        System.out.println("[EMAIL SERVICE] Muc dich: " + purpose);
        boolean demoMode = senderEmail.isBlank() || senderPassword.isBlank();
        if (demoMode) {
            System.out.println("[EMAIL SERVICE] DEMO OTP: >>> " + otp + " <<<");
        } else {
            System.out.println("[EMAIL SERVICE] DANG GUI THUC TE DEN GMAIL QUA TAI KHOAN: " + senderEmail);
        }
        System.out.println("==================================================");

        if (demoMode) {
            return true;
        }

        try {
            return sendViaPort(senderEmail, senderPassword, toEmail, otp, purpose, "465", true);
        } catch (Exception e1) {
            System.err.println("[EMAIL SERVICE] Port 465 loi (" + e1.getMessage() + "), thu lai voi Port 587...");
            try {
                Thread.sleep(1000);
                return sendViaPort(senderEmail, senderPassword, toEmail, otp, purpose, "587", false);
            } catch (Exception e2) {
                System.err.println("[EMAIL SERVICE] Khong the gui email that: " + e2.getMessage());
                e2.printStackTrace();
                return false;
            }
        }
    }

    private static boolean sendViaPort(String senderEmail, String senderPassword, String toEmail, String otp, String purpose, String port, boolean isSsl) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        if (isSsl) {
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.socketFactory.port", port);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        } else {
            props.put("mail.smtp.starttls.enable", "true");
        }
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail, "He Thong Web JSP/Servlet"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        message.setSubject("Ma xac thuc OTP - " + purpose, "UTF-8");

        String content = "<h3>Xin chao,</h3>"
                + "<p>Ban vua yeu cau ma xac thuc cho muc dich: <b>" + purpose + "</b>.</p>"
                + "<p>Ma OTP cua ban la: <h2 style='color: #007bff;'>" + otp + "</h2></p>"
                + "<p>Ma co hieu luc trong 5 phut. Vui long khong chia se ma nay cho ai.</p>";

        message.setContent(content, "text/html; charset=UTF-8");

        Transport.send(message);
        System.out.println("[EMAIL SERVICE] GUI EMAIL THAT THANH CONG QUA PORT " + port + "!");
        return true;
    }
}
