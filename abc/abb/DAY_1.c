#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdbool.h>

// ======================= Task 0.1 =======================
void task01_datatypes() {
    // TODO: Declare int, float, double, char
    // Print their sizes and demonstrate type casting


	int i = 42;
	float f = 3.14;
	double d = 1.23456;
	char c = 'A';
	
	printf("Integer i = %d\n", i);
	printf("Float f = %f\n", f);
	printf("Double d = %f\n", d);
	printf("Char c = %c\n\n", c);
	
	printf("Size of Integer i = %zu bytes\n", sizeof(i));
	printf("Size of Float f = %zu bytes\n", sizeof(f));
	printf("Size of Double d = %zu bytes\n", sizeof(d));
	printf("Size of Char c = %zu bytes\n\n", sizeof(c));

	printf("i = %f\n", (float)i);
	printf("f = %d\n", (int)f);
    printf("d = %d\n", (int)d);
    printf("c = %d\n", (int)c);
}

// ======================= Task 0.2 =======================
void task02_calculator() {
    // TODO: Take two integers as input
    // Perform arithmetic operations
    // Implement switch-case calculator

    int a;
	int b;
    char operator;

	printf("Enter First number  ");
	scanf("%d", &a);
	printf("Enter Second number ");
	scanf("%d", &b);

    printf("Enter Operator +, -, *, /, %%,\n");
	scanf(" %c", &operator);

    switch (operator){
        case '+':
            printf("Result of %d + %d = %d\n",a,b,a+b);
            break;
        case '-':
            printf("Result of %d - %d = %d\n",a,b,a-b);
            break;
        case '*':
            printf("Result of %d * %d = %d\n",a,b,a*b);
            break;
        case '/':
            if(b != 0){
                printf("Result of %d / %d = %d\n",a,b,a/b);
            }
            else{
                printf("Division by zero is not allowed\n");
            }
            break;
        case '%':
            if(b != 0){
                printf("Result of %d %% %d = %d\n",a,b,a%b);
            }
            else{
                printf("Modulo by zero is not allowed\n");
            }
            break;
        default:
            printf("Invalid Operator!\n");

    }
}

// ======================= Task 0.3 =======================
void task03_fibonacci() {
    // TODO: Print Fibonacci sequence up to n terms
    int n;

    printf("Enter number ");
	scanf("%d", &n);

    printf("The Fibonacci sequence up to %dth terms is:  ", n );

    int b = 0;
    int first = 0;
    int second = 0;

    for(int i = 0 ;i < n ; i++){
        
        if(i == 0){
            printf("%d ",i);
        }
        else if(i == 1){
            printf("%d ",i);
            second = i;
        }
        else{
            printf("%d ",first + second);
        }
        b = first;
        first = first + second;
        second = b;
    }
    printf("\n");
}

void task03_guessing_game() {
    // TODO: Implement guessing game with random number

    int random,guess,attempt = 0;
    random = rand() % 101;
    
    do{
        printf("Enter your guess number ");
        scanf("%d", &guess);
        attempt++;

        if(guess < random){
            printf("The guess is too low\n");
        }
        else if(guess > random){
            printf("The guess is too high\n");
        }
        else{
            printf("You guess the correct number in %dth attempts\n",attempt);
        }
    } while(random != guess);
}

// ======================= Task 0.4 =======================
int isPrime(int n) {
    // TODO: Return 1 if n is prime, else 0
    if (n<=1){
        return 0;
    }
    else{
        for(int i = 2;i < n;i++){
            if(n%i == 0){
                return 0;
            } 
        } 
        return 1;
    }   
    return 0;
}

void task04_prime_numbers() {
    // TODO: Print prime numbers between 1 and 100
    printf("Prime numbers between 1 and 100 are:\n");
    for(int n = 1;n <= 100; n++){
        if(isPrime(n) == 1){
            printf("%d ",n);
        }
    }
    printf("\n");
}

int factorial(int n) {
    // TODO: Implement recursive factorial function
    if(n == 1){
        return 1;
    }
    else{
        n = n * (factorial(n-1));
    }
    return n;
}

// ======================= Task 0.5 =======================
void task05_reverse_string() {
    // TODO: Reverse a string without library functions
    char p[100];

    printf("Enter the string:  ");
    scanf("%s",p);

    int length = 0;
    while(p[length] != '\0'){
        length++;
    }
    printf("The Reverse string is: ");

    char *first = &p[0];
    char *end = &p[length-1];
    while(first < end){
        char temp = *first;
        *first = *end;
        *end = temp;

        first++;
        end--;
    }
    

    printf("%s",p);
    
    printf("\n");
}

