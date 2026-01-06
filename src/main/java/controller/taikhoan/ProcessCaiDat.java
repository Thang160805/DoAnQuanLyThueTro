package controller.taikhoan;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.BaoHong;
import model.bean.HopDong;
import model.bean.TaiKhoan;
import model.bo.BaoHongBO;
import model.bo.HopDongBO;
import model.bo.TaiKhoanBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ProcessCaiDat
 */
@WebServlet(name = "CaiDat", urlPatterns = { "/CaiDat" })
public class ProcessCaiDat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessCaiDat() {
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
		
		HopDongBO hdBO = new HopDongBO();
		ArrayList<HopDong> listPhongThue = hdBO.getListPhongDaThueById(user.getId());
		request.setAttribute("listPhongThue", listPhongThue);
		
		BaoHongBO bhBO = new BaoHongBO();
		ArrayList<BaoHong> listBH = bhBO.getTOP3BaoHongByID_NguoiGui(user.getId());
		request.setAttribute("listBH", listBH);
		
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/CaiDat.jsp");
		rs.forward(request, response);
	}

}
