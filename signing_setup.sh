#!/bin/sh

mkdir -p /root/sign/
pushd /root/sign/
openssl genrsa -out repo.key 2048
chmod 0400 repo.key
openssl rsa -in repo.key -out repo.pub -pubout
printf "function: sha256\nfingerprint: `sha256 -q repo.pub`\n" > fingerprint

cat >> sign.sh << DONE
#!/bin/sh
read -t 2 sum
[ -z "$sum" ] && exit 1
echo SIGNATURE
echo -n $sum | openssl dgst -sign /root/sign/repo.key -sha256 -binary
echo
echo CERT
cat /root/sign/repo.pub
echo END
DONE

chmod +x sign.sh

popd

rm src/usr/local/share/Demo/keys/pkg/trusted/*
cp /root/sign/fingerprint src/usr/local/share/Demo/keys/pkg/trusted/fingerprint
