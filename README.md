# seaweed-demo

This is a simple demo setup of [seaweedfs](https://github.com/seaweedfs/seaweedfs) for tinkering around with.

## Usage

```plaintext
make start
make shell  # enters interactive weed shell, see commands below
make stop
```

## weed shell commands

Create a local bucket

```plaintext
s3.bucket.create -name bob
```

Configure/mount a bucket from AWS into our local seaweed setup.  We'll mount it under the local `bob` bucket so that
we can access it from there.  Replace the values of `$ACCESSKEY`, `$SECRETKEY`, `$REGION` and `$BUCKET` as appropriate.

```plaintext
remote.configure -name=aws -type=s3 -s3.access_key=$ACCESSKEY -s3.secret_key=$SECRETKEY -s3.region=$BUCKET -s3.storage_class="STANDARD_IA"
remote.mount -dir=/buckets/bob/$BUCKET -remote=aws/$BUCKET
remote.cache -dir /buckets/bob/$BUCKET
```

Filer commands

```plaintext
fs.ls /buckets/bob/$BUCKET
fs.cat /buckets/bob/$BUCKET/hello.txt
```

## s3cmd foo

Exploring the local S3 bucket with [s3cmd](https://s3tools.org/s3cmd):

```plaintext
s3cmd ls s3://
s3cmd ls s3://bob
s3cmd ls s3://bob/$BUCKET
s3cmd get s3://bob/$BUCKET/hello.txt h.txt
curl -sL "$(s3cmd signurl s3://bob/$BUCKET/hello.txt +120)"
```

## Config files

It should be possible to create the above bucket config by defining it in config files. Reference
files can be created as follows:

```plaintext
weed scaffold -config <component>
```

where `<component>` is one of:

- `filer`
- `notification`
- `replication`
- `security`
- `master`
