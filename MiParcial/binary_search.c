#define SIZE 30

int binary_search(char nums[],char num,char left, char right);

int main(char num,char nums[SIZE]){
    binary_search(nums,num,nums[0],nums[SIZE-1]);
}