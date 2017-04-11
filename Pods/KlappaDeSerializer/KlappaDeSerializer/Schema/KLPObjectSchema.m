//
//  KLPObjectSchema.m
//  KlappaDeSerializer
//
//  Created by Ilja Kosynkin on 3/21/17.
//  Copyright © 2017 Ilja Kosynkin. All rights reserved.
//

#import "KLPObjectSchema.h"

@implementation KLPObjectSchema {
    struct Node* root_node;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self->_keys = [[NSMutableArray alloc] init];
        
        Node(root, '\0')
        self->root_node = root;
    }
    
    return self;
}

- (void) addProperty:(NSString*) name value:(struct Value*) value {
    add_field(self->root_node, value);
    [self->_keys addObject:name];
}

- (struct Node*) getNodeForName:(NSString*) name {
    return find_node(root_node, transfer([name cStringUsingEncoding:NSUTF8StringEncoding]));
}

- (void) reloadR:(struct Node*) root withStrategy:(id<KLPNamingStrategy>) strategy {
    if (root == NULL) {
        return;
    }
    
    NSString* converted = [strategy convertName:[NSString stringWithUTF8String:root->value->key]];
    root->value->mapped_key = transfer([converted UTF8String]);
    
    for (unsigned long long i = 0; i < root->descendants->nodes_count; i++) {
        [self reloadR:root->descendants->nodes[i] withStrategy:strategy];
    }
}

- (void) reload:(id<KLPNamingStrategy>) strategy {
    [self reloadR:root_node withStrategy:strategy];
}
@end
