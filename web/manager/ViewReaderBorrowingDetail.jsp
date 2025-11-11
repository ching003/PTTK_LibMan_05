<%-- Document : ViewReaderDetail Created on : Nov 5, 2025, 3:52:37 PM Author : Admin --%>

    <%@page import="model.*" %>
        <%@page import="java.util.ArrayList" %>
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

                            table {
                                width: 40%;
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
                                padding: 10px;
                                font-size: 18px;
                            }

                            th,
                            td {
                                padding: 5px 8px;
                                border: 1px solid #ccc;
                                text-align: left;
                            }

                            th {
                                background-color: #ffb6c1;
                                color: white;
                            }

                            th:first-child,
                            td:first-child {
                                width: 50px;
                                text-align: center;
                            }

                            th:nth-child(2),
                            td:nth-child(2) {
                                width: 100px;
                                text-align: center;
                            }

                            th:nth-child(3),
                            td:nth-child(3) {
                                width: 80px;
                                text-align: center;
                            }



                            .pagination {
                                text-align: center;
                                margin-bottom: 30px;
                                display: flex;
                                justify-content: center;
                                align-items: center;
                                gap: 8px;
                                font-size: 14px;
                            }

                            .pagination button {
                                padding: 5px 10px;
                                border: 1px solid #ccc;
                                background-color: white;
                                cursor: pointer;
                                border-radius: 4px;
                            }

                            .pagination button.active {
                                background-color: #ff85a2;
                                color: white;
                                border-color: #ff85a2;
                            }

                            .pagination button:hover:not(.active) {
                                background-color: #ffb6c1;
                                color: white;
                            }

                            .page-info {
                                font-weight: bold;
                            }
                        </style>
                    </head>

                    <body>
                        <% User manager=(User) session.getAttribute("manager"); if (manager==null) {
                            response.sendRedirect(request.getContextPath() + "/user/Login.jsp?err=timeout" ); return; }
                            ArrayList<BorrowSlip> list = (ArrayList<BorrowSlip>) request.getAttribute("borrowSlipList");
                                String readerIdParam = request.getParameter("readerId");
                                if (list == null && readerIdParam != null && !readerIdParam.trim().isEmpty()) {
                                %>
                                <jsp:forward page="/BorrowSlipServlet">
                                    <jsp:param name="readerId" value="<%=readerIdParam%>" />
                                </jsp:forward>
                                <% return; } Integer cardId=(Integer) request.getAttribute("cardId"); String
                                    readerName="" ; if (list !=null && !list.isEmpty()) { BorrowSlip
                                    firstSlip=list.get(0); if (firstSlip.getReader() !=null) { if
                                    (firstSlip.getReader().getName() !=null) {
                                    readerName=firstSlip.getReader().getName(); } if (cardId==null &&
                                    firstSlip.getReader().getLibraryCard() !=null) {
                                    cardId=firstSlip.getReader().getLibraryCard().getId(); } } } SimpleDateFormat
                                    sdf=new SimpleDateFormat("dd/MM/yyyy"); %>
                                    <header>
                                        <div>LibMan – Library Management System</div>
                                        <div>Hello manager, <strong>
                                                <%=manager.getName()%>
                                            </strong></div>
                                    </header>

                                    <div class="module-name">
                                        View reader borrowing detail
                                    </div>
                                    <div
                                        style="width: 60%; margin: 0px auto 0px auto; font-size: 16px; line-height: 1.6;">
                                        <p><strong>Name:</strong>
                                            <%=readerName%>
                                        </p>
                                        <p><strong>Card ID:</strong>
                                            <%=cardId !=null ? cardId : "" %>
                                        </p>
                                    </div>
                                    <table id="docTable">
                                        <caption>Reader Borrowing Detail Table</caption>
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>ID</th>
                                                <th>Borrow Date</th>
                                                <th>Number of documents</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% if (list !=null && !list.isEmpty()) { int count=1; for (BorrowSlip slip :
                                                list) { %>
                                                <tr style="cursor: pointer;"
                                                    onclick="window.location.href='<%=request.getContextPath()%>/manager/ViewSlipDetail.jsp?slipId=<%=slip.getId()%>'">
                                                    <td>
                                                        <%=count++%>
                                                    </td>
                                                    <td>
                                                        <%=slip.getId()%>
                                                    </td>
                                                    <td>
                                                        <%=slip.getBorrowDate() !=null ?
                                                            sdf.format(slip.getBorrowDate()) : "" %>
                                                    </td>
                                                    <td>
                                                        <%=slip.getListBorrowDocuments() !=null ?
                                                            slip.getListBorrowDocuments().length : 0%>
                                                    </td>
                                                </tr>
                                                <% } } else { %>
                                                    <tr>
                                                        <td colspan="4" style="text-align: center; padding: 20px;">
                                                            No data found.</td>
                                                    </tr>
                                                    <% } %>
                                        </tbody>
                                    </table>

                                    <div class="pagination" id="pagination">
                                        <span class="page-info" id="pageInfo"></span>
                                    </div>

                                    <script>
                                        // Phân trang bảng
                                        window.addEventListener('DOMContentLoaded', function () {
                                            const rowsPerPage = 8;
                                            const table = document.getElementById('docTable');
                                            const tbody = table.querySelector('tbody');
                                            const rows = Array.from(tbody.querySelectorAll('tr'));
                                            const paginationDiv = document.getElementById('pagination');
                                            const pageInfo = document.getElementById('pageInfo');

                                            // Kiểm tra nếu có dòng "Không có dữ liệu" thì không cần pagination
                                            if (rows.length === 1 && rows[0].querySelector('td[colspan]')) {
                                                pageInfo.textContent = '';
                                                return;
                                            }

                                            const totalPages = Math.ceil(rows.length / rowsPerPage);
                                            let currentPage = 1;

                                            function showPage(page) {
                                                currentPage = page;
                                                const start = (page - 1) * rowsPerPage;
                                                const end = start + rowsPerPage;
                                                rows.forEach((row, idx) => {
                                                    row.style.display = (idx >= start && idx < end) ? '' : 'none';
                                                });
                                                renderPagination();
                                            }

                                            function renderPagination() {
                                                paginationDiv.querySelectorAll('button').forEach(btn => btn.remove());
                                                if (totalPages > 1) {
                                                    for (let i = 1; i <= totalPages; i++) {
                                                        const btn = document.createElement('button');
                                                        btn.textContent = i;
                                                        if (i === currentPage) btn.classList.add('active');
                                                        btn.addEventListener('click', () => showPage(i));
                                                        paginationDiv.insertBefore(btn, pageInfo);
                                                    }
                                                }
                                            }

                                            // Chỉ áp dụng pagination nếu có nhiều hơn 8 rows
                                            if (totalPages > 1) {
                                                showPage(1);
                                            }
                                        });
                                    </script>
                    </body>

                    </html>