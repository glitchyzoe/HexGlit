import processing.pdf.*;

HDrawablePool pool;

HColorPool colors;


void setup(){
	size(800,800);
	H.init(this).background(#000000);
	smooth();

	colors = new HColorPool()
	.add(#32184E)
	.add(#532768)
	.add(#604A99)
	.add(#8D297C)
	.add(#A95393)
	//.add(#D09286)
	//.add(#45A6D3)
	.add(#cccccc)
	.add(#222222)
	.add(#ffffff)

	//.add(#AD7BC0)
	//.add(#AD6EAE)
	//.add(#B2D1E6)
	//.add(#B6A5CB)
	//.add(#CFE7EC)
	//.add(#EAE6D9)
	
	;  

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HShape("hex2.svg"))
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeWeight(1)
						//.stroke(#000000)
			
						.noStroke()
						.size( (int)random(5, 30) )
						.rotate( (int)random(360) )
						.loc( (int)random(width), (int)random(height) )
						.anchorAt(H.CENTER)
						.alpha( (int)random(10, 200) )
						;

						d.randomColors(colors.fillOnly());
					}
				}
			)
			.requestAll();
		
		saveHiRes(2);
		noLoop();

		saveVector();
		noLoop();
		
	}

void draw() {
	H.drawStage();
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "glit.pdf"); 
	

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); //PGraphics, uses3D, alpha	

	}

	endRecord();
}

void saveHiRes(int scaleFactor) {
	PGraphics hires = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);
	beginRecord(hires);
	hires.scale(scaleFactor);

	if (hires == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(hires, false, 1); //PGraphics, uses3D, alpha	

	}

	endRecord();
	hires.save("glit.png");

}
