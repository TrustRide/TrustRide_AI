package com.fastcampus.gearshift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SPagingDto {
    public static final int GRID_PAGE_SIZE = 9;
    public static final int LIST_PAGE_SIZE = 10;
    public static final int PAGE_BLOCK_SIZE = 5; // 한 번에 보여줄 페이지 수

    private int size;        // 한 페이지당 글 수
    private int page;        // 현재 페이지
    private int totalCount;  // 전체 글 수
    private int totalPages;  // 전체 페이지 수
    private int offset;      // LIMIT offset
    private int limit;       // LIMIT 개수

    // 블록 페이징 관련
    private int startPage;   // 페이지 번호 블록의 시작 번호
    private int endPage;     // 페이지 번호 블록의 끝 번호
    private boolean hasPrev; // 이전 블록 존재 여부
    private boolean hasNext; // 다음 블록 존재 여부

    public SPagingDto(int size, int page, int totalCount) {
        this.size = size;
        this.page = page;
        this.totalCount = totalCount;
        this.totalPages = (int) Math.ceil((double) totalCount / size);
        this.offset = (page - 1) * size;
        this.limit = size;

        // 블록 페이징 계산
        int currentBlock = (int) Math.ceil((double) page / PAGE_BLOCK_SIZE);
        this.startPage = (currentBlock - 1) * PAGE_BLOCK_SIZE + 1;
        this.endPage = Math.min(startPage + PAGE_BLOCK_SIZE - 1, totalPages);

        this.hasPrev = startPage > 1;
        this.hasNext = endPage < totalPages;
    }

    public static SPagingDto fromGrid(int page, int totalCount) {
        return new SPagingDto(GRID_PAGE_SIZE, page, totalCount);
    }

    public static SPagingDto fromList(int page, int totalCount) {
        return new SPagingDto(LIST_PAGE_SIZE, page, totalCount);
    }
}
