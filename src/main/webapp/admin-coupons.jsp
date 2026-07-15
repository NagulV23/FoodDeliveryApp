<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Coupon"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin - Coupon Management | Foodie</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f4f6fa;min-height:100vh;}

/* Navbar */
.navbar{height:76px;padding:0 60px;display:flex;justify-content:space-between;align-items:center;background:rgba(255,255,255,.92);backdrop-filter:blur(20px);box-shadow:0 8px 25px rgba(0,0,0,.06);position:sticky;top:0;z-index:999;}
.logo{font-size:28px;font-weight:800;color:#ff6b35;text-decoration:none;}
.nav-links{display:flex;gap:25px;align-items:center;}
.nav-links a{text-decoration:none;color:#555;font-size:15px;font-weight:500;transition:.3s;}
.nav-links a:hover{color:#ff6b35;}
.admin-badge{background:#ff6b35;color:white;padding:6px 16px;border-radius:30px;font-size:13px;font-weight:600;}

/* Layout */
.container{max-width:1200px;margin:30px auto;padding:0 20px 60px;}

/* Header */
.header{display:flex;justify-content:space-between;align-items:center;margin-bottom:30px;flex-wrap:wrap;gap:15px;}
.header h1{font-size:30px;font-weight:700;color:#222;}
.header p{color:#888;font-size:15px;margin-top:4px;}
.add-btn{background:linear-gradient(135deg,#27ae60,#2ecc71);color:white;border:none;padding:14px 28px;border-radius:14px;font-size:15px;font-weight:600;cursor:pointer;transition:.3s;display:flex;align-items:center;gap:8px;text-decoration:none;}
.add-btn:hover{transform:translateY(-2px);box-shadow:0 10px 25px rgba(39,174,96,.35);}

/* Messages */
.message{padding:14px 20px;border-radius:12px;margin-bottom:20px;font-size:14px;font-weight:500;display:flex;align-items:center;gap:10px;animation:slideDown .4s ease;}
@keyframes slideDown{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}
.message.success{background:#e8fff0;color:#27ae60;border:1px solid #b2f0c0;}
.message.error{background:#fff0f0;color:#e74c3c;border:1px solid #ffd5d5;}

/* Table */
.table-wrapper{background:white;border-radius:20px;box-shadow:0 10px 30px rgba(0,0,0,.08);overflow:hidden;}
table{width:100%;border-collapse:collapse;}
thead{background:#f8f9fa;}
th{padding:16px 20px;text-align:left;font-size:13px;text-transform:uppercase;letter-spacing:.5px;color:#888;font-weight:600;border-bottom:2px solid #eee;}
td{padding:16px 20px;border-bottom:1px solid #f0f0f0;font-size:14px;color:#333;vertical-align:middle;}
tr:last-child td{border-bottom:none;}
tr:hover{background:#fafbfc;}
.coupon-code{font-weight:700;color:#ff6b35;font-size:15px;letter-spacing:.5px;}
.badge{display:inline-block;padding:4px 12px;border-radius:20px;font-size:12px;font-weight:600;}
.badge.active{background:#e8fff0;color:#27ae60;}
.badge.inactive{background:#f0f0f0;color:#999;}
.badge.percentage{background:#fff0e8;color:#ff6b35;}
.badge.flat{background:#e8f0ff;color:#3498db;}

/* Action buttons */
.action-btn{padding:6px 14px;border:none;border-radius:8px;font-size:13px;font-weight:600;cursor:pointer;transition:.3s;text-decoration:none;display:inline-block;margin:0 3px;}
.action-btn.edit{background:#fff0e8;color:#ff6b35;}
.action-btn.edit:hover{background:#ff6b35;color:white;}
.action-btn.toggle{background:#e8fff0;color:#27ae60;}
.action-btn.toggle:hover{background:#27ae60;color:white;}
.action-btn.delete{background:#fff0f0;color:#e74c3c;}
.action-btn.delete:hover{background:#e74c3c;color:white;}
.actions-cell{white-space:nowrap;}

/* Modal */
.modal-overlay{display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,.5);z-index:9999;justify-content:center;align-items:center;animation:fadeIn .3s ease;}
.modal-overlay.show{display:flex;}
@keyframes fadeIn{from{opacity:0;}to{opacity:1;}}
.modal{background:white;border-radius:24px;padding:35px;width:92%;max-width:580px;max-height:90vh;overflow-y:auto;animation:scaleIn .3s ease;box-shadow:0 30px 60px rgba(0,0,0,.25);}
@keyframes scaleIn{from{transform:scale(.9);opacity:0;}to{transform:scale(1);opacity:1;}}
.modal-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
.modal-header h2{font-size:24px;font-weight:700;color:#222;}
.close-btn{background:none;border:none;font-size:28px;cursor:pointer;color:#999;transition:.3s;padding:4px;line-height:1;}
.close-btn:hover{color:#e74c3c;}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;}
.form-group{display:flex;flex-direction:column;}
.form-group.full{grid-column:1/-1;}
.form-group label{font-size:13px;font-weight:600;color:#444;margin-bottom:6px;}
.form-group input,.form-group select,.form-group textarea{padding:12px 14px;border:2px solid #eee;border-radius:10px;font-size:14px;outline:none;transition:.3s;background:#fafafa;}
.form-group input:focus,.form-group select:focus,.form-group textarea:focus{border-color:#ff6b35;background:white;box-shadow:0 0 0 3px rgba(255,107,53,.1);}
.form-group textarea{resize:vertical;min-height:70px;}
.form-group .helper{font-size:12px;color:#999;margin-top:4px;}
.modal-actions{display:flex;gap:12px;margin-top:24px;justify-content:flex-end;}
.submit-btn{padding:14px 32px;background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;border:none;border-radius:12px;font-size:15px;font-weight:600;cursor:pointer;transition:.3s;}
.submit-btn:hover{transform:translateY(-2px);box-shadow:0 10px 25px rgba(255,107,53,.3);}
.cancel-btn{padding:14px 32px;background:white;color:#555;border:2px solid #ddd;border-radius:12px;font-size:15px;font-weight:600;cursor:pointer;transition:.3s;}
.cancel-btn:hover{border-color:#999;}

/* Responsive */
@media(max-width:768px){
.navbar{padding:16px 20px;height:auto;flex-direction:column;gap:12px;}
.nav-links{gap:14px;flex-wrap:wrap;justify-content:center;}
.form-grid{grid-template-columns:1fr;}
.form-group.full{grid-column:1;}
.header{flex-direction:column;align-items:flex-start;}
.table-wrapper{overflow-x:auto;}
th,td{padding:12px 14px;font-size:13px;}
}
</style>
</head>
<body>

<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

List<Coupon> couponList = (List<Coupon>) request.getAttribute("couponList");
Coupon editCoupon = (Coupon) request.getAttribute("editCoupon");
String adminMessage = (String) session.getAttribute("adminMessage");
String adminError = (String) session.getAttribute("adminError");

// Format dates for display
SimpleDateFormat dateFmt = new SimpleDateFormat("dd MMM yyyy");
SimpleDateFormat inputFmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
%>

<!-- Navbar -->
<div class="navbar">
<a href="<%=request.getContextPath()%>/home.jsp" class="logo">🍔 Foodie</a>
<div class="nav-links">
<a href="<%=request.getContextPath()%>/home.jsp">Home</a>
<a href="<%=request.getContextPath()%>/callRestaurantServlet">Restaurants</a>
<a href="<%=request.getContextPath()%>/admin/coupons">Coupons</a>
<span class="admin-badge">👑 Admin</span>
<span style="display:flex;align-items:center;gap:8px;font-size:14px;font-weight:600;color:#555;">👋 <%= loggedInUser.getName() %></span>
<a href="<%=request.getContextPath()%>/logout" style="text-decoration:none;color:#e74c3c;font-weight:600;font-size:14px;">Logout</a>
</div>
</div>

<div class="container">

    <!-- Header -->
    <div class="header">
        <div>
            <h1>🎫 Coupon Management</h1>
            <p>Create and manage promotional coupons for your customers</p>
        </div>
        <button class="add-btn" onclick="openAddModal()">+ Create Coupon</button>
    </div>

    <!-- Messages -->
    <% if (adminMessage != null) { %>
    <div class="message success">✅ <%= adminMessage %></div>
    <% session.removeAttribute("adminMessage"); %>
    <% } %>
    <% if (adminError != null) { %>
    <div class="message error">⚠️ <%= adminError %></div>
    <% session.removeAttribute("adminError"); %>
    <% } %>

    <!-- Coupons Table -->
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th>Value</th>
                    <th>Min Order</th>
                    <th>Usage</th>
                    <th>Valid Until</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                if (couponList != null && !couponList.isEmpty()) {
                    for (Coupon coupon : couponList) {
                        String typeClass = "PERCENTAGE".equalsIgnoreCase(coupon.getDiscountType()) ? "percentage" : "flat";
                        String typeLabel = "PERCENTAGE".equalsIgnoreCase(coupon.getDiscountType()) ? coupon.getDiscountValue() + "%" : "₹" + String.format("%.0f", coupon.getDiscountValue());
                        String statusClass = coupon.isActive() ? "active" : "inactive";
                        String statusLabel = coupon.isActive() ? "Active" : "Inactive";
                        String validUntil = coupon.getValidUntil() != null ? dateFmt.format(coupon.getValidUntil()) : "No expiry";
                %>
                <tr>
                    <td><span class="coupon-code"><%= coupon.getCode() %></span></td>
                    <td><%= coupon.getDescription() != null ? coupon.getDescription() : "-" %></td>
                    <td><span class="badge <%= typeClass %>"><%= coupon.getDiscountType() %></span></td>
                    <td><strong><%= typeLabel %></strong></td>
                    <td>₹<%= String.format("%.0f", coupon.getMinOrderAmount()) %></td>
                    <td><%= coupon.getUsedCount() %><% if (coupon.getUsageLimit() > 0) { %> / <%= coupon.getUsageLimit() %><% } %></td>
                    <td><%= validUntil %></td>
                    <td><span class="badge <%= statusClass %>"><%= statusLabel %></span></td>
                    <td class="actions-cell">
                        <a href="<%=request.getContextPath()%>/admin/coupons?action=edit&id=<%= coupon.getCouponId() %>" class="action-btn edit">✏️ Edit</a>
                        <a href="<%=request.getContextPath()%>/admin/coupons?action=toggle&id=<%= coupon.getCouponId() %>" class="action-btn toggle"><%= coupon.isActive() ? "⏸️" : "▶️" %></a>
                        <a href="<%=request.getContextPath()%>/admin/coupons?action=delete&id=<%= coupon.getCouponId() %>" class="action-btn delete" onclick="return confirm('Delete coupon <%= coupon.getCode() %>?')">🗑️</a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="9" style="text-align:center;padding:40px;color:#888;font-size:16px;">
                        🎫 No coupons created yet. <a href="#" onclick="openAddModal();return false;" style="color:#ff6b35;font-weight:600;">Create your first coupon</a>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>

</div>

<!-- ================= ADD/EDIT MODAL ================= -->
<div class="modal-overlay <%= editCoupon != null ? "show" : "" %>" id="couponModal">
    <div class="modal">
        <div class="modal-header">
            <h2><%= editCoupon != null ? "✏️ Edit Coupon" : "🎫 Create Coupon" %></h2>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>

        <form action="<%=request.getContextPath()%>/admin/coupons" method="post">
            <input type="hidden" name="action" value="<%= editCoupon != null ? "edit" : "add" %>">
            <% if (editCoupon != null) { %>
            <input type="hidden" name="couponId" value="<%= editCoupon.getCouponId() %>">
            <% } %>

            <div class="form-grid">
                <div class="form-group">
                    <label>Coupon Code *</label>
                    <input type="text" name="code" placeholder="e.g. SAVE50" value="<%= editCoupon != null ? editCoupon.getCode() : "" %>" required style="text-transform:uppercase;">
                </div>

                <div class="form-group">
                    <label>Discount Type *</label>
                    <select name="discountType" required>
                        <option value="FLAT" <%= editCoupon != null && "FLAT".equals(editCoupon.getDiscountType()) ? "selected" : "" %>>Flat (₹)</option>
                        <option value="PERCENTAGE" <%= editCoupon != null && "PERCENTAGE".equals(editCoupon.getDiscountType()) ? "selected" : "" %>>Percentage (%)</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Discount Value *</label>
                    <input type="number" name="discountValue" step="0.01" min="0" placeholder="e.g. 50" value="<%= editCoupon != null ? editCoupon.getDiscountValue() : "" %>" required>
                    <span class="helper">In ₹ or % depending on type</span>
                </div>

                <div class="form-group">
                    <label>Max Discount (₹)</label>
                    <input type="number" name="maxDiscount" step="0.01" min="0" placeholder="0 = no cap" value="<%= editCoupon != null && editCoupon.getMaxDiscount() > 0 ? editCoupon.getMaxDiscount() : "" %>">
                    <span class="helper">Cap for percentage discounts (0 = unlimited)</span>
                </div>

                <div class="form-group">
                    <label>Min Order Amount (₹)</label>
                    <input type="number" name="minOrderAmount" step="0.01" min="0" placeholder="0 = no minimum" value="<%= editCoupon != null && editCoupon.getMinOrderAmount() > 0 ? editCoupon.getMinOrderAmount() : "" %>">
                </div>

                <div class="form-group">
                    <label>Usage Limit</label>
                    <input type="number" name="usageLimit" min="0" placeholder="0 = unlimited" value="<%= editCoupon != null && editCoupon.getUsageLimit() > 0 ? editCoupon.getUsageLimit() : "" %>">
                </div>

                <div class="form-group">
                    <label>Valid From</label>
                    <input type="datetime-local" name="validFrom" value="<%= editCoupon != null && editCoupon.getValidFrom() != null ? inputFmt.format(editCoupon.getValidFrom()) : "" %>">
                </div>

                <div class="form-group">
                    <label>Valid Until</label>
                    <input type="datetime-local" name="validUntil" value="<%= editCoupon != null && editCoupon.getValidUntil() != null ? inputFmt.format(editCoupon.getValidUntil()) : "" %>">
                </div>

                <div class="form-group full">
                    <label>Description</label>
                    <textarea name="description" placeholder="Describe the offer..."><%= editCoupon != null && editCoupon.getDescription() != null ? editCoupon.getDescription() : "" %></textarea>
                </div>

                <div class="form-group full" style="flex-direction:row;align-items:center;gap:10px;">
                    <input type="checkbox" name="isActive" id="isActive" value="true" <%= editCoupon == null || editCoupon.isActive() ? "checked" : "" %> style="width:20px;height:20px;accent-color:#27ae60;">
                    <label for="isActive" style="margin-bottom:0;cursor:pointer;">Active — coupon can be used by customers</label>
                </div>
            </div>

            <div class="modal-actions">
                <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
                <button type="submit" class="submit-btn"><%= editCoupon != null ? "💾 Update Coupon" : "🎫 Create Coupon" %></button>
            </div>
        </form>
    </div>
</div>

<script>
function openAddModal() {
    var modal = document.getElementById('couponModal');
    modal.classList.add('show');
    // If there's an edit coupon, reload page without edit param
    <%
    if (editCoupon != null) {
    %>
    window.location.href = '<%=request.getContextPath()%>/admin/coupons';
    <%
    }
    %>
}

function closeModal() {
    document.getElementById('couponModal').classList.remove('show');
}

// Close modal on overlay click
document.getElementById('couponModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});

// Auto-open modal if edit coupon is present
<%
if (editCoupon != null) {
%>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('couponModal').classList.add('show');
});
<%
}
%>
</script>

</body>
</html>
