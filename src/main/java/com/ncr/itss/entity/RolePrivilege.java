package com.ncr.itss.entity;

import java.util.Date;

public class RolePrivilege {

    private Long id;

    private Date createAt;

    private Date updateAt;

    private Role role;

    private Privilege privilege;

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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Privilege getPrivilege() {
        return privilege;
    }

    public void setPrivilege(Privilege privilege) {
        this.privilege = privilege;
    }


    public RolePrivilege() {
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RolePrivilege rolePrivilege = (RolePrivilege) o;

        if (id != null ? !id.equals(rolePrivilege.id) : rolePrivilege.id != null) return false;
        if (createAt != null ? !createAt.equals(rolePrivilege.createAt) : rolePrivilege.createAt != null) return false;
        if (updateAt != null ? !updateAt.equals(rolePrivilege.updateAt) : rolePrivilege.updateAt != null) return false;
        if (role != null ? !role.equals(rolePrivilege.role) : rolePrivilege.role != null) return false;
        return privilege != null ? privilege.equals(rolePrivilege.privilege) : rolePrivilege.privilege == null;

    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (createAt != null ? createAt.hashCode() : 0);
        result = 31 * result + (updateAt != null ? updateAt.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        result = 31 * result + (privilege != null ? privilege.hashCode() : 0);
        return result;
    }


    @Override
    public String toString() {
        return "RolePrivilege{" +
                "id=" + id +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", role=" + role +
                ", privilege=" + privilege +
                '}';
    }
}