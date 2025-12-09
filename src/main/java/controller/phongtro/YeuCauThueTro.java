package controller.phongtro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;

import java.io.IOException;

/**
 * Servlet implementation class YeuCauThueTro
 */
@WebServlet("/YeuCauThueTro")
public class YeuCauThueTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public YeuCauThueTro() {
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
		
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan tk = tkBO.getThongTinCaNhan(user.getId());
		request.setAttribute("ThongTin", tk);
		int ID_Phong = Integer.parseInt(request.getParameter("ID_Phong"));
		request.setAttribute("ID_Phong", ID_Phong);
		PhongTroBO ptBO = new PhongTroBO();
		PhongTro pt = ptBO.getPhongTroById(ID_Phong);
		request.setAttribute("ThongTinPhong", pt);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/YeuCauThueTro.jsp");
		rs.forward(request, response);
	}

}
