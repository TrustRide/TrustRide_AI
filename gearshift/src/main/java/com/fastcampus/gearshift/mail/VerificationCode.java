package com.fastcampus.gearshift.mail;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class VerificationCode {

    private final String code;
    private final LocalDateTime createdTime;

    public VerificationCode(String code) {
        this.code = code;
        this.createdTime = LocalDateTime.now();
    }

}
