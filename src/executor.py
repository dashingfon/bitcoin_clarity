import pathlib
import argparse
import subprocess  # type: ignore
import yaml  # type: ignore


deployment_plan_path = pathlib.Path(__file__).parent.parent.joinpath(
    "deployments", "sell_nft.devnet-plan.yaml"
)


def main(tx: str):
    with open(deployment_plan_path) as file:
        yaml_file = yaml.safe_load(file)
    yaml_file["plan"]["batches"][0]["transactions"][0]["contract-call"]["parameters"][
        0
    ] = tx
    with open(deployment_plan_path, "w") as file:
        yaml.dump(yaml_file)
    subprocess.run(
        ["clarinet", "deployments", "apply", "-p", "sell_nft.devnet-plan.yaml"]
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser("Update deployment plan and call contract")
    parser.add_argument("tx", type=str)
    args = parser.parse_args()
    main(tx=args.tx)
