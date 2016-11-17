package com.ncr.itss.base;

/**
 * Created by kee on 2016/7/1.
 */
public class PageHelper {
    private Integer page;
    private Integer size;
    private Integer offset;
    private String sort;

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public PageHelper(Integer page, Integer size, String sort) {
        this.page = page;
        this.size = size;
        this.sort = sort;
        this.offset = page * size;
    }


}
