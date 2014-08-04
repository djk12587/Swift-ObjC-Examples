//
//  UIKitExamplesObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "UIKitExamplesObj-C.h"

@implementation UIKitExamplesObj_C

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    switch (indexPath.row) {
        case 0: {
            if (!cell.accessoryView || ![cell.accessoryView isMemberOfClass:[UISwitch class]]) {
                UISwitch *switchView = [[UISwitch alloc]init];
                [switchView addTarget:self action:@selector(switchToggle:) forControlEvents:UIControlEventValueChanged];
                [cell setAccessoryView:switchView];
            }
            
            UISwitch *switchView = (UISwitch *)cell.accessoryView;
            [cell.textLabel setText:[NSString stringWithFormat:@"Switch:%d",switchView.on]];
            
        }
            break;
        case 1: {
            if (!cell.accessoryView || ![cell.accessoryView isMemberOfClass:[UIButton class]]) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 0, 100, 40);
                button.backgroundColor = [UIColor redColor];
                [button setTitle:@"button" forState:UIControlStateNormal];
                [cell setAccessoryView:button];
            }
            [cell.textLabel setText:@"Button:"];
        }
            break;
        case 2: {
            if (!cell.accessoryView || ![cell.accessoryView isMemberOfClass:[UISlider class]]) {
                UISlider *slider = [[UISlider alloc]init];
                [slider setMinimumValue:0];
                [slider setMaximumValue:9];
                [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
                [cell setAccessoryView:slider];
            }
            
            UISlider *slider = (UISlider *)cell.accessoryView;
            [cell.textLabel setText:[NSString stringWithFormat:@"Slider: %d",(int)slider.value]];
        }
            break;
        case 3: {
            if (!cell.accessoryView || ![cell.accessoryView isMemberOfClass:[UIProgressView class]]) {
                UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
                [cell setAccessoryView:progressView];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
            [cell.textLabel setText:@"Progress:"];
        }
            break;
        case 4: {
            if (!cell.accessoryView || ![cell.accessoryView isMemberOfClass:[UITextField class]]) {
                UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 180, 33)];
                [textField setBorderStyle:UITextBorderStyleRoundedRect];
                [textField setDelegate:self];
                [textField setReturnKeyType:UIReturnKeyDone];
                [cell setAccessoryView:textField];
            }
            [cell.textLabel setText:@"Text Field:"];
        }
            break;
        default: {
            [cell.textLabel setText:@"AlertController:"];
            [cell.detailTextLabel setText:@"tap to view"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
        }
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 3: {
            UIProgressView *progressView = (UIProgressView *)[self.tableView cellForRowAtIndexPath:indexPath].accessoryView;
            if (progressView.progress > 0) {
                [progressView setProgress:0 animated:YES];
            } else {
                [progressView setProgress:1 animated:YES];
            }
        }
            
            break;
        case 5: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Click" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
    }
}

- (void) switchToggle:(UISwitch *)switchView {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textLabel setText:[NSString stringWithFormat:@"Switch:%d",switchView.on]];
}

- (void) sliderValueChanged:(UISlider *)slider {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [cell.textLabel setText:[NSString stringWithFormat:@"Slider: %d",(int)slider.value]];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
