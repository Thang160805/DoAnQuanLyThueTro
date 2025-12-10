package controller.phongtro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.YeuCauThueTroBO;
import model.bean.YeuCauThueTro;
import java.io.IOException;
import java.sql.Date;

/**
 * Servlet implementation class XuLyYeuCauThueTro
 */
@WebServlet("/XuLyYeuCauThueTro")
public class XuLyYeuCauThueTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyYeuCauThueTro() {
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
		 int idPhong = Integer.parseInt(request.getParameter("ID_Phong"));
         int idTaiKhoan = Integer.parseInt(request.getParameter("ID_TaiKhoan"));
         String ngayDon = request.getParameter("NgayDonVao");
         Date ngayDonVao = Date.valueOf(ngayDon);
         String thoiHan = request.getParameter("ThoiHanThue");
         String loiNhan = request.getParameter("LoiNhan");
         String lienHe = request.getParameter("contact");


         YeuCauThueTroBO ycttBO = new YeuCauThueTroBO();
         YeuCauThueTro yctt = new YeuCauThueTro();
         yctt.setID_Phong(idPhong);
         yctt.setID_TaiKhoan(idTaiKhoan);
         yctt.setNgayDonVao(ngayDonVao);
         yctt.setThoiHanThue(thoiHan);
         yctt.setLoiNhan(loiNhan);
         yctt.setLienHe(lienHe);
         boolean checked = ycttBO.insertYeuCauThueTro(yctt);
         if(checked) {
        	 response.getWriter().write("{\"status\":\"success\"}");
         } else {
             response.getWriter().write("{\"status\":\"error\"}");
         }
	}

}
