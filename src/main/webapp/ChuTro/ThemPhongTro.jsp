<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.KhuVuc"%>
<%@ page import="model.bean.TienIch"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm phòng</title>
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
	href="${pageContext.request.contextPath}/assets/css/ThemPhongTro.css">
<style>
* {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Open Sans", sans-serif;
        }
.upload-area {
	border: 2px dashed #cbd5e1;
	padding: 20px;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
	background: #f8fafc;
}

.upload-area:hover {
	background: #f1f5f9;
}

.file-input {
	display: none;
}

.sub-image-grid img {
	width: 100%;
	height: 80px;
	object-fit: cover;
	border-radius: 8px;
}

.more-box {
	background: #f1f5f9;
	border-radius: 8px;
	height: 80px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #64748b;
	font-size: 12px;
	border: 1px dashed #cbd5e1;
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

		<h1 class="form-header">Thêm Phòng Trọ Mới</h1>

		<form id="insertRoom">
			<div class="form-grid">

				<div class="col-left">

					<div class="card">
						<h2 class="section-title">
							<i class="fa-solid fa-house" style="margin-right: 8px;"></i>Thông
							Tin Cơ Bản
						</h2>

						<div class="form-group">
							<label for="tenPhong">Tên phòng</label> <input type="text"
								id="tenPhong" name="tenPhong" class="input-style"
								placeholder="Ví dụ: Phòng Studio, Căn Hộ Mini...">
						</div>

						<div class="form-group">
							<label for="diaChi">Địa chỉ chi tiết</label>
							<textarea id="diaChi" name="diaChi"
								placeholder="Nhập số nhà, tên đường, phường/xã..."></textarea>
						</div>

						<div class="input-row">
							<div class="form-group">
								<label for="giaThue">Giá thuê (VNĐ)</label>
								<div class="input-with-unit">
									<input type="number" id="giaThue" name="giaThue"
										class="input-style" placeholder="Chỉ nhập số"> <span
										class="input-unit">VNĐ</span>
								</div>
							</div>

							<div class="form-group">
								<label for="dienTich">Diện tích (m²)</label>
								<div class="input-with-unit">
									<input type="number" id="dienTich" name="dienTich"
										class="input-style" placeholder="Chỉ nhập số"> <span
										class="input-unit">m²</span>
								</div>
							</div>


						</div>

						<div class="input-row"
							style="grid-template-columns: repeat(2, 1fr);">
							<div class="form-group">
								<label for="giaDien">Giá điện (VNĐ/kWh)</label>
								<div class="input-with-unit">
									<input type="number" id="giaDien" name="giaDien"
										class="input-style" placeholder="Giá điện"> <span
										class="input-unit">đ/kWh</span>
								</div>
							</div>

							<div class="form-group">
								<label for="giaNuoc">Giá nước (VNĐ/m³)</label>
								<div class="input-with-unit">
									<input type="number" id="giaNuoc" name="giaNuoc"
										class="input-style" placeholder="Giá nước"> <span
										class="input-unit">đ/m³</span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="moTa">Mô tả chi tiết</label>
							<textarea id="moTa" name="moTa"
								placeholder="Cung cấp thông tin chi tiết về phòng, môi trường xung quanh, an ninh...">Phòng mới xây, đầy đủ nội thất cơ bản. Khu vực yên tĩnh, an ninh tốt, gần chợ và trường đại học.</textarea>
						</div>
					</div>

					<div class="card">
						<h2 class="section-title">
							<i class="fa-solid fa-map-location-dot"
								style="margin-right: 8px;"></i>Khu Vực & Tiện Ích
						</h2>

						<div class="form-group">
							<label for="khuVuc">Chọn Khu vực</label> <select id="khuVuc"
								name="khuVuc" class="input-style">
								<%
								ArrayList<KhuVuc> list = (ArrayList<KhuVuc>) request.getAttribute("listKV");
								for (KhuVuc kv : list) {
								%>
								<option value="<%=kv.getId()%>"><%=kv.getTenKhuVuc()%></option>
								<%
								}
								%>
							</select>
						</div>

						<label>Chọn tiện ích có sẵn (Chọn nhiều)</label>
						<div class="amenity-grid">
							<%
							ArrayList<TienIch> listTI = (ArrayList<TienIch>) request.getAttribute("listTI");
							for (TienIch ti : listTI) {
							%>
							<label class="checkbox-container"> <input type="checkbox"
								name="tienIch" value="<%=ti.getId()%>"> <span
								class="custom-checkbox"><i class="fa-solid fa-check"></i></span>
								<span class="amenity-label"><%=ti.getTenTienIch()%></span>
							</label>
							<%
							}
							%>
						</div>
					</div>
				</div>

				<div class="col-right">
					<div class="card">
						<h2 class="section-title">
							<i class="fa-solid fa-camera" style="margin-right: 8px;"></i>Quản
							lý Hình Ảnh
						</h2>

						<!-- ẢNH CHÍNH -->
						<div class="form-group">
							<label>Ảnh Chính (Bắt buộc 1 ảnh)</label> <label for="anhChinh"
								class="upload-area">
								<div class="upload-icon">
									<i class="fa-solid fa-upload"></i>
								</div>
								<div class="upload-text">Kéo thả hoặc nhấn để chọn ảnh
									chính</div> <input type="file" id="anhChinh" name="anhChinh"
								class="file-input" accept="image/*">
							</label>
						</div>

						<div class="image-preview-wrapper">
							<label>Ảnh Chính (Preview)</label> <img
								src=""
								alt="Ảnh Chính Preview" class="main-image-preview"
								style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;">
						</div>

						<hr>

						<!-- ẢNH PHỤ -->
						<div class="form-group">
							<label>Ảnh Phụ (Tối đa 5 ảnh)</label> <label for="anhPhu"
								class="upload-area">
								<div class="upload-icon">
									<i class="fa-solid fa-image"></i>
								</div>
								<div class="upload-text">Chọn nhiều ảnh phụ</div> <input
								type="file" id="anhPhu" name="anhPhu" class="file-input"
								accept="image/*" multiple>
							</label>
						</div>

						<div class="image-preview-wrapper">
							<label>Ảnh Phụ (Preview)</label>

							<!-- JS sẽ tự thêm ảnh vào đây -->
							<div class="sub-image-grid"
								style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-top: 10px;">
							</div>
						</div>

					</div>
				</div>
			</div>

			<div class="action-buttons">
				<a href="${pageContext.request.contextPath}/QuanLyTro"
					class="btn btn-cancel">Hủy bỏ</a>
				<button type="submit" class="btn btn-success">
					<i class="fa-solid fa-plus"></i> Thêm phòng
				</button>
			</div>

		</form>

	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		function showToast(message, type = "success") {
		    const toast = $("#toast");

		    let iconHTML = "";

		    if (type === "error") {
		        toast.css("background-color", "#dc2626"); // đỏ
		        iconHTML = `<i class="fa-solid fa-circle-xmark" style="color:#fecaca; margin-right:8px;"></i>`;
		    } else {
		        toast.css("background-color", "#2563eb"); // xanh
		        iconHTML = `<i class="fa-solid fa-circle-check" style="color:#4ade80; margin-right:8px;"></i>`;
		    }

		    toast.html(iconHTML + message);

		    toast.css({ opacity: "1", transform: "translateY(0)" });

		    setTimeout(() => {
		        toast.css({ opacity: "0", transform: "translateY(20px)" });
		    }, 5000);
		}
		
		$(document).ready(function () {


		    $("#anhPhu").on("change", function () {
		        let files = this.files;

		        if (files.length > 5) {
		            showToast("Chỉ được chọn tối đa 5 ảnh phụ!", "error");
		            this.value = ""; 
		            return;
		        }
		    });
		})

		    $("#insertRoom").on("submit", function (e) {
    e.preventDefault();

    let formData = new FormData(this);

    $("input[name='tienIch']:checked").each(function () {
        formData.append("tienIchList[]", $(this).val());
    });

    let anhPhuFiles = $("#anhPhu")[0].files;
    for (let i = 0; i < anhPhuFiles.length; i++) {
        formData.append("anhPhuList[]", anhPhuFiles[i]);
    }

    $.ajax({
        url: "/DoAnQLThueTro/XuLyThemPhongTro",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        dataType: "json",

        success: function (res) {
            if (res.success) {
                showToast(res.message || "Thêm phòng thành công!", "success");

                setTimeout(() => {
                    window.location.href = "/DoAnQLThueTro/QuanLyTro";
                }, 3000);

            } else {
                showToast(res.message || "Không thể thêm phòng!", "error");
            }
        },

        error: function (xhr) {
            let msg = "Lỗi kết nối server!";
            if (xhr.responseText) {
                try {
                    let json = JSON.parse(xhr.responseText);
                    if (json.message) msg = json.message;
                } catch (e) {}
            }
            showToast(msg, "error");
        }
    });
});

		
		$("#anhChinh").on("change", function () {
		    let file = this.files[0];
		    if (file) {
		        let reader = new FileReader();
		        reader.onload = function (e) {
		            $(".main-image-preview").attr("src", e.target.result);
		        };
		        reader.readAsDataURL(file);
		    }
		});
		
		document.getElementById("anhPhu").addEventListener("change", function () {
    let files = this.files;

    if (files.length > 5) {
        showToast("Chỉ chọn tối đa 5 ảnh!", "error");
        this.value = "";
        return;
    }

    let preview = document.querySelector(".sub-image-grid");
    preview.innerHTML = ""; 

    [...files].forEach((file, index) => {
        if (index < 3) {
            let img = document.createElement("img");
            img.src = URL.createObjectURL(file);
            img.style.width = "100%";
            img.style.height = "80px";
            img.style.objectFit = "cover";
            img.style.borderRadius = "8px";
            preview.appendChild(img);
        }
    });

    if (files.length > 3) {
        let more = document.createElement("div");
        more.classList.add("more-box");
        more.innerText = `+${files.length - 3} more`;
        preview.appendChild(more);
    }
});



		</script>

</body>
</html>