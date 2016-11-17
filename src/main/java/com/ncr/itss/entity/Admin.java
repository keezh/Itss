package com.ncr.itss.entity;


import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;


public class Admin {

    private Long id;

    private String username;

    private String password;

    private Date createAt;

    private Date updateAt;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @JsonFormat(pattern = "YYYY-MM-dd HH:mm", timezone = "UTF-8")
    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    @JsonFormat(pattern = "YYYY-MM-dd HH:mm", timezone = "UTF-8")
    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }
}
