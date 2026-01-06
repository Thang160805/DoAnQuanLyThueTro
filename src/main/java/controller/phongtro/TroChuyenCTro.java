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
import model.bean.TinNhan;
import model.bo.CuocTroChuyenBO;
import model.bo.TaiKhoanBO;
import model.bo.TinNhanBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class TroChuyenCTro
 */
@WebServlet("/TroChuyenCTro")
public class TroChuyenCTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TroChuyenCTro() {
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
		
		int ID_ChuTro = Integer.parseInt(request.getParameter("ID_ChuTro"));
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan tk = tkBO.getThongTinCaNhan(ID_ChuTro);
		request.setAttribute("ThongTin", tk);
		CuocTroChuyenBO ctcBO = new CuocTroChuyenBO();
		int idCuocTroChuyen = ctcBO.getIDOrInsert(user.getId(), ID_ChuTro);
		TinNhanBO tnBO = new TinNhanBO();
		ArrayList<TinNhan> listTinNhan = tnBO.getTinNhanByID(idCuocTroChuyen);
		request.setAttribute("listTinNhan", listTinNhan);
		request.setAttribute("idCuocTroChuyen", idCuocTroChuyen);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/TroChuyenCTro.jsp");
		rs.forward(request, response);
	}

}
