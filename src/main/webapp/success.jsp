<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sess = request.getSession(false);
    String username = (sess != null) ? (String) sess.getAttribute("username") : null;

    if(username == null){
        username = "User";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>InfinitX Lab - Dashboard</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:"Segoe UI", Arial, sans-serif;
}

body{
    background: radial-gradient(circle at top left, #0b1a33, #050b17);
    color:white;
    overflow-x:hidden;
}

/* NAVBAR */

.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 60px;
    background:rgba(15,23,42,0.85);
    backdrop-filter:blur(12px);
    position:sticky;
    top:0;
    z-index:999;
    border-bottom:1px solid rgba(255,255,255,0.08);
}

.logo{
    display:flex;
    align-items:center;
    gap:12px;
}

.logo img{
    height:50px;
}

.logo h2{
    color:#38bdf8;
    font-size:22px;
}

.nav-links{
    display:flex;
    gap:30px;
    align-items:center;
}

.nav-links a{
    color:#e2e8f0;
    text-decoration:none;
    font-weight:600;
}

.nav-links a:hover{
    color:#38bdf8;
}

/* DROPDOWN */

.dropdown{
    position:relative;
}

.dropdown button{
    background:none;
    border:none;
    color:#e2e8f0;
    font-size:15px;
    cursor:pointer;
    font-weight:600;
}

.dropdown-content{
    display:none;
    position:absolute;
    top:40px;
    left:-50px;
    min-width:250px;
    background:#0f172a;
    border-radius:15px;
    padding:10px;
    box-shadow:0px 8px 25px rgba(0,0,0,0.6);
}

.dropdown-content a{
    display:block;
    padding:12px;
    border-radius:10px;
    color:#cbd5e1;
}

.dropdown-content a:hover{
    background:#1e293b;
    color:#38bdf8;
}

.dropdown:hover .dropdown-content{
    display:block;
}

/* USER AREA */

.user-area{
    display:flex;
    align-items:center;
    gap:15px;
}

.user-area span{
    color:#a5b4fc;
    font-weight:700;
}

.logout-btn{
    background:linear-gradient(90deg,#ef4444,#dc2626);
    border:none;
    padding:10px 18px;
    border-radius:12px;
    color:white;
    cursor:pointer;
    font-weight:bold;
}

/* HERO */

.hero{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:90px 70px;
    gap:40px;
}

.hero-left{
    max-width:650px;
}

.hero-left h1{
    font-size:56px;
    line-height:1.2;
}

.hero-left h1 span{
    color:#38bdf8;
}

.hero-left p{
    margin-top:20px;
    line-height:1.8;
    color:#cbd5e1;
}

.hero-buttons{
    margin-top:30px;
    display:flex;
    gap:15px;
}

.btn-primary{
    background:linear-gradient(90deg,#38bdf8,#2563eb);
    padding:14px 22px;
    border-radius:14px;
    color:white;
    text-decoration:none;
    font-weight:bold;
}

.btn-secondary{
    background:rgba(255,255,255,0.08);
    padding:14px 22px;
    border-radius:14px;
    color:white;
    text-decoration:none;
    border:1px solid rgba(255,255,255,0.1);
}

.hero-right img{
    width:350px;
    border-radius:20px;
}

/* SECTION */

.section{
    padding:80px 70px;
}

.section h2{
    text-align:center;
    font-size:38px;
    margin-bottom:40px;
}

.section h2 span{
    color:#38bdf8;
}

/* SEARCH */

.search-box{
    text-align:center;
    margin-bottom:40px;
}

.search-box input{
    width:350px;
    padding:15px;
    border:none;
    border-radius:12px;
    background:#1e293b;
    color:white;
    font-size:16px;
    outline:none;
}

/* COURSES */

.courses-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
}

.course-link{
    text-decoration:none;
    color:white;
}

.course-card{
    background:rgba(30,41,59,0.75);
    border:1px solid rgba(255,255,255,0.08);
    padding:28px;
    border-radius:22px;
    transition:0.3s;
}

.course-card:hover{
    transform:translateY(-10px);
    border:1px solid #38bdf8;
}

.course-card h3{
    color:#38bdf8;
    margin-bottom:12px;
}

.course-card p{
    color:#cbd5e1;
    line-height:1.7;
}

/* TRAINERS */

.trainers-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:25px;
}

.trainer-card{
    background:rgba(30,41,59,0.75);
    padding:30px;
    border-radius:22px;
    text-align:center;
}

.trainer-card img{
    height:110px;
    width:110px;
    border-radius:50%;
    border:4px solid #38bdf8;
    margin-bottom:15px;
}

/* INFO */

.info-box{
    background:rgba(30,41,59,0.75);
    padding:45px;
    border-radius:22px;
    max-width:950px;
    margin:auto;
    text-align:center;
    line-height:1.9;
    color:#cbd5e1;
}

