package web.payment.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PayCancleAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("√Îº“");
		ActionForward forward = new ActionForward();
		forward.setPath("PayList.pa");
		forward.setRedirect(true);
		return forward;
	}

}
