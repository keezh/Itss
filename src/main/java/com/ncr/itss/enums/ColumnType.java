package com.ncr.itss.enums;

/**
 * Created by kee on 2016/7/5.
 */
public enum ColumnType {

    VARCHAR("VARCHAR", "String"),

    CHAR("CHAR", "String"),

    BLOB("BLOB", "byte[]"),

    TEXT("TEXT", "String"),

    INTEGER("INTEGER", "Long"),

    TINYINT("TINYINT", "Integer"),

    SMALLINT("SMALLINT", "Integer"),

    MEDIUMINT("MEDIUMINT", "Integer"),

    BIT("BIT", "Boolean"),

    INT("INT", "Integer"),

    BIGINT("BIGINT", "Long"),

    FLOAT("FLOAT", "Float"),

    DOUBLE("DOUBLE", "Double"),

    DECIMAL("DECIMAL", "java.math.BigDecimal"),

    DATE("DATE", "java.util.Date"),

    DATETIME("DATETIME", "java.util.Date");

    private String column;
    private String field;

    ColumnType(String column, String field) {
        this.column = column;
        this.field = field;
    }

    public String getColumn() {
        return column;
    }

    public void setColumn(String column) {
        this.column = column;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public static String getFieldByColumn(String column) {
        for (ColumnType columnType : values()) {
            if (columnType.getColumn().equals(column)) {
                return columnType.getField();
            }
        }
        return null;
    }
}
