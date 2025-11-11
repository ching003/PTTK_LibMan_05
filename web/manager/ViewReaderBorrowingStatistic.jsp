<%@page import="model.User" %>
    <%@page import="model.ReaderStatistic" %>
        <%@page import="java.util.ArrayList" %>
            <%@page import="java.text.SimpleDateFormat" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
                        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
                        <title>View Reader Borrowing Statistic</title>
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
                                margin: 15px 0;
                                font-weight: bold;
                            }

                            .filter-form {
                                display: flex;
                                justify-content: center;
                                align-items: center;
                                gap: 15px;
                                margin-bottom: 25px;
                            }

                            .filter-form label {
                                font-weight: 600;
                            }

                            .filter-form input[type="text"] {
                                padding: 6px 10px;
                                border: 1px solid #ccc;
                                border-radius: 6px;
                                font-size: 14px;
                                width: 130px;
                            }

                            .filter-form button {
                                padding: 6px 16px;
                                font-size: 14px;
                                background-color: #ffe6f0;
                                border: none;
                                color: black;
                                font-weight: 600;
                                border-radius: 4px;
                                cursor: pointer;
                                transition: background 0.3s ease;
                            }

                            .filter-form button:hover {
                                background-color: #87cefa;
                            }

                            table {
                                width: 60%;
                                margin: 0 auto 30px auto;
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
                                width: 150px;
                            }

                            th:nth-child(4),
                            td:nth-child(4) {
                                width: 120px;
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
                            ArrayList<ReaderStatistic> readerStatisticList = (ArrayList<ReaderStatistic>)
                                request.getAttribute("readerStatisticList");
                                if (readerStatisticList == null) {
                                readerStatisticList = new ArrayList<ReaderStatistic>();
                                    }
                                    String startDay = (String) request.getAttribute("startDay");
                                    if (startDay == null || startDay.isEmpty()) {
                                    startDay = request.getParameter("startDay");
                                    }
                                    String endDay = (String) request.getAttribute("endDay");
                                    if (endDay == null || endDay.isEmpty()) {
                                    endDay = request.getParameter("endDay");
                                    }
                                    %>
                                    <header>
                                        <div>LibMan – Library Management System</div>
                                        <div>Hello manager, <strong>
                                                <%=manager.getName()%>
                                            </strong></div>
                                    </header>

                                    <div class="module-name">
                                        View Reader Borrowing Statistic
                                    </div>

                                    <form action="${pageContext.request.contextPath}/ReaderStatisticServlet"
                                        method="get" class="filter-form">
                                        <label for="startDay">Start Day</label>
                                        <input type="text" id="startDay" name="startDay" placeholder="dd/MM/yyyy"
                                            value="<%= startDay != null ? startDay : "" %>">
                                        <label for="endDay">End Day</label>
                                        <input type="text" id="endDay" name="endDay" placeholder="dd/MM/yyyy"
                                            value="<%= endDay != null ? endDay : "" %>">
                                        <button type="submit">Show</button>
                                    </form>
                                    <table id="docTable">
                                        <caption>Reader Borrowing Statistic Table
                                            <% if (!readerStatisticList.isEmpty() && startDay !=null && endDay !=null) {
                                                %>
                                                <span style="font-weight: normal; font-size: 14px; color: #555;">
                                                    – Display <%= readerStatisticList.size() %> results from day "
                                                        <%= startDay %>" to day "<%= endDay %>"
                                                </span>
                                                <% } %>
                                        </caption>
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>CardID</th>
                                                <th>Name</th>
                                                <th>Number of times borrowed</th>
                                                <th>Total number of documents borrowed</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% int
                                                stt=1; for (ReaderStatistic rs : readerStatisticList) { %>
                                                <tr style="cursor: pointer;"
                                                    onclick="window.location.href='<%=request.getContextPath()%>/manager/ViewReaderBorrowingDetail.jsp?readerId=<%=rs.getId()%>'">

                                                    <td>
                                                        <%=stt++%>
                                                    </td>
                                                    <td>
                                                        <%=rs.getLibraryCard().getId()%>
                                                    </td>
                                                    <td>
                                                        <%=rs.getName() !=null ? rs.getName() : "" %>
                                                    </td>
                                                    <td>
                                                        <%=rs.getCount()%>
                                                    </td>
                                                    <td>
                                                        <%=rs.getTotalBorrowedDocuments()%>
                                                    </td>
                                                </tr>
                                                <% } %>
           
                                        </tbody>
                                    </table>

                                    <div class="pagination" id="pagination">
                                        <span class="page-info" id="pageInfo"></span>
                                    </div>

                                    <script>
                                        // -----------------------------
                                        // Định dạng ngày dd/mm/yyyy khi nhập
                                        // -----------------------------
                                        function formatDateInput(input) {
                                            input.addEventListener('input', function (e) {
                                                let v = this.value.replace(/[^0-9]/g, '');
                                                if (v.length >= 3 && v.length <= 4) v = v.slice(0, 2) + '/' + v.slice(2);
                                                else if (v.length > 4) v = v.slice(0, 2) + '/' + v.slice(2, 4) + '/' + v.slice(4, 8);
                                                this.value = v.slice(0, 10);
                                            });
                                        }

                                        formatDateInput(document.getElementById('startDay'));
                                        formatDateInput(document.getElementById('endDay'));

                                        // Phân trang bảng
                                        window.addEventListener('DOMContentLoaded', function () {
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

                                            // Tạm thời hiển thị tất cả rows
                                            rows.forEach((row, idx) => {
                                                row.style.display = '';
                                            });

                                            const rowsPerPage = 8;
                                            const totalPages = Math.ceil(rows.length / rowsPerPage);
                                            let currentPage = 1;

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
                                    <script>
                                        // Khởi tạo Flatpickr cho 2 ô ngày
                                        const startPicker = flatpickr("#startDay", {
                                            dateFormat: "d/m/Y", // hiển thị dd/MM/yyyy
                                            allowInput: true,
                                            altInput: true,
                                            altFormat: "d/m/Y",
                                            locale: { firstDayOfWeek: 1 }
                                        });

                                        const endPicker = flatpickr("#endDay", {
                                            dateFormat: "d/m/Y",
                                            allowInput: true,
                                            altInput: true,
                                            altFormat: "d/m/Y",
                                            locale: { firstDayOfWeek: 1 }
                                        });

                                        // Khi submit form: kiểm tra ngày
                                        document.querySelector('.filter-form').addEventListener('submit', function (e) {
                                            const startValue = document.getElementById('startDay').value;
                                            const endValue = document.getElementById('endDay').value;

                                            if (!startValue || !endValue) {
                                                e.preventDefault();
                                                alert("Vui lòng chọn đầy đủ ngày bắt đầu và ngày kết thúc!");
                                                return;
                                            }

                                            // Chuyển "dd/MM/yyyy" → Date
                                            const [d1, m1, y1] = startValue.split("/").map(Number);
                                            const [d2, m2, y2] = endValue.split("/").map(Number);
                                            const startDate = new Date(y1, m1 - 1, d1);
                                            const endDate = new Date(y2, m2 - 1, d2);

                                            // So sánh
                                            if (startDate > endDate) {
                                                e.preventDefault();
                                                alert("Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc!");
                                                return;
                                            }

                                        });
                                    </script>

                    </body>

                    </html>