const apiKey = 'b6eafef22e95f17b1204060608f629eb';
const lat = 41.6398;
const lon = 42.9864;

async function getWeather() {
    try {
        const apiUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric`;
        const response = await fetch(apiUrl);
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

        const data = await response.json();
        document.querySelector('.tempDisplay').textContent = `${data.main.temp}℃`;
        document.querySelector('.humidityDisplay').textContent = `Humidity: ${data.main.humidity}%`;
        document.querySelector('.descDisplay').textContent = data.weather[0].description;
        document.querySelector('.weatheremoji').textContent = getWeatherEmoji(data.weather[0].main);
    } catch (error) {
        console.error("Error fetching weather data:", error);
        document.querySelector('.tempDisplay').textContent = "Error loading data";
    }
}

function getWeatherEmoji(condition) {
    switch (condition) {
        case 'Clear': return '☀️';
        case 'Clouds': return '☁️';
        case 'Rain': return '🌧️';
        case 'Snow': return '❄️';
        default: return '🌈';
    }
}

getWeather();
