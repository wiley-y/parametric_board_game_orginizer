

// Which part of the design to show
// Parts box, deck box
generatedPart = "Gridded_Box"; // [Gridded_Box, Lid, none, test]

/* [Global Parameters] */

Grid_Size_X = 140; 
Grid_Size_Y = 100; // 0.1
Grid_Size_Z = 29; 

Horizontal_Grid_Devisions = 2;
Vertical_Grid_Devisions = 1;

/* [Lid Parameters] */

Lid_Tolerance = 0.6;
Locking_Ridge_Size = 0.5;
Box_Lip_Height=8; 
Additional_Lid_Height = 1;
Lid_As_Box_Stand_Height = 5; //0.1

/* [Wall Parameters] */

Lid_Thickness = 1.5;
Wall_Thickness = 1;
Outer_Edge_Rounding = 0; //[0:0.0001:0.02]

/* [Cavity Settings] */

Default_Grid_Type = "Box"; //[Box, Deck, Scoop]
Box_Edge_Rounding = 0; //[0:0.0001:0.02]
Scoop_Edge_Rounding = 0.25; // [0:0.01:0.5]

/* [Custom Cavity Settings] */

Deck_Edge_Opening = 0.8; //[0:0.05:1]
Deck_Edge_Slope = 0.8; //[0:0.05:1]

/* [First Custom Grid Settings] */
First_Custom_Grid_Toggle = false;
First_Custom_Grid_Position = 0;
First_Custom_Grid_Size = [2, 2];
First_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
First_Custom_Deck_Edge_Left = true;
First_Custom_Deck_Edge_Top = true;
First_Custom_Deck_Edge_Bottom = true;
First_Custom_Deck_Edge_Right = true;

/* [Second Custom Grid Settings] */
Second_Custom_Grid_Toggle = false;
Second_Custom_Grid_Position = 1;
Second_Custom_Grid_Size = [1, 1];
Second_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Second_Custom_Deck_Edge_Left = true;
Second_Custom_Deck_Edge_Top = true;
Second_Custom_Deck_Edge_Bottom = true;
Second_Custom_Deck_Edge_Right = true;

/* [Third Custom Grid Settings] */
Third_Custom_Grid_Toggle = false;
Third_Custom_Grid_Position = 1;
Third_Custom_Grid_Size = [1, 1];
Third_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Third_Custom_Deck_Edge_Left = true;
Third_Custom_Deck_Edge_Top = true;
Third_Custom_Deck_Edge_Bottom = true;
Third_Custom_Deck_Edge_Right = true;

/* [Fourth Custom Grid Settings] */
Fourth_Custom_Grid_Toggle = false;
Fourth_Custom_Grid_Position = 1;
Fourth_Custom_Grid_Size = [1, 1];
Fourth_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Fourth_Custom_Deck_Edge_Left = true;
Fourth_Custom_Deck_Edge_Top = true;
Fourth_Custom_Deck_Edge_Bottom = true;
Fourth_Custom_Deck_Edge_Right = true;

/* [Fifth Custom Grid Settings] */
Fifth_Custom_Grid_Toggle = false;
Fifth_Custom_Grid_Position = 1;
Fifth_Custom_Grid_Size = [1, 1];
Fifth_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Fifth_Custom_Deck_Edge_Left = true;
Fifth_Custom_Deck_Edge_Top = true;
Fifth_Custom_Deck_Edge_Bottom = true;
Fifth_Custom_Deck_Edge_Right = true;

/* [Sixth Custom Grid Settings] */
Sixth_Custom_Grid_Toggle = false;
Sixth_Custom_Grid_Position = 1;
Sixth_Custom_Grid_Size = [1, 1];
Sixth_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Sixth_Custom_Deck_Edge_Left = true;
Sixth_Custom_Deck_Edge_Top = true;
Sixth_Custom_Deck_Edge_Bottom = true;
Sixth_Custom_Deck_Edge_Right = true;

/* [Seventh Custom Grid Settings] */
Seventh_Custom_Grid_Toggle = false;
Seventh_Custom_Grid_Position = 1;
Seventh_Custom_Grid_Size = [1, 1];
Seventh_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Seventh_Custom_Deck_Edge_Left = true;
Seventh_Custom_Deck_Edge_Top = true;
Seventh_Custom_Deck_Edge_Bottom = true;
Seventh_Custom_Deck_Edge_Right = true;

