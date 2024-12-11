import requests
import random

def test_proxy(proxies):
    for proxy in proxies:
        proxies_dict = {
            "http": f"http://{proxy}",
            "https": f"http://{proxy}"
        }
        try:
            # Use the proxy to check your IP location
            response = requests.get("https://ipinfo.io", proxies=proxies_dict, timeout=5)
            if response.status_code == 200:
                print(f"Proxy {proxy} is working!")
                print("Response:", response.json())
                return proxy  # Return the first working proxy
        except Exception as e:
            print(f"Proxy {proxy} failed:", e)
    return None
