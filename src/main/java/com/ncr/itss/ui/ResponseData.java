package com.ncr.itss.ui;

public class ResponseData {
    private Object code;

    private String message;

    private Object data;

    public ResponseData() {
    }

    public ResponseData(Object code, String message) {
        super();
        this.code = code;
        this.message = message;
    }

    public ResponseData(Object code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public Object getCode() {
        return code;
    }

    public void setCode(Object code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object message) {
        this.data = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
