
<%@ page import="java.net.http.HttpClient" %>
<%@ page import="java.net.http.HttpRequest" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.http.HttpResponse" %>
<%@ page import="io.github.cdimascio.dotenv.Dotenv" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="org.example.jsp_250311.model.GeminiResponse" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
    <style>
      @font-face {
        font-family: 'RixYeoljeongdo_Regular';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2102-01@1.0/RixYeoljeongdo_Regular.woff') format('woff');
        font-weight: normal;
        font-style: normal;
      }
      *{
        margin: 0;
        padding: 0;
        font-family: 'RixYeoljeongdo_Regular';
      }
      form{
        display: flex;
        justify-content: center;
        margin-top: 20px;
        width: 100%;
      }
      section{
        display: flex;
        justify-content: center;
        margin-top: 20px;
        width: 100%;
      }
      .title{
        margin-top: 250px;
      }

    </style>
</head>
<body>
    <%! HttpClient client = HttpClient.newHttpClient(); %>
    <%! Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load(); %>
    <%! ObjectMapper mapper = new ObjectMapper(); %>
    <%! String answer = ""; %>
    <%
      String prompt = request.getParameter("prompt");
      if (prompt == null || prompt.isBlank()) {
        prompt = "Please insert prompt";
        answer = "Please insert prompt";
      } else {
        prompt += " no markdown, under 300 character, use korean language, nutshell please";
        Map<String, List<Map<String, List<Map<String, String>>>>> geminiMap = new HashMap<>();
        List<Map<String, String>> parts = List.of(new HashMap<>());
        parts.get(0).put("text", prompt);
        List<Map<String, List<Map<String, String>>>> contents = List.of(new HashMap<>());
        contents.get(0).put("parts", parts);
        geminiMap.put("contents", contents);
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=%s".formatted(
                        dotenv.get("GEMINI_KEY")
                )))
                .POST(HttpRequest.BodyPublishers.ofString(
                        mapper.writeValueAsString(geminiMap)))
                .build();
        try {
          HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
          answer = mapper.readValue(httpResponse.body(), GeminiResponse.class).candidates().get(0).content().parts().get(0).text();
        } catch (Exception e) {
          answer = e.getMessage();
        }
      }
    %>
    <section class="title">
        Prompt : <%= request.getParameter("prompt") %>
    </section>
    <section>
      Answer : <%= answer %>
    </section>
    <form>
      <input name="prompt" placeholder="Input prompt">
      <button>submit</button>
    </form>
</body>
</html>
