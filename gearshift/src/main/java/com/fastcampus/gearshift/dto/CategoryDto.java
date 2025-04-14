package com.fastcampus.gearshift.dto;

import lombok.*;

@Getter
@Setter
@RequiredArgsConstructor
@ToString
@AllArgsConstructor
public class CategoryDto {
    private Integer tier;
    private String cateName;
    private String cateCode;
    private String cateParent;
}