import serial
import re
import time

serialPort = serial.Serial(port = "COM8", baudrate=9600, bytesize=8, timeout=2, stopbits=serial.STOPBITS_ONE, parity='N', xonxoff=0)

def sendData():
	print('\nA = ', A,' B = ', B,'OP = ', OP)

	#serialPort.write(operation)
	#A
	serialPort.write(b'\x05')
	#B
	serialPort.write(b'\x03')
	#OP
	serialPort.write(b'\x22')
	
	serialPort.flush()

	ser_bytes = serialPort.read(10)
	print(ser_bytes," - ", type(ser_bytes))
	print(int.from_bytes(ser_bytes,byteorder='little'))

	# Wait until there is data waiting in the serial buffer
	#if(serialPort.in_waiting > 0):
	    # Read data out of the buffer until a carraige return / new line is found
	#    serialString = serialPort.readline()
	#    print('\nRecieved: ', serialString)


operation_numbers = {}
operation_numbers["ADD"] = "100000"
operation_numbers["SUB"] = "100010"
operation_numbers["AND"] = "100100"
operation_numbers["OR"]  = "100101"
operation_numbers["XOR"] = "100110"
operation_numbers["SRA"] = "000011"
operation_numbers["SRL"] = "000010"
operation_numbers["NOR"] = "100111"


operation = ''
A = 0
B = 0
OP = 0

sendData()
#while(1):
#	print('\nEnter operation: ')
#	operation = input()
#	try:
#		OP = operation_numbers[operation]
#	except Exception as e:
#		keys = str(operation_numbers.keys())
#		keys = re.search("\B\[.+\B\]", keys).group()
#		print('\nInvalid Operation!\n\nValid operations are:\n', keys)
#	else:
#		print('\nEnter A: ')
#		A = input()
#		try:
#	   		A = int(A)
#	   		if (A > 128 or A < -127):
#	   			raise ValueError()
#		except ValueError:
#	   		print("\nInvalid Number!\n\nNumbers Between [-127, 128]!")
#		
#		else:
#			print('\nEnter B: ')
#			B = input()
#			try:
#		   		B = int(B)
#		   		if (B > 128 or B < -127):
#		   			raise ValueError()
#			except ValueError:
#		   		print("\nInvalid Number!\n\nNumbers Between [-127, 128]!")
#		
#			else:
#		   		sendData()
