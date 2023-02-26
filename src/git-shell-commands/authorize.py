#!/usr/bin/env python3
from argparse import ArgumentParser
from argparse import Namespace
from re import compile
from sys import exit

EXIT_SUCCESS = 0
EXIT_ERROR_INVALID_SSHKEY = 1
EXIT_ERROR_FAILED_FILE_ACCESS = 2

authorized_key_file = "/git/.ssh/authorized_keys"
supported_alg = [
    "ssh-rsa",
    "ssh-dss",
    "ecdsa-sha2-nistp256",
    "ecdsa-sha2-nistp384",
    "ecdsa-sha2-nistp521",
    "ssh-ed25519"
]

debug_mode: bool = False


def debug(msg: str) -> None:
    """
        If debug_mode is true, print a debug message
        :param msg: str
        :return: None
    """
    if debug_mode:
        print(f"[DEBUG]: {msg}")


def get_args() -> Namespace:
    """
      Get command-line arguments

      :return: Namespace
    """
    parser = ArgumentParser(description="git-authorize.py")
    parser.add_argument(
        "--sshkey",
        type=str,
        required=True,
        help=f"ssh public key (using a "
             f"supported algorithm: "
             f"{','.join(supported_alg)})"
    )
    parser.add_argument(
        "--debug",
        required=False,
        default=False,
        action="store_true",
        help="set debug messaging."
    )
    return parser.parse_args()


def verify_key(ssh_key: str) -> bool:
    """
      Verify the SSH key format

      :param ssh_key: str
      :return: bool
    """
    debug("verify_key() starting...")
    alg = '|'.join(supported_alg)
    key = "[A-Za-z0-9/+]+" + "[=]{0,3}"
    email_suffix = "([^@]+@[^@]+)?){0,1}"
    p = f"^(({alg})\\s+{key}\\s*" + email_suffix + "$"
    regex = compile(p)
    debug(f"regex:'{p}'")
    return regex.match(ssh_key) is not None


def main(arguments: Namespace) -> int:
    """
        main program

        :param arguments: Namespace
        :return: int
    """
    debug("Starting authorize.py...")
    if verify_key(arguments.sshkey):
        debug("\tssh key verified")
        try:
            with open(authorized_key_file, 'a') as f:
                debug("\twriting key")
                f.write(args.sshkey+"\n")
                debug("\tkey written")
            return EXIT_SUCCESS
        except Exception as e:
            print(f"Failed to write to {authorized_key_file}")
            return EXIT_ERROR_FAILED_FILE_ACCESS
    else:
        print("Invalid ssh key")
        return EXIT_ERROR_INVALID_SSHKEY


if __name__ == "__main__":
    args = get_args()
    debug_mode: bool = args.debug
    exit(main(args))
