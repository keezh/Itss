package com.ncr.itss.entity;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 */
public class Privilege {

    private Long id;

    private String name;

    private String code;

    private Integer type;

    private String action;

    private Privilege parent;

    private Long sort;

    private Date createAt;

    private Date updateAt;

    private List<Privilege> children;

    private List<RolePrivilege> rolePrivilegeList;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }


    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }


    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
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

    public Long getSort() {
        return sort;
    }

    public void setSort(Long sort) {
        this.sort = sort;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Privilege menu = (Privilege) o;

        if (id != menu.id) return false;
        if (name != null ? !name.equals(menu.name) : menu.name != null) return false;
        if (code != null ? !code.equals(menu.code) : menu.code != null) return false;
        if (type != null ? !type.equals(menu.type) : menu.type != null) return false;
        if (action != null ? !action.equals(menu.action) : menu.action != null) return false;

        return true;
    }


    public Privilege getParent() {
        return parent;
    }


    public void setParent(Privilege parent) {
        this.parent = parent;
    }

    public List<Privilege> getChildren() {
        return children;
    }

    public void setChildren(List<Privilege> children) {
        this.children = children;
    }


    public List<RolePrivilege> getRolePrivilegeList() {
        if (this.rolePrivilegeList == null) {
            return new ArrayList<>();
        }
        return rolePrivilegeList;
    }

    public void setRolePrivilegeList(List<RolePrivilege> rolePrivilegeList) {
        this.rolePrivilegeList = rolePrivilegeList;
    }

    @Override
    public String toString() {
        return "Privilege{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", type=" + type +
                ", action='" + action + '\'' +
                ", parent=" + parent +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", children=" + children +
                ", rolePrivilegeList=" + rolePrivilegeList +
                '}';
    }
}
