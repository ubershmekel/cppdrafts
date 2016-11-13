import time
import os
import subprocess

def call(line):
    print('Running: %s' % line)
    return subprocess.check_output(line, shell=True)

def generate_html(branch):
    print(call('git checkout {branch}'.format(branch=branch)))
    
    call('latexmk -f -pdf std')
    call('pdf2htmlEX --optimize-text 1 --zoom 1.5 std.pdf std.html')
    call('cp std.html /output/{branch}.html'.format(branch=branch))

    

def main():
    start = time.time()
    #print('. = %s' % call('pwd'))
    branches_txt = call('git branch -a')
    to_generate = ['master']
    for line in branches_txt.splitlines():
        if 'c++' in line:
            branch_name = line.strip().replace('remotes/origin/', '')
            to_generate.append(branch_name)
    
    print("Generating html for:")
    print(repr(to_generate))

    if len(to_generate) == 1:
        print("Exiting, did not find enough draft branches")
        exit(1)
    
    for branch in to_generate:
        generate_html(branch)
    
    duration = (time.time() - start) / 60.0
    print('generation took %.1f minutes' % duration)

if __name__ == "__main__":
    main()