package com.fastcampus.gearshift.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class NewsDto {
    private Integer newsId;
    private String newsTitle;
    private String newsContent;
    private String newsThumbnailUrl; // 이 이름 정확히 일치해야 함
    private Date newsRegDate; // 컬럼명이 이거면 newsRegDate 써야 함
}

