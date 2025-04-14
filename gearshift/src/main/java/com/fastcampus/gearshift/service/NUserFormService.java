package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.UserDto;

import java.util.List;

public interface NUserFormService {
    List<UserDto> userForm();
    UserDto getUserFormById(Integer userId);
    void updateUserForm(Integer userId, UserDto updatedUserForm);
    void deleteUser(Integer userId);
}