/* [Eighth Custom Grid Settings] */
Eighth_Custom_Grid_Toggle = false;
Eighth_Custom_Grid_Position = 1;
Eighth_Custom_Grid_Size = [1, 1];
Eighth_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Eighth_Custom_Deck_Edge_Left = true;
Eighth_Custom_Deck_Edge_Top = true;
Eighth_Custom_Deck_Edge_Bottom = true;
Eighth_Custom_Deck_Edge_Right = true;

/* [Ninth Custom Grid Settings] */
Ninth_Custom_Grid_Toggle = false;
Ninth_Custom_Grid_Position = 1;
Ninth_Custom_Grid_Size = [1, 1];
Ninth_Custom_Grid_Type = "Box"; //[Box, Scoop, Deck, Fill]
Ninth_Custom_Deck_Edge_Left = true;
Ninth_Custom_Deck_Edge_Top = true;
Ninth_Custom_Deck_Edge_Bottom = true;
Ninth_Custom_Deck_Edge_Right = true;

/* [Additional Options] */
numberGuides = true;
enforceOuterWall = false;

//////////////////////////////////////

include <BOSL/constants.scad>
use <BOSL/joiners.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <BOSL/math.scad>

$fa = $preview ? 20 : 1;
$fs = 0.4;

module GridSizeWarning (nGridSize, Grid_Size)
{
    if(Grid_Size[0] > Horizontal_Grid_Devisions || Grid_Size[1] > Vertical_Grid_Devisions) 
        echo("Warning : ", nGridSize, "Grid size cannot exceed Grid Devisions");
}
GridSizeWarning("First", First_Custom_Grid_Size);
GridSizeWarning("Second", Second_Custom_Grid_Size);
GridSizeWarning("Third", Third_Custom_Grid_Size);
GridSizeWarning("Fourth", Fourth_Custom_Grid_Size);
GridSizeWarning("Fifth", Fifth_Custom_Grid_Size);
GridSizeWarning("Sixth", Sixth_Custom_Grid_Size);
GridSizeWarning("Seventh", Seventh_Custom_Grid_Size);
GridSizeWarning("Eighth", Eighth_Custom_Grid_Size);
GridSizeWarning("Ninth", Ninth_Custom_Grid_Size);

//process size variables to create the size of the outer box
Grid_Size_Vector = concat([Grid_Size_X], [Grid_Size_Y], [Grid_Size_Z]);

function OuterSizeFromGridSize (axis) = 
    axis == "x" ? //test
    (Grid_Size_X * Horizontal_Grid_Devisions) + (Wall_Thickness * (Horizontal_Grid_Devisions+1)) + ((Lid_Thickness + Lid_Tolerance) * 2) //true value
    :
    axis == "y" ? // false value / second test
    (Grid_Size_Y * Vertical_Grid_Devisions) + (Wall_Thickness * (Vertical_Grid_Devisions+1)) + ((Lid_Thickness + Lid_Tolerance) * 2) // second true value
    :
    axis == "z" ? // third test
    (Grid_Size_Z + Wall_Thickness + Lid_Thickness + Lid_Tolerance)
    :
    undef; // if none pass
function InnerBoxFromGridSize (axis) = 
    axis == "x" ? //test
    (Grid_Size_X * Horizontal_Grid_Devisions) + (Wall_Thickness * (Horizontal_Grid_Devisions+1))//true value
    :
    axis == "y" ? // false value / second test
    (Grid_Size_Y * Vertical_Grid_Devisions) + (Wall_Thickness * (Vertical_Grid_Devisions+1))// second true value
    :
    axis == "z" ? // third test
    (Grid_Size_Z + Wall_Thickness)
    :
    undef; // if none pass

x = InnerBoxFromGridSize("x"); // horisontal
y = InnerBoxFromGridSize("y"); // vertical
z = InnerBoxFromGridSize("z");

zTrueDimentions = z + Additional_Lid_Height;

