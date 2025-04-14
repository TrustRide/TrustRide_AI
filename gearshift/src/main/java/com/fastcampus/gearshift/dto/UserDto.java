package com.fastcampus.gearshift.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class UserDto {
    private Integer userId;
    private String userEmail;
    private String userPassword;
    private String userPhoneNumber;
    private String userName;
    private String userGender;
    private String userAccount;

    private String memberResident;
    private String memberAddr1;
    private String memberAddr2;
    private String memberAddr3;

    private String memberLicense;

    private Date createdAt;    // 유저등록일  --->삭제하지말아주세요 제발



}