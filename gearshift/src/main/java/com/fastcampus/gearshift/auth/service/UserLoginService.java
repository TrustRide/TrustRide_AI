package com.fastcampus.gearshift.auth.service;

import com.fastcampus.gearshift.dao.SUserDao;
import com.fastcampus.gearshift.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service("userDetailsService")
public class UserLoginService implements UserDetailsService {

    @Autowired
    private SUserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserDto user = userDao.findByEmail(email);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getUserEmail())
                .password(user.getUserPassword()) // 암호화된 비번
                .roles("USER")
                .build();
    }

}