// create an array to make the custom grid settings readable
customCavityArray = concat(
    [ 
        [ First_Custom_Grid_Toggle,     
        First_Custom_Grid_Position,       
        First_Custom_Grid_Size,       
        First_Custom_Grid_Type,
        First_Custom_Deck_Edge_Left,
        First_Custom_Deck_Edge_Top,
        First_Custom_Deck_Edge_Bottom,
        First_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Second_Custom_Grid_Toggle,    
        Second_Custom_Grid_Position,      
        Second_Custom_Grid_Size,      
        Second_Custom_Grid_Type,
        Second_Custom_Deck_Edge_Left,
        Second_Custom_Deck_Edge_Top,
        Second_Custom_Deck_Edge_Bottom,
        Second_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Third_Custom_Grid_Toggle,     
        Third_Custom_Grid_Position,       
        Third_Custom_Grid_Size,       
        Third_Custom_Grid_Type,
        Third_Custom_Deck_Edge_Left,
        Third_Custom_Deck_Edge_Top,
        Third_Custom_Deck_Edge_Bottom,
        Third_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Fourth_Custom_Grid_Toggle,    
        Fourth_Custom_Grid_Position,      
        Fourth_Custom_Grid_Size,      
        Fourth_Custom_Grid_Type,
        Fourth_Custom_Deck_Edge_Left,
        Fourth_Custom_Deck_Edge_Top,
        Fourth_Custom_Deck_Edge_Bottom,
        Fourth_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Fifth_Custom_Grid_Toggle,     
        Fifth_Custom_Grid_Position,       
        Fifth_Custom_Grid_Size,       
        Fifth_Custom_Grid_Type,
        Fifth_Custom_Deck_Edge_Left,
        Fifth_Custom_Deck_Edge_Top,
        Fifth_Custom_Deck_Edge_Bottom,
        Fifth_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Sixth_Custom_Grid_Toggle,     
        Sixth_Custom_Grid_Position,       
        Sixth_Custom_Grid_Size,       
        Sixth_Custom_Grid_Type,
        Sixth_Custom_Deck_Edge_Left,
        Sixth_Custom_Deck_Edge_Top,
        Sixth_Custom_Deck_Edge_Bottom,
        Sixth_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Seventh_Custom_Grid_Toggle,   
        Seventh_Custom_Grid_Position,     
        Seventh_Custom_Grid_Size,     
        Seventh_Custom_Grid_Type,
        Seventh_Custom_Deck_Edge_Left,
        Seventh_Custom_Deck_Edge_Top,
        Seventh_Custom_Deck_Edge_Bottom,
        Seventh_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Eighth_Custom_Grid_Toggle,    
        Eighth_Custom_Grid_Position,      
        Eighth_Custom_Grid_Size,      
        Eighth_Custom_Grid_Type,
        Eighth_Custom_Deck_Edge_Left,
        Eighth_Custom_Deck_Edge_Top,
        Eighth_Custom_Deck_Edge_Bottom,
        Eighth_Custom_Deck_Edge_Right ] 
    ], 
    [ 
        [ Ninth_Custom_Grid_Toggle,     
        Ninth_Custom_Grid_Position,       
        Ninth_Custom_Grid_Size,       
        Ninth_Custom_Grid_Type,
        Ninth_Custom_Deck_Edge_Left,
        Ninth_Custom_Deck_Edge_Top,
        Ninth_Custom_Deck_Edge_Bottom,
        Ninth_Custom_Deck_Edge_Right ] 
    ] 
);

customCavityVerticalSpan = [
    for(i = [0 : len(customCavityArray) - 1])
        [for(i2 = [0 : customCavityArray[i][2][1] - 1])
            customCavityArray[i][0] == true ? // only add to the array if that custom cavity is enabled
            customCavityArray[i][1] + (1 * i2) : undef // if false, set undef
        ]
];
//echo("customCavityVerticalSpan", customCavityVerticalSpan);

customCavityDoNotBuild = [
    for(i = [0 : len(customCavityArray) - 1])
        for(i2 = [0 : customCavityArray[i][2][0] - 1])
            for(i3 = [0 : customCavityArray[i][2][1] - 1])
                customCavityVerticalSpan[i][i3] != undef ?
                customCavityVerticalSpan[i][i3] + (Vertical_Grid_Devisions * (i2))
                :undef
    ];
//echo("customCavityDoNotBuild", customCavityDoNotBuild);

//echo(customCavityArray[0][2][1] - 1);

lockingRidgeSpacing = ((z-Box_Lip_Height)*0.2);

// create an array describing every point in the grid
grid = [for (ix=[0:(Horizontal_Grid_Devisions-1)]) for(iy=[0:Vertical_Grid_Devisions-1]) [(ix), (iy), 0]];
//echo(grid);


module FilledBox(filledBoxSize)
{
    subdevBoxEdges = EDGES_TOP + EDGES_Z_ALL + EDGES_BOTTOM;
    cuboid(
        size=filledBoxSize,
        fillet=Outer_Edge_Rounding * z,
        edges=subdevBoxEdges);
}

