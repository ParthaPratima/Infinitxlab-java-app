<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String course = request.getParameter("name");

    String title = "Course Not Found";
    String description = "No course details available.";
    String video = "";
    String bgImage = "";

    if(course != null){

        if(course.equals("aws")){
            title = "AWS Cloud";
            description = "Learn EC2, IAM, VPC, S3, Auto Scaling, CloudWatch and real-time deployments.";
            video = "https://www.youtube.com/embed/TLf5OASKf18";
            bgImage = "https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=1600";
        }

        else if(course.equals("docker")){
            title = "Docker";
            description = "Learn Dockerfile, Images, Containers, Docker Compose and container deployments.";
            video = "https://www.youtube.com/embed/H8Lyj2D_cWo";
            bgImage = "https://images.unsplash.com/photo-1605745341112-85968b19335b?q=80&w=1600";
        }

        else if(course.equals("kubernetes")){
            title = "Kubernetes";
            description = "Learn Pods, Services, Deployments, Ingress, Helm and production Kubernetes.";
            video = "https://www.youtube.com/embed/YkJDFy6F5oM";
            bgImage = "https://images.unsplash.com/photo-1667372393119-3d4c48d07fc9?q=80&w=1600";
        }

        else if(course.equals("jenkins")){
            title = "Jenkins";
            description = "Learn Jenkins pipelines, CI/CD automation and deployment workflows.";
            video = "https://www.youtube.com/embed/FX322RVNGj4";
            bgImage = "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=1600";
        }

        else if(course.equals("terraform")){
            title = "Terraform";
            description = "Learn Infrastructure as Code using Terraform with AWS.";
            video = "https://www.youtube.com/embed/SLB_c_ayRMo";
            bgImage = "https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1600";
        }

        else if(course.equals("git")){
            title = "Git";
            description = "Learn version control, branching, merging and Git workflows.";
            video = "https://www.youtube.com/embed/apGV9Kg7ics";
            bgImage = "https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=1600";
        }

        else if(course.equals("github")){
            title = "GitHub";
            description = "Learn repositories, pull requests, GitHub Actions and collaboration.";
            video = "https://www.youtube.com/embed/w3jLJU7DT5E";
            bgImage = "https://images.unsplash.com/photo-1618401471353-b98afee0b2eb?q=80&w=1600";
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

<title><%= title %></title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial;
}

body{
    background:#020617;
    color:white;
    min-height:100vh;
    position:relative;
    overflow-x:hidden;
}

/* Background Image */

.bg{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:url('<%= bgImage %>');
    background-size:cover;
    background-position:center;
    opacity:0.12;
    z-index:-1;
}

/* Main Container */

.container{
    width:90%;
    max-width:1300px;
    margin:50px auto;
    display:flex;
    gap:40px;
    align-items:center;
    justify-content:space-between;
    flex-wrap:wrap;
}

/* Left */

.left{
    flex:1;
    min-width:350px;
}

.left h1{
    font-size:55px;
    color:#38bdf8;
    margin-bottom:25px;
}

.left p{
    color:#cbd5e1;
    line-height:1.9;
    font-size:18px;
    margin-bottom:30px;
}

/* Features */

.features{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    margin-top:30px;
}

.feature-card{
    background:rgba(15,23,42,0.7);
    border:1px solid rgba(255,255,255,0.08);
    padding:25px;
    border-radius:18px;
    backdrop-filter:blur(12px);
    transition:0.3s;
}

.feature-card:hover{
    transform:translateY(-8px);
    border:1px solid #38bdf8;
}

.feature-card h3{
    color:#38bdf8;
    margin-bottom:12px;
}

/* Right */

.right{
    flex:1;
    min-width:350px;
    display:flex;
    justify-content:center;
}

/* Video Box */

.video-box{
    width:100%;
    max-width:550px;
    background:rgba(15,23,42,0.7);
    border-radius:25px;
    padding:20px;
    backdrop-filter:blur(15px);
    border:1px solid rgba(255,255,255,0.08);
    box-shadow:0px 10px 40px rgba(0,0,0,0.5);
}

.video-box iframe{
    width:100%;
    height:320px;
    border:none;
    border-radius:20px;
}

/* Button */

.btn{
    display:inline-block;
    margin-top:40px;
    background:linear-gradient(90deg,#2563eb,#38bdf8);
    color:white;
    padding:14px 24px;
    text-decoration:none;
    border-radius:12px;
    font-weight:bold;
    transition:0.3s;
}

.btn:hover{
    transform:translateY(-4px);
}

/* Responsive */

@media(max-width:900px){

    .container{
        flex-direction:column;
    }

    .left h1{
        font-size:40px;
    }

    .video-box iframe{
        height:250px;
    }
}

</style>

</head>

<body>

<div class="bg"></div>

<div class="container">

    <!-- LEFT -->

    <div class="left">

        <h1><%= title %></h1>

        <p><%= description %></p>

        <div class="features">

            <div class="feature-card">
                <h3>Live Classes</h3>
                <p>Interactive real-time training sessions.</p>
            </div>

            <div class="feature-card">
                <h3>Projects</h3>
                <p>Hands-on industry level projects.</p>
            </div>

            <div class="feature-card">
                <h3>Recordings</h3>
                <p>Lifetime access to class recordings.</p>
            </div>

            <div class="feature-card">
                <h3>Interview Prep</h3>
                <p>Resume, mock interviews and guidance.</p>
            </div>

        </div>

        <a href="success.jsp" class="btn">⬅ Back To Dashboard</a>

    </div>

    <!-- RIGHT -->

    <div class="right">

        <div class="video-box">

            <iframe
                src="<%= video %>"
                allowfullscreen>
            </iframe>

        </div>

    </div>

</div>

</body>
</html>