macro "Open_Angle_Measurement [f1]"{

    // fits a spline curve to the bezier curve, then segments it
    // gets all of the points that comprise the new curve and the length of the curve in the x direction
    run( "Fit Spline", "straighten" );
    getSelectionCoordinates(x, y);
    n = x.length;
    run( "Add Selection...", "stroke = blue" );

    // draws the midpoint
    makePoint( x[ n / 2 ],y[ n / 2 ] );
    run( "Add Selection...", "stroke = red" );

    // saves the start and endpoint of the curve respectively as (x1,y1) and (x2,y2)
    for ( i = 0; i < n; i++ )
        if( i == 0 ){
            x1 = x[i];
            y1 = y[i];
        }else if( i == n - 1 ){
            x2 = x[i];
            y2 = y[i];
        };

    // draws 2 lines to create the angle
    makeLine( x1, y1, x[ n / 2], y[ n / 2], x2, y2 );
    run( "Add Selection...", "stroke = black" );

    // calculates the angle created by the two lines
    getSelectionCoordinates(x, y); 
    for ( i = 1; i < n - 1; i++) { 
        dotprod = ( x[ i + 1 ] - x[i] ) * (x[ i - 1 ] - x[i] )+( y[ i + 1 ] - y[i] ) * (y[ i - 1 ] - y[i] ); 
        crossprod = ( x[ i + 1 ] - x[i] ) * ( y[ i - 1 ] - y[i] ) - ( y[ i + 1 ] - y[i] ) * ( x[ i - 1 ] - x[i] ); 
        angle = ( 180 /PI ) * atan2( crossprod, dotprod ); 

        // writes the angle measurement above the drawn angle
        degreesym = fromCharCode( 176 );
        setFont( "SansSerif", 20 );

        // depending on the picture taken, the location of the
        makeText( abs( angle ) + degreesym ,x[i] - 35 ,y[i] - 45 );

        run( "Add Selection...", "stroke = black" );

        run( "Select None" );
    }
}
