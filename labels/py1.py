import tkinter as tk

class Page1(tk.Tk):
    def __init__(self):
        super().__init__()  
        self.geometry("1920x1080")
        self.title("Seller Information")

        label = tk.Label(self, text="სახელი", fg="black", font=("Arial", 70))
        label.pack(pady=20)

        self.seller_name = tk.Entry(self, font=("Arial", 50), width=30)
        self.seller_name.pack(pady=20)

        next_page = tk.Button(self, font=("Arial", 50), width=20, text="შემდეგი გვერდი", command=self.open_page_2)
        next_page.pack(pady=20)

    def open_page_2(self):
        # Get entered text from Page1's Entry widget
        entered_text = self.seller_name.get()

        # Close Page1 and open Page2, passing the entered text
        self.destroy()
        page_2 = Page2(entered_text)  
        page_2.mainloop()


class Page2(tk.Tk):
    def __init__(self, entered_text):
        super().__init__()  
        self.geometry("1920x1080")
        self.title("Date")

        label2 = tk.Label(self, text="ჩაწერეთ თვე", fg="black", font=("Arial", 70))
        label2.pack(pady=20)
        
        self.date = tk.Entry(self, font=("Arial", 50), width=30)
        self.date.pack(pady=20)
        
        next_page2 = tk.Button(self, font=("Arial", 50), width=20, text="შემდეგი გვერდი", command=self.open_page_3)
        next_page2.pack(pady=20)

        # Store the entered text from Page1
        self.entered_text_from_page1 = entered_text

    def open_page_3(self):
        # Get entered text from Page2's Entry widget
        entered_date = self.date.get()

        # Pass both the seller name (from Page1) and the date (from Page2) to Page3
        self.destroy()
        page_3 = Page3(self.entered_text_from_page1, entered_date)  
        page_3.mainloop()


class Page3(tk.Tk):
    def __init__(self, entered_text_from_page1, entered_date):
        super().__init__()
        self.geometry("1920x1080")
        self.title("Main")

        # Display the seller's name from Page1 and the date from Page2
        label1 = tk.Label(self, text=f"გამყიდველის სახელი: {entered_text_from_page1}", fg="black", font=("Arial", 50))
        label1.pack(pady=20)

        label2 = tk.Label(self, text=f"თვე და რიცხვი: {entered_date}", fg="black", font=("Arial", 50))
        label2.pack(pady=20)
        self.producte = tk.Entry(self, font=("Arial", 50), width=30)
        self.producte.pack(pady=20)


if __name__ == "__main__":
    page_1 = Page1()  # Create an instance of Page1
    page_1.mainloop()  # Start the Tkinter main event loop
