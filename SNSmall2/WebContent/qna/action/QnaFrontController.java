package web.qna.action;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.product.action.ProductDetailAction;

public class QnaFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/QnaInsertAction.qn")){
			action = new QnaInsertAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {e.printStackTrace();}
			
		}else if(command.equals("/QnaList.qn")){
			action = new QnaList();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {e.printStackTrace();}
			
		}else if(command.equals("/QnaPopular.qn")){
			action = new QnaPopular();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {e.printStackTrace();}
			
		}
		
		if(forward != null){
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
		
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
}
