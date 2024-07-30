# Bash-Case-Statements
In my Bash project, I implemented a menu-driven script utilizing a while loop to repeatedly present a set of options to the user. Inside the loop, a case statement handles user input, executing specific commands based on the chosen option. 

1. Create a variable that'll be used in the conditional statement of the while loop.

   ``
   variable-name=1
   ``

2.  Create the options to be displayed for the user, ``echo`` command will be used here.
3.  Create a variable that will accept the input from the user

    ``
      read $usrinput
    ``

4. Begin case statement with task that will be executed based on the option

   ``
     case $usrinput in
   ``

5. Once satisfied, you can exit the loop by hitting 6
