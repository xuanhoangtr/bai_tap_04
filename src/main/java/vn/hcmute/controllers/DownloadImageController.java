package vn.hcmute.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.apache.commons.io.IOUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.hcmute.utils.Constant;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DEFAULT_SVG =
        "<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'>"
        + "<rect width='200' height='200' fill='#f8f9fa' rx='8'/>"
        + "<circle cx='100' cy='85' r='36' fill='#e9ecef'/>"
        + "<path d='M100 60 C90 60 82 68 82 78 C82 92 100 110 100 110 C100 110 118 92 118 78 C118 68 110 60 100 60 Z' fill='#adb5bd'/>"
        + "<text x='100' y='145' font-family='Arial, sans-serif' font-size='13' font-weight='bold' fill='#495057' text-anchor='middle'>Apple Store</text>"
        + "</svg>";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null && !fileName.isEmpty() && !"avatar.png".equals(fileName)) {
            File file = new File(Constant.DIR + "/" + fileName);
            if (file.exists()) {
                resp.setContentType("image/jpeg");
                try (FileInputStream fis = new FileInputStream(file)) {
                    IOUtils.copy(fis, resp.getOutputStream());
                }
                return;
            }
        }

        // Tra ve anh SVG mac dinh sieu nhe, khong lo loi 404 hay mang cham
        resp.setContentType("image/svg+xml; charset=UTF-8");
        resp.getWriter().write(DEFAULT_SVG);
    }
}
