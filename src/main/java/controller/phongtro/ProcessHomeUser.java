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
import model.bean.ThongBao;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ProcessHomeUser
 */
@WebServlet("/ProcessHomeUser")
public class ProcessHomeUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessHomeUser() {
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
		TaiKhoan ThongTin = tkBO.getThongTinCaNhan(user.getId());
		request.setAttribute("ThongTinCaNhan", ThongTin);
		PhongTroBO ptBO = new PhongTroBO();
		ArrayList<PhongTro> listPhongTrong = ptBO.getListPhongTroTrong();
		request.setAttribute("listPhongTrong", listPhongTrong);
		
		ArrayList<PhongTro> listNewPT = ptBO.getListNewPhongTro();
		request.setAttribute("listNewPT", listNewPT);
		
		ThongBaoBO tbBO = new ThongBaoBO();
		int countTB = tbBO.getCountThongBao(user.getId());
		request.setAttribute("countTB", countTB);
		ArrayList<ThongBao> listTB = tbBO.getTop3TB(user.getId());
		request.setAttribute("listTB", listTB);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/Home.jsp");
		rs.forward(request, response);
		
	}

}
