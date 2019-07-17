import ptvsd
ptvsd.enable_attach(address=("0.0.0.0",6543),log_dir="/root/logs")
ptvsd.wait_for_attach()