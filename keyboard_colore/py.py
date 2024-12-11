import usb.core
import usb.util

# Replace with your keyboard's VID and PID
VENDOR_ID = 0x1A2C
PRODUCT_ID = 0x99F4

# RGB command to set the keyboard to white (may vary, adjust as needed)
RGB_WHITE_COMMAND = [0x00, 0xFF, 0xFF, 0xFF]  # This is an example command

def main():
    # Find the device
    dev = usb.core.find(idVendor=VENDOR_ID, idProduct=PRODUCT_ID)

    if dev is None:
        print("Keyboard not found. Check the VID and PID.")
        return

    # Detach the kernel driver if needed
    if dev.is_kernel_driver_active(0):
        dev.detach_kernel_driver(0)

    # Set configuration
    dev.set_configuration()

    # Attempt to send the RGB command
    try:
        # Send the command to the first endpoint (may need adjustment)
        dev.write(1, RGB_WHITE_COMMAND)
        print("RGB set to white!")
    except Exception as e:
        print(f"Error sending command: {e}")

if __name__ == "__main__":
    main()
