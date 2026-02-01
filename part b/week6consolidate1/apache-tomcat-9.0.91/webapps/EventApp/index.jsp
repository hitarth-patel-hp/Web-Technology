<!DOCTYPE html>
<html>
<head>
    <title>Event Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
            padding: 40px;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
        }

        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #999;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
        }

        button {
            width: 100%;
            padding: 12px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        .events-list {
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid #f0f0f0;
        }

        .events-list h2 {
            color: #333;
            font-size: 18px;
            margin-bottom: 15px;
        }

        .event-item {
            background: #f9f9f9;
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 10px;
            border-left: 4px solid #667eea;
            color: #555;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: none;
            border: 1px solid #c3e6cb;
        }

        .success-message.show {
            display: block;
        }

        .loading {
            display: none;
            text-align: center;
            color: #53619c;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h1>Event Manager</h1>
        <p class="subtitle">Create and manage your events effortlessly</p>
    </header>

    <div class="success-message" id="successMsg"></div>

    <form id="eventForm">
        <div class="form-group">
            <label for="title">Event Title</label>
            <input type="text" name="title" id="title" placeholder="Enter event title..." required>
        </div>
        <button type="submit">
            <span>+ Add Event</span>
            <span class="loading" id="loading">Adding...</span>
        </button>
    </form>

    <div class="events-list" id="eventsList" style="display: none;">
        <h2> Recent Events</h2>
        <div id="eventsContainer"></div>
    </div>
</div>

<script>
let events = [];

document.getElementById("eventForm").addEventListener("submit", function(e){
    e.preventDefault();

    const title = document.getElementById("title").value.trim();
    const loading = document.getElementById("loading");
    const successMsg = document.getElementById("successMsg");

    if(title === ""){
        alert("Please enter an event title!");
        return;
    }

    loading.style.display = "inline";

    fetch("addevent", {
        method: "POST",
        body: new FormData(this)
    })
    .then(response => response.text())
    .then(data => {
        loading.style.display = "none";
        
        // Show success message
        successMsg.textContent = data;
        successMsg.classList.add("show");
        
        // Add to events list
        events.unshift(title);
        updateEventsList();
        
        // Clear form
        document.getElementById("title").value = "";
        
        // Hide success message after 3 seconds
        setTimeout(() => {
            successMsg.classList.remove("show");
        }, 3000);
    })
    .catch(error => {
        loading.style.display = "none";
        alert("Error: " + error);
    });
});

function updateEventsList() {
    const eventsList = document.getElementById("eventsList");
    const eventsContainer = document.getElementById("eventsContainer");
    
    if(events.length > 0) {
        eventsList.style.display = "block";
        eventsContainer.innerHTML = events.map((event, index) => 
            `<div class="event-item">${index + 1}. ${event}</div>`
        ).join("");
    }
}
</script>

</body>
</html>