void task05_second_largest() {
    // TODO: Find the second largest element in an array
    int p[10] = {7,8,5,9,15,2,3,4,10,11};
    int large = p[0];
    int second = 0;
    int length = 10;

    for(int i = 0;i < length;i++){
        
        if(large < p[i]){
            second = large;
            large = p[i];
        }
        else if (p[i] > second && p[i] != large) {
            second = p[i];
        }        
    }
    printf("Second largest number is: %d\n",second);
}

// ======================= Task 0.6 =======================
void task06_file_io() {
    // TODO: Write 5 integers to a file, then read them back

    int nums[5];
    printf("Enter 5 integers:\n");
    for (int i = 0; i < 5; i++) {
        scanf("%d", &nums[i]);
    }

    FILE *fp;

    fp = fopen("number.txt","w");
    if(fp == NULL){
        printf("Error opening file for writing!\n");
        return;
    }

    for (int i = 0; i < 5; i++) {
        fprintf(fp,"%d\n",nums[i]);
    }
    fclose(fp);

    printf("Numbers written to numbers.txt\n");

    for (int i = 0; i < 5; i++) {
        nums[i] = 0;
    }

    printf("Numbers read from file:\n");

    fp = fopen("number.txt","r");
    for (int i = 0; i < 5; i++) {
        fscanf(fp,"%d", &nums[i]);
        printf("%d ", nums[i]);
    }
    fclose(fp);
    printf("\n");
}

bool is_power_of_two(int n) {
    return (n > 0) && ((n & (n - 1)) == 0);
}

// ======================= Task 0.7 =======================
void task07_bitwise_ops() {
    // TODO: Demonstrate AND, OR, XOR, NOT, shifts
    // Bonus: Check if number is power of 2
    int x = 5; 
    int y = 9; 

    printf("x = %d, y = %d\n", x, y);
    printf("x & y = %d\n", x & y);   
    printf("x | y = %d\n", x | y);   
    printf("x ^ y = %d\n", x ^ y);   
    printf("~x = %d\n", ~x);         
    printf("~y = %d\n", ~y);         
    printf("x << 1 = %d\n", x << 1); 
    printf("y << 1 = %d\n", y << 1);
    printf("x >> 1 = %d\n", x >> 1); 
    printf("y >> 1 = %d\n", y >> 1);

    // Power of 2 check
    int num;
    printf("\nEnter a number to check if it is power of 2: ");
    scanf("%d", &num);

    if (is_power_of_two(num))
        printf("%d is a power of 2\n", num);
    else
        printf("%d is NOT a power of 2\n", num);
}


    
// ======================= Task 0.8 =======================
void task08_enum_weekday() {
    // TODO: Map number (1–7) to day of week using enum
    enum Weekday { MON = 1, TUE, WED, THU, FRI, SAT, SUN };


    int day;
    printf("Enter a number (1-7): ");
    scanf("%d", &day);

    switch (day) {
        case MON: printf("Monday\n"); break;
        case TUE: printf("Tuesday\n"); break;
        case WED: printf("Wednesday\n"); break;
        case THU: printf("Thursday\n"); break;
        case FRI: printf("Friday\n"); break;
        case SAT: printf("Saturday\n"); break;
        case SUN: printf("Sunday\n"); break;
        default: printf("Invalid input! Please enter 1–7.\n"); break;
    }

}

// ======================= Task 0.9 =======================
struct Point {
    int x;
    int y;
};


void task09_struct_distance() {
    struct Point p1, p2;
    double distance;

    printf("Enter coordinates of first point (x y): ");
    scanf("%d %d", &p1.x, &p1.y);

    printf("Enter coordinates of second point (x y): ");
    scanf("%d %d", &p2.x, &p2.y);

    distance = sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2));

    printf("Euclidean Distance = %.2f\n", distance);
}



// ======================= Task 0.10 =======================
void task10_cmd_args(int argc, char *argv[]) {
    // TODO: Take 2 integers as command line args and print sum
    int num1 = atoi(argv[1]);  
    int num2 = atoi(argv[2]);

    printf("Sum = %d\n", num1 + num2);
}

// ======================= Main =======================
int main(int argc, char *argv[]) {
    srand(time(NULL)); // Seed random numbers

    // Uncomment tasks as you implement them
    // task01_datatypes();
    // task02_calculator();
    // task03_fibonacci();
    // task03_guessing_game();
    // task04_prime_numbers();
    // printf("Factorial of 5 = %d\n", factorial(10));
    // task05_reverse_string();
    // task05_second_largest();
    // task06_file_io();
    // task07_bitwise_ops();
    // task08_enum_weekday();
    // task09_struct_distance();
    // task10_cmd_args(argc, argv);

    return 0;
}