module HollowBox() {
    difference() 
    {
        FilledBox(filledBoxSize = [x,y,z]);

            zmove(z/2) zmove(Wall_Thickness)
        cuboid(
            size = [
                (x - (Wall_Thickness*2)),
                (y - (Wall_Thickness*2)),
                z],
            fillet = Box_Edge_Rounding * z,
            edges = EDGES_Z_ALL + EDGES_BOTTOM,
            center = true);
    };
};

fontSize = (x) * 0.04;

module FloatingNumberGuides(cavityPos, xCavitySize, yCavitySize, dimentions) 
{
    textGuide = str(cavityPos);
    move([ // move to spot in grid
        grid[cavityPos][0] * Grid_Size_X,// + Wall_Thickness,
        grid[cavityPos][1] * Grid_Size_Y,// + Wall_Thickness,
        0
        ])
    move([ // align with box
        -grid[0][0] * Grid_Size_X + (Wall_Thickness),///2 - Wall_Thickness),
        -grid[0][1] * Grid_Size_Y + (Wall_Thickness),///2 - Wall_Thickness),
        0
        ])
    zmove(z) ymove(Grid_Size_Y/2) xmove(Grid_Size_X/2) 
    {
    //position number
    linear_extrude(1) text( 
        textGuide, 
        size = fontSize, 
        font = "Liberation Sans",
        halign = "center",
        valign = "center");
    if(dimentions == true) {
        //y dimention
        linear_extrude(1) text( 
            str("y:", (Grid_Size_Y * yCavitySize) + (Wall_Thickness * (yCavitySize-1)), "mm  "), 
            size = fontSize * 0.5, 
            font = "Liberation Sans",
            halign = "right",
            valign = "center");
        //x dimention
        ymove(-fontSize * 0.7 * 1.2)
        linear_extrude(1) text( 
            str("x:", (Grid_Size_X * xCavitySize) + (Wall_Thickness * (xCavitySize-1)), "mm  "), 
            size = fontSize * 0.5, 
            font = "Liberation Sans",
            halign = "center",
            valign = "top");
    }
    };
}

module floatingDimentionGuides() 
{
    //y dimentions
        ymove(y / 2) //move to middle of line
        xmove(-x * 0.05) //move away from the box
    linear_extrude(1) text(
        str("y : ", y + (Lid_Thickness*2) + (Lid_Tolerance*2), "mm"), 
        size = fontSize, 
        font = "Liberation Sans",
        halign = "right",
        valign = "bottom");

    //x dimentions
        xmove(x / 2) //move to middle of line
        ymove(-y * 0.05) //move away from the box
    linear_extrude(1) text(
        str("x : ", x + (Lid_Thickness*2) + (Lid_Tolerance*2), "mm"), 
        size = fontSize, 
        font = "Liberation Sans",
        halign = "center",
        valign = "top");

    //z dimentions
        ymove(-y * 0.05) //move away from the box
        xmove(-x * 0.05) //move away from the box
    linear_extrude(1) text(
        str("z : ", z + Additional_Lid_Height + Lid_Thickness, "mm"), 
        size = fontSize, 
        font = "Liberation Sans",
        halign = "right",
        valign = "top");
}

module CavityFingerTab (fingerTabWidth) 
{
    zmove(-z/2) zmove(Wall_Thickness)
    cyl(
        d = fingerTabWidth,
        h = z,
        fillet1 = fingerTabWidth / 2,
        align = V_UP
    );
}

module SlicedCyl(l, d1, d2, fillet1, thickness)
{
    intersection() {
        //yscale(100)
        cyl(
            l = l,
            d2 = d2,
            d1 = d1,
            fillet1 = (l < (d1/2) ? z/2 : (d1/4))
        );
        cuboid(
            size = ([d2*d1*2, thickness+0.01, d2*d1*2]),
            center = true
        );
    };
}

