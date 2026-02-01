import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddEventServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String title = request.getParameter("title");

        // Simulated database logic
        response.getWriter().print("Event '" + title + "' added successfully!");
    }
}
