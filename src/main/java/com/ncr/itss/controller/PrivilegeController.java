package com.ncr.itss.controller;



import com.ncr.itss.core.utils.StringUtils;
import com.ncr.itss.dao.PrivilegeDao;
import com.ncr.itss.entity.Privilege;
import com.ncr.itss.enums.PrivilegeType;
import com.ncr.itss.service.PrivilegeService;
import com.ncr.itss.ui.ResponseData;
import com.ncr.itss.ui.Table;
import com.ncr.itss.ui.Tree;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by renshilei on 2015/9/7.
 */
@Controller
@RequestMapping("/privilege")
public class PrivilegeController {
    private static final Logger logger = LoggerFactory.getLogger(PrivilegeController.class);


    @Autowired
    private PrivilegeDao privilegeDao;


    @Autowired
    private PrivilegeService privilegeService;

    /**
     * 列
     *
     * @return
     */
    @RequestMapping("list")
    public String list(Model model) {

        List<Privilege> privilegeList = privilegeService.findAll();

        model.addAttribute("privilegeList", privilegeList);

        Map<Object, String> typeMap = new HashMap<>();

        typeMap.put(PrivilegeType.MENU.getCode(), PrivilegeType.MENU.getMessage());
        typeMap.put(PrivilegeType.BUTTON.getCode(), PrivilegeType.BUTTON.getMessage());

        model.addAttribute("typeMap", typeMap);

        return "privilege/list";
    }

    /**
     * 列
     *
     * @param start
     * @param length
     * @return
     */
    @ResponseBody
    @RequestMapping("list-data")
    public Table listData(
            @RequestParam(value = "start", defaultValue = "0") Integer start,
            @RequestParam(value = "length", defaultValue = "10") Integer length,
            Long parentId) {
        List<Privilege> privilegeList;
        if (parentId == null) {
            privilegeList = privilegeService.findAll();
        } else {
            privilegeList = privilegeService.findChildren(parentId);
        }
        return new Table(privilegeList.size(), privilegeList.size(), privilegeList);
    }

    /**
     * 形
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("tree-data")
    public List<Tree> treeData(String id) {
        List<Privilege> privilegeList;
        if (StringUtils.isEmpty(id) || StringUtils.equals("#", id)) {
            privilegeList = privilegeService.findAll();
            List<Tree> treeList = getTrees(privilegeList);
            Tree root = new Tree();
            root.setId("#");
            root.setName("菜单管理");
            root.setIsParent(true);
            root.setIconSkin("root");
            root.setType(PrivilegeType.MENU.getCode());
            root.setChildren(treeList);
            List<Tree> rootList = new ArrayList<>();
            rootList.add(root);
            return rootList;
        } else {
            privilegeList = privilegeService.findChildren(Long.parseLong(id));
            return getTrees(privilegeList);
        }
    }

    /**
     * 菜单   （List<Privilege>=>List<Tree>）
     *
     * @param privilegeList
     * @return
     */
    private List<Tree> getTrees(List<Privilege> privilegeList) {
        List<Tree> treeList = new ArrayList<>();

        for (Privilege privilege : privilegeList) {
            Tree tree = new Tree();
            tree.setId(privilege.getId() + "");
            tree.setName(privilege.getName());

            if (privilege.getType().equals(PrivilegeType.BUTTON.getCode())) {
                tree.setIsParent(false);
            } else {
                tree.setIsParent(true);
            }

            tree.setIconSkin(PrivilegeType.getIconSkin(privilege.getType()));
            tree.setType(privilege.getType());
            treeList.add(tree);
        }
        return treeList;
    }


    /**
     * 修
     *
     * @param model
     * @return
     */
    @RequestMapping("add")
    public String add(Model model, Long parentId) {
        Privilege privilege = new Privilege();
        Privilege parent = new Privilege();
        parent.setId(parentId);
        privilege.setParent(parent);
        model.addAttribute("bean", privilege);
        String selectOptions = PrivilegeType.getSelectOptions(privilege.getType());
        model.addAttribute("selectOptions", selectOptions);
        return "privilege/edit";
    }


    /**
     * 修
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("edit")
    public String edit(Long id, Model model) {
        Privilege privilege = privilegeDao.find(id);
        model.addAttribute("bean", privilege);
        String selectOptions = PrivilegeType.getSelectOptions(privilege.getType());
        model.addAttribute("selectOptions", selectOptions);
        return "privilege/edit";
    }

    /**
     * 保存
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("save")
    public ResponseData save(Privilege privilege, Long parentId) {
        Privilege target;
        Privilege parent = new Privilege();
        parent.setId(parentId);

        if (null == privilege.getId()) {
            target = privilege;
            target.setParent(parent);
            target.setCreateAt(new Date());
            target.setUpdateAt(new Date());
            privilegeDao.insert(target);
            target = privilegeDao.find(target.getId());
            target.setSort(target.getId());//设置排序
            privilegeDao.update(target);

        } else {
            target = privilegeDao.find(privilege.getId());
            target.setAction(privilege.getAction());
            target.setCode(privilege.getCode());
            target.setName(privilege.getName());
            target.setType(privilege.getType());
            target.setParent(parent);
            target.setUpdateAt(new Date());
            privilegeDao.update(privilege);
        }

        Tree tree = new Tree();
        tree.setId(target.getId() + "");
        tree.setName(target.getName());
        tree.setIsParent(true);
        tree.setType(target.getType());

        return new ResponseData(true, "保存成功", tree);
    }


    /**
     * 删
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("delete")
    public ResponseData delete(Long id) {

        Boolean success = privilegeService.delete(id);

        return new ResponseData(success, "删除成功");

    }


}
