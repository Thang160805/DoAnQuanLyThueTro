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
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class AdminQT
 */
@WebServlet("/AdminQT")
public class AdminQT extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminQT() {
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
		request.setAttribute("ThongTinCaNhan", tk);
		ArrayList<TaiKhoan> listTK = tkBO.getListTaiKhoan();
		request.setAttribute("listTK", listTK);
		int countTK = tkBO.getCountTaiKhoan();
		request.setAttribute("countTK", countTK);
		PhongTroBO ptBO = new PhongTroBO();
		ArrayList<PhongTro> listPT = ptBO.getListPhongTroChuaDuyet();
		request.setAttribute("listPT", listPT);
		int countCD = ptBO.getCountPhongChoDuyet();
		int countDD = ptBO.getCountPhongDaDuyet();
		request.setAttribute("countCD", countCD);
		request.setAttribute("countDD", countDD);
		RequestDispatcher rs = request.getRequestDispatcher("/admin/AdminQT.jsp");
		rs.forward(request, response);
	}

}