.info-box a{
    color:#38bdf8;
}

/* FOOTER */

footer{
    margin-top:70px;
    background:#0f172a;
    text-align:center;
    padding:25px;
    color:#cbd5e1;
}

/* RESPONSIVE */

@media(max-width:900px){

    .hero{
        flex-direction:column;
        text-align:center;
    }

    .hero-left h1{
        font-size:42px;
    }

    .hero-right img{
        width:280px;
    }

    .navbar{
        padding:15px 20px;
    }

    .section{
        padding:60px 20px;
    }

    .search-box input{
        width:100%;
    }
}

</style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">
        <img src="InfinitX-img.png" alt="Logo">
        <h2>InfinitX Lab</h2>
    </div>

    <div class="nav-links">

        <a href="#about">About</a>
        <a href="#contact">Contact</a>

        <div class="dropdown">

            <button>Courses ▾</button>

            <div class="dropdown-content">

                <a href="course.jsp?name=aws">AWS Cloud</a>
                <a href="course.jsp?name=devops">DevOps</a>
                <a href="course.jsp?name=git">Git</a>
                <a href="course.jsp?name=github">GitHub</a>
                <a href="course.jsp?name=docker">Docker</a>
                <a href="course.jsp?name=kubernetes">Kubernetes</a>
                <a href="course.jsp?name=terraform">Terraform</a>
                <a href="course.jsp?name=jenkins">Jenkins</a>

            </div>

        </div>

    </div>

    <div class="user-area">

        <span>Welcome, <%= username %></span>

        <form action="logout.jsp">

            <button class="logout-btn">Logout</button>

        </form>

    </div>

</div>

<!-- HERO -->

<div class="hero">

    <div class="hero-left">

        <h1>
            Hi, <span><%= username %></span>
            <br>
            Welcome to <span>InfinitX Lab</span>
        </h1>

        <p style="color:#facc15; font-weight:600;">
            "We keep your hand infinitely — guiding you from learning to mastery."
        </p>

        <p>
            Your gateway to mastering Cloud, DevOps,
            Automation, Testing, Monitoring,
            Security Tools and AI/ML.
        </p>

        <div class="hero-buttons">

            <a href="#courses" class="btn-primary">
                Explore Courses
            </a>

            <a href="#trainers" class="btn-secondary">
                Meet Trainers
            </a>

        </div>

    </div>

    <div class="hero-right">

        <img src="InfinitX-img.png" alt="Banner">

    </div>

</div>

<!-- COURSES -->

<div class="section" id="courses">

    <h2>Our <span>Popular Courses</span></h2>

    <!-- SEARCH -->

    <div class="search-box">

        <input type="text"
               id="courseSearch"
               placeholder="Search courses...">

    </div>


 <div class="courses-grid">

    <a href="course.jsp?name=aws" class="course-link">
        <div class="course-card">
            <h3>AWS Cloud</h3>
            <p>EC2, S3, IAM, VPC, Auto Scaling, Load Balancer & Cloud deployments.</p>
        </div>
    </a>

    <a href="course.jsp?name=devops" class="course-link">
        <div class="course-card">
            <h3>DevOps Engineering</h3>
            <p>CI/CD pipelines, automation, deployments, production DevOps projects.</p>
        </div>
    </a>

    <a href="course.jsp?name=git" class="course-link">
        <div class="course-card">
            <h3>Git</h3>
            <p>Version control, branching, merging, rebasing, conflict resolution.</p>
        </div>
    </a>

    <a href="course.jsp?name=github" class="course-link">
        <div class="course-card">
            <h3>GitHub</h3>
            <p>Pull Requests, GitHub Actions, workflows, repositories & collaboration.</p>
        </div>
    </a>

    <a href="course.jsp?name=maven" class="course-link">
        <div class="course-card">
            <h3>Maven</h3>
            <p>Build lifecycle, packaging, dependencies and Java project automation.</p>
        </div>
    </a>

    <a href="course.jsp?name=nexus" class="course-link">
        <div class="course-card">
            <h3>Nexus</h3>
            <p>Artifact repository manager for Maven, Docker images and releases.</p>
        </div>
    </a>

    <a href="course.jsp?name=jenkins" class="course-link">
        <div class="course-card">
            <h3>Jenkins</h3>
            <p>Jenkinsfile, pipelines, CI/CD automation and production deployment.</p>
        </div>
    </a>

    <a href="course.jsp?name=ansible" class="course-link">
        <div class="course-card">
            <h3>Ansible</h3>
            <p>Playbooks, roles, automation scripts and configuration management.</p>
        </div>
    </a>

    <a href="course.jsp?name=docker" class="course-link">
        <div class="course-card">
            <h3>Docker</h3>
            <p>Dockerfile, images, containers, compose and real-time deployments.</p>
        </div>
    </a>

    <a href="course.jsp?name=kubernetes" class="course-link">
        <div class="course-card">
            <h3>Kubernetes</h3>
            <p>Pods, Deployments, Services, Ingress, Helm charts & scaling.</p>
        </div>
    </a>

    <a href="course.jsp?name=terraform" class="course-link">
        <div class="course-card">
            <h3>Terraform</h3>
            <p>Infrastructure as Code (IaC) with Terraform modules for AWS.</p>
        </div>
    </a>

    <a href="course.jsp?name=sonarqube" class="course-link">
        <div class="course-card">
            <h3>SonarQube</h3>
            <p>Code quality analysis, vulnerability scan and code review automation.</p>
        </div>
    </a>

    <a href="course.jsp?name=prometheus" class="course-link">
        <div class="course-card">
            <h3>Prometheus & Grafana</h3>
            <p>Monitoring, metrics, dashboards, alerting rules and exporters.</p>
        </div>
    </a>

    <a href="course.jsp?name=trivy" class="course-link">
        <div class="course-card">
            <h3>Trivy</h3>
            <p>Container vulnerability scanning, reports and security best practices.</p>
        </div>
    </a>

    <a href="course.jsp?name=gitops" class="course-link">
        <div class="course-card">
            <h3>GitOps</h3>
            <p>Modern deployments using Git-based automation and Kubernetes GitOps.</p>
        </div>
    </a>

    <a href="course.jsp?name=aiml" class="course-link">
        <div class="course-card">
            <h3>AI / ML</h3>
            <p>AI and Machine Learning fundamentals with practical industry approach.</p>
        </div>
    </a>

    <a href="course.jsp?name=java-testing" class="course-link">
        <div class="course-card">
            <h3>Java Testing</h3>
            <p>Manual + automation testing, test case writing, CI integration.</p>
        </div>
    </a>

    <a href="course.jsp?name=python-testing" class="course-link">
        <div class="course-card">
            <h3>Python Testing</h3>
            <p>Pytest, unit testing, automation testing and QA best practices.</p>
        </div>
    </a>

  </div>


