package com.ncr.itss.enums;

/**
 * @author kee
 */
public enum MenuType {
    MENU(1, "菜单"),
    BUTTON(2, "按钮");

    private Integer code;
    private String message;

    MenuType(Integer code, String message) {
        this.code = code;
        this.message = message;
    }


    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static String getSelectOptions(Integer code) {
        String options = "";
        for (MenuType menuType : values()) {
            options += " <option value=\"" + menuType.getCode() + "\"";
            if (menuType.getCode().equals(code)) {
                options += "selected=selected";
            }
            options += ">" + menuType.getMessage() + "</option>";
        }

        return options;

    }


}
