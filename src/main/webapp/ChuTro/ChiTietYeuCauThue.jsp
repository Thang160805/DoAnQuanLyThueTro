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
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChiTietYeuCauThue.css">
</head>
<body>
<div class="container">
        
        <div style="margin-bottom: 20px;">
            <a href="#" style="color: var(--text-secondary); text-decoration: none; font-size: 14px;">
                <i class="fa-solid fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>

        <div class="grid-layout">
            
            <div class="col-left">
                
                <div class="card">
                    <div class="room-img-wrapper">
                        <img src="https://i.imgur.com/7yUvePI.jpeg" alt="Ảnh phòng trọ" class="room-img">
                        <div style="position: absolute; top: 15px; left: 15px; background: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; color: var(--text-main);">
                            Cho thuê
                        </div>
                    </div>
                    
                    <h2 class="room-name">Phòng Trọ Cao Cấp – P102</h2>
                    <div class="room-address">
                        <i class="fa-solid fa-location-dot" style="color: var(--primary)"></i> 
                        Số 12, Ngõ 66 Nguyễn Thái Học, TP. Vinh
                    </div>

                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <span class="price-tag">3.500.000đ<span style="font-size: 14px; font-weight: 400; color: var(--text-secondary);">/tháng</span></span>
                    </div>

                    <div class="utilities">
                        <div class="util-item"><i class="fa-solid fa-bolt" style="color: #f59e0b;"></i> 3.500đ/kWh</div>
                        <div class="util-item"><i class="fa-solid fa-droplet" style="color: #0ea5e9;"></i> 20.000đ/m³</div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-title">Người yêu cầu thuê</div>
                    <div class="user-profile">
                        <img src="https://i.pravatar.cc/100?img=12" alt="Avatar" class="user-avatar">
                        <div class="user-info">
                            <h3 class="user-name">Phạm Hương</h3>
                            <div class="user-detail-row">
                                <i class="fa-solid fa-phone"></i> 0987 654 321
                            </div>
                            <div class="user-detail-row">
                                <i class="fa-solid fa-id-card"></i> 038201009999
                            </div>
                            <div class="user-detail-row">
                                <i class="fa-solid fa-venus"></i> Nữ
                            </div>
                            <div class="user-detail-row">
                                <i class="fa-solid fa-map-pin"></i> Nghi Phú, TP. Vinh
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-right">
                
                <div class="card">
                    <div class="card-title">
                        Thông tin yêu cầu
                        <span class="status-badge">Chờ duyệt</span>
                    </div>
                    
                    <ul class="info-list">
                        <li class="info-item">
                            <span class="label"><i class="fa-regular fa-calendar-check" style="margin-right: 8px;"></i>Ngày dọn vào</span>
                            <span class="value">13/12/2025</span>
                        </li>
                        <li class="info-item">
                            <span class="label"><i class="fa-solid fa-clock-rotate-left" style="margin-right: 8px;"></i>Thời hạn thuê</span>
                            <span class="value">1 năm</span>
                        </li>
                        <li class="info-item">
                            <span class="label"><i class="fa-solid fa-address-book" style="margin-right: 8px;"></i>Liên hệ qua</span>
                            <span class="value" style="color: var(--primary); font-weight: 600;">Điện thoại</span>
                        </li>
                    </ul>

                    <div style="margin-top: 20px;">
                        <span class="label" style="font-size: 14px;">Lời nhắn:</span>
                        <div class="message-box">
                            "Tôi là sinh viên năm cuối, muốn thuê ở lâu dài. Mong sớm nhận được phản hồi từ chủ trọ."
                        </div>
                    </div>
                </div>

                <div class="card" style="border: none; background: transparent; box-shadow: none; padding: 0;">
                    <div class="action-group">
                        <button class="btn btn-approve">
                            <i class="fa-solid fa-phone-volume"></i> Duyệt yêu cầu (Đã liên hệ)
                        </button>
                        
                        <button class="btn btn-reject">
                            <i class="fa-solid fa-xmark"></i> Hủy yêu cầu
                        </button>
                    </div>
                    <p style="text-align: center; color: var(--text-light); font-size: 12px; margin-top: 12px;">
                        Việc duyệt đồng nghĩa bạn đã liên hệ và xác nhận với người thuê.
                    </p>
                </div>

            </div>
        </div>
    </div>

</body>
</html>