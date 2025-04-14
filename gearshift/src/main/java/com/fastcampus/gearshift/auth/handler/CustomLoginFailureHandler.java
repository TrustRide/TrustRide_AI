package com.fastcampus.gearshift.auth.handler;

import com.fastcampus.gearshift.service.SAdminService;
import com.fastcampus.gearshift.service.SUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

    @Autowired
    private SUserService userService;

    @Autowired
    private SAdminService adminService;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        String email = request.getParameter("userEmail");
        String contextPath = request.getContextPath();

        String loginType = "personal";
        if (email != null && email.startsWith("admin:")) {
            loginType = "admin";
        }

        response.sendRedirect(contextPath + "/login.do?error=true&loginType=" + loginType);
    }
}
