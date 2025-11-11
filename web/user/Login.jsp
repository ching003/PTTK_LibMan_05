<%-- Document : Login Created on : Nov 5, 2025, 12:00:01 AM Author : Admin --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>LibMan - Login</title>
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
                    text-align: center;
                    padding: 10px 20px;
                    font-size: 20px;
                    font-weight: bold;
                    letter-spacing: 1px;
                }

                .login-container {
                    width: 380px;
                    background: white;
                    margin: 80px auto;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
                }

                h2 {
                    text-align: center;
                    color: #d14782;
                    margin-bottom: 25px;
                }

                label {
                    display: block;
                    margin-bottom: 6px;
                    font-weight: bold;
                    color: #555;
                }

                .required {
                    color: red;
                    margin-left: 4px;
                }

                input[type="text"],
                input[type="password"] {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid #ccc;
                    border-radius: 6px;
                    margin-bottom: 18px;
                    font-size: 14px;
                    transition: border 0.3s ease;
                }

                input[type="text"]:focus,
                input[type="password"]:focus {
                    border: 1px solid #ff6699;
                    outline: none;
                }

                button {
                    width: 100%;
                    background-color: #ff85a2;
                    color: white;
                    border: none;
                    padding: 10px;
                    font-size: 16px;
                    border-radius: 6px;
                    cursor: pointer;
                    transition: background 0.3s ease;
                }

                button:hover {
                    background-color: #ff6b8a;
                }

                .footer {
                    text-align: center;
                    margin-top: 20px;
                    color: #777;
                    font-size: 13px;
                }

                .error {
                    color: #e60073;
                    background-color: #ffe6f0;
                    border-radius: 6px;
                    text-align: center;
                    padding: 8px;
                    margin-top: 15px;
                    font-weight: bold;
                }
            </style>
        </head>

        <body>
            <header>
                LibMan – Library Management System
            </header>
            <div class="login-container">
                <h2>Login</h2>
                <form action="${pageContext.request.contextPath}/UserServlet" method="post">
                    <label for="username">Username<span class="required">*</span></label>
                    <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required
                        title="Please enter username">

                    <label for="password">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required
                        title="Please enter password">

                    <button type="submit">Login</button>
                </form>
                <% if(request.getParameter("err") !=null && request.getParameter("err").equalsIgnoreCase("timeout")){ %>
                    <p style="color:red; text-align:center;">Hết phiên làm việc. Làm ơn đăng nhập lại!</p>
                    <% }else if(request.getParameter("err") !=null &&
                        request.getParameter("err").equalsIgnoreCase("fail")){ %>
                        <p style="color:red; text-align:center;">Sai tên đăng nhập/mật khẩu!</p>
                        <% } %>

                            <div class="footer">
                                © 2025 LibMan - PTIT
                            </div>
            </div>
        </body>

        </html>