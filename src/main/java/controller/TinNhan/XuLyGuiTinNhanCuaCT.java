package controller.TinNhan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.TinNhan;
import model.bo.CuocTroChuyenBO;
import model.bo.TinNhanBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;

/**
 * Servlet implementation class XuLyGuiTinNhanCuaCT
 */
@WebServlet("/XuLyGuiTinNhanCuaCT")
public class XuLyGuiTinNhanCuaCT extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyGuiTinNhanCuaCT() {
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

		String message = request.getParameter("message");
		int idNguoiNhan = Integer.parseInt(request.getParameter("idNguoiNhan"));

		CuocTroChuyenBO ctcBO = new CuocTroChuyenBO();
		TinNhanBO tnBO = new TinNhanBO();

		int idCuocTroChuyen = ctcBO.getIDOrInsert(user.getId(), idNguoiNhan);
		TinNhan tn = tnBO.insertAndReturnTinNhan(idCuocTroChuyen, user.getId(), message);

		String thoiGian = tn.getThoiGian().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);

		response.setContentType("application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		out.print("{");
		out.print("\"noiDung\":\"" + tn.getNoiDung() + "\",");
		out.print("\"thoiGian\":\"" + thoiGian + "\",");
		out.print("\"idNguoiGui\":" + tn.getID_NguoiGui());
		out.print("}");
		out.flush();
	}

}
