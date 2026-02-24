import os
import glob

BASE_DIR = '/glade/campaign/uwyo/wyom0200/alaska/miroc6/ssp370'
#'/beegfs/datasets/DYNDOWN/MIROC6ssp370'
INNER_DIRS = ["12km", "4km", "1_33km"]

def count_files(data_dir):
    """Count regular files (non-recursive) inside a directory."""
    files = [
        f for f in os.listdir(data_dir)
        if os.path.isfile(os.path.join(data_dir, f))
    ]

    print(f"[{data_dir}] Total files: {len(files)}")
    return len(files)


def main():
    # Loop over post_proc-s* directories
    postproc_dirs = glob.glob(os.path.join(BASE_DIR, "post_proc-s*"))

    if not postproc_dirs:
        print("No post_proc-s* directories found.")
        return

    for post_dir in sorted(postproc_dirs):
        print(f"\nChecking {post_dir}")

        for inner in INNER_DIRS:
            inner_path = os.path.join(post_dir, inner)

            if os.path.isdir(inner_path):
                count_files(inner_path)
            else:
                print(f"{inner_path} does not exist.")


if __name__ == "__main__":
    main()
~                
