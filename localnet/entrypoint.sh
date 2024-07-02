#!/bin/bash

file_count=$(ls -1 /root | wc -l)

if [ "$file_count" -gt 2 ]; then
  echo "*** Skipping decompression as a chain state is already present."
else
  echo "*** Decompressing chain state..."
  tar --use-compress-program=zstd -xf /root/root.tar.zst -C / 2>&1 | grep -v -E "^\./"
fi

echo "*** Starting localnet nodes..."
alice_start=(
  "node-subtensor"
  --base-path /root/alice
  --chain="/root/local_spec.json"
  --alice
  --port 30334
  --rpc-port 9946
  --ws-port 9944
  --validator
  --allow-private-ipv4
  --discover-local
  --unsafe-ws-external
  --unsafe-rpc-external
  --rpc-cors=all
)

bob_start=(
  "node-subtensor"
  --base-path /root/bob
  --chain="/root/local_spec.json"
  --bob
  --port 30335
  --validator
  --allow-private-ipv4
  --discover-local
)

trap 'pkill -P $$' EXIT SIGINT SIGTERM

# Start Alice
("${alice_start[@]}" 2>&1) &

# Wait for Alice to be ready otherwise the chances are that Bob will start first and catches the exposed port(9944)
while ! nc -z localhost 9944; do
  sleep 1
done

("${bob_start[@]}" 2>&1) &
wait
