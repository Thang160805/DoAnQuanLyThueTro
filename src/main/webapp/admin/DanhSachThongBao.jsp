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
<title>Tất cả thông báo</title>
<!-- Font Google: Poppins & Inter -->
<!-- Google Fonts: Poppins (Hiện đại, tròn trịa giống Airbnb) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/TatCaThongBao.css">
<style>
body {
    font-family: "Open Sans", sans-serif;
    background-color: #f9fafb;    
    color: #111827;               
    line-height: 1.5;
    -webkit-font-smoothing: antialiased;
}
a {
	text-decoration: none;
	color: inherit;
	transition: 0.2s;
}
.notif-empty{
display: flex;
align-items: center;
gap:10px;
}
.pagination-wrapper {
    margin-top: 30px;
    margin-bottom: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
}

.pagination-list {
    display: flex;
    align-items: center;
    gap: 6px;
    list-style: none;
    padding: 0;
}

/* Từng ô số */
.pagi-item {
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 40px;
    height: 40px;
    padding: 0 10px;
    border-radius: 10px;
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    color: #475569;
    font-weight: 500;
    font-family: 'Inter', sans-serif;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Hiệu ứng Hover */
.pagi-item:hover {
    border-color: #6366f1;
    color: #6366f1;
    background-color: #f5f3ff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
}

/* Trang hiện tại */
.pagi-item.active {
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: #ffffff;
    border: none;
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.35);
}

/* Dấu ba chấm */
.pagi-dots {
    color: #94a3b8;
    padding: 0 5px;
}

/* Chữ hiển thị thông tin */
.pagi-info {
    font-size: 0.85rem;
    color: #64748b;
    font-weight: 400;
}

/* Nút Icon */
.pagi-item i {
    font-size: 0.8rem;
}
</style>
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
		<%
		ArrayList<ThongBao> list = (ArrayList<ThongBao>) request.getAttribute("listThongBao");
		%>

		<!-- HEADER SECTION -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/AdminQT" class="page-title">Thông báo</a>
			<button class="btn-mark-read" onclick="markAllRead()"
				title="Đánh dấu tất cả là đã đọc">
				<i class="fa-solid fa-check-double"></i> <span>Đánh dấu tất
					cả đã đọc</span>
			</button>
		</header>

		<div class="notif-list" id="notifList">
			<%
			if (list == null || list.isEmpty()) {
			%>
			<div class="notif-empty">
				<div class="notif-empty-icon">
					<i class="fa-regular fa-bell"></i>
				</div>
				<h4>Chưa có thông báo nào</h4>
			</div>
			<%
			} else {
			for (ThongBao tb : list) {
			%>
			<%
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
			<a
				href="${pageContext.request.contextPath}/ChiTietThongBaoAdmin?id=<%= tb.getId() %>"
				class="notif-card <%= tb.getIs_read() == 1 ? "is-read" : "" %>">

				<div class="notif-icon <%=iconClass%>">
					<i class="fa-solid <%=icon%>"></i>
				</div>

				<div class="notif-content">
					<div class="notif-title"><%=tb.getTitle()%></div>
					<div class="notif-meta"><%=TimeHelper.timeAgo(tb.getCreate_at())%></div>
				</div> <%
                         if (tb.getIs_read() == 0) {
                        %>
				<div class="unread-dot"></div> 
				<% } %>
			</a>
			<%
			}%>
			<%
			Integer totalPage = (Integer) request.getAttribute("totalPage");
			Integer currentPage = (Integer) request.getAttribute("currentPage");

			if (totalPage != null && totalPage > 1) {
			%>
			<nav class="pagination-wrapper">
				<ul class="pagination-list">
					<%
					if (currentPage > 1) {
					%>
					<li><a href="?page=<%=currentPage - 1%>"
						class="pagi-item prev" title="Trang trước"> <i
							class="fa-solid fa-chevron-left"></i>
					</a></li>
					<%
					}
					%>

					<%
					
					int start = Math.max(1, currentPage - 2);
					int end = Math.min(totalPage, currentPage + 2);

					if (start > 1) {
					%>
					<li><a href="?page=1" class="pagi-item">1</a></li>
					<%
					if (start > 2) {
					%><li class="pagi-dots">...</li>
					<%
					}
					%>
					<%
					}
					%>

					<%
					for (int i = start; i <= end; i++) {
					%>
					<li><a href="?page=<%=i%>"
						class="pagi-item <%=(i == currentPage) ? "active" : ""%>"> <%=i%>
					</a></li>
					<%
					}
					%>

					<%
					if (end < totalPage) {
					%>
					<%
					if (end < totalPage - 1) {
					%><li class="pagi-dots">...</li>
					<%
					}
					%>
					<li><a href="?page=<%=totalPage%>" class="pagi-item"><%=totalPage%></a></li>
					<%
					}
					%>

					<%
					if (currentPage < totalPage) {
					%>
					<li><a href="?page=<%=currentPage + 1%>"
						class="pagi-item next" title="Trang tiếp"> <i
							class="fa-solid fa-chevron-right"></i>
					</a></li>
					<%
					}
					%>
				</ul>
				
			</nav>
			<%
			}
			%>
			<%}
			%>
		</div>

	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<%
	TaiKhoan tk = (TaiKhoan) session.getAttribute("user");
	int id = tk.getId();
	%>
	<script>
	
	const USER_ID = <%=id%>
	function markAllRead() {
	    const unreadCards = document.querySelectorAll('.notif-card:not(.is-read)');
	    const btn = document.querySelector('.btn-mark-read');
	    const btnText = btn.querySelector('span');
	    const btnIcon = btn.querySelector('i');

	    if (unreadCards.length === 0) return;
	    btnIcon.classList.remove('fa-check-double');
	    btnIcon.classList.add('fa-spinner', 'fa-spin');
	    $.ajax({
	        url: "/DoAnQLThueTro/UpdateTrangThaiTB",
	        type: "post",
	        data: {
	            action: "DocTatCa",
	            receiverId: USER_ID
	        },
	        success: function (response) {
	            setTimeout(() => {
	                unreadCards.forEach(card => {
	                    card.classList.add('is-read');
	                });

	                btnIcon.classList.remove('fa-spinner', 'fa-spin');
	                btnIcon.classList.add('fa-check');
	                btnText.textContent = "Đã xong!";
	                btn.style.color = "#10b981"; 
	                btn.style.borderColor = "#10b981";
	                btn.style.background = "#ecfdf5";

	                setTimeout(() => {
	                    btnIcon.classList.remove('fa-check');
	                    btnIcon.classList.add('fa-check-double');
	                    btnText.textContent = "Đánh dấu tất cả đã đọc";
	                    btn.removeAttribute('style');
	                }, 2000);

	            }, 300);
	        },
	        error: function (xhr) {
	            alert("Lỗi: không thể cập nhật trạng thái đọc!");
	            console.log(xhr.responseText);
	        }
	    });
	}
</script>
</body>
</html>