module TokenBoxCavity(
    cavityPos,  
    xCavitySize,
    yCavitySize, 
    cavityType,
    cavityBoxFillet,
    cavityNumber) 
{
    xCavitySizeMM = (Grid_Size_X * xCavitySize) + (Wall_Thickness * (xCavitySize - 1));
    yCavitySizeMM = (Grid_Size_Y * yCavitySize) + (Wall_Thickness * (yCavitySize - 1));
    //echo(xCavitySize);

        move([ // move to spot in grid
            (grid[cavityPos][0] * Grid_Size_X) + (Wall_Thickness * (grid[cavityPos][0] + 1)),
            (grid[cavityPos][1] * Grid_Size_Y) + (Wall_Thickness * (grid[cavityPos][1] + 1)),
            0
        ])
    union() {

        if(cavityType != "Fill") if(cavityType=="Box" || cavityType == "Deck")
        {
            if(cavityType=="Deck") { // check if deck is enabled
                sliceThickness = Wall_Thickness + Lid_Thickness + Lid_Tolerance;
                for(i = [0:3], // count the loop
                    deckArray = [ // and also encode move array to get the cutouts at the edges of the box
                    [[xCavitySizeMM / 2,                    -(sliceThickness / 2),                  0], "x", 3], //bottom
                    [[xCavitySizeMM / 2,                    (sliceThickness / 2) + yCavitySizeMM,   0], "x", 2], //left
                    [[-(sliceThickness / 2),                yCavitySizeMM / 2,                      0], "y", 1], //top
                    [[(sliceThickness / 2) + xCavitySizeMM, yCavitySizeMM / 2,                      0], "y", 4]  //right
                ]) {
                    if(customCavityArray[cavityNumber][deckArray[2] + 3] == true) {
                            move(deckArray[0])
                            zrot(deckArray[1] == "x" ? 0 : 90) // if x, not rot. if y, 90 degrees rot
                            zmove(Wall_Thickness)
                        SlicedCyl( // build the cutouts at deckArray positions
                            l = z + Wall_Thickness,
                            d2 = Deck_Edge_Opening * (deckArray[1] == "x" ? xCavitySizeMM : yCavitySizeMM),
                            d1 = (Deck_Edge_Opening * Deck_Edge_Slope) * (deckArray[1] == "x" ? xCavitySizeMM : yCavitySizeMM),
                            thickness = sliceThickness
                        );
                    };
                };
            };
            
            zmove(-z/2)
            zmove(Wall_Thickness) // move up for floor
            cuboid(
                size=[xCavitySizeMM, yCavitySizeMM, z],
                fillet=cavityBoxFillet,
                edges=EDGES_Z_ALL+EDGES_BOTTOM,
                center = false);
        };
        if(cavityType=="Scoop")
        {
            // make the longer of the two sides the Grid_Size_Y
            cylCavityLength = xCavitySizeMM>yCavitySizeMM ? xCavitySizeMM : yCavitySizeMM; 
            // make the other value the Grid_Size_X
            cylCavityWidth = cylCavityLength==xCavitySizeMM ? yCavitySizeMM : xCavitySizeMM;
            // orient the Grid_Size_Y along the correct axis
            cylCavityOrient = xCavitySizeMM>yCavitySizeMM ? ORIENT_X : ORIENT_Y;
            
            zmove(z/2)
            zscale((z*2-(Wall_Thickness*2)) / cylCavityWidth)
            cyl(
                l = cylCavityLength,
                d = cylCavityWidth,
                orient = cylCavityOrient,
                fillet = cylCavityWidth*(Scoop_Edge_Rounding),
                align = V_BACK+V_RIGHT);
        };
    };
};

module TokenBoxCavityArray()
{
    for(i = [0:(Vertical_Grid_Devisions * Horizontal_Grid_Devisions)-1]) //build defaults
    {
            if(in_list(i, customCavityDoNotBuild) == true) echo("did not build default cavity ", customCavityDoNotBuild[i]);
            if(in_list(i, customCavityDoNotBuild) != true) 
            { 
                //echo("building default cavity");
                TokenBoxCavity(
                    cavityPos = i,  
                    xCavitySize = 1,
                    yCavitySize = 1, 
                    cavityType = Default_Grid_Type,
                    cavityBoxFillet = Box_Edge_Rounding * z);
                
                # if(numberGuides==true) {
                    FloatingNumberGuides(
                        cavityPos = i, 
                        xCavitySize = 1, 
                        yCavitySize = 1,
                        dimentions = false);
                };
            };
    };
    for(i = [0:len(customCavityArray)]) { // build custom cavities
        if(customCavityArray[i][0] == true)
        {
            TokenBoxCavity(
                    cavityPos = customCavityArray[i][1],  
                    xCavitySize = customCavityArray[i][2][0],
                    yCavitySize = customCavityArray[i][2][1], 
                    cavityType = customCavityArray[i][3],
                    cavityBoxFillet = Box_Edge_Rounding * z,
                    cavityNumber = i);
            
            # if(numberGuides==true) {
                    FloatingNumberGuides(
                        cavityPos = customCavityArray[i][1], 
                        xCavitySize = customCavityArray[i][2][0], 
                        yCavitySize = customCavityArray[i][2][1],
                        dimentions = true);
            };
        };
    };
}

