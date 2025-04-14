package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.UserDto;

public interface SUserService {
    void registerUser(UserDto user);
    boolean isEmailDuplicated(String email);
    UserDto findUserByEmail(String email);
}
