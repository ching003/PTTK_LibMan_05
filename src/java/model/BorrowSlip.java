/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class BorrowSlip {
    private int id;
    private Date borrowDate;
    private Date dueDate;
    private Reader reader;
    private BorrowDocument[] listBorrowDocuments;

    public BorrowSlip() {
    }
  
    public BorrowSlip(int id, Date borrowDate, Date dueDate, Reader reader, BorrowDocument[] listBorrowDocuments) {
        this.id = id;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.reader = reader;
        this.listBorrowDocuments = listBorrowDocuments;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Reader getReader() {
        return reader;
    }

    public void setReader(Reader reader) {
        this.reader = reader;
    }
    
    public BorrowDocument[] getListBorrowDocuments() {
        return listBorrowDocuments;
    }

    public void setListBorrowDocuments(BorrowDocument[] listBorrowDocuments) {
        this.listBorrowDocuments = listBorrowDocuments;
    }
}
