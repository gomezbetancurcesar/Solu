package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"> \r\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\">\r\n");
      out.write("<head id=\"Head1\"><title>Login</title>\r\n");
      out.write("    <link rel=\"icon\" href=\"images/logotipos/logo_solutel.ico\" type=\"image/vnd.microsoft.icon\" />\r\n");
      out.write("    <link rel=\"shortcut icon\" href=\"images/logotipos/logo_solutel.ico\" type=\"image/vnd.microsoft.icon\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"App_themes/css/template.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"App_themes/css/validationEngine.jquery.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/Desck.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/bootstrap.css\" type=\"text/css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/bootstrap-responsive.css\" type=\"text/css\" />\r\n");
      out.write("    <script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("    <script src=\"http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("    \r\n");
      out.write("    \r\n");
      out.write("    <link rel=\"stylesheet\" href=\"//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css\">\r\n");
      out.write("    <script src=\"//code.jquery.com/jquery-1.10.2.js\"></script>\r\n");
      out.write("    <script src=\"//code.jquery.com/ui/1.11.4/jquery-ui.js\"></script>\r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("     \r\n");
      out.write("        function validaLogin()\r\n");
      out.write("        {\r\n");
      out.write("            var rut = $(\"#tbUsuario\").val();\r\n");
      out.write("            var pass = $(\"#tbPassword\").val();\r\n");
      out.write("            var org = $(\"#tbOrgani\").val();\r\n");
      out.write("            if (rut === \"\" || rut === \"RUT USUARIO\")\r\n");
      out.write("            {\r\n");
      out.write("                alert(\"Favor ingrese un Rut de Usuario\");\r\n");
      out.write("                $(\"#tbUsuario\").focus();\r\n");
      out.write("                return false;\r\n");
      out.write("            }\r\n");
      out.write("            else if (pass === \"\" || pass === \"||||||||||||\")\r\n");
      out.write("            {\r\n");
      out.write("                alert(\"Favor ingrese una contraseña\");\r\n");
      out.write("                $(\"#tbPassword\").focus();\r\n");
      out.write("                return false;\r\n");
      out.write("            }\r\n");
      out.write("            else if (org === \"\")\r\n");
      out.write("            {\r\n");
      out.write("                alert(\"Favor ingrese una Base de Datos\");\r\n");
      out.write("                $(\"#tbOrgani\").focus();\r\n");
      out.write("                return false;\r\n");
      out.write("            }\r\n");
      out.write("            $.ajax(\r\n");
      out.write("            {\r\n");
      out.write("                url : 'ServletValidaLogin', \r\n");
      out.write("                data : \"rut=\"+rut+\"&pass=\"+pass+\"&org=\"+org,\r\n");
      out.write("                type : 'POST',\r\n");
      out.write("                dataType : \"html\",\r\n");
      out.write("                success : function(data)\r\n");
      out.write("                {\r\n");
      out.write("                    if (data === \"ok\")\r\n");
      out.write("                    {\r\n");
      out.write("                        window.location='index.jsp';\r\n");
      out.write("                    }else if (data === \"error login\")\r\n");
      out.write("                    {\r\n");
      out.write("                        alert(\"Usuario o contraseña incorrecto\");\r\n");
      out.write("                    }else{\r\n");
      out.write("                        alert(data);\r\n");
      out.write("                    }\r\n");
      out.write("                }\r\n");
      out.write("            });\r\n");
      out.write("        }\r\n");
      out.write("     \r\n");
      out.write("        $(document).ready(function ()\r\n");
      out.write("        {\r\n");
      out.write("            $(\".logines\").focus(function ()\r\n");
      out.write("            {\r\n");
      out.write("                if (this.value == this.defaultValue)\r\n");
      out.write("                {\r\n");
      out.write("                    this.value = \"\";\r\n");
      out.write("                }\r\n");
      out.write("            }).blur(function ()\r\n");
      out.write("            {\r\n");
      out.write("                if (!this.value.length)\r\n");
      out.write("                {\r\n");
      out.write("                    this.value = this.defaultValue;\r\n");
      out.write("                }\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("    </script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div id=\"dialog\" title=\"Basic dialog\">\r\n");
      out.write("</div>\r\n");
      out.write("    <table class= \"header\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td>\r\n");
      out.write("                <img align=\"left\" src=\"images\\logotipos\\logo_solutel.png\" width=\"180px\" height=\"100px\"/>\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td>\r\n");
      out.write("                <div id=\"PanelLogin\">\r\n");
      out.write("                    <div class=\"contenedor\">\r\n");
      out.write("                        <div class=\"loginAccesosContenidos\">\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <form action=\"\" name=\"frmLogin\" method=\"post\">\r\n");
      out.write("                            <div class=\"loginAccesos\">\r\n");
      out.write("                                <div class=\"P-Right section Bloque\">\r\n");
      out.write("                                    <h2 style=\"margin-top:0px; padding-top:0px;\">Acceso Usuarios</h2>\r\n");
      out.write("                                    <input name=\"tbUsuario\" maxlength=\"11\" type=\"text\" id=\"tbUsuario\" class=\"validate[required] logines\" value=\"RUT USUARIO\" style=\"width:95%;\" />\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <input name=\"tbOrgani\" maxlength=\"20\" type=\"text\" id=\"tbOrgani\" value=\"SOLUTEL\" style=\"width:95%;\" />\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <input name=\"tbPassword\" maxlength=\"10\" type=\"password\" id=\"tbPassword\" class=\"validate[required] logines\"  value=\"||||||||||||\" style=\"width:95%;\" />\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <span id=\"lblnoexiste\" style=\"color:Red;\"></span>\t\r\n");
      out.write("                                    <br />\r\n");
      out.write("                                    <input name=\"btnLogin\" type=\"button\" id=\"btnLogin\" onclick=\"validaLogin()\" value=\"Ingresar\" class=\"BotonIngresar\"/>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <br />\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </form>\r\n");
      out.write("                        <div style=\"width:100%; clear:left; background-color:#f2f2f2;\">\r\n");
      out.write("                            <div style=\"width:800px; background-position: center top; margin: 0 auto; padding:10px;\">\r\n");
      out.write("                                <b>Contáctenos</b>\r\n");
      out.write("                                <br />\r\n");
      out.write("                                <b>Dirección: </b> General Bari 144, Providencia, Chile\r\n");
      out.write("                                <b>Teléfono central:</b> 24841200\r\n");
      out.write("                                <b>Mail</b>: <a href=\"mailto:solutel@solutel.com \">solutel@solutel.com</a>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <br />\r\n");
      out.write("                        <br />\r\n");
      out.write("                        <br />\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("    ");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
