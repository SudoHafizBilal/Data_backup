#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <limits.h>

// ======================= Part 1: Pointer Basics and Arithmetic =======================

// Task 1.1: Basic pointer usage
void task1_1() {
    // TODO: Declare int variable, pointer to it
    // Print value using direct and pointer
    // Modify via pointer and print new value
    int a = 10;
    int *b = &a;
    printf("Direct: %d\n",a);
    printf("Using pointer: %d\n",*b);
    *b = 20;
    printf("Modified value using pointer: %d\n",a);
}

// Task 1.2: Swap two integers using pointers
void swap(int *a, int *b) {
    // TODO: Implement swap using pointers
    printf("Before swap\n");
    printf("int_1: %d\n",*a);
    printf("int_2: %d\n",*b);
    int temp = *b;
    *b = *a;
    *a = temp;
    printf("After swap\n");
    printf("int_1: %d\n",*a);
    printf("int_2: %d\n",*b);
}

// Task 1.3: Pointer arithmetic on array
void task1_3() {
    // TODO: Create an array
    // Print all elements using pointers
    // Calculate sum
    // Reverse in place
    int arr[] = {1,2,3,4,5};
    int *ptr = arr;
    int sum = 0;
    int length = sizeof(arr)/sizeof(arr[0]);
    printf("Array elements are: ");
    
    for(int i = 0;i < length;i++){
        printf("%d ",ptr[i]);
        sum = sum + ptr[i];
    }
    printf("\nThe Sum is: %d\n",sum);
    int *a = arr + length-1;
    ptr = arr;
    while(ptr < a){
        int temp = *ptr;
        *ptr = *a;
        ptr++;
        *a = temp;
        a--;
    }
    ptr = arr;
    printf("Reverse array elements are: ");
    for(int i = 0;i < length;i++){
        printf("%d ",ptr[i]);
    }
   
}


// ======================= Part 2: Pointers and Arrays/Strings =======================

// Custom strlen using pointers
int my_strlen(const char *s) {
    // TODO: Implement strlen
    int length = 0;
    while(*s != '\0'){
        length++;
        s++;
    }
    return length;
}

// Custom strcpy using pointers
void my_strcpy(char *dest, const char *src) {
    // TODO: Implement strcpy
   // char *arr = dest;
    int a = my_strlen(src);
    while(*src != '\0'){
        *dest = *src;
        dest++;
        src++;
    }
    *dest = '\0';
    //printf("Copy string using my_strcpy: ");
   // for(int i = 0;i < a;i++){
     //   printf("%c",arr[i]);
    //}
    //printf("\n");
}

// Custom strcmp using pointers
int my_strcmp(const char *s1, const char *s2) {
    // TODO: Implement strcmp
    if(s1-s2 == 0){
        printf("Strings are equal\n");
    }
    else{
        printf("Strings are not equal\n");
    }
    return 0;
}

// Task 2.2: Palindrome checker (case-insensitive)
int is_palindrome(const char *s) {
    // TODO: Implement palindrome check
    int a = my_strlen(s);
    const char *end = s + (a-1); 
    while(s < end){
        if(tolower(*s) != tolower(*end)){
            return 0;
        }
        s++;
        end--;
    }
    return 1;
}


// ======================= Part 3: Preprocessor & File I/O =======================

// Macros
#define SQUARE(x) ((x)*(x))    
#define MAX2(a,b) ((a > b) ? a:b)
#define MAX3(a,b,c) (MAX2(MAX2(a,b),c))
#define MAX4(a,b,c,d) (MAX2(MAX3(a,b,c),d))
#define TO_UPPER(c) ((c >= 'a' && c <= 'z') ? (c-32): c )

void task3_1_macros() {
    // TODO: Demonstrate macros with test cases
    int x = 5, y = 10, z = 3, w = 15;

    printf("SQUARE(%d) = %d\n", x, SQUARE(x));
    printf("MAX2(%d, %d) = %d\n", x, y, MAX2(x, y));
    printf("MAX3(%d, %d, %d) = %d\n", x, y, z, MAX3(x, y, z));
    printf("MAX4(%d, %d, %d, %d) = %d\n", x, y, z, w, MAX4(x, y, z, w));

    char c1 = 'a', c2 = 'Z';
    printf("TO_UPPER('%c') = %c\n", c1, TO_UPPER(c1));
    printf("TO_UPPER('%c') = %c\n", c2, TO_UPPER(c2));
}

// Student struct
struct Student {
    char name[50];
    int roll;
    float gpa;
};

