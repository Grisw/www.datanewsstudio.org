package org.datanewsstudio.www.textanalyzer.model;

import java.io.Serializable;

public class FileUploadResponse implements Serializable {

    public enum Code{
        UNKNOWN_ERROR(-1, "Unknown error, may be produced by python programs."),
        SUCCESS(0, "Success."),
        FORMAT_ERROR(1, "Format error, check file format guide."),
        UPLOAD_FAILED(400, "Upload failed."),
        TYPE_ERROR(401, "Type error, file must end with '.txt'."),
        PARAM_ERROR(402, "Parameter error, 'lang' and 'files' are required."),
        UNKNOWN_LANG(403, "Unknown Language.");

        private int code;
        private String message;

        Code(int code, String message) {
            this.code = code;
            this.message = message;
        }

        public int getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }

        public static Code getCode(int code){
            Code[] codes = Code.values();
            for(Code c : codes){
                if(c.code == code){
                    return c;
                }
            }
            return Code.UNKNOWN_ERROR;
        }
    }

    private int code;
    private String message;
    private String object;

    public FileUploadResponse(Code code, String object) {
        this.code = code.getCode();
        this.message = code.getMessage();
        this.object = object;
    }

    public void setCode(Code code) {
        this.code = code.getCode();
        this.message = code.getMessage();
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public String getObject() {
        return object;
    }

    public void setObject(String object) {
        this.object = object;
    }
}