</div>

<!-- RECORDINGS -->

<div class="section" id="recordings">

    <h2>Recorded <span>Classes</span></h2>

    <div class="courses-grid">

        <div class="course-card">

            <h3>DevOps Class 1</h3>

            <p>DevOps Introduction and Why DevOps demanding.</p>

            <br>

            <a href="https://drive.google.com/file/d/1S_wqpgklObpDhnDlHa54p8iPVEA8KHqB/view?usp=sharing"
               target="_blank"
               class="btn-primary">

               Watch Recording

            </a>

        </div>

        <div class="course-card">

            <h3>Docker Class 1</h3>

            <p>Docker installation and first container.</p>

            <br>

            <a href="https://drive.google.com/"
               target="_blank"
               class="btn-primary">

               Watch Recording

            </a>

        </div>

    </div>

</div>

<!-- TRAINERS -->

<div class="section" id="trainers">

    <h2>Meet Our <span>Trainers</span></h2>

    <div class="trainers-grid">

        <div class="trainer-card">
            <img src="soumya.png" alt="trainer1">
            <h3>Soumyajit Rout</h3>
            <p>Senior DevOps Engineer</p>
        </div>

        <div class="trainer-card">
            <img src="satya.png" alt="trainer2">
            <h3>Satyajit Rout</h3>
            <p>Senior Software Engineer</p>
        </div>

    </div>

</div>

<!-- ABOUT -->

<div class="section" id="about">

    <h2>About <span>InfinitX Lab</span></h2>

    <div class="info-box">

        InfinitX Lab provides hands-on Cloud,
        DevOps, Testing and AI/ML training with
        real-time projects and mentorship.

    </div>

</div>

<!-- CONTACT -->

<div class="section" id="contact">

    <h2>Contact <span>Us</span></h2>

    <div class="info-box">

        📞 Contact: 9337789240 <br>
        📧 Mail: infinitxlab@gmail.com <br>
        📸 Instagram: @infintx_lab

    </div>

</div>

<!-- FOOTER -->

<footer>

    © 2026 <strong>InfinitX Lab</strong>

</footer>

<!-- SEARCH SCRIPT -->

<script>

const searchInput = document.getElementById("courseSearch");

searchInput.addEventListener("keyup", function(){

    let filter = searchInput.value.toLowerCase();

    let cards = document.querySelectorAll(".course-card");

    cards.forEach(function(card){

        let text = card.innerText.toLowerCase();

        if(text.includes(filter)){
            card.parentElement.style.display = "block";
        }
        else{
            card.parentElement.style.display = "none";
        }

    });

});

</script>

</body>
</html>