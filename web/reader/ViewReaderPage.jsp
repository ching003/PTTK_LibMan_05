<%-- Document : ViewReaderPageFrm Created on : Oct 21, 2025, 11:46:47 PM Author : Admin --%>

    <%@page import="model.*" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>

            <!DOCTYPE html>

            <head>
                <title>View Reader Page</title>
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

                    .content {
                        display: flex;
                        justify-content: center;
                        margin-top: 50px;
                    }

                    button {
                        padding: 15px 40px;
                        font-size: 18px;
                        background-color: #ff85a2;
                        color: white;
                        border: none;
                        border-radius: 8px;
                        cursor: pointer;
                        transition: background 0.3s ease;
                    }

                    button:hover {
                        background-color: #ff6b8a;
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

                    <div class="content">
                        <button
                            onclick="window.location.href='<%=request.getContextPath()%>/reader/ViewSearchDocument.jsp'">Search
                            Document</button>
                    </div>
            </body>

            </html>