<%@page import="java.util.ArrayList" %>
    <%@page import="model.*" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="UTF-8">
                <title>Search Document</title>
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
                        font-size: 28px;
                        color: #777;
                        margin: 15px 0;
                        font-weight: bold;
                    }

                    .search-form {
                        display: flex;
                        justify-content: center;
                        margin-bottom: 20px;
                    }

                    .search-form input[type="text"] {
                        width: 250px;
                        padding: 8px;
                        font-size: 14px;
                        border: 1px solid #ccc;
                        border-radius: 6px 0 0 6px;
                        outline: none;
                    }

                    .search-form button {
                        padding: 8px 16px;
                        font-size: 14px;
                        border: none;
                        background-color: #ff85a2;
                        color: white;
                        border-radius: 0 6px 6px 0;
                        cursor: pointer;
                        transition: background 0.3s ease;
                    }

                    .search-form button:hover {
                        background-color: #ff6b8a;
                    }

                    table {
                        width: 50%;
                        margin: 0 auto 10px auto;
                        border-collapse: collapse;
                        background-color: white;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }

                    caption {
                        caption-side: top;
                        font-weight: bold;
                        font-size: 18px;
                        color: #777;
                        padding: 10px;
                        text-align: left;
                    }

                    th,
                    td {
                        padding: 6px 8px;
                        text-align: left;
                        border: 1px solid #ccc;
                    }

                    th:first-child,
                    td:first-child {
                        width: 40px;
                        text-align: center;
                        padding: 4px;
                    }

                    th:nth-child(2),
                    td:nth-child(2) {
                        width: 60px;
                        /* cột mã ngắn hơn */
                        text-align: center;
                    }

                    th {
                        background-color: #ffb6c1;
                        color: white;
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
                <% User reader=(User)session.getAttribute("reader"); if(reader==null){
                    response.sendRedirect(request.getContextPath() + "/user/Login.jsp?err=timeout" ); return; } %>
                    <header>
                        <div>LibMan – Library Management System</div>
                        <div>Hello reader, <%=reader.getName()%>
                        </div>
                    </header>

                    <div class="module-name">
                        Search Document
                    </div>

                    <div class="search-form">
                        <form action="${pageContext.request.contextPath}/DocumentServlet" method="get">
                            <input type="text" name="docName" placeholder="Input document name...">
                            <button type="submit">Search</button>
                        </form>
                    </div>
                    <% ArrayList<Document> listDocuments = (ArrayList<Document>) request.getAttribute("listDocuments");
                            String keyword = request.getParameter("docName");
                            %>
                            <table id="docTable">
                                <caption>Search Document Table
                                    <% if (listDocuments !=null) { int count=listDocuments.size(); if (keyword !=null &&
                                        !keyword.trim().isEmpty()) { %>
                                        <span style="font-weight: normal; font-size: 14px; color: #555;">
                                            – Found <%= count %> results with keyword "<%= keyword %>"
                                        </span>
                                        <% } else { %>
                                            <span style="font-weight: normal; font-size: 14px; color: #555;">
                                                – Found <%= count %> results
                                            </span>
                                            <% } } %>
                                </caption>
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>ID</th>
                                        <th>Document Name</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% if(listDocuments !=null && !listDocuments.isEmpty()) { for(int i=0;
                                        i<listDocuments.size(); i++) { Document doc=listDocuments.get(i); %>
                                        <tr class="clickable-row"
                                            onclick="window.location.href='<%=request.getContextPath()%>/reader/ViewDetailDocument.jsp?id=<%=doc.getId()%>'">
                                            <td>
                                                <%=i+1%>
                                            </td>
                                            <td>
                                                <%=doc.getId()%>
                                            </td>
                                            <td>
                                                <%=doc.getName()%>
                                            </td>
                                        </tr>
                                        <% } } %>
                                </tbody>
                            </table>

                            <div class="pagination" id="pagination">
                                <span class="page-info" id="pageInfo"></span>
                            </div>

                            <script>
                                window.addEventListener('DOMContentLoaded', function () {
                                    const table = document.getElementById('docTable');
                                    const tbody = table.querySelector('tbody');
                                    const rows = Array.from(tbody.querySelectorAll('tr'));
                                    const paginationDiv = document.getElementById('pagination');
                                    const pageInfo = document.getElementById('pageInfo');

                                    // Kiểm tra nếu có dòng "Không tìm thấy kết quả" thì không cần pagination
                                    if (rows.length === 1 && rows[0].querySelector('td[colspan]')) {
                                        pageInfo.textContent = '';
                                        return;
                                    }
                                    // Tạm thời hiển thị tất cả rows để debug
                                    rows.forEach((row, idx) => {
                                        row.style.display = '';
                                    });

                                    const rowsPerPage = 8;
                                    const totalPages = Math.ceil(rows.length / rowsPerPage);
                                    let currentPage = 1;

                                    console.log('SearchDocumentFrm - Total pages:', totalPages);

                                    function showPage(page) {
                                        currentPage = page;
                                        const start = (page - 1) * rowsPerPage;
                                        const end = start + rowsPerPage;
                                        rows.forEach((row, idx) => {
                                            // Bỏ qua dòng header nếu có
                                            if (row.querySelector('th')) {
                                                row.style.display = '';
                                                return;
                                            }
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