module BoxLip (boxLipTolerance) 
{
    if(Box_Lip_Height != 0)
        cuboid(
            size=[
                x + Lid_Thickness*2 + boxLipTolerance,
                y + Lid_Thickness*2 + boxLipTolerance,
                Box_Lip_Height + (boxLipTolerance*2),
            ],
            fillet=Outer_Edge_Rounding * z,
            edges=EDGES_ALL
        );
};

module LockingRidge (lockingRidgeTolerance)
{
    zmove(-(z/2)) zmove(Box_Lip_Height + (Locking_Ridge_Size)) zmove((z - Box_Lip_Height) * 0.2)
    zmove(Locking_Ridge_Size/2)
    cuboid(
        size = [
            x + (lockingRidgeTolerance * 2) + (Locking_Ridge_Size * 2),
            y + (lockingRidgeTolerance * 2) + (Locking_Ridge_Size * 2), 
            Locking_Ridge_Size
        ],
        fillet = Locking_Ridge_Size/2,
        center = true
    );
}

module SubdevBox ()
{
    difference() {
        move([x/2, y/2, 0]) 
        union() {
            FilledBox(filledBoxSize = [x,y,z]);

            difference() {
                //zmove(-(z/2)) zmove(Box_Lip_Height + (Locking_Ridge_Size)) zmove((z - Box_Lip_Height) * 0.2)
                LockingRidge(0);

                FilledBox(filledBoxSize = [x,y,z]);
            };

            if(enforceOuterWall==true) HollowBox();
    
            zmove(-(z/2)) zmove(Box_Lip_Height/2)
            BoxLip(Lid_Tolerance);
        };

        TokenBoxCavityArray();
    };
};

module AdornedBox() 
{
    if(enforceOuterWall==true) HollowBox();
    
    zmove(-(z/2)) zmove(Box_Lip_Height/2)
    BoxLip(Lid_Tolerance);

}

module Box ()
{
    difference() {
        zmove(z/2)
        SubdevBox();

        if(Lid_As_Box_Stand_Height != 0)
            move([x/2, y/2, -z/2]) // align with box
            zmove(Lid_As_Box_Stand_Height) // move in by the variable amount
            difference() {
                FilledBox(filledBoxSize = [x*2 ,y*2 , z - 0.01]);
                FilledBox(filledBoxSize = [x,y,z]);
            };
    };
}

module Lid ()
{
    difference() {
        zmove(z/2) zmove(Additional_Lid_Height/2) zmove(Lid_Thickness/2) //zmove(-Lid_Tolerance/2)
    difference() {
        cuboid( // outer shell
                size = [
                        x + Lid_Thickness*2 + Lid_Tolerance, 
                        y + Lid_Thickness*2 + Lid_Tolerance, 
                        z + Additional_Lid_Height + Lid_Thickness + Lid_Tolerance],
                    fillet = Outer_Edge_Rounding * z,// * (Additional_Lid_Height + Lid_Thickness + Lid_Tolerance),
                    edges = EDGES_ALL,
                    center = true);

        zmove(-Lid_Thickness) // make room for floor
        cuboid( // inner mask
            size = [
                    x + Lid_Tolerance*2, 
                    y + Lid_Tolerance*2, 
                    z + Additional_Lid_Height + Lid_Tolerance*2],
                fillet = Box_Edge_Rounding* z,// * (Additional_Lid_Height + Lid_Tolerance*2),
                edges = EDGES_Z_ALL + EDGES_BOTTOM);
    };
            zmove(z/2)
            scale([((x + Lid_Tolerance*2) / x), ((y + Lid_Tolerance*2) / y), 1]) 
        AdornedBox();

            zmove(z/2)
            LockingRidge(0);
    };
}

module EchoInformation() 
{
    echo();
    echo("The external dimentions of the box in MM are ... ");
    echo("X =  ", x);
    echo("Y =  ", y);
    echo("Z =  ", z + Additional_Lid_Height);

    echo();
}


if(generatedPart=="Gridded_Box") {
    //zmove(z/2)
    //zrot(-90) // rotate for better readability
    render() 
    Box();
};
if(generatedPart=="Lid") {
    zflip()
    Lid();
};
if(generatedPart=="test"){
    SlicedCyl(
        l = z + Wall_Thickness,
        d2 = 80,
        d1 = 70,
        fillet1 = (z + Wall_Thickness)/2,
        thickness = 1
    );
};
if(generatedPart=="none") {}

%floatingDimentionGuides();

//EchoInformation();