// Task 3.2: File I/O
void task3_2_fileio() {
    struct Student students[5] = {
        {"AliKhan", 14, 3.20},
        {"SaraAhmed", 15, 3.90},
        {"BilalRaza", 16, 3.50},
        {"AhsanMalik", 17, 3.99},
        {"HinaNoor", 18, 3.70}
    };

    // Find highest GPA
    float highest = students[0].gpa;
    int h = 0;
    for (int i = 1; i < 5; i++) {
        if (students[i].gpa > highest) {
            highest = students[i].gpa;
            h = i;
        }
    }
    printf("Student with highest gpa:\n");
    printf("Name = %s ,Roll = %d ,gpa = %.2f\n",
           students[h].name, students[h].roll, students[h].gpa);

    // Write clean data
    FILE *file = fopen("Students.txt","w");
    if (file == NULL) {
        printf("Error opening file for writing\n");
        return;
    }
    for (int i = 0; i < 5; i++) {
        fprintf(file, "%s %d %.2f\n",
                students[i].name, students[i].roll, students[i].gpa);
    }
    fclose(file);
    printf("Data saved to Students.txt\n");

    // Read back
    file = fopen("Students.txt","r");
    if (file == NULL) {
        printf("Error opening file for reading!\n");
        return;
    }

    printf("\nReading back from file:\n");
    struct Student temp;
    while (fscanf(file, "%s %d %f",
                  temp.name, &temp.roll, &temp.gpa) == 3) {
        printf("Name = %s, Roll = %d, GPA = %.2f\n",
               temp.name, temp.roll, temp.gpa);
    }
    fclose(file);
}

// ======================= Part 4: Advanced Challenge =======================

// Linked List Node
struct Node {
    int data;
    struct Node *next;
};

struct Node* insert_begin(struct Node *head, int value) {
    // TODO: Insert new node at beginning
    struct Node* new = (struct Node*) malloc(sizeof(struct Node));
    new->data = value;
    new->next = head;
    return new;
}

struct Node* delete_value(struct Node *head, int value) {
    // TODO: Delete node by value
    struct Node* temp = head;
    struct Node* pre = NULL;

    if(temp != NULL && temp->data == value){
        head = temp->next;
        free(temp);
        return head;
    }

  
    while((temp != NULL) && (temp->data != value)){
        pre = temp;
        temp = temp->next;
    }
    pre->next = temp->next;
    free(temp);
    return head;
}

void print_list(struct Node *head) {
    // TODO: Print linked list
    struct Node* temp = head;
    while(temp != NULL){
        printf("%d ",temp->data);
        temp = temp->next;
    }
    printf("\n");
}

void task4_1_linkedlist() {
    // TODO: Test insert, delete, print
    struct Node *head = NULL;

    //insert some elements
    head = insert_begin(head,10);
    head = insert_begin(head,20);
    head = insert_begin(head,30);

    //print linked list
    printf("Print Linked list: ");
    print_list(head);
    //delete node
    head = delete_value(head,30);
    printf("Print Linked list after deleting node: ");
    print_list(head);    

}


// ======================= Part 5: Dynamic Memory Allocation =======================

// Task 5.1: Dynamic array, sum, average
void task5_1_dynamic_array() {
    // TODO: malloc array, input elements, compute sum and avg
    int n;
    printf("Enter number of elements: ");
    scanf("%d",&n);
    int *arr = (int*) malloc(n*sizeof(int));
    int sum = 0;
    for(int i = 0;i < n;i++){
        printf("Enter %dth number: ",i+1);
        scanf("%d", &arr[i]);
        sum = sum + arr[i];
    }
    float avegr = (float)sum/(float)n;
    printf("Sum: %d\n",sum);
    printf("Average: %0.2f\n",avegr); 
    free(arr);

}

// Task 5.2: Extend array with realloc
void task5_2_realloc_array() {
    // TODO: realloc to extend existing array
    int n,m;
    printf("Enter number of elements: ");
    scanf("%d",&n);
    int *arr = (int*) malloc(n*sizeof(int));
    for(int i = 0;i < n;i++){
        printf("Enter %dth number: ",i+1);
        scanf("%d", &arr[i]);
    }
    printf("Original array: ");
    for(int i = 0;i < n;i++){
        printf("%d ",arr[i]);
    }
    printf("\n");
    printf("Enter number of Extra elements to append: ");
    scanf("%d",&m);
    int *arr_1 = (int*) malloc((n+m)*sizeof(int));
    for(int i = 0;i < n;i++){
        arr_1[i] = arr[i];
    }
    free(arr);
    for(int i = 0;i < m;i++){
        printf("Enter %dth number: ",n+1+i);
        scanf("%d", &arr_1[n+i]);
    }
    printf("Extended array: ");
    for(int i = 0;i < (n+m);i++){
        printf("%d ",arr_1[i]);
    }
    free(arr_1);
    printf("\n");
}

// Memory Leak Detector (simplified tracking)
#define MAX_PTRS 100
void* allocated_ptrs[MAX_PTRS];
int allocated_count = 0;

