package com.tap.utility;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * EmailService sends order confirmation emails via the Resend API.
 * Falls back to console logging if the API key is not configured.
 */
public class EmailService {

    private static final String RESEND_API_URL = "https://api.resend.com/emails";
    private static final String FROM_EMAIL = "noreply@foodie.app";

    /**
     * Sends an email using the Resend API.
     * Falls back to logging if API key is not set or request fails.
     */
    public static void sendEmail(String to, String subject, String htmlBody) {
        String apiKey = System.getenv("RESEND_API_KEY");

        if (apiKey == null || apiKey.isEmpty() || apiKey.equals("YOUR_API_KEY")) {
            // Fallback: log the email to console
            System.out.println("==========================================");
            System.out.println("📧 EMAIL NOTIFICATION (API key not set)");
            System.out.println("To: " + to);
            System.out.println("Subject: " + subject);
            System.out.println("Body: " + htmlBody.replaceAll("<[^>]*>", "").trim());
            System.out.println("==========================================");
            return;
        }

        try {
            URL url = new URL(RESEND_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + apiKey);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String jsonPayload = String.format(
                "{\"from\":\"%s\",\"to\":\"%s\",\"subject\":\"%s\",\"html\":\"%s\"}",
                FROM_EMAIL,
                escapeJson(to),
                escapeJson(subject),
                escapeJson(htmlBody)
            );

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonPayload.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode >= 200 && responseCode < 300) {
                System.out.println("✅ Confirmation email sent to " + to);
            } else {
                System.err.println("⚠️ Failed to send email. Response code: " + responseCode);
            }

        } catch (Exception e) {
            System.err.println("⚠️ Email sending failed (will retry on next order): " + e.getMessage());
        }
    }

    /**
     * Builds a beautiful HTML order confirmation email.
     */
    public static String buildOrderConfirmationEmail(
            String customerName, int orderId, double totalAmount,
            String paymentMode, String address, String itemsHtml) {

        return "<!DOCTYPE html>"
            + "<html><head><meta charset='UTF-8'>"
            + "<style>"
            + "body{font-family:'Segoe UI',Arial,sans-serif;background:#f4f6fa;margin:0;padding:0;}"
            + ".container{max-width:600px;margin:30px auto;background:white;border-radius:16px;overflow:hidden;box-shadow:0 8px 30px rgba(0,0,0,.08);}"
            + ".header{background:linear-gradient(135deg,#27ae60,#2ecc71);padding:30px;text-align:center;color:white;}"
            + ".header h1{margin:0;font-size:26px;}"
            + ".header p{margin:8px 0 0;opacity:.9;font-size:15px;}"
            + ".order-badge{display:inline-block;margin-top:12px;padding:8px 20px;background:rgba(255,255,255,.2);border-radius:20px;font-size:16px;font-weight:bold;}"
            + ".body{padding:30px;}"
            + ".greeting{font-size:18px;color:#333;margin-bottom:20px;}"
            + ".section{margin-bottom:25px;}"
            + ".section h3{font-size:16px;color:#ff6b35;margin-bottom:10px;border-bottom:2px solid #f0f0f0;padding-bottom:8px;}"
            + "table{width:100%;border-collapse:collapse;}"
            + "th{text-align:left;padding:10px 0;color:#888;font-size:13px;text-transform:uppercase;border-bottom:2px solid #f0f0f0;}"
            + ".total-row{display:flex;justify-content:space-between;padding:8px 0;font-size:15px;}"
            + ".grand-total{display:flex;justify-content:space-between;padding:12px 0;border-top:2px solid #ff6b35;margin-top:8px;font-size:20px;font-weight:bold;color:#ff6b35;}"
            + ".footer{text-align:center;padding:20px;color:#999;font-size:13px;background:#fafafa;border-top:1px solid #eee;}"
            + ".btn{display:inline-block;padding:12px 30px;background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;text-decoration:none;border-radius:8px;font-weight:bold;margin-top:15px;}"
            + "</style></head><body>"
            + "<div class='container'>"
            + "<div class='header'>"
            + "<h1>🎉 Order Confirmed!</h1>"
            + "<p>Your delicious food is being prepared</p>"
            + "<div class='order-badge'>#ORD-" + String.format("%05d", orderId) + "</div>"
            + "</div>"
            + "<div class='body'>"
            + "<div class='greeting'>Hey <strong>" + escapeHtml(customerName) + "</strong>,</div>"
            + "<p style='color:#888;margin-bottom:20px;line-height:1.7;'>"
            + "Your order has been placed successfully! We're letting the restaurant know and your food will be on its way soon.</p>"
            + "<div class='section'>"
            + "<h3>🛒 Ordered Items</h3>"
            + "<table>"
            + "<tr><th>Item</th><th style='text-align:center;'>Qty</th><th style='text-align:right;'>Total</th></tr>"
            + itemsHtml
            + "</table>"
            + "</div>"
            + "<div class='section'>"
            + "<h3>📍 Delivery Details</h3>"
            + "<div class='total-row'><span style='color:#888;'>Address</span><span style='font-weight:600;text-align:right;max-width:55%;'>" + escapeHtml(address) + "</span></div>"
            + "<div class='total-row'><span style='color:#888;'>Payment</span><span style='font-weight:600;'>" + escapeHtml(paymentMode) + "</span></div>"
            + "</div>"
            + "<div class='grand-total'>"
            + "<span>Total Paid</span>"
            + "<span>₹ " + String.format("%.0f", totalAmount) + "</span>"
            + "</div>"
            + "<div style='text-align:center;'>"
            + "<a href='#' class='btn'>📦 Track Your Order</a>"
            + "</div>"
            + "</div>"
            + "<div class='footer'>"
            + "<p>Made with ❤️ by Foodie</p>"
            + "<p style='margin-top:6px;'>Need help? Contact our 24/7 support</p>"
            + "</div>"
            + "</div></body></html>";
    }

    private static String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private static String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
