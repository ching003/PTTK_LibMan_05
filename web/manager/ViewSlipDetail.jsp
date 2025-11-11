<%@page import="model.User" %>
    <%@page import="model.BorrowSlip" %>
        <%@page import="model.BorrowDocument" %>
            <%@page import="java.text.SimpleDateFormat" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>View Reader Borrowing Detail</title>
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
                                letter-spacing: 1px;
                            }

                            .module-name {
                                text-align: center;
                                font-size: 24px;
                                color: #777;
                                margin: 10px 0;
                                font-weight: bold;
                            }

                            /* --- Thông tin độc giả --- */
                            .reader-info {
                                width: 60%;
                                margin: 0 auto 10px auto;
                                font-size: 16px;
                                line-height: 1.6;
                            }

                            .info-row {
                                display: flex;
                                justify-content: space-between;
                            }

                            .info-left,
                            .info-right {
                                width: 48%;
                            }

                            /* --- Bảng dữ liệu --- */
                            table {
                                width: 60%;
                                margin: 0 auto 20px auto;
                                border-collapse: collapse;
                                background-color: white;
                                box-shadow: 0 0 6px rgba(0, 0, 0, 0.1);
                            }

                            caption {
                                caption-side: top;
                                text-align: left;
                                font-weight: bold;
                                color: #777;
                                padding: 8px;
                                font-size: 18px;
                            }

                            th,
                            td {
                                padding: 6px 8px;
                                border: 1px solid #ccc;
                                text-align: center;
                            }

                            th {
                                background-color: #ffb6c1;
                                color: white;
                            }

                            th:first-child,
                            td:first-child {
                                width: 60px;
                            }

                            th:nth-child(2),
                            td:nth-child(2) {
                                width: 100px;
                            }

                            th:nth-child(3),
                            td:nth-child(3) {
                                width: 320px;
                                text-align: left;
                            }

                            /* --- Hàng cuối: ngày mượn / ngày trả --- */
                            .footer-row td {
                                text-align: left;
                                border-top: 1px solid #ccc;
                                background-color: #fffafc;
                                padding: 10px 12px;
                            }

                            .footer-row td p {
                                margin: 3px 0;
                                font-size: 15px;
                            }

                            .footer-row strong {
                                font-weight: 600;
                            }

                            .footer-row span {
                                display: inline-block;
                                min-width: 120px;
                                color: #555;
                                font-weight: normal;
                            }
                        </style>
                    </head>

                    <body>
                        <% User manager=(User) session.getAttribute("manager"); if (manager==null) {
                            response.sendRedirect(request.getContextPath() + "/user/Login.jsp?err=timeout" ); return; }
                            BorrowSlip slip=(BorrowSlip) request.getAttribute("borrowSlip"); String
                            slipIdParam=request.getParameter("slipId"); if (slip==null && slipIdParam !=null &&
                            !slipIdParam.trim().isEmpty()) { %>
                            <jsp:forward page="/BorrowSlipServlet">
                                <jsp:param name="slipId" value="<%=slipIdParam%>" />
                            </jsp:forward>
                            <% return; } if (slip==null) { response.sendRedirect(request.getContextPath()
                                + "/manager/ViewManagerPage.jsp?err=notfound" ); return; } SimpleDateFormat sdf=new
                                SimpleDateFormat("dd/MM/yyyy"); %>
                                <header>
                                    <div>LibMan – Library Management System</div>
                                    <div>Hello manager, <strong>
                                            <%=manager.getName()%>
                                        </strong></div>
                                </header>

                                <div class="module-name">
                                    View reader borrowing statistic
                                </div>

                                <!-- Thông tin độc giả -->
                                <div class="reader-info">
                                    <div class="info-row">
                                        <div class="info-left"><strong>Name: </strong>
                                            <%=slip.getReader() !=null && slip.getReader().getName() !=null ?
                                                slip.getReader().getName() : "" %>
                                        </div>
                                        <div class="info-right" style="text-align: right;"><strong>Borrow Slip ID:
                                            </strong>
                                            <%=slip.getId()%>
                                        </div>
                                    </div>
                                    <p><strong> Card ID:</strong>
                                        <%=slip.getReader() !=null && slip.getReader().getLibraryCard() !=null ?
                                            slip.getReader().getLibraryCard().getId() : "" %>
                                    </p>
                                </div>

                                <!-- Bảng tài liệu -->
                                <table id="docTable">
                                    <caption>BorrowSlip Detail Table</caption>
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>ID</th>
                                            <th>Document</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (slip.getListBorrowDocuments() !=null &&
                                            slip.getListBorrowDocuments().length>
                                            0) {
                                            int stt = 1;
                                            for (BorrowDocument bd : slip.getListBorrowDocuments()) {
                                            if (bd.getDocument() != null) {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=stt++%>
                                                </td>
                                                <td>
                                                    <%=bd.getDocument().getId()%>
                                                </td>
                                                <td>
                                                    <%=bd.getDocument().getName() !=null ? bd.getDocument().getName()
                                                        : "" %>
                                                </td>
                                            </tr>
                                            <% } } } else { %>
                                                <tr>
                                                    <td colspan="3" style="text-align: center; padding: 20px;">Không có
                                                        tài
                                                        liệu mượn.</td>
                                                </tr>
                                                <% } %>
                                                    <!-- Hàng cuối cùng: Ngày mượn / Ngày trả -->
                                                    <tr class="footer-row">
                                                        <td colspan="3">
                                                            <p><strong>Borrow Date:</strong> <span>
                                                                    <%=slip.getBorrowDate() !=null ?
                                                                        sdf.format(slip.getBorrowDate()) : "" %>
                                                                </span></p>
                                                            <p><strong>Due Date:</strong> <span>
                                                                    <%=slip.getDueDate() !=null ?
                                                                        sdf.format(slip.getDueDate()) : "" %>
                                                                </span></p>
                                                        </td>
                                                    </tr>
                                    </tbody>
                                </table>

                    </body>

                    </html>