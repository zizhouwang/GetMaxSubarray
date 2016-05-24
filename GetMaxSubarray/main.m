//
//  main.m
//  GetMaxSubarray
//
//  Created by wzzyinqiang on 16/5/24.
//  Copyright © 2016年 wzzyinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_LEFT @"max_left"
#define MAX_RIGHT @"max_right"
#define MAX_SUM @"max_sum"

NSDictionary* find_max_crossing_subarray(NSArray * the_array, NSInteger low, NSInteger mid, NSInteger high) {
    CGFloat left_sum = LONG_LONG_MIN;
    
    CGFloat sum = 0.0f;
    
    NSInteger max_left = 0;
    
    for (NSInteger i = mid; i >= low; i--) {
        sum += [the_array[i] floatValue];
        
        if (sum > left_sum) {
            left_sum = sum;
            
            max_left = i;
        }
    }
    
    
    CGFloat right_sum = LONG_LONG_MIN;
    
    sum = 0.0f;
    
    NSInteger max_right = 0;
    
    for (NSInteger j = mid + 1; j <= high; j++) {
        sum += [the_array[j] floatValue];
        
        if (sum > right_sum) {
            right_sum = sum;
            
            max_right = j;
        }
    }
    
    return @{MAX_LEFT:[NSString stringWithFormat:@"%li",(long)max_left],MAX_RIGHT:[NSString stringWithFormat:@"%li",(long)max_right],MAX_SUM:[NSString stringWithFormat:@"%f",left_sum + right_sum]};
}

NSDictionary* find_maximum_subarray(NSArray * the_array, NSInteger low, NSInteger high) {
    if (high == low) {
        return @{MAX_LEFT:[NSString stringWithFormat:@"%li",(long)low],MAX_RIGHT:[NSString stringWithFormat:@"%li",(long)high],MAX_SUM:the_array[low]};
    }
    else {
        NSInteger mid = (low + high) / 2;
        
        NSDictionary * left_result_dic = find_maximum_subarray(the_array, low, mid);
        
        NSDictionary * right_result_dic = find_maximum_subarray(the_array, mid + 1, high);
        
        NSDictionary * cross_result_dic = find_max_crossing_subarray(the_array, low, mid, high);
        
        CGFloat left_sum = [left_result_dic[MAX_SUM] floatValue];
        
        CGFloat right_sum = [right_result_dic[MAX_SUM] floatValue];
        
        CGFloat cross_sum = [cross_result_dic[MAX_SUM] floatValue];
        
        if (left_sum >= right_sum && left_sum >= cross_sum) {
            return @{MAX_LEFT:left_result_dic[MAX_LEFT],MAX_RIGHT:left_result_dic[MAX_RIGHT],MAX_SUM:[NSString stringWithFormat:@"%f",left_sum]};
        }
        else if (right_sum >= left_sum && right_sum >= cross_sum) {
            return @{MAX_LEFT:right_result_dic[MAX_LEFT],MAX_RIGHT:right_result_dic[MAX_RIGHT],MAX_SUM:[NSString stringWithFormat:@"%f",right_sum]};
        }
        else {
            return @{MAX_LEFT:cross_result_dic[MAX_LEFT],MAX_RIGHT:cross_result_dic[MAX_RIGHT],MAX_SUM:[NSString stringWithFormat:@"%f",cross_sum]};
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray * the_array = @[@"2",@"-1",@"5",@"-3",@"6",@"3",@"-2",@"2",@"-9",@"5"];
        
        NSLog(@"%@",find_maximum_subarray(the_array, 0, the_array.count - 1));
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
