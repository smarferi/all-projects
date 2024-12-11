import requests
from bs4 import BeautifulSoup

def get_turkey_proxies():
    # URL of the free proxy list
    url = "https://spys.one/free-proxy-list/TR/"
    
    # Headers to mimic a browser request
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }

    # Fetch the webpage content
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.text, "html.parser")
    
    proxies = []
    # Parse proxies (customize according to the website structure)
    for row in soup.find_all("tr", class_="spy1xx"):
        try:
            # Extract the IP:Port format
            ip_port = row.find_all("td")[0].text.strip()
            proxies.append(ip_port)
        except Exception as e:
            continue

    return proxies
