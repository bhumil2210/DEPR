import base58
y = ""
def convertIpfsBytes32(hash_string):           
	bytes_array = base58.b58decode(hash_string) 
	return bytes_array

hash_string = 'QmWmyoMoctfbAaiEs2G46gpeUmhqFRDW6KWo64y5r581Vz'
x = convertIpfsBytes32(hash_string)
print("hash_string = ",hash_string)
print("decoded = ",x)
print("bytes32 = ",x[2:])
print("encoded = ",base58.b58encode(x))