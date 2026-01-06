package controller.chutro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.PhongTroBO;

import java.io.IOException;

/**
 * Servlet implementation class XoaPhongTro
 */
@WebServlet("/XoaPhongTro")
public class XoaPhongTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XoaPhongTro() {
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
		
		int idPhong = Integer.parseInt(request.getParameter("id"));
		String TrangThai = request.getParameter("status");
		PhongTroBO ptBO = new PhongTroBO();
		
		if (TrangThai != null && TrangThai.trim().equals("Còn trống")) {
			ptBO.deletePhongTro_TienIch(idPhong);
			ptBO.deleteHinhAnhPhong(idPhong);
			ptBO.deleteYeuCauThueTro(idPhong);
			boolean checked = ptBO.deletePhongTro(idPhong);
			if(checked) {
				response.getWriter().write("{\"success\": true}");
			}else {
				response.getWriter().write("{\"success\": false, \"message\": \"Không thể xóa phòng!\"}");
			}
            
            
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Phòng đang có người sử dụng không thể xóa!\"}");
        }
	}

}
