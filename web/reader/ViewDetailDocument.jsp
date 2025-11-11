<%-- Document : ViewDetailDocumentFrm Created on : Oct 21, 2025, 11:47:32 PM Author : Admin --%>

    <%@page import="java.text.DecimalFormat" %>
        <%@page import="model.Document" %>
            <%@page import="model.User" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <% String idParam=request.getParameter("id"); Document
                        doc=(Document)request.getAttribute("document"); if(idParam !=null && !idParam.trim().isEmpty()
                        && doc==null){ %>
                        <jsp:forward page="/DocumentServlet">
                            <jsp:param name="action" value="detail" />
                            <jsp:param name="id" value="<%=idParam%>" />
                        </jsp:forward>
                        <% return; } %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                                <title>View Document Detail</title>
                                <style>
                                    body {
                                        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
                                        background-color: white;
                                        margin: 0;
                                        padding: 0;
                                    }

                                    header {
                                        background-color: #ffb6c1;
                                        color: white;
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        padding: 10px 20px;
                                        font-size: 20px;
                                        font-weight: bold;
                                    }

                                    .module-name {
                                        text-align: center;
                                        font-size: 28px;
                                        color: #777;
                                        margin: 15px 0;
                                        font-weight: bold;
                                    }

                                    caption {
                                        caption-side: top;
                                        font-weight: bold;
                                        font-size: 18px;
                                        color: #777;
                                        padding: 10px;
                                        text-align: left;
                                    }

                                    .table-title {
                                        text-align: center;
                                        font-size: 20px;
                                        font-weight: bold;
                                        margin-bottom: 10px;
                                        color: #d14782;
                                    }

                                    table {
                                        width: 50%;
                                        margin: 0 auto 30px auto;
                                        border-collapse: collapse;
                                        background-color: white;
                                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                                    }

                                    th,
                                    td {
                                        padding: 10px 15px;
                                        text-align: left;
                                        border: 1px solid #ccc;
                                    }

                                    th {
                                        background-color: #ffe6f0;
                                        color: #555;
                                        width: 30%;
                                    }

                                    tr:nth-child(even) {
                                        background-color: white;
                                    }

                                    .table-header {
                                        background-color: white;
                                        /* nền hồng đậm */
                                        color: #ffb6c1;
                                        /* chữ trắng */
                                        font-size: 18px;
                                        text-align: center;
                                    }

                                    .row-label {
                                        background-color: white;
                                        color: white;
                                        width: 30%;
                                        text-align: left;
                                    }

                                    .price-cell {
                                        text-align: right;
                                        /* căn phải cho giá bìa */
                                    }

                                    .back-button {
                                        display: block;
                                        margin: 0 auto 40px auto;
                                        padding: 10px 20px;
                                        font-size: 16px;
                                        background-color: #ff85a2;
                                        color: white;
                                        border: none;
                                        border-radius: 6px;
                                        cursor: pointer;
                                        transition: background 0.3s ease;
                                    }

                                    .back-button:hover {
                                        background-color: #ff6b8a;
                                    }
                                </style>
                            </head>

                            <body>
                                <% User reader=(User)session.getAttribute("reader"); if(reader==null){
                                    response.sendRedirect(request.getContextPath() + "/user/Login.jsp?err=timeout" );
                                    return; } %>
                                    <header>
                                        <div>LibMan – Library Management System</div>
                                        <div>Hello reader, <%=reader.getName()%>
                                        </div>
                                    </header>

                                    <div class="module-name">
                                        Search Document
                                    </div>
                                    <br><br>
                                    <% doc=(Document)request.getAttribute("document"); if(doc==null){ %>
                                        <div style="text-align: center; color: red; margin: 20px;">
                                            No information found.
                                        </div>
                                        <button class="back-button" onclick="history.back()"> Return </button>
                                        <% return; } DecimalFormat formatter=new DecimalFormat("#,###"); String
                                            formattedPrice=formatter.format(doc.getCoverPrice()); %>
                                            <table>
                                                <tr>
                                                    <caption>Detail Document Table</caption>
                                                </tr>
                                                <tr>
                                                    <th>ID</th>
                                                    <td>
                                                        <%=doc.getId()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Name</th>
                                                    <td>
                                                        <%=doc.getName()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Author</th>
                                                    <td>
                                                        <%=doc.getAuthor()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Genre</th>
                                                    <td>
                                                        <%=doc.getGenre()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Cover Price(VND)</th>
                                                    <td>
                                                        <%=formattedPrice%>
                                                    </td>
                                                </tr>
                                            </table>
                                            <button class="back-button" onclick="history.back()"> Return </button>

                            </body>

                            </html>