
import serial
import matplotlib.pyplot as plt
import time
import numpy as np

# Configure the serial port
port = '/dev/cu.usbserial-0001'  # Change this to match your ESP32's port
baud_rate = 115200

# Data storage
timestamps = []
moisture_values = []

# Setup the plot
plt.figure(figsize=(10, 6))
plt.ion()  # Interactive mode on
plt.xlabel('Time (seconds)')
plt.ylabel('Moisture Value')
plt.title('Soil Moisture Sensor Readings')
plt.grid(True)

# Start time reference
start_time = time.time()

try:
    # Open the serial port
    ser = serial.Serial(port, baud_rate,-1)
    print(f"Connected to {port} at {baud_rate} baud")
    
    # Create empty line
    line, = plt.plot([], [], 'b-')
    
    while True:
        if ser.in_waiting > 0:
            # Read a line from serial
            serial_data = ser.readline().decode('utf-8').strip()
            
            try:
                # Parse just the moisture value (no timestamp)
                moisture_value = float(serial_data)
                
                # Calculate elapsed time
                current_time = time.time() - start_time
                
                # Add to our data arrays
                timestamps.append(current_time)
                moisture_values.append(moisture_value)
                
                # Update the plot
                line.set_xdata(timestamps)
                line.set_ydata(moisture_values)
                plt.xlim(min(timestamps), max(timestamps))
                plt.ylim(0, 4100)  # Assuming 12-bit ADC (0-4095)
                
                # Redraw the plot
                plt.draw()
                plt.pause(0.01)
            
            except ValueError:
                print(f"Could not parse data: {serial_data}")
                continue
                
except KeyboardInterrupt:
    print("\nExiting...")
except serial.SerialException as e:
    print(f"Error with serial port: {e}")
finally:
    # Close the serial port if it's open
    if 'ser' in locals() and ser.is_open:
        ser.close()
        print("Serial port closed")