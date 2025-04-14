package com.fastcampus.gearshift.dto;

import lombok.*;


@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class HolderDTO {

    private Integer holderId;
    private String holderName;
    private String holderPhoneNumber;
    private String holderAddr1;
    private String holderAddr2;
    private String holderAddr3;
    private String holderResident;
    private String holderLicense;

}