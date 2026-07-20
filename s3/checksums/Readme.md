# Create a new s3 bucket

```md
aws s3 mb s3://checksums-examples-tbrai-5588
```

# Create a file to have checksum performed on

```
echo "Greetings Martian!" > myfile.txt
```

# Get a MD5 checksum for a file
```md
md5sum myfile.txt
# b916115e06b31fcf6c513a0eaa894d05  myfile.txt
```

# upload file and look at its etag
```md
aws s3 cp myfile.txt s3://checksums-examples-tbrai-5588
aws s3api head-object --bucket checksums-examples-tbrai-5588 --key myfile.txt
```
# Check base64 encoded SHA1 checksum of file
```sh
openssl dgst -sha1 -binary myfile.txt | base64
```
# Upload file with different checksum algorithm

```sh
aws s3api put-object \
--bucket checksums-examples-tbrai-5588 \
--key myfilesha1.txt \
--body myfile.txt \
--checksum-algorithm="SHA1" \
--checksum-sha1="7T/iCveMeiknKzEarlAZxbJXzXk=" #base64 encoded SHA1 checksum
```