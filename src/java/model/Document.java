/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Document {
    private int id;
    private String name;
    private String author;
    private String genre;
    private float coverPrice;

    public Document() {
    }

    public Document(int id, String name, String author, String genre, float coverPrice) {
        this.id = id;
        this.name = name;
        this.author = author;
        this.genre = genre;
        this.coverPrice = coverPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public float getCoverPrice() {
        return coverPrice;
    }

    public void setCoverPrice(float CoverPrice) {
        this.coverPrice = CoverPrice;
    }
    
}
