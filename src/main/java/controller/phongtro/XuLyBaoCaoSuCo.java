package controller.phongtro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.bean.BaoHong;
import model.bean.TaiKhoan;
import model.bo.BaoHongBO;
import utils.ImagesHelper;

import java.awt.Image;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Servlet implementation class XuLyBaoCaoSuCo
 */
@WebServlet("/XuLyBaoCaoSuCo")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize = 10 * 1024 * 1024,
	    maxRequestSize = 50 * 1024 * 1024
	)
public class XuLyBaoCaoSuCo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyBaoCaoSuCo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		TaiKhoan user = (TaiKhoan) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
        String tieuDe = request.getParameter("tieuDe");
        String phongId = request.getParameter("phongId");
        String loaiHuHong = request.getParameter("loaiHuHong");
        String mucDo = request.getParameter("mucDoUuTien");
        String moTa = request.getParameter("moTa");
        ArrayList<String> anhBaoHong = ImagesHelper.saveMultipleBaoHongImages(request.getParts(), getServletContext());
        
        if (tieuDe == null || tieuDe.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng nhập tiêu đề sự cố\"}");
            return;
        }

        if (phongId == null || phongId.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng chọn phòng xảy ra sự cố\"}");
            return;
        }

        if (loaiHuHong == null || loaiHuHong.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng chọn loại hư hỏng\"}");
            return;
        }

        if (mucDo == null || mucDo.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng chọn mức độ ưu tiên\"}");
            return;
        }

        if (moTa == null || moTa.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng nhập mô tả chi tiết\"}");
            return;
        }
		
        if (anhBaoHong == null || anhBaoHong.isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng tải lên ít nhất 1 ảnh minh chứng\"}");
            return;
        }

        if (anhBaoHong.size() > 5) {
            out.print("{\"status\":\"error\",\"message\":\"Chỉ được tải lên tối đa 5 ảnh\"}");
            return;
        }

        for (Part part : request.getParts()) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                if (part.getSize() > 10 * 1024 * 1024) {
                    out.print("{\"status\":\"error\",\"message\":\"Mỗi ảnh không được vượt quá 10MB\"}");
                    return;
                }
                String contentType = part.getContentType();
                if (!"image/png".equals(contentType)
                        && !"image/jpeg".equals(contentType)) {
                    out.print("{\"status\":\"error\",\"message\":\"Chỉ cho phép ảnh PNG hoặc JPG\"}");
                    return;
                }
            }
        }
        int ID_Phong = Integer.parseInt(phongId);
        BaoHongBO bhBO = new BaoHongBO();
        BaoHong bh = new BaoHong();
        bh.setID_Phong(ID_Phong);
        bh.setID_NguoiGui(user.getId());
        bh.setTieuDe(tieuDe);
        bh.setLoaiHuHong(loaiHuHong);
        bh.setMucDoUuTien(mucDo);
        bh.setMoTa(moTa);
        int ID_BaoHong = bhBO.insertBaoHong(bh);
        if(ID_BaoHong > 0) {
        	bhBO.insertAnhBaoHong(ID_BaoHong, anhBaoHong);
        	 out.print("{\"status\":\"success\"}");
        	    return;
        }else {
        	out.print("{\"status\":\"error\",\"message\":\"Không thể gửi báo cáo sự cố, vui lòng thử lại\"}");
            return;
        }
	}

}
