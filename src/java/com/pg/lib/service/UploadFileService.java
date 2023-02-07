/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author pakutsing
 */
public class UploadFileService {

    private final String pathAttachfileLocalhost = "C:/Users/pakutsing/Desktop/Github/OrderUniformByPos2023/web/attachfile/";
    private final String pathAttachfileOnServer = "/web/webapps/OrderUniform/attachfile/";

    public HashMap<String, String> checkMultiContent(HttpServletRequest request, String content) throws UnsupportedEncodingException {
        HashMap<String, String> result = new HashMap<String, String>();
        String path = "";
        if (ServletFileUpload.isMultipartContent(request)) {

            try {
                //Create a factory for disk-based file and Create a new file upload handler 
                List multipart = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

                Iterator iterator = multipart.iterator();

                //Loop check content FormData;
                while (iterator.hasNext()) {

                    FileItem item = (FileItem) iterator.next();

                    //Item for Upload
                    if (!item.isFormField()) {
                        if (content.equalsIgnoreCase("uploadorder")) {
                            path = uploadexcelOrder(item);
                        }
                        //value return;
                        result.put("path", path);
                    }

                    //other 
                    if (item.isFormField()) {
                        //Get value from input companyname;
                        if (item.getFieldName().equals("doc_name")) {
                            result.put("docname", item.getString("UTF-8"));
                        } else if (item.getFieldName().equals("type")) {
                            result.put("type", item.getString("UTF-8"));
                        }
                    }
                }

            } catch (FileUploadException ex) {
                ex.printStackTrace();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        return result;
    }

    public String uploadexcelOrder(FileItem item) throws Exception {

        // Get Filename
        String filename = item.getName();

        // Generate Directory
        String folderName = makeDirectorySaveFile(pathAttachfileLocalhost + "upload_master/order");

        // Generate path Upload
        File uploadFile = new File(pathAttachfileLocalhost + "upload_master/order/" + folderName + "/" + filename);

        // Upload...
        item.write(uploadFile);

        String Strpath = "upload_master/order/" + folderName + "/" + filename;

        return Strpath;
    }

    private String makeDirectorySaveFile(String defualtpath) {
        String currentMili = Long.toString(System.currentTimeMillis());
        String pathForUpload = defualtpath + "/" + currentMili;
        File theDir = new File(pathForUpload);

        if (!theDir.exists()) {
            theDir.mkdirs();
        } else {
            System.out.println("Could not Create The Directory... ");
        }

        return currentMili;
    }
}
