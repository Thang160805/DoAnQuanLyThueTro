package controller.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.TienIch;
import model.bo.PhongTroBO;
import model.bo.TienIchBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ChiTietPhongDuyet
 */
@WebServlet("/ChiTietPhongDuyet")
public class ChiTietPhongDuyet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChiTietPhongDuyet() {
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
		
		int ID_Phong = Integer.parseInt(request.getParameter("ID_Phong"));
		PhongTroBO ptBO = new PhongTroBO();
		PhongTro pt = ptBO.getPhongTroById(ID_Phong);
		request.setAttribute("ChiTietPhong", pt);
		TienIchBO tiBO = new TienIchBO();
		ArrayList<TienIch> listTienIch = tiBO.getListTienIchByIDPhong(ID_Phong);
		request.setAttribute("listTienIch", listTienIch);
		RequestDispatcher rs = request.getRequestDispatcher("/admin/ChiTietPhongDuyet.jsp");
		rs.forward(request, response);
	}

}
