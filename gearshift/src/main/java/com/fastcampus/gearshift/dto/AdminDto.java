package com.fastcampus.gearshift.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class AdminDto {
    private Integer adminId;
    private String adminEmail;
    private String adminPassword;
    private String adminPhone;
    private String adminName;
    private String department;
    private String position;
    private String gender;
    private Boolean isDeleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
