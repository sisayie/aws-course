# Create the stack

curl -fsSL https://raw.githubusercontent.com/sisayie/aws-course/refs/heads/main/examples/sagemaker-s3-processing/aws-ml-stack.sh | bash

If it fails to run because of `\r`, add a `.gitattributes` file to the repository:

Remove the `\r` using the following command
`sed -i 's/\r$//' aws-ml-stack.sh`

 .gitattributes✓

```
*.sh text eol=lf
*.yml text eol=lf
*.yaml text eol=lf
```

 Then normalize the existing file:

```
git add --renormalize .
git commit -m "Normalize shell scripts to LF"
git push
```

 This prevents Git from checking the shell script out with Windows-style `CRLF` line endings.