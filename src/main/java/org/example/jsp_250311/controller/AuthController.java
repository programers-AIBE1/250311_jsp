package org.example.jsp_250311.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.Random;


@WebServlet("/auth")
public class AuthController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Random rand = new Random();
        int num;
        if (req.getCookies() == null ||
                Arrays.stream(req.getCookies()).noneMatch(cookie -> cookie.getName().equals("cookie_number"))
        ) {
            num = rand.nextInt(100);
            Cookie cookie = new Cookie("cookie_number", "%d".formatted(num));
            resp.addCookie(cookie);
        }


        HttpSession session = req.getSession();
        if(session.getAttribute("num") == null) {
            num = rand.nextInt(100);
            session.setAttribute("num", num);
        }



        if (session.getAttribute("is_login") != null && (boolean) session.getAttribute("is_login")) {
            req.getRequestDispatcher("/WEB-INF/success.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/auth.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("pw");

        if (id != null && password != null && id.equals("asdf") && password.equals("1234")) {
            HttpSession session = req.getSession();
            session.setAttribute("is_login", true);
        }

        resp.sendRedirect(req.getRequestURI());
    }
}
