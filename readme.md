# aws-course

# Create a Github repository
echo "# aws-course" >> readme.md
git init
git add readme.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:sisayie/aws-course.git
git push -u origin main

---

# Create the stack

curl -fsSL https://raw.githubusercontent.com/sisayie/aws-course/refs/heads/main/aws-ml-stack.sh | sh