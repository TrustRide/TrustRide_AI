package com.fastcampus.gearshift.auth.provider;

import com.fastcampus.gearshift.auth.service.AdminLoginService;
import com.fastcampus.gearshift.auth.service.UserLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;


@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired private UserLoginService userLoginService;
    @Autowired private AdminLoginService adminLoginService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Authentication authenticate(Authentication authentication) {
        String emailWithPrefix = authentication.getName();
        String rawPassword = authentication.getCredentials().toString();

        UserDetails userDetails = null;
        if (emailWithPrefix.startsWith("user:")) {
            String email = emailWithPrefix.substring("user:".length());
            userDetails = userLoginService.loadUserByUsername(email); // user 서비스에서 인증
        } else if (emailWithPrefix.startsWith("admin:")) {
            String email = emailWithPrefix.substring("admin:".length());
            userDetails = adminLoginService.loadUserByUsername(email); // admin 서비스에서 인증
        }

        if (!passwordEncoder.matches(rawPassword, userDetails.getPassword())) {
            throw new BadCredentialsException("잘못된 비밀번호");
        }

        return new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }

}

