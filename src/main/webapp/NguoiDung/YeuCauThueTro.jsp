<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	href="${pageContext.request.contextPath}/assets/css/YeuCauThueTro.css">
	<style>
	.navbar-brand {
	font-weight: 800;
	color: #1E90FF !important;
	font-size: 1.8rem;
	display: flex;
	align-items: center;
	gap: 10px;
}
	</style>
</head>
<body>
<div class="container">

    <nav class="navbar">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/ProcessHomeUser"> <i
			class="fa-solid fa-house-chimney"></i> FindRoom
		</a>
        <a href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=" class="btn-back">
            <i class="fa-solid fa-arrow-left"></i> Quay lại
        </a>
    </nav>

    <header class="page-header">
        <h1>Gửi yêu cầu thuê</h1>
        <p>Hoàn tất thông tin bên dưới để gửi yêu cầu đến chủ nhà.</p>
    </header>

    <div class="layout-grid">
        
        <main>
            <div class="card-left">
                <div class="card-header">
                    <div class="card-title">Thông tin người thuê</div>
                    <div class="card-desc">Vui lòng điền chính xác để chủ nhà có thể liên hệ với bạn.</div>
                </div>

                <form id="rentalForm">
                    <div class="form-grid">
                        <div class="form-group col-span-2">
                            <label>Họ và tên</label>
                            <div class="input-box">
                                <i class="fa-regular fa-user"></i>
                                <input type="text" class="form-control" placeholder="Ví dụ: Nguyễn Văn A" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <div class="input-box">
                                <i class="fa-regular fa-envelope"></i>
                                <input type="email" class="form-control" placeholder="email@example.com">
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <div class="input-box">
                                <i class="fa-solid fa-phone"></i>
                                <input type="tel" class="form-control" placeholder="09xx xxx xxx" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Ngày dọn vào dự kiến</label>
                            <div class="input-box">
                                <i class="fa-regular fa-calendar"></i>
                                <input type="date" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Thời hạn thuê</label>
                            <div class="input-box">
                                <i class="fa-regular fa-clock"></i>
                                <select class="form-control" style="appearance: none;">
                                    <option value="6 tháng">6 tháng</option>
                                    <option value="12 tháng" selected>1 năm</option>
                                    <option value="lâu dài">Lâu dài (> 1 năm)</option>
                                </select>
                                <i class="fa-solid fa-chevron-down" style="left: auto; right: 14px;"></i>
                            </div>
                        </div>

                        <div class="form-group col-span-2">
                            <label>Lời nhắn cho chủ nhà</label>
                            <textarea class="form-control" placeholder="Ví dụ: Tôi là sinh viên năm cuối, muốn thuê ở lâu dài..."></textarea>
                        </div>

                        <div class="form-group col-span-2">
                            <label>Bạn muốn được liên hệ qua?</label>
                            <div class="contact-grid">
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="call" checked>
                                    <div class="contact-label">
                                        <i class="fa-solid fa-phone-volume"></i>
                                        <span>Gọi điện</span>
                                    </div>
                                </label>
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="zalo">
                                    <div class="contact-label">
                                        <i class="fa-brands fa-facebook-messenger"></i>
                                        <span>Zalo / Mess</span>
                                    </div>
                                </label>
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="sms">
                                    <div class="contact-label">
                                        <i class="fa-regular fa-comment-dots"></i>
                                        <span>Tin nhắn</span>
                                    </div>
                                </label>
                                <label class="contact-item">
                                    <input type="radio" name="contact" value="email">
                                    <div class="contact-label">
                                        <i class="fa-regular fa-envelope"></i>
                                        <span>Email</span>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-footer">
                        <a href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=" type="button" class="btn btn-ghost">Hủy bỏ</a>
                        <button type="submit" class="btn btn-primary">
                            <span>Gửi yêu cầu</span>
                            <i class="fa-regular fa-paper-plane"></i>
                        </button>
                    </div>
                </form>
            </div>
        </main>

        <aside class="sticky-sidebar">
            <div class="card room-preview">
                <div class="room-img-wrapper">
                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80" alt="Phòng trọ">
                    <div class="status-badge">Còn trống</div>
                </div>

                <div class="room-content">
                    <h3 class="room-title">Phòng Studio Full Nội Thất - Ban Công Thoáng</h3>
                    <div class="room-address">
                        <i class="fa-solid fa-location-dot" style="margin-top:2px;"></i>
                        <span>Số 15, Ngõ 102 Đường Láng, Đống Đa, Hà Nội</span>
                    </div>

                    <div class="room-price">
                        4.500.000đ <span>/tháng</span>
                    </div>

                    <div class="divider"></div>

                    <div class="owner-mini">
                        <div class="owner-avt">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <div class="owner-details">
                            <div>Nguyễn Văn Chủ</div>
                            <div>Chủ nhà • Phản hồi 100%</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 16px; font-size: 13px; color: #6b7280;">
                <i class="fa-solid fa-shield-halved"></i> Thông tin của bạn được bảo mật.
            </div>
        </aside>

    </div>
</div>
<div id="toast">
    <i class="fa-solid fa-circle-check"></i>
    <span>Yêu cầu đã được gửi thành công!</span>
</div>

<script>
    document.getElementById('rentalForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Button Loading Effect
        const btn = this.querySelector('button[type="submit"]');
        const originalContent = btn.innerHTML;
        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang gửi...';
        btn.disabled = true;

        // Fake API Call
        setTimeout(() => {
            btn.innerHTML = originalContent;
            btn.disabled = false;
            
            // Show Toast
            const toast = document.getElementById('toast');
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 3000);
        }, 1500);
    });
</script>

</body>
</html>