package controller.chutro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.KhuVuc;
import model.bean.TaiKhoan;
import model.bean.TienIch;
import model.bo.KhuVucBO;
import model.bo.TienIchBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ThemPhongTro
 */
@WebServlet("/ThemPhongTro")
public class ThemPhongTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThemPhongTro() {
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
		KhuVucBO kvBO = new KhuVucBO();
		ArrayList<KhuVuc> listKhuVuc = kvBO.getListKhuVuc();
		request.setAttribute("listKV", listKhuVuc);
		TienIchBO tiBO = new TienIchBO();
		ArrayList<TienIch> listTienIch = tiBO.getListTienIch();
		request.setAttribute("listTI", listTienIch);
		
		RequestDispatcher rs = request.getRequestDispatcher("/ChuTro/ThemPhongTro.jsp");
		rs.forward(request, response);
	}

}
