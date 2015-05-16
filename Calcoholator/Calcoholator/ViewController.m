//
//  ViewController.m
//  Calcoholator
//
//  Created by Trevor Vieweg on 5/16/15.
//  Copyright (c) 2015 Trevor Vieweg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    [self calcAndUpdateAlcolator];
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Value of slider changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self calcAndUpdateAlcolator];
}

- (IBAction)tapGestureDidFire:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
}

- (void) calcAndUpdateAlcolator {
    
    //alcohol constants
    const int ouncesInBeerGlass = 12;
    const float ouncesInOneWineGlass = 5;
    const float alcoholPercentageOfWine = 0.13;
    
    //Beer calculation
    int numberOfBeers = self.beerCountSlider.value;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = alcoholPercentageOfBeer * ouncesInBeerGlass;
    float ouncesOfAlcoholTotal = numberOfBeers * ouncesOfAlcoholPerBeer;
    
    //Wine calculation
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    //Decide to use plural or singluar
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular of beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular of glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    //update labels
    self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%d %@", numberOfBeers, beerText];
    
    //if no alcohol percentage has been entered, keep instructions in results label.
    if (alcoholPercentageOfBeer != 0) {
        NSString *resultText = [NSString stringWithFormat:@"%d %@ contains as much alcohol as %.1f %@ of wine", numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
        
        self.resultLabel.text = resultText;
        
        self.title = [NSString stringWithFormat:@"Wine (%.1f %@)", numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    }
}

@end
