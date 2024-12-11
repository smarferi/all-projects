from proxy.test import test_proxy
from proxy_scraper import get_turkey_proxies
from requests.exceptions import ProxyError, Timeout

def main():
    print("Fetching Turkish proxies...")
    proxies = get_turkey_proxies()
    
    if not proxies:
        print("No proxies found. Try again later.")
        return
    
    print(f"Found {len(proxies)} proxies. Testing them...")
    working_proxy = test_proxy(proxies)

    if working_proxy:
        print(f"Working proxy: {working_proxy}")
    else:
        print("No working proxies found.")
