package com.ncr.itss.entity;

import java.util.Date;

public class AdminRole {

    private Long id;


    private Date createAt;

    private Date updateAt;

    private Admin Admin;

    private Role role;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    public Admin getAdmin() {
        return Admin;
    }

    public void setAdmin(Admin admin) {
        Admin = admin;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AdminRole adminRole = (AdminRole) o;

        if (id != null ? !id.equals(adminRole.id) : adminRole.id != null) return false;
        if (createAt != null ? !createAt.equals(adminRole.createAt) : adminRole.createAt != null) return false;
        if (updateAt != null ? !updateAt.equals(adminRole.updateAt) : adminRole.updateAt != null) return false;
        if (Admin != null ? !Admin.equals(adminRole.Admin) : adminRole.Admin != null) return false;
        return role != null ? role.equals(adminRole.role) : adminRole.role == null;

    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (createAt != null ? createAt.hashCode() : 0);
        result = 31 * result + (updateAt != null ? updateAt.hashCode() : 0);
        result = 31 * result + (Admin != null ? Admin.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        return result;
    }


    @Override
    public String toString() {
        return "AdminRole{" +
                "id=" + id +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", Admin=" + Admin +
                ", role=" + role +
                '}';
    }
}