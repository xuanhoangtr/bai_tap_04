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
        + "<rect width='200' height='200' fill='#e2e8f0' rx='100'/>"
        + "<circle cx='100' cy='75' r='38' fill='#94a3b8'/>"
        + "<path d='M40 165 C40 130 68 112 100 112 C132 112 160 130 160 165 Z' fill='#64748b'/>"
        + "<text x='100' y='190' font-family='Arial, sans-serif' font-size='12' font-weight='bold' fill='#475569' text-anchor='middle'>User Avatar</text>"
        + "</svg>";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName != null && !fileName.trim().isEmpty()) {
            File file = new File(Constant.DIR + File.separator + fileName.trim());
            if (file.exists() && file.isFile()) {
                String mimeType = getServletContext().getMimeType(file.getName());
                if (mimeType == null) {
                    if (fileName.endsWith(".png")) mimeType = "image/png";
                    else if (fileName.endsWith(".gif")) mimeType = "image/gif";
                    else if (fileName.endsWith(".webp")) mimeType = "image/webp";
                    else mimeType = "image/jpeg";
                }
                resp.setContentType(mimeType);
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
