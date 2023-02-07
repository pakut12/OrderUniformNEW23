/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import com.pg.lib.model.OUUploadOrder;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

/**
 *
 * @author pakutsing
 */
public class ReadExcelService {

    private final String pathAttachfileLocalhost = "C:/Users/pakutsing/Desktop/Github/OrderUniformByPos2023/web/attachfile/";
    private final String pathAttachfileOnServer = "/web/webapps/OrderUniform/attachfile/";

    public Boolean ChkOrder(HashMap<String, String> order) throws IOException {
        Boolean ChkExcel = null;
        FileInputStream fileInputStream = new FileInputStream(pathAttachfileLocalhost + order.get("path"));
        HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);
        HSSFSheet worksheet = workbook.getSheetAt(0);
        HSSFRow row = worksheet.getRow(0);
        int lastCellNum = row.getLastCellNum();
        
        if (lastCellNum == 14) {
            ChkExcel = true;
        } else {
            ChkExcel = false;
        }
        return ChkExcel;

    }

    public List<OUUploadOrder> ReadOrder(HashMap<String, String> order) throws IOException {

        List<OUUploadOrder> listorder = new LinkedList<OUUploadOrder>();
        try {
            FileInputStream fileInputStream = new FileInputStream(pathAttachfileLocalhost + order.get("path"));
            HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);
            HSSFSheet worksheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = worksheet.iterator();
            //Loop Row
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                //skip column name at first row

                if (row.getRowNum() == 0) {
                    continue;
                }
                Iterator<Cell> cellIterator = row.cellIterator();
                OUUploadOrder orderdetail = new OUUploadOrder();

                while (cellIterator.hasNext()) {

                    Cell cell = cellIterator.next();
                    cell.setCellType(cell.CELL_TYPE_STRING);

                    if (cell.getColumnIndex() == 0) {
                        continue;
                    } else if (cell.getColumnIndex() == 1) {
                        orderdetail.setReceipt_id(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 2) {
                        orderdetail.setOrder_cms_id(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 3) {
                        orderdetail.setOrder_cms_fullname(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 4) {
                        orderdetail.setOrder_cms_company(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 5) {
                        orderdetail.setOrder_cms_department(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 6) {
                        orderdetail.setOrder_product_id(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 7) {
                        orderdetail.setOrder_product_barcode(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 8) {
                        orderdetail.setOrder_product_name(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 9) {
                        orderdetail.setOrder_mat_group(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 10) {
                        orderdetail.setOrder_mat_name(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 11) {
                        orderdetail.setOrder_product_qty(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 12) {
                        orderdetail.setOrder_price_inc_vat(cell.getStringCellValue());
                    } else if (cell.getColumnIndex() == 13) {
                        orderdetail.setOrder_price_exc_vat(cell.getStringCellValue());
                    }
                }

                listorder.add(orderdetail);
            }
            fileInputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listorder;

    }
}
