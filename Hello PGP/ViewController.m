//
//  ViewController.m
//  Hello PGP
//
//  Created by Weiran Zhang on 12/01/2015.
//  Copyright (c) 2015 Weiran Zhang. All rights reserved.
//

#import "ViewController.h"

#import <ObjectivePGP/ObjectivePGP.h>

@interface ViewController ()
@property (nonatomic, strong) ObjectivePGP *pgp;
@property (weak) IBOutlet NSTextField *recipientsPublicKeyTextField;
@property (weak) IBOutlet NSTextField *messageTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.window.title = @"Hello PGP";
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)pressedEncrypt:(id)sender {
    self.pgp = [[ObjectivePGP alloc] init];
    NSError *error = nil;
    
    NSData *keyData = [self.recipientsPublicKeyTextField.stringValue dataUsingEncoding:NSASCIIStringEncoding];
    [self.pgp importKeysFromData:keyData allowDuplicates:YES];
    NSArray *keys = [self.pgp getKeysOfType:PGPKeyPublic];
    
    NSData *stringToEncrypt = [self.messageTextField.stringValue dataUsingEncoding:NSASCIIStringEncoding];

    NSData *encryptedData = [self.pgp encryptData:stringToEncrypt usingPublicKey:keys[0] armored:YES error:&error];
    if (encryptedData && !error) {
        self.messageTextField.stringValue = [[NSString alloc] initWithData:encryptedData encoding:NSASCIIStringEncoding];
    }
}
@end
