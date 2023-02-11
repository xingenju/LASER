import sys
from os import path

if __name__ == '__main__':
    dir_path = sys.argv[1]
    ori_file_name = sys.argv[2]
    file_name = ori_file_name.split('.')[0]
    lines = []
    with open(path.join(dir_path, ori_file_name), "r") as fin:
        for line in fin:
            line = line.strip()
            line = line.strip("\n")
            if not line:
                continue
            else:
                lines.append(line)
    with open(path.join(dir_path, file_name + "_clean.txt"), "w") as fout:
        for index, line in enumerate(lines):
            if index != len(lines) - 1:
                fout.write(line + "\n")
            else:
                fout.write(line)