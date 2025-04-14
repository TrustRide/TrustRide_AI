package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.AdminDto;

import java.util.List;

public interface SAdminService {
    void registerUser(AdminDto user);
    List<AdminDto> getAllUsers();
    int getTotalUserCount();
    List<AdminDto> getUsersWithPaging(int offset, int limit);
    AdminDto findUserByEmail(String email);
    void deleteUser(Integer adminId);
    void activateUser(Integer adminId);
}
