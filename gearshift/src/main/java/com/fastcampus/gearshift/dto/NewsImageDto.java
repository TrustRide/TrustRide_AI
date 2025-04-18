package com.fastcampus.gearshift.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NewsImageDto {
    private Integer newsImageId;
    private Integer newsId;
    private String NewsImageUrl;
    private Boolean NewsIsThumbnail;
}
