import math
import pathlib
# import subprocess
# import argparse

# import merkletools
# import yaml


deployment_plan_path = pathlib.Path(__file__).parent.parent.joinpath(
    "deployments", "buy_nft.yaml"
)


def write_yaml(content: dict) -> None:
    ...


def hexReverse(hexString: str) -> str:
    value = int(hexString, 16)
    numbytes = math.ceil(value.bit_length() / 8)
    result = int.from_bytes(
        value.to_bytes(numbytes, byteorder="little"), byteorder="big"
    )
    return hex(result)


def verify_transaction():
    ...

def send_transaction():
    ...


def main():
    ...


if __name__ == "__main__":
    main()