void* my_malloc(size_t size) {
    // TODO: Track allocated pointers
    void* ptr = malloc(size);
    if(ptr != NULL && allocated_count < MAX_PTRS){
        allocated_ptrs[allocated_count++] = ptr;
    }
    printf("Memory allocated to %dth pointer \n",allocated_count);
    return ptr;
}

void my_free(void *ptr) {
    // TODO: Free and update tracking
    for(int i = 0;i < allocated_count;i++){
        if(allocated_ptrs[i] == ptr){
            printf("Allocated pointer's memory successfully free at %p\n",ptr);
            free(ptr);
            allocated_ptrs[i] = NULL;
            return;
        }
    }
    printf("Warning: Tried to free untracked pointer!\n");
}

void report_leaks() {
    // TODO: Report if unfreed memory remains
    int leak = 0;
    for(int i = 0;i < allocated_count;i++){
        if(allocated_ptrs[i] != NULL){
            leak++;
            printf("Memory leak detected at pointer %p \n",allocated_ptrs[i]);
        }
    }
    if(leak == 0){
        printf("No memory leaks detected \n");
    }
    
}

void task5_3_leak_detector() {
    // TODO: Demonstrate memory leak detection
    int *arr1 = (int*) my_malloc(5 * sizeof(int));   
    int *arr2 = (int*) my_malloc(3 * sizeof(int));

    my_free(arr2);   // Freed properly

    report_leaks();  // Should detect arr1 as leaked
}


// ======================= Final Task: Booth's Multiplication =======================

int twos_complement(int b){
    b = ~b;
    b = b + 0x00000001;
    return b;
}

int add(int a, int b) {
    // TODO: Implement bitwise addition helper
    int carry = 0;
    while(b != 0){
        carry = (unsigned)(a&b) << 1;
        a = a ^ b;
        b = carry;
    }
    return a;
}

long long booth_multiply(int multiplicand, int multiplier) {
    // TODO: Implement Booth's algorithm using shifting/adding
    int A   = 0;
    int n   = 32;
    int M   = multiplicand;
    int Q   = multiplier;
    int Q_1 = 0;
    int Q_0 = 0;

    for(int i = 0;i < n;i++){
        Q_0 = Q & 1;
        if(Q_0 == 1 && Q_1 == 0){
            A = add(A,twos_complement(M));
        }
        else if(Q_0 == 0 && Q_1 == 1){
            A = add(A,M);
        }

        Q_1 = Q & 1;
        Q = (A & 1) << 31 | (unsigned)Q >> 1;
        A = A >> 1;

    }
   
    long long result = ((long long) A << 32) | (unsigned)(Q);
    return (result);
}

void test_booth() {
    // TODO: Write test cases for booth_multiply
    // Include positive, negative, zero, overflow cases
    //printf("Using BOOTH Multiplier: %lld\n",result);

    
    printf(" 5 *  3 = %lld (expected %d)\n", booth_multiply(5, 3),5*3);
    printf("-5 *  3 = %lld (expected %d)\n", booth_multiply(-5, 3),-5*3);
    printf(" 5 * -3 = %lld (expected %d)\n", booth_multiply(5, -3),5*-3);
    printf("-5 * -3 = %lld (expected %d)\n", booth_multiply(-5, -3),-5*-3);
    printf(" 0 *  7 = %lld (expected %d)\n", booth_multiply(0, 7),0*7);
    printf(" 7 *  0 = %lld (expected %d)\n", booth_multiply(7, 0),7*0);
    printf(" 1 * 123 = %lld (expected %d)\n", booth_multiply(1, 123),1*123);
    printf("INT_MAX * 1 = %lld (expected %d)\n", booth_multiply(INT_MAX, 1), INT_MAX);
    printf("INT_MIN * 1 = %lld (expected %d)\n", booth_multiply(INT_MIN, 1), INT_MIN);

    //int comp = int_1 * int_2;
    //printf("Using operator: %d\n",comp);
    //if(comp == result){
      //  printf("Matched \n");
    //}
    //else{
      //  printf("Unmatched \n");
    //}
}


// ======================= Main =======================
int main() {
    // Uncomment and run tasks as you implement

    // --- Part 1 ---
    // task1_1();
    // int a=5, b=10; swap(&a,&b);
    // task1_3();

    // --- Part 2 ---
    // printf("Len = %d\n", my_strlen("Hello"));
    // char buf[100]; my_strcpy(buf,"World");
    // printf("Copied: %s\n", buf);
    // my_strcmp("world", "world");
    // printf("Palindrome? %s\n", is_palindrome("Madam") ? "Yes":"No");

    // --- Part 3 ---
    // task3_1_macros();
    // task3_2_fileio();

    // --- Part 4 ---
    // task4_1_linkedlist();

    // --- Part 5 ---
    // task5_1_dynamic_array();
    // task5_2_realloc_array();
    // task5_3_leak_detector();

    // --- Final Task ---
    // test_booth();

    return 0;
}
