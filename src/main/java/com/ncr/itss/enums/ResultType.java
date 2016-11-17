package com.ncr.itss.enums;

/**
 * @author kee
 *         <select name="para_type" class="select-no-border key-type l ng-pristine ng-valid ng-touched" ng-model="in.para_type" style="">
 *         <option value="">参数类型</option>
 *         <option value="int   ">int</option>
 *         <option value="long   ">long</option>
 *         <option value="float   ">float</option>
 *         <option value="string   ">string</option>
 *         <option value="boolen   ">boolen</option>
 *         <option value="file   ">file</option>
 *         <option value="array    ">array</option>
 *         <option value="json   ">json</option>
 *         <option value="xml    ">xml</option>
 *         </select>
 */
public enum ResultType {
    JSON(1, "JSON", "json"),
    VIEW(2, "页面", "view"),
    XML(3, "XML", "xml");

    private Integer code;
    private String message;
    private String type;

    ResultType(Integer code, String message, String type) {
        this.code = code;
        this.message = message;
        this.type = type;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public static String getSelectOptions(Integer code) {
        String options = "";
        for (ResultType privilegeType : values()) {
            options += " <option value=\"" + privilegeType.getCode() + "\"";
            if (privilegeType.getCode().equals(code)) {
                options += "selected=selected";
            }
            options += ">" + privilegeType.getType() + "</option>";
        }

        return options;

    }

    public static String getType(Integer code) {
        for (ResultType privilegeType : values()) {
            if (privilegeType.getCode().equals(code))
                return privilegeType.getType();
        }
        return null;
    }


}
