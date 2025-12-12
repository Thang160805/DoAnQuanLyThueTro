<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.ThongBao"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="utils.TimeHelper"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Font Google: Poppins & Inter -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Toastify CSS (Thông báo đẹp) -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChiTietThongBao.css">
</head>
<body>
<%
	// Ngăn cache để không thể back sau khi logout
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	if (session.getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	%>
<div class="container">
        
        <!-- 1. HEADER NAV -->
        <nav class="nav-header">
            <a href="${pageContext.request.contextPath}/TatCaThongBao" class="back-link">
                <i class="fa-solid fa-chevron-left"></i>
                Quay lại
            </a>
            
        </nav>

        <!-- 2. MAIN DETAIL CARD -->
        <main class="detail-card">
        <% ThongBao tb = (ThongBao) request.getAttribute("ChiTietTB"); 
        String icon = "";
		String iconClass = "";
		if (tb.getType().equals("important")) {
			icon = "fa-triangle-exclamation";
			iconClass = "icon-danger";
		} else if (tb.getRole() == 0) {
			icon = "fa-user-check";
			iconClass = "icon-admin";
		} else if (tb.getRole() == 1) {
			icon = "fa-comment-dots";
			iconClass = "icon-owner";
		} else if (tb.getRole() == 3 || tb.getSender_id() == -1) {
			icon = "fa-receipt";
			iconClass = "icon-system";
		}
        %>
            
            <!-- Thông tin người gửi -->
            <div class="meta-row">
                <!-- Thay đổi class icon ở đây: icon-admin, icon-system, icon-danger, icon-owner -->
                <div class="sender-icon <%=iconClass%>">
                    <i class="fa-solid <%=icon%>"></i>
                </div>
                <div class="sender-info">
                    <span class="sender-name">Thông báo mới</span>
                    <span class="time-sent"><%= TimeHelper.timeAgo(tb.getCreate_at()) %> • Gửi tới Bạn</span>
                </div>
            </div>

            <!-- Tiêu đề -->
            <h1 class="notif-title"><%= tb.getTitle() %></h1>

            <!-- Nội dung chi tiết -->
            <div class="notif-body">
                <%= tb.getFull_content() %>
            </div>
        </main>

        <!-- 3. REPLY SECTION -->
        <section class="reply-card">
            <h3 class="reply-header">Phản hồi đến bộ phận hỗ trợ</h3>
            <textarea id="replyText" class="reply-input" placeholder="Nhập nội dung phản hồi của bạn..."></textarea>
            <div style="text-align: right;">
                <button class="btn-send" onclick="sendReply()">
                    <i class="fa-regular fa-paper-plane"></i>
                    Gửi phản hồi
                </button>
            </div>
        </section>

    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
        <i class="fa-solid fa-circle-check"></i>
        <span>Đã gửi phản hồi thành công!</span>
    </div>

   
        
</body>
</html>