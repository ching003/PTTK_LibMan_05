/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ReaderStatistic extends Reader{
    private int count;
    private int totalBorrowedDocuments;

    public ReaderStatistic() {
        super();
    }
    
    public int getTotalBorrowedDocuments() {
        return totalBorrowedDocuments;
    }

    public void setTotalBorrowedDocuments(int totalBorrowedDocuments) {
        this.totalBorrowedDocuments = totalBorrowedDocuments;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    
}
