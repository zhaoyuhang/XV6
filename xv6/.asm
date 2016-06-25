
_picviewer:     file format elf32-i386


Disassembly of section .text:

00000000 <compressPic>:

PICNODE pic;
int isRun = 1;

// 压缩图片
void compressPic(int width, int height) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	81 ec 98 00 00 00    	sub    $0x98,%esp
    int x0, y0, x1, x2, y1, y2;
    float fx1, fx2, fy1, fy2;
    int x, y, index;
    RGBQUAD* data;

    w0 = pic.width;
       9:	a1 94 ff 00 00       	mov    0xff94,%eax
       e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    h0 = pic.height;
      11:	a1 98 ff 00 00       	mov    0xff98,%eax
      16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    w1 = width;
      19:	8b 45 08             	mov    0x8(%ebp),%eax
      1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    h1 = height;
      1f:	8b 45 0c             	mov    0xc(%ebp),%eax
      22:	89 45 dc             	mov    %eax,-0x24(%ebp)

    fw = w0 * 1.0 / w1;
      25:	db 45 e8             	fildl  -0x18(%ebp)
      28:	db 45 e0             	fildl  -0x20(%ebp)
      2b:	de f9                	fdivrp %st,%st(1)
      2d:	d9 5d d8             	fstps  -0x28(%ebp)
    fh = h0 * 1.0 / h1;
      30:	db 45 e4             	fildl  -0x1c(%ebp)
      33:	db 45 dc             	fildl  -0x24(%ebp)
      36:	de f9                	fdivrp %st,%st(1)
      38:	d9 5d d4             	fstps  -0x2c(%ebp)

    index = 0;
      3b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));
      42:	8b 45 e0             	mov    -0x20(%ebp),%eax
      45:	0f af 45 dc          	imul   -0x24(%ebp),%eax
      49:	c1 e0 02             	shl    $0x2,%eax
      4c:	89 04 24             	mov    %eax,(%esp)
      4f:	e8 73 2e 00 00       	call   2ec7 <malloc>
      54:	89 45 d0             	mov    %eax,-0x30(%ebp)
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
      57:	8b 55 e0             	mov    -0x20(%ebp),%edx
      5a:	8b 45 dc             	mov    -0x24(%ebp),%eax
      5d:	0f af c2             	imul   %edx,%eax
      60:	c1 e0 02             	shl    $0x2,%eax
      63:	89 44 24 08          	mov    %eax,0x8(%esp)
      67:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      6e:	00 
      6f:	8b 45 d0             	mov    -0x30(%ebp),%eax
      72:	89 04 24             	mov    %eax,(%esp)
      75:	e8 cc 27 00 00       	call   2846 <memset>
    for (y = 0; y < h1; ++y) {
      7a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      81:	e9 07 03 00 00       	jmp    38d <compressPic+0x38d>
        y0 = y*fh;
      86:	db 45 f0             	fildl  -0x10(%ebp)
      89:	d8 4d d4             	fmuls  -0x2c(%ebp)
      8c:	d9 bd 7e ff ff ff    	fnstcw -0x82(%ebp)
      92:	0f b7 85 7e ff ff ff 	movzwl -0x82(%ebp),%eax
      99:	b4 0c                	mov    $0xc,%ah
      9b:	66 89 85 7c ff ff ff 	mov    %ax,-0x84(%ebp)
      a2:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
      a8:	db 5d cc             	fistpl -0x34(%ebp)
      ab:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
        y1 = (int)y0;
      b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
      b4:	89 45 c8             	mov    %eax,-0x38(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;
      b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      ba:	83 e8 01             	sub    $0x1,%eax
      bd:	3b 45 c8             	cmp    -0x38(%ebp),%eax
      c0:	74 08                	je     ca <compressPic+0xca>
      c2:	8b 45 c8             	mov    -0x38(%ebp),%eax
      c5:	83 c0 01             	add    $0x1,%eax
      c8:	eb 03                	jmp    cd <compressPic+0xcd>
      ca:	8b 45 c8             	mov    -0x38(%ebp),%eax
      cd:	89 45 c4             	mov    %eax,-0x3c(%ebp)

        fy1 = y1-y0;
      d0:	8b 45 cc             	mov    -0x34(%ebp),%eax
      d3:	8b 55 c8             	mov    -0x38(%ebp),%edx
      d6:	29 c2                	sub    %eax,%edx
      d8:	89 d0                	mov    %edx,%eax
      da:	89 45 80             	mov    %eax,-0x80(%ebp)
      dd:	db 45 80             	fildl  -0x80(%ebp)
      e0:	d9 5d c0             	fstps  -0x40(%ebp)
        fy2 = 1.0f-fy1;
      e3:	d9 e8                	fld1   
      e5:	d8 65 c0             	fsubs  -0x40(%ebp)
      e8:	d9 5d bc             	fstps  -0x44(%ebp)

        for (x = 0; x < w1; ++x) {
      eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      f2:	e9 86 02 00 00       	jmp    37d <compressPic+0x37d>
            x0 = x*fw;
      f7:	db 45 f4             	fildl  -0xc(%ebp)
      fa:	d8 4d d8             	fmuls  -0x28(%ebp)
      fd:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     103:	db 5d b8             	fistpl -0x48(%ebp)
     106:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
            x1 = (int)x0;
     10c:	8b 45 b8             	mov    -0x48(%ebp),%eax
     10f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
            x2 = (x1 == w0-1) ? x1 : x1 + 1;
     112:	8b 45 e8             	mov    -0x18(%ebp),%eax
     115:	83 e8 01             	sub    $0x1,%eax
     118:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
     11b:	74 08                	je     125 <compressPic+0x125>
     11d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     120:	83 c0 01             	add    $0x1,%eax
     123:	eb 03                	jmp    128 <compressPic+0x128>
     125:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     128:	89 45 b0             	mov    %eax,-0x50(%ebp)

            fx1 = y1-y0;
     12b:	8b 45 cc             	mov    -0x34(%ebp),%eax
     12e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     131:	29 c2                	sub    %eax,%edx
     133:	89 d0                	mov    %edx,%eax
     135:	89 45 80             	mov    %eax,-0x80(%ebp)
     138:	db 45 80             	fildl  -0x80(%ebp)
     13b:	d9 5d ac             	fstps  -0x54(%ebp)
            fx2 = 1.0f-fx1;
     13e:	d9 e8                	fld1   
     140:	d8 65 ac             	fsubs  -0x54(%ebp)
     143:	d9 5d a8             	fstps  -0x58(%ebp)

            float s1 = fx1*fy1;
     146:	d9 45 ac             	flds   -0x54(%ebp)
     149:	d8 4d c0             	fmuls  -0x40(%ebp)
     14c:	d9 5d a4             	fstps  -0x5c(%ebp)
            float s2 = fx2*fy1;
     14f:	d9 45 a8             	flds   -0x58(%ebp)
     152:	d8 4d c0             	fmuls  -0x40(%ebp)
     155:	d9 5d a0             	fstps  -0x60(%ebp)
            float s3 = fx2*fy2;
     158:	d9 45 a8             	flds   -0x58(%ebp)
     15b:	d8 4d bc             	fmuls  -0x44(%ebp)
     15e:	d9 5d 9c             	fstps  -0x64(%ebp)
            float s4 = fx1*fy2;
     161:	d9 45 ac             	flds   -0x54(%ebp)
     164:	d8 4d bc             	fmuls  -0x44(%ebp)
     167:	d9 5d 98             	fstps  -0x68(%ebp)

            RGBQUAD p1, p2, p3, p4;
            p1 = pic.data[x1+y1*w0];
     16a:	8b 15 90 ff 00 00    	mov    0xff90,%edx
     170:	8b 45 c8             	mov    -0x38(%ebp),%eax
     173:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     177:	89 c1                	mov    %eax,%ecx
     179:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     17c:	01 c8                	add    %ecx,%eax
     17e:	c1 e0 02             	shl    $0x2,%eax
     181:	01 d0                	add    %edx,%eax
     183:	8b 00                	mov    (%eax),%eax
     185:	89 45 94             	mov    %eax,-0x6c(%ebp)
            p2 = pic.data[x2+y1*w0];
     188:	8b 15 90 ff 00 00    	mov    0xff90,%edx
     18e:	8b 45 c8             	mov    -0x38(%ebp),%eax
     191:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     195:	89 c1                	mov    %eax,%ecx
     197:	8b 45 b0             	mov    -0x50(%ebp),%eax
     19a:	01 c8                	add    %ecx,%eax
     19c:	c1 e0 02             	shl    $0x2,%eax
     19f:	01 d0                	add    %edx,%eax
     1a1:	8b 00                	mov    (%eax),%eax
     1a3:	89 45 90             	mov    %eax,-0x70(%ebp)
            p3 = pic.data[x1+y2*w0];
     1a6:	8b 15 90 ff 00 00    	mov    0xff90,%edx
     1ac:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     1af:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1b3:	89 c1                	mov    %eax,%ecx
     1b5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     1b8:	01 c8                	add    %ecx,%eax
     1ba:	c1 e0 02             	shl    $0x2,%eax
     1bd:	01 d0                	add    %edx,%eax
     1bf:	8b 00                	mov    (%eax),%eax
     1c1:	89 45 8c             	mov    %eax,-0x74(%ebp)
            p4 = pic.data[x2+y2*w0];
     1c4:	8b 15 90 ff 00 00    	mov    0xff90,%edx
     1ca:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     1cd:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1d1:	89 c1                	mov    %eax,%ecx
     1d3:	8b 45 b0             	mov    -0x50(%ebp),%eax
     1d6:	01 c8                	add    %ecx,%eax
     1d8:	c1 e0 02             	shl    $0x2,%eax
     1db:	01 d0                	add    %edx,%eax
     1dd:	8b 00                	mov    (%eax),%eax
     1df:	89 45 88             	mov    %eax,-0x78(%ebp)

            data[index].rgbRed = (BYTE)(p1.rgbRed*s3 + p2.rgbRed*s4 + p3.rgbRed*s2 + p4.rgbRed*s1);
     1e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     1ec:	8b 45 d0             	mov    -0x30(%ebp),%eax
     1ef:	01 c2                	add    %eax,%edx
     1f1:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     1f5:	0f b6 c0             	movzbl %al,%eax
     1f8:	89 45 80             	mov    %eax,-0x80(%ebp)
     1fb:	db 45 80             	fildl  -0x80(%ebp)
     1fe:	d8 4d 9c             	fmuls  -0x64(%ebp)
     201:	0f b6 45 92          	movzbl -0x6e(%ebp),%eax
     205:	0f b6 c0             	movzbl %al,%eax
     208:	89 45 80             	mov    %eax,-0x80(%ebp)
     20b:	db 45 80             	fildl  -0x80(%ebp)
     20e:	d8 4d 98             	fmuls  -0x68(%ebp)
     211:	de c1                	faddp  %st,%st(1)
     213:	0f b6 45 8e          	movzbl -0x72(%ebp),%eax
     217:	0f b6 c0             	movzbl %al,%eax
     21a:	89 45 80             	mov    %eax,-0x80(%ebp)
     21d:	db 45 80             	fildl  -0x80(%ebp)
     220:	d8 4d a0             	fmuls  -0x60(%ebp)
     223:	de c1                	faddp  %st,%st(1)
     225:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
     229:	0f b6 c0             	movzbl %al,%eax
     22c:	89 45 80             	mov    %eax,-0x80(%ebp)
     22f:	db 45 80             	fildl  -0x80(%ebp)
     232:	d8 4d a4             	fmuls  -0x5c(%ebp)
     235:	de c1                	faddp  %st,%st(1)
     237:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     23d:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     243:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     249:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     250:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = (BYTE)(p1.rgbGreen*s3 + p2.rgbGreen*s4 + p3.rgbGreen*s2 + p4.rgbGreen*s1);
     253:	8b 45 ec             	mov    -0x14(%ebp),%eax
     256:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     25d:	8b 45 d0             	mov    -0x30(%ebp),%eax
     260:	01 c2                	add    %eax,%edx
     262:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     266:	0f b6 c0             	movzbl %al,%eax
     269:	89 45 80             	mov    %eax,-0x80(%ebp)
     26c:	db 45 80             	fildl  -0x80(%ebp)
     26f:	d8 4d 9c             	fmuls  -0x64(%ebp)
     272:	0f b6 45 91          	movzbl -0x6f(%ebp),%eax
     276:	0f b6 c0             	movzbl %al,%eax
     279:	89 45 80             	mov    %eax,-0x80(%ebp)
     27c:	db 45 80             	fildl  -0x80(%ebp)
     27f:	d8 4d 98             	fmuls  -0x68(%ebp)
     282:	de c1                	faddp  %st,%st(1)
     284:	0f b6 45 8d          	movzbl -0x73(%ebp),%eax
     288:	0f b6 c0             	movzbl %al,%eax
     28b:	89 45 80             	mov    %eax,-0x80(%ebp)
     28e:	db 45 80             	fildl  -0x80(%ebp)
     291:	d8 4d a0             	fmuls  -0x60(%ebp)
     294:	de c1                	faddp  %st,%st(1)
     296:	0f b6 45 89          	movzbl -0x77(%ebp),%eax
     29a:	0f b6 c0             	movzbl %al,%eax
     29d:	89 45 80             	mov    %eax,-0x80(%ebp)
     2a0:	db 45 80             	fildl  -0x80(%ebp)
     2a3:	d8 4d a4             	fmuls  -0x5c(%ebp)
     2a6:	de c1                	faddp  %st,%st(1)
     2a8:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     2ae:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     2b4:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     2ba:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     2c1:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = (BYTE)(p1.rgbBlue*s3 + p2.rgbBlue*s4 + p3.rgbBlue*s2 + p4.rgbBlue*s1);
     2c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     2c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     2ce:	8b 45 d0             	mov    -0x30(%ebp),%eax
     2d1:	01 c2                	add    %eax,%edx
     2d3:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     2d7:	0f b6 c0             	movzbl %al,%eax
     2da:	89 45 80             	mov    %eax,-0x80(%ebp)
     2dd:	db 45 80             	fildl  -0x80(%ebp)
     2e0:	d8 4d 9c             	fmuls  -0x64(%ebp)
     2e3:	0f b6 45 90          	movzbl -0x70(%ebp),%eax
     2e7:	0f b6 c0             	movzbl %al,%eax
     2ea:	89 45 80             	mov    %eax,-0x80(%ebp)
     2ed:	db 45 80             	fildl  -0x80(%ebp)
     2f0:	d8 4d 98             	fmuls  -0x68(%ebp)
     2f3:	de c1                	faddp  %st,%st(1)
     2f5:	0f b6 45 8c          	movzbl -0x74(%ebp),%eax
     2f9:	0f b6 c0             	movzbl %al,%eax
     2fc:	89 45 80             	mov    %eax,-0x80(%ebp)
     2ff:	db 45 80             	fildl  -0x80(%ebp)
     302:	d8 4d a0             	fmuls  -0x60(%ebp)
     305:	de c1                	faddp  %st,%st(1)
     307:	0f b6 45 88          	movzbl -0x78(%ebp),%eax
     30b:	0f b6 c0             	movzbl %al,%eax
     30e:	89 45 80             	mov    %eax,-0x80(%ebp)
     311:	db 45 80             	fildl  -0x80(%ebp)
     314:	d8 4d a4             	fmuls  -0x5c(%ebp)
     317:	de c1                	faddp  %st,%st(1)
     319:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     31f:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     325:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     32b:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     332:	88 02                	mov    %al,(%edx)

            data[index].rgbRed = p1.rgbRed;
     334:	8b 45 ec             	mov    -0x14(%ebp),%eax
     337:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     33e:	8b 45 d0             	mov    -0x30(%ebp),%eax
     341:	01 c2                	add    %eax,%edx
     343:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     347:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = p1.rgbGreen;
     34a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     34d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     354:	8b 45 d0             	mov    -0x30(%ebp),%eax
     357:	01 c2                	add    %eax,%edx
     359:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     35d:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = p1.rgbBlue;
     360:	8b 45 ec             	mov    -0x14(%ebp),%eax
     363:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     36a:	8b 45 d0             	mov    -0x30(%ebp),%eax
     36d:	01 c2                	add    %eax,%edx
     36f:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     373:	88 02                	mov    %al,(%edx)

            ++index;
     375:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;

        fy1 = y1-y0;
        fy2 = 1.0f-fy1;

        for (x = 0; x < w1; ++x) {
     379:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     37d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     380:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     383:	0f 8c 6e fd ff ff    	jl     f7 <compressPic+0xf7>
    fh = h0 * 1.0 / h1;

    index = 0;
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
    for (y = 0; y < h1; ++y) {
     389:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     38d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     390:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     393:	0f 8c ed fc ff ff    	jl     86 <compressPic+0x86>

            ++index;
        }
    }

    freepic(&pic);
     399:	c7 04 24 90 ff 00 00 	movl   $0xff90,(%esp)
     3a0:	e8 28 1a 00 00       	call   1dcd <freepic>
    pic.data = data;
     3a5:	8b 45 d0             	mov    -0x30(%ebp),%eax
     3a8:	a3 90 ff 00 00       	mov    %eax,0xff90
    pic.width = width;
     3ad:	8b 45 08             	mov    0x8(%ebp),%eax
     3b0:	a3 94 ff 00 00       	mov    %eax,0xff94
    pic.height = height;
     3b5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b8:	a3 98 ff 00 00       	mov    %eax,0xff98
}
     3bd:	c9                   	leave  
     3be:	c3                   	ret    

000003bf <modifyPic>:

void modifyPic(Context context) {
     3bf:	55                   	push   %ebp
     3c0:	89 e5                	mov    %esp,%ebp
     3c2:	83 ec 48             	sub    $0x48,%esp
    int c_width, c_height;
    int pic_width, pic_height;

    c_width = context.width;
     3c5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    c_height = context.height;
     3cb:	8b 45 10             	mov    0x10(%ebp),%eax
     3ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
    pic_width = pic.width;
     3d1:	a1 94 ff 00 00       	mov    0xff94,%eax
     3d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pic_height = pic.height;
     3d9:	a1 98 ff 00 00       	mov    0xff98,%eax
     3de:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if (pic_width < c_width && pic_height < c_height) {
     3e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3e4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     3e7:	7d 0d                	jge    3f6 <modifyPic+0x37>
     3e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     3ec:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     3ef:	7d 05                	jge    3f6 <modifyPic+0x37>
        return;
     3f1:	e9 b6 00 00 00       	jmp    4ac <modifyPic+0xed>
    }

    float scale_p, scale_c;
    scale_p = pic_width * 1.0 / pic_height;
     3f6:	db 45 f4             	fildl  -0xc(%ebp)
     3f9:	db 45 f0             	fildl  -0x10(%ebp)
     3fc:	de f9                	fdivrp %st,%st(1)
     3fe:	d9 5d e4             	fstps  -0x1c(%ebp)
    scale_c = c_width * 1.0 / c_height;
     401:	db 45 ec             	fildl  -0x14(%ebp)
     404:	db 45 e8             	fildl  -0x18(%ebp)
     407:	de f9                	fdivrp %st,%st(1)
     409:	d9 5d e0             	fstps  -0x20(%ebp)

    if (scale_p <= scale_c) {
     40c:	d9 45 e0             	flds   -0x20(%ebp)
     40f:	d9 45 e4             	flds   -0x1c(%ebp)
     412:	d9 c9                	fxch   %st(1)
     414:	df e9                	fucomip %st(1),%st
     416:	dd d8                	fstp   %st(0)
     418:	72 30                	jb     44a <modifyPic+0x8b>
        pic_width = scale_p * (c_height-10);
     41a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     41d:	83 e8 0a             	sub    $0xa,%eax
     420:	89 45 d0             	mov    %eax,-0x30(%ebp)
     423:	db 45 d0             	fildl  -0x30(%ebp)
     426:	d8 4d e4             	fmuls  -0x1c(%ebp)
     429:	d9 7d ce             	fnstcw -0x32(%ebp)
     42c:	0f b7 45 ce          	movzwl -0x32(%ebp),%eax
     430:	b4 0c                	mov    $0xc,%ah
     432:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
     436:	d9 6d cc             	fldcw  -0x34(%ebp)
     439:	db 5d f4             	fistpl -0xc(%ebp)
     43c:	d9 6d ce             	fldcw  -0x32(%ebp)
        pic_height = c_height-10;
     43f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     442:	83 e8 0a             	sub    $0xa,%eax
     445:	89 45 f0             	mov    %eax,-0x10(%ebp)
     448:	eb 2e                	jmp    478 <modifyPic+0xb9>
    } else {
        pic_height = (c_width-5) / scale_p;
     44a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     44d:	83 e8 05             	sub    $0x5,%eax
     450:	89 45 d0             	mov    %eax,-0x30(%ebp)
     453:	db 45 d0             	fildl  -0x30(%ebp)
     456:	d8 75 e4             	fdivs  -0x1c(%ebp)
     459:	d9 7d ce             	fnstcw -0x32(%ebp)
     45c:	0f b7 45 ce          	movzwl -0x32(%ebp),%eax
     460:	b4 0c                	mov    $0xc,%ah
     462:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
     466:	d9 6d cc             	fldcw  -0x34(%ebp)
     469:	db 5d f0             	fistpl -0x10(%ebp)
     46c:	d9 6d ce             	fldcw  -0x32(%ebp)
        pic_width = c_width-5;
     46f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     472:	83 e8 05             	sub    $0x5,%eax
     475:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    printf(0, "modifyPic: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
     478:	8b 45 f0             	mov    -0x10(%ebp),%eax
     47b:	89 44 24 0c          	mov    %eax,0xc(%esp)
     47f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     482:	89 44 24 08          	mov    %eax,0x8(%esp)
     486:	c7 44 24 04 40 92 00 	movl   $0x9240,0x4(%esp)
     48d:	00 
     48e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     495:	e8 41 27 00 00       	call   2bdb <printf>

    compressPic(pic_width, pic_height);
     49a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     49d:	89 44 24 04          	mov    %eax,0x4(%esp)
     4a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a4:	89 04 24             	mov    %eax,(%esp)
     4a7:	e8 54 fb ff ff       	call   0 <compressPic>
}
     4ac:	c9                   	leave  
     4ad:	c3                   	ret    

000004ae <drawPicViewerWnd>:

// 绘制窗口
void drawPicViewerWnd(Context context) {
     4ae:	55                   	push   %ebp
     4af:	89 e5                	mov    %esp,%ebp
     4b1:	83 ec 38             	sub    $0x38,%esp
    int width, height;

    width = context.width;
     4b4:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    height = context.height;
     4ba:	8b 45 10             	mov    0x10(%ebp),%eax
     4bd:	89 45 f0             	mov    %eax,-0x10(%ebp)

    fill_rect(context, 0, 0, width, height, 0xFFFF);
     4c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c6:	c7 44 24 1c ff ff 00 	movl   $0xffff,0x1c(%esp)
     4cd:	00 
     4ce:	89 54 24 18          	mov    %edx,0x18(%esp)
     4d2:	89 44 24 14          	mov    %eax,0x14(%esp)
     4d6:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     4dd:	00 
     4de:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     4e5:	00 
     4e6:	8b 45 08             	mov    0x8(%ebp),%eax
     4e9:	89 04 24             	mov    %eax,(%esp)
     4ec:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ef:	89 44 24 04          	mov    %eax,0x4(%esp)
     4f3:	8b 45 10             	mov    0x10(%ebp),%eax
     4f6:	89 44 24 08          	mov    %eax,0x8(%esp)
     4fa:	e8 53 07 00 00       	call   c52 <fill_rect>

    draw_line(context, 0, 0, width-1, 0, BORDERLINE_COLOR);
     4ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     502:	83 e8 01             	sub    $0x1,%eax
     505:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     50c:	00 
     50d:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     514:	00 
     515:	89 44 24 14          	mov    %eax,0x14(%esp)
     519:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     520:	00 
     521:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     528:	00 
     529:	8b 45 08             	mov    0x8(%ebp),%eax
     52c:	89 04 24             	mov    %eax,(%esp)
     52f:	8b 45 0c             	mov    0xc(%ebp),%eax
     532:	89 44 24 04          	mov    %eax,0x4(%esp)
     536:	8b 45 10             	mov    0x10(%ebp),%eax
     539:	89 44 24 08          	mov    %eax,0x8(%esp)
     53d:	e8 85 0e 00 00       	call   13c7 <draw_line>
    draw_line(context, width-1, 0, width-1, height-1, BORDERLINE_COLOR);
     542:	8b 45 f0             	mov    -0x10(%ebp),%eax
     545:	8d 48 ff             	lea    -0x1(%eax),%ecx
     548:	8b 45 f4             	mov    -0xc(%ebp),%eax
     54b:	8d 50 ff             	lea    -0x1(%eax),%edx
     54e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     551:	83 e8 01             	sub    $0x1,%eax
     554:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     55b:	00 
     55c:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     560:	89 54 24 14          	mov    %edx,0x14(%esp)
     564:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     56b:	00 
     56c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     570:	8b 45 08             	mov    0x8(%ebp),%eax
     573:	89 04 24             	mov    %eax,(%esp)
     576:	8b 45 0c             	mov    0xc(%ebp),%eax
     579:	89 44 24 04          	mov    %eax,0x4(%esp)
     57d:	8b 45 10             	mov    0x10(%ebp),%eax
     580:	89 44 24 08          	mov    %eax,0x8(%esp)
     584:	e8 3e 0e 00 00       	call   13c7 <draw_line>
    draw_line(context, 0, height-1, width-1, height-1, BORDERLINE_COLOR);
     589:	8b 45 f0             	mov    -0x10(%ebp),%eax
     58c:	8d 48 ff             	lea    -0x1(%eax),%ecx
     58f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     592:	8d 50 ff             	lea    -0x1(%eax),%edx
     595:	8b 45 f0             	mov    -0x10(%ebp),%eax
     598:	83 e8 01             	sub    $0x1,%eax
     59b:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     5a2:	00 
     5a3:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     5a7:	89 54 24 14          	mov    %edx,0x14(%esp)
     5ab:	89 44 24 10          	mov    %eax,0x10(%esp)
     5af:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5b6:	00 
     5b7:	8b 45 08             	mov    0x8(%ebp),%eax
     5ba:	89 04 24             	mov    %eax,(%esp)
     5bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     5c0:	89 44 24 04          	mov    %eax,0x4(%esp)
     5c4:	8b 45 10             	mov    0x10(%ebp),%eax
     5c7:	89 44 24 08          	mov    %eax,0x8(%esp)
     5cb:	e8 f7 0d 00 00       	call   13c7 <draw_line>
    draw_line(context, 0, height-1, 0, 0, BORDERLINE_COLOR);
     5d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5d3:	83 e8 01             	sub    $0x1,%eax
     5d6:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     5dd:	00 
     5de:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     5e5:	00 
     5e6:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
     5ed:	00 
     5ee:	89 44 24 10          	mov    %eax,0x10(%esp)
     5f2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5f9:	00 
     5fa:	8b 45 08             	mov    0x8(%ebp),%eax
     5fd:	89 04 24             	mov    %eax,(%esp)
     600:	8b 45 0c             	mov    0xc(%ebp),%eax
     603:	89 44 24 04          	mov    %eax,0x4(%esp)
     607:	8b 45 10             	mov    0x10(%ebp),%eax
     60a:	89 44 24 08          	mov    %eax,0x8(%esp)
     60e:	e8 b4 0d 00 00       	call   13c7 <draw_line>

    fill_rect(context, 1, 1, width-2, TOPBAR_HEIGHT, TOPBAR_COLOR);
     613:	8b 45 f4             	mov    -0xc(%ebp),%eax
     616:	83 e8 02             	sub    $0x2,%eax
     619:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
     620:	00 
     621:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
     628:	00 
     629:	89 44 24 14          	mov    %eax,0x14(%esp)
     62d:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     634:	00 
     635:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     63c:	00 
     63d:	8b 45 08             	mov    0x8(%ebp),%eax
     640:	89 04 24             	mov    %eax,(%esp)
     643:	8b 45 0c             	mov    0xc(%ebp),%eax
     646:	89 44 24 04          	mov    %eax,0x4(%esp)
     64a:	8b 45 10             	mov    0x10(%ebp),%eax
     64d:	89 44 24 08          	mov    %eax,0x8(%esp)
     651:	e8 fc 05 00 00       	call   c52 <fill_rect>
    puts_str(context, "PictureViewer", 0, WINDOW_WIDTH/2 - 53, 3);
     656:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
     65d:	00 
     65e:	c7 44 24 14 c5 00 00 	movl   $0xc5,0x14(%esp)
     665:	00 
     666:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     66d:	00 
     66e:	c7 44 24 0c 6a 92 00 	movl   $0x926a,0xc(%esp)
     675:	00 
     676:	8b 45 08             	mov    0x8(%ebp),%eax
     679:	89 04 24             	mov    %eax,(%esp)
     67c:	8b 45 0c             	mov    0xc(%ebp),%eax
     67f:	89 44 24 04          	mov    %eax,0x4(%esp)
     683:	8b 45 10             	mov    0x10(%ebp),%eax
     686:	89 44 24 08          	mov    %eax,0x8(%esp)
     68a:	e8 a2 0b 00 00       	call   1231 <puts_str>

    draw_iconlist(context, wndRes, sizeof(wndRes) / sizeof(ICON));
     68f:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     696:	00 
     697:	c7 44 24 0c 60 cc 00 	movl   $0xcc60,0xc(%esp)
     69e:	00 
     69f:	8b 45 08             	mov    0x8(%ebp),%eax
     6a2:	89 04 24             	mov    %eax,(%esp)
     6a5:	8b 45 0c             	mov    0xc(%ebp),%eax
     6a8:	89 44 24 04          	mov    %eax,0x4(%esp)
     6ac:	8b 45 10             	mov    0x10(%ebp),%eax
     6af:	89 44 24 08          	mov    %eax,0x8(%esp)
     6b3:	e8 ea 10 00 00       	call   17a2 <draw_iconlist>
}
     6b8:	c9                   	leave  
     6b9:	c3                   	ret    

000006ba <drawPicViewerContent>:

void drawPicViewerContent(Context context, char* fileName) {
     6ba:	55                   	push   %ebp
     6bb:	89 e5                	mov    %esp,%ebp
     6bd:	83 ec 38             	sub    $0x38,%esp
    int c_width, c_height;
    int pic_width, pic_height;

    c_width = context.width;
     6c0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    c_height = context.height;
     6c6:	8b 45 10             	mov    0x10(%ebp),%eax
     6c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pic_width = pic.width;
     6cc:	a1 94 ff 00 00       	mov    0xff94,%eax
     6d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pic_height = pic.height;
     6d4:	a1 98 ff 00 00       	mov    0xff98,%eax
     6d9:	89 45 e8             	mov    %eax,-0x18(%ebp)

    printf(0, "drawPicViewerContent: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
     6dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6df:	89 44 24 0c          	mov    %eax,0xc(%esp)
     6e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6e6:	89 44 24 08          	mov    %eax,0x8(%esp)
     6ea:	c7 44 24 04 78 92 00 	movl   $0x9278,0x4(%esp)
     6f1:	00 
     6f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     6f9:	e8 dd 24 00 00       	call   2bdb <printf>
    draw_picture(context, pic, (c_width-pic_width) >> 1, TOPBAR_HEIGHT + ((c_height-pic_height) >> 1));
     6fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
     701:	8b 55 f0             	mov    -0x10(%ebp),%edx
     704:	29 c2                	sub    %eax,%edx
     706:	89 d0                	mov    %edx,%eax
     708:	d1 f8                	sar    %eax
     70a:	8d 50 14             	lea    0x14(%eax),%edx
     70d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     710:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     713:	29 c1                	sub    %eax,%ecx
     715:	89 c8                	mov    %ecx,%eax
     717:	d1 f8                	sar    %eax
     719:	89 54 24 1c          	mov    %edx,0x1c(%esp)
     71d:	89 44 24 18          	mov    %eax,0x18(%esp)
     721:	a1 90 ff 00 00       	mov    0xff90,%eax
     726:	89 44 24 0c          	mov    %eax,0xc(%esp)
     72a:	a1 94 ff 00 00       	mov    0xff94,%eax
     72f:	89 44 24 10          	mov    %eax,0x10(%esp)
     733:	a1 98 ff 00 00       	mov    0xff98,%eax
     738:	89 44 24 14          	mov    %eax,0x14(%esp)
     73c:	8b 45 08             	mov    0x8(%ebp),%eax
     73f:	89 04 24             	mov    %eax,(%esp)
     742:	8b 45 0c             	mov    0xc(%ebp),%eax
     745:	89 44 24 04          	mov    %eax,0x4(%esp)
     749:	8b 45 10             	mov    0x10(%ebp),%eax
     74c:	89 44 24 08          	mov    %eax,0x8(%esp)
     750:	e8 9c 0b 00 00       	call   12f1 <draw_picture>
}
     755:	c9                   	leave  
     756:	c3                   	ret    

00000757 <h_closeWnd>:

void h_closeWnd(Point p) {
     757:	55                   	push   %ebp
     758:	89 e5                	mov    %esp,%ebp
    isRun = 0;
     75a:	c7 05 98 cc 00 00 00 	movl   $0x0,0xcc98
     761:	00 00 00 
}
     764:	5d                   	pop    %ebp
     765:	c3                   	ret    

00000766 <addWndEvent>:

void addWndEvent(ClickableManager *cm) {
     766:	55                   	push   %ebp
     767:	89 e5                	mov    %esp,%ebp
     769:	57                   	push   %edi
     76a:	56                   	push   %esi
     76b:	53                   	push   %ebx
     76c:	83 ec 4c             	sub    $0x4c,%esp
    int i;
	int n = sizeof(wndEvents) / sizeof(Handler);
     76f:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)

	for (i = 0; i < n; i++) {
     776:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     77d:	e9 96 00 00 00       	jmp    818 <addWndEvent+0xb2>
		createClickable(cm,
     782:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     785:	8b 1c 85 94 cc 00 00 	mov    0xcc94(,%eax,4),%ebx
     78c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     78f:	6b c0 34             	imul   $0x34,%eax,%eax
     792:	05 80 cc 00 00       	add    $0xcc80,%eax
     797:	8b 78 10             	mov    0x10(%eax),%edi
     79a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     79d:	6b c0 34             	imul   $0x34,%eax,%eax
     7a0:	05 80 cc 00 00       	add    $0xcc80,%eax
     7a5:	8b 70 0c             	mov    0xc(%eax),%esi
     7a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7ab:	6b c0 34             	imul   $0x34,%eax,%eax
     7ae:	05 80 cc 00 00       	add    $0xcc80,%eax
     7b3:	8b 48 04             	mov    0x4(%eax),%ecx
     7b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7b9:	6b c0 34             	imul   $0x34,%eax,%eax
     7bc:	05 80 cc 00 00       	add    $0xcc80,%eax
     7c1:	8b 10                	mov    (%eax),%edx
     7c3:	8d 45 d0             	lea    -0x30(%ebp),%eax
     7c6:	89 7c 24 10          	mov    %edi,0x10(%esp)
     7ca:	89 74 24 0c          	mov    %esi,0xc(%esp)
     7ce:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     7d2:	89 54 24 04          	mov    %edx,0x4(%esp)
     7d6:	89 04 24             	mov    %eax,(%esp)
     7d9:	e8 be 18 00 00       	call   209c <initRect>
     7de:	83 ec 04             	sub    $0x4,%esp
     7e1:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     7e5:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
     7ec:	00 
     7ed:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7f0:	89 44 24 04          	mov    %eax,0x4(%esp)
     7f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7f7:	89 44 24 08          	mov    %eax,0x8(%esp)
     7fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     7fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
     802:	8b 45 dc             	mov    -0x24(%ebp),%eax
     805:	89 44 24 10          	mov    %eax,0x10(%esp)
     809:	8b 45 08             	mov    0x8(%ebp),%eax
     80c:	89 04 24             	mov    %eax,(%esp)
     80f:	e8 74 19 00 00       	call   2188 <createClickable>

void addWndEvent(ClickableManager *cm) {
    int i;
	int n = sizeof(wndEvents) / sizeof(Handler);

	for (i = 0; i < n; i++) {
     814:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     818:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     81b:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     81e:	0f 8c 5e ff ff ff    	jl     782 <addWndEvent+0x1c>
		createClickable(cm,
				initRect(wndRes[i].position_x, wndRes[i].position_y,
						wndRes[i].pic.width, wndRes[i].pic.height), MSG_LPRESS,
				wndEvents[i]);
	}
}
     824:	8d 65 f4             	lea    -0xc(%ebp),%esp
     827:	5b                   	pop    %ebx
     828:	5e                   	pop    %esi
     829:	5f                   	pop    %edi
     82a:	5d                   	pop    %ebp
     82b:	c3                   	ret    

0000082c <main>:

int main(int argc, char *argv[]) {
     82c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     830:	83 e4 f0             	and    $0xfffffff0,%esp
     833:	ff 71 fc             	pushl  -0x4(%ecx)
     836:	55                   	push   %ebp
     837:	89 e5                	mov    %esp,%ebp
     839:	57                   	push   %edi
     83a:	56                   	push   %esi
     83b:	53                   	push   %ebx
     83c:	51                   	push   %ecx
     83d:	81 ec a8 00 00 00    	sub    $0xa8,%esp
     843:	89 cb                	mov    %ecx,%ebx
    ClickableManager cm;
    int winid;
    struct Msg msg;
    Point p;

    winid = init_context(&context, WINDOW_WIDTH, WINDOW_HEIGHT);
     845:	c7 44 24 08 36 01 00 	movl   $0x136,0x8(%esp)
     84c:	00 
     84d:	c7 44 24 04 f4 01 00 	movl   $0x1f4,0x4(%esp)
     854:	00 
     855:	8d 45 c8             	lea    -0x38(%ebp),%eax
     858:	89 04 24             	mov    %eax,(%esp)
     85b:	e8 06 03 00 00       	call   b66 <init_context>
     860:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    cm = initClickManager(context);
     863:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
     869:	8b 55 c8             	mov    -0x38(%ebp),%edx
     86c:	89 54 24 04          	mov    %edx,0x4(%esp)
     870:	8b 55 cc             	mov    -0x34(%ebp),%edx
     873:	89 54 24 08          	mov    %edx,0x8(%esp)
     877:	8b 55 d0             	mov    -0x30(%ebp),%edx
     87a:	89 54 24 0c          	mov    %edx,0xc(%esp)
     87e:	89 04 24             	mov    %eax,(%esp)
     881:	e8 b4 18 00 00       	call   213a <initClickManager>
     886:	83 ec 04             	sub    $0x4,%esp
     889:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
     88f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     892:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
     898:	89 45 b8             	mov    %eax,-0x48(%ebp)
     89b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     8a1:	89 45 bc             	mov    %eax,-0x44(%ebp)
     8a4:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     8aa:	89 45 c0             	mov    %eax,-0x40(%ebp)
     8ad:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
     8b3:	89 45 c4             	mov    %eax,-0x3c(%ebp)

    loadBitmap(&pic, argv[1]);
     8b6:	8b 43 04             	mov    0x4(%ebx),%eax
     8b9:	83 c0 04             	add    $0x4,%eax
     8bc:	8b 00                	mov    (%eax),%eax
     8be:	89 44 24 04          	mov    %eax,0x4(%esp)
     8c2:	c7 04 24 90 ff 00 00 	movl   $0xff90,(%esp)
     8c9:	e8 53 0f 00 00       	call   1821 <loadBitmap>
    load_iconlist(wndRes, sizeof(wndRes) / sizeof(ICON));
     8ce:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
     8d5:	00 
     8d6:	c7 04 24 60 cc 00 00 	movl   $0xcc60,(%esp)
     8dd:	e8 7e 0e 00 00       	call   1760 <load_iconlist>

    modifyPic(context);
     8e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
     8e5:	89 04 24             	mov    %eax,(%esp)
     8e8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8eb:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ef:	8b 45 d0             	mov    -0x30(%ebp),%eax
     8f2:	89 44 24 08          	mov    %eax,0x8(%esp)
     8f6:	e8 c4 fa ff ff       	call   3bf <modifyPic>
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
     8fb:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     8fe:	c7 44 24 10 58 02 00 	movl   $0x258,0x10(%esp)
     905:	00 
     906:	c7 44 24 0c 20 03 00 	movl   $0x320,0xc(%esp)
     90d:	00 
     90e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     915:	00 
     916:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     91d:	00 
     91e:	89 04 24             	mov    %eax,(%esp)
     921:	e8 76 17 00 00       	call   209c <initRect>
     926:	83 ec 04             	sub    $0x4,%esp
     929:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     92c:	89 44 24 04          	mov    %eax,0x4(%esp)
     930:	8b 45 d8             	mov    -0x28(%ebp),%eax
     933:	89 44 24 08          	mov    %eax,0x8(%esp)
     937:	8b 45 dc             	mov    -0x24(%ebp),%eax
     93a:	89 44 24 0c          	mov    %eax,0xc(%esp)
     93e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     941:	89 44 24 10          	mov    %eax,0x10(%esp)
     945:	8d 45 b4             	lea    -0x4c(%ebp),%eax
     948:	89 04 24             	mov    %eax,(%esp)
     94b:	e8 4f 19 00 00       	call   229f <deleteClickable>
    addWndEvent(&cm);
     950:	8d 45 b4             	lea    -0x4c(%ebp),%eax
     953:	89 04 24             	mov    %eax,(%esp)
     956:	e8 0b fe ff ff       	call   766 <addWndEvent>

    while (isRun) {
     95b:	e9 e2 01 00 00       	jmp    b42 <main+0x316>
        getMsg(&msg);
     960:	8d 45 98             	lea    -0x68(%ebp),%eax
     963:	89 04 24             	mov    %eax,(%esp)
     966:	e8 28 21 00 00       	call   2a93 <getMsg>
        switch (msg.msg_type) {
     96b:	8b 45 98             	mov    -0x68(%ebp),%eax
     96e:	83 f8 08             	cmp    $0x8,%eax
     971:	0f 87 ca 01 00 00    	ja     b41 <main+0x315>
     977:	8b 04 85 b0 92 00 00 	mov    0x92b0(,%eax,4),%eax
     97e:	ff e0                	jmp    *%eax
		case MSG_DOUBLECLICK:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
     980:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     983:	8b 55 a0             	mov    -0x60(%ebp),%edx
     986:	8d 45 90             	lea    -0x70(%ebp),%eax
     989:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     98d:	89 54 24 04          	mov    %edx,0x4(%esp)
     991:	89 04 24             	mov    %eax,(%esp)
     994:	e8 dc 16 00 00       	call   2075 <initPoint>
     999:	83 ec 04             	sub    $0x4,%esp
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.double_click, p)) {
     99c:	8b 4d b8             	mov    -0x48(%ebp),%ecx
     99f:	8b 45 90             	mov    -0x70(%ebp),%eax
     9a2:	8b 55 94             	mov    -0x6c(%ebp),%edx
     9a5:	89 44 24 04          	mov    %eax,0x4(%esp)
     9a9:	89 54 24 08          	mov    %edx,0x8(%esp)
     9ad:	89 0c 24             	mov    %ecx,(%esp)
     9b0:	e8 ca 19 00 00       	call   237f <executeHandler>
     9b5:	85 c0                	test   %eax,%eax
     9b7:	74 1e                	je     9d7 <main+0x1ab>
				updateWindow(winid, context.addr, msg.msg_detail);
     9b9:	8b 55 9c             	mov    -0x64(%ebp),%edx
     9bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9bf:	89 54 24 08          	mov    %edx,0x8(%esp)
     9c3:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9ca:	89 04 24             	mov    %eax,(%esp)
     9cd:	e8 d9 20 00 00       	call   2aab <updateWindow>
			}
			break;
     9d2:	e9 6b 01 00 00       	jmp    b42 <main+0x316>
     9d7:	e9 66 01 00 00       	jmp    b42 <main+0x316>
		case MSG_UPDATE:
			drawPicViewerWnd(context);
     9dc:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9df:	89 04 24             	mov    %eax,(%esp)
     9e2:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9e5:	89 44 24 04          	mov    %eax,0x4(%esp)
     9e9:	8b 45 d0             	mov    -0x30(%ebp),%eax
     9ec:	89 44 24 08          	mov    %eax,0x8(%esp)
     9f0:	e8 b9 fa ff ff       	call   4ae <drawPicViewerWnd>
			drawPicViewerContent(context, argv[1]);
     9f5:	8b 43 04             	mov    0x4(%ebx),%eax
     9f8:	83 c0 04             	add    $0x4,%eax
     9fb:	8b 00                	mov    (%eax),%eax
     9fd:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a01:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a04:	89 04 24             	mov    %eax,(%esp)
     a07:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a0a:	89 44 24 04          	mov    %eax,0x4(%esp)
     a0e:	8b 45 d0             	mov    -0x30(%ebp),%eax
     a11:	89 44 24 08          	mov    %eax,0x8(%esp)
     a15:	e8 a0 fc ff ff       	call   6ba <drawPicViewerContent>
			updateWindow(winid, context.addr, msg.msg_detail);
     a1a:	8b 55 9c             	mov    -0x64(%ebp),%edx
     a1d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a20:	89 54 24 08          	mov    %edx,0x8(%esp)
     a24:	89 44 24 04          	mov    %eax,0x4(%esp)
     a28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a2b:	89 04 24             	mov    %eax,(%esp)
     a2e:	e8 78 20 00 00       	call   2aab <updateWindow>
			break;
     a33:	e9 0a 01 00 00       	jmp    b42 <main+0x316>
		case MSG_PARTIAL_UPDATE:
			updatePartialWindow(winid, context.addr,
     a38:	8b 7d ac             	mov    -0x54(%ebp),%edi
     a3b:	8b 75 a8             	mov    -0x58(%ebp),%esi
     a3e:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     a41:	8b 55 a0             	mov    -0x60(%ebp),%edx
     a44:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a47:	89 7c 24 14          	mov    %edi,0x14(%esp)
     a4b:	89 74 24 10          	mov    %esi,0x10(%esp)
     a4f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     a53:	89 54 24 08          	mov    %edx,0x8(%esp)
     a57:	89 44 24 04          	mov    %eax,0x4(%esp)
     a5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a5e:	89 04 24             	mov    %eax,(%esp)
     a61:	e8 4d 20 00 00       	call   2ab3 <updatePartialWindow>
					msg.concrete_msg.msg_partial_update.x1,
					msg.concrete_msg.msg_partial_update.y1,
					msg.concrete_msg.msg_partial_update.x2,
					msg.concrete_msg.msg_partial_update.y2);
			break;
     a66:	e9 d7 00 00 00       	jmp    b42 <main+0x316>
		case MSG_LPRESS:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
     a6b:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     a6e:	8b 55 a0             	mov    -0x60(%ebp),%edx
     a71:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
     a77:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     a7b:	89 54 24 04          	mov    %edx,0x4(%esp)
     a7f:	89 04 24             	mov    %eax,(%esp)
     a82:	e8 ee 15 00 00       	call   2075 <initPoint>
     a87:	83 ec 04             	sub    $0x4,%esp
     a8a:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
     a90:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
     a96:	89 45 90             	mov    %eax,-0x70(%ebp)
     a99:	89 55 94             	mov    %edx,-0x6c(%ebp)
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.left_click, p)) {
     a9c:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
     a9f:	8b 45 90             	mov    -0x70(%ebp),%eax
     aa2:	8b 55 94             	mov    -0x6c(%ebp),%edx
     aa5:	89 44 24 04          	mov    %eax,0x4(%esp)
     aa9:	89 54 24 08          	mov    %edx,0x8(%esp)
     aad:	89 0c 24             	mov    %ecx,(%esp)
     ab0:	e8 ca 18 00 00       	call   237f <executeHandler>
     ab5:	85 c0                	test   %eax,%eax
     ab7:	74 1b                	je     ad4 <main+0x2a8>

				updateWindow(winid, context.addr, msg.msg_detail);
     ab9:	8b 55 9c             	mov    -0x64(%ebp),%edx
     abc:	8b 45 c8             	mov    -0x38(%ebp),%eax
     abf:	89 54 24 08          	mov    %edx,0x8(%esp)
     ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
     ac7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aca:	89 04 24             	mov    %eax,(%esp)
     acd:	e8 d9 1f 00 00       	call   2aab <updateWindow>
			}
			break;
     ad2:	eb 6e                	jmp    b42 <main+0x316>
     ad4:	eb 6c                	jmp    b42 <main+0x316>
		case MSG_RPRESS:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
     ad6:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     ad9:	8b 55 a0             	mov    -0x60(%ebp),%edx
     adc:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
     ae2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     ae6:	89 54 24 04          	mov    %edx,0x4(%esp)
     aea:	89 04 24             	mov    %eax,(%esp)
     aed:	e8 83 15 00 00       	call   2075 <initPoint>
     af2:	83 ec 04             	sub    $0x4,%esp
     af5:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
     afb:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
     b01:	89 45 90             	mov    %eax,-0x70(%ebp)
     b04:	89 55 94             	mov    %edx,-0x6c(%ebp)
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.right_click, p)) {
     b07:	8b 4d bc             	mov    -0x44(%ebp),%ecx
     b0a:	8b 45 90             	mov    -0x70(%ebp),%eax
     b0d:	8b 55 94             	mov    -0x6c(%ebp),%edx
     b10:	89 44 24 04          	mov    %eax,0x4(%esp)
     b14:	89 54 24 08          	mov    %edx,0x8(%esp)
     b18:	89 0c 24             	mov    %ecx,(%esp)
     b1b:	e8 5f 18 00 00       	call   237f <executeHandler>
     b20:	85 c0                	test   %eax,%eax
     b22:	74 1b                	je     b3f <main+0x313>
				updateWindow(winid, context.addr, msg.msg_detail);
     b24:	8b 55 9c             	mov    -0x64(%ebp),%edx
     b27:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b2a:	89 54 24 08          	mov    %edx,0x8(%esp)
     b2e:	89 44 24 04          	mov    %eax,0x4(%esp)
     b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b35:	89 04 24             	mov    %eax,(%esp)
     b38:	e8 6e 1f 00 00       	call   2aab <updateWindow>
			}
			break;
     b3d:	eb 03                	jmp    b42 <main+0x316>
     b3f:	eb 01                	jmp    b42 <main+0x316>
		default:
			break;
     b41:	90                   	nop

    modifyPic(context);
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    addWndEvent(&cm);

    while (isRun) {
     b42:	a1 98 cc 00 00       	mov    0xcc98,%eax
     b47:	85 c0                	test   %eax,%eax
     b49:	0f 85 11 fe ff ff    	jne    960 <main+0x134>
			break;
		default:
			break;
		}
    }
    free_context(&context, winid);
     b4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b52:	89 44 24 04          	mov    %eax,0x4(%esp)
     b56:	8d 45 c8             	lea    -0x38(%ebp),%eax
     b59:	89 04 24             	mov    %eax,(%esp)
     b5c:	e8 88 00 00 00       	call   be9 <free_context>
    exit();
     b61:	e8 8d 1e 00 00       	call   29f3 <exit>

00000b66 <init_context>:
#include "stat.h"
#include "user.h"
#include "drawingAPI.h"

int init_context(struct Context* context_ptr, int width, int height)
{
     b66:	55                   	push   %ebp
     b67:	89 e5                	mov    %esp,%ebp
     b69:	83 ec 18             	sub    $0x18,%esp
    context_ptr->width = width;
     b6c:	8b 45 08             	mov    0x8(%ebp),%eax
     b6f:	8b 55 0c             	mov    0xc(%ebp),%edx
     b72:	89 50 04             	mov    %edx,0x4(%eax)
    context_ptr->height = height;
     b75:	8b 45 08             	mov    0x8(%ebp),%eax
     b78:	8b 55 10             	mov    0x10(%ebp),%edx
     b7b:	89 50 08             	mov    %edx,0x8(%eax)
    context_ptr->addr = (unsigned short*)malloc(sizeof(unsigned short) * width * height);
     b7e:	8b 55 0c             	mov    0xc(%ebp),%edx
     b81:	8b 45 10             	mov    0x10(%ebp),%eax
     b84:	0f af c2             	imul   %edx,%eax
     b87:	01 c0                	add    %eax,%eax
     b89:	89 04 24             	mov    %eax,(%esp)
     b8c:	e8 36 23 00 00       	call   2ec7 <malloc>
     b91:	8b 55 08             	mov    0x8(%ebp),%edx
     b94:	89 02                	mov    %eax,(%edx)
    memset(context_ptr->addr, 0, sizeof(unsigned short) * width * height);
     b96:	8b 55 0c             	mov    0xc(%ebp),%edx
     b99:	8b 45 10             	mov    0x10(%ebp),%eax
     b9c:	0f af c2             	imul   %edx,%eax
     b9f:	8d 14 00             	lea    (%eax,%eax,1),%edx
     ba2:	8b 45 08             	mov    0x8(%ebp),%eax
     ba5:	8b 00                	mov    (%eax),%eax
     ba7:	89 54 24 08          	mov    %edx,0x8(%esp)
     bab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     bb2:	00 
     bb3:	89 04 24             	mov    %eax,(%esp)
     bb6:	e8 8b 1c 00 00       	call   2846 <memset>
    initializeASCII();
     bbb:	e8 93 01 00 00       	call   d53 <initializeASCII>
    initializeGBK();
     bc0:	e8 17 03 00 00       	call   edc <initializeGBK>
    return createWindow(0, 0, width, height);
     bc5:	8b 45 10             	mov    0x10(%ebp),%eax
     bc8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
     bcf:	89 44 24 08          	mov    %eax,0x8(%esp)
     bd3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     bda:	00 
     bdb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     be2:	e8 b4 1e 00 00       	call   2a9b <createWindow>
}
     be7:	c9                   	leave  
     be8:	c3                   	ret    

00000be9 <free_context>:

void free_context(struct Context* context_ptr, int winid)
{
     be9:	55                   	push   %ebp
     bea:	89 e5                	mov    %esp,%ebp
     bec:	83 ec 18             	sub    $0x18,%esp
    free(context_ptr->addr);
     bef:	8b 45 08             	mov    0x8(%ebp),%eax
     bf2:	8b 00                	mov    (%eax),%eax
     bf4:	89 04 24             	mov    %eax,(%esp)
     bf7:	e8 92 21 00 00       	call   2d8e <free>
    freeASCII();
     bfc:	e8 c6 02 00 00       	call   ec7 <freeASCII>
    freeGBK();
     c01:	e8 7e 03 00 00       	call   f84 <freeGBK>
    destroyWindow(winid);
     c06:	8b 45 0c             	mov    0xc(%ebp),%eax
     c09:	89 04 24             	mov    %eax,(%esp)
     c0c:	e8 92 1e 00 00       	call   2aa3 <destroyWindow>
}
     c11:	c9                   	leave  
     c12:	c3                   	ret    

00000c13 <draw_point>:
*             then do nothing!
*/

void
draw_point(struct Context c, unsigned int x, unsigned int y, unsigned short color)
{
     c13:	55                   	push   %ebp
     c14:	89 e5                	mov    %esp,%ebp
     c16:	83 ec 04             	sub    $0x4,%esp
     c19:	8b 45 1c             	mov    0x1c(%ebp),%eax
     c1c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  if(x >= c.width)
     c20:	8b 45 0c             	mov    0xc(%ebp),%eax
     c23:	3b 45 14             	cmp    0x14(%ebp),%eax
     c26:	77 02                	ja     c2a <draw_point+0x17>
    return;
     c28:	eb 26                	jmp    c50 <draw_point+0x3d>
  if(y >= c.height)
     c2a:	8b 45 10             	mov    0x10(%ebp),%eax
     c2d:	3b 45 18             	cmp    0x18(%ebp),%eax
     c30:	77 02                	ja     c34 <draw_point+0x21>
    return;
     c32:	eb 1c                	jmp    c50 <draw_point+0x3d>
  c.addr[y*c.width+x] = color;
     c34:	8b 55 08             	mov    0x8(%ebp),%edx
     c37:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3a:	0f af 45 18          	imul   0x18(%ebp),%eax
     c3e:	89 c1                	mov    %eax,%ecx
     c40:	8b 45 14             	mov    0x14(%ebp),%eax
     c43:	01 c8                	add    %ecx,%eax
     c45:	01 c0                	add    %eax,%eax
     c47:	01 c2                	add    %eax,%edx
     c49:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
     c4d:	66 89 02             	mov    %ax,(%edx)
}
     c50:	c9                   	leave  
     c51:	c3                   	ret    

00000c52 <fill_rect>:
/*
*fill_rect: set a rect area with a certain color
*/
void
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
     c52:	55                   	push   %ebp
     c53:	89 e5                	mov    %esp,%ebp
     c55:	83 ec 2c             	sub    $0x2c,%esp
     c58:	8b 45 24             	mov    0x24(%ebp),%eax
     c5b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
     c5f:	8b 45 1c             	mov    0x1c(%ebp),%eax
     c62:	8b 55 14             	mov    0x14(%ebp),%edx
     c65:	01 c2                	add    %eax,%edx
     c67:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6a:	39 c2                	cmp    %eax,%edx
     c6c:	0f 46 c2             	cmovbe %edx,%eax
     c6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int my = c.height < by + height ? c.height : by + height;
     c72:	8b 45 20             	mov    0x20(%ebp),%eax
     c75:	8b 55 18             	mov    0x18(%ebp),%edx
     c78:	01 c2                	add    %eax,%edx
     c7a:	8b 45 10             	mov    0x10(%ebp),%eax
     c7d:	39 c2                	cmp    %eax,%edx
     c7f:	0f 46 c2             	cmovbe %edx,%eax
     c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (y = by; y < my; y++)
     c85:	8b 45 18             	mov    0x18(%ebp),%eax
     c88:	89 45 f8             	mov    %eax,-0x8(%ebp)
     c8b:	eb 47                	jmp    cd4 <fill_rect+0x82>
	{
		for (x = bx; x < mx; x++)
     c8d:	8b 45 14             	mov    0x14(%ebp),%eax
     c90:	89 45 fc             	mov    %eax,-0x4(%ebp)
     c93:	eb 33                	jmp    cc8 <fill_rect+0x76>
		{
			draw_point(c, x, y, color);
     c95:	0f b7 4d ec          	movzwl -0x14(%ebp),%ecx
     c99:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c9c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c9f:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     ca3:	89 54 24 10          	mov    %edx,0x10(%esp)
     ca7:	89 44 24 0c          	mov    %eax,0xc(%esp)
     cab:	8b 45 08             	mov    0x8(%ebp),%eax
     cae:	89 04 24             	mov    %eax,(%esp)
     cb1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb4:	89 44 24 04          	mov    %eax,0x4(%esp)
     cb8:	8b 45 10             	mov    0x10(%ebp),%eax
     cbb:	89 44 24 08          	mov    %eax,0x8(%esp)
     cbf:	e8 4f ff ff ff       	call   c13 <draw_point>
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
	{
		for (x = bx; x < mx; x++)
     cc4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     cc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ccb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     cce:	7c c5                	jl     c95 <fill_rect+0x43>
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
     cd0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     cd7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cda:	7c b1                	jl     c8d <fill_rect+0x3b>
		for (x = bx; x < mx; x++)
		{
			draw_point(c, x, y, color);
		}
	}
}
     cdc:	c9                   	leave  
     cdd:	c3                   	ret    

00000cde <printBinary>:

void printBinary(char c)
{
     cde:	55                   	push   %ebp
     cdf:	89 e5                	mov    %esp,%ebp
     ce1:	83 ec 28             	sub    $0x28,%esp
     ce4:	8b 45 08             	mov    0x8(%ebp),%eax
     ce7:	88 45 e4             	mov    %al,-0x1c(%ebp)
	int i;
	for (i = 0; i < 8; i++)
     cea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cf1:	eb 44                	jmp    d37 <printBinary+0x59>
	{
		if(((c << i) & 0x80) != 0)
     cf3:	0f be 55 e4          	movsbl -0x1c(%ebp),%edx
     cf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cfa:	89 c1                	mov    %eax,%ecx
     cfc:	d3 e2                	shl    %cl,%edx
     cfe:	89 d0                	mov    %edx,%eax
     d00:	25 80 00 00 00       	and    $0x80,%eax
     d05:	85 c0                	test   %eax,%eax
     d07:	74 16                	je     d1f <printBinary+0x41>
		{
			printf(0, "1");
     d09:	c7 44 24 04 d4 92 00 	movl   $0x92d4,0x4(%esp)
     d10:	00 
     d11:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d18:	e8 be 1e 00 00       	call   2bdb <printf>
     d1d:	eb 14                	jmp    d33 <printBinary+0x55>
		}
		else
		{
			printf(0, "0");
     d1f:	c7 44 24 04 d6 92 00 	movl   $0x92d6,0x4(%esp)
     d26:	00 
     d27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d2e:	e8 a8 1e 00 00       	call   2bdb <printf>
}

void printBinary(char c)
{
	int i;
	for (i = 0; i < 8; i++)
     d33:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d37:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
     d3b:	7e b6                	jle    cf3 <printBinary+0x15>
		{
			printf(0, "0");
		}
	}

	printf(0, "\n");
     d3d:	c7 44 24 04 d8 92 00 	movl   $0x92d8,0x4(%esp)
     d44:	00 
     d45:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d4c:	e8 8a 1e 00 00       	call   2bdb <printf>
}
     d51:	c9                   	leave  
     d52:	c3                   	ret    

00000d53 <initializeASCII>:
char buf[512];
//hankaku是一个数组，将hankaku.txt文件中的每一行转化成一个8位整数（unsigned short）
//每16个整数可以代表一个字符
unsigned char *hankaku;
void initializeASCII()
{
     d53:	55                   	push   %ebp
     d54:	89 e5                	mov    %esp,%ebp
     d56:	56                   	push   %esi
     d57:	53                   	push   %ebx
     d58:	83 ec 30             	sub    $0x30,%esp

	int fd, n, i;
	int x, y;
	printf(0,"initialzing ASCII\n");
     d5b:	c7 44 24 04 da 92 00 	movl   $0x92da,0x4(%esp)
     d62:	00 
     d63:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d6a:	e8 6c 1e 00 00       	call   2bdb <printf>
	//打开hankaku.txt文件
	if((fd = open(HANKAKU, 0)) < 0){
     d6f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d76:	00 
     d77:	c7 04 24 ed 92 00 00 	movl   $0x92ed,(%esp)
     d7e:	e8 b0 1c 00 00       	call   2a33 <open>
     d83:	89 45 e8             	mov    %eax,-0x18(%ebp)
     d86:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d8a:	79 21                	jns    dad <initializeASCII+0x5a>
	  printf(0,"cannot open %s\n", HANKAKU);
     d8c:	c7 44 24 08 ed 92 00 	movl   $0x92ed,0x8(%esp)
     d93:	00 
     d94:	c7 44 24 04 f9 92 00 	movl   $0x92f9,0x4(%esp)
     d9b:	00 
     d9c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     da3:	e8 33 1e 00 00       	call   2bdb <printf>
	  return;
     da8:	e9 13 01 00 00       	jmp    ec0 <initializeASCII+0x16d>
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
     dad:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     db4:	e8 0e 21 00 00       	call   2ec7 <malloc>
     db9:	a3 a0 ff 00 00       	mov    %eax,0xffa0
	for (i = 0; i < ASCII_NUM; i++)
     dbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     dc5:	eb 12                	jmp    dd9 <initializeASCII+0x86>
	{
		hankaku[i] = 0;
     dc7:	8b 15 a0 ff 00 00    	mov    0xffa0,%edx
     dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd0:	01 d0                	add    %edx,%eax
     dd2:	c6 00 00             	movb   $0x0,(%eax)
	  printf(0,"cannot open %s\n", HANKAKU);
	  return;
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
	for (i = 0; i < ASCII_NUM; i++)
     dd5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dd9:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
     de0:	7e e5                	jle    dc7 <initializeASCII+0x74>

	//不断读取文件，如果读到的字符是“*/."，就按顺序记录到hankaku数组中
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
     de2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	y = 0;
     de9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while((n = read(fd, buf, sizeof(buf))) > 0)
     df0:	e9 84 00 00 00       	jmp    e79 <initializeASCII+0x126>
	{
		for (i = 0; i < n; i++){
     df5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     dfc:	eb 73                	jmp    e71 <initializeASCII+0x11e>
			//printf(0,"%c, %d", buf[i], i);
			if (buf[i] == '*' || buf[i] == '.')
     dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e01:	05 c0 ff 00 00       	add    $0xffc0,%eax
     e06:	0f b6 00             	movzbl (%eax),%eax
     e09:	3c 2a                	cmp    $0x2a,%al
     e0b:	74 0f                	je     e1c <initializeASCII+0xc9>
     e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e10:	05 c0 ff 00 00       	add    $0xffc0,%eax
     e15:	0f b6 00             	movzbl (%eax),%eax
     e18:	3c 2e                	cmp    $0x2e,%al
     e1a:	75 51                	jne    e6d <initializeASCII+0x11a>
			{
				if (buf[i] == '*')
     e1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e1f:	05 c0 ff 00 00       	add    $0xffc0,%eax
     e24:	0f b6 00             	movzbl (%eax),%eax
     e27:	3c 2a                	cmp    $0x2a,%al
     e29:	75 2d                	jne    e58 <initializeASCII+0x105>
				{
					hankaku[y] |= (0x80 >> x);
     e2b:	8b 15 a0 ff 00 00    	mov    0xffa0,%edx
     e31:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e34:	01 c2                	add    %eax,%edx
     e36:	8b 0d a0 ff 00 00    	mov    0xffa0,%ecx
     e3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e3f:	01 c8                	add    %ecx,%eax
     e41:	0f b6 00             	movzbl (%eax),%eax
     e44:	89 c3                	mov    %eax,%ebx
     e46:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e49:	be 80 00 00 00       	mov    $0x80,%esi
     e4e:	89 c1                	mov    %eax,%ecx
     e50:	d3 fe                	sar    %cl,%esi
     e52:	89 f0                	mov    %esi,%eax
     e54:	09 d8                	or     %ebx,%eax
     e56:	88 02                	mov    %al,(%edx)
				}
				x ++;
     e58:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
				if (x >= ASCII_WIDTH)
     e5c:	83 7d f0 07          	cmpl   $0x7,-0x10(%ebp)
     e60:	7e 0b                	jle    e6d <initializeASCII+0x11a>
				{
					x = 0;
     e62:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
					y ++;
     e69:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
	{
		for (i = 0; i < n; i++){
     e6d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e74:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
     e77:	7c 85                	jl     dfe <initializeASCII+0xab>
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
     e79:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     e80:	00 
     e81:	c7 44 24 04 c0 ff 00 	movl   $0xffc0,0x4(%esp)
     e88:	00 
     e89:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e8c:	89 04 24             	mov    %eax,(%esp)
     e8f:	e8 77 1b 00 00       	call   2a0b <read>
     e94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     e97:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     e9b:	0f 8f 54 ff ff ff    	jg     df5 <initializeASCII+0xa2>

//	for (i = 0; i < ASCII_NUM * ASCII_HEIGHT; i++)
//	{
//		printBinary(hankaku[i]);
//	}
	printf(0,"initialzing ASCII complete!\n");
     ea1:	c7 44 24 04 09 93 00 	movl   $0x9309,0x4(%esp)
     ea8:	00 
     ea9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eb0:	e8 26 1d 00 00       	call   2bdb <printf>
	close(fd);
     eb5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     eb8:	89 04 24             	mov    %eax,(%esp)
     ebb:	e8 5b 1b 00 00       	call   2a1b <close>
}
     ec0:	83 c4 30             	add    $0x30,%esp
     ec3:	5b                   	pop    %ebx
     ec4:	5e                   	pop    %esi
     ec5:	5d                   	pop    %ebp
     ec6:	c3                   	ret    

00000ec7 <freeASCII>:

void freeASCII(){
     ec7:	55                   	push   %ebp
     ec8:	89 e5                	mov    %esp,%ebp
     eca:	83 ec 18             	sub    $0x18,%esp
	free(hankaku);
     ecd:	a1 a0 ff 00 00       	mov    0xffa0,%eax
     ed2:	89 04 24             	mov    %eax,(%esp)
     ed5:	e8 b4 1e 00 00       	call   2d8e <free>
}
     eda:	c9                   	leave  
     edb:	c3                   	ret    

00000edc <initializeGBK>:

struct File_Node fontFile;
void initializeGBK(){
     edc:	55                   	push   %ebp
     edd:	89 e5                	mov    %esp,%ebp
     edf:	83 ec 28             	sub    $0x28,%esp
	int fd;
	printf(0,"initialzing gbk\n");
     ee2:	c7 44 24 04 26 93 00 	movl   $0x9326,0x4(%esp)
     ee9:	00 
     eea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ef1:	e8 e5 1c 00 00       	call   2bdb <printf>
	if((fd = open(HZK16, 0)) < 0){
     ef6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     efd:	00 
     efe:	c7 04 24 37 93 00 00 	movl   $0x9337,(%esp)
     f05:	e8 29 1b 00 00       	call   2a33 <open>
     f0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f0d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f11:	79 1e                	jns    f31 <initializeGBK+0x55>
		printf(0,"cannot open %s\n", HZK16);
     f13:	c7 44 24 08 37 93 00 	movl   $0x9337,0x8(%esp)
     f1a:	00 
     f1b:	c7 44 24 04 f9 92 00 	movl   $0x92f9,0x4(%esp)
     f22:	00 
     f23:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f2a:	e8 ac 1c 00 00       	call   2bdb <printf>
		return;
     f2f:	eb 51                	jmp    f82 <initializeGBK+0xa6>
	}
	fontFile.buf = malloc(27000*sizeof(unsigned char));
     f31:	c7 04 24 78 69 00 00 	movl   $0x6978,(%esp)
     f38:	e8 8a 1f 00 00       	call   2ec7 <malloc>
     f3d:	a3 a4 ff 00 00       	mov    %eax,0xffa4
	fontFile.size = read(fd, fontFile.buf, 27000);
     f42:	a1 a4 ff 00 00       	mov    0xffa4,%eax
     f47:	c7 44 24 08 78 69 00 	movl   $0x6978,0x8(%esp)
     f4e:	00 
     f4f:	89 44 24 04          	mov    %eax,0x4(%esp)
     f53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f56:	89 04 24             	mov    %eax,(%esp)
     f59:	e8 ad 1a 00 00       	call   2a0b <read>
     f5e:	a3 a8 ff 00 00       	mov    %eax,0xffa8
	printf(0,"initialzing gbk complete!\n");
     f63:	c7 44 24 04 41 93 00 	movl   $0x9341,0x4(%esp)
     f6a:	00 
     f6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f72:	e8 64 1c 00 00       	call   2bdb <printf>
	close(fd);
     f77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f7a:	89 04 24             	mov    %eax,(%esp)
     f7d:	e8 99 1a 00 00       	call   2a1b <close>
}
     f82:	c9                   	leave  
     f83:	c3                   	ret    

00000f84 <freeGBK>:

void freeGBK(){
     f84:	55                   	push   %ebp
     f85:	89 e5                	mov    %esp,%ebp
     f87:	83 ec 18             	sub    $0x18,%esp
	free(fontFile.buf);
     f8a:	a1 a4 ff 00 00       	mov    0xffa4,%eax
     f8f:	89 04 24             	mov    %eax,(%esp)
     f92:	e8 f7 1d 00 00       	call   2d8e <free>
}
     f97:	c9                   	leave  
     f98:	c3                   	ret    

00000f99 <put_ascii>:

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
     f99:	55                   	push   %ebp
     f9a:	89 e5                	mov    %esp,%ebp
     f9c:	53                   	push   %ebx
     f9d:	83 ec 30             	sub    $0x30,%esp
     fa0:	8b 55 14             	mov    0x14(%ebp),%edx
     fa3:	8b 45 18             	mov    0x18(%ebp),%eax
     fa6:	88 55 e8             	mov    %dl,-0x18(%ebp)
     fa9:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
     fad:	8b 45 20             	mov    0x20(%ebp),%eax
     fb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
     fb3:	eb 7f                	jmp    1034 <put_ascii+0x9b>
		for(tmpX = 0; tmpX < 8; tmpX++) {
     fb5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     fbc:	eb 6c                	jmp    102a <put_ascii+0x91>
			if((((hankaku + (ascii * 16))[tmpY - y] << tmpX) & 0x80) == 0x80) {
     fbe:	a1 a0 ff 00 00       	mov    0xffa0,%eax
     fc3:	0f b6 55 e8          	movzbl -0x18(%ebp),%edx
     fc7:	c1 e2 04             	shl    $0x4,%edx
     fca:	89 d1                	mov    %edx,%ecx
     fcc:	8b 55 20             	mov    0x20(%ebp),%edx
     fcf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     fd2:	29 d3                	sub    %edx,%ebx
     fd4:	89 da                	mov    %ebx,%edx
     fd6:	01 ca                	add    %ecx,%edx
     fd8:	01 d0                	add    %edx,%eax
     fda:	0f b6 00             	movzbl (%eax),%eax
     fdd:	0f b6 d0             	movzbl %al,%edx
     fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     fe3:	89 c1                	mov    %eax,%ecx
     fe5:	d3 e2                	shl    %cl,%edx
     fe7:	89 d0                	mov    %edx,%eax
     fe9:	25 80 00 00 00       	and    $0x80,%eax
     fee:	85 c0                	test   %eax,%eax
     ff0:	74 34                	je     1026 <put_ascii+0x8d>
				//printf(0, "x: %d, y: %d\n", x + tmpX, tmpY);
				draw_point(c, x + tmpX, tmpY, colorNum);
     ff2:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
     ff6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ff9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ffc:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
     fff:	01 d8                	add    %ebx,%eax
    1001:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    1005:	89 54 24 10          	mov    %edx,0x10(%esp)
    1009:	89 44 24 0c          	mov    %eax,0xc(%esp)
    100d:	8b 45 08             	mov    0x8(%ebp),%eax
    1010:	89 04 24             	mov    %eax,(%esp)
    1013:	8b 45 0c             	mov    0xc(%ebp),%eax
    1016:	89 44 24 04          	mov    %eax,0x4(%esp)
    101a:	8b 45 10             	mov    0x10(%ebp),%eax
    101d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1021:	e8 ed fb ff ff       	call   c13 <draw_point>
void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
		for(tmpX = 0; tmpX < 8; tmpX++) {
    1026:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    102a:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    102e:	7e 8e                	jle    fbe <put_ascii+0x25>

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
    1030:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1034:	8b 45 20             	mov    0x20(%ebp),%eax
    1037:	83 c0 10             	add    $0x10,%eax
    103a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    103d:	0f 8f 72 ff ff ff    	jg     fb5 <put_ascii+0x1c>
				draw_point(c, x + tmpX, tmpY, colorNum);
				//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
			}
		}
	}
}
    1043:	83 c4 30             	add    $0x30,%esp
    1046:	5b                   	pop    %ebx
    1047:	5d                   	pop    %ebp
    1048:	c3                   	ret    

00001049 <put_gbk>:

void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
    1049:	55                   	push   %ebp
    104a:	89 e5                	mov    %esp,%ebp
    104c:	53                   	push   %ebx
    104d:	83 ec 34             	sub    $0x34,%esp
    1050:	8b 55 14             	mov    0x14(%ebp),%edx
    1053:	8b 45 18             	mov    0x18(%ebp),%eax
    1056:	66 89 55 e8          	mov    %dx,-0x18(%ebp)
    105a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
    105e:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
    1062:	0f b6 c0             	movzbl %al,%eax
    1065:	3d a0 00 00 00       	cmp    $0xa0,%eax
    106a:	0f 8e 40 01 00 00    	jle    11b0 <put_gbk+0x167>
    1070:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    1074:	66 c1 f8 08          	sar    $0x8,%ax
    1078:	98                   	cwtl   
    1079:	0f b6 c0             	movzbl %al,%eax
    107c:	3d a0 00 00 00       	cmp    $0xa0,%eax
    1081:	0f 8e 29 01 00 00    	jle    11b0 <put_gbk+0x167>
		hzk16Base = fontFile.buf;
    1087:	a1 a4 ff 00 00       	mov    0xffa4,%eax
    108c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;
    108f:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
    1093:	0f b6 c0             	movzbl %al,%eax
    1096:	2d a1 00 00 00       	sub    $0xa1,%eax
    109b:	6b c0 5e             	imul   $0x5e,%eax,%eax
    109e:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
    10a2:	66 c1 fa 08          	sar    $0x8,%dx
    10a6:	0f bf d2             	movswl %dx,%edx
    10a9:	0f b6 d2             	movzbl %dl,%edx
    10ac:	81 ea a1 00 00 00    	sub    $0xa1,%edx
    10b2:	01 d0                	add    %edx,%eax
    10b4:	c1 e0 05             	shl    $0x5,%eax
    10b7:	89 45 f0             	mov    %eax,-0x10(%ebp)

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
    10ba:	8b 45 20             	mov    0x20(%ebp),%eax
    10bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10c0:	e9 da 00 00 00       	jmp    119f <put_gbk+0x156>
			for(tmpX = 0; tmpX < 8; tmpX++) {
    10c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    10cc:	eb 58                	jmp    1126 <put_gbk+0xdd>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
    10ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10d1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    10d4:	01 d0                	add    %edx,%eax
    10d6:	0f b6 00             	movzbl (%eax),%eax
    10d9:	0f b6 d0             	movzbl %al,%edx
    10dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    10df:	89 c1                	mov    %eax,%ecx
    10e1:	d3 e2                	shl    %cl,%edx
    10e3:	89 d0                	mov    %edx,%eax
    10e5:	25 80 00 00 00       	and    $0x80,%eax
    10ea:	85 c0                	test   %eax,%eax
    10ec:	74 34                	je     1122 <put_gbk+0xd9>
					draw_point(c, x + tmpX, tmpY, colorNum);
    10ee:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    10f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    10f8:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    10fb:	01 d8                	add    %ebx,%eax
    10fd:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    1101:	89 54 24 10          	mov    %edx,0x10(%esp)
    1105:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
    110c:	89 04 24             	mov    %eax,(%esp)
    110f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1112:	89 44 24 04          	mov    %eax,0x4(%esp)
    1116:	8b 45 10             	mov    0x10(%ebp),%eax
    1119:	89 44 24 08          	mov    %eax,0x8(%esp)
    111d:	e8 f1 fa ff ff       	call   c13 <draw_point>
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
			for(tmpX = 0; tmpX < 8; tmpX++) {
    1122:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1126:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    112a:	7e a2                	jle    10ce <put_gbk+0x85>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
    112c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
			for(tmpX = 0; tmpX < 8; tmpX++) {
    1130:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    1137:	eb 58                	jmp    1191 <put_gbk+0x148>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
    1139:	8b 45 f0             	mov    -0x10(%ebp),%eax
    113c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    113f:	01 d0                	add    %edx,%eax
    1141:	0f b6 00             	movzbl (%eax),%eax
    1144:	0f b6 d0             	movzbl %al,%edx
    1147:	8b 45 f8             	mov    -0x8(%ebp),%eax
    114a:	89 c1                	mov    %eax,%ecx
    114c:	d3 e2                	shl    %cl,%edx
    114e:	89 d0                	mov    %edx,%eax
    1150:	25 80 00 00 00       	and    $0x80,%eax
    1155:	85 c0                	test   %eax,%eax
    1157:	74 34                	je     118d <put_gbk+0x144>
					draw_point(c, x + tmpX, tmpY, colorNum);
    1159:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    115d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1160:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1163:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    1166:	01 d8                	add    %ebx,%eax
    1168:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    116c:	89 54 24 10          	mov    %edx,0x10(%esp)
    1170:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	89 04 24             	mov    %eax,(%esp)
    117a:	8b 45 0c             	mov    0xc(%ebp),%eax
    117d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1181:	8b 45 10             	mov    0x10(%ebp),%eax
    1184:	89 44 24 08          	mov    %eax,0x8(%esp)
    1188:	e8 86 fa ff ff       	call   c13 <draw_point>
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
			for(tmpX = 0; tmpX < 8; tmpX++) {
    118d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1191:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    1195:	7e a2                	jle    1139 <put_gbk+0xf0>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX + 8] = colorNum;
				}
			}
			offset++;
    1197:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
    119b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    119f:	8b 45 20             	mov    0x20(%ebp),%eax
    11a2:	83 c0 10             	add    $0x10,%eax
    11a5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a8:	0f 8f 17 ff ff ff    	jg     10c5 <put_gbk+0x7c>
void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
    11ae:	eb 7b                	jmp    122b <put_gbk+0x1e2>
			}
			offset++;
		}
	}
	else {
		put_ascii(c, (gbk & 0x00FF), colorNum, x, y);
    11b0:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    11b4:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    11b8:	0f b6 c0             	movzbl %al,%eax
    11bb:	8b 4d 20             	mov    0x20(%ebp),%ecx
    11be:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    11c2:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
    11c5:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    11c9:	89 54 24 10          	mov    %edx,0x10(%esp)
    11cd:	89 44 24 0c          	mov    %eax,0xc(%esp)
    11d1:	8b 45 08             	mov    0x8(%ebp),%eax
    11d4:	89 04 24             	mov    %eax,(%esp)
    11d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    11da:	89 44 24 04          	mov    %eax,0x4(%esp)
    11de:	8b 45 10             	mov    0x10(%ebp),%eax
    11e1:	89 44 24 08          	mov    %eax,0x8(%esp)
    11e5:	e8 af fd ff ff       	call   f99 <put_ascii>
		put_ascii(c, ((gbk >> 8) & 0x00FF), colorNum, x + 8, y);
    11ea:	8b 45 1c             	mov    0x1c(%ebp),%eax
    11ed:	8d 58 08             	lea    0x8(%eax),%ebx
    11f0:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    11f4:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    11f8:	66 c1 f8 08          	sar    $0x8,%ax
    11fc:	0f b6 c0             	movzbl %al,%eax
    11ff:	8b 4d 20             	mov    0x20(%ebp),%ecx
    1202:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1206:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    120a:	89 54 24 10          	mov    %edx,0x10(%esp)
    120e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1212:	8b 45 08             	mov    0x8(%ebp),%eax
    1215:	89 04 24             	mov    %eax,(%esp)
    1218:	8b 45 0c             	mov    0xc(%ebp),%eax
    121b:	89 44 24 04          	mov    %eax,0x4(%esp)
    121f:	8b 45 10             	mov    0x10(%ebp),%eax
    1222:	89 44 24 08          	mov    %eax,0x8(%esp)
    1226:	e8 6e fd ff ff       	call   f99 <put_ascii>
	}
}
    122b:	83 c4 34             	add    $0x34,%esp
    122e:	5b                   	pop    %ebx
    122f:	5d                   	pop    %ebp
    1230:	c3                   	ret    

00001231 <puts_str>:

void puts_str(struct Context c, char *str, unsigned short colorNum, int x, int y)
{
    1231:	55                   	push   %ebp
    1232:	89 e5                	mov    %esp,%ebp
    1234:	83 ec 38             	sub    $0x38,%esp
    1237:	8b 45 18             	mov    0x18(%ebp),%eax
    123a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	//printf(0,"puts string : %s\n", str);
	int i = 0, xTmp;
    123e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
    1245:	8b 45 14             	mov    0x14(%ebp),%eax
    1248:	89 04 24             	mov    %eax,(%esp)
    124b:	e8 cf 15 00 00       	call   281f <strlen>
    1250:	89 45 ec             	mov    %eax,-0x14(%ebp)
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    1253:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    125a:	8b 45 1c             	mov    0x1c(%ebp),%eax
    125d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1260:	eb 49                	jmp    12ab <puts_str+0x7a>
		if(str[i] < 0xA1) {
			put_ascii(c, str[i], colorNum, xTmp, y);
    1262:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    1266:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1269:	8b 45 14             	mov    0x14(%ebp),%eax
    126c:	01 c8                	add    %ecx,%eax
    126e:	0f b6 00             	movzbl (%eax),%eax
    1271:	0f b6 c0             	movzbl %al,%eax
    1274:	8b 4d 20             	mov    0x20(%ebp),%ecx
    1277:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    127b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    127e:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    1282:	89 54 24 10          	mov    %edx,0x10(%esp)
    1286:	89 44 24 0c          	mov    %eax,0xc(%esp)
    128a:	8b 45 08             	mov    0x8(%ebp),%eax
    128d:	89 04 24             	mov    %eax,(%esp)
    1290:	8b 45 0c             	mov    0xc(%ebp),%eax
    1293:	89 44 24 04          	mov    %eax,0x4(%esp)
    1297:	8b 45 10             	mov    0x10(%ebp),%eax
    129a:	89 44 24 08          	mov    %eax,0x8(%esp)
    129e:	e8 f6 fc ff ff       	call   f99 <put_ascii>
			xTmp += 8;
    12a3:	83 45 f0 08          	addl   $0x8,-0x10(%ebp)
			i++;
    12a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	int i = 0, xTmp;
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    12ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ae:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12b1:	72 af                	jb     1262 <puts_str+0x31>
			put_gbk(c, wStr, colorNum, xTmp, y);
			xTmp += 16;
			i += 2;
		}
	}
}
    12b3:	c9                   	leave  
    12b4:	c3                   	ret    

000012b5 <_RGB16BIT565>:

int _RGB16BIT565(int r,int g,int b){
    12b5:	55                   	push   %ebp
    12b6:	89 e5                	mov    %esp,%ebp
	return ((b / 8)+((g / 4)<<5)+((r / 8)<<11));
    12b8:	8b 45 10             	mov    0x10(%ebp),%eax
    12bb:	8d 50 07             	lea    0x7(%eax),%edx
    12be:	85 c0                	test   %eax,%eax
    12c0:	0f 48 c2             	cmovs  %edx,%eax
    12c3:	c1 f8 03             	sar    $0x3,%eax
    12c6:	89 c2                	mov    %eax,%edx
    12c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12cb:	8d 48 03             	lea    0x3(%eax),%ecx
    12ce:	85 c0                	test   %eax,%eax
    12d0:	0f 48 c1             	cmovs  %ecx,%eax
    12d3:	c1 f8 02             	sar    $0x2,%eax
    12d6:	c1 e0 05             	shl    $0x5,%eax
    12d9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12dc:	8b 45 08             	mov    0x8(%ebp),%eax
    12df:	8d 50 07             	lea    0x7(%eax),%edx
    12e2:	85 c0                	test   %eax,%eax
    12e4:	0f 48 c2             	cmovs  %edx,%eax
    12e7:	c1 f8 03             	sar    $0x3,%eax
    12ea:	c1 e0 0b             	shl    $0xb,%eax
    12ed:	01 c8                	add    %ecx,%eax
}
    12ef:	5d                   	pop    %ebp
    12f0:	c3                   	ret    

000012f1 <draw_picture>:

void draw_picture(Context c, PICNODE pic, int x, int y)
{
    12f1:	55                   	push   %ebp
    12f2:	89 e5                	mov    %esp,%ebp
    12f4:	53                   	push   %ebx
    12f5:	83 ec 28             	sub    $0x28,%esp
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    12f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    12ff:	e9 b1 00 00 00       	jmp    13b5 <draw_picture+0xc4>
	{
		for (j = 0; j < pic.width; j++)
    1304:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    130b:	e9 95 00 00 00       	jmp    13a5 <draw_picture+0xb4>
		{
			rgb = pic.data[i*pic.width+j];
    1310:	8b 55 14             	mov    0x14(%ebp),%edx
    1313:	8b 45 18             	mov    0x18(%ebp),%eax
    1316:	0f af 45 f8          	imul   -0x8(%ebp),%eax
    131a:	89 c1                	mov    %eax,%ecx
    131c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    131f:	01 c8                	add    %ecx,%eax
    1321:	c1 e0 02             	shl    $0x2,%eax
    1324:	01 d0                	add    %edx,%eax
    1326:	8b 00                	mov    (%eax),%eax
    1328:	89 45 ee             	mov    %eax,-0x12(%ebp)
			if (rgb.rgbReserved == 1) continue;
    132b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
    132f:	3c 01                	cmp    $0x1,%al
    1331:	75 02                	jne    1335 <draw_picture+0x44>
    1333:	eb 6c                	jmp    13a1 <draw_picture+0xb0>
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
    1335:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
    1339:	0f b6 c8             	movzbl %al,%ecx
    133c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1340:	0f b6 d0             	movzbl %al,%edx
    1343:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
    1347:	0f b6 c0             	movzbl %al,%eax
    134a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    134e:	89 54 24 04          	mov    %edx,0x4(%esp)
    1352:	89 04 24             	mov    %eax,(%esp)
    1355:	e8 5b ff ff ff       	call   12b5 <_RGB16BIT565>
    135a:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
			draw_point(c, j + x, pic.height - 1 - i + y, color);
    135e:	0f b7 4d f2          	movzwl -0xe(%ebp),%ecx
    1362:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1365:	83 e8 01             	sub    $0x1,%eax
    1368:	2b 45 f8             	sub    -0x8(%ebp),%eax
    136b:	89 c2                	mov    %eax,%edx
    136d:	8b 45 24             	mov    0x24(%ebp),%eax
    1370:	01 d0                	add    %edx,%eax
    1372:	89 c2                	mov    %eax,%edx
    1374:	8b 45 20             	mov    0x20(%ebp),%eax
    1377:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    137a:	01 d8                	add    %ebx,%eax
    137c:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    1380:	89 54 24 10          	mov    %edx,0x10(%esp)
    1384:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1388:	8b 45 08             	mov    0x8(%ebp),%eax
    138b:	89 04 24             	mov    %eax,(%esp)
    138e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1391:	89 44 24 04          	mov    %eax,0x4(%esp)
    1395:	8b 45 10             	mov    0x10(%ebp),%eax
    1398:	89 44 24 08          	mov    %eax,0x8(%esp)
    139c:	e8 72 f8 ff ff       	call   c13 <draw_point>
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
	{
		for (j = 0; j < pic.width; j++)
    13a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13a5:	8b 45 18             	mov    0x18(%ebp),%eax
    13a8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13ab:	0f 8f 5f ff ff ff    	jg     1310 <draw_picture+0x1f>
void draw_picture(Context c, PICNODE pic, int x, int y)
{
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    13b1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    13b5:	8b 45 1c             	mov    0x1c(%ebp),%eax
    13b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13bb:	0f 8f 43 ff ff ff    	jg     1304 <draw_picture+0x13>
			if (rgb.rgbReserved == 1) continue;
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
			draw_point(c, j + x, pic.height - 1 - i + y, color);
		}
	}
}
    13c1:	83 c4 28             	add    $0x28,%esp
    13c4:	5b                   	pop    %ebx
    13c5:	5d                   	pop    %ebp
    13c6:	c3                   	ret    

000013c7 <draw_line>:

void draw_line(Context c, int x0, int y0, int x1, int y1, unsigned short color)
{
    13c7:	55                   	push   %ebp
    13c8:	89 e5                	mov    %esp,%ebp
    13ca:	83 ec 3c             	sub    $0x3c,%esp
    13cd:	8b 45 24             	mov    0x24(%ebp),%eax
    13d0:	66 89 45 dc          	mov    %ax,-0x24(%ebp)
	int dx, dy, x, y, len, i;
	dx = x1 - x0;
    13d4:	8b 45 14             	mov    0x14(%ebp),%eax
    13d7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13da:	29 c2                	sub    %eax,%edx
    13dc:	89 d0                	mov    %edx,%eax
    13de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	dy = y1 - y0;
    13e1:	8b 45 18             	mov    0x18(%ebp),%eax
    13e4:	8b 55 20             	mov    0x20(%ebp),%edx
    13e7:	29 c2                	sub    %eax,%edx
    13e9:	89 d0                	mov    %edx,%eax
    13eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	x = x0 << 10;
    13ee:	8b 45 14             	mov    0x14(%ebp),%eax
    13f1:	c1 e0 0a             	shl    $0xa,%eax
    13f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	y = y0 << 10;
    13f7:	8b 45 18             	mov    0x18(%ebp),%eax
    13fa:	c1 e0 0a             	shl    $0xa,%eax
    13fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	dx = (dx < 0) ? -dx : dx;
    1400:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1403:	c1 f8 1f             	sar    $0x1f,%eax
    1406:	31 45 fc             	xor    %eax,-0x4(%ebp)
    1409:	29 45 fc             	sub    %eax,-0x4(%ebp)
	dy = (dy < 0) ? -dy : dy;
    140c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    140f:	c1 f8 1f             	sar    $0x1f,%eax
    1412:	31 45 f8             	xor    %eax,-0x8(%ebp)
    1415:	29 45 f8             	sub    %eax,-0x8(%ebp)
	if(dx >= dy) {
    1418:	8b 45 fc             	mov    -0x4(%ebp),%eax
    141b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    141e:	7c 57                	jl     1477 <draw_line+0xb0>
		len = dx + 1;
    1420:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1423:	83 c0 01             	add    $0x1,%eax
    1426:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dx = (x1 > x0) ? 1024 : -1024;
    1429:	8b 45 1c             	mov    0x1c(%ebp),%eax
    142c:	3b 45 14             	cmp    0x14(%ebp),%eax
    142f:	7e 07                	jle    1438 <draw_line+0x71>
    1431:	b8 00 04 00 00       	mov    $0x400,%eax
    1436:	eb 05                	jmp    143d <draw_line+0x76>
    1438:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    143d:	89 45 fc             	mov    %eax,-0x4(%ebp)
		dy = (y1 >= y0) ? (((y1 - y0 + 1) << 10) / len) : (((y1 - y0 - 1) << 10) / len);
    1440:	8b 45 20             	mov    0x20(%ebp),%eax
    1443:	3b 45 18             	cmp    0x18(%ebp),%eax
    1446:	7c 16                	jl     145e <draw_line+0x97>
    1448:	8b 45 18             	mov    0x18(%ebp),%eax
    144b:	8b 55 20             	mov    0x20(%ebp),%edx
    144e:	29 c2                	sub    %eax,%edx
    1450:	89 d0                	mov    %edx,%eax
    1452:	83 c0 01             	add    $0x1,%eax
    1455:	c1 e0 0a             	shl    $0xa,%eax
    1458:	99                   	cltd   
    1459:	f7 7d ec             	idivl  -0x14(%ebp)
    145c:	eb 14                	jmp    1472 <draw_line+0xab>
    145e:	8b 45 18             	mov    0x18(%ebp),%eax
    1461:	8b 55 20             	mov    0x20(%ebp),%edx
    1464:	29 c2                	sub    %eax,%edx
    1466:	89 d0                	mov    %edx,%eax
    1468:	83 e8 01             	sub    $0x1,%eax
    146b:	c1 e0 0a             	shl    $0xa,%eax
    146e:	99                   	cltd   
    146f:	f7 7d ec             	idivl  -0x14(%ebp)
    1472:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1475:	eb 55                	jmp    14cc <draw_line+0x105>
	}
	else {
		len = dy + 1;
    1477:	8b 45 f8             	mov    -0x8(%ebp),%eax
    147a:	83 c0 01             	add    $0x1,%eax
    147d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dy = (y1 > y0) ? 1024 : -1024;
    1480:	8b 45 20             	mov    0x20(%ebp),%eax
    1483:	3b 45 18             	cmp    0x18(%ebp),%eax
    1486:	7e 07                	jle    148f <draw_line+0xc8>
    1488:	b8 00 04 00 00       	mov    $0x400,%eax
    148d:	eb 05                	jmp    1494 <draw_line+0xcd>
    148f:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    1494:	89 45 f8             	mov    %eax,-0x8(%ebp)
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
    1497:	8b 45 1c             	mov    0x1c(%ebp),%eax
    149a:	3b 45 14             	cmp    0x14(%ebp),%eax
    149d:	7c 16                	jl     14b5 <draw_line+0xee>
    149f:	8b 45 14             	mov    0x14(%ebp),%eax
    14a2:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14a5:	29 c2                	sub    %eax,%edx
    14a7:	89 d0                	mov    %edx,%eax
    14a9:	83 c0 01             	add    $0x1,%eax
    14ac:	c1 e0 0a             	shl    $0xa,%eax
    14af:	99                   	cltd   
    14b0:	f7 7d ec             	idivl  -0x14(%ebp)
    14b3:	eb 14                	jmp    14c9 <draw_line+0x102>
    14b5:	8b 45 14             	mov    0x14(%ebp),%eax
    14b8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14bb:	29 c2                	sub    %eax,%edx
    14bd:	89 d0                	mov    %edx,%eax
    14bf:	83 e8 01             	sub    $0x1,%eax
    14c2:	c1 e0 0a             	shl    $0xa,%eax
    14c5:	99                   	cltd   
    14c6:	f7 7d ec             	idivl  -0x14(%ebp)
    14c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	}
	for(i = 0; i < len; i++) {
    14cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    14d3:	eb 47                	jmp    151c <draw_line+0x155>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
    14d5:	0f b7 4d dc          	movzwl -0x24(%ebp),%ecx
    14d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14dc:	c1 f8 0a             	sar    $0xa,%eax
    14df:	89 c2                	mov    %eax,%edx
    14e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e4:	c1 f8 0a             	sar    $0xa,%eax
    14e7:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    14eb:	89 54 24 10          	mov    %edx,0x10(%esp)
    14ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
    14f3:	8b 45 08             	mov    0x8(%ebp),%eax
    14f6:	89 04 24             	mov    %eax,(%esp)
    14f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1500:	8b 45 10             	mov    0x10(%ebp),%eax
    1503:	89 44 24 08          	mov    %eax,0x8(%esp)
    1507:	e8 07 f7 ff ff       	call   c13 <draw_point>
		y += dy;
    150c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    150f:	01 45 f0             	add    %eax,-0x10(%ebp)
		x += dx;
    1512:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1515:	01 45 f4             	add    %eax,-0xc(%ebp)
	else {
		len = dy + 1;
		dy = (y1 > y0) ? 1024 : -1024;
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
	}
	for(i = 0; i < len; i++) {
    1518:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    151c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1522:	7c b1                	jl     14d5 <draw_line+0x10e>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
		y += dy;
		x += dx;
	}
}
    1524:	c9                   	leave  
    1525:	c3                   	ret    

00001526 <draw_window>:

void
draw_window(Context c, char *title)
{
    1526:	55                   	push   %ebp
    1527:	89 e5                	mov    %esp,%ebp
    1529:	83 ec 38             	sub    $0x38,%esp
  PICNODE pic;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    152c:	8b 45 0c             	mov    0xc(%ebp),%eax
    152f:	83 e8 01             	sub    $0x1,%eax
    1532:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1539:	00 
    153a:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    1541:	00 
    1542:	89 44 24 14          	mov    %eax,0x14(%esp)
    1546:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    154d:	00 
    154e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1555:	00 
    1556:	8b 45 08             	mov    0x8(%ebp),%eax
    1559:	89 04 24             	mov    %eax,(%esp)
    155c:	8b 45 0c             	mov    0xc(%ebp),%eax
    155f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1563:	8b 45 10             	mov    0x10(%ebp),%eax
    1566:	89 44 24 08          	mov    %eax,0x8(%esp)
    156a:	e8 58 fe ff ff       	call   13c7 <draw_line>
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    156f:	8b 45 10             	mov    0x10(%ebp),%eax
    1572:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1575:	8b 45 0c             	mov    0xc(%ebp),%eax
    1578:	8d 50 ff             	lea    -0x1(%eax),%edx
    157b:	8b 45 0c             	mov    0xc(%ebp),%eax
    157e:	83 e8 01             	sub    $0x1,%eax
    1581:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1588:	00 
    1589:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    158d:	89 54 24 14          	mov    %edx,0x14(%esp)
    1591:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1598:	00 
    1599:	89 44 24 0c          	mov    %eax,0xc(%esp)
    159d:	8b 45 08             	mov    0x8(%ebp),%eax
    15a0:	89 04 24             	mov    %eax,(%esp)
    15a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    15aa:	8b 45 10             	mov    0x10(%ebp),%eax
    15ad:	89 44 24 08          	mov    %eax,0x8(%esp)
    15b1:	e8 11 fe ff ff       	call   13c7 <draw_line>
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    15b6:	8b 45 10             	mov    0x10(%ebp),%eax
    15b9:	8d 48 ff             	lea    -0x1(%eax),%ecx
    15bc:	8b 45 10             	mov    0x10(%ebp),%eax
    15bf:	8d 50 ff             	lea    -0x1(%eax),%edx
    15c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c5:	83 e8 01             	sub    $0x1,%eax
    15c8:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    15cf:	00 
    15d0:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    15d4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    15db:	00 
    15dc:	89 54 24 10          	mov    %edx,0x10(%esp)
    15e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
    15e4:	8b 45 08             	mov    0x8(%ebp),%eax
    15e7:	89 04 24             	mov    %eax,(%esp)
    15ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    15ed:	89 44 24 04          	mov    %eax,0x4(%esp)
    15f1:	8b 45 10             	mov    0x10(%ebp),%eax
    15f4:	89 44 24 08          	mov    %eax,0x8(%esp)
    15f8:	e8 ca fd ff ff       	call   13c7 <draw_line>
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    15fd:	8b 45 10             	mov    0x10(%ebp),%eax
    1600:	83 e8 01             	sub    $0x1,%eax
    1603:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    160a:	00 
    160b:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    1612:	00 
    1613:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    161a:	00 
    161b:	89 44 24 10          	mov    %eax,0x10(%esp)
    161f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1626:	00 
    1627:	8b 45 08             	mov    0x8(%ebp),%eax
    162a:	89 04 24             	mov    %eax,(%esp)
    162d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1630:	89 44 24 04          	mov    %eax,0x4(%esp)
    1634:	8b 45 10             	mov    0x10(%ebp),%eax
    1637:	89 44 24 08          	mov    %eax,0x8(%esp)
    163b:	e8 87 fd ff ff       	call   13c7 <draw_line>
  fill_rect(c, 1, 1, c.width - 2, BOTTOMBAR_HEIGHT, TOPBAR_COLOR);
    1640:	8b 45 0c             	mov    0xc(%ebp),%eax
    1643:	83 e8 02             	sub    $0x2,%eax
    1646:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    164d:	00 
    164e:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    1655:	00 
    1656:	89 44 24 14          	mov    %eax,0x14(%esp)
    165a:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    1661:	00 
    1662:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1669:	00 
    166a:	8b 45 08             	mov    0x8(%ebp),%eax
    166d:	89 04 24             	mov    %eax,(%esp)
    1670:	8b 45 0c             	mov    0xc(%ebp),%eax
    1673:	89 44 24 04          	mov    %eax,0x4(%esp)
    1677:	8b 45 10             	mov    0x10(%ebp),%eax
    167a:	89 44 24 08          	mov    %eax,0x8(%esp)
    167e:	e8 cf f5 ff ff       	call   c52 <fill_rect>
  fill_rect(c, 1, c.height - 1 - BOTTOMBAR_HEIGHT, c.width - 2, BOTTOMBAR_HEIGHT, BOTTOMBAR_COLOR);
    1683:	8b 45 0c             	mov    0xc(%ebp),%eax
    1686:	83 e8 02             	sub    $0x2,%eax
    1689:	89 c2                	mov    %eax,%edx
    168b:	8b 45 10             	mov    0x10(%ebp),%eax
    168e:	83 e8 15             	sub    $0x15,%eax
    1691:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    1698:	00 
    1699:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    16a0:	00 
    16a1:	89 54 24 14          	mov    %edx,0x14(%esp)
    16a5:	89 44 24 10          	mov    %eax,0x10(%esp)
    16a9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    16b0:	00 
    16b1:	8b 45 08             	mov    0x8(%ebp),%eax
    16b4:	89 04 24             	mov    %eax,(%esp)
    16b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ba:	89 44 24 04          	mov    %eax,0x4(%esp)
    16be:	8b 45 10             	mov    0x10(%ebp),%eax
    16c1:	89 44 24 08          	mov    %eax,0x8(%esp)
    16c5:	e8 88 f5 ff ff       	call   c52 <fill_rect>

  loadBitmap(&pic, "close.bmp");
    16ca:	c7 44 24 04 5c 93 00 	movl   $0x935c,0x4(%esp)
    16d1:	00 
    16d2:	8d 45 ec             	lea    -0x14(%ebp),%eax
    16d5:	89 04 24             	mov    %eax,(%esp)
    16d8:	e8 44 01 00 00       	call   1821 <loadBitmap>
  draw_picture(c, pic, 3, 3);
    16dd:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    16e4:	00 
    16e5:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    16ec:	00 
    16ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16f0:	89 44 24 0c          	mov    %eax,0xc(%esp)
    16f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16f7:	89 44 24 10          	mov    %eax,0x10(%esp)
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	89 44 24 14          	mov    %eax,0x14(%esp)
    1702:	8b 45 08             	mov    0x8(%ebp),%eax
    1705:	89 04 24             	mov    %eax,(%esp)
    1708:	8b 45 0c             	mov    0xc(%ebp),%eax
    170b:	89 44 24 04          	mov    %eax,0x4(%esp)
    170f:	8b 45 10             	mov    0x10(%ebp),%eax
    1712:	89 44 24 08          	mov    %eax,0x8(%esp)
    1716:	e8 d6 fb ff ff       	call   12f1 <draw_picture>
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    171b:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    1722:	00 
    1723:	c7 44 24 14 19 00 00 	movl   $0x19,0x14(%esp)
    172a:	00 
    172b:	c7 44 24 10 ff ff 00 	movl   $0xffff,0x10(%esp)
    1732:	00 
    1733:	8b 45 14             	mov    0x14(%ebp),%eax
    1736:	89 44 24 0c          	mov    %eax,0xc(%esp)
    173a:	8b 45 08             	mov    0x8(%ebp),%eax
    173d:	89 04 24             	mov    %eax,(%esp)
    1740:	8b 45 0c             	mov    0xc(%ebp),%eax
    1743:	89 44 24 04          	mov    %eax,0x4(%esp)
    1747:	8b 45 10             	mov    0x10(%ebp),%eax
    174a:	89 44 24 08          	mov    %eax,0x8(%esp)
    174e:	e8 de fa ff ff       	call   1231 <puts_str>
  freepic(&pic);
    1753:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1756:	89 04 24             	mov    %eax,(%esp)
    1759:	e8 6f 06 00 00       	call   1dcd <freepic>
}
    175e:	c9                   	leave  
    175f:	c3                   	ret    

00001760 <load_iconlist>:

void load_iconlist(ICON* iconlist, int len)
{
    1760:	55                   	push   %ebp
    1761:	89 e5                	mov    %esp,%ebp
    1763:	83 ec 28             	sub    $0x28,%esp
	int i;
	for (i = 0; i < len; i++)
    1766:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    176d:	eb 29                	jmp    1798 <load_iconlist+0x38>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
    176f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1772:	6b d0 34             	imul   $0x34,%eax,%edx
    1775:	8b 45 08             	mov    0x8(%ebp),%eax
    1778:	01 d0                	add    %edx,%eax
    177a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    177d:	6b ca 34             	imul   $0x34,%edx,%ecx
    1780:	8b 55 08             	mov    0x8(%ebp),%edx
    1783:	01 ca                	add    %ecx,%edx
    1785:	83 c2 28             	add    $0x28,%edx
    1788:	89 44 24 04          	mov    %eax,0x4(%esp)
    178c:	89 14 24             	mov    %edx,(%esp)
    178f:	e8 8d 00 00 00       	call   1821 <loadBitmap>
}

void load_iconlist(ICON* iconlist, int len)
{
	int i;
	for (i = 0; i < len; i++)
    1794:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1798:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    179e:	7c cf                	jl     176f <load_iconlist+0xf>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
	}
}
    17a0:	c9                   	leave  
    17a1:	c3                   	ret    

000017a2 <draw_iconlist>:
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    17a2:	55                   	push   %ebp
    17a3:	89 e5                	mov    %esp,%ebp
    17a5:	53                   	push   %ebx
    17a6:	83 ec 30             	sub    $0x30,%esp
    int i;
    for (i = 0; i < len; i++)
    17a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    17b0:	eb 61                	jmp    1813 <draw_iconlist+0x71>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    17b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b5:	6b d0 34             	imul   $0x34,%eax,%edx
    17b8:	8b 45 14             	mov    0x14(%ebp),%eax
    17bb:	01 d0                	add    %edx,%eax
    17bd:	8b 48 24             	mov    0x24(%eax),%ecx
    17c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c3:	6b d0 34             	imul   $0x34,%eax,%edx
    17c6:	8b 45 14             	mov    0x14(%ebp),%eax
    17c9:	01 d0                	add    %edx,%eax
    17cb:	8b 50 20             	mov    0x20(%eax),%edx
    17ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d1:	6b d8 34             	imul   $0x34,%eax,%ebx
    17d4:	8b 45 14             	mov    0x14(%ebp),%eax
    17d7:	01 d8                	add    %ebx,%eax
    17d9:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    17dd:	89 54 24 18          	mov    %edx,0x18(%esp)
    17e1:	8b 50 28             	mov    0x28(%eax),%edx
    17e4:	89 54 24 0c          	mov    %edx,0xc(%esp)
    17e8:	8b 50 2c             	mov    0x2c(%eax),%edx
    17eb:	89 54 24 10          	mov    %edx,0x10(%esp)
    17ef:	8b 40 30             	mov    0x30(%eax),%eax
    17f2:	89 44 24 14          	mov    %eax,0x14(%esp)
    17f6:	8b 45 08             	mov    0x8(%ebp),%eax
    17f9:	89 04 24             	mov    %eax,(%esp)
    17fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ff:	89 44 24 04          	mov    %eax,0x4(%esp)
    1803:	8b 45 10             	mov    0x10(%ebp),%eax
    1806:	89 44 24 08          	mov    %eax,0x8(%esp)
    180a:	e8 e2 fa ff ff       	call   12f1 <draw_picture>
	}
}
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    int i;
    for (i = 0; i < len; i++)
    180f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1813:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1816:	3b 45 18             	cmp    0x18(%ebp),%eax
    1819:	7c 97                	jl     17b2 <draw_iconlist+0x10>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    }
}
    181b:	83 c4 30             	add    $0x30,%esp
    181e:	5b                   	pop    %ebx
    181f:	5d                   	pop    %ebp
    1820:	c3                   	ret    

00001821 <loadBitmap>:
#include "clickable.h"

void showRgbQuan(RGBQUAD* pRGB);
void showBmpHead(BITMAPFILEHEADER* pBmpHead);
void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead);
void loadBitmap(PICNODE *pic, char pic_name[]) {
    1821:	55                   	push   %ebp
    1822:	89 e5                	mov    %esp,%ebp
    1824:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	BITMAPFILEHEADER bitHead;
	BITMAPINFOHEADER bitInfoHead;
	char *BmpFileHeader;
	WORD *temp_WORD;
	DWORD *temp_DWORD;
	int fd, n, i, j, k, index = 0;
    182a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int width;
	int height;

	if ((fd = open(pic_name, 0)) < 0) {
    1831:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1838:	00 
    1839:	8b 45 0c             	mov    0xc(%ebp),%eax
    183c:	89 04 24             	mov    %eax,(%esp)
    183f:	e8 ef 11 00 00       	call   2a33 <open>
    1844:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1847:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    184b:	79 20                	jns    186d <loadBitmap+0x4c>
		printf(0, "cannot open %s\n", pic_name);
    184d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1850:	89 44 24 08          	mov    %eax,0x8(%esp)
    1854:	c7 44 24 04 68 93 00 	movl   $0x9368,0x4(%esp)
    185b:	00 
    185c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1863:	e8 73 13 00 00       	call   2bdb <printf>
		return;
    1868:	e9 ef 02 00 00       	jmp    1b5c <loadBitmap+0x33b>
	}
	printf(0, "reading bitmap: %s\n", pic_name);
    186d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1870:	89 44 24 08          	mov    %eax,0x8(%esp)
    1874:	c7 44 24 04 78 93 00 	movl   $0x9378,0x4(%esp)
    187b:	00 
    187c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1883:	e8 53 13 00 00       	call   2bdb <printf>
	//pfile = fopen(strFile,"rb");//打开文件
	BmpFileHeader = (char *) malloc(14 * sizeof(char));
    1888:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
    188f:	e8 33 16 00 00       	call   2ec7 <malloc>
    1894:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//printf(0, "file bmp open success.\n");
	//读取位图文件头信息
	//printf(0, "reading BmpFileHeader.\n");
	n = read(fd, BmpFileHeader, 14);
    1897:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    189e:	00 
    189f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18a2:	89 44 24 04          	mov    %eax,0x4(%esp)
    18a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18a9:	89 04 24             	mov    %eax,(%esp)
    18ac:	e8 5a 11 00 00       	call   2a0b <read>
    18b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
	//fread(BmpFileHeader,1,14,pfile);
	temp_WORD = (WORD*) (BmpFileHeader);
    18b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
	bitHead.bfType = *temp_WORD;
    18ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
    18bd:	0f b7 00             	movzwl (%eax),%eax
    18c0:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
	if (bitHead.bfType != 0x4d42) {
    18c4:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    18c8:	66 3d 42 4d          	cmp    $0x4d42,%ax
    18cc:	74 19                	je     18e7 <loadBitmap+0xc6>
		printf(0, "file is not .bmp file!");
    18ce:	c7 44 24 04 8c 93 00 	movl   $0x938c,0x4(%esp)
    18d5:	00 
    18d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18dd:	e8 f9 12 00 00       	call   2bdb <printf>
		return;
    18e2:	e9 75 02 00 00       	jmp    1b5c <loadBitmap+0x33b>
	}
	temp_DWORD = (DWORD *) (BmpFileHeader + sizeof(bitHead.bfType));
    18e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18ea:	83 c0 02             	add    $0x2,%eax
    18ed:	89 45 d8             	mov    %eax,-0x28(%ebp)
	bitHead.bfSize = *temp_DWORD;
    18f0:	8b 45 d8             	mov    -0x28(%ebp),%eax
    18f3:	8b 00                	mov    (%eax),%eax
    18f5:	89 45 b0             	mov    %eax,-0x50(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    18f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18fb:	83 c0 06             	add    $0x6,%eax
    18fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize));
	bitHead.bfReserved1 = *temp_WORD;
    1901:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1904:	0f b7 00             	movzwl (%eax),%eax
    1907:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    190b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    190e:	83 c0 08             	add    $0x8,%eax
    1911:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1));
	bitHead.bfReserved2 = *temp_WORD;
    1914:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1917:	0f b7 00             	movzwl (%eax),%eax
    191a:	66 89 45 b6          	mov    %ax,-0x4a(%ebp)
	temp_DWORD = (DWORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    191e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1921:	83 c0 0a             	add    $0xa,%eax
    1924:	89 45 d8             	mov    %eax,-0x28(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1)
			+ sizeof(bitHead.bfReserved2));
	bitHead.bfOffBits = *temp_DWORD;
    1927:	8b 45 d8             	mov    -0x28(%ebp),%eax
    192a:	8b 00                	mov    (%eax),%eax
    192c:	89 45 b8             	mov    %eax,-0x48(%ebp)
	//printf(0, "reading BmpFileHeader success!\n");
	//showBmpHead(&bitHead);
	//printf(0, "\n\n");
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
    192f:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    1936:	00 
    1937:	8d 45 84             	lea    -0x7c(%ebp),%eax
    193a:	89 44 24 04          	mov    %eax,0x4(%esp)
    193e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1941:	89 04 24             	mov    %eax,(%esp)
    1944:	e8 c2 10 00 00       	call   2a0b <read>
	width = bitInfoHead.biWidth;
    1949:	8b 45 88             	mov    -0x78(%ebp),%eax
    194c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	height = bitInfoHead.biHeight;
    194f:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1952:	89 45 d0             	mov    %eax,-0x30(%ebp)
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
			width * height * sizeof(RGBQUAD));
    1955:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1958:	0f af 45 d0          	imul   -0x30(%ebp),%eax
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
	width = bitInfoHead.biWidth;
	height = bitInfoHead.biHeight;
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
    195c:	c1 e0 02             	shl    $0x2,%eax
    195f:	89 44 24 10          	mov    %eax,0x10(%esp)
    1963:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1966:	89 44 24 0c          	mov    %eax,0xc(%esp)
    196a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    196d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1971:	c7 44 24 04 a4 93 00 	movl   $0x93a4,0x4(%esp)
    1978:	00 
    1979:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1980:	e8 56 12 00 00       	call   2bdb <printf>
			width * height * sizeof(RGBQUAD));
	//fread(&bitInfoHead,1,sizeof(BITMAPINFOHEADER),pfile);
	//showBmpInforHead(&bitInfoHead);
	//printf(0, "\n");
	if (n == 0) {
    1985:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1989:	75 14                	jne    199f <loadBitmap+0x17e>
		printf(0, "0");
    198b:	c7 44 24 04 c9 93 00 	movl   $0x93c9,0x4(%esp)
    1992:	00 
    1993:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    199a:	e8 3c 12 00 00       	call   2bdb <printf>
	}

	//分配内存空间把源图存入内存
	int l_width = WIDTHBYTES(width * bitInfoHead.biBitCount);//计算位图的实际宽度并确保它为32的倍数
    199f:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    19a3:	0f b7 c0             	movzwl %ax,%eax
    19a6:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    19aa:	83 c0 1f             	add    $0x1f,%eax
    19ad:	8d 50 1f             	lea    0x1f(%eax),%edx
    19b0:	85 c0                	test   %eax,%eax
    19b2:	0f 48 c2             	cmovs  %edx,%eax
    19b5:	c1 f8 05             	sar    $0x5,%eax
    19b8:	c1 e0 02             	shl    $0x2,%eax
    19bb:	89 45 cc             	mov    %eax,-0x34(%ebp)
	BYTE *pColorData = (BYTE *) malloc(height * l_width);
    19be:	8b 45 d0             	mov    -0x30(%ebp),%eax
    19c1:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    19c5:	89 04 24             	mov    %eax,(%esp)
    19c8:	e8 fa 14 00 00       	call   2ec7 <malloc>
    19cd:	89 45 c8             	mov    %eax,-0x38(%ebp)
	memset(pColorData, 0, (uint) height * l_width);
    19d0:	8b 55 d0             	mov    -0x30(%ebp),%edx
    19d3:	8b 45 cc             	mov    -0x34(%ebp),%eax
    19d6:	0f af c2             	imul   %edx,%eax
    19d9:	89 44 24 08          	mov    %eax,0x8(%esp)
    19dd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19e4:	00 
    19e5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    19e8:	89 04 24             	mov    %eax,(%esp)
    19eb:	e8 56 0e 00 00       	call   2846 <memset>
	long nData = height * l_width;
    19f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    19f3:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    19f7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	//把位图数据信息读到数组里
	read(fd, pColorData, nData);
    19fa:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    19fd:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a01:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1a04:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a08:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a0b:	89 04 24             	mov    %eax,(%esp)
    1a0e:	e8 f8 0f 00 00       	call   2a0b <read>

	//printf(0, "reading bmp data.\n");
	//将位图数据转化为RGB数据
	RGBQUAD* dataOfBmp;

	dataOfBmp = (RGBQUAD *) malloc(width * height * sizeof(RGBQUAD));//用于保存各像素对应的RGB数据
    1a13:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1a16:	0f af 45 d0          	imul   -0x30(%ebp),%eax
    1a1a:	c1 e0 02             	shl    $0x2,%eax
    1a1d:	89 04 24             	mov    %eax,(%esp)
    1a20:	e8 a2 14 00 00       	call   2ec7 <malloc>
    1a25:	89 45 c0             	mov    %eax,-0x40(%ebp)
	memset(dataOfBmp, 0, (uint) width * height * sizeof(RGBQUAD));
    1a28:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1a2b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1a2e:	0f af c2             	imul   %edx,%eax
    1a31:	c1 e0 02             	shl    $0x2,%eax
    1a34:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a38:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a3f:	00 
    1a40:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1a43:	89 04 24             	mov    %eax,(%esp)
    1a46:	e8 fb 0d 00 00       	call   2846 <memset>
	if (bitInfoHead.biBitCount < 24)	//有调色板，即位图为非真彩色
    1a4b:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    1a4f:	66 83 f8 17          	cmp    $0x17,%ax
    1a53:	77 19                	ja     1a6e <loadBitmap+0x24d>
			{
		printf(0, "%s is not a 24 bit bmp! return.");
    1a55:	c7 44 24 04 cc 93 00 	movl   $0x93cc,0x4(%esp)
    1a5c:	00 
    1a5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a64:	e8 72 11 00 00       	call   2bdb <printf>
		return;
    1a69:	e9 ee 00 00 00       	jmp    1b5c <loadBitmap+0x33b>
	} else	//位图为24位真彩色
	{
		index = 0;
    1a6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (i = 0; i < height; i++)
    1a75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a7c:	e9 94 00 00 00       	jmp    1b15 <loadBitmap+0x2f4>
			for (j = 0; j < width; j++) {
    1a81:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1a88:	eb 7b                	jmp    1b05 <loadBitmap+0x2e4>
				k = i * l_width + j * 3;
    1a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8d:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    1a91:	89 c1                	mov    %eax,%ecx
    1a93:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1a96:	89 d0                	mov    %edx,%eax
    1a98:	01 c0                	add    %eax,%eax
    1a9a:	01 d0                	add    %edx,%eax
    1a9c:	01 c8                	add    %ecx,%eax
    1a9e:	89 45 bc             	mov    %eax,-0x44(%ebp)
				dataOfBmp[index].rgbRed = pColorData[k + 2];
    1aa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aa4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1aab:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1aae:	01 c2                	add    %eax,%edx
    1ab0:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1ab3:	8d 48 02             	lea    0x2(%eax),%ecx
    1ab6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ab9:	01 c8                	add    %ecx,%eax
    1abb:	0f b6 00             	movzbl (%eax),%eax
    1abe:	88 42 02             	mov    %al,0x2(%edx)
				dataOfBmp[index].rgbGreen = pColorData[k + 1];
    1ac1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ac4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1acb:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1ace:	01 c2                	add    %eax,%edx
    1ad0:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1ad3:	8d 48 01             	lea    0x1(%eax),%ecx
    1ad6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ad9:	01 c8                	add    %ecx,%eax
    1adb:	0f b6 00             	movzbl (%eax),%eax
    1ade:	88 42 01             	mov    %al,0x1(%edx)
				dataOfBmp[index].rgbBlue = pColorData[k];
    1ae1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1aeb:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1aee:	01 c2                	add    %eax,%edx
    1af0:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1af3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1af6:	01 c8                	add    %ecx,%eax
    1af8:	0f b6 00             	movzbl (%eax),%eax
    1afb:	88 02                	mov    %al,(%edx)
				index++;
    1afd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
			for (j = 0; j < width; j++) {
    1b01:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b08:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
    1b0b:	0f 8c 79 ff ff ff    	jl     1a8a <loadBitmap+0x269>
		printf(0, "%s is not a 24 bit bmp! return.");
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
    1b11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b18:	3b 45 d0             	cmp    -0x30(%ebp),%eax
    1b1b:	0f 8c 60 ff ff ff    	jl     1a81 <loadBitmap+0x260>
//			printf(0, "\n");
//		}
//		showRgbQuan(&dataOfBmp[i]);
//	}

	close(fd);
    1b21:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b24:	89 04 24             	mov    %eax,(%esp)
    1b27:	e8 ef 0e 00 00       	call   2a1b <close>

	//free(dataOfBmp);
	pic->data = dataOfBmp;
    1b2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2f:	8b 55 c0             	mov    -0x40(%ebp),%edx
    1b32:	89 10                	mov    %edx,(%eax)
	pic->width = width;
    1b34:	8b 45 08             	mov    0x8(%ebp),%eax
    1b37:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1b3a:	89 50 04             	mov    %edx,0x4(%eax)
	pic->height = height;
    1b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b40:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1b43:	89 50 08             	mov    %edx,0x8(%eax)
	free(pColorData);
    1b46:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1b49:	89 04 24             	mov    %eax,(%esp)
    1b4c:	e8 3d 12 00 00       	call   2d8e <free>
	free(BmpFileHeader);
    1b51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b54:	89 04 24             	mov    %eax,(%esp)
    1b57:	e8 32 12 00 00       	call   2d8e <free>
	//printf("\n");
}
    1b5c:	c9                   	leave  
    1b5d:	c3                   	ret    

00001b5e <showBmpHead>:

void showBmpHead(BITMAPFILEHEADER* pBmpHead) {
    1b5e:	55                   	push   %ebp
    1b5f:	89 e5                	mov    %esp,%ebp
    1b61:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图文件头:\n");
    1b64:	c7 44 24 04 ec 93 00 	movl   $0x93ec,0x4(%esp)
    1b6b:	00 
    1b6c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b73:	e8 63 10 00 00       	call   2bdb <printf>
	printf(0, "bmp格式标志bftype：0x%x\n", pBmpHead->bfType);
    1b78:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7b:	0f b7 00             	movzwl (%eax),%eax
    1b7e:	0f b7 c0             	movzwl %ax,%eax
    1b81:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b85:	c7 44 24 04 fe 93 00 	movl   $0x93fe,0x4(%esp)
    1b8c:	00 
    1b8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b94:	e8 42 10 00 00       	call   2bdb <printf>
	printf(0, "文件大小:%d\n", pBmpHead->bfSize);
    1b99:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9c:	8b 40 04             	mov    0x4(%eax),%eax
    1b9f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ba3:	c7 44 24 04 1c 94 00 	movl   $0x941c,0x4(%esp)
    1baa:	00 
    1bab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1bb2:	e8 24 10 00 00       	call   2bdb <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved1);
    1bb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bba:	0f b7 40 08          	movzwl 0x8(%eax),%eax
    1bbe:	0f b7 c0             	movzwl %ax,%eax
    1bc1:	89 44 24 08          	mov    %eax,0x8(%esp)
    1bc5:	c7 44 24 04 2d 94 00 	movl   $0x942d,0x4(%esp)
    1bcc:	00 
    1bcd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1bd4:	e8 02 10 00 00       	call   2bdb <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved2);
    1bd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdc:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    1be0:	0f b7 c0             	movzwl %ax,%eax
    1be3:	89 44 24 08          	mov    %eax,0x8(%esp)
    1be7:	c7 44 24 04 2d 94 00 	movl   $0x942d,0x4(%esp)
    1bee:	00 
    1bef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1bf6:	e8 e0 0f 00 00       	call   2bdb <printf>
	printf(0, "实际位图数据的偏移字节数:%d\n", pBmpHead->bfOffBits);
    1bfb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfe:	8b 40 0c             	mov    0xc(%eax),%eax
    1c01:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c05:	c7 44 24 04 3c 94 00 	movl   $0x943c,0x4(%esp)
    1c0c:	00 
    1c0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c14:	e8 c2 0f 00 00       	call   2bdb <printf>
}
    1c19:	c9                   	leave  
    1c1a:	c3                   	ret    

00001c1b <showBmpInforHead>:

void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead) {
    1c1b:	55                   	push   %ebp
    1c1c:	89 e5                	mov    %esp,%ebp
    1c1e:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图信息头:\n");
    1c21:	c7 44 24 04 65 94 00 	movl   $0x9465,0x4(%esp)
    1c28:	00 
    1c29:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c30:	e8 a6 0f 00 00       	call   2bdb <printf>
	printf(0, "结构体的长度:%d\n", pBmpInforHead->biSize);
    1c35:	8b 45 08             	mov    0x8(%ebp),%eax
    1c38:	8b 00                	mov    (%eax),%eax
    1c3a:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c3e:	c7 44 24 04 77 94 00 	movl   $0x9477,0x4(%esp)
    1c45:	00 
    1c46:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c4d:	e8 89 0f 00 00       	call   2bdb <printf>
	printf(0, "位图宽:%d\n", pBmpInforHead->biWidth);
    1c52:	8b 45 08             	mov    0x8(%ebp),%eax
    1c55:	8b 40 04             	mov    0x4(%eax),%eax
    1c58:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c5c:	c7 44 24 04 8e 94 00 	movl   $0x948e,0x4(%esp)
    1c63:	00 
    1c64:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c6b:	e8 6b 0f 00 00       	call   2bdb <printf>
	printf(0, "位图高:%d\n", pBmpInforHead->biHeight);
    1c70:	8b 45 08             	mov    0x8(%ebp),%eax
    1c73:	8b 40 08             	mov    0x8(%eax),%eax
    1c76:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c7a:	c7 44 24 04 9c 94 00 	movl   $0x949c,0x4(%esp)
    1c81:	00 
    1c82:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c89:	e8 4d 0f 00 00       	call   2bdb <printf>
	printf(0, "biPlanes平面数:%d\n", pBmpInforHead->biPlanes);
    1c8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c91:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
    1c95:	0f b7 c0             	movzwl %ax,%eax
    1c98:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c9c:	c7 44 24 04 aa 94 00 	movl   $0x94aa,0x4(%esp)
    1ca3:	00 
    1ca4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1cab:	e8 2b 0f 00 00       	call   2bdb <printf>
	printf(0, "biBitCount采用颜色位数:%d\n", pBmpInforHead->biBitCount);
    1cb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb3:	0f b7 40 0e          	movzwl 0xe(%eax),%eax
    1cb7:	0f b7 c0             	movzwl %ax,%eax
    1cba:	89 44 24 08          	mov    %eax,0x8(%esp)
    1cbe:	c7 44 24 04 c0 94 00 	movl   $0x94c0,0x4(%esp)
    1cc5:	00 
    1cc6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1ccd:	e8 09 0f 00 00       	call   2bdb <printf>
	printf(0, "压缩方式:%d\n", pBmpInforHead->biCompression);
    1cd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd5:	8b 40 10             	mov    0x10(%eax),%eax
    1cd8:	89 44 24 08          	mov    %eax,0x8(%esp)
    1cdc:	c7 44 24 04 e1 94 00 	movl   $0x94e1,0x4(%esp)
    1ce3:	00 
    1ce4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1ceb:	e8 eb 0e 00 00       	call   2bdb <printf>
	printf(0, "biSizeImage实际位图数据占用的字节数:%d\n", pBmpInforHead->biSizeImage);
    1cf0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf3:	8b 40 14             	mov    0x14(%eax),%eax
    1cf6:	89 44 24 08          	mov    %eax,0x8(%esp)
    1cfa:	c7 44 24 04 f4 94 00 	movl   $0x94f4,0x4(%esp)
    1d01:	00 
    1d02:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d09:	e8 cd 0e 00 00       	call   2bdb <printf>
	printf(0, "X方向分辨率:%d\n", pBmpInforHead->biXPelsPerMeter);
    1d0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d11:	8b 40 18             	mov    0x18(%eax),%eax
    1d14:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d18:	c7 44 24 04 28 95 00 	movl   $0x9528,0x4(%esp)
    1d1f:	00 
    1d20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d27:	e8 af 0e 00 00       	call   2bdb <printf>
	printf(0, "Y方向分辨率:%d\n", pBmpInforHead->biYPelsPerMeter);
    1d2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2f:	8b 40 1c             	mov    0x1c(%eax),%eax
    1d32:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d36:	c7 44 24 04 3d 95 00 	movl   $0x953d,0x4(%esp)
    1d3d:	00 
    1d3e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d45:	e8 91 0e 00 00       	call   2bdb <printf>
	printf(0, "使用的颜色数:%d\n", pBmpInforHead->biClrUsed);
    1d4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4d:	8b 40 20             	mov    0x20(%eax),%eax
    1d50:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d54:	c7 44 24 04 52 95 00 	movl   $0x9552,0x4(%esp)
    1d5b:	00 
    1d5c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d63:	e8 73 0e 00 00       	call   2bdb <printf>
	printf(0, "重要颜色数:%d\n", pBmpInforHead->biClrImportant);
    1d68:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6b:	8b 40 24             	mov    0x24(%eax),%eax
    1d6e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d72:	c7 44 24 04 69 95 00 	movl   $0x9569,0x4(%esp)
    1d79:	00 
    1d7a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d81:	e8 55 0e 00 00       	call   2bdb <printf>
}
    1d86:	c9                   	leave  
    1d87:	c3                   	ret    

00001d88 <showRgbQuan>:
void showRgbQuan(RGBQUAD* pRGB) {
    1d88:	55                   	push   %ebp
    1d89:	89 e5                	mov    %esp,%ebp
    1d8b:	83 ec 28             	sub    $0x28,%esp
	printf(0, "(%d,%d,%d) ", pRGB->rgbRed, pRGB->rgbGreen, pRGB->rgbBlue);
    1d8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d91:	0f b6 00             	movzbl (%eax),%eax
    1d94:	0f b6 c8             	movzbl %al,%ecx
    1d97:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    1d9e:	0f b6 d0             	movzbl %al,%edx
    1da1:	8b 45 08             	mov    0x8(%ebp),%eax
    1da4:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1da8:	0f b6 c0             	movzbl %al,%eax
    1dab:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    1daf:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1db3:	89 44 24 08          	mov    %eax,0x8(%esp)
    1db7:	c7 44 24 04 7d 95 00 	movl   $0x957d,0x4(%esp)
    1dbe:	00 
    1dbf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1dc6:	e8 10 0e 00 00       	call   2bdb <printf>
}
    1dcb:	c9                   	leave  
    1dcc:	c3                   	ret    

00001dcd <freepic>:

void freepic(PICNODE *pic) {
    1dcd:	55                   	push   %ebp
    1dce:	89 e5                	mov    %esp,%ebp
    1dd0:	83 ec 18             	sub    $0x18,%esp
	free(pic->data);
    1dd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd6:	8b 00                	mov    (%eax),%eax
    1dd8:	89 04 24             	mov    %eax,(%esp)
    1ddb:	e8 ae 0f 00 00       	call   2d8e <free>
}
    1de0:	c9                   	leave  
    1de1:	c3                   	ret    

00001de2 <set_icon_alpha>:

void set_icon_alpha(PICNODE *pic) {
    1de2:	55                   	push   %ebp
    1de3:	89 e5                	mov    %esp,%ebp
    1de5:	53                   	push   %ebx
    1de6:	81 ec 84 00 00 00    	sub    $0x84,%esp
	int W = 15;
    1dec:	c7 45 ec 0f 00 00 00 	movl   $0xf,-0x14(%ebp)
	Rect r1 = initRect(0, 0, W, W);
    1df3:	8d 45 dc             	lea    -0x24(%ebp),%eax
    1df6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1df9:	89 54 24 10          	mov    %edx,0x10(%esp)
    1dfd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1e00:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1e04:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1e0b:	00 
    1e0c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1e13:	00 
    1e14:	89 04 24             	mov    %eax,(%esp)
    1e17:	e8 80 02 00 00       	call   209c <initRect>
    1e1c:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(pic->width - W, 0, W, W);
    1e1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e22:	8b 40 04             	mov    0x4(%eax),%eax
    1e25:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1e28:	89 c2                	mov    %eax,%edx
    1e2a:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1e2d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1e30:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    1e34:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1e37:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1e3b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1e42:	00 
    1e43:	89 54 24 04          	mov    %edx,0x4(%esp)
    1e47:	89 04 24             	mov    %eax,(%esp)
    1e4a:	e8 4d 02 00 00       	call   209c <initRect>
    1e4f:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
    1e52:	8b 45 08             	mov    0x8(%ebp),%eax
    1e55:	8b 40 08             	mov    0x8(%eax),%eax
    1e58:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1e5b:	89 c1                	mov    %eax,%ecx
    1e5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e60:	8b 40 04             	mov    0x4(%eax),%eax
    1e63:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1e66:	89 c2                	mov    %eax,%edx
    1e68:	8d 45 bc             	lea    -0x44(%ebp),%eax
    1e6b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    1e6e:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    1e72:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    1e75:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    1e79:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1e7d:	89 54 24 04          	mov    %edx,0x4(%esp)
    1e81:	89 04 24             	mov    %eax,(%esp)
    1e84:	e8 13 02 00 00       	call   209c <initRect>
    1e89:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0, pic->height - W, W, W);
    1e8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8f:	8b 40 08             	mov    0x8(%eax),%eax
    1e92:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1e95:	89 c2                	mov    %eax,%edx
    1e97:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1e9a:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1e9d:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    1ea1:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1ea4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1ea8:	89 54 24 08          	mov    %edx,0x8(%esp)
    1eac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1eb3:	00 
    1eb4:	89 04 24             	mov    %eax,(%esp)
    1eb7:	e8 e0 01 00 00       	call   209c <initRect>
    1ebc:	83 ec 04             	sub    $0x4,%esp
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    1ebf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1ec6:	e9 96 01 00 00       	jmp    2061 <set_icon_alpha+0x27f>
		for (j = 0; j < pic->height; j++) {
    1ecb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1ed2:	e9 77 01 00 00       	jmp    204e <set_icon_alpha+0x26c>
			p = initPoint(i, j);
    1ed7:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1eda:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1edd:	89 54 24 08          	mov    %edx,0x8(%esp)
    1ee1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ee4:	89 54 24 04          	mov    %edx,0x4(%esp)
    1ee8:	89 04 24             	mov    %eax,(%esp)
    1eeb:	e8 85 01 00 00       	call   2075 <initPoint>
    1ef0:	83 ec 04             	sub    $0x4,%esp
			if (isIn(p, r1) || isIn(p, r2) || isIn(p, r3) || isIn(p, r4)) {
    1ef3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ef6:	89 44 24 08          	mov    %eax,0x8(%esp)
    1efa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1efd:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1f01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f04:	89 44 24 10          	mov    %eax,0x10(%esp)
    1f08:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1f0b:	89 44 24 14          	mov    %eax,0x14(%esp)
    1f0f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    1f12:	8b 55 a8             	mov    -0x58(%ebp),%edx
    1f15:	89 04 24             	mov    %eax,(%esp)
    1f18:	89 54 24 04          	mov    %edx,0x4(%esp)
    1f1c:	e8 d6 01 00 00       	call   20f7 <isIn>
    1f21:	85 c0                	test   %eax,%eax
    1f23:	0f 85 9a 00 00 00    	jne    1fc3 <set_icon_alpha+0x1e1>
    1f29:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1f2c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1f30:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1f33:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1f37:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1f3a:	89 44 24 10          	mov    %eax,0x10(%esp)
    1f3e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1f41:	89 44 24 14          	mov    %eax,0x14(%esp)
    1f45:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    1f48:	8b 55 a8             	mov    -0x58(%ebp),%edx
    1f4b:	89 04 24             	mov    %eax,(%esp)
    1f4e:	89 54 24 04          	mov    %edx,0x4(%esp)
    1f52:	e8 a0 01 00 00       	call   20f7 <isIn>
    1f57:	85 c0                	test   %eax,%eax
    1f59:	75 68                	jne    1fc3 <set_icon_alpha+0x1e1>
    1f5b:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1f5e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1f62:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1f65:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1f69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1f6c:	89 44 24 10          	mov    %eax,0x10(%esp)
    1f70:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f73:	89 44 24 14          	mov    %eax,0x14(%esp)
    1f77:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    1f7a:	8b 55 a8             	mov    -0x58(%ebp),%edx
    1f7d:	89 04 24             	mov    %eax,(%esp)
    1f80:	89 54 24 04          	mov    %edx,0x4(%esp)
    1f84:	e8 6e 01 00 00       	call   20f7 <isIn>
    1f89:	85 c0                	test   %eax,%eax
    1f8b:	75 36                	jne    1fc3 <set_icon_alpha+0x1e1>
    1f8d:	8b 45 ac             	mov    -0x54(%ebp),%eax
    1f90:	89 44 24 08          	mov    %eax,0x8(%esp)
    1f94:	8b 45 b0             	mov    -0x50(%ebp),%eax
    1f97:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1f9b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    1f9e:	89 44 24 10          	mov    %eax,0x10(%esp)
    1fa2:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1fa5:	89 44 24 14          	mov    %eax,0x14(%esp)
    1fa9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    1fac:	8b 55 a8             	mov    -0x58(%ebp),%edx
    1faf:	89 04 24             	mov    %eax,(%esp)
    1fb2:	89 54 24 04          	mov    %edx,0x4(%esp)
    1fb6:	e8 3c 01 00 00       	call   20f7 <isIn>
    1fbb:	85 c0                	test   %eax,%eax
    1fbd:	0f 84 87 00 00 00    	je     204a <set_icon_alpha+0x268>
				if (pic->data[j * pic->width + i].rgbBlue == 0xff
    1fc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc6:	8b 10                	mov    (%eax),%edx
    1fc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1fcb:	8b 40 04             	mov    0x4(%eax),%eax
    1fce:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1fd2:	89 c1                	mov    %eax,%ecx
    1fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd7:	01 c8                	add    %ecx,%eax
    1fd9:	c1 e0 02             	shl    $0x2,%eax
    1fdc:	01 d0                	add    %edx,%eax
    1fde:	0f b6 00             	movzbl (%eax),%eax
    1fe1:	3c ff                	cmp    $0xff,%al
    1fe3:	75 65                	jne    204a <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbGreen == 0xff
    1fe5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe8:	8b 10                	mov    (%eax),%edx
    1fea:	8b 45 08             	mov    0x8(%ebp),%eax
    1fed:	8b 40 04             	mov    0x4(%eax),%eax
    1ff0:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1ff4:	89 c1                	mov    %eax,%ecx
    1ff6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ff9:	01 c8                	add    %ecx,%eax
    1ffb:	c1 e0 02             	shl    $0x2,%eax
    1ffe:	01 d0                	add    %edx,%eax
    2000:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    2004:	3c ff                	cmp    $0xff,%al
    2006:	75 42                	jne    204a <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbRed == 0xff) {
    2008:	8b 45 08             	mov    0x8(%ebp),%eax
    200b:	8b 10                	mov    (%eax),%edx
    200d:	8b 45 08             	mov    0x8(%ebp),%eax
    2010:	8b 40 04             	mov    0x4(%eax),%eax
    2013:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    2017:	89 c1                	mov    %eax,%ecx
    2019:	8b 45 f4             	mov    -0xc(%ebp),%eax
    201c:	01 c8                	add    %ecx,%eax
    201e:	c1 e0 02             	shl    $0x2,%eax
    2021:	01 d0                	add    %edx,%eax
    2023:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    2027:	3c ff                	cmp    $0xff,%al
    2029:	75 1f                	jne    204a <set_icon_alpha+0x268>
					pic->data[j * pic->width + i].rgbReserved = 1;
    202b:	8b 45 08             	mov    0x8(%ebp),%eax
    202e:	8b 10                	mov    (%eax),%edx
    2030:	8b 45 08             	mov    0x8(%ebp),%eax
    2033:	8b 40 04             	mov    0x4(%eax),%eax
    2036:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    203a:	89 c1                	mov    %eax,%ecx
    203c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    203f:	01 c8                	add    %ecx,%eax
    2041:	c1 e0 02             	shl    $0x2,%eax
    2044:	01 d0                	add    %edx,%eax
    2046:	c6 40 03 01          	movb   $0x1,0x3(%eax)
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
		for (j = 0; j < pic->height; j++) {
    204a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    204e:	8b 45 08             	mov    0x8(%ebp),%eax
    2051:	8b 40 08             	mov    0x8(%eax),%eax
    2054:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2057:	0f 8f 7a fe ff ff    	jg     1ed7 <set_icon_alpha+0xf5>
	Rect r2 = initRect(pic->width - W, 0, W, W);
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    205d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2061:	8b 45 08             	mov    0x8(%ebp),%eax
    2064:	8b 40 04             	mov    0x4(%eax),%eax
    2067:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    206a:	0f 8f 5b fe ff ff    	jg     1ecb <set_icon_alpha+0xe9>
					pic->data[j * pic->width + i].rgbReserved = 1;
				}
			}
		}
	}
}
    2070:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2073:	c9                   	leave  
    2074:	c3                   	ret    

00002075 <initPoint>:
#include "message.h"
#include "types.h"
#include "user.h"
#include "finder.h"
Point initPoint(int x, int y)
{
    2075:	55                   	push   %ebp
    2076:	89 e5                	mov    %esp,%ebp
    2078:	83 ec 10             	sub    $0x10,%esp
	Point p;
	p.x = x;
    207b:	8b 45 0c             	mov    0xc(%ebp),%eax
    207e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	p.y = y;
    2081:	8b 45 10             	mov    0x10(%ebp),%eax
    2084:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return p;
    2087:	8b 4d 08             	mov    0x8(%ebp),%ecx
    208a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    208d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    2090:	89 01                	mov    %eax,(%ecx)
    2092:	89 51 04             	mov    %edx,0x4(%ecx)
}
    2095:	8b 45 08             	mov    0x8(%ebp),%eax
    2098:	c9                   	leave  
    2099:	c2 04 00             	ret    $0x4

0000209c <initRect>:

Rect initRect(int x, int y, int w, int h)
{
    209c:	55                   	push   %ebp
    209d:	89 e5                	mov    %esp,%ebp
    209f:	83 ec 24             	sub    $0x24,%esp
	Rect r;
	r.start = initPoint(x, y);
    20a2:	8d 45 e8             	lea    -0x18(%ebp),%eax
    20a5:	8b 55 10             	mov    0x10(%ebp),%edx
    20a8:	89 54 24 08          	mov    %edx,0x8(%esp)
    20ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    20af:	89 54 24 04          	mov    %edx,0x4(%esp)
    20b3:	89 04 24             	mov    %eax,(%esp)
    20b6:	e8 ba ff ff ff       	call   2075 <initPoint>
    20bb:	83 ec 04             	sub    $0x4,%esp
    20be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    20c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    20c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20c7:	89 55 f4             	mov    %edx,-0xc(%ebp)
	r.width = w;
    20ca:	8b 45 14             	mov    0x14(%ebp),%eax
    20cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	r.height = h;
    20d0:	8b 45 18             	mov    0x18(%ebp),%eax
    20d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return r;
    20d6:	8b 45 08             	mov    0x8(%ebp),%eax
    20d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    20dc:	89 10                	mov    %edx,(%eax)
    20de:	8b 55 f4             	mov    -0xc(%ebp),%edx
    20e1:	89 50 04             	mov    %edx,0x4(%eax)
    20e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
    20e7:	89 50 08             	mov    %edx,0x8(%eax)
    20ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
    20ed:	89 50 0c             	mov    %edx,0xc(%eax)
}
    20f0:	8b 45 08             	mov    0x8(%ebp),%eax
    20f3:	c9                   	leave  
    20f4:	c2 04 00             	ret    $0x4

000020f7 <isIn>:

int isIn(Point p, Rect r)
{
    20f7:	55                   	push   %ebp
    20f8:	89 e5                	mov    %esp,%ebp
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    20fa:	8b 55 08             	mov    0x8(%ebp),%edx
    20fd:	8b 45 10             	mov    0x10(%ebp),%eax
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    2100:	39 c2                	cmp    %eax,%edx
    2102:	7c 2f                	jl     2133 <isIn+0x3c>
	return r;
}

int isIn(Point p, Rect r)
{
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    2104:	8b 45 08             	mov    0x8(%ebp),%eax
    2107:	8b 4d 10             	mov    0x10(%ebp),%ecx
    210a:	8b 55 18             	mov    0x18(%ebp),%edx
    210d:	01 ca                	add    %ecx,%edx
    210f:	39 d0                	cmp    %edx,%eax
    2111:	7d 20                	jge    2133 <isIn+0x3c>
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    2113:	8b 55 0c             	mov    0xc(%ebp),%edx
    2116:	8b 45 14             	mov    0x14(%ebp),%eax
    2119:	39 c2                	cmp    %eax,%edx
    211b:	7c 16                	jl     2133 <isIn+0x3c>
    211d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2120:	8b 4d 14             	mov    0x14(%ebp),%ecx
    2123:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2126:	01 ca                	add    %ecx,%edx
    2128:	39 d0                	cmp    %edx,%eax
    212a:	7d 07                	jge    2133 <isIn+0x3c>
    212c:	b8 01 00 00 00       	mov    $0x1,%eax
    2131:	eb 05                	jmp    2138 <isIn+0x41>
    2133:	b8 00 00 00 00       	mov    $0x0,%eax
}
    2138:	5d                   	pop    %ebp
    2139:	c3                   	ret    

0000213a <initClickManager>:

ClickableManager initClickManager(struct Context c)
{
    213a:	55                   	push   %ebp
    213b:	89 e5                	mov    %esp,%ebp
    213d:	83 ec 20             	sub    $0x20,%esp
	ClickableManager cm;
	cm.left_click = 0;
    2140:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	cm.double_click = 0;
    2147:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	cm.right_click = 0;
    214e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	cm.wndWidth = c.width;
    2155:	8b 45 10             	mov    0x10(%ebp),%eax
    2158:	89 45 f8             	mov    %eax,-0x8(%ebp)
	cm.wndHeight = c.height;
    215b:	8b 45 14             	mov    0x14(%ebp),%eax
    215e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return cm;
    2161:	8b 45 08             	mov    0x8(%ebp),%eax
    2164:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2167:	89 10                	mov    %edx,(%eax)
    2169:	8b 55 f0             	mov    -0x10(%ebp),%edx
    216c:	89 50 04             	mov    %edx,0x4(%eax)
    216f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2172:	89 50 08             	mov    %edx,0x8(%eax)
    2175:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2178:	89 50 0c             	mov    %edx,0xc(%eax)
    217b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    217e:	89 50 10             	mov    %edx,0x10(%eax)
}
    2181:	8b 45 08             	mov    0x8(%ebp),%eax
    2184:	c9                   	leave  
    2185:	c2 04 00             	ret    $0x4

00002188 <createClickable>:

void createClickable(ClickableManager *c, Rect r, int MsgType, Handler h)
{
    2188:	55                   	push   %ebp
    2189:	89 e5                	mov    %esp,%ebp
    218b:	83 ec 28             	sub    $0x28,%esp
	switch (MsgType)
    218e:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2191:	83 f8 03             	cmp    $0x3,%eax
    2194:	74 72                	je     2208 <createClickable+0x80>
    2196:	83 f8 04             	cmp    $0x4,%eax
    2199:	74 0a                	je     21a5 <createClickable+0x1d>
    219b:	83 f8 02             	cmp    $0x2,%eax
    219e:	74 38                	je     21d8 <createClickable+0x50>
    21a0:	e9 96 00 00 00       	jmp    223b <createClickable+0xb3>
	{
		case MSG_DOUBLECLICK:
			addClickable(&c->double_click, r, h);
    21a5:	8b 45 08             	mov    0x8(%ebp),%eax
    21a8:	8d 50 04             	lea    0x4(%eax),%edx
    21ab:	8b 45 20             	mov    0x20(%ebp),%eax
    21ae:	89 44 24 14          	mov    %eax,0x14(%esp)
    21b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    21b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    21b9:	8b 45 10             	mov    0x10(%ebp),%eax
    21bc:	89 44 24 08          	mov    %eax,0x8(%esp)
    21c0:	8b 45 14             	mov    0x14(%ebp),%eax
    21c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
    21c7:	8b 45 18             	mov    0x18(%ebp),%eax
    21ca:	89 44 24 10          	mov    %eax,0x10(%esp)
    21ce:	89 14 24             	mov    %edx,(%esp)
    21d1:	e8 7c 00 00 00       	call   2252 <addClickable>
	        break;
    21d6:	eb 78                	jmp    2250 <createClickable+0xc8>
	    case MSG_LPRESS:
	    	addClickable(&c->left_click, r, h);
    21d8:	8b 45 08             	mov    0x8(%ebp),%eax
    21db:	8b 55 20             	mov    0x20(%ebp),%edx
    21de:	89 54 24 14          	mov    %edx,0x14(%esp)
    21e2:	8b 55 0c             	mov    0xc(%ebp),%edx
    21e5:	89 54 24 04          	mov    %edx,0x4(%esp)
    21e9:	8b 55 10             	mov    0x10(%ebp),%edx
    21ec:	89 54 24 08          	mov    %edx,0x8(%esp)
    21f0:	8b 55 14             	mov    0x14(%ebp),%edx
    21f3:	89 54 24 0c          	mov    %edx,0xc(%esp)
    21f7:	8b 55 18             	mov    0x18(%ebp),%edx
    21fa:	89 54 24 10          	mov    %edx,0x10(%esp)
    21fe:	89 04 24             	mov    %eax,(%esp)
    2201:	e8 4c 00 00 00       	call   2252 <addClickable>
	    	break;
    2206:	eb 48                	jmp    2250 <createClickable+0xc8>
	    case MSG_RPRESS:
	    	addClickable(&c->right_click, r, h);
    2208:	8b 45 08             	mov    0x8(%ebp),%eax
    220b:	8d 50 08             	lea    0x8(%eax),%edx
    220e:	8b 45 20             	mov    0x20(%ebp),%eax
    2211:	89 44 24 14          	mov    %eax,0x14(%esp)
    2215:	8b 45 0c             	mov    0xc(%ebp),%eax
    2218:	89 44 24 04          	mov    %eax,0x4(%esp)
    221c:	8b 45 10             	mov    0x10(%ebp),%eax
    221f:	89 44 24 08          	mov    %eax,0x8(%esp)
    2223:	8b 45 14             	mov    0x14(%ebp),%eax
    2226:	89 44 24 0c          	mov    %eax,0xc(%esp)
    222a:	8b 45 18             	mov    0x18(%ebp),%eax
    222d:	89 44 24 10          	mov    %eax,0x10(%esp)
    2231:	89 14 24             	mov    %edx,(%esp)
    2234:	e8 19 00 00 00       	call   2252 <addClickable>
	    	break;
    2239:	eb 15                	jmp    2250 <createClickable+0xc8>
	    default:
	    	printf(0, "向clickable传递了非鼠标点击事件！");
    223b:	c7 44 24 04 8c 95 00 	movl   $0x958c,0x4(%esp)
    2242:	00 
    2243:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    224a:	e8 8c 09 00 00       	call   2bdb <printf>
	    	break;
    224f:	90                   	nop
	}
}
    2250:	c9                   	leave  
    2251:	c3                   	ret    

00002252 <addClickable>:

void addClickable(Clickable **head, Rect r, Handler h)
{
    2252:	55                   	push   %ebp
    2253:	89 e5                	mov    %esp,%ebp
    2255:	83 ec 28             	sub    $0x28,%esp
	//printf(0, "adding clickable\n");
	Clickable *c = (Clickable *)malloc(sizeof(Clickable));
    2258:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    225f:	e8 63 0c 00 00       	call   2ec7 <malloc>
    2264:	89 45 f4             	mov    %eax,-0xc(%ebp)
	c->area = r;
    2267:	8b 45 f4             	mov    -0xc(%ebp),%eax
    226a:	8b 55 0c             	mov    0xc(%ebp),%edx
    226d:	89 10                	mov    %edx,(%eax)
    226f:	8b 55 10             	mov    0x10(%ebp),%edx
    2272:	89 50 04             	mov    %edx,0x4(%eax)
    2275:	8b 55 14             	mov    0x14(%ebp),%edx
    2278:	89 50 08             	mov    %edx,0x8(%eax)
    227b:	8b 55 18             	mov    0x18(%ebp),%edx
    227e:	89 50 0c             	mov    %edx,0xc(%eax)
	c->handler = h;
    2281:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2284:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2287:	89 50 10             	mov    %edx,0x10(%eax)
	c->next = *head;
    228a:	8b 45 08             	mov    0x8(%ebp),%eax
    228d:	8b 10                	mov    (%eax),%edx
    228f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2292:	89 50 14             	mov    %edx,0x14(%eax)
	*head = c;
    2295:	8b 45 08             	mov    0x8(%ebp),%eax
    2298:	8b 55 f4             	mov    -0xc(%ebp),%edx
    229b:	89 10                	mov    %edx,(%eax)
}
    229d:	c9                   	leave  
    229e:	c3                   	ret    

0000229f <deleteClickable>:

void deleteClickable(Clickable **head, Rect region)
{
    229f:	55                   	push   %ebp
    22a0:	89 e5                	mov    %esp,%ebp
    22a2:	83 ec 38             	sub    $0x38,%esp
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
    22a5:	8b 45 08             	mov    0x8(%ebp),%eax
    22a8:	8b 00                	mov    (%eax),%eax
    22aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    22b3:	e9 bb 00 00 00       	jmp    2373 <deleteClickable+0xd4>
	{
		if (isIn(cur->area.start, region))
    22b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    22bb:	89 44 24 08          	mov    %eax,0x8(%esp)
    22bf:	8b 45 10             	mov    0x10(%ebp),%eax
    22c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    22c6:	8b 45 14             	mov    0x14(%ebp),%eax
    22c9:	89 44 24 10          	mov    %eax,0x10(%esp)
    22cd:	8b 45 18             	mov    0x18(%ebp),%eax
    22d0:	89 44 24 14          	mov    %eax,0x14(%esp)
    22d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22d7:	8b 50 04             	mov    0x4(%eax),%edx
    22da:	8b 00                	mov    (%eax),%eax
    22dc:	89 04 24             	mov    %eax,(%esp)
    22df:	89 54 24 04          	mov    %edx,0x4(%esp)
    22e3:	e8 0f fe ff ff       	call   20f7 <isIn>
    22e8:	85 c0                	test   %eax,%eax
    22ea:	74 60                	je     234c <deleteClickable+0xad>
		{
			//如果当前指针指向头部
			if (cur == *head)
    22ec:	8b 45 08             	mov    0x8(%ebp),%eax
    22ef:	8b 00                	mov    (%eax),%eax
    22f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    22f4:	75 2e                	jne    2324 <deleteClickable+0x85>
			{
				//删除头节点
				temp = *head;
    22f6:	8b 45 08             	mov    0x8(%ebp),%eax
    22f9:	8b 00                	mov    (%eax),%eax
    22fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
				*head = cur->next;
    22fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2301:	8b 50 14             	mov    0x14(%eax),%edx
    2304:	8b 45 08             	mov    0x8(%ebp),%eax
    2307:	89 10                	mov    %edx,(%eax)
				cur = prev = *head;
    2309:	8b 45 08             	mov    0x8(%ebp),%eax
    230c:	8b 00                	mov    (%eax),%eax
    230e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2311:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2314:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    2317:	8b 45 ec             	mov    -0x14(%ebp),%eax
    231a:	89 04 24             	mov    %eax,(%esp)
    231d:	e8 6c 0a 00 00       	call   2d8e <free>
    2322:	eb 4f                	jmp    2373 <deleteClickable+0xd4>
			}
			else
			{
				//删除当前节点
				prev->next = cur->next;
    2324:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2327:	8b 50 14             	mov    0x14(%eax),%edx
    232a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    232d:	89 50 14             	mov    %edx,0x14(%eax)
				temp = cur;
    2330:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2333:	89 45 ec             	mov    %eax,-0x14(%ebp)
				cur = cur->next;
    2336:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2339:	8b 40 14             	mov    0x14(%eax),%eax
    233c:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    233f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2342:	89 04 24             	mov    %eax,(%esp)
    2345:	e8 44 0a 00 00       	call   2d8e <free>
    234a:	eb 27                	jmp    2373 <deleteClickable+0xd4>
			}
		}
		else
		{
			//如果当前节点是头节点，
			if (cur == *head)
    234c:	8b 45 08             	mov    0x8(%ebp),%eax
    234f:	8b 00                	mov    (%eax),%eax
    2351:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2354:	75 0b                	jne    2361 <deleteClickable+0xc2>
			{
				cur = cur->next;
    2356:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2359:	8b 40 14             	mov    0x14(%eax),%eax
    235c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    235f:	eb 12                	jmp    2373 <deleteClickable+0xd4>
			}
			else
			{
				cur = cur->next;
    2361:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2364:	8b 40 14             	mov    0x14(%eax),%eax
    2367:	89 45 f0             	mov    %eax,-0x10(%ebp)
				prev = prev->next;
    236a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    236d:	8b 40 14             	mov    0x14(%eax),%eax
    2370:	89 45 f4             	mov    %eax,-0xc(%ebp)

void deleteClickable(Clickable **head, Rect region)
{
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
	while (cur != 0)
    2373:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2377:	0f 85 3b ff ff ff    	jne    22b8 <deleteClickable+0x19>
				cur = cur->next;
				prev = prev->next;
			}
		}
	}
}
    237d:	c9                   	leave  
    237e:	c3                   	ret    

0000237f <executeHandler>:

int executeHandler(Clickable *head, Point click)
{
    237f:	55                   	push   %ebp
    2380:	89 e5                	mov    %esp,%ebp
    2382:	83 ec 38             	sub    $0x38,%esp
	Clickable *cur = head;
    2385:	8b 45 08             	mov    0x8(%ebp),%eax
    2388:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    238b:	eb 6d                	jmp    23fa <executeHandler+0x7b>
	{
		if (isIn(click, cur->area))
    238d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2390:	8b 10                	mov    (%eax),%edx
    2392:	89 54 24 08          	mov    %edx,0x8(%esp)
    2396:	8b 50 04             	mov    0x4(%eax),%edx
    2399:	89 54 24 0c          	mov    %edx,0xc(%esp)
    239d:	8b 50 08             	mov    0x8(%eax),%edx
    23a0:	89 54 24 10          	mov    %edx,0x10(%esp)
    23a4:	8b 40 0c             	mov    0xc(%eax),%eax
    23a7:	89 44 24 14          	mov    %eax,0x14(%esp)
    23ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    23ae:	8b 55 10             	mov    0x10(%ebp),%edx
    23b1:	89 04 24             	mov    %eax,(%esp)
    23b4:	89 54 24 04          	mov    %edx,0x4(%esp)
    23b8:	e8 3a fd ff ff       	call   20f7 <isIn>
    23bd:	85 c0                	test   %eax,%eax
    23bf:	74 30                	je     23f1 <executeHandler+0x72>
		{
			renaming = 0;
    23c1:	c7 05 c4 01 01 00 00 	movl   $0x0,0x101c4
    23c8:	00 00 00 
			isSearching = 0;
    23cb:	c7 05 c0 01 01 00 00 	movl   $0x0,0x101c0
    23d2:	00 00 00 
			cur->handler(click);
    23d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23d8:	8b 48 10             	mov    0x10(%eax),%ecx
    23db:	8b 45 0c             	mov    0xc(%ebp),%eax
    23de:	8b 55 10             	mov    0x10(%ebp),%edx
    23e1:	89 04 24             	mov    %eax,(%esp)
    23e4:	89 54 24 04          	mov    %edx,0x4(%esp)
    23e8:	ff d1                	call   *%ecx
			return 1;
    23ea:	b8 01 00 00 00       	mov    $0x1,%eax
    23ef:	eb 4d                	jmp    243e <executeHandler+0xbf>
		}
		cur = cur->next;
    23f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23f4:	8b 40 14             	mov    0x14(%eax),%eax
    23f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
}

int executeHandler(Clickable *head, Point click)
{
	Clickable *cur = head;
	while (cur != 0)
    23fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23fe:	75 8d                	jne    238d <executeHandler+0xe>
			cur->handler(click);
			return 1;
		}
		cur = cur->next;
	}
	isSearching = 0;
    2400:	c7 05 c0 01 01 00 00 	movl   $0x0,0x101c0
    2407:	00 00 00 
	if (renaming == 1){
    240a:	a1 c4 01 01 00       	mov    0x101c4,%eax
    240f:	83 f8 01             	cmp    $0x1,%eax
    2412:	75 11                	jne    2425 <executeHandler+0xa6>
		renaming = 0;
    2414:	c7 05 c4 01 01 00 00 	movl   $0x0,0x101c4
    241b:	00 00 00 
		return 1;
    241e:	b8 01 00 00 00       	mov    $0x1,%eax
    2423:	eb 19                	jmp    243e <executeHandler+0xbf>
	}
	printf(0, "execute: none!\n");
    2425:	c7 44 24 04 ba 95 00 	movl   $0x95ba,0x4(%esp)
    242c:	00 
    242d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2434:	e8 a2 07 00 00       	call   2bdb <printf>
	return 0;
    2439:	b8 00 00 00 00       	mov    $0x0,%eax
}
    243e:	c9                   	leave  
    243f:	c3                   	ret    

00002440 <printClickable>:

void printClickable(Clickable *c)
{
    2440:	55                   	push   %ebp
    2441:	89 e5                	mov    %esp,%ebp
    2443:	53                   	push   %ebx
    2444:	83 ec 24             	sub    $0x24,%esp
	printf(0, "(%d, %d, %d, %d)\n", c->area.start.x, c->area.start.y, c->area.width, c->area.height);
    2447:	8b 45 08             	mov    0x8(%ebp),%eax
    244a:	8b 58 0c             	mov    0xc(%eax),%ebx
    244d:	8b 45 08             	mov    0x8(%ebp),%eax
    2450:	8b 48 08             	mov    0x8(%eax),%ecx
    2453:	8b 45 08             	mov    0x8(%ebp),%eax
    2456:	8b 50 04             	mov    0x4(%eax),%edx
    2459:	8b 45 08             	mov    0x8(%ebp),%eax
    245c:	8b 00                	mov    (%eax),%eax
    245e:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    2462:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    2466:	89 54 24 0c          	mov    %edx,0xc(%esp)
    246a:	89 44 24 08          	mov    %eax,0x8(%esp)
    246e:	c7 44 24 04 ca 95 00 	movl   $0x95ca,0x4(%esp)
    2475:	00 
    2476:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    247d:	e8 59 07 00 00       	call   2bdb <printf>
}
    2482:	83 c4 24             	add    $0x24,%esp
    2485:	5b                   	pop    %ebx
    2486:	5d                   	pop    %ebp
    2487:	c3                   	ret    

00002488 <printClickableList>:

void printClickableList(Clickable *head)
{
    2488:	55                   	push   %ebp
    2489:	89 e5                	mov    %esp,%ebp
    248b:	83 ec 28             	sub    $0x28,%esp
	Clickable *cur = head;
    248e:	8b 45 08             	mov    0x8(%ebp),%eax
    2491:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(0, "Clickable List:\n");
    2494:	c7 44 24 04 dc 95 00 	movl   $0x95dc,0x4(%esp)
    249b:	00 
    249c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24a3:	e8 33 07 00 00       	call   2bdb <printf>
	while(cur != 0)
    24a8:	eb 14                	jmp    24be <printClickableList+0x36>
	{
		printClickable(cur);
    24aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24ad:	89 04 24             	mov    %eax,(%esp)
    24b0:	e8 8b ff ff ff       	call   2440 <printClickable>
		cur = cur->next;
    24b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24b8:	8b 40 14             	mov    0x14(%eax),%eax
    24bb:	89 45 f4             	mov    %eax,-0xc(%ebp)

void printClickableList(Clickable *head)
{
	Clickable *cur = head;
	printf(0, "Clickable List:\n");
	while(cur != 0)
    24be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24c2:	75 e6                	jne    24aa <printClickableList+0x22>
	{
		printClickable(cur);
		cur = cur->next;
	}
	printf(0, "\n");
    24c4:	c7 44 24 04 ed 95 00 	movl   $0x95ed,0x4(%esp)
    24cb:	00 
    24cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24d3:	e8 03 07 00 00       	call   2bdb <printf>
}
    24d8:	c9                   	leave  
    24d9:	c3                   	ret    

000024da <testHanler>:

void testHanler(struct Point p)
{
    24da:	55                   	push   %ebp
    24db:	89 e5                	mov    %esp,%ebp
    24dd:	83 ec 18             	sub    $0x18,%esp
	printf(0, "execute: (%d, %d)!\n", p.x, p.y);
    24e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    24e3:	8b 45 08             	mov    0x8(%ebp),%eax
    24e6:	89 54 24 0c          	mov    %edx,0xc(%esp)
    24ea:	89 44 24 08          	mov    %eax,0x8(%esp)
    24ee:	c7 44 24 04 ef 95 00 	movl   $0x95ef,0x4(%esp)
    24f5:	00 
    24f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24fd:	e8 d9 06 00 00       	call   2bdb <printf>
}
    2502:	c9                   	leave  
    2503:	c3                   	ret    

00002504 <testClickable>:
void testClickable(struct Context c)
{
    2504:	55                   	push   %ebp
    2505:	89 e5                	mov    %esp,%ebp
    2507:	81 ec 98 00 00 00    	sub    $0x98,%esp
	ClickableManager cm = initClickManager(c);
    250d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    2510:	8b 55 08             	mov    0x8(%ebp),%edx
    2513:	89 54 24 04          	mov    %edx,0x4(%esp)
    2517:	8b 55 0c             	mov    0xc(%ebp),%edx
    251a:	89 54 24 08          	mov    %edx,0x8(%esp)
    251e:	8b 55 10             	mov    0x10(%ebp),%edx
    2521:	89 54 24 0c          	mov    %edx,0xc(%esp)
    2525:	89 04 24             	mov    %eax,(%esp)
    2528:	e8 0d fc ff ff       	call   213a <initClickManager>
    252d:	83 ec 04             	sub    $0x4,%esp

	Rect r1 = initRect(5,5,20,20);
    2530:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    2533:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    253a:	00 
    253b:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    2542:	00 
    2543:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    254a:	00 
    254b:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    2552:	00 
    2553:	89 04 24             	mov    %eax,(%esp)
    2556:	e8 41 fb ff ff       	call   209c <initRect>
    255b:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(20,20,20,20);
    255e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    2561:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    2568:	00 
    2569:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    2570:	00 
    2571:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
    2578:	00 
    2579:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
    2580:	00 
    2581:	89 04 24             	mov    %eax,(%esp)
    2584:	e8 13 fb ff ff       	call   209c <initRect>
    2589:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(50,50,15,15);
    258c:	8d 45 b4             	lea    -0x4c(%ebp),%eax
    258f:	c7 44 24 10 0f 00 00 	movl   $0xf,0x10(%esp)
    2596:	00 
    2597:	c7 44 24 0c 0f 00 00 	movl   $0xf,0xc(%esp)
    259e:	00 
    259f:	c7 44 24 08 32 00 00 	movl   $0x32,0x8(%esp)
    25a6:	00 
    25a7:	c7 44 24 04 32 00 00 	movl   $0x32,0x4(%esp)
    25ae:	00 
    25af:	89 04 24             	mov    %eax,(%esp)
    25b2:	e8 e5 fa ff ff       	call   209c <initRect>
    25b7:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0,0,30,30);
    25ba:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    25bd:	c7 44 24 10 1e 00 00 	movl   $0x1e,0x10(%esp)
    25c4:	00 
    25c5:	c7 44 24 0c 1e 00 00 	movl   $0x1e,0xc(%esp)
    25cc:	00 
    25cd:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    25d4:	00 
    25d5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    25dc:	00 
    25dd:	89 04 24             	mov    %eax,(%esp)
    25e0:	e8 b7 fa ff ff       	call   209c <initRect>
    25e5:	83 ec 04             	sub    $0x4,%esp
	Point p1 = initPoint(23, 23);
    25e8:	8d 45 9c             	lea    -0x64(%ebp),%eax
    25eb:	c7 44 24 08 17 00 00 	movl   $0x17,0x8(%esp)
    25f2:	00 
    25f3:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
    25fa:	00 
    25fb:	89 04 24             	mov    %eax,(%esp)
    25fe:	e8 72 fa ff ff       	call   2075 <initPoint>
    2603:	83 ec 04             	sub    $0x4,%esp
	Point p2 = initPoint(70, 70);
    2606:	8d 45 94             	lea    -0x6c(%ebp),%eax
    2609:	c7 44 24 08 46 00 00 	movl   $0x46,0x8(%esp)
    2610:	00 
    2611:	c7 44 24 04 46 00 00 	movl   $0x46,0x4(%esp)
    2618:	00 
    2619:	89 04 24             	mov    %eax,(%esp)
    261c:	e8 54 fa ff ff       	call   2075 <initPoint>
    2621:	83 ec 04             	sub    $0x4,%esp
	createClickable(&cm, r1, MSG_LPRESS, &testHanler);
    2624:	c7 44 24 18 da 24 00 	movl   $0x24da,0x18(%esp)
    262b:	00 
    262c:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    2633:	00 
    2634:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2637:	89 44 24 04          	mov    %eax,0x4(%esp)
    263b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    263e:	89 44 24 08          	mov    %eax,0x8(%esp)
    2642:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2645:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2649:	8b 45 e0             	mov    -0x20(%ebp),%eax
    264c:	89 44 24 10          	mov    %eax,0x10(%esp)
    2650:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    2653:	89 04 24             	mov    %eax,(%esp)
    2656:	e8 2d fb ff ff       	call   2188 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    265b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    265e:	89 44 24 08          	mov    %eax,0x8(%esp)
    2662:	c7 44 24 04 03 96 00 	movl   $0x9603,0x4(%esp)
    2669:	00 
    266a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2671:	e8 65 05 00 00       	call   2bdb <printf>
	createClickable(&cm, r2, MSG_LPRESS, &testHanler);
    2676:	c7 44 24 18 da 24 00 	movl   $0x24da,0x18(%esp)
    267d:	00 
    267e:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    2685:	00 
    2686:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    2689:	89 44 24 04          	mov    %eax,0x4(%esp)
    268d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2690:	89 44 24 08          	mov    %eax,0x8(%esp)
    2694:	8b 45 cc             	mov    -0x34(%ebp),%eax
    2697:	89 44 24 0c          	mov    %eax,0xc(%esp)
    269b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    269e:	89 44 24 10          	mov    %eax,0x10(%esp)
    26a2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    26a5:	89 04 24             	mov    %eax,(%esp)
    26a8:	e8 db fa ff ff       	call   2188 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    26ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26b0:	89 44 24 08          	mov    %eax,0x8(%esp)
    26b4:	c7 44 24 04 03 96 00 	movl   $0x9603,0x4(%esp)
    26bb:	00 
    26bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26c3:	e8 13 05 00 00       	call   2bdb <printf>
	createClickable(&cm, r3, MSG_LPRESS, &testHanler);
    26c8:	c7 44 24 18 da 24 00 	movl   $0x24da,0x18(%esp)
    26cf:	00 
    26d0:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    26d7:	00 
    26d8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    26db:	89 44 24 04          	mov    %eax,0x4(%esp)
    26df:	8b 45 b8             	mov    -0x48(%ebp),%eax
    26e2:	89 44 24 08          	mov    %eax,0x8(%esp)
    26e6:	8b 45 bc             	mov    -0x44(%ebp),%eax
    26e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
    26ed:	8b 45 c0             	mov    -0x40(%ebp),%eax
    26f0:	89 44 24 10          	mov    %eax,0x10(%esp)
    26f4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    26f7:	89 04 24             	mov    %eax,(%esp)
    26fa:	e8 89 fa ff ff       	call   2188 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    26ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2702:	89 44 24 08          	mov    %eax,0x8(%esp)
    2706:	c7 44 24 04 03 96 00 	movl   $0x9603,0x4(%esp)
    270d:	00 
    270e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2715:	e8 c1 04 00 00       	call   2bdb <printf>
	printClickableList(cm.left_click);
    271a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    271d:	89 04 24             	mov    %eax,(%esp)
    2720:	e8 63 fd ff ff       	call   2488 <printClickableList>
	executeHandler(cm.left_click, p1);
    2725:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    2728:	8b 45 9c             	mov    -0x64(%ebp),%eax
    272b:	8b 55 a0             	mov    -0x60(%ebp),%edx
    272e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2732:	89 54 24 08          	mov    %edx,0x8(%esp)
    2736:	89 0c 24             	mov    %ecx,(%esp)
    2739:	e8 41 fc ff ff       	call   237f <executeHandler>
	executeHandler(cm.left_click, p2);
    273e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    2741:	8b 45 94             	mov    -0x6c(%ebp),%eax
    2744:	8b 55 98             	mov    -0x68(%ebp),%edx
    2747:	89 44 24 04          	mov    %eax,0x4(%esp)
    274b:	89 54 24 08          	mov    %edx,0x8(%esp)
    274f:	89 0c 24             	mov    %ecx,(%esp)
    2752:	e8 28 fc ff ff       	call   237f <executeHandler>
	deleteClickable(&cm.left_click, r4);
    2757:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    275a:	89 44 24 04          	mov    %eax,0x4(%esp)
    275e:	8b 45 a8             	mov    -0x58(%ebp),%eax
    2761:	89 44 24 08          	mov    %eax,0x8(%esp)
    2765:	8b 45 ac             	mov    -0x54(%ebp),%eax
    2768:	89 44 24 0c          	mov    %eax,0xc(%esp)
    276c:	8b 45 b0             	mov    -0x50(%ebp),%eax
    276f:	89 44 24 10          	mov    %eax,0x10(%esp)
    2773:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    2776:	89 04 24             	mov    %eax,(%esp)
    2779:	e8 21 fb ff ff       	call   229f <deleteClickable>
	printClickableList(cm.left_click);
    277e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2781:	89 04 24             	mov    %eax,(%esp)
    2784:	e8 ff fc ff ff       	call   2488 <printClickableList>
}
    2789:	c9                   	leave  
    278a:	c3                   	ret    

0000278b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    278b:	55                   	push   %ebp
    278c:	89 e5                	mov    %esp,%ebp
    278e:	57                   	push   %edi
    278f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    2790:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2793:	8b 55 10             	mov    0x10(%ebp),%edx
    2796:	8b 45 0c             	mov    0xc(%ebp),%eax
    2799:	89 cb                	mov    %ecx,%ebx
    279b:	89 df                	mov    %ebx,%edi
    279d:	89 d1                	mov    %edx,%ecx
    279f:	fc                   	cld    
    27a0:	f3 aa                	rep stos %al,%es:(%edi)
    27a2:	89 ca                	mov    %ecx,%edx
    27a4:	89 fb                	mov    %edi,%ebx
    27a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
    27a9:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    27ac:	5b                   	pop    %ebx
    27ad:	5f                   	pop    %edi
    27ae:	5d                   	pop    %ebp
    27af:	c3                   	ret    

000027b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    27b0:	55                   	push   %ebp
    27b1:	89 e5                	mov    %esp,%ebp
    27b3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    27b6:	8b 45 08             	mov    0x8(%ebp),%eax
    27b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    27bc:	90                   	nop
    27bd:	8b 45 08             	mov    0x8(%ebp),%eax
    27c0:	8d 50 01             	lea    0x1(%eax),%edx
    27c3:	89 55 08             	mov    %edx,0x8(%ebp)
    27c6:	8b 55 0c             	mov    0xc(%ebp),%edx
    27c9:	8d 4a 01             	lea    0x1(%edx),%ecx
    27cc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    27cf:	0f b6 12             	movzbl (%edx),%edx
    27d2:	88 10                	mov    %dl,(%eax)
    27d4:	0f b6 00             	movzbl (%eax),%eax
    27d7:	84 c0                	test   %al,%al
    27d9:	75 e2                	jne    27bd <strcpy+0xd>
    ;
  return os;
    27db:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    27de:	c9                   	leave  
    27df:	c3                   	ret    

000027e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    27e0:	55                   	push   %ebp
    27e1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    27e3:	eb 08                	jmp    27ed <strcmp+0xd>
    p++, q++;
    27e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    27e9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    27ed:	8b 45 08             	mov    0x8(%ebp),%eax
    27f0:	0f b6 00             	movzbl (%eax),%eax
    27f3:	84 c0                	test   %al,%al
    27f5:	74 10                	je     2807 <strcmp+0x27>
    27f7:	8b 45 08             	mov    0x8(%ebp),%eax
    27fa:	0f b6 10             	movzbl (%eax),%edx
    27fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    2800:	0f b6 00             	movzbl (%eax),%eax
    2803:	38 c2                	cmp    %al,%dl
    2805:	74 de                	je     27e5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    2807:	8b 45 08             	mov    0x8(%ebp),%eax
    280a:	0f b6 00             	movzbl (%eax),%eax
    280d:	0f b6 d0             	movzbl %al,%edx
    2810:	8b 45 0c             	mov    0xc(%ebp),%eax
    2813:	0f b6 00             	movzbl (%eax),%eax
    2816:	0f b6 c0             	movzbl %al,%eax
    2819:	29 c2                	sub    %eax,%edx
    281b:	89 d0                	mov    %edx,%eax
}
    281d:	5d                   	pop    %ebp
    281e:	c3                   	ret    

0000281f <strlen>:

uint
strlen(char *s)
{
    281f:	55                   	push   %ebp
    2820:	89 e5                	mov    %esp,%ebp
    2822:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    2825:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    282c:	eb 04                	jmp    2832 <strlen+0x13>
    282e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    2832:	8b 55 fc             	mov    -0x4(%ebp),%edx
    2835:	8b 45 08             	mov    0x8(%ebp),%eax
    2838:	01 d0                	add    %edx,%eax
    283a:	0f b6 00             	movzbl (%eax),%eax
    283d:	84 c0                	test   %al,%al
    283f:	75 ed                	jne    282e <strlen+0xf>
    ;
  return n;
    2841:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    2844:	c9                   	leave  
    2845:	c3                   	ret    

00002846 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2846:	55                   	push   %ebp
    2847:	89 e5                	mov    %esp,%ebp
    2849:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    284c:	8b 45 10             	mov    0x10(%ebp),%eax
    284f:	89 44 24 08          	mov    %eax,0x8(%esp)
    2853:	8b 45 0c             	mov    0xc(%ebp),%eax
    2856:	89 44 24 04          	mov    %eax,0x4(%esp)
    285a:	8b 45 08             	mov    0x8(%ebp),%eax
    285d:	89 04 24             	mov    %eax,(%esp)
    2860:	e8 26 ff ff ff       	call   278b <stosb>
  return dst;
    2865:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2868:	c9                   	leave  
    2869:	c3                   	ret    

0000286a <strchr>:

char*
strchr(const char *s, char c)
{
    286a:	55                   	push   %ebp
    286b:	89 e5                	mov    %esp,%ebp
    286d:	83 ec 04             	sub    $0x4,%esp
    2870:	8b 45 0c             	mov    0xc(%ebp),%eax
    2873:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    2876:	eb 14                	jmp    288c <strchr+0x22>
    if(*s == c)
    2878:	8b 45 08             	mov    0x8(%ebp),%eax
    287b:	0f b6 00             	movzbl (%eax),%eax
    287e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    2881:	75 05                	jne    2888 <strchr+0x1e>
      return (char*)s;
    2883:	8b 45 08             	mov    0x8(%ebp),%eax
    2886:	eb 13                	jmp    289b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    2888:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    288c:	8b 45 08             	mov    0x8(%ebp),%eax
    288f:	0f b6 00             	movzbl (%eax),%eax
    2892:	84 c0                	test   %al,%al
    2894:	75 e2                	jne    2878 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    2896:	b8 00 00 00 00       	mov    $0x0,%eax
}
    289b:	c9                   	leave  
    289c:	c3                   	ret    

0000289d <gets>:

char*
gets(char *buf, int max)
{
    289d:	55                   	push   %ebp
    289e:	89 e5                	mov    %esp,%ebp
    28a0:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    28a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    28aa:	eb 4c                	jmp    28f8 <gets+0x5b>
    cc = read(0, &c, 1);
    28ac:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    28b3:	00 
    28b4:	8d 45 ef             	lea    -0x11(%ebp),%eax
    28b7:	89 44 24 04          	mov    %eax,0x4(%esp)
    28bb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28c2:	e8 44 01 00 00       	call   2a0b <read>
    28c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    28ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    28ce:	7f 02                	jg     28d2 <gets+0x35>
      break;
    28d0:	eb 31                	jmp    2903 <gets+0x66>
    buf[i++] = c;
    28d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28d5:	8d 50 01             	lea    0x1(%eax),%edx
    28d8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    28db:	89 c2                	mov    %eax,%edx
    28dd:	8b 45 08             	mov    0x8(%ebp),%eax
    28e0:	01 c2                	add    %eax,%edx
    28e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    28e6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    28e8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    28ec:	3c 0a                	cmp    $0xa,%al
    28ee:	74 13                	je     2903 <gets+0x66>
    28f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    28f4:	3c 0d                	cmp    $0xd,%al
    28f6:	74 0b                	je     2903 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    28f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28fb:	83 c0 01             	add    $0x1,%eax
    28fe:	3b 45 0c             	cmp    0xc(%ebp),%eax
    2901:	7c a9                	jl     28ac <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    2903:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2906:	8b 45 08             	mov    0x8(%ebp),%eax
    2909:	01 d0                	add    %edx,%eax
    290b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    290e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2911:	c9                   	leave  
    2912:	c3                   	ret    

00002913 <stat>:

int
stat(char *n, struct stat *st)
{
    2913:	55                   	push   %ebp
    2914:	89 e5                	mov    %esp,%ebp
    2916:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2919:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2920:	00 
    2921:	8b 45 08             	mov    0x8(%ebp),%eax
    2924:	89 04 24             	mov    %eax,(%esp)
    2927:	e8 07 01 00 00       	call   2a33 <open>
    292c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    292f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2933:	79 07                	jns    293c <stat+0x29>
    return -1;
    2935:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    293a:	eb 23                	jmp    295f <stat+0x4c>
  r = fstat(fd, st);
    293c:	8b 45 0c             	mov    0xc(%ebp),%eax
    293f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2943:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2946:	89 04 24             	mov    %eax,(%esp)
    2949:	e8 fd 00 00 00       	call   2a4b <fstat>
    294e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    2951:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2954:	89 04 24             	mov    %eax,(%esp)
    2957:	e8 bf 00 00 00       	call   2a1b <close>
  return r;
    295c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    295f:	c9                   	leave  
    2960:	c3                   	ret    

00002961 <atoi>:

int
atoi(const char *s)
{
    2961:	55                   	push   %ebp
    2962:	89 e5                	mov    %esp,%ebp
    2964:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    2967:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    296e:	eb 25                	jmp    2995 <atoi+0x34>
    n = n*10 + *s++ - '0';
    2970:	8b 55 fc             	mov    -0x4(%ebp),%edx
    2973:	89 d0                	mov    %edx,%eax
    2975:	c1 e0 02             	shl    $0x2,%eax
    2978:	01 d0                	add    %edx,%eax
    297a:	01 c0                	add    %eax,%eax
    297c:	89 c1                	mov    %eax,%ecx
    297e:	8b 45 08             	mov    0x8(%ebp),%eax
    2981:	8d 50 01             	lea    0x1(%eax),%edx
    2984:	89 55 08             	mov    %edx,0x8(%ebp)
    2987:	0f b6 00             	movzbl (%eax),%eax
    298a:	0f be c0             	movsbl %al,%eax
    298d:	01 c8                	add    %ecx,%eax
    298f:	83 e8 30             	sub    $0x30,%eax
    2992:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2995:	8b 45 08             	mov    0x8(%ebp),%eax
    2998:	0f b6 00             	movzbl (%eax),%eax
    299b:	3c 2f                	cmp    $0x2f,%al
    299d:	7e 0a                	jle    29a9 <atoi+0x48>
    299f:	8b 45 08             	mov    0x8(%ebp),%eax
    29a2:	0f b6 00             	movzbl (%eax),%eax
    29a5:	3c 39                	cmp    $0x39,%al
    29a7:	7e c7                	jle    2970 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    29a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    29ac:	c9                   	leave  
    29ad:	c3                   	ret    

000029ae <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    29ae:	55                   	push   %ebp
    29af:	89 e5                	mov    %esp,%ebp
    29b1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    29b4:	8b 45 08             	mov    0x8(%ebp),%eax
    29b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    29ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    29bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    29c0:	eb 17                	jmp    29d9 <memmove+0x2b>
    *dst++ = *src++;
    29c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    29c5:	8d 50 01             	lea    0x1(%eax),%edx
    29c8:	89 55 fc             	mov    %edx,-0x4(%ebp)
    29cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    29ce:	8d 4a 01             	lea    0x1(%edx),%ecx
    29d1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    29d4:	0f b6 12             	movzbl (%edx),%edx
    29d7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    29d9:	8b 45 10             	mov    0x10(%ebp),%eax
    29dc:	8d 50 ff             	lea    -0x1(%eax),%edx
    29df:	89 55 10             	mov    %edx,0x10(%ebp)
    29e2:	85 c0                	test   %eax,%eax
    29e4:	7f dc                	jg     29c2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    29e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    29e9:	c9                   	leave  
    29ea:	c3                   	ret    

000029eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    29eb:	b8 01 00 00 00       	mov    $0x1,%eax
    29f0:	cd 40                	int    $0x40
    29f2:	c3                   	ret    

000029f3 <exit>:
SYSCALL(exit)
    29f3:	b8 02 00 00 00       	mov    $0x2,%eax
    29f8:	cd 40                	int    $0x40
    29fa:	c3                   	ret    

000029fb <wait>:
SYSCALL(wait)
    29fb:	b8 03 00 00 00       	mov    $0x3,%eax
    2a00:	cd 40                	int    $0x40
    2a02:	c3                   	ret    

00002a03 <pipe>:
SYSCALL(pipe)
    2a03:	b8 04 00 00 00       	mov    $0x4,%eax
    2a08:	cd 40                	int    $0x40
    2a0a:	c3                   	ret    

00002a0b <read>:
SYSCALL(read)
    2a0b:	b8 05 00 00 00       	mov    $0x5,%eax
    2a10:	cd 40                	int    $0x40
    2a12:	c3                   	ret    

00002a13 <write>:
SYSCALL(write)
    2a13:	b8 10 00 00 00       	mov    $0x10,%eax
    2a18:	cd 40                	int    $0x40
    2a1a:	c3                   	ret    

00002a1b <close>:
SYSCALL(close)
    2a1b:	b8 15 00 00 00       	mov    $0x15,%eax
    2a20:	cd 40                	int    $0x40
    2a22:	c3                   	ret    

00002a23 <kill>:
SYSCALL(kill)
    2a23:	b8 06 00 00 00       	mov    $0x6,%eax
    2a28:	cd 40                	int    $0x40
    2a2a:	c3                   	ret    

00002a2b <exec>:
SYSCALL(exec)
    2a2b:	b8 07 00 00 00       	mov    $0x7,%eax
    2a30:	cd 40                	int    $0x40
    2a32:	c3                   	ret    

00002a33 <open>:
SYSCALL(open)
    2a33:	b8 0f 00 00 00       	mov    $0xf,%eax
    2a38:	cd 40                	int    $0x40
    2a3a:	c3                   	ret    

00002a3b <mknod>:
SYSCALL(mknod)
    2a3b:	b8 11 00 00 00       	mov    $0x11,%eax
    2a40:	cd 40                	int    $0x40
    2a42:	c3                   	ret    

00002a43 <unlink>:
SYSCALL(unlink)
    2a43:	b8 12 00 00 00       	mov    $0x12,%eax
    2a48:	cd 40                	int    $0x40
    2a4a:	c3                   	ret    

00002a4b <fstat>:
SYSCALL(fstat)
    2a4b:	b8 08 00 00 00       	mov    $0x8,%eax
    2a50:	cd 40                	int    $0x40
    2a52:	c3                   	ret    

00002a53 <link>:
SYSCALL(link)
    2a53:	b8 13 00 00 00       	mov    $0x13,%eax
    2a58:	cd 40                	int    $0x40
    2a5a:	c3                   	ret    

00002a5b <mkdir>:
SYSCALL(mkdir)
    2a5b:	b8 14 00 00 00       	mov    $0x14,%eax
    2a60:	cd 40                	int    $0x40
    2a62:	c3                   	ret    

00002a63 <chdir>:
SYSCALL(chdir)
    2a63:	b8 09 00 00 00       	mov    $0x9,%eax
    2a68:	cd 40                	int    $0x40
    2a6a:	c3                   	ret    

00002a6b <dup>:
SYSCALL(dup)
    2a6b:	b8 0a 00 00 00       	mov    $0xa,%eax
    2a70:	cd 40                	int    $0x40
    2a72:	c3                   	ret    

00002a73 <getpid>:
SYSCALL(getpid)
    2a73:	b8 0b 00 00 00       	mov    $0xb,%eax
    2a78:	cd 40                	int    $0x40
    2a7a:	c3                   	ret    

00002a7b <sbrk>:
SYSCALL(sbrk)
    2a7b:	b8 0c 00 00 00       	mov    $0xc,%eax
    2a80:	cd 40                	int    $0x40
    2a82:	c3                   	ret    

00002a83 <sleep>:
SYSCALL(sleep)
    2a83:	b8 0d 00 00 00       	mov    $0xd,%eax
    2a88:	cd 40                	int    $0x40
    2a8a:	c3                   	ret    

00002a8b <uptime>:
SYSCALL(uptime)
    2a8b:	b8 0e 00 00 00       	mov    $0xe,%eax
    2a90:	cd 40                	int    $0x40
    2a92:	c3                   	ret    

00002a93 <getMsg>:
SYSCALL(getMsg)
    2a93:	b8 16 00 00 00       	mov    $0x16,%eax
    2a98:	cd 40                	int    $0x40
    2a9a:	c3                   	ret    

00002a9b <createWindow>:
SYSCALL(createWindow)
    2a9b:	b8 17 00 00 00       	mov    $0x17,%eax
    2aa0:	cd 40                	int    $0x40
    2aa2:	c3                   	ret    

00002aa3 <destroyWindow>:
SYSCALL(destroyWindow)
    2aa3:	b8 18 00 00 00       	mov    $0x18,%eax
    2aa8:	cd 40                	int    $0x40
    2aaa:	c3                   	ret    

00002aab <updateWindow>:
SYSCALL(updateWindow)
    2aab:	b8 19 00 00 00       	mov    $0x19,%eax
    2ab0:	cd 40                	int    $0x40
    2ab2:	c3                   	ret    

00002ab3 <updatePartialWindow>:
SYSCALL(updatePartialWindow)
    2ab3:	b8 1a 00 00 00       	mov    $0x1a,%eax
    2ab8:	cd 40                	int    $0x40
    2aba:	c3                   	ret    

00002abb <kwrite>:
SYSCALL(kwrite)
    2abb:	b8 1c 00 00 00       	mov    $0x1c,%eax
    2ac0:	cd 40                	int    $0x40
    2ac2:	c3                   	ret    

00002ac3 <setSampleRate>:
SYSCALL(setSampleRate)
    2ac3:	b8 1b 00 00 00       	mov    $0x1b,%eax
    2ac8:	cd 40                	int    $0x40
    2aca:	c3                   	ret    

00002acb <pause>:
SYSCALL(pause)
    2acb:	b8 1d 00 00 00       	mov    $0x1d,%eax
    2ad0:	cd 40                	int    $0x40
    2ad2:	c3                   	ret    

00002ad3 <wavdecode>:
SYSCALL(wavdecode)
    2ad3:	b8 1e 00 00 00       	mov    $0x1e,%eax
    2ad8:	cd 40                	int    $0x40
    2ada:	c3                   	ret    

00002adb <beginDecode>:
SYSCALL(beginDecode)
    2adb:	b8 1f 00 00 00       	mov    $0x1f,%eax
    2ae0:	cd 40                	int    $0x40
    2ae2:	c3                   	ret    

00002ae3 <waitForDecode>:
SYSCALL(waitForDecode)
    2ae3:	b8 20 00 00 00       	mov    $0x20,%eax
    2ae8:	cd 40                	int    $0x40
    2aea:	c3                   	ret    

00002aeb <endDecode>:
SYSCALL(endDecode)
    2aeb:	b8 21 00 00 00       	mov    $0x21,%eax
    2af0:	cd 40                	int    $0x40
    2af2:	c3                   	ret    

00002af3 <getCoreBuf>:
    2af3:	b8 22 00 00 00       	mov    $0x22,%eax
    2af8:	cd 40                	int    $0x40
    2afa:	c3                   	ret    

00002afb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    2afb:	55                   	push   %ebp
    2afc:	89 e5                	mov    %esp,%ebp
    2afe:	83 ec 18             	sub    $0x18,%esp
    2b01:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b04:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    2b07:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2b0e:	00 
    2b0f:	8d 45 f4             	lea    -0xc(%ebp),%eax
    2b12:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b16:	8b 45 08             	mov    0x8(%ebp),%eax
    2b19:	89 04 24             	mov    %eax,(%esp)
    2b1c:	e8 f2 fe ff ff       	call   2a13 <write>
}
    2b21:	c9                   	leave  
    2b22:	c3                   	ret    

00002b23 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    2b23:	55                   	push   %ebp
    2b24:	89 e5                	mov    %esp,%ebp
    2b26:	56                   	push   %esi
    2b27:	53                   	push   %ebx
    2b28:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    2b2b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    2b32:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    2b36:	74 17                	je     2b4f <printint+0x2c>
    2b38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2b3c:	79 11                	jns    2b4f <printint+0x2c>
    neg = 1;
    2b3e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    2b45:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b48:	f7 d8                	neg    %eax
    2b4a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2b4d:	eb 06                	jmp    2b55 <printint+0x32>
  } else {
    x = xx;
    2b4f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b52:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    2b55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    2b5c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2b5f:	8d 41 01             	lea    0x1(%ecx),%eax
    2b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2b65:	8b 5d 10             	mov    0x10(%ebp),%ebx
    2b68:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2b6b:	ba 00 00 00 00       	mov    $0x0,%edx
    2b70:	f7 f3                	div    %ebx
    2b72:	89 d0                	mov    %edx,%eax
    2b74:	0f b6 80 9c cc 00 00 	movzbl 0xcc9c(%eax),%eax
    2b7b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    2b7f:	8b 75 10             	mov    0x10(%ebp),%esi
    2b82:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2b85:	ba 00 00 00 00       	mov    $0x0,%edx
    2b8a:	f7 f6                	div    %esi
    2b8c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2b8f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b93:	75 c7                	jne    2b5c <printint+0x39>
  if(neg)
    2b95:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2b99:	74 10                	je     2bab <printint+0x88>
    buf[i++] = '-';
    2b9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b9e:	8d 50 01             	lea    0x1(%eax),%edx
    2ba1:	89 55 f4             	mov    %edx,-0xc(%ebp)
    2ba4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    2ba9:	eb 1f                	jmp    2bca <printint+0xa7>
    2bab:	eb 1d                	jmp    2bca <printint+0xa7>
    putc(fd, buf[i]);
    2bad:	8d 55 dc             	lea    -0x24(%ebp),%edx
    2bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bb3:	01 d0                	add    %edx,%eax
    2bb5:	0f b6 00             	movzbl (%eax),%eax
    2bb8:	0f be c0             	movsbl %al,%eax
    2bbb:	89 44 24 04          	mov    %eax,0x4(%esp)
    2bbf:	8b 45 08             	mov    0x8(%ebp),%eax
    2bc2:	89 04 24             	mov    %eax,(%esp)
    2bc5:	e8 31 ff ff ff       	call   2afb <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2bca:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2bce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bd2:	79 d9                	jns    2bad <printint+0x8a>
    putc(fd, buf[i]);
}
    2bd4:	83 c4 30             	add    $0x30,%esp
    2bd7:	5b                   	pop    %ebx
    2bd8:	5e                   	pop    %esi
    2bd9:	5d                   	pop    %ebp
    2bda:	c3                   	ret    

00002bdb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2bdb:	55                   	push   %ebp
    2bdc:	89 e5                	mov    %esp,%ebp
    2bde:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    2be1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    2be8:	8d 45 0c             	lea    0xc(%ebp),%eax
    2beb:	83 c0 04             	add    $0x4,%eax
    2bee:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    2bf1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2bf8:	e9 7c 01 00 00       	jmp    2d79 <printf+0x19e>
    c = fmt[i] & 0xff;
    2bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
    2c00:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2c03:	01 d0                	add    %edx,%eax
    2c05:	0f b6 00             	movzbl (%eax),%eax
    2c08:	0f be c0             	movsbl %al,%eax
    2c0b:	25 ff 00 00 00       	and    $0xff,%eax
    2c10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    2c13:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2c17:	75 2c                	jne    2c45 <printf+0x6a>
      if(c == '%'){
    2c19:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2c1d:	75 0c                	jne    2c2b <printf+0x50>
        state = '%';
    2c1f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    2c26:	e9 4a 01 00 00       	jmp    2d75 <printf+0x19a>
      } else {
        putc(fd, c);
    2c2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c2e:	0f be c0             	movsbl %al,%eax
    2c31:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c35:	8b 45 08             	mov    0x8(%ebp),%eax
    2c38:	89 04 24             	mov    %eax,(%esp)
    2c3b:	e8 bb fe ff ff       	call   2afb <putc>
    2c40:	e9 30 01 00 00       	jmp    2d75 <printf+0x19a>
      }
    } else if(state == '%'){
    2c45:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    2c49:	0f 85 26 01 00 00    	jne    2d75 <printf+0x19a>
      if(c == 'd'){
    2c4f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    2c53:	75 2d                	jne    2c82 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    2c55:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2c58:	8b 00                	mov    (%eax),%eax
    2c5a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2c61:	00 
    2c62:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2c69:	00 
    2c6a:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    2c71:	89 04 24             	mov    %eax,(%esp)
    2c74:	e8 aa fe ff ff       	call   2b23 <printint>
        ap++;
    2c79:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2c7d:	e9 ec 00 00 00       	jmp    2d6e <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    2c82:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    2c86:	74 06                	je     2c8e <printf+0xb3>
    2c88:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    2c8c:	75 2d                	jne    2cbb <printf+0xe0>
        printint(fd, *ap, 16, 0);
    2c8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2c91:	8b 00                	mov    (%eax),%eax
    2c93:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2c9a:	00 
    2c9b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    2ca2:	00 
    2ca3:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ca7:	8b 45 08             	mov    0x8(%ebp),%eax
    2caa:	89 04 24             	mov    %eax,(%esp)
    2cad:	e8 71 fe ff ff       	call   2b23 <printint>
        ap++;
    2cb2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2cb6:	e9 b3 00 00 00       	jmp    2d6e <printf+0x193>
      } else if(c == 's'){
    2cbb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    2cbf:	75 45                	jne    2d06 <printf+0x12b>
        s = (char*)*ap;
    2cc1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2cc4:	8b 00                	mov    (%eax),%eax
    2cc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    2cc9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    2ccd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2cd1:	75 09                	jne    2cdc <printf+0x101>
          s = "(null)";
    2cd3:	c7 45 f4 13 96 00 00 	movl   $0x9613,-0xc(%ebp)
        while(*s != 0){
    2cda:	eb 1e                	jmp    2cfa <printf+0x11f>
    2cdc:	eb 1c                	jmp    2cfa <printf+0x11f>
          putc(fd, *s);
    2cde:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ce1:	0f b6 00             	movzbl (%eax),%eax
    2ce4:	0f be c0             	movsbl %al,%eax
    2ce7:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ceb:	8b 45 08             	mov    0x8(%ebp),%eax
    2cee:	89 04 24             	mov    %eax,(%esp)
    2cf1:	e8 05 fe ff ff       	call   2afb <putc>
          s++;
    2cf6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2cfd:	0f b6 00             	movzbl (%eax),%eax
    2d00:	84 c0                	test   %al,%al
    2d02:	75 da                	jne    2cde <printf+0x103>
    2d04:	eb 68                	jmp    2d6e <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2d06:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    2d0a:	75 1d                	jne    2d29 <printf+0x14e>
        putc(fd, *ap);
    2d0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2d0f:	8b 00                	mov    (%eax),%eax
    2d11:	0f be c0             	movsbl %al,%eax
    2d14:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d18:	8b 45 08             	mov    0x8(%ebp),%eax
    2d1b:	89 04 24             	mov    %eax,(%esp)
    2d1e:	e8 d8 fd ff ff       	call   2afb <putc>
        ap++;
    2d23:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2d27:	eb 45                	jmp    2d6e <printf+0x193>
      } else if(c == '%'){
    2d29:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2d2d:	75 17                	jne    2d46 <printf+0x16b>
        putc(fd, c);
    2d2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d32:	0f be c0             	movsbl %al,%eax
    2d35:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d39:	8b 45 08             	mov    0x8(%ebp),%eax
    2d3c:	89 04 24             	mov    %eax,(%esp)
    2d3f:	e8 b7 fd ff ff       	call   2afb <putc>
    2d44:	eb 28                	jmp    2d6e <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2d46:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    2d4d:	00 
    2d4e:	8b 45 08             	mov    0x8(%ebp),%eax
    2d51:	89 04 24             	mov    %eax,(%esp)
    2d54:	e8 a2 fd ff ff       	call   2afb <putc>
        putc(fd, c);
    2d59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d5c:	0f be c0             	movsbl %al,%eax
    2d5f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d63:	8b 45 08             	mov    0x8(%ebp),%eax
    2d66:	89 04 24             	mov    %eax,(%esp)
    2d69:	e8 8d fd ff ff       	call   2afb <putc>
      }
      state = 0;
    2d6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2d75:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2d79:	8b 55 0c             	mov    0xc(%ebp),%edx
    2d7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d7f:	01 d0                	add    %edx,%eax
    2d81:	0f b6 00             	movzbl (%eax),%eax
    2d84:	84 c0                	test   %al,%al
    2d86:	0f 85 71 fe ff ff    	jne    2bfd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2d8c:	c9                   	leave  
    2d8d:	c3                   	ret    

00002d8e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2d8e:	55                   	push   %ebp
    2d8f:	89 e5                	mov    %esp,%ebp
    2d91:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    2d94:	8b 45 08             	mov    0x8(%ebp),%eax
    2d97:	83 e8 08             	sub    $0x8,%eax
    2d9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d9d:	a1 a8 d1 00 00       	mov    0xd1a8,%eax
    2da2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2da5:	eb 24                	jmp    2dcb <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2da7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2daa:	8b 00                	mov    (%eax),%eax
    2dac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2daf:	77 12                	ja     2dc3 <free+0x35>
    2db1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2db4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2db7:	77 24                	ja     2ddd <free+0x4f>
    2db9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2dbc:	8b 00                	mov    (%eax),%eax
    2dbe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2dc1:	77 1a                	ja     2ddd <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2dc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2dc6:	8b 00                	mov    (%eax),%eax
    2dc8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    2dcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2dce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    2dd1:	76 d4                	jbe    2da7 <free+0x19>
    2dd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2dd6:	8b 00                	mov    (%eax),%eax
    2dd8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2ddb:	76 ca                	jbe    2da7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    2ddd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2de0:	8b 40 04             	mov    0x4(%eax),%eax
    2de3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2dea:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2ded:	01 c2                	add    %eax,%edx
    2def:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2df2:	8b 00                	mov    (%eax),%eax
    2df4:	39 c2                	cmp    %eax,%edx
    2df6:	75 24                	jne    2e1c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    2df8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2dfb:	8b 50 04             	mov    0x4(%eax),%edx
    2dfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e01:	8b 00                	mov    (%eax),%eax
    2e03:	8b 40 04             	mov    0x4(%eax),%eax
    2e06:	01 c2                	add    %eax,%edx
    2e08:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e0b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2e0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e11:	8b 00                	mov    (%eax),%eax
    2e13:	8b 10                	mov    (%eax),%edx
    2e15:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e18:	89 10                	mov    %edx,(%eax)
    2e1a:	eb 0a                	jmp    2e26 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    2e1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e1f:	8b 10                	mov    (%eax),%edx
    2e21:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e24:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    2e26:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e29:	8b 40 04             	mov    0x4(%eax),%eax
    2e2c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2e33:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e36:	01 d0                	add    %edx,%eax
    2e38:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2e3b:	75 20                	jne    2e5d <free+0xcf>
    p->s.size += bp->s.size;
    2e3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e40:	8b 50 04             	mov    0x4(%eax),%edx
    2e43:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e46:	8b 40 04             	mov    0x4(%eax),%eax
    2e49:	01 c2                	add    %eax,%edx
    2e4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e4e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e54:	8b 10                	mov    (%eax),%edx
    2e56:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e59:	89 10                	mov    %edx,(%eax)
    2e5b:	eb 08                	jmp    2e65 <free+0xd7>
  } else
    p->s.ptr = bp;
    2e5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e60:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2e63:	89 10                	mov    %edx,(%eax)
  freep = p;
    2e65:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e68:	a3 a8 d1 00 00       	mov    %eax,0xd1a8
}
    2e6d:	c9                   	leave  
    2e6e:	c3                   	ret    

00002e6f <morecore>:

static Header*
morecore(uint nu)
{
    2e6f:	55                   	push   %ebp
    2e70:	89 e5                	mov    %esp,%ebp
    2e72:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    2e75:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2e7c:	77 07                	ja     2e85 <morecore+0x16>
    nu = 4096;
    2e7e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    2e85:	8b 45 08             	mov    0x8(%ebp),%eax
    2e88:	c1 e0 03             	shl    $0x3,%eax
    2e8b:	89 04 24             	mov    %eax,(%esp)
    2e8e:	e8 e8 fb ff ff       	call   2a7b <sbrk>
    2e93:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    2e96:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    2e9a:	75 07                	jne    2ea3 <morecore+0x34>
    return 0;
    2e9c:	b8 00 00 00 00       	mov    $0x0,%eax
    2ea1:	eb 22                	jmp    2ec5 <morecore+0x56>
  hp = (Header*)p;
    2ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ea6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    2ea9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2eac:	8b 55 08             	mov    0x8(%ebp),%edx
    2eaf:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    2eb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2eb5:	83 c0 08             	add    $0x8,%eax
    2eb8:	89 04 24             	mov    %eax,(%esp)
    2ebb:	e8 ce fe ff ff       	call   2d8e <free>
  return freep;
    2ec0:	a1 a8 d1 00 00       	mov    0xd1a8,%eax
}
    2ec5:	c9                   	leave  
    2ec6:	c3                   	ret    

00002ec7 <malloc>:

void*
malloc(uint nbytes)
{
    2ec7:	55                   	push   %ebp
    2ec8:	89 e5                	mov    %esp,%ebp
    2eca:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2ecd:	8b 45 08             	mov    0x8(%ebp),%eax
    2ed0:	83 c0 07             	add    $0x7,%eax
    2ed3:	c1 e8 03             	shr    $0x3,%eax
    2ed6:	83 c0 01             	add    $0x1,%eax
    2ed9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    2edc:	a1 a8 d1 00 00       	mov    0xd1a8,%eax
    2ee1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2ee4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2ee8:	75 23                	jne    2f0d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    2eea:	c7 45 f0 a0 d1 00 00 	movl   $0xd1a0,-0x10(%ebp)
    2ef1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2ef4:	a3 a8 d1 00 00       	mov    %eax,0xd1a8
    2ef9:	a1 a8 d1 00 00       	mov    0xd1a8,%eax
    2efe:	a3 a0 d1 00 00       	mov    %eax,0xd1a0
    base.s.size = 0;
    2f03:	c7 05 a4 d1 00 00 00 	movl   $0x0,0xd1a4
    2f0a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2f0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f10:	8b 00                	mov    (%eax),%eax
    2f12:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    2f15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f18:	8b 40 04             	mov    0x4(%eax),%eax
    2f1b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2f1e:	72 4d                	jb     2f6d <malloc+0xa6>
      if(p->s.size == nunits)
    2f20:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f23:	8b 40 04             	mov    0x4(%eax),%eax
    2f26:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2f29:	75 0c                	jne    2f37 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    2f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f2e:	8b 10                	mov    (%eax),%edx
    2f30:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f33:	89 10                	mov    %edx,(%eax)
    2f35:	eb 26                	jmp    2f5d <malloc+0x96>
      else {
        p->s.size -= nunits;
    2f37:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f3a:	8b 40 04             	mov    0x4(%eax),%eax
    2f3d:	2b 45 ec             	sub    -0x14(%ebp),%eax
    2f40:	89 c2                	mov    %eax,%edx
    2f42:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f45:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    2f48:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f4b:	8b 40 04             	mov    0x4(%eax),%eax
    2f4e:	c1 e0 03             	shl    $0x3,%eax
    2f51:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    2f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f57:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2f5a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    2f5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f60:	a3 a8 d1 00 00       	mov    %eax,0xd1a8
      return (void*)(p + 1);
    2f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f68:	83 c0 08             	add    $0x8,%eax
    2f6b:	eb 38                	jmp    2fa5 <malloc+0xde>
    }
    if(p == freep)
    2f6d:	a1 a8 d1 00 00       	mov    0xd1a8,%eax
    2f72:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    2f75:	75 1b                	jne    2f92 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    2f77:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2f7a:	89 04 24             	mov    %eax,(%esp)
    2f7d:	e8 ed fe ff ff       	call   2e6f <morecore>
    2f82:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2f85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2f89:	75 07                	jne    2f92 <malloc+0xcb>
        return 0;
    2f8b:	b8 00 00 00 00       	mov    $0x0,%eax
    2f90:	eb 13                	jmp    2fa5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2f92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f95:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f9b:	8b 00                	mov    (%eax),%eax
    2f9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    2fa0:	e9 70 ff ff ff       	jmp    2f15 <malloc+0x4e>
}
    2fa5:	c9                   	leave  
    2fa6:	c3                   	ret    

00002fa7 <abs>:
#include "math.h"
#define pi 3.1415926535898 
int abs(int x)
{
    2fa7:	55                   	push   %ebp
    2fa8:	89 e5                	mov    %esp,%ebp
	if (x < 0)
    2faa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2fae:	79 07                	jns    2fb7 <abs+0x10>
		return x * -1;
    2fb0:	8b 45 08             	mov    0x8(%ebp),%eax
    2fb3:	f7 d8                	neg    %eax
    2fb5:	eb 03                	jmp    2fba <abs+0x13>
	else
		return x;
    2fb7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2fba:	5d                   	pop    %ebp
    2fbb:	c3                   	ret    

00002fbc <sin>:
double sin(double x)  
{  
    2fbc:	55                   	push   %ebp
    2fbd:	89 e5                	mov    %esp,%ebp
    2fbf:	83 ec 3c             	sub    $0x3c,%esp
    2fc2:	8b 45 08             	mov    0x8(%ebp),%eax
    2fc5:	89 45 c8             	mov    %eax,-0x38(%ebp)
    2fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fcb:	89 45 cc             	mov    %eax,-0x34(%ebp)
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
    2fce:	dd 45 c8             	fldl   -0x38(%ebp)
    2fd1:	dd 5d f8             	fstpl  -0x8(%ebp)
    2fd4:	d9 e8                	fld1   
    2fd6:	dd 5d f0             	fstpl  -0x10(%ebp)
    2fd9:	dd 45 c8             	fldl   -0x38(%ebp)
    2fdc:	dd 5d e8             	fstpl  -0x18(%ebp)
    2fdf:	dd 45 c8             	fldl   -0x38(%ebp)
    2fe2:	dd 5d e0             	fstpl  -0x20(%ebp)
	int n=1,sign=1;  
    2fe5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    2fec:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
	while(Precious>1e-6)  
    2ff3:	eb 50                	jmp    3045 <sin+0x89>
	{  
		n = n+1;  
    2ff5:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Fac=Fac*n*(n + 1);
    2ff9:	db 45 dc             	fildl  -0x24(%ebp)
    2ffc:	dc 4d f0             	fmull  -0x10(%ebp)
    2fff:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3002:	83 c0 01             	add    $0x1,%eax
    3005:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    3008:	db 45 c4             	fildl  -0x3c(%ebp)
    300b:	de c9                	fmulp  %st,%st(1)
    300d:	dd 5d f0             	fstpl  -0x10(%ebp)
		n = n + 1;  
    3010:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Xn*=x*x;  
    3014:	dd 45 c8             	fldl   -0x38(%ebp)
    3017:	dc 4d c8             	fmull  -0x38(%ebp)
    301a:	dd 45 e8             	fldl   -0x18(%ebp)
    301d:	de c9                	fmulp  %st,%st(1)
    301f:	dd 5d e8             	fstpl  -0x18(%ebp)
		sign=-sign;  
    3022:	f7 5d d8             	negl   -0x28(%ebp)
		Precious=Xn/Fac;  
    3025:	dd 45 e8             	fldl   -0x18(%ebp)
    3028:	dc 75 f0             	fdivl  -0x10(%ebp)
    302b:	dd 5d e0             	fstpl  -0x20(%ebp)
		Result=sign>0?Result+Precious:Result-Precious;  
    302e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    3032:	7e 08                	jle    303c <sin+0x80>
    3034:	dd 45 f8             	fldl   -0x8(%ebp)
    3037:	dc 45 e0             	faddl  -0x20(%ebp)
    303a:	eb 06                	jmp    3042 <sin+0x86>
    303c:	dd 45 f8             	fldl   -0x8(%ebp)
    303f:	dc 65 e0             	fsubl  -0x20(%ebp)
    3042:	dd 5d f8             	fstpl  -0x8(%ebp)
}
double sin(double x)  
{  
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
	int n=1,sign=1;  
	while(Precious>1e-6)  
    3045:	dd 45 e0             	fldl   -0x20(%ebp)
    3048:	dd 05 20 96 00 00    	fldl   0x9620
    304e:	d9 c9                	fxch   %st(1)
    3050:	df e9                	fucomip %st(1),%st
    3052:	dd d8                	fstp   %st(0)
    3054:	77 9f                	ja     2ff5 <sin+0x39>
		Xn*=x*x;  
		sign=-sign;  
		Precious=Xn/Fac;  
		Result=sign>0?Result+Precious:Result-Precious;  
	}  
	return Result;  
    3056:	dd 45 f8             	fldl   -0x8(%ebp)
}  
    3059:	c9                   	leave  
    305a:	c3                   	ret    

0000305b <cos>:
double cos(double x)  
{  
    305b:	55                   	push   %ebp
    305c:	89 e5                	mov    %esp,%ebp
    305e:	83 ec 10             	sub    $0x10,%esp
    3061:	8b 45 08             	mov    0x8(%ebp),%eax
    3064:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3067:	8b 45 0c             	mov    0xc(%ebp),%eax
    306a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(pi/2-x);  
    306d:	dd 05 28 96 00 00    	fldl   0x9628
    3073:	dc 65 f8             	fsubl  -0x8(%ebp)
    3076:	dd 1c 24             	fstpl  (%esp)
    3079:	e8 3e ff ff ff       	call   2fbc <sin>
}  
    307e:	c9                   	leave  
    307f:	c3                   	ret    

00003080 <tan>:
double tan(double x)  
{  
    3080:	55                   	push   %ebp
    3081:	89 e5                	mov    %esp,%ebp
    3083:	83 ec 18             	sub    $0x18,%esp
    3086:	8b 45 08             	mov    0x8(%ebp),%eax
    3089:	89 45 f8             	mov    %eax,-0x8(%ebp)
    308c:	8b 45 0c             	mov    0xc(%ebp),%eax
    308f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(x)/cos(x);  
    3092:	dd 45 f8             	fldl   -0x8(%ebp)
    3095:	dd 1c 24             	fstpl  (%esp)
    3098:	e8 1f ff ff ff       	call   2fbc <sin>
    309d:	dd 5d f0             	fstpl  -0x10(%ebp)
    30a0:	dd 45 f8             	fldl   -0x8(%ebp)
    30a3:	dd 1c 24             	fstpl  (%esp)
    30a6:	e8 b0 ff ff ff       	call   305b <cos>
    30ab:	dc 7d f0             	fdivrl -0x10(%ebp)
}  
    30ae:	c9                   	leave  
    30af:	c3                   	ret    

000030b0 <pow>:

double pow(double x, double y)
{
    30b0:	55                   	push   %ebp
    30b1:	89 e5                	mov    %esp,%ebp
    30b3:	83 ec 48             	sub    $0x48,%esp
    30b6:	8b 45 08             	mov    0x8(%ebp),%eax
    30b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    30bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    30bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    30c2:	8b 45 10             	mov    0x10(%ebp),%eax
    30c5:	89 45 d8             	mov    %eax,-0x28(%ebp)
    30c8:	8b 45 14             	mov    0x14(%ebp),%eax
    30cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(x==0 && y!=0) return 0;
    30ce:	dd 45 e0             	fldl   -0x20(%ebp)
    30d1:	d9 ee                	fldz   
    30d3:	df e9                	fucomip %st(1),%st
    30d5:	dd d8                	fstp   %st(0)
    30d7:	7a 28                	jp     3101 <pow+0x51>
    30d9:	dd 45 e0             	fldl   -0x20(%ebp)
    30dc:	d9 ee                	fldz   
    30de:	df e9                	fucomip %st(1),%st
    30e0:	dd d8                	fstp   %st(0)
    30e2:	75 1d                	jne    3101 <pow+0x51>
    30e4:	dd 45 d8             	fldl   -0x28(%ebp)
    30e7:	d9 ee                	fldz   
    30e9:	df e9                	fucomip %st(1),%st
    30eb:	dd d8                	fstp   %st(0)
    30ed:	7a 0b                	jp     30fa <pow+0x4a>
    30ef:	dd 45 d8             	fldl   -0x28(%ebp)
    30f2:	d9 ee                	fldz   
    30f4:	df e9                	fucomip %st(1),%st
    30f6:	dd d8                	fstp   %st(0)
    30f8:	74 07                	je     3101 <pow+0x51>
    30fa:	d9 ee                	fldz   
    30fc:	e9 30 01 00 00       	jmp    3231 <pow+0x181>
	else if(x==0 && y==0) return 1;
    3101:	dd 45 e0             	fldl   -0x20(%ebp)
    3104:	d9 ee                	fldz   
    3106:	df e9                	fucomip %st(1),%st
    3108:	dd d8                	fstp   %st(0)
    310a:	7a 28                	jp     3134 <pow+0x84>
    310c:	dd 45 e0             	fldl   -0x20(%ebp)
    310f:	d9 ee                	fldz   
    3111:	df e9                	fucomip %st(1),%st
    3113:	dd d8                	fstp   %st(0)
    3115:	75 1d                	jne    3134 <pow+0x84>
    3117:	dd 45 d8             	fldl   -0x28(%ebp)
    311a:	d9 ee                	fldz   
    311c:	df e9                	fucomip %st(1),%st
    311e:	dd d8                	fstp   %st(0)
    3120:	7a 12                	jp     3134 <pow+0x84>
    3122:	dd 45 d8             	fldl   -0x28(%ebp)
    3125:	d9 ee                	fldz   
    3127:	df e9                	fucomip %st(1),%st
    3129:	dd d8                	fstp   %st(0)
    312b:	75 07                	jne    3134 <pow+0x84>
    312d:	d9 e8                	fld1   
    312f:	e9 fd 00 00 00       	jmp    3231 <pow+0x181>
	else if(y<0) return 1/pow(x,-y);//把指数小于0的情况转为1/x^-y计算
    3134:	d9 ee                	fldz   
    3136:	dd 45 d8             	fldl   -0x28(%ebp)
    3139:	d9 c9                	fxch   %st(1)
    313b:	df e9                	fucomip %st(1),%st
    313d:	dd d8                	fstp   %st(0)
    313f:	76 1d                	jbe    315e <pow+0xae>
    3141:	dd 45 d8             	fldl   -0x28(%ebp)
    3144:	d9 e0                	fchs   
    3146:	dd 5c 24 08          	fstpl  0x8(%esp)
    314a:	dd 45 e0             	fldl   -0x20(%ebp)
    314d:	dd 1c 24             	fstpl  (%esp)
    3150:	e8 5b ff ff ff       	call   30b0 <pow>
    3155:	d9 e8                	fld1   
    3157:	de f1                	fdivp  %st,%st(1)
    3159:	e9 d3 00 00 00       	jmp    3231 <pow+0x181>
	else if(x<0 && y-(int)y!=0) return 0;//若x为负，且y不为整数数，则出错，返回0  
    315e:	d9 ee                	fldz   
    3160:	dd 45 e0             	fldl   -0x20(%ebp)
    3163:	d9 c9                	fxch   %st(1)
    3165:	df e9                	fucomip %st(1),%st
    3167:	dd d8                	fstp   %st(0)
    3169:	76 40                	jbe    31ab <pow+0xfb>
    316b:	dd 45 d8             	fldl   -0x28(%ebp)
    316e:	d9 7d d6             	fnstcw -0x2a(%ebp)
    3171:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    3175:	b4 0c                	mov    $0xc,%ah
    3177:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    317b:	d9 6d d4             	fldcw  -0x2c(%ebp)
    317e:	db 5d d0             	fistpl -0x30(%ebp)
    3181:	d9 6d d6             	fldcw  -0x2a(%ebp)
    3184:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3187:	89 45 d0             	mov    %eax,-0x30(%ebp)
    318a:	db 45 d0             	fildl  -0x30(%ebp)
    318d:	dd 45 d8             	fldl   -0x28(%ebp)
    3190:	de e1                	fsubp  %st,%st(1)
    3192:	d9 ee                	fldz   
    3194:	df e9                	fucomip %st(1),%st
    3196:	7a 0a                	jp     31a2 <pow+0xf2>
    3198:	d9 ee                	fldz   
    319a:	df e9                	fucomip %st(1),%st
    319c:	dd d8                	fstp   %st(0)
    319e:	74 0b                	je     31ab <pow+0xfb>
    31a0:	eb 02                	jmp    31a4 <pow+0xf4>
    31a2:	dd d8                	fstp   %st(0)
    31a4:	d9 ee                	fldz   
    31a6:	e9 86 00 00 00       	jmp    3231 <pow+0x181>
	else if(x<0 && y-(int)y==0)//若x为负，且y为整数数，则用循环计算 
    31ab:	d9 ee                	fldz   
    31ad:	dd 45 e0             	fldl   -0x20(%ebp)
    31b0:	d9 c9                	fxch   %st(1)
    31b2:	df e9                	fucomip %st(1),%st
    31b4:	dd d8                	fstp   %st(0)
    31b6:	76 63                	jbe    321b <pow+0x16b>
    31b8:	dd 45 d8             	fldl   -0x28(%ebp)
    31bb:	d9 7d d6             	fnstcw -0x2a(%ebp)
    31be:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    31c2:	b4 0c                	mov    $0xc,%ah
    31c4:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    31c8:	d9 6d d4             	fldcw  -0x2c(%ebp)
    31cb:	db 5d d0             	fistpl -0x30(%ebp)
    31ce:	d9 6d d6             	fldcw  -0x2a(%ebp)
    31d1:	8b 45 d0             	mov    -0x30(%ebp),%eax
    31d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    31d7:	db 45 d0             	fildl  -0x30(%ebp)
    31da:	dd 45 d8             	fldl   -0x28(%ebp)
    31dd:	de e1                	fsubp  %st,%st(1)
    31df:	d9 ee                	fldz   
    31e1:	df e9                	fucomip %st(1),%st
    31e3:	7a 34                	jp     3219 <pow+0x169>
    31e5:	d9 ee                	fldz   
    31e7:	df e9                	fucomip %st(1),%st
    31e9:	dd d8                	fstp   %st(0)
    31eb:	75 2e                	jne    321b <pow+0x16b>
	{
		double powint=1;
    31ed:	d9 e8                	fld1   
    31ef:	dd 5d f0             	fstpl  -0x10(%ebp)
		int i;
		for(i=1;i<=y;i++) powint*=x;
    31f2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    31f9:	eb 0d                	jmp    3208 <pow+0x158>
    31fb:	dd 45 f0             	fldl   -0x10(%ebp)
    31fe:	dc 4d e0             	fmull  -0x20(%ebp)
    3201:	dd 5d f0             	fstpl  -0x10(%ebp)
    3204:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    3208:	db 45 ec             	fildl  -0x14(%ebp)
    320b:	dd 45 d8             	fldl   -0x28(%ebp)
    320e:	df e9                	fucomip %st(1),%st
    3210:	dd d8                	fstp   %st(0)
    3212:	73 e7                	jae    31fb <pow+0x14b>
		return powint;
    3214:	dd 45 f0             	fldl   -0x10(%ebp)
    3217:	eb 18                	jmp    3231 <pow+0x181>
    3219:	dd d8                	fstp   %st(0)
	}
	return exp(y*ln(x));
    321b:	dd 45 e0             	fldl   -0x20(%ebp)
    321e:	dd 1c 24             	fstpl  (%esp)
    3221:	e8 36 00 00 00       	call   325c <ln>
    3226:	dc 4d d8             	fmull  -0x28(%ebp)
    3229:	dd 1c 24             	fstpl  (%esp)
    322c:	e8 0e 02 00 00       	call   343f <exp>
}
    3231:	c9                   	leave  
    3232:	c3                   	ret    

00003233 <sqrt>:
// 求根
double sqrt(double x)
{
    3233:	55                   	push   %ebp
    3234:	89 e5                	mov    %esp,%ebp
    3236:	83 ec 28             	sub    $0x28,%esp
    3239:	8b 45 08             	mov    0x8(%ebp),%eax
    323c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    323f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3242:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return pow(x,0.5);
    3245:	dd 05 30 96 00 00    	fldl   0x9630
    324b:	dd 5c 24 08          	fstpl  0x8(%esp)
    324f:	dd 45 f0             	fldl   -0x10(%ebp)
    3252:	dd 1c 24             	fstpl  (%esp)
    3255:	e8 56 fe ff ff       	call   30b0 <pow>
}
    325a:	c9                   	leave  
    325b:	c3                   	ret    

0000325c <ln>:

// ln(x) = 2 arctanh((x-1)/(x+1))
// 调用了Arctanh(double) 方法
double ln(double x)
{
    325c:	55                   	push   %ebp
    325d:	89 e5                	mov    %esp,%ebp
    325f:	81 ec 88 00 00 00    	sub    $0x88,%esp
    3265:	8b 45 08             	mov    0x8(%ebp),%eax
    3268:	89 45 90             	mov    %eax,-0x70(%ebp)
    326b:	8b 45 0c             	mov    0xc(%ebp),%eax
    326e:	89 45 94             	mov    %eax,-0x6c(%ebp)
	double y=x-1,ln_p1=0,ln_p2=0,ln_p3=0,ln_px=0,ln_tmp=1,dln_px=1,tmp;
    3271:	dd 45 90             	fldl   -0x70(%ebp)
    3274:	d9 e8                	fld1   
    3276:	de e9                	fsubrp %st,%st(1)
    3278:	dd 5d c0             	fstpl  -0x40(%ebp)
    327b:	d9 ee                	fldz   
    327d:	dd 5d f0             	fstpl  -0x10(%ebp)
    3280:	d9 ee                	fldz   
    3282:	dd 5d b8             	fstpl  -0x48(%ebp)
    3285:	d9 ee                	fldz   
    3287:	dd 5d b0             	fstpl  -0x50(%ebp)
    328a:	d9 ee                	fldz   
    328c:	dd 5d e8             	fstpl  -0x18(%ebp)
    328f:	d9 e8                	fld1   
    3291:	dd 5d e0             	fstpl  -0x20(%ebp)
    3294:	d9 e8                	fld1   
    3296:	dd 5d a8             	fstpl  -0x58(%ebp)
	int l;
	if(x==1) return 0;
    3299:	dd 45 90             	fldl   -0x70(%ebp)
    329c:	d9 e8                	fld1   
    329e:	df e9                	fucomip %st(1),%st
    32a0:	dd d8                	fstp   %st(0)
    32a2:	7a 12                	jp     32b6 <ln+0x5a>
    32a4:	dd 45 90             	fldl   -0x70(%ebp)
    32a7:	d9 e8                	fld1   
    32a9:	df e9                	fucomip %st(1),%st
    32ab:	dd d8                	fstp   %st(0)
    32ad:	75 07                	jne    32b6 <ln+0x5a>
    32af:	d9 ee                	fldz   
    32b1:	e9 87 01 00 00       	jmp    343d <ln+0x1e1>
	else if(x>2) return -ln(1/x);
    32b6:	dd 45 90             	fldl   -0x70(%ebp)
    32b9:	dd 05 38 96 00 00    	fldl   0x9638
    32bf:	d9 c9                	fxch   %st(1)
    32c1:	df e9                	fucomip %st(1),%st
    32c3:	dd d8                	fstp   %st(0)
    32c5:	76 14                	jbe    32db <ln+0x7f>
    32c7:	d9 e8                	fld1   
    32c9:	dc 75 90             	fdivl  -0x70(%ebp)
    32cc:	dd 1c 24             	fstpl  (%esp)
    32cf:	e8 88 ff ff ff       	call   325c <ln>
    32d4:	d9 e0                	fchs   
    32d6:	e9 62 01 00 00       	jmp    343d <ln+0x1e1>
	else if(x<.1)
    32db:	dd 05 40 96 00 00    	fldl   0x9640
    32e1:	dd 45 90             	fldl   -0x70(%ebp)
    32e4:	d9 c9                	fxch   %st(1)
    32e6:	df e9                	fucomip %st(1),%st
    32e8:	dd d8                	fstp   %st(0)
    32ea:	76 59                	jbe    3345 <ln+0xe9>
	{
		double n=-1;
    32ec:	d9 e8                	fld1   
    32ee:	d9 e0                	fchs   
    32f0:	dd 5d c8             	fstpl  -0x38(%ebp)
		double a;
		do
		{
			n=n-.6;
    32f3:	dd 45 c8             	fldl   -0x38(%ebp)
    32f6:	dd 05 48 96 00 00    	fldl   0x9648
    32fc:	de e9                	fsubrp %st,%st(1)
    32fe:	dd 5d c8             	fstpl  -0x38(%ebp)
			a=x/exp(n);
    3301:	dd 45 c8             	fldl   -0x38(%ebp)
    3304:	dd 1c 24             	fstpl  (%esp)
    3307:	e8 33 01 00 00       	call   343f <exp>
    330c:	dd 45 90             	fldl   -0x70(%ebp)
    330f:	de f1                	fdivp  %st,%st(1)
    3311:	dd 5d a0             	fstpl  -0x60(%ebp)
		}
		while(a>2 || a<1);
    3314:	dd 45 a0             	fldl   -0x60(%ebp)
    3317:	dd 05 38 96 00 00    	fldl   0x9638
    331d:	d9 c9                	fxch   %st(1)
    331f:	df e9                	fucomip %st(1),%st
    3321:	dd d8                	fstp   %st(0)
    3323:	77 ce                	ja     32f3 <ln+0x97>
    3325:	d9 e8                	fld1   
    3327:	dd 45 a0             	fldl   -0x60(%ebp)
    332a:	d9 c9                	fxch   %st(1)
    332c:	df e9                	fucomip %st(1),%st
    332e:	dd d8                	fstp   %st(0)
    3330:	77 c1                	ja     32f3 <ln+0x97>
		return ln(a)+n;
    3332:	dd 45 a0             	fldl   -0x60(%ebp)
    3335:	dd 1c 24             	fstpl  (%esp)
    3338:	e8 1f ff ff ff       	call   325c <ln>
    333d:	dc 45 c8             	faddl  -0x38(%ebp)
    3340:	e9 f8 00 00 00       	jmp    343d <ln+0x1e1>
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    3345:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    334c:	d9 e8                	fld1   
    334e:	dd 5d d8             	fstpl  -0x28(%ebp)
    3351:	e9 b6 00 00 00       	jmp    340c <ln+0x1b0>
	{
		ln_tmp=ln_px;
    3356:	dd 45 e8             	fldl   -0x18(%ebp)
    3359:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    335c:	dd 45 d8             	fldl   -0x28(%ebp)
    335f:	dc 4d c0             	fmull  -0x40(%ebp)
    3362:	dd 5d d8             	fstpl  -0x28(%ebp)
		if(l==1) tmp=tmp/l;
    3365:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    3369:	75 0d                	jne    3378 <ln+0x11c>
    336b:	db 45 d4             	fildl  -0x2c(%ebp)
    336e:	dd 45 d8             	fldl   -0x28(%ebp)
    3371:	de f1                	fdivp  %st,%st(1)
    3373:	dd 5d d8             	fstpl  -0x28(%ebp)
    3376:	eb 13                	jmp    338b <ln+0x12f>
		else tmp=tmp/-l;
    3378:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    337b:	f7 d8                	neg    %eax
    337d:	89 45 8c             	mov    %eax,-0x74(%ebp)
    3380:	db 45 8c             	fildl  -0x74(%ebp)
    3383:	dd 45 d8             	fldl   -0x28(%ebp)
    3386:	de f1                	fdivp  %st,%st(1)
    3388:	dd 5d d8             	fstpl  -0x28(%ebp)
		ln_p1+=tmp;
    338b:	dd 45 f0             	fldl   -0x10(%ebp)
    338e:	dc 45 d8             	faddl  -0x28(%ebp)
    3391:	dd 5d f0             	fstpl  -0x10(%ebp)
		ln_p2=ln_p1+-1*tmp*y*l/(l+1);
    3394:	dd 45 d8             	fldl   -0x28(%ebp)
    3397:	d9 e0                	fchs   
    3399:	dc 4d c0             	fmull  -0x40(%ebp)
    339c:	db 45 d4             	fildl  -0x2c(%ebp)
    339f:	de c9                	fmulp  %st,%st(1)
    33a1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    33a4:	83 c0 01             	add    $0x1,%eax
    33a7:	89 45 8c             	mov    %eax,-0x74(%ebp)
    33aa:	db 45 8c             	fildl  -0x74(%ebp)
    33ad:	de f9                	fdivrp %st,%st(1)
    33af:	dc 45 f0             	faddl  -0x10(%ebp)
    33b2:	dd 5d b8             	fstpl  -0x48(%ebp)
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
    33b5:	dd 45 d8             	fldl   -0x28(%ebp)
    33b8:	dc 4d c0             	fmull  -0x40(%ebp)
    33bb:	dc 4d c0             	fmull  -0x40(%ebp)
    33be:	db 45 d4             	fildl  -0x2c(%ebp)
    33c1:	de c9                	fmulp  %st,%st(1)
    33c3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    33c6:	83 c0 02             	add    $0x2,%eax
    33c9:	89 45 8c             	mov    %eax,-0x74(%ebp)
    33cc:	db 45 8c             	fildl  -0x74(%ebp)
    33cf:	de f9                	fdivrp %st,%st(1)
    33d1:	dc 45 b8             	faddl  -0x48(%ebp)
    33d4:	dd 5d b0             	fstpl  -0x50(%ebp)
		dln_px=ln_p3-ln_p2;
    33d7:	dd 45 b0             	fldl   -0x50(%ebp)
    33da:	dc 65 b8             	fsubl  -0x48(%ebp)
    33dd:	dd 5d a8             	fstpl  -0x58(%ebp)
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
    33e0:	dd 45 a8             	fldl   -0x58(%ebp)
    33e3:	dc 4d a8             	fmull  -0x58(%ebp)
    33e6:	dd 45 b8             	fldl   -0x48(%ebp)
    33e9:	d8 c0                	fadd   %st(0),%st
    33eb:	dd 45 b0             	fldl   -0x50(%ebp)
    33ee:	de e1                	fsubp  %st,%st(1)
    33f0:	dc 45 f0             	faddl  -0x10(%ebp)
    33f3:	de f9                	fdivrp %st,%st(1)
    33f5:	dd 45 b0             	fldl   -0x50(%ebp)
    33f8:	de e1                	fsubp  %st,%st(1)
    33fa:	dd 5d e8             	fstpl  -0x18(%ebp)
		tmp*=l;
    33fd:	db 45 d4             	fildl  -0x2c(%ebp)
    3400:	dd 45 d8             	fldl   -0x28(%ebp)
    3403:	de c9                	fmulp  %st,%st(1)
    3405:	dd 5d d8             	fstpl  -0x28(%ebp)
			a=x/exp(n);
		}
		while(a>2 || a<1);
		return ln(a)+n;
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    3408:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    340c:	dd 45 e8             	fldl   -0x18(%ebp)
    340f:	dc 65 e0             	fsubl  -0x20(%ebp)
    3412:	dd 05 50 96 00 00    	fldl   0x9650
    3418:	d9 c9                	fxch   %st(1)
    341a:	df e9                	fucomip %st(1),%st
    341c:	dd d8                	fstp   %st(0)
    341e:	0f 87 32 ff ff ff    	ja     3356 <ln+0xfa>
    3424:	dd 45 e8             	fldl   -0x18(%ebp)
    3427:	dc 65 e0             	fsubl  -0x20(%ebp)
    342a:	dd 05 58 96 00 00    	fldl   0x9658
    3430:	df e9                	fucomip %st(1),%st
    3432:	dd d8                	fstp   %st(0)
    3434:	0f 87 1c ff ff ff    	ja     3356 <ln+0xfa>
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
		dln_px=ln_p3-ln_p2;
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
		tmp*=l;
	}
	return ln_px;
    343a:	dd 45 e8             	fldl   -0x18(%ebp)
}
    343d:	c9                   	leave  
    343e:	c3                   	ret    

0000343f <exp>:

// 求e^x 用于Pow( double, double )调用
// e^x = 1+x+(x^2)/2!+(x^3)/3!+...
// 精度为7位
double exp( double x )
{
    343f:	55                   	push   %ebp
    3440:	89 e5                	mov    %esp,%ebp
    3442:	83 ec 78             	sub    $0x78,%esp
    3445:	8b 45 08             	mov    0x8(%ebp),%eax
    3448:	89 45 a0             	mov    %eax,-0x60(%ebp)
    344b:	8b 45 0c             	mov    0xc(%ebp),%eax
    344e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
    3451:	dd 45 a0             	fldl   -0x60(%ebp)
    3454:	dd 5d c0             	fstpl  -0x40(%ebp)
    3457:	d9 ee                	fldz   
    3459:	dd 5d f0             	fstpl  -0x10(%ebp)
    345c:	d9 ee                	fldz   
    345e:	dd 5d b8             	fstpl  -0x48(%ebp)
    3461:	d9 ee                	fldz   
    3463:	dd 5d b0             	fstpl  -0x50(%ebp)
    3466:	d9 ee                	fldz   
    3468:	dd 5d e8             	fstpl  -0x18(%ebp)
    346b:	d9 e8                	fld1   
    346d:	dd 5d e0             	fstpl  -0x20(%ebp)
    3470:	d9 e8                	fld1   
    3472:	dd 5d d8             	fstpl  -0x28(%ebp)
	int l;
	if(x==0) return 1;
    3475:	dd 45 a0             	fldl   -0x60(%ebp)
    3478:	d9 ee                	fldz   
    347a:	df e9                	fucomip %st(1),%st
    347c:	dd d8                	fstp   %st(0)
    347e:	7a 12                	jp     3492 <exp+0x53>
    3480:	dd 45 a0             	fldl   -0x60(%ebp)
    3483:	d9 ee                	fldz   
    3485:	df e9                	fucomip %st(1),%st
    3487:	dd d8                	fstp   %st(0)
    3489:	75 07                	jne    3492 <exp+0x53>
    348b:	d9 e8                	fld1   
    348d:	e9 08 01 00 00       	jmp    359a <exp+0x15b>
	if(x<0) return 1/exp(-x); 
    3492:	d9 ee                	fldz   
    3494:	dd 45 a0             	fldl   -0x60(%ebp)
    3497:	d9 c9                	fxch   %st(1)
    3499:	df e9                	fucomip %st(1),%st
    349b:	dd d8                	fstp   %st(0)
    349d:	76 16                	jbe    34b5 <exp+0x76>
    349f:	dd 45 a0             	fldl   -0x60(%ebp)
    34a2:	d9 e0                	fchs   
    34a4:	dd 1c 24             	fstpl  (%esp)
    34a7:	e8 93 ff ff ff       	call   343f <exp>
    34ac:	d9 e8                	fld1   
    34ae:	de f1                	fdivp  %st,%st(1)
    34b0:	e9 e5 00 00 00       	jmp    359a <exp+0x15b>
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    34b5:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
    34bc:	d9 e8                	fld1   
    34be:	dd 5d d0             	fstpl  -0x30(%ebp)
    34c1:	e9 92 00 00 00       	jmp    3558 <exp+0x119>
	{
		ex_tmp=ex_px;
    34c6:	dd 45 e8             	fldl   -0x18(%ebp)
    34c9:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    34cc:	dd 45 d0             	fldl   -0x30(%ebp)
    34cf:	dc 4d c0             	fmull  -0x40(%ebp)
    34d2:	dd 5d d0             	fstpl  -0x30(%ebp)
		tmp=tmp/l;
    34d5:	db 45 cc             	fildl  -0x34(%ebp)
    34d8:	dd 45 d0             	fldl   -0x30(%ebp)
    34db:	de f1                	fdivp  %st,%st(1)
    34dd:	dd 5d d0             	fstpl  -0x30(%ebp)
		ex_p1+=tmp;
    34e0:	dd 45 f0             	fldl   -0x10(%ebp)
    34e3:	dc 45 d0             	faddl  -0x30(%ebp)
    34e6:	dd 5d f0             	fstpl  -0x10(%ebp)
		ex_p2=ex_p1+tmp*y/(l+1);
    34e9:	dd 45 d0             	fldl   -0x30(%ebp)
    34ec:	dc 4d c0             	fmull  -0x40(%ebp)
    34ef:	8b 45 cc             	mov    -0x34(%ebp),%eax
    34f2:	83 c0 01             	add    $0x1,%eax
    34f5:	89 45 9c             	mov    %eax,-0x64(%ebp)
    34f8:	db 45 9c             	fildl  -0x64(%ebp)
    34fb:	de f9                	fdivrp %st,%st(1)
    34fd:	dc 45 f0             	faddl  -0x10(%ebp)
    3500:	dd 5d b8             	fstpl  -0x48(%ebp)
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
    3503:	dd 45 d0             	fldl   -0x30(%ebp)
    3506:	dc 4d c0             	fmull  -0x40(%ebp)
    3509:	dc 4d c0             	fmull  -0x40(%ebp)
    350c:	8b 45 cc             	mov    -0x34(%ebp),%eax
    350f:	83 c0 01             	add    $0x1,%eax
    3512:	89 45 9c             	mov    %eax,-0x64(%ebp)
    3515:	db 45 9c             	fildl  -0x64(%ebp)
    3518:	de f9                	fdivrp %st,%st(1)
    351a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    351d:	83 c0 02             	add    $0x2,%eax
    3520:	89 45 9c             	mov    %eax,-0x64(%ebp)
    3523:	db 45 9c             	fildl  -0x64(%ebp)
    3526:	de f9                	fdivrp %st,%st(1)
    3528:	dc 45 b8             	faddl  -0x48(%ebp)
    352b:	dd 5d b0             	fstpl  -0x50(%ebp)
		dex_px=ex_p3-ex_p2;
    352e:	dd 45 b0             	fldl   -0x50(%ebp)
    3531:	dc 65 b8             	fsubl  -0x48(%ebp)
    3534:	dd 5d d8             	fstpl  -0x28(%ebp)
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
    3537:	dd 45 d8             	fldl   -0x28(%ebp)
    353a:	dc 4d d8             	fmull  -0x28(%ebp)
    353d:	dd 45 b8             	fldl   -0x48(%ebp)
    3540:	d8 c0                	fadd   %st(0),%st
    3542:	dd 45 b0             	fldl   -0x50(%ebp)
    3545:	de e1                	fsubp  %st,%st(1)
    3547:	dc 45 f0             	faddl  -0x10(%ebp)
    354a:	de f9                	fdivrp %st,%st(1)
    354c:	dd 45 b0             	fldl   -0x50(%ebp)
    354f:	de e1                	fsubp  %st,%st(1)
    3551:	dd 5d e8             	fstpl  -0x18(%ebp)
{
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
	int l;
	if(x==0) return 1;
	if(x<0) return 1/exp(-x); 
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    3554:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
    3558:	dd 45 e8             	fldl   -0x18(%ebp)
    355b:	dc 65 e0             	fsubl  -0x20(%ebp)
    355e:	dd 05 60 96 00 00    	fldl   0x9660
    3564:	d9 c9                	fxch   %st(1)
    3566:	df e9                	fucomip %st(1),%st
    3568:	dd d8                	fstp   %st(0)
    356a:	77 12                	ja     357e <exp+0x13f>
    356c:	dd 45 e8             	fldl   -0x18(%ebp)
    356f:	dc 65 e0             	fsubl  -0x20(%ebp)
    3572:	dd 05 68 96 00 00    	fldl   0x9668
    3578:	df e9                	fucomip %st(1),%st
    357a:	dd d8                	fstp   %st(0)
    357c:	76 15                	jbe    3593 <exp+0x154>
    357e:	dd 45 d8             	fldl   -0x28(%ebp)
    3581:	dd 05 60 96 00 00    	fldl   0x9660
    3587:	d9 c9                	fxch   %st(1)
    3589:	df e9                	fucomip %st(1),%st
    358b:	dd d8                	fstp   %st(0)
    358d:	0f 87 33 ff ff ff    	ja     34c6 <exp+0x87>
		ex_p2=ex_p1+tmp*y/(l+1);
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
		dex_px=ex_p3-ex_p2;
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
	}
	return ex_px+1;
    3593:	dd 45 e8             	fldl   -0x18(%ebp)
    3596:	d9 e8                	fld1   
    3598:	de c1                	faddp  %st,%st(1)
    359a:	c9                   	leave  
    359b:	c3                   	ret    

0000359c <OpenTableFile>:
};
double  s_freq[4] = {44.1, 48, 32, 0};
char *mode_names[4] = { "stereo", "j-stereo", "dual-ch", "single-ch" };

int OpenTableFile(char *name)
{
    359c:	55                   	push   %ebp
    359d:	89 e5                	mov    %esp,%ebp
    359f:	83 ec 78             	sub    $0x78,%esp
	char fulname[80];
	int f;

	fulname[0] = '\0';
    35a2:	c6 45 a4 00          	movb   $0x0,-0x5c(%ebp)
	strcpy(fulname, name);
    35a6:	8b 45 08             	mov    0x8(%ebp),%eax
    35a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    35ad:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    35b0:	89 04 24             	mov    %eax,(%esp)
    35b3:	e8 f8 f1 ff ff       	call   27b0 <strcpy>
	//-1 ?
	if( (f=open(fulname,O_RDWR))==-1 ) {
    35b8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    35bf:	00 
    35c0:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    35c3:	89 04 24             	mov    %eax,(%esp)
    35c6:	e8 68 f4 ff ff       	call   2a33 <open>
    35cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    35ce:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    35d2:	75 1b                	jne    35ef <OpenTableFile+0x53>
		printf(0,"\nOpenTable: could not find %s\n", fulname);
    35d4:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    35d7:	89 44 24 08          	mov    %eax,0x8(%esp)
    35db:	c7 44 24 04 9c 96 00 	movl   $0x969c,0x4(%esp)
    35e2:	00 
    35e3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35ea:	e8 ec f5 ff ff       	call   2bdb <printf>
    }
    return f;
    35ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    35f2:	c9                   	leave  
    35f3:	c3                   	ret    

000035f4 <WriteHdr>:


void WriteHdr(struct frame_params *fr_ps)
{
    35f4:	55                   	push   %ebp
    35f5:	89 e5                	mov    %esp,%ebp
    35f7:	57                   	push   %edi
    35f8:	56                   	push   %esi
    35f9:	53                   	push   %ebx
    35fa:	83 ec 3c             	sub    $0x3c,%esp
	layer *info = fr_ps->header;
    35fd:	8b 45 08             	mov    0x8(%ebp),%eax
    3600:	8b 00                	mov    (%eax),%eax
    3602:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    3605:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3608:	8b 78 14             	mov    0x14(%eax),%edi
    360b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    360e:	8b 70 10             	mov    0x10(%eax),%esi
    3611:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3614:	8b 58 0c             	mov    0xc(%eax),%ebx
		info->version, info->lay, !info->error_protection,
    3617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    361a:	8b 40 08             	mov    0x8(%eax),%eax

void WriteHdr(struct frame_params *fr_ps)
{
	layer *info = fr_ps->header;

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    361d:	85 c0                	test   %eax,%eax
    361f:	0f 94 c0             	sete   %al
    3622:	0f b6 c8             	movzbl %al,%ecx
    3625:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3628:	8b 50 04             	mov    0x4(%eax),%edx
    362b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    362e:	8b 00                	mov    (%eax),%eax
    3630:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    3634:	89 74 24 18          	mov    %esi,0x18(%esp)
    3638:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    363c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3640:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3644:	89 44 24 08          	mov    %eax,0x8(%esp)
    3648:	c7 44 24 04 bc 96 00 	movl   $0x96bc,0x4(%esp)
    364f:	00 
    3650:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3657:	e8 7f f5 ff ff       	call   2bdb <printf>
		info->version, info->lay, !info->error_protection,
		info->bitrate_index, info->sampling_frequency, info->padding);

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
    365c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    365f:	8b 78 2c             	mov    0x2c(%eax),%edi
    3662:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3665:	8b 70 28             	mov    0x28(%eax),%esi
    3668:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    366b:	8b 58 24             	mov    0x24(%eax),%ebx
    366e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3671:	8b 48 20             	mov    0x20(%eax),%ecx
    3674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3677:	8b 50 1c             	mov    0x1c(%eax),%edx
    367a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    367d:	8b 40 18             	mov    0x18(%eax),%eax
    3680:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    3684:	89 74 24 18          	mov    %esi,0x18(%esp)
    3688:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    368c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3690:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3694:	89 44 24 08          	mov    %eax,0x8(%esp)
    3698:	c7 44 24 04 fc 96 00 	movl   $0x96fc,0x4(%esp)
    369f:	00 
    36a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    36a7:	e8 2f f5 ff ff       	call   2bdb <printf>
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    36ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36af:	8b 40 1c             	mov    0x1c(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    36b2:	8b 0c 85 c0 cd 00 00 	mov    0xcdc0(,%eax,4),%ecx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    36b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36bc:	8b 40 10             	mov    0x10(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    36bf:	dd 04 c5 a0 cd 00 00 	fldl   0xcda0(,%eax,8)
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    36c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36c9:	8b 40 04             	mov    0x4(%eax),%eax
    36cc:	8d 50 ff             	lea    -0x1(%eax),%edx
    36cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36d2:	8b 58 0c             	mov    0xc(%eax),%ebx

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    36d5:	89 d0                	mov    %edx,%eax
    36d7:	c1 e0 04             	shl    $0x4,%eax
    36da:	29 d0                	sub    %edx,%eax
    36dc:	01 d8                	add    %ebx,%eax
    36de:	8b 14 85 e0 cc 00 00 	mov    0xcce0(,%eax,4),%edx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    36e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36e8:	8b 40 04             	mov    0x4(%eax),%eax
    36eb:	83 e8 01             	sub    $0x1,%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    36ee:	8b 04 85 c0 cc 00 00 	mov    0xccc0(,%eax,4),%eax
    36f5:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    36f9:	dd 5c 24 10          	fstpl  0x10(%esp)
    36fd:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3701:	89 44 24 08          	mov    %eax,0x8(%esp)
    3705:	c7 44 24 04 24 97 00 	movl   $0x9724,0x4(%esp)
    370c:	00 
    370d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3714:	e8 c2 f4 ff ff       	call   2bdb <printf>
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);

	printf(0, "sblim=%d, jsbd=%d, ch=%d\n",
    3719:	8b 45 08             	mov    0x8(%ebp),%eax
    371c:	8b 48 08             	mov    0x8(%eax),%ecx
    371f:	8b 45 08             	mov    0x8(%ebp),%eax
    3722:	8b 50 0c             	mov    0xc(%eax),%edx
    3725:	8b 45 08             	mov    0x8(%ebp),%eax
    3728:	8b 40 10             	mov    0x10(%eax),%eax
    372b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    372f:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3733:	89 44 24 08          	mov    %eax,0x8(%esp)
    3737:	c7 44 24 04 53 97 00 	movl   $0x9753,0x4(%esp)
    373e:	00 
    373f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3746:	e8 90 f4 ff ff       	call   2bdb <printf>
		fr_ps->sblimit, fr_ps->jsbound, fr_ps->stereo);
}
    374b:	83 c4 3c             	add    $0x3c,%esp
    374e:	5b                   	pop    %ebx
    374f:	5e                   	pop    %esi
    3750:	5f                   	pop    %edi
    3751:	5d                   	pop    %ebp
    3752:	c3                   	ret    

00003753 <mem_alloc>:

void *mem_alloc(unsigned long block, char *item)
{
    3753:	55                   	push   %ebp
    3754:	89 e5                	mov    %esp,%ebp
    3756:	83 ec 28             	sub    $0x28,%esp
	void *ptr;
	ptr = (void *)malloc((unsigned long)block);
    3759:	8b 45 08             	mov    0x8(%ebp),%eax
    375c:	89 04 24             	mov    %eax,(%esp)
    375f:	e8 63 f7 ff ff       	call   2ec7 <malloc>
    3764:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (ptr != 0)
    3767:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    376b:	74 1c                	je     3789 <mem_alloc+0x36>
		memset(ptr, 0, block);
    376d:	8b 45 08             	mov    0x8(%ebp),%eax
    3770:	89 44 24 08          	mov    %eax,0x8(%esp)
    3774:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    377b:	00 
    377c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    377f:	89 04 24             	mov    %eax,(%esp)
    3782:	e8 bf f0 ff ff       	call   2846 <memset>
    3787:	eb 20                	jmp    37a9 <mem_alloc+0x56>
	else{
		printf(0, "Unable to allocate %s\n", item);
    3789:	8b 45 0c             	mov    0xc(%ebp),%eax
    378c:	89 44 24 08          	mov    %eax,0x8(%esp)
    3790:	c7 44 24 04 6d 97 00 	movl   $0x976d,0x4(%esp)
    3797:	00 
    3798:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    379f:	e8 37 f4 ff ff       	call   2bdb <printf>
		exit();
    37a4:	e8 4a f2 ff ff       	call   29f3 <exit>
	}
	return ptr;
    37a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    37ac:	c9                   	leave  
    37ad:	c3                   	ret    

000037ae <alloc_buffer>:

void alloc_buffer(Bit_stream_struc *bs, int size)
{
    37ae:	55                   	push   %ebp
    37af:	89 e5                	mov    %esp,%ebp
    37b1:	83 ec 18             	sub    $0x18,%esp
	bs->buf = (unsigned char *) mem_alloc(size*sizeof(unsigned char), "buffer");
    37b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    37b7:	c7 44 24 04 84 97 00 	movl   $0x9784,0x4(%esp)
    37be:	00 
    37bf:	89 04 24             	mov    %eax,(%esp)
    37c2:	e8 8c ff ff ff       	call   3753 <mem_alloc>
    37c7:	8b 55 08             	mov    0x8(%ebp),%edx
    37ca:	89 42 04             	mov    %eax,0x4(%edx)
	bs->buf_size = size;
    37cd:	8b 45 08             	mov    0x8(%ebp),%eax
    37d0:	8b 55 0c             	mov    0xc(%ebp),%edx
    37d3:	89 50 08             	mov    %edx,0x8(%eax)
}
    37d6:	c9                   	leave  
    37d7:	c3                   	ret    

000037d8 <desalloc_buffer>:

void desalloc_buffer(Bit_stream_struc *bs)
{
    37d8:	55                   	push   %ebp
    37d9:	89 e5                	mov    %esp,%ebp
    37db:	83 ec 18             	sub    $0x18,%esp
	free(bs->buf);
    37de:	8b 45 08             	mov    0x8(%ebp),%eax
    37e1:	8b 40 04             	mov    0x4(%eax),%eax
    37e4:	89 04 24             	mov    %eax,(%esp)
    37e7:	e8 a2 f5 ff ff       	call   2d8e <free>
}
    37ec:	c9                   	leave  
    37ed:	c3                   	ret    

000037ee <open_bit_stream_r>:

void open_bit_stream_r(Bit_stream_struc *bs, char *bs_filenam, int size)
{
    37ee:	55                   	push   %ebp
    37ef:	89 e5                	mov    %esp,%ebp
    37f1:	83 ec 18             	sub    $0x18,%esp
	//register unsigned char flag = 1;

	if ((bs->pt = open(bs_filenam, O_RDWR)) == -1) {
    37f4:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    37fb:	00 
    37fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    37ff:	89 04 24             	mov    %eax,(%esp)
    3802:	e8 2c f2 ff ff       	call   2a33 <open>
    3807:	8b 55 08             	mov    0x8(%ebp),%edx
    380a:	89 02                	mov    %eax,(%edx)
    380c:	8b 45 08             	mov    0x8(%ebp),%eax
    380f:	8b 00                	mov    (%eax),%eax
    3811:	83 f8 ff             	cmp    $0xffffffff,%eax
    3814:	75 20                	jne    3836 <open_bit_stream_r+0x48>
		printf(0, "Could not find \"%s\".\n", bs_filenam);
    3816:	8b 45 0c             	mov    0xc(%ebp),%eax
    3819:	89 44 24 08          	mov    %eax,0x8(%esp)
    381d:	c7 44 24 04 8b 97 00 	movl   $0x978b,0x4(%esp)
    3824:	00 
    3825:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    382c:	e8 aa f3 ff ff       	call   2bdb <printf>
		exit();
    3831:	e8 bd f1 ff ff       	call   29f3 <exit>
	}

	bs->format = BINARY;
    3836:	8b 45 08             	mov    0x8(%ebp),%eax
    3839:	c6 40 24 00          	movb   $0x0,0x24(%eax)
	alloc_buffer(bs, size);
    383d:	8b 45 10             	mov    0x10(%ebp),%eax
    3840:	89 44 24 04          	mov    %eax,0x4(%esp)
    3844:	8b 45 08             	mov    0x8(%ebp),%eax
    3847:	89 04 24             	mov    %eax,(%esp)
    384a:	e8 5f ff ff ff       	call   37ae <alloc_buffer>
	bs->buf_byte_idx=0;
    384f:	8b 45 08             	mov    0x8(%ebp),%eax
    3852:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
	bs->buf_bit_idx=0;
    3859:	8b 45 08             	mov    0x8(%ebp),%eax
    385c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
	bs->totbit=0;
    3863:	8b 45 08             	mov    0x8(%ebp),%eax
    3866:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	bs->mode = READ_MODE;
    386d:	8b 45 08             	mov    0x8(%ebp),%eax
    3870:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
	bs->eob = FALSE;
    3877:	8b 45 08             	mov    0x8(%ebp),%eax
    387a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
	bs->eobs = FALSE;
    3881:	8b 45 08             	mov    0x8(%ebp),%eax
    3884:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
    388b:	c9                   	leave  
    388c:	c3                   	ret    

0000388d <close_bit_stream_r>:

void close_bit_stream_r(Bit_stream_struc *bs)
{
    388d:	55                   	push   %ebp
    388e:	89 e5                	mov    %esp,%ebp
    3890:	83 ec 18             	sub    $0x18,%esp
	close(bs->pt);
    3893:	8b 45 08             	mov    0x8(%ebp),%eax
    3896:	8b 00                	mov    (%eax),%eax
    3898:	89 04 24             	mov    %eax,(%esp)
    389b:	e8 7b f1 ff ff       	call   2a1b <close>
	desalloc_buffer(bs);
    38a0:	8b 45 08             	mov    0x8(%ebp),%eax
    38a3:	89 04 24             	mov    %eax,(%esp)
    38a6:	e8 2d ff ff ff       	call   37d8 <desalloc_buffer>
}
    38ab:	c9                   	leave  
    38ac:	c3                   	ret    

000038ad <end_bs>:

int end_bs(Bit_stream_struc *bs)
{
    38ad:	55                   	push   %ebp
    38ae:	89 e5                	mov    %esp,%ebp
  return(bs->eobs);
    38b0:	8b 45 08             	mov    0x8(%ebp),%eax
    38b3:	8b 40 20             	mov    0x20(%eax),%eax
}
    38b6:	5d                   	pop    %ebp
    38b7:	c3                   	ret    

000038b8 <sstell>:


unsigned long sstell(Bit_stream_struc *bs)
{
    38b8:	55                   	push   %ebp
    38b9:	89 e5                	mov    %esp,%ebp
  return(bs->totbit);
    38bb:	8b 45 08             	mov    0x8(%ebp),%eax
    38be:	8b 40 0c             	mov    0xc(%eax),%eax
}
    38c1:	5d                   	pop    %ebp
    38c2:	c3                   	ret    

000038c3 <refill_buffer>:


void refill_buffer(Bit_stream_struc *bs)
{
    38c3:	55                   	push   %ebp
    38c4:	89 e5                	mov    %esp,%ebp
    38c6:	56                   	push   %esi
    38c7:	53                   	push   %ebx
    38c8:	83 ec 10             	sub    $0x10,%esp
	register int i=bs->buf_size-2-bs->buf_byte_idx;
    38cb:	8b 45 08             	mov    0x8(%ebp),%eax
    38ce:	8b 40 08             	mov    0x8(%eax),%eax
    38d1:	8d 50 fe             	lea    -0x2(%eax),%edx
    38d4:	8b 45 08             	mov    0x8(%ebp),%eax
    38d7:	8b 40 10             	mov    0x10(%eax),%eax
    38da:	89 d3                	mov    %edx,%ebx
    38dc:	29 c3                	sub    %eax,%ebx
	register unsigned long n=1;
    38de:	be 01 00 00 00       	mov    $0x1,%esi

	while ((i>=0) && (!bs->eob)) {
    38e3:	eb 35                	jmp    391a <refill_buffer+0x57>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
    38e5:	8b 45 08             	mov    0x8(%ebp),%eax
    38e8:	8b 50 04             	mov    0x4(%eax),%edx
    38eb:	89 d8                	mov    %ebx,%eax
    38ed:	8d 58 ff             	lea    -0x1(%eax),%ebx
    38f0:	01 c2                	add    %eax,%edx
    38f2:	8b 45 08             	mov    0x8(%ebp),%eax
    38f5:	8b 00                	mov    (%eax),%eax
    38f7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    38fe:	00 
    38ff:	89 54 24 04          	mov    %edx,0x4(%esp)
    3903:	89 04 24             	mov    %eax,(%esp)
    3906:	e8 00 f1 ff ff       	call   2a0b <read>
    390b:	89 c6                	mov    %eax,%esi
		if (!n)
    390d:	85 f6                	test   %esi,%esi
    390f:	75 09                	jne    391a <refill_buffer+0x57>
		bs->eob= i+1;
    3911:	8d 53 01             	lea    0x1(%ebx),%edx
    3914:	8b 45 08             	mov    0x8(%ebp),%eax
    3917:	89 50 1c             	mov    %edx,0x1c(%eax)
void refill_buffer(Bit_stream_struc *bs)
{
	register int i=bs->buf_size-2-bs->buf_byte_idx;
	register unsigned long n=1;

	while ((i>=0) && (!bs->eob)) {
    391a:	85 db                	test   %ebx,%ebx
    391c:	78 0a                	js     3928 <refill_buffer+0x65>
    391e:	8b 45 08             	mov    0x8(%ebp),%eax
    3921:	8b 40 1c             	mov    0x1c(%eax),%eax
    3924:	85 c0                	test   %eax,%eax
    3926:	74 bd                	je     38e5 <refill_buffer+0x22>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
		if (!n)
		bs->eob= i+1;
	}
}
    3928:	83 c4 10             	add    $0x10,%esp
    392b:	5b                   	pop    %ebx
    392c:	5e                   	pop    %esi
    392d:	5d                   	pop    %ebp
    392e:	c3                   	ret    

0000392f <get1bit>:


int mask[8]={0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80};

unsigned int get1bit(Bit_stream_struc *bs)
{
    392f:	55                   	push   %ebp
    3930:	89 e5                	mov    %esp,%ebp
    3932:	53                   	push   %ebx
    3933:	83 ec 24             	sub    $0x24,%esp
   unsigned int bit;
   register int i;

   bs->totbit++;
    3936:	8b 45 08             	mov    0x8(%ebp),%eax
    3939:	8b 40 0c             	mov    0xc(%eax),%eax
    393c:	8d 50 01             	lea    0x1(%eax),%edx
    393f:	8b 45 08             	mov    0x8(%ebp),%eax
    3942:	89 50 0c             	mov    %edx,0xc(%eax)

   if (!bs->buf_bit_idx) {
    3945:	8b 45 08             	mov    0x8(%ebp),%eax
    3948:	8b 40 14             	mov    0x14(%eax),%eax
    394b:	85 c0                	test   %eax,%eax
    394d:	0f 85 9f 00 00 00    	jne    39f2 <get1bit+0xc3>
        bs->buf_bit_idx = 8;
    3953:	8b 45 08             	mov    0x8(%ebp),%eax
    3956:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
        bs->buf_byte_idx--;
    395d:	8b 45 08             	mov    0x8(%ebp),%eax
    3960:	8b 40 10             	mov    0x10(%eax),%eax
    3963:	8d 50 ff             	lea    -0x1(%eax),%edx
    3966:	8b 45 08             	mov    0x8(%ebp),%eax
    3969:	89 50 10             	mov    %edx,0x10(%eax)
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    396c:	8b 45 08             	mov    0x8(%ebp),%eax
    396f:	8b 40 10             	mov    0x10(%eax),%eax
    3972:	83 f8 03             	cmp    $0x3,%eax
    3975:	7e 10                	jle    3987 <get1bit+0x58>
    3977:	8b 45 08             	mov    0x8(%ebp),%eax
    397a:	8b 50 10             	mov    0x10(%eax),%edx
    397d:	8b 45 08             	mov    0x8(%ebp),%eax
    3980:	8b 40 1c             	mov    0x1c(%eax),%eax
    3983:	39 c2                	cmp    %eax,%edx
    3985:	7d 6b                	jge    39f2 <get1bit+0xc3>
             if (bs->eob)
    3987:	8b 45 08             	mov    0x8(%ebp),%eax
    398a:	8b 40 1c             	mov    0x1c(%eax),%eax
    398d:	85 c0                	test   %eax,%eax
    398f:	74 0c                	je     399d <get1bit+0x6e>
                bs->eobs = TRUE;
    3991:	8b 45 08             	mov    0x8(%ebp),%eax
    3994:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    399b:	eb 55                	jmp    39f2 <get1bit+0xc3>
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    399d:	8b 45 08             	mov    0x8(%ebp),%eax
    39a0:	8b 58 10             	mov    0x10(%eax),%ebx
    39a3:	eb 2f                	jmp    39d4 <get1bit+0xa5>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    39a5:	8b 45 08             	mov    0x8(%ebp),%eax
    39a8:	8b 50 04             	mov    0x4(%eax),%edx
    39ab:	8b 45 08             	mov    0x8(%ebp),%eax
    39ae:	8b 40 08             	mov    0x8(%eax),%eax
    39b1:	8d 48 ff             	lea    -0x1(%eax),%ecx
    39b4:	8b 45 08             	mov    0x8(%ebp),%eax
    39b7:	8b 40 10             	mov    0x10(%eax),%eax
    39ba:	29 c1                	sub    %eax,%ecx
    39bc:	89 c8                	mov    %ecx,%eax
    39be:	01 d8                	add    %ebx,%eax
    39c0:	01 c2                	add    %eax,%edx
    39c2:	8b 45 08             	mov    0x8(%ebp),%eax
    39c5:	8b 48 04             	mov    0x4(%eax),%ecx
    39c8:	89 d8                	mov    %ebx,%eax
    39ca:	01 c8                	add    %ecx,%eax
    39cc:	0f b6 00             	movzbl (%eax),%eax
    39cf:	88 02                	mov    %al,(%edx)
        bs->buf_byte_idx--;
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
             if (bs->eob)
                bs->eobs = TRUE;
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    39d1:	83 eb 01             	sub    $0x1,%ebx
    39d4:	85 db                	test   %ebx,%ebx
    39d6:	79 cd                	jns    39a5 <get1bit+0x76>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
                refill_buffer(bs);
    39d8:	8b 45 08             	mov    0x8(%ebp),%eax
    39db:	89 04 24             	mov    %eax,(%esp)
    39de:	e8 e0 fe ff ff       	call   38c3 <refill_buffer>
                bs->buf_byte_idx = bs->buf_size-1;
    39e3:	8b 45 08             	mov    0x8(%ebp),%eax
    39e6:	8b 40 08             	mov    0x8(%eax),%eax
    39e9:	8d 50 ff             	lea    -0x1(%eax),%edx
    39ec:	8b 45 08             	mov    0x8(%ebp),%eax
    39ef:	89 50 10             	mov    %edx,0x10(%eax)
             }
        }
   }
   bit = bs->buf[bs->buf_byte_idx]&mask[bs->buf_bit_idx-1];
    39f2:	8b 45 08             	mov    0x8(%ebp),%eax
    39f5:	8b 50 04             	mov    0x4(%eax),%edx
    39f8:	8b 45 08             	mov    0x8(%ebp),%eax
    39fb:	8b 40 10             	mov    0x10(%eax),%eax
    39fe:	01 d0                	add    %edx,%eax
    3a00:	0f b6 00             	movzbl (%eax),%eax
    3a03:	0f b6 d0             	movzbl %al,%edx
    3a06:	8b 45 08             	mov    0x8(%ebp),%eax
    3a09:	8b 40 14             	mov    0x14(%eax),%eax
    3a0c:	83 e8 01             	sub    $0x1,%eax
    3a0f:	8b 04 85 e0 cd 00 00 	mov    0xcde0(,%eax,4),%eax
    3a16:	21 d0                	and    %edx,%eax
    3a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
   bit = bit >> (bs->buf_bit_idx-1);
    3a1b:	8b 45 08             	mov    0x8(%ebp),%eax
    3a1e:	8b 40 14             	mov    0x14(%eax),%eax
    3a21:	83 e8 01             	sub    $0x1,%eax
    3a24:	89 c1                	mov    %eax,%ecx
    3a26:	d3 6d f4             	shrl   %cl,-0xc(%ebp)
   bs->buf_bit_idx--;
    3a29:	8b 45 08             	mov    0x8(%ebp),%eax
    3a2c:	8b 40 14             	mov    0x14(%eax),%eax
    3a2f:	8d 50 ff             	lea    -0x1(%eax),%edx
    3a32:	8b 45 08             	mov    0x8(%ebp),%eax
    3a35:	89 50 14             	mov    %edx,0x14(%eax)
   return(bit);
    3a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    3a3b:	83 c4 24             	add    $0x24,%esp
    3a3e:	5b                   	pop    %ebx
    3a3f:	5d                   	pop    %ebp
    3a40:	c3                   	ret    

00003a41 <getbits>:

int putmask[9]={0x0, 0x1, 0x3, 0x7, 0xf, 0x1f, 0x3f, 0x7f, 0xff};

unsigned long getbits(Bit_stream_struc *bs, int N)
{
    3a41:	55                   	push   %ebp
    3a42:	89 e5                	mov    %esp,%ebp
    3a44:	57                   	push   %edi
    3a45:	56                   	push   %esi
    3a46:	53                   	push   %ebx
    3a47:	83 ec 2c             	sub    $0x2c,%esp
	unsigned long val=0;
    3a4a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	register int i;
	register int j = N;
    3a51:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	register int k, tmp;

	if (N > MAX_LENGTH)
    3a54:	83 7d 0c 20          	cmpl   $0x20,0xc(%ebp)
    3a58:	7e 1c                	jle    3a76 <getbits+0x35>
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);
    3a5a:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
    3a61:	00 
    3a62:	c7 44 24 04 a4 97 00 	movl   $0x97a4,0x4(%esp)
    3a69:	00 
    3a6a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3a71:	e8 65 f1 ff ff       	call   2bdb <printf>

	bs->totbit += N;
    3a76:	8b 45 08             	mov    0x8(%ebp),%eax
    3a79:	8b 50 0c             	mov    0xc(%eax),%edx
    3a7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a7f:	01 c2                	add    %eax,%edx
    3a81:	8b 45 08             	mov    0x8(%ebp),%eax
    3a84:	89 50 0c             	mov    %edx,0xc(%eax)
	while (j > 0) {
    3a87:	e9 0a 01 00 00       	jmp    3b96 <getbits+0x155>
		if (!bs->buf_bit_idx) {
    3a8c:	8b 45 08             	mov    0x8(%ebp),%eax
    3a8f:	8b 40 14             	mov    0x14(%eax),%eax
    3a92:	85 c0                	test   %eax,%eax
    3a94:	0f 85 9f 00 00 00    	jne    3b39 <getbits+0xf8>
			bs->buf_bit_idx = 8;
    3a9a:	8b 45 08             	mov    0x8(%ebp),%eax
    3a9d:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
			bs->buf_byte_idx--;
    3aa4:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa7:	8b 40 10             	mov    0x10(%eax),%eax
    3aaa:	8d 50 ff             	lea    -0x1(%eax),%edx
    3aad:	8b 45 08             	mov    0x8(%ebp),%eax
    3ab0:	89 50 10             	mov    %edx,0x10(%eax)
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    3ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    3ab6:	8b 40 10             	mov    0x10(%eax),%eax
    3ab9:	83 f8 03             	cmp    $0x3,%eax
    3abc:	7e 10                	jle    3ace <getbits+0x8d>
    3abe:	8b 45 08             	mov    0x8(%ebp),%eax
    3ac1:	8b 50 10             	mov    0x10(%eax),%edx
    3ac4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ac7:	8b 40 1c             	mov    0x1c(%eax),%eax
    3aca:	39 c2                	cmp    %eax,%edx
    3acc:	7d 6b                	jge    3b39 <getbits+0xf8>
				if (bs->eob)
    3ace:	8b 45 08             	mov    0x8(%ebp),%eax
    3ad1:	8b 40 1c             	mov    0x1c(%eax),%eax
    3ad4:	85 c0                	test   %eax,%eax
    3ad6:	74 0c                	je     3ae4 <getbits+0xa3>
					bs->eobs = TRUE;
    3ad8:	8b 45 08             	mov    0x8(%ebp),%eax
    3adb:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    3ae2:	eb 55                	jmp    3b39 <getbits+0xf8>
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    3ae4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ae7:	8b 70 10             	mov    0x10(%eax),%esi
    3aea:	eb 2f                	jmp    3b1b <getbits+0xda>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    3aec:	8b 45 08             	mov    0x8(%ebp),%eax
    3aef:	8b 50 04             	mov    0x4(%eax),%edx
    3af2:	8b 45 08             	mov    0x8(%ebp),%eax
    3af5:	8b 40 08             	mov    0x8(%eax),%eax
    3af8:	8d 48 ff             	lea    -0x1(%eax),%ecx
    3afb:	8b 45 08             	mov    0x8(%ebp),%eax
    3afe:	8b 40 10             	mov    0x10(%eax),%eax
    3b01:	29 c1                	sub    %eax,%ecx
    3b03:	89 c8                	mov    %ecx,%eax
    3b05:	01 f0                	add    %esi,%eax
    3b07:	01 c2                	add    %eax,%edx
    3b09:	8b 45 08             	mov    0x8(%ebp),%eax
    3b0c:	8b 48 04             	mov    0x4(%eax),%ecx
    3b0f:	89 f0                	mov    %esi,%eax
    3b11:	01 c8                	add    %ecx,%eax
    3b13:	0f b6 00             	movzbl (%eax),%eax
    3b16:	88 02                	mov    %al,(%edx)
			bs->buf_byte_idx--;
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
				if (bs->eob)
					bs->eobs = TRUE;
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    3b18:	83 ee 01             	sub    $0x1,%esi
    3b1b:	85 f6                	test   %esi,%esi
    3b1d:	79 cd                	jns    3aec <getbits+0xab>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
						refill_buffer(bs);
    3b1f:	8b 45 08             	mov    0x8(%ebp),%eax
    3b22:	89 04 24             	mov    %eax,(%esp)
    3b25:	e8 99 fd ff ff       	call   38c3 <refill_buffer>
					bs->buf_byte_idx = bs->buf_size-1;
    3b2a:	8b 45 08             	mov    0x8(%ebp),%eax
    3b2d:	8b 40 08             	mov    0x8(%eax),%eax
    3b30:	8d 50 ff             	lea    -0x1(%eax),%edx
    3b33:	8b 45 08             	mov    0x8(%ebp),%eax
    3b36:	89 50 10             	mov    %edx,0x10(%eax)
				}
			}
		}
		k = MIN(j, bs->buf_bit_idx);
    3b39:	8b 45 08             	mov    0x8(%ebp),%eax
    3b3c:	8b 40 14             	mov    0x14(%eax),%eax
    3b3f:	39 d8                	cmp    %ebx,%eax
    3b41:	0f 4f c3             	cmovg  %ebx,%eax
    3b44:	89 c6                	mov    %eax,%esi
		tmp = bs->buf[bs->buf_byte_idx]&putmask[bs->buf_bit_idx];
    3b46:	8b 45 08             	mov    0x8(%ebp),%eax
    3b49:	8b 50 04             	mov    0x4(%eax),%edx
    3b4c:	8b 45 08             	mov    0x8(%ebp),%eax
    3b4f:	8b 40 10             	mov    0x10(%eax),%eax
    3b52:	01 d0                	add    %edx,%eax
    3b54:	0f b6 00             	movzbl (%eax),%eax
    3b57:	0f b6 d0             	movzbl %al,%edx
    3b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    3b5d:	8b 40 14             	mov    0x14(%eax),%eax
    3b60:	8b 04 85 00 ce 00 00 	mov    0xce00(,%eax,4),%eax
    3b67:	89 d7                	mov    %edx,%edi
    3b69:	21 c7                	and    %eax,%edi
		tmp = tmp >> (bs->buf_bit_idx-k);
    3b6b:	8b 45 08             	mov    0x8(%ebp),%eax
    3b6e:	8b 40 14             	mov    0x14(%eax),%eax
    3b71:	29 f0                	sub    %esi,%eax
    3b73:	89 c1                	mov    %eax,%ecx
    3b75:	d3 ff                	sar    %cl,%edi
		val |= tmp << (j-k);
    3b77:	89 d8                	mov    %ebx,%eax
    3b79:	29 f0                	sub    %esi,%eax
    3b7b:	89 c1                	mov    %eax,%ecx
    3b7d:	d3 e7                	shl    %cl,%edi
    3b7f:	89 f8                	mov    %edi,%eax
    3b81:	09 45 e4             	or     %eax,-0x1c(%ebp)
		bs->buf_bit_idx -= k;
    3b84:	8b 45 08             	mov    0x8(%ebp),%eax
    3b87:	8b 40 14             	mov    0x14(%eax),%eax
    3b8a:	29 f0                	sub    %esi,%eax
    3b8c:	89 c2                	mov    %eax,%edx
    3b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    3b91:	89 50 14             	mov    %edx,0x14(%eax)
		j -= k;
    3b94:	29 f3                	sub    %esi,%ebx

	if (N > MAX_LENGTH)
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);

	bs->totbit += N;
	while (j > 0) {
    3b96:	85 db                	test   %ebx,%ebx
    3b98:	0f 8f ee fe ff ff    	jg     3a8c <getbits+0x4b>
		tmp = tmp >> (bs->buf_bit_idx-k);
		val |= tmp << (j-k);
		bs->buf_bit_idx -= k;
		j -= k;
	}
	return val;
    3b9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    3ba1:	83 c4 2c             	add    $0x2c,%esp
    3ba4:	5b                   	pop    %ebx
    3ba5:	5e                   	pop    %esi
    3ba6:	5f                   	pop    %edi
    3ba7:	5d                   	pop    %ebp
    3ba8:	c3                   	ret    

00003ba9 <seek_sync>:


int seek_sync(Bit_stream_struc *bs, unsigned long sync, int N)
{
    3ba9:	55                   	push   %ebp
    3baa:	89 e5                	mov    %esp,%ebp
    3bac:	83 ec 38             	sub    $0x38,%esp
	unsigned long aligning;
	unsigned long val;
	long maxi = (int)pow(2.0, (double)N) - 1;
    3baf:	db 45 10             	fildl  0x10(%ebp)
    3bb2:	dd 5c 24 08          	fstpl  0x8(%esp)
    3bb6:	dd 05 10 98 00 00    	fldl   0x9810
    3bbc:	dd 1c 24             	fstpl  (%esp)
    3bbf:	e8 ec f4 ff ff       	call   30b0 <pow>
    3bc4:	d9 7d e6             	fnstcw -0x1a(%ebp)
    3bc7:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    3bcb:	b4 0c                	mov    $0xc,%ah
    3bcd:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    3bd1:	d9 6d e4             	fldcw  -0x1c(%ebp)
    3bd4:	db 5d e0             	fistpl -0x20(%ebp)
    3bd7:	d9 6d e6             	fldcw  -0x1a(%ebp)
    3bda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3bdd:	83 e8 01             	sub    $0x1,%eax
    3be0:	89 45 f0             	mov    %eax,-0x10(%ebp)

	aligning = sstell(bs)%ALIGNING;
    3be3:	8b 45 08             	mov    0x8(%ebp),%eax
    3be6:	89 04 24             	mov    %eax,(%esp)
    3be9:	e8 ca fc ff ff       	call   38b8 <sstell>
    3bee:	83 e0 07             	and    $0x7,%eax
    3bf1:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if (aligning)
    3bf4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3bf8:	74 17                	je     3c11 <seek_sync+0x68>
		getbits(bs, (int)(ALIGNING-aligning));
    3bfa:	b8 08 00 00 00       	mov    $0x8,%eax
    3bff:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3c02:	89 44 24 04          	mov    %eax,0x4(%esp)
    3c06:	8b 45 08             	mov    0x8(%ebp),%eax
    3c09:	89 04 24             	mov    %eax,(%esp)
    3c0c:	e8 30 fe ff ff       	call   3a41 <getbits>

	val = getbits(bs, N);
    3c11:	8b 45 10             	mov    0x10(%ebp),%eax
    3c14:	89 44 24 04          	mov    %eax,0x4(%esp)
    3c18:	8b 45 08             	mov    0x8(%ebp),%eax
    3c1b:	89 04 24             	mov    %eax,(%esp)
    3c1e:	e8 1e fe ff ff       	call   3a41 <getbits>
    3c23:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    3c26:	eb 1a                	jmp    3c42 <seek_sync+0x99>
		val <<= ALIGNING;
    3c28:	c1 65 f4 08          	shll   $0x8,-0xc(%ebp)
		val |= getbits(bs, ALIGNING);
    3c2c:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    3c33:	00 
    3c34:	8b 45 08             	mov    0x8(%ebp),%eax
    3c37:	89 04 24             	mov    %eax,(%esp)
    3c3a:	e8 02 fe ff ff       	call   3a41 <getbits>
    3c3f:	09 45 f4             	or     %eax,-0xc(%ebp)
	aligning = sstell(bs)%ALIGNING;
	if (aligning)
		getbits(bs, (int)(ALIGNING-aligning));

	val = getbits(bs, N);
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    3c42:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3c45:	23 45 f4             	and    -0xc(%ebp),%eax
    3c48:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3c4b:	74 0f                	je     3c5c <seek_sync+0xb3>
    3c4d:	8b 45 08             	mov    0x8(%ebp),%eax
    3c50:	89 04 24             	mov    %eax,(%esp)
    3c53:	e8 55 fc ff ff       	call   38ad <end_bs>
    3c58:	85 c0                	test   %eax,%eax
    3c5a:	74 cc                	je     3c28 <seek_sync+0x7f>
		val <<= ALIGNING;
		val |= getbits(bs, ALIGNING);
	}

	if (end_bs(bs))
    3c5c:	8b 45 08             	mov    0x8(%ebp),%eax
    3c5f:	89 04 24             	mov    %eax,(%esp)
    3c62:	e8 46 fc ff ff       	call   38ad <end_bs>
    3c67:	85 c0                	test   %eax,%eax
    3c69:	74 07                	je     3c72 <seek_sync+0xc9>
		return(0);
    3c6b:	b8 00 00 00 00       	mov    $0x0,%eax
    3c70:	eb 05                	jmp    3c77 <seek_sync+0xce>
	else
		return(1);
    3c72:	b8 01 00 00 00       	mov    $0x1,%eax
}
    3c77:	c9                   	leave  
    3c78:	c3                   	ret    

00003c79 <js_bound>:

int js_bound(int lay, int m_ext)
{
    3c79:	55                   	push   %ebp
    3c7a:	89 e5                	mov    %esp,%ebp
    3c7c:	83 ec 18             	sub    $0x18,%esp
		{ 4, 8, 12, 16 },
		{ 4, 8, 12, 16},
		{ 0, 4, 8, 16}
	};  /* lay+m_e -> jsbound */

    if(lay<1 || lay >3 || m_ext<0 || m_ext>3) {
    3c7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    3c83:	7e 12                	jle    3c97 <js_bound+0x1e>
    3c85:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    3c89:	7f 0c                	jg     3c97 <js_bound+0x1e>
    3c8b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3c8f:	78 06                	js     3c97 <js_bound+0x1e>
    3c91:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
    3c95:	7e 27                	jle    3cbe <js_bound+0x45>
        printf(0, "js_bound bad layer/modext (%d/%d)\n", lay, m_ext);
    3c97:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c9a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3c9e:	8b 45 08             	mov    0x8(%ebp),%eax
    3ca1:	89 44 24 08          	mov    %eax,0x8(%esp)
    3ca5:	c7 44 24 04 d8 97 00 	movl   $0x97d8,0x4(%esp)
    3cac:	00 
    3cad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3cb4:	e8 22 ef ff ff       	call   2bdb <printf>
        exit();
    3cb9:	e8 35 ed ff ff       	call   29f3 <exit>
    }
	return(jsb_table[lay-1][m_ext]);
    3cbe:	8b 45 08             	mov    0x8(%ebp),%eax
    3cc1:	83 e8 01             	sub    $0x1,%eax
    3cc4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cce:	01 d0                	add    %edx,%eax
    3cd0:	8b 04 85 40 ce 00 00 	mov    0xce40(,%eax,4),%eax
}
    3cd7:	c9                   	leave  
    3cd8:	c3                   	ret    

00003cd9 <hdr_to_frps>:

void hdr_to_frps(struct frame_params *fr_ps)
{
    3cd9:	55                   	push   %ebp
    3cda:	89 e5                	mov    %esp,%ebp
    3cdc:	83 ec 28             	sub    $0x28,%esp
	layer *hdr = fr_ps->header;     /* (or pass in as arg?) */
    3cdf:	8b 45 08             	mov    0x8(%ebp),%eax
    3ce2:	8b 00                	mov    (%eax),%eax
    3ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)

	fr_ps->actual_mode = hdr->mode;
    3ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3cea:	8b 50 1c             	mov    0x1c(%eax),%edx
    3ced:	8b 45 08             	mov    0x8(%ebp),%eax
    3cf0:	89 50 04             	mov    %edx,0x4(%eax)
	fr_ps->stereo = (hdr->mode == MPG_MD_MONO) ? 1 : 2;
    3cf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3cf6:	8b 40 1c             	mov    0x1c(%eax),%eax
    3cf9:	83 f8 03             	cmp    $0x3,%eax
    3cfc:	75 07                	jne    3d05 <hdr_to_frps+0x2c>
    3cfe:	b8 01 00 00 00       	mov    $0x1,%eax
    3d03:	eb 05                	jmp    3d0a <hdr_to_frps+0x31>
    3d05:	b8 02 00 00 00       	mov    $0x2,%eax
    3d0a:	8b 55 08             	mov    0x8(%ebp),%edx
    3d0d:	89 42 08             	mov    %eax,0x8(%edx)
	fr_ps->sblimit = SBLIMIT;
    3d10:	8b 45 08             	mov    0x8(%ebp),%eax
    3d13:	c7 40 10 20 00 00 00 	movl   $0x20,0x10(%eax)
	if(hdr->mode == MPG_MD_JOINT_STEREO)
    3d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d1d:	8b 40 1c             	mov    0x1c(%eax),%eax
    3d20:	83 f8 01             	cmp    $0x1,%eax
    3d23:	75 20                	jne    3d45 <hdr_to_frps+0x6c>
		fr_ps->jsbound = js_bound(hdr->lay, hdr->mode_ext);
    3d25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d28:	8b 50 20             	mov    0x20(%eax),%edx
    3d2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d2e:	8b 40 04             	mov    0x4(%eax),%eax
    3d31:	89 54 24 04          	mov    %edx,0x4(%esp)
    3d35:	89 04 24             	mov    %eax,(%esp)
    3d38:	e8 3c ff ff ff       	call   3c79 <js_bound>
    3d3d:	8b 55 08             	mov    0x8(%ebp),%edx
    3d40:	89 42 0c             	mov    %eax,0xc(%edx)
    3d43:	eb 0c                	jmp    3d51 <hdr_to_frps+0x78>
	else
		fr_ps->jsbound = fr_ps->sblimit;
    3d45:	8b 45 08             	mov    0x8(%ebp),%eax
    3d48:	8b 50 10             	mov    0x10(%eax),%edx
    3d4b:	8b 45 08             	mov    0x8(%ebp),%eax
    3d4e:	89 50 0c             	mov    %edx,0xc(%eax)
}
    3d51:	c9                   	leave  
    3d52:	c3                   	ret    

00003d53 <hputbuf>:

void hputbuf(unsigned int val, int N)
{
    3d53:	55                   	push   %ebp
    3d54:	89 e5                	mov    %esp,%ebp
    3d56:	83 ec 18             	sub    $0x18,%esp
	if (N != 8) {
    3d59:	83 7d 0c 08          	cmpl   $0x8,0xc(%ebp)
    3d5d:	74 19                	je     3d78 <hputbuf+0x25>
		printf(0,"Not Supported yet!!\n");
    3d5f:	c7 44 24 04 fb 97 00 	movl   $0x97fb,0x4(%esp)
    3d66:	00 
    3d67:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d6e:	e8 68 ee ff ff       	call   2bdb <printf>
		exit();
    3d73:	e8 7b ec ff ff       	call   29f3 <exit>
	}
	getCoreBuf(1, val);
    3d78:	8b 45 08             	mov    0x8(%ebp),%eax
    3d7b:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d7f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d86:	e8 68 ed ff ff       	call   2af3 <getCoreBuf>
//	buf[offset % BUFSIZE] = val;
//	offset++;
}
    3d8b:	c9                   	leave  
    3d8c:	c3                   	ret    

00003d8d <hsstell>:

unsigned long hsstell()
{
    3d8d:	55                   	push   %ebp
    3d8e:	89 e5                	mov    %esp,%ebp
    3d90:	83 ec 18             	sub    $0x18,%esp
	return getCoreBuf(2, 0);
    3d93:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3d9a:	00 
    3d9b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    3da2:	e8 4c ed ff ff       	call   2af3 <getCoreBuf>
//	return(totbit);
}
    3da7:	c9                   	leave  
    3da8:	c3                   	ret    

00003da9 <hgetbits>:

unsigned long hgetbits(int N)
{
    3da9:	55                   	push   %ebp
    3daa:	89 e5                	mov    %esp,%ebp
    3dac:	83 ec 18             	sub    $0x18,%esp

	return getCoreBuf(3, N);
    3daf:	8b 45 08             	mov    0x8(%ebp),%eax
    3db2:	89 44 24 04          	mov    %eax,0x4(%esp)
    3db6:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    3dbd:	e8 31 ed ff ff       	call   2af3 <getCoreBuf>
}
    3dc2:	c9                   	leave  
    3dc3:	c3                   	ret    

00003dc4 <hget1bit>:


unsigned int hget1bit()
{
    3dc4:	55                   	push   %ebp
    3dc5:	89 e5                	mov    %esp,%ebp
    3dc7:	83 ec 18             	sub    $0x18,%esp
	return(hgetbits(1));
    3dca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3dd1:	e8 d3 ff ff ff       	call   3da9 <hgetbits>
}
    3dd6:	c9                   	leave  
    3dd7:	c3                   	ret    

00003dd8 <rewindNbits>:


void rewindNbits(int N)
{
    3dd8:	55                   	push   %ebp
    3dd9:	89 e5                	mov    %esp,%ebp
    3ddb:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(4, N);
    3dde:	8b 45 08             	mov    0x8(%ebp),%eax
    3de1:	89 44 24 04          	mov    %eax,0x4(%esp)
    3de5:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
    3dec:	e8 02 ed ff ff       	call   2af3 <getCoreBuf>
}
    3df1:	c9                   	leave  
    3df2:	c3                   	ret    

00003df3 <rewindNbytes>:


void rewindNbytes(int N)
{
    3df3:	55                   	push   %ebp
    3df4:	89 e5                	mov    %esp,%ebp
    3df6:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(5, N);
    3df9:	8b 45 08             	mov    0x8(%ebp),%eax
    3dfc:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e00:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    3e07:	e8 e7 ec ff ff       	call   2af3 <getCoreBuf>
}
    3e0c:	c9                   	leave  
    3e0d:	c3                   	ret    

00003e0e <read_decoder_table>:
				/* 0..31 Huffman code table 0..31	*/
				/* 32,33 count1-tables			*/

/* ��ȡ huffman ����� */
void read_decoder_table() 
{
    3e0e:	55                   	push   %ebp
    3e0f:	89 e5                	mov    %esp,%ebp
    3e11:	57                   	push   %edi
    3e12:	56                   	push   %esi
    3e13:	53                   	push   %ebx
    3e14:	81 ec 40 1b 00 00    	sub    $0x1b40,%esp
	unsigned char h1[7][2] = {{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11}};
    3e1a:	c6 45 e6 02          	movb   $0x2,-0x1a(%ebp)
    3e1e:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
    3e22:	c6 45 e8 00          	movb   $0x0,-0x18(%ebp)
    3e26:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    3e2a:	c6 45 ea 02          	movb   $0x2,-0x16(%ebp)
    3e2e:	c6 45 eb 01          	movb   $0x1,-0x15(%ebp)
    3e32:	c6 45 ec 00          	movb   $0x0,-0x14(%ebp)
    3e36:	c6 45 ed 10          	movb   $0x10,-0x13(%ebp)
    3e3a:	c6 45 ee 02          	movb   $0x2,-0x12(%ebp)
    3e3e:	c6 45 ef 01          	movb   $0x1,-0x11(%ebp)
    3e42:	c6 45 f0 00          	movb   $0x0,-0x10(%ebp)
    3e46:	c6 45 f1 01          	movb   $0x1,-0xf(%ebp)
    3e4a:	c6 45 f2 00          	movb   $0x0,-0xe(%ebp)
    3e4e:	c6 45 f3 11          	movb   $0x11,-0xd(%ebp)

	unsigned char h2[17][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    3e52:	c6 45 c4 02          	movb   $0x2,-0x3c(%ebp)
    3e56:	c6 45 c5 01          	movb   $0x1,-0x3b(%ebp)
    3e5a:	c6 45 c6 00          	movb   $0x0,-0x3a(%ebp)
    3e5e:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
    3e62:	c6 45 c8 04          	movb   $0x4,-0x38(%ebp)
    3e66:	c6 45 c9 01          	movb   $0x1,-0x37(%ebp)
    3e6a:	c6 45 ca 02          	movb   $0x2,-0x36(%ebp)
    3e6e:	c6 45 cb 01          	movb   $0x1,-0x35(%ebp)
    3e72:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
    3e76:	c6 45 cd 10          	movb   $0x10,-0x33(%ebp)
    3e7a:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    3e7e:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
    3e82:	c6 45 d0 02          	movb   $0x2,-0x30(%ebp)
    3e86:	c6 45 d1 01          	movb   $0x1,-0x2f(%ebp)
    3e8a:	c6 45 d2 00          	movb   $0x0,-0x2e(%ebp)
    3e8e:	c6 45 d3 11          	movb   $0x11,-0x2d(%ebp)
    3e92:	c6 45 d4 04          	movb   $0x4,-0x2c(%ebp)
    3e96:	c6 45 d5 01          	movb   $0x1,-0x2b(%ebp)
    3e9a:	c6 45 d6 02          	movb   $0x2,-0x2a(%ebp)
    3e9e:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
    3ea2:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
    3ea6:	c6 45 d9 20          	movb   $0x20,-0x27(%ebp)
    3eaa:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    3eae:	c6 45 db 21          	movb   $0x21,-0x25(%ebp)
    3eb2:	c6 45 dc 02          	movb   $0x2,-0x24(%ebp)
    3eb6:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
    3eba:	c6 45 de 00          	movb   $0x0,-0x22(%ebp)
    3ebe:	c6 45 df 12          	movb   $0x12,-0x21(%ebp)
    3ec2:	c6 45 e0 02          	movb   $0x2,-0x20(%ebp)
    3ec6:	c6 45 e1 01          	movb   $0x1,-0x1f(%ebp)
    3eca:	c6 45 e2 00          	movb   $0x0,-0x1e(%ebp)
    3ece:	c6 45 e3 02          	movb   $0x2,-0x1d(%ebp)
    3ed2:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
    3ed6:	c6 45 e5 22          	movb   $0x22,-0x1b(%ebp)

	unsigned char h3[17][2] = {{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x10},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    3eda:	c6 45 a2 04          	movb   $0x4,-0x5e(%ebp)
    3ede:	c6 45 a3 01          	movb   $0x1,-0x5d(%ebp)
    3ee2:	c6 45 a4 02          	movb   $0x2,-0x5c(%ebp)
    3ee6:	c6 45 a5 01          	movb   $0x1,-0x5b(%ebp)
    3eea:	c6 45 a6 00          	movb   $0x0,-0x5a(%ebp)
    3eee:	c6 45 a7 00          	movb   $0x0,-0x59(%ebp)
    3ef2:	c6 45 a8 00          	movb   $0x0,-0x58(%ebp)
    3ef6:	c6 45 a9 01          	movb   $0x1,-0x57(%ebp)
    3efa:	c6 45 aa 02          	movb   $0x2,-0x56(%ebp)
    3efe:	c6 45 ab 01          	movb   $0x1,-0x55(%ebp)
    3f02:	c6 45 ac 00          	movb   $0x0,-0x54(%ebp)
    3f06:	c6 45 ad 11          	movb   $0x11,-0x53(%ebp)
    3f0a:	c6 45 ae 02          	movb   $0x2,-0x52(%ebp)
    3f0e:	c6 45 af 01          	movb   $0x1,-0x51(%ebp)
    3f12:	c6 45 b0 00          	movb   $0x0,-0x50(%ebp)
    3f16:	c6 45 b1 10          	movb   $0x10,-0x4f(%ebp)
    3f1a:	c6 45 b2 04          	movb   $0x4,-0x4e(%ebp)
    3f1e:	c6 45 b3 01          	movb   $0x1,-0x4d(%ebp)
    3f22:	c6 45 b4 02          	movb   $0x2,-0x4c(%ebp)
    3f26:	c6 45 b5 01          	movb   $0x1,-0x4b(%ebp)
    3f2a:	c6 45 b6 00          	movb   $0x0,-0x4a(%ebp)
    3f2e:	c6 45 b7 20          	movb   $0x20,-0x49(%ebp)
    3f32:	c6 45 b8 00          	movb   $0x0,-0x48(%ebp)
    3f36:	c6 45 b9 21          	movb   $0x21,-0x47(%ebp)
    3f3a:	c6 45 ba 02          	movb   $0x2,-0x46(%ebp)
    3f3e:	c6 45 bb 01          	movb   $0x1,-0x45(%ebp)
    3f42:	c6 45 bc 00          	movb   $0x0,-0x44(%ebp)
    3f46:	c6 45 bd 12          	movb   $0x12,-0x43(%ebp)
    3f4a:	c6 45 be 02          	movb   $0x2,-0x42(%ebp)
    3f4e:	c6 45 bf 01          	movb   $0x1,-0x41(%ebp)
    3f52:	c6 45 c0 00          	movb   $0x0,-0x40(%ebp)
    3f56:	c6 45 c1 02          	movb   $0x2,-0x3f(%ebp)
    3f5a:	c6 45 c2 00          	movb   $0x0,-0x3e(%ebp)
    3f5e:	c6 45 c3 22          	movb   $0x22,-0x3d(%ebp)

	unsigned char h5[31][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x13},{0x2,0x1},{0x0,0x31},{0x2,0x1},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x33}};
    3f62:	c6 85 64 ff ff ff 02 	movb   $0x2,-0x9c(%ebp)
    3f69:	c6 85 65 ff ff ff 01 	movb   $0x1,-0x9b(%ebp)
    3f70:	c6 85 66 ff ff ff 00 	movb   $0x0,-0x9a(%ebp)
    3f77:	c6 85 67 ff ff ff 00 	movb   $0x0,-0x99(%ebp)
    3f7e:	c6 85 68 ff ff ff 04 	movb   $0x4,-0x98(%ebp)
    3f85:	c6 85 69 ff ff ff 01 	movb   $0x1,-0x97(%ebp)
    3f8c:	c6 85 6a ff ff ff 02 	movb   $0x2,-0x96(%ebp)
    3f93:	c6 85 6b ff ff ff 01 	movb   $0x1,-0x95(%ebp)
    3f9a:	c6 85 6c ff ff ff 00 	movb   $0x0,-0x94(%ebp)
    3fa1:	c6 85 6d ff ff ff 10 	movb   $0x10,-0x93(%ebp)
    3fa8:	c6 85 6e ff ff ff 00 	movb   $0x0,-0x92(%ebp)
    3faf:	c6 85 6f ff ff ff 01 	movb   $0x1,-0x91(%ebp)
    3fb6:	c6 85 70 ff ff ff 02 	movb   $0x2,-0x90(%ebp)
    3fbd:	c6 85 71 ff ff ff 01 	movb   $0x1,-0x8f(%ebp)
    3fc4:	c6 85 72 ff ff ff 00 	movb   $0x0,-0x8e(%ebp)
    3fcb:	c6 85 73 ff ff ff 11 	movb   $0x11,-0x8d(%ebp)
    3fd2:	c6 85 74 ff ff ff 08 	movb   $0x8,-0x8c(%ebp)
    3fd9:	c6 85 75 ff ff ff 01 	movb   $0x1,-0x8b(%ebp)
    3fe0:	c6 85 76 ff ff ff 04 	movb   $0x4,-0x8a(%ebp)
    3fe7:	c6 85 77 ff ff ff 01 	movb   $0x1,-0x89(%ebp)
    3fee:	c6 85 78 ff ff ff 02 	movb   $0x2,-0x88(%ebp)
    3ff5:	c6 85 79 ff ff ff 01 	movb   $0x1,-0x87(%ebp)
    3ffc:	c6 85 7a ff ff ff 00 	movb   $0x0,-0x86(%ebp)
    4003:	c6 85 7b ff ff ff 20 	movb   $0x20,-0x85(%ebp)
    400a:	c6 85 7c ff ff ff 00 	movb   $0x0,-0x84(%ebp)
    4011:	c6 85 7d ff ff ff 02 	movb   $0x2,-0x83(%ebp)
    4018:	c6 85 7e ff ff ff 02 	movb   $0x2,-0x82(%ebp)
    401f:	c6 85 7f ff ff ff 01 	movb   $0x1,-0x81(%ebp)
    4026:	c6 45 80 00          	movb   $0x0,-0x80(%ebp)
    402a:	c6 45 81 21          	movb   $0x21,-0x7f(%ebp)
    402e:	c6 45 82 00          	movb   $0x0,-0x7e(%ebp)
    4032:	c6 45 83 12          	movb   $0x12,-0x7d(%ebp)
    4036:	c6 45 84 08          	movb   $0x8,-0x7c(%ebp)
    403a:	c6 45 85 01          	movb   $0x1,-0x7b(%ebp)
    403e:	c6 45 86 04          	movb   $0x4,-0x7a(%ebp)
    4042:	c6 45 87 01          	movb   $0x1,-0x79(%ebp)
    4046:	c6 45 88 02          	movb   $0x2,-0x78(%ebp)
    404a:	c6 45 89 01          	movb   $0x1,-0x77(%ebp)
    404e:	c6 45 8a 00          	movb   $0x0,-0x76(%ebp)
    4052:	c6 45 8b 22          	movb   $0x22,-0x75(%ebp)
    4056:	c6 45 8c 00          	movb   $0x0,-0x74(%ebp)
    405a:	c6 45 8d 30          	movb   $0x30,-0x73(%ebp)
    405e:	c6 45 8e 02          	movb   $0x2,-0x72(%ebp)
    4062:	c6 45 8f 01          	movb   $0x1,-0x71(%ebp)
    4066:	c6 45 90 00          	movb   $0x0,-0x70(%ebp)
    406a:	c6 45 91 03          	movb   $0x3,-0x6f(%ebp)
    406e:	c6 45 92 00          	movb   $0x0,-0x6e(%ebp)
    4072:	c6 45 93 13          	movb   $0x13,-0x6d(%ebp)
    4076:	c6 45 94 02          	movb   $0x2,-0x6c(%ebp)
    407a:	c6 45 95 01          	movb   $0x1,-0x6b(%ebp)
    407e:	c6 45 96 00          	movb   $0x0,-0x6a(%ebp)
    4082:	c6 45 97 31          	movb   $0x31,-0x69(%ebp)
    4086:	c6 45 98 02          	movb   $0x2,-0x68(%ebp)
    408a:	c6 45 99 01          	movb   $0x1,-0x67(%ebp)
    408e:	c6 45 9a 00          	movb   $0x0,-0x66(%ebp)
    4092:	c6 45 9b 32          	movb   $0x32,-0x65(%ebp)
    4096:	c6 45 9c 02          	movb   $0x2,-0x64(%ebp)
    409a:	c6 45 9d 01          	movb   $0x1,-0x63(%ebp)
    409e:	c6 45 9e 00          	movb   $0x0,-0x62(%ebp)
    40a2:	c6 45 9f 23          	movb   $0x23,-0x61(%ebp)
    40a6:	c6 45 a0 00          	movb   $0x0,-0x60(%ebp)
    40aa:	c6 45 a1 33          	movb   $0x33,-0x5f(%ebp)

	unsigned char h6[31][2] = {{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x0,0x11},{0x6,0x1},{0x2,0x1},{0x0,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x2,0x1},{0x0,0x3},{0x0,0x33}};
    40ae:	c6 85 26 ff ff ff 06 	movb   $0x6,-0xda(%ebp)
    40b5:	c6 85 27 ff ff ff 01 	movb   $0x1,-0xd9(%ebp)
    40bc:	c6 85 28 ff ff ff 04 	movb   $0x4,-0xd8(%ebp)
    40c3:	c6 85 29 ff ff ff 01 	movb   $0x1,-0xd7(%ebp)
    40ca:	c6 85 2a ff ff ff 02 	movb   $0x2,-0xd6(%ebp)
    40d1:	c6 85 2b ff ff ff 01 	movb   $0x1,-0xd5(%ebp)
    40d8:	c6 85 2c ff ff ff 00 	movb   $0x0,-0xd4(%ebp)
    40df:	c6 85 2d ff ff ff 00 	movb   $0x0,-0xd3(%ebp)
    40e6:	c6 85 2e ff ff ff 00 	movb   $0x0,-0xd2(%ebp)
    40ed:	c6 85 2f ff ff ff 10 	movb   $0x10,-0xd1(%ebp)
    40f4:	c6 85 30 ff ff ff 00 	movb   $0x0,-0xd0(%ebp)
    40fb:	c6 85 31 ff ff ff 11 	movb   $0x11,-0xcf(%ebp)
    4102:	c6 85 32 ff ff ff 06 	movb   $0x6,-0xce(%ebp)
    4109:	c6 85 33 ff ff ff 01 	movb   $0x1,-0xcd(%ebp)
    4110:	c6 85 34 ff ff ff 02 	movb   $0x2,-0xcc(%ebp)
    4117:	c6 85 35 ff ff ff 01 	movb   $0x1,-0xcb(%ebp)
    411e:	c6 85 36 ff ff ff 00 	movb   $0x0,-0xca(%ebp)
    4125:	c6 85 37 ff ff ff 01 	movb   $0x1,-0xc9(%ebp)
    412c:	c6 85 38 ff ff ff 02 	movb   $0x2,-0xc8(%ebp)
    4133:	c6 85 39 ff ff ff 01 	movb   $0x1,-0xc7(%ebp)
    413a:	c6 85 3a ff ff ff 00 	movb   $0x0,-0xc6(%ebp)
    4141:	c6 85 3b ff ff ff 20 	movb   $0x20,-0xc5(%ebp)
    4148:	c6 85 3c ff ff ff 00 	movb   $0x0,-0xc4(%ebp)
    414f:	c6 85 3d ff ff ff 21 	movb   $0x21,-0xc3(%ebp)
    4156:	c6 85 3e ff ff ff 06 	movb   $0x6,-0xc2(%ebp)
    415d:	c6 85 3f ff ff ff 01 	movb   $0x1,-0xc1(%ebp)
    4164:	c6 85 40 ff ff ff 02 	movb   $0x2,-0xc0(%ebp)
    416b:	c6 85 41 ff ff ff 01 	movb   $0x1,-0xbf(%ebp)
    4172:	c6 85 42 ff ff ff 00 	movb   $0x0,-0xbe(%ebp)
    4179:	c6 85 43 ff ff ff 12 	movb   $0x12,-0xbd(%ebp)
    4180:	c6 85 44 ff ff ff 02 	movb   $0x2,-0xbc(%ebp)
    4187:	c6 85 45 ff ff ff 01 	movb   $0x1,-0xbb(%ebp)
    418e:	c6 85 46 ff ff ff 00 	movb   $0x0,-0xba(%ebp)
    4195:	c6 85 47 ff ff ff 02 	movb   $0x2,-0xb9(%ebp)
    419c:	c6 85 48 ff ff ff 00 	movb   $0x0,-0xb8(%ebp)
    41a3:	c6 85 49 ff ff ff 22 	movb   $0x22,-0xb7(%ebp)
    41aa:	c6 85 4a ff ff ff 04 	movb   $0x4,-0xb6(%ebp)
    41b1:	c6 85 4b ff ff ff 01 	movb   $0x1,-0xb5(%ebp)
    41b8:	c6 85 4c ff ff ff 02 	movb   $0x2,-0xb4(%ebp)
    41bf:	c6 85 4d ff ff ff 01 	movb   $0x1,-0xb3(%ebp)
    41c6:	c6 85 4e ff ff ff 00 	movb   $0x0,-0xb2(%ebp)
    41cd:	c6 85 4f ff ff ff 31 	movb   $0x31,-0xb1(%ebp)
    41d4:	c6 85 50 ff ff ff 00 	movb   $0x0,-0xb0(%ebp)
    41db:	c6 85 51 ff ff ff 13 	movb   $0x13,-0xaf(%ebp)
    41e2:	c6 85 52 ff ff ff 04 	movb   $0x4,-0xae(%ebp)
    41e9:	c6 85 53 ff ff ff 01 	movb   $0x1,-0xad(%ebp)
    41f0:	c6 85 54 ff ff ff 02 	movb   $0x2,-0xac(%ebp)
    41f7:	c6 85 55 ff ff ff 01 	movb   $0x1,-0xab(%ebp)
    41fe:	c6 85 56 ff ff ff 00 	movb   $0x0,-0xaa(%ebp)
    4205:	c6 85 57 ff ff ff 30 	movb   $0x30,-0xa9(%ebp)
    420c:	c6 85 58 ff ff ff 00 	movb   $0x0,-0xa8(%ebp)
    4213:	c6 85 59 ff ff ff 32 	movb   $0x32,-0xa7(%ebp)
    421a:	c6 85 5a ff ff ff 02 	movb   $0x2,-0xa6(%ebp)
    4221:	c6 85 5b ff ff ff 01 	movb   $0x1,-0xa5(%ebp)
    4228:	c6 85 5c ff ff ff 00 	movb   $0x0,-0xa4(%ebp)
    422f:	c6 85 5d ff ff ff 23 	movb   $0x23,-0xa3(%ebp)
    4236:	c6 85 5e ff ff ff 02 	movb   $0x2,-0xa2(%ebp)
    423d:	c6 85 5f ff ff ff 01 	movb   $0x1,-0xa1(%ebp)
    4244:	c6 85 60 ff ff ff 00 	movb   $0x0,-0xa0(%ebp)
    424b:	c6 85 61 ff ff ff 03 	movb   $0x3,-0x9f(%ebp)
    4252:	c6 85 62 ff ff ff 00 	movb   $0x0,-0x9e(%ebp)
    4259:	c6 85 63 ff ff ff 33 	movb   $0x33,-0x9d(%ebp)

	unsigned char h7[71][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x12,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x4},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x5},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    4260:	8d 95 98 fe ff ff    	lea    -0x168(%ebp),%edx
    4266:	b8 20 98 00 00       	mov    $0x9820,%eax
    426b:	b9 23 00 00 00       	mov    $0x23,%ecx
    4270:	89 d7                	mov    %edx,%edi
    4272:	89 c6                	mov    %eax,%esi
    4274:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    4276:	89 f0                	mov    %esi,%eax
    4278:	89 fa                	mov    %edi,%edx
    427a:	0f b7 08             	movzwl (%eax),%ecx
    427d:	66 89 0a             	mov    %cx,(%edx)
    4280:	83 c2 02             	add    $0x2,%edx
    4283:	83 c0 02             	add    $0x2,%eax

	unsigned char h8[71][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x33},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x6,0x1},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x2,0x1},{0x0,0x53},{0x2,0x1},{0x0,0x45},{0x2,0x1},{0x0,0x54},{0x0,0x55}};
    4286:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    428c:	ba c0 98 00 00       	mov    $0x98c0,%edx
    4291:	bb 8e 00 00 00       	mov    $0x8e,%ebx
    4296:	89 c1                	mov    %eax,%ecx
    4298:	83 e1 02             	and    $0x2,%ecx
    429b:	85 c9                	test   %ecx,%ecx
    429d:	74 0f                	je     42ae <read_decoder_table+0x4a0>
    429f:	0f b7 0a             	movzwl (%edx),%ecx
    42a2:	66 89 08             	mov    %cx,(%eax)
    42a5:	83 c0 02             	add    $0x2,%eax
    42a8:	83 c2 02             	add    $0x2,%edx
    42ab:	83 eb 02             	sub    $0x2,%ebx
    42ae:	89 d9                	mov    %ebx,%ecx
    42b0:	c1 e9 02             	shr    $0x2,%ecx
    42b3:	89 c7                	mov    %eax,%edi
    42b5:	89 d6                	mov    %edx,%esi
    42b7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    42b9:	89 f2                	mov    %esi,%edx
    42bb:	89 f8                	mov    %edi,%eax
    42bd:	b9 00 00 00 00       	mov    $0x0,%ecx
    42c2:	89 de                	mov    %ebx,%esi
    42c4:	83 e6 02             	and    $0x2,%esi
    42c7:	85 f6                	test   %esi,%esi
    42c9:	74 0b                	je     42d6 <read_decoder_table+0x4c8>
    42cb:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    42cf:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    42d3:	83 c1 02             	add    $0x2,%ecx
    42d6:	83 e3 01             	and    $0x1,%ebx
    42d9:	85 db                	test   %ebx,%ebx
    42db:	74 07                	je     42e4 <read_decoder_table+0x4d6>
    42dd:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    42e1:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h9[71][2] = {{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x0,0x43},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x15},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x54},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    42e4:	8d 95 7c fd ff ff    	lea    -0x284(%ebp),%edx
    42ea:	b8 60 99 00 00       	mov    $0x9960,%eax
    42ef:	b9 23 00 00 00       	mov    $0x23,%ecx
    42f4:	89 d7                	mov    %edx,%edi
    42f6:	89 c6                	mov    %eax,%esi
    42f8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    42fa:	89 f0                	mov    %esi,%eax
    42fc:	89 fa                	mov    %edi,%edx
    42fe:	0f b7 08             	movzwl (%eax),%ecx
    4301:	66 89 0a             	mov    %cx,(%edx)
    4304:	83 c2 02             	add    $0x2,%edx
    4307:	83 c0 02             	add    $0x2,%eax

	unsigned char h10[127][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0xa,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x40},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x1c,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x60},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x36},{0x0,0x71},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x45},{0x0,0x62},{0x2,0x1},{0x0,0x70},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x6,0x1},{0x2,0x1},{0x0,0x63},{0x2,0x1},{0x0,0x54},{0x0,0x55},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x6,0x1},{0x2,0x1},{0x0,0x47},{0x2,0x1},{0x0,0x66},{0x0,0x75},{0x4,0x1},{0x2,0x1},{0x0,0x57},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    430a:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    4310:	ba 00 9a 00 00       	mov    $0x9a00,%edx
    4315:	bb fe 00 00 00       	mov    $0xfe,%ebx
    431a:	89 c1                	mov    %eax,%ecx
    431c:	83 e1 02             	and    $0x2,%ecx
    431f:	85 c9                	test   %ecx,%ecx
    4321:	74 0f                	je     4332 <read_decoder_table+0x524>
    4323:	0f b7 0a             	movzwl (%edx),%ecx
    4326:	66 89 08             	mov    %cx,(%eax)
    4329:	83 c0 02             	add    $0x2,%eax
    432c:	83 c2 02             	add    $0x2,%edx
    432f:	83 eb 02             	sub    $0x2,%ebx
    4332:	89 d9                	mov    %ebx,%ecx
    4334:	c1 e9 02             	shr    $0x2,%ecx
    4337:	89 c7                	mov    %eax,%edi
    4339:	89 d6                	mov    %edx,%esi
    433b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    433d:	89 f2                	mov    %esi,%edx
    433f:	89 f8                	mov    %edi,%eax
    4341:	b9 00 00 00 00       	mov    $0x0,%ecx
    4346:	89 de                	mov    %ebx,%esi
    4348:	83 e6 02             	and    $0x2,%esi
    434b:	85 f6                	test   %esi,%esi
    434d:	74 0b                	je     435a <read_decoder_table+0x54c>
    434f:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    4353:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    4357:	83 c1 02             	add    $0x2,%ecx
    435a:	83 e3 01             	and    $0x1,%ebx
    435d:	85 db                	test   %ebx,%ebx
    435f:	74 07                	je     4368 <read_decoder_table+0x55a>
    4361:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    4365:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h11[127][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x12},{0x18,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x21},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x1e,0x1},{0x10,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x0,0x61},{0x6,0x1},{0x2,0x1},{0x0,0x16},{0x2,0x1},{0x0,0x6},{0x0,0x26},{0x2,0x1},{0x0,0x62},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x0,0x60},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x17},{0x0,0x71},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x55},{0x0,0x57},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    4368:	8d 95 80 fb ff ff    	lea    -0x480(%ebp),%edx
    436e:	b8 00 9b 00 00       	mov    $0x9b00,%eax
    4373:	b9 3f 00 00 00       	mov    $0x3f,%ecx
    4378:	89 d7                	mov    %edx,%edi
    437a:	89 c6                	mov    %eax,%esi
    437c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    437e:	89 f0                	mov    %esi,%eax
    4380:	89 fa                	mov    %edi,%edx
    4382:	0f b7 08             	movzwl (%eax),%ecx
    4385:	66 89 0a             	mov    %cx,(%edx)
    4388:	83 c2 02             	add    $0x2,%edx
    438b:	83 c0 02             	add    $0x2,%eax

	unsigned char h12[127][2] = {{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x1a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x41},{0x0,0x33},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x1c,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x16},{0x0,0x61},{0x4,0x1},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x6},{0x0,0x44},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x71},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x46},{0x0,0x72},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x27},{0x2,0x1},{0x0,0x55},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x56},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    438e:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    4394:	ba 00 9c 00 00       	mov    $0x9c00,%edx
    4399:	bb fe 00 00 00       	mov    $0xfe,%ebx
    439e:	89 c1                	mov    %eax,%ecx
    43a0:	83 e1 02             	and    $0x2,%ecx
    43a3:	85 c9                	test   %ecx,%ecx
    43a5:	74 0f                	je     43b6 <read_decoder_table+0x5a8>
    43a7:	0f b7 0a             	movzwl (%edx),%ecx
    43aa:	66 89 08             	mov    %cx,(%eax)
    43ad:	83 c0 02             	add    $0x2,%eax
    43b0:	83 c2 02             	add    $0x2,%edx
    43b3:	83 eb 02             	sub    $0x2,%ebx
    43b6:	89 d9                	mov    %ebx,%ecx
    43b8:	c1 e9 02             	shr    $0x2,%ecx
    43bb:	89 c7                	mov    %eax,%edi
    43bd:	89 d6                	mov    %edx,%esi
    43bf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    43c1:	89 f2                	mov    %esi,%edx
    43c3:	89 f8                	mov    %edi,%eax
    43c5:	b9 00 00 00 00       	mov    $0x0,%ecx
    43ca:	89 de                	mov    %ebx,%esi
    43cc:	83 e6 02             	and    $0x2,%esi
    43cf:	85 f6                	test   %esi,%esi
    43d1:	74 0b                	je     43de <read_decoder_table+0x5d0>
    43d3:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    43d7:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    43db:	83 c1 02             	add    $0x2,%ecx
    43de:	83 e3 01             	and    $0x1,%ebx
    43e1:	85 db                	test   %ebx,%ebx
    43e3:	74 07                	je     43ec <read_decoder_table+0x5de>
    43e5:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    43e9:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h13[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x46,0x1},{0x1c,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x4,0x1},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x62},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x4,0x1},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x55},{0x0,0x71},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x48,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x4,0x1},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x0,0x72},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x2,0x1},{0x0,0x90},{0x0,0x9},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x73},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x0,0x83},{0x6,0x1},{0x2,0x1},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x85},{0x2,0x1},{0x0,0x58},{0x0,0x39},{0x2,0x1},{0x0,0x93},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0x6,0x1},{0x2,0x1},{0x0,0xa0},{0x2,0x1},{0x0,0x68},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x44,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x4,0x1},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x2,0x1},{0x0,0xb1},{0x0,0x1b},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xb2},{0x4,0x1},{0x2,0x1},{0x0,0x76},{0x0,0x77},{0x0,0x94},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x0,0xa4},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xa5},{0x0,0x2b},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x88},{0x0,0xb3},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0x79},{0x0,0xa6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x98},{0x0,0xc1},{0x3c,0x1},{0x16,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x2,0x1},{0x0,0xd0},{0x0,0xd},{0x2,0x1},{0x0,0xd1},{0x2,0x1},{0x0,0x4b},{0x2,0x1},{0x0,0x97},{0x0,0xa7},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xc3},{0x2,0x1},{0x0,0x7a},{0x0,0x99},{0x4,0x1},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x0,0xb7},{0x4,0x1},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x2,0x1},{0x0,0x7b},{0x0,0xd3},{0x34,0x1},{0x1c,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe0},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe1},{0x0,0x1e},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0x2e},{0x0,0xe2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe3},{0x0,0x6d},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x0,0xf0},{0x26,0x1},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xaa},{0x0,0x9b},{0x0,0xb9},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0xd6},{0x0,0xc8},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x2,0x1},{0x0,0xab},{0x2,0x1},{0x0,0x5e},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xf},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x20,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x0,0x3f},{0x6,0x1},{0x2,0x1},{0x0,0xf3},{0x2,0x1},{0x0,0xe6},{0x0,0xca},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbb},{0x0,0xac},{0x2,0x1},{0x0,0xe7},{0x0,0xf5},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0x9d},{0x2,0x1},{0x0,0x5f},{0x0,0xe8},{0x1e,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x6f},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xad},{0x0,0xda},{0x8,0x1},{0x2,0x1},{0x0,0xf7},{0x4,0x1},{0x2,0x1},{0x0,0x7e},{0x0,0x7f},{0x0,0x8e},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xae},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xeb},{0x2,0x1},{0x0,0xbe},{0x2,0x1},{0x0,0xcd},{0x0,0xfa},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe9},{0x0,0xaf},{0x0,0xdc},{0x2,0x1},{0x0,0xce},{0x0,0xfb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xde},{0x2,0x1},{0x0,0xcf},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xef},{0x2,0x1},{0x0,0xff},{0x2,0x1},{0x0,0xed},{0x2,0x1},{0x0,0xfd},{0x2,0x1},{0x0,0xfc},{0x0,0xfe}};
    43ec:	8d 95 84 f6 ff ff    	lea    -0x97c(%ebp),%edx
    43f2:	b8 00 9d 00 00       	mov    $0x9d00,%eax
    43f7:	b9 ff 00 00 00       	mov    $0xff,%ecx
    43fc:	89 d7                	mov    %edx,%edi
    43fe:	89 c6                	mov    %eax,%esi
    4400:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    4402:	89 f0                	mov    %esi,%eax
    4404:	89 fa                	mov    %edi,%edx
    4406:	0f b7 08             	movzwl (%eax),%ecx
    4409:	66 89 0a             	mov    %cx,(%edx)
    440c:	83 c2 02             	add    $0x2,%edx
    440f:	83 c0 02             	add    $0x2,%eax

	unsigned char h15[511][2] = {{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x32,0x1},{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x14},{0x0,0x41},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x0,0x43},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x34},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x61},{0x5a,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x36},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x18,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x4,0x1},{0x2,0x1},{0x0,0x56},{0x0,0x80},{0x2,0x1},{0x0,0x8},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x81},{0x0,0x18},{0x2,0x1},{0x0,0x82},{0x0,0x28},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x90},{0x0,0x19},{0x0,0x91},{0x4,0x1},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x5c,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x4,0x1},{0x2,0x1},{0x0,0x9},{0x0,0x77},{0x0,0x93},{0x4,0x1},{0x2,0x1},{0x0,0x39},{0x0,0x94},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x68},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x1a,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x3a},{0x0,0x87},{0x4,0x1},{0x2,0x1},{0x0,0x78},{0x0,0xa4},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb0},{0x0,0xb1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x0,0xb2},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0x79},{0x0,0x3b},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x4,0x1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x50,0x1},{0x22,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5b},{0x0,0x2c},{0x0,0xc2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x0,0xa6},{0x2,0x1},{0x0,0xa7},{0x0,0x7a},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc3},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x99},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x2,0x1},{0x0,0x4c},{0x0,0xa8},{0x14,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x2,0x1},{0x0,0xd},{0x0,0x2d},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd2},{0x0,0xd3},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9a},{0x0,0xb8},{0x0,0xd4},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x44,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x4,0x1},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x0,0xe1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0x2e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb9},{0x0,0x9b},{0x2,0x1},{0x0,0xe3},{0x0,0xd6},{0x4,0x1},{0x2,0x1},{0x0,0x6d},{0x0,0x3e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x2,0x1},{0x0,0xab},{0x0,0x5e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc9},{0x0,0x9c},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x6e},{0x0,0xf2},{0x2,0x1},{0x0,0x2f},{0x0,0xe6},{0x26,0x1},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0xf3},{0x2,0x1},{0x0,0x3f},{0x0,0xf4},{0x6,0x1},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0x8d},{0x0,0xd9},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xf5},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0x5f},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf},{0x0,0xae},{0x0,0x6f},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x4,0x1},{0x2,0x1},{0x0,0xad},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0xe9},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xeb},{0x4,0x1},{0x2,0x1},{0x0,0xbe},{0x0,0xfa},{0x2,0x1},{0x0,0xaf},{0x0,0xdd},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xec},{0x0,0xce},{0x0,0xfb},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xfc},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xcf},{0x0,0xfd},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xfe},{0x2,0x1},{0x0,0xef},{0x0,0xff}};
    4412:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    4418:	ba 00 a1 00 00       	mov    $0xa100,%edx
    441d:	bb fe 03 00 00       	mov    $0x3fe,%ebx
    4422:	89 c1                	mov    %eax,%ecx
    4424:	83 e1 02             	and    $0x2,%ecx
    4427:	85 c9                	test   %ecx,%ecx
    4429:	74 0f                	je     443a <read_decoder_table+0x62c>
    442b:	0f b7 0a             	movzwl (%edx),%ecx
    442e:	66 89 08             	mov    %cx,(%eax)
    4431:	83 c0 02             	add    $0x2,%eax
    4434:	83 c2 02             	add    $0x2,%edx
    4437:	83 eb 02             	sub    $0x2,%ebx
    443a:	89 d9                	mov    %ebx,%ecx
    443c:	c1 e9 02             	shr    $0x2,%ecx
    443f:	89 c7                	mov    %eax,%edi
    4441:	89 d6                	mov    %edx,%esi
    4443:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    4445:	89 f2                	mov    %esi,%edx
    4447:	89 f8                	mov    %edi,%eax
    4449:	b9 00 00 00 00       	mov    $0x0,%ecx
    444e:	89 de                	mov    %ebx,%esi
    4450:	83 e6 02             	and    $0x2,%esi
    4453:	85 f6                	test   %esi,%esi
    4455:	74 0b                	je     4462 <read_decoder_table+0x654>
    4457:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    445b:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    445f:	83 c1 02             	add    $0x2,%ecx
    4462:	83 e3 01             	and    $0x1,%ebx
    4465:	85 db                	test   %ebx,%ebx
    4467:	74 07                	je     4470 <read_decoder_table+0x662>
    4469:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    446d:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h16[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x2a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x8a,0x1},{0x28,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x15},{0x0,0x51},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x0,0x53},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x0,0x61},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x4,0x1},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x0,0x71},{0x28,0x1},{0x12,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x7},{0x2,0x1},{0x0,0x55},{0x0,0x64},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x65},{0x0,0x73},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x56},{0x0,0x8},{0x2,0x1},{0x0,0x80},{0x0,0x81},{0x6,0x1},{0x2,0x1},{0x0,0x18},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x84},{0x4,0x1},{0x2,0x1},{0x0,0x48},{0x0,0x90},{0x0,0x91},{0x6,0x1},{0x2,0x1},{0x0,0x19},{0x2,0x1},{0x0,0x9},{0x0,0x76},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x4,0x1},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x0,0x1a},{0x8,0x1},{0x2,0x1},{0x0,0xa2},{0x2,0x1},{0x0,0x67},{0x2,0x1},{0x0,0x57},{0x0,0x49},{0x6,0x1},{0x2,0x1},{0x0,0x94},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0xa1},{0x2,0x1},{0x0,0x68},{0x0,0x95},{0xdc,0x1},{0x7e,0x1},{0x32,0x1},{0x1a,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x2a},{0x2,0x1},{0x0,0x59},{0x0,0x3a},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x4a},{0x2,0x1},{0x0,0x96},{0x0,0x69},{0x4,0x1},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x0,0xb1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xb2},{0x2,0x1},{0x0,0x2b},{0x2,0x1},{0x0,0xa5},{0x0,0x5a},{0x6,0x1},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x4,0x1},{0x2,0x1},{0x0,0xb4},{0x0,0x4b},{0x2,0x1},{0x0,0xc},{0x0,0xc1},{0x1e,0x1},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb5},{0x0,0xc2},{0x0,0x2c},{0x4,0x1},{0x2,0x1},{0x0,0xa7},{0x0,0xc3},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x8,0x1},{0x2,0x1},{0x0,0x1d},{0x4,0x1},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x0,0x3b},{0x4,0x1},{0x2,0x1},{0x0,0xd1},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x12,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0x2e},{0x0,0xe2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x79},{0x0,0x98},{0x0,0xc0},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0x5b},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0x7a},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x4c},{0x0,0x99},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x6,0x1},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0x9a},{0x58,0x1},{0x56,0x1},{0x24,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x8,0x1},{0x2,0x1},{0x0,0xe3},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0xb7},{0x0,0x7b},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa9},{0x0,0xb8},{0x0,0xd4},{0x2,0x1},{0x0,0xe1},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x18,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xd6},{0x0,0x6d},{0x2,0x1},{0x0,0x3e},{0x0,0xc8},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x0,0x4e},{0x4,0x1},{0x2,0x1},{0x0,0xd7},{0x0,0xe5},{0x2,0x1},{0x0,0xba},{0x0,0xab},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9c},{0x0,0xe6},{0x4,0x1},{0x2,0x1},{0x0,0x6e},{0x0,0xd8},{0x2,0x1},{0x0,0x8d},{0x0,0xbb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe7},{0x0,0x9d},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x4,0x1},{0x2,0x1},{0x0,0xcb},{0x0,0xbc},{0x0,0x9e},{0x0,0xf1},{0x2,0x1},{0x0,0x1f},{0x2,0x1},{0x0,0xf},{0x0,0x2f},{0x42,0x1},{0x38,0x1},{0x2,0x1},{0x0,0xf2},{0x34,0x1},{0x32,0x1},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xbd},{0x2,0x1},{0x0,0x5e},{0x2,0x1},{0x0,0x7d},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xca},{0x2,0x1},{0x0,0xac},{0x0,0x7e},{0x4,0x1},{0x2,0x1},{0x0,0xda},{0x0,0xad},{0x0,0xcc},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xae},{0x2,0x1},{0x0,0xdb},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xbe},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xed},{0x0,0xee},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0xea},{0x0,0xe9},{0x2,0x1},{0x0,0xde},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x0,0xce},{0x0,0x3f},{0x0,0xf0},{0x4,0x1},{0x2,0x1},{0x0,0xf3},{0x0,0xf4},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0xa,0x1},{0x2,0x1},{0x0,0xff},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x0,0x7f},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x8f},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xfa},{0x0,0xaf},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    4470:	8d 95 88 ee ff ff    	lea    -0x1178(%ebp),%edx
    4476:	b8 00 a5 00 00       	mov    $0xa500,%eax
    447b:	b9 ff 00 00 00       	mov    $0xff,%ecx
    4480:	89 d7                	mov    %edx,%edi
    4482:	89 c6                	mov    %eax,%esi
    4484:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    4486:	89 f0                	mov    %esi,%eax
    4488:	89 fa                	mov    %edi,%edx
    448a:	0f b7 08             	movzwl (%eax),%ecx
    448d:	66 89 0a             	mov    %cx,(%edx)
    4490:	83 c2 02             	add    $0x2,%edx
    4493:	83 c0 02             	add    $0x2,%eax

	unsigned char h24[512][2] = {{0x3c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0xfa,0x1},{0x62,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x4,0x1},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x20,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x2,0x1},{0x0,0x73},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x17},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x4,0x1},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x5c,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x2,0x1},{0x0,0x94},{0x0,0x49},{0x4,0x1},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0x68},{0x0,0xa1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x4,0x1},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x2,0x1},{0x0,0x87},{0x2,0x1},{0x0,0x78},{0x0,0x4a},{0x16,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x96},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x6,0x1},{0x2,0x1},{0x0,0xb2},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0xb3},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x90},{0x2,0x1},{0x0,0x9},{0x0,0xa0},{0x2,0x1},{0x0,0x97},{0x0,0x79},{0x4,0x1},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x0,0xb4},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1a},{0x2,0x1},{0x0,0xa},{0x0,0xb0},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x43,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0xa7},{0x2,0x1},{0x0,0x7a},{0x0,0xc3},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0xc},{0x0,0xd0},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x4,0x1},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x2,0x1},{0x0,0x99},{0x0,0xa8},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x2,0x1},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x9,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x55,0xfa},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xe3},{0x2,0x1},{0x0,0xd6},{0x0,0x6d},{0x14,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0x2e},{0x0,0x4e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0xd7},{0x4,0x1},{0x2,0x1},{0x0,0x7d},{0x0,0xab},{0x0,0xe5},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xba},{0x0,0x5e},{0x2,0x1},{0x0,0xc9},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x8,0x1},{0x2,0x1},{0x0,0xe6},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x4a,0x1},{0x2,0x1},{0x0,0xff},{0x40,0x1},{0x3a,0x1},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xd9},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0xe8},{0x2,0x1},{0x0,0x8e},{0x0,0xcb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x2,0x1},{0x0,0xad},{0x0,0xe9},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xea},{0x0,0xae},{0x2,0x1},{0x0,0xdc},{0x0,0xcd},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xbe},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xce},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xee},{0x0,0xf},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x1f},{0x0,0xf1},{0x4,0x1},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x2,0x1},{0x0,0xf3},{0x0,0x3f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0x8f},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xaf},{0x0,0xfa},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    4496:	8d 95 88 ea ff ff    	lea    -0x1578(%ebp),%edx
    449c:	bb 00 a9 00 00       	mov    $0xa900,%ebx
    44a1:	b8 00 01 00 00       	mov    $0x100,%eax
    44a6:	89 d7                	mov    %edx,%edi
    44a8:	89 de                	mov    %ebx,%esi
    44aa:	89 c1                	mov    %eax,%ecx
    44ac:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char hA[31][2] = {{0x2,0x1},{0x0,0x0},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x4},{0x2,0x1},{0x0,0x1},{0x0,0x2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xa},{0x2,0x1},{0x0,0x3},{0x0,0x6},{0x6,0x1},{0x2,0x1},{0x0,0x9},{0x2,0x1},{0x0,0x5},{0x0,0x7},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0xd},{0x2,0x1},{0x0,0xf},{0x0,0xb}};
    44ae:	c6 85 4a ea ff ff 02 	movb   $0x2,-0x15b6(%ebp)
    44b5:	c6 85 4b ea ff ff 01 	movb   $0x1,-0x15b5(%ebp)
    44bc:	c6 85 4c ea ff ff 00 	movb   $0x0,-0x15b4(%ebp)
    44c3:	c6 85 4d ea ff ff 00 	movb   $0x0,-0x15b3(%ebp)
    44ca:	c6 85 4e ea ff ff 08 	movb   $0x8,-0x15b2(%ebp)
    44d1:	c6 85 4f ea ff ff 01 	movb   $0x1,-0x15b1(%ebp)
    44d8:	c6 85 50 ea ff ff 04 	movb   $0x4,-0x15b0(%ebp)
    44df:	c6 85 51 ea ff ff 01 	movb   $0x1,-0x15af(%ebp)
    44e6:	c6 85 52 ea ff ff 02 	movb   $0x2,-0x15ae(%ebp)
    44ed:	c6 85 53 ea ff ff 01 	movb   $0x1,-0x15ad(%ebp)
    44f4:	c6 85 54 ea ff ff 00 	movb   $0x0,-0x15ac(%ebp)
    44fb:	c6 85 55 ea ff ff 08 	movb   $0x8,-0x15ab(%ebp)
    4502:	c6 85 56 ea ff ff 00 	movb   $0x0,-0x15aa(%ebp)
    4509:	c6 85 57 ea ff ff 04 	movb   $0x4,-0x15a9(%ebp)
    4510:	c6 85 58 ea ff ff 02 	movb   $0x2,-0x15a8(%ebp)
    4517:	c6 85 59 ea ff ff 01 	movb   $0x1,-0x15a7(%ebp)
    451e:	c6 85 5a ea ff ff 00 	movb   $0x0,-0x15a6(%ebp)
    4525:	c6 85 5b ea ff ff 01 	movb   $0x1,-0x15a5(%ebp)
    452c:	c6 85 5c ea ff ff 00 	movb   $0x0,-0x15a4(%ebp)
    4533:	c6 85 5d ea ff ff 02 	movb   $0x2,-0x15a3(%ebp)
    453a:	c6 85 5e ea ff ff 08 	movb   $0x8,-0x15a2(%ebp)
    4541:	c6 85 5f ea ff ff 01 	movb   $0x1,-0x15a1(%ebp)
    4548:	c6 85 60 ea ff ff 04 	movb   $0x4,-0x15a0(%ebp)
    454f:	c6 85 61 ea ff ff 01 	movb   $0x1,-0x159f(%ebp)
    4556:	c6 85 62 ea ff ff 02 	movb   $0x2,-0x159e(%ebp)
    455d:	c6 85 63 ea ff ff 01 	movb   $0x1,-0x159d(%ebp)
    4564:	c6 85 64 ea ff ff 00 	movb   $0x0,-0x159c(%ebp)
    456b:	c6 85 65 ea ff ff 0c 	movb   $0xc,-0x159b(%ebp)
    4572:	c6 85 66 ea ff ff 00 	movb   $0x0,-0x159a(%ebp)
    4579:	c6 85 67 ea ff ff 0a 	movb   $0xa,-0x1599(%ebp)
    4580:	c6 85 68 ea ff ff 02 	movb   $0x2,-0x1598(%ebp)
    4587:	c6 85 69 ea ff ff 01 	movb   $0x1,-0x1597(%ebp)
    458e:	c6 85 6a ea ff ff 00 	movb   $0x0,-0x1596(%ebp)
    4595:	c6 85 6b ea ff ff 03 	movb   $0x3,-0x1595(%ebp)
    459c:	c6 85 6c ea ff ff 00 	movb   $0x0,-0x1594(%ebp)
    45a3:	c6 85 6d ea ff ff 06 	movb   $0x6,-0x1593(%ebp)
    45aa:	c6 85 6e ea ff ff 06 	movb   $0x6,-0x1592(%ebp)
    45b1:	c6 85 6f ea ff ff 01 	movb   $0x1,-0x1591(%ebp)
    45b8:	c6 85 70 ea ff ff 02 	movb   $0x2,-0x1590(%ebp)
    45bf:	c6 85 71 ea ff ff 01 	movb   $0x1,-0x158f(%ebp)
    45c6:	c6 85 72 ea ff ff 00 	movb   $0x0,-0x158e(%ebp)
    45cd:	c6 85 73 ea ff ff 09 	movb   $0x9,-0x158d(%ebp)
    45d4:	c6 85 74 ea ff ff 02 	movb   $0x2,-0x158c(%ebp)
    45db:	c6 85 75 ea ff ff 01 	movb   $0x1,-0x158b(%ebp)
    45e2:	c6 85 76 ea ff ff 00 	movb   $0x0,-0x158a(%ebp)
    45e9:	c6 85 77 ea ff ff 05 	movb   $0x5,-0x1589(%ebp)
    45f0:	c6 85 78 ea ff ff 00 	movb   $0x0,-0x1588(%ebp)
    45f7:	c6 85 79 ea ff ff 07 	movb   $0x7,-0x1587(%ebp)
    45fe:	c6 85 7a ea ff ff 04 	movb   $0x4,-0x1586(%ebp)
    4605:	c6 85 7b ea ff ff 01 	movb   $0x1,-0x1585(%ebp)
    460c:	c6 85 7c ea ff ff 02 	movb   $0x2,-0x1584(%ebp)
    4613:	c6 85 7d ea ff ff 01 	movb   $0x1,-0x1583(%ebp)
    461a:	c6 85 7e ea ff ff 00 	movb   $0x0,-0x1582(%ebp)
    4621:	c6 85 7f ea ff ff 0e 	movb   $0xe,-0x1581(%ebp)
    4628:	c6 85 80 ea ff ff 00 	movb   $0x0,-0x1580(%ebp)
    462f:	c6 85 81 ea ff ff 0d 	movb   $0xd,-0x157f(%ebp)
    4636:	c6 85 82 ea ff ff 02 	movb   $0x2,-0x157e(%ebp)
    463d:	c6 85 83 ea ff ff 01 	movb   $0x1,-0x157d(%ebp)
    4644:	c6 85 84 ea ff ff 00 	movb   $0x0,-0x157c(%ebp)
    464b:	c6 85 85 ea ff ff 0f 	movb   $0xf,-0x157b(%ebp)
    4652:	c6 85 86 ea ff ff 00 	movb   $0x0,-0x157a(%ebp)
    4659:	c6 85 87 ea ff ff 0b 	movb   $0xb,-0x1579(%ebp)

	unsigned char hB[31][2] = {{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x2},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x5},{0x2,0x1},{0x0,0x6},{0x0,0x7},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x9},{0x2,0x1},{0x0,0xa},{0x0,0xb},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xd},{0x2,0x1},{0x0,0xe},{0x0,0xf}};
    4660:	c6 85 0c ea ff ff 10 	movb   $0x10,-0x15f4(%ebp)
    4667:	c6 85 0d ea ff ff 01 	movb   $0x1,-0x15f3(%ebp)
    466e:	c6 85 0e ea ff ff 08 	movb   $0x8,-0x15f2(%ebp)
    4675:	c6 85 0f ea ff ff 01 	movb   $0x1,-0x15f1(%ebp)
    467c:	c6 85 10 ea ff ff 04 	movb   $0x4,-0x15f0(%ebp)
    4683:	c6 85 11 ea ff ff 01 	movb   $0x1,-0x15ef(%ebp)
    468a:	c6 85 12 ea ff ff 02 	movb   $0x2,-0x15ee(%ebp)
    4691:	c6 85 13 ea ff ff 01 	movb   $0x1,-0x15ed(%ebp)
    4698:	c6 85 14 ea ff ff 00 	movb   $0x0,-0x15ec(%ebp)
    469f:	c6 85 15 ea ff ff 00 	movb   $0x0,-0x15eb(%ebp)
    46a6:	c6 85 16 ea ff ff 00 	movb   $0x0,-0x15ea(%ebp)
    46ad:	c6 85 17 ea ff ff 01 	movb   $0x1,-0x15e9(%ebp)
    46b4:	c6 85 18 ea ff ff 02 	movb   $0x2,-0x15e8(%ebp)
    46bb:	c6 85 19 ea ff ff 01 	movb   $0x1,-0x15e7(%ebp)
    46c2:	c6 85 1a ea ff ff 00 	movb   $0x0,-0x15e6(%ebp)
    46c9:	c6 85 1b ea ff ff 02 	movb   $0x2,-0x15e5(%ebp)
    46d0:	c6 85 1c ea ff ff 00 	movb   $0x0,-0x15e4(%ebp)
    46d7:	c6 85 1d ea ff ff 03 	movb   $0x3,-0x15e3(%ebp)
    46de:	c6 85 1e ea ff ff 04 	movb   $0x4,-0x15e2(%ebp)
    46e5:	c6 85 1f ea ff ff 01 	movb   $0x1,-0x15e1(%ebp)
    46ec:	c6 85 20 ea ff ff 02 	movb   $0x2,-0x15e0(%ebp)
    46f3:	c6 85 21 ea ff ff 01 	movb   $0x1,-0x15df(%ebp)
    46fa:	c6 85 22 ea ff ff 00 	movb   $0x0,-0x15de(%ebp)
    4701:	c6 85 23 ea ff ff 04 	movb   $0x4,-0x15dd(%ebp)
    4708:	c6 85 24 ea ff ff 00 	movb   $0x0,-0x15dc(%ebp)
    470f:	c6 85 25 ea ff ff 05 	movb   $0x5,-0x15db(%ebp)
    4716:	c6 85 26 ea ff ff 02 	movb   $0x2,-0x15da(%ebp)
    471d:	c6 85 27 ea ff ff 01 	movb   $0x1,-0x15d9(%ebp)
    4724:	c6 85 28 ea ff ff 00 	movb   $0x0,-0x15d8(%ebp)
    472b:	c6 85 29 ea ff ff 06 	movb   $0x6,-0x15d7(%ebp)
    4732:	c6 85 2a ea ff ff 00 	movb   $0x0,-0x15d6(%ebp)
    4739:	c6 85 2b ea ff ff 07 	movb   $0x7,-0x15d5(%ebp)
    4740:	c6 85 2c ea ff ff 08 	movb   $0x8,-0x15d4(%ebp)
    4747:	c6 85 2d ea ff ff 01 	movb   $0x1,-0x15d3(%ebp)
    474e:	c6 85 2e ea ff ff 04 	movb   $0x4,-0x15d2(%ebp)
    4755:	c6 85 2f ea ff ff 01 	movb   $0x1,-0x15d1(%ebp)
    475c:	c6 85 30 ea ff ff 02 	movb   $0x2,-0x15d0(%ebp)
    4763:	c6 85 31 ea ff ff 01 	movb   $0x1,-0x15cf(%ebp)
    476a:	c6 85 32 ea ff ff 00 	movb   $0x0,-0x15ce(%ebp)
    4771:	c6 85 33 ea ff ff 08 	movb   $0x8,-0x15cd(%ebp)
    4778:	c6 85 34 ea ff ff 00 	movb   $0x0,-0x15cc(%ebp)
    477f:	c6 85 35 ea ff ff 09 	movb   $0x9,-0x15cb(%ebp)
    4786:	c6 85 36 ea ff ff 02 	movb   $0x2,-0x15ca(%ebp)
    478d:	c6 85 37 ea ff ff 01 	movb   $0x1,-0x15c9(%ebp)
    4794:	c6 85 38 ea ff ff 00 	movb   $0x0,-0x15c8(%ebp)
    479b:	c6 85 39 ea ff ff 0a 	movb   $0xa,-0x15c7(%ebp)
    47a2:	c6 85 3a ea ff ff 00 	movb   $0x0,-0x15c6(%ebp)
    47a9:	c6 85 3b ea ff ff 0b 	movb   $0xb,-0x15c5(%ebp)
    47b0:	c6 85 3c ea ff ff 04 	movb   $0x4,-0x15c4(%ebp)
    47b7:	c6 85 3d ea ff ff 01 	movb   $0x1,-0x15c3(%ebp)
    47be:	c6 85 3e ea ff ff 02 	movb   $0x2,-0x15c2(%ebp)
    47c5:	c6 85 3f ea ff ff 01 	movb   $0x1,-0x15c1(%ebp)
    47cc:	c6 85 40 ea ff ff 00 	movb   $0x0,-0x15c0(%ebp)
    47d3:	c6 85 41 ea ff ff 0c 	movb   $0xc,-0x15bf(%ebp)
    47da:	c6 85 42 ea ff ff 00 	movb   $0x0,-0x15be(%ebp)
    47e1:	c6 85 43 ea ff ff 0d 	movb   $0xd,-0x15bd(%ebp)
    47e8:	c6 85 44 ea ff ff 02 	movb   $0x2,-0x15bc(%ebp)
    47ef:	c6 85 45 ea ff ff 01 	movb   $0x1,-0x15bb(%ebp)
    47f6:	c6 85 46 ea ff ff 00 	movb   $0x0,-0x15ba(%ebp)
    47fd:	c6 85 47 ea ff ff 0e 	movb   $0xe,-0x15b9(%ebp)
    4804:	c6 85 48 ea ff ff 00 	movb   $0x0,-0x15b8(%ebp)
    480b:	c6 85 49 ea ff ff 0f 	movb   $0xf,-0x15b7(%ebp)
	
	struct huffcodetab ht[HTN] = {
    4812:	66 c7 85 bc e4 ff ff 	movw   $0x30,-0x1b44(%ebp)
    4819:	30 00 
    481b:	c6 85 be e4 ff ff 00 	movb   $0x0,-0x1b42(%ebp)
    4822:	c7 85 c0 e4 ff ff 00 	movl   $0x0,-0x1b40(%ebp)
    4829:	00 00 00 
    482c:	c7 85 c4 e4 ff ff 00 	movl   $0x0,-0x1b3c(%ebp)
    4833:	00 00 00 
    4836:	c7 85 c8 e4 ff ff 00 	movl   $0x0,-0x1b38(%ebp)
    483d:	00 00 00 
    4840:	c7 85 cc e4 ff ff 00 	movl   $0x0,-0x1b34(%ebp)
    4847:	00 00 00 
    484a:	c7 85 d0 e4 ff ff ff 	movl   $0xffffffff,-0x1b30(%ebp)
    4851:	ff ff ff 
    4854:	c7 85 d4 e4 ff ff 00 	movl   $0x0,-0x1b2c(%ebp)
    485b:	00 00 00 
    485e:	c7 85 d8 e4 ff ff 00 	movl   $0x0,-0x1b28(%ebp)
    4865:	00 00 00 
    4868:	c7 85 dc e4 ff ff 00 	movl   $0x0,-0x1b24(%ebp)
    486f:	00 00 00 
    4872:	c7 85 e0 e4 ff ff 00 	movl   $0x0,-0x1b20(%ebp)
    4879:	00 00 00 
    487c:	66 c7 85 e4 e4 ff ff 	movw   $0x31,-0x1b1c(%ebp)
    4883:	31 00 
    4885:	c6 85 e6 e4 ff ff 00 	movb   $0x0,-0x1b1a(%ebp)
    488c:	c7 85 e8 e4 ff ff 02 	movl   $0x2,-0x1b18(%ebp)
    4893:	00 00 00 
    4896:	c7 85 ec e4 ff ff 02 	movl   $0x2,-0x1b14(%ebp)
    489d:	00 00 00 
    48a0:	c7 85 f0 e4 ff ff 00 	movl   $0x0,-0x1b10(%ebp)
    48a7:	00 00 00 
    48aa:	c7 85 f4 e4 ff ff 00 	movl   $0x0,-0x1b0c(%ebp)
    48b1:	00 00 00 
    48b4:	c7 85 f8 e4 ff ff ff 	movl   $0xffffffff,-0x1b08(%ebp)
    48bb:	ff ff ff 
    48be:	c7 85 fc e4 ff ff 00 	movl   $0x0,-0x1b04(%ebp)
    48c5:	00 00 00 
    48c8:	c7 85 00 e5 ff ff 00 	movl   $0x0,-0x1b00(%ebp)
    48cf:	00 00 00 
    48d2:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    48d5:	89 85 04 e5 ff ff    	mov    %eax,-0x1afc(%ebp)
    48db:	c7 85 08 e5 ff ff 07 	movl   $0x7,-0x1af8(%ebp)
    48e2:	00 00 00 
    48e5:	66 c7 85 0c e5 ff ff 	movw   $0x32,-0x1af4(%ebp)
    48ec:	32 00 
    48ee:	c6 85 0e e5 ff ff 00 	movb   $0x0,-0x1af2(%ebp)
    48f5:	c7 85 10 e5 ff ff 03 	movl   $0x3,-0x1af0(%ebp)
    48fc:	00 00 00 
    48ff:	c7 85 14 e5 ff ff 03 	movl   $0x3,-0x1aec(%ebp)
    4906:	00 00 00 
    4909:	c7 85 18 e5 ff ff 00 	movl   $0x0,-0x1ae8(%ebp)
    4910:	00 00 00 
    4913:	c7 85 1c e5 ff ff 00 	movl   $0x0,-0x1ae4(%ebp)
    491a:	00 00 00 
    491d:	c7 85 20 e5 ff ff ff 	movl   $0xffffffff,-0x1ae0(%ebp)
    4924:	ff ff ff 
    4927:	c7 85 24 e5 ff ff 00 	movl   $0x0,-0x1adc(%ebp)
    492e:	00 00 00 
    4931:	c7 85 28 e5 ff ff 00 	movl   $0x0,-0x1ad8(%ebp)
    4938:	00 00 00 
    493b:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    493e:	89 85 2c e5 ff ff    	mov    %eax,-0x1ad4(%ebp)
    4944:	c7 85 30 e5 ff ff 11 	movl   $0x11,-0x1ad0(%ebp)
    494b:	00 00 00 
    494e:	66 c7 85 34 e5 ff ff 	movw   $0x33,-0x1acc(%ebp)
    4955:	33 00 
    4957:	c6 85 36 e5 ff ff 00 	movb   $0x0,-0x1aca(%ebp)
    495e:	c7 85 38 e5 ff ff 03 	movl   $0x3,-0x1ac8(%ebp)
    4965:	00 00 00 
    4968:	c7 85 3c e5 ff ff 03 	movl   $0x3,-0x1ac4(%ebp)
    496f:	00 00 00 
    4972:	c7 85 40 e5 ff ff 00 	movl   $0x0,-0x1ac0(%ebp)
    4979:	00 00 00 
    497c:	c7 85 44 e5 ff ff 00 	movl   $0x0,-0x1abc(%ebp)
    4983:	00 00 00 
    4986:	c7 85 48 e5 ff ff ff 	movl   $0xffffffff,-0x1ab8(%ebp)
    498d:	ff ff ff 
    4990:	c7 85 4c e5 ff ff 00 	movl   $0x0,-0x1ab4(%ebp)
    4997:	00 00 00 
    499a:	c7 85 50 e5 ff ff 00 	movl   $0x0,-0x1ab0(%ebp)
    49a1:	00 00 00 
    49a4:	8d 45 a2             	lea    -0x5e(%ebp),%eax
    49a7:	89 85 54 e5 ff ff    	mov    %eax,-0x1aac(%ebp)
    49ad:	c7 85 58 e5 ff ff 11 	movl   $0x11,-0x1aa8(%ebp)
    49b4:	00 00 00 
    49b7:	66 c7 85 5c e5 ff ff 	movw   $0x34,-0x1aa4(%ebp)
    49be:	34 00 
    49c0:	c6 85 5e e5 ff ff 00 	movb   $0x0,-0x1aa2(%ebp)
    49c7:	c7 85 60 e5 ff ff 00 	movl   $0x0,-0x1aa0(%ebp)
    49ce:	00 00 00 
    49d1:	c7 85 64 e5 ff ff 00 	movl   $0x0,-0x1a9c(%ebp)
    49d8:	00 00 00 
    49db:	c7 85 68 e5 ff ff 00 	movl   $0x0,-0x1a98(%ebp)
    49e2:	00 00 00 
    49e5:	c7 85 6c e5 ff ff 00 	movl   $0x0,-0x1a94(%ebp)
    49ec:	00 00 00 
    49ef:	c7 85 70 e5 ff ff ff 	movl   $0xffffffff,-0x1a90(%ebp)
    49f6:	ff ff ff 
    49f9:	c7 85 74 e5 ff ff 00 	movl   $0x0,-0x1a8c(%ebp)
    4a00:	00 00 00 
    4a03:	c7 85 78 e5 ff ff 00 	movl   $0x0,-0x1a88(%ebp)
    4a0a:	00 00 00 
    4a0d:	c7 85 7c e5 ff ff 00 	movl   $0x0,-0x1a84(%ebp)
    4a14:	00 00 00 
    4a17:	c7 85 80 e5 ff ff 00 	movl   $0x0,-0x1a80(%ebp)
    4a1e:	00 00 00 
    4a21:	66 c7 85 84 e5 ff ff 	movw   $0x35,-0x1a7c(%ebp)
    4a28:	35 00 
    4a2a:	c6 85 86 e5 ff ff 00 	movb   $0x0,-0x1a7a(%ebp)
    4a31:	c7 85 88 e5 ff ff 04 	movl   $0x4,-0x1a78(%ebp)
    4a38:	00 00 00 
    4a3b:	c7 85 8c e5 ff ff 04 	movl   $0x4,-0x1a74(%ebp)
    4a42:	00 00 00 
    4a45:	c7 85 90 e5 ff ff 00 	movl   $0x0,-0x1a70(%ebp)
    4a4c:	00 00 00 
    4a4f:	c7 85 94 e5 ff ff 00 	movl   $0x0,-0x1a6c(%ebp)
    4a56:	00 00 00 
    4a59:	c7 85 98 e5 ff ff ff 	movl   $0xffffffff,-0x1a68(%ebp)
    4a60:	ff ff ff 
    4a63:	c7 85 9c e5 ff ff 00 	movl   $0x0,-0x1a64(%ebp)
    4a6a:	00 00 00 
    4a6d:	c7 85 a0 e5 ff ff 00 	movl   $0x0,-0x1a60(%ebp)
    4a74:	00 00 00 
    4a77:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
    4a7d:	89 85 a4 e5 ff ff    	mov    %eax,-0x1a5c(%ebp)
    4a83:	c7 85 a8 e5 ff ff 1f 	movl   $0x1f,-0x1a58(%ebp)
    4a8a:	00 00 00 
    4a8d:	66 c7 85 ac e5 ff ff 	movw   $0x36,-0x1a54(%ebp)
    4a94:	36 00 
    4a96:	c6 85 ae e5 ff ff 00 	movb   $0x0,-0x1a52(%ebp)
    4a9d:	c7 85 b0 e5 ff ff 04 	movl   $0x4,-0x1a50(%ebp)
    4aa4:	00 00 00 
    4aa7:	c7 85 b4 e5 ff ff 04 	movl   $0x4,-0x1a4c(%ebp)
    4aae:	00 00 00 
    4ab1:	c7 85 b8 e5 ff ff 00 	movl   $0x0,-0x1a48(%ebp)
    4ab8:	00 00 00 
    4abb:	c7 85 bc e5 ff ff 00 	movl   $0x0,-0x1a44(%ebp)
    4ac2:	00 00 00 
    4ac5:	c7 85 c0 e5 ff ff ff 	movl   $0xffffffff,-0x1a40(%ebp)
    4acc:	ff ff ff 
    4acf:	c7 85 c4 e5 ff ff 00 	movl   $0x0,-0x1a3c(%ebp)
    4ad6:	00 00 00 
    4ad9:	c7 85 c8 e5 ff ff 00 	movl   $0x0,-0x1a38(%ebp)
    4ae0:	00 00 00 
    4ae3:	8d 85 26 ff ff ff    	lea    -0xda(%ebp),%eax
    4ae9:	89 85 cc e5 ff ff    	mov    %eax,-0x1a34(%ebp)
    4aef:	c7 85 d0 e5 ff ff 1f 	movl   $0x1f,-0x1a30(%ebp)
    4af6:	00 00 00 
    4af9:	66 c7 85 d4 e5 ff ff 	movw   $0x37,-0x1a2c(%ebp)
    4b00:	37 00 
    4b02:	c6 85 d6 e5 ff ff 00 	movb   $0x0,-0x1a2a(%ebp)
    4b09:	c7 85 d8 e5 ff ff 06 	movl   $0x6,-0x1a28(%ebp)
    4b10:	00 00 00 
    4b13:	c7 85 dc e5 ff ff 06 	movl   $0x6,-0x1a24(%ebp)
    4b1a:	00 00 00 
    4b1d:	c7 85 e0 e5 ff ff 00 	movl   $0x0,-0x1a20(%ebp)
    4b24:	00 00 00 
    4b27:	c7 85 e4 e5 ff ff 00 	movl   $0x0,-0x1a1c(%ebp)
    4b2e:	00 00 00 
    4b31:	c7 85 e8 e5 ff ff ff 	movl   $0xffffffff,-0x1a18(%ebp)
    4b38:	ff ff ff 
    4b3b:	c7 85 ec e5 ff ff 00 	movl   $0x0,-0x1a14(%ebp)
    4b42:	00 00 00 
    4b45:	c7 85 f0 e5 ff ff 00 	movl   $0x0,-0x1a10(%ebp)
    4b4c:	00 00 00 
    4b4f:	8d 85 98 fe ff ff    	lea    -0x168(%ebp),%eax
    4b55:	89 85 f4 e5 ff ff    	mov    %eax,-0x1a0c(%ebp)
    4b5b:	c7 85 f8 e5 ff ff 47 	movl   $0x47,-0x1a08(%ebp)
    4b62:	00 00 00 
    4b65:	66 c7 85 fc e5 ff ff 	movw   $0x38,-0x1a04(%ebp)
    4b6c:	38 00 
    4b6e:	c6 85 fe e5 ff ff 00 	movb   $0x0,-0x1a02(%ebp)
    4b75:	c7 85 00 e6 ff ff 06 	movl   $0x6,-0x1a00(%ebp)
    4b7c:	00 00 00 
    4b7f:	c7 85 04 e6 ff ff 06 	movl   $0x6,-0x19fc(%ebp)
    4b86:	00 00 00 
    4b89:	c7 85 08 e6 ff ff 00 	movl   $0x0,-0x19f8(%ebp)
    4b90:	00 00 00 
    4b93:	c7 85 0c e6 ff ff 00 	movl   $0x0,-0x19f4(%ebp)
    4b9a:	00 00 00 
    4b9d:	c7 85 10 e6 ff ff ff 	movl   $0xffffffff,-0x19f0(%ebp)
    4ba4:	ff ff ff 
    4ba7:	c7 85 14 e6 ff ff 00 	movl   $0x0,-0x19ec(%ebp)
    4bae:	00 00 00 
    4bb1:	c7 85 18 e6 ff ff 00 	movl   $0x0,-0x19e8(%ebp)
    4bb8:	00 00 00 
    4bbb:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    4bc1:	89 85 1c e6 ff ff    	mov    %eax,-0x19e4(%ebp)
    4bc7:	c7 85 20 e6 ff ff 47 	movl   $0x47,-0x19e0(%ebp)
    4bce:	00 00 00 
    4bd1:	66 c7 85 24 e6 ff ff 	movw   $0x39,-0x19dc(%ebp)
    4bd8:	39 00 
    4bda:	c6 85 26 e6 ff ff 00 	movb   $0x0,-0x19da(%ebp)
    4be1:	c7 85 28 e6 ff ff 06 	movl   $0x6,-0x19d8(%ebp)
    4be8:	00 00 00 
    4beb:	c7 85 2c e6 ff ff 06 	movl   $0x6,-0x19d4(%ebp)
    4bf2:	00 00 00 
    4bf5:	c7 85 30 e6 ff ff 00 	movl   $0x0,-0x19d0(%ebp)
    4bfc:	00 00 00 
    4bff:	c7 85 34 e6 ff ff 00 	movl   $0x0,-0x19cc(%ebp)
    4c06:	00 00 00 
    4c09:	c7 85 38 e6 ff ff ff 	movl   $0xffffffff,-0x19c8(%ebp)
    4c10:	ff ff ff 
    4c13:	c7 85 3c e6 ff ff 00 	movl   $0x0,-0x19c4(%ebp)
    4c1a:	00 00 00 
    4c1d:	c7 85 40 e6 ff ff 00 	movl   $0x0,-0x19c0(%ebp)
    4c24:	00 00 00 
    4c27:	8d 85 7c fd ff ff    	lea    -0x284(%ebp),%eax
    4c2d:	89 85 44 e6 ff ff    	mov    %eax,-0x19bc(%ebp)
    4c33:	c7 85 48 e6 ff ff 47 	movl   $0x47,-0x19b8(%ebp)
    4c3a:	00 00 00 
    4c3d:	66 c7 85 4c e6 ff ff 	movw   $0x3031,-0x19b4(%ebp)
    4c44:	31 30 
    4c46:	c6 85 4e e6 ff ff 00 	movb   $0x0,-0x19b2(%ebp)
    4c4d:	c7 85 50 e6 ff ff 08 	movl   $0x8,-0x19b0(%ebp)
    4c54:	00 00 00 
    4c57:	c7 85 54 e6 ff ff 08 	movl   $0x8,-0x19ac(%ebp)
    4c5e:	00 00 00 
    4c61:	c7 85 58 e6 ff ff 00 	movl   $0x0,-0x19a8(%ebp)
    4c68:	00 00 00 
    4c6b:	c7 85 5c e6 ff ff 00 	movl   $0x0,-0x19a4(%ebp)
    4c72:	00 00 00 
    4c75:	c7 85 60 e6 ff ff ff 	movl   $0xffffffff,-0x19a0(%ebp)
    4c7c:	ff ff ff 
    4c7f:	c7 85 64 e6 ff ff 00 	movl   $0x0,-0x199c(%ebp)
    4c86:	00 00 00 
    4c89:	c7 85 68 e6 ff ff 00 	movl   $0x0,-0x1998(%ebp)
    4c90:	00 00 00 
    4c93:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    4c99:	89 85 6c e6 ff ff    	mov    %eax,-0x1994(%ebp)
    4c9f:	c7 85 70 e6 ff ff 7f 	movl   $0x7f,-0x1990(%ebp)
    4ca6:	00 00 00 
    4ca9:	66 c7 85 74 e6 ff ff 	movw   $0x3131,-0x198c(%ebp)
    4cb0:	31 31 
    4cb2:	c6 85 76 e6 ff ff 00 	movb   $0x0,-0x198a(%ebp)
    4cb9:	c7 85 78 e6 ff ff 08 	movl   $0x8,-0x1988(%ebp)
    4cc0:	00 00 00 
    4cc3:	c7 85 7c e6 ff ff 08 	movl   $0x8,-0x1984(%ebp)
    4cca:	00 00 00 
    4ccd:	c7 85 80 e6 ff ff 00 	movl   $0x0,-0x1980(%ebp)
    4cd4:	00 00 00 
    4cd7:	c7 85 84 e6 ff ff 00 	movl   $0x0,-0x197c(%ebp)
    4cde:	00 00 00 
    4ce1:	c7 85 88 e6 ff ff ff 	movl   $0xffffffff,-0x1978(%ebp)
    4ce8:	ff ff ff 
    4ceb:	c7 85 8c e6 ff ff 00 	movl   $0x0,-0x1974(%ebp)
    4cf2:	00 00 00 
    4cf5:	c7 85 90 e6 ff ff 00 	movl   $0x0,-0x1970(%ebp)
    4cfc:	00 00 00 
    4cff:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
    4d05:	89 85 94 e6 ff ff    	mov    %eax,-0x196c(%ebp)
    4d0b:	c7 85 98 e6 ff ff 7f 	movl   $0x7f,-0x1968(%ebp)
    4d12:	00 00 00 
    4d15:	66 c7 85 9c e6 ff ff 	movw   $0x3231,-0x1964(%ebp)
    4d1c:	31 32 
    4d1e:	c6 85 9e e6 ff ff 00 	movb   $0x0,-0x1962(%ebp)
    4d25:	c7 85 a0 e6 ff ff 08 	movl   $0x8,-0x1960(%ebp)
    4d2c:	00 00 00 
    4d2f:	c7 85 a4 e6 ff ff 08 	movl   $0x8,-0x195c(%ebp)
    4d36:	00 00 00 
    4d39:	c7 85 a8 e6 ff ff 00 	movl   $0x0,-0x1958(%ebp)
    4d40:	00 00 00 
    4d43:	c7 85 ac e6 ff ff 00 	movl   $0x0,-0x1954(%ebp)
    4d4a:	00 00 00 
    4d4d:	c7 85 b0 e6 ff ff ff 	movl   $0xffffffff,-0x1950(%ebp)
    4d54:	ff ff ff 
    4d57:	c7 85 b4 e6 ff ff 00 	movl   $0x0,-0x194c(%ebp)
    4d5e:	00 00 00 
    4d61:	c7 85 b8 e6 ff ff 00 	movl   $0x0,-0x1948(%ebp)
    4d68:	00 00 00 
    4d6b:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    4d71:	89 85 bc e6 ff ff    	mov    %eax,-0x1944(%ebp)
    4d77:	c7 85 c0 e6 ff ff 7f 	movl   $0x7f,-0x1940(%ebp)
    4d7e:	00 00 00 
    4d81:	66 c7 85 c4 e6 ff ff 	movw   $0x3331,-0x193c(%ebp)
    4d88:	31 33 
    4d8a:	c6 85 c6 e6 ff ff 00 	movb   $0x0,-0x193a(%ebp)
    4d91:	c7 85 c8 e6 ff ff 10 	movl   $0x10,-0x1938(%ebp)
    4d98:	00 00 00 
    4d9b:	c7 85 cc e6 ff ff 10 	movl   $0x10,-0x1934(%ebp)
    4da2:	00 00 00 
    4da5:	c7 85 d0 e6 ff ff 00 	movl   $0x0,-0x1930(%ebp)
    4dac:	00 00 00 
    4daf:	c7 85 d4 e6 ff ff 00 	movl   $0x0,-0x192c(%ebp)
    4db6:	00 00 00 
    4db9:	c7 85 d8 e6 ff ff ff 	movl   $0xffffffff,-0x1928(%ebp)
    4dc0:	ff ff ff 
    4dc3:	c7 85 dc e6 ff ff 00 	movl   $0x0,-0x1924(%ebp)
    4dca:	00 00 00 
    4dcd:	c7 85 e0 e6 ff ff 00 	movl   $0x0,-0x1920(%ebp)
    4dd4:	00 00 00 
    4dd7:	8d 85 84 f6 ff ff    	lea    -0x97c(%ebp),%eax
    4ddd:	89 85 e4 e6 ff ff    	mov    %eax,-0x191c(%ebp)
    4de3:	c7 85 e8 e6 ff ff ff 	movl   $0x1ff,-0x1918(%ebp)
    4dea:	01 00 00 
    4ded:	66 c7 85 ec e6 ff ff 	movw   $0x3431,-0x1914(%ebp)
    4df4:	31 34 
    4df6:	c6 85 ee e6 ff ff 00 	movb   $0x0,-0x1912(%ebp)
    4dfd:	c7 85 f0 e6 ff ff 00 	movl   $0x0,-0x1910(%ebp)
    4e04:	00 00 00 
    4e07:	c7 85 f4 e6 ff ff 00 	movl   $0x0,-0x190c(%ebp)
    4e0e:	00 00 00 
    4e11:	c7 85 f8 e6 ff ff 00 	movl   $0x0,-0x1908(%ebp)
    4e18:	00 00 00 
    4e1b:	c7 85 fc e6 ff ff 00 	movl   $0x0,-0x1904(%ebp)
    4e22:	00 00 00 
    4e25:	c7 85 00 e7 ff ff ff 	movl   $0xffffffff,-0x1900(%ebp)
    4e2c:	ff ff ff 
    4e2f:	c7 85 04 e7 ff ff 00 	movl   $0x0,-0x18fc(%ebp)
    4e36:	00 00 00 
    4e39:	c7 85 08 e7 ff ff 00 	movl   $0x0,-0x18f8(%ebp)
    4e40:	00 00 00 
    4e43:	c7 85 0c e7 ff ff 00 	movl   $0x0,-0x18f4(%ebp)
    4e4a:	00 00 00 
    4e4d:	c7 85 10 e7 ff ff 00 	movl   $0x0,-0x18f0(%ebp)
    4e54:	00 00 00 
    4e57:	66 c7 85 14 e7 ff ff 	movw   $0x3531,-0x18ec(%ebp)
    4e5e:	31 35 
    4e60:	c6 85 16 e7 ff ff 00 	movb   $0x0,-0x18ea(%ebp)
    4e67:	c7 85 18 e7 ff ff 10 	movl   $0x10,-0x18e8(%ebp)
    4e6e:	00 00 00 
    4e71:	c7 85 1c e7 ff ff 10 	movl   $0x10,-0x18e4(%ebp)
    4e78:	00 00 00 
    4e7b:	c7 85 20 e7 ff ff 00 	movl   $0x0,-0x18e0(%ebp)
    4e82:	00 00 00 
    4e85:	c7 85 24 e7 ff ff 00 	movl   $0x0,-0x18dc(%ebp)
    4e8c:	00 00 00 
    4e8f:	c7 85 28 e7 ff ff ff 	movl   $0xffffffff,-0x18d8(%ebp)
    4e96:	ff ff ff 
    4e99:	c7 85 2c e7 ff ff 00 	movl   $0x0,-0x18d4(%ebp)
    4ea0:	00 00 00 
    4ea3:	c7 85 30 e7 ff ff 00 	movl   $0x0,-0x18d0(%ebp)
    4eaa:	00 00 00 
    4ead:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    4eb3:	89 85 34 e7 ff ff    	mov    %eax,-0x18cc(%ebp)
    4eb9:	c7 85 38 e7 ff ff ff 	movl   $0x1ff,-0x18c8(%ebp)
    4ec0:	01 00 00 
    4ec3:	66 c7 85 3c e7 ff ff 	movw   $0x3631,-0x18c4(%ebp)
    4eca:	31 36 
    4ecc:	c6 85 3e e7 ff ff 00 	movb   $0x0,-0x18c2(%ebp)
    4ed3:	c7 85 40 e7 ff ff 10 	movl   $0x10,-0x18c0(%ebp)
    4eda:	00 00 00 
    4edd:	c7 85 44 e7 ff ff 10 	movl   $0x10,-0x18bc(%ebp)
    4ee4:	00 00 00 
    4ee7:	c7 85 48 e7 ff ff 01 	movl   $0x1,-0x18b8(%ebp)
    4eee:	00 00 00 
    4ef1:	c7 85 4c e7 ff ff 01 	movl   $0x1,-0x18b4(%ebp)
    4ef8:	00 00 00 
    4efb:	c7 85 50 e7 ff ff ff 	movl   $0xffffffff,-0x18b0(%ebp)
    4f02:	ff ff ff 
    4f05:	c7 85 54 e7 ff ff 00 	movl   $0x0,-0x18ac(%ebp)
    4f0c:	00 00 00 
    4f0f:	c7 85 58 e7 ff ff 00 	movl   $0x0,-0x18a8(%ebp)
    4f16:	00 00 00 
    4f19:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4f1f:	89 85 5c e7 ff ff    	mov    %eax,-0x18a4(%ebp)
    4f25:	c7 85 60 e7 ff ff ff 	movl   $0x1ff,-0x18a0(%ebp)
    4f2c:	01 00 00 
    4f2f:	66 c7 85 64 e7 ff ff 	movw   $0x3731,-0x189c(%ebp)
    4f36:	31 37 
    4f38:	c6 85 66 e7 ff ff 00 	movb   $0x0,-0x189a(%ebp)
    4f3f:	c7 85 68 e7 ff ff 10 	movl   $0x10,-0x1898(%ebp)
    4f46:	00 00 00 
    4f49:	c7 85 6c e7 ff ff 10 	movl   $0x10,-0x1894(%ebp)
    4f50:	00 00 00 
    4f53:	c7 85 70 e7 ff ff 02 	movl   $0x2,-0x1890(%ebp)
    4f5a:	00 00 00 
    4f5d:	c7 85 74 e7 ff ff 03 	movl   $0x3,-0x188c(%ebp)
    4f64:	00 00 00 
    4f67:	c7 85 78 e7 ff ff 10 	movl   $0x10,-0x1888(%ebp)
    4f6e:	00 00 00 
    4f71:	c7 85 7c e7 ff ff 00 	movl   $0x0,-0x1884(%ebp)
    4f78:	00 00 00 
    4f7b:	c7 85 80 e7 ff ff 00 	movl   $0x0,-0x1880(%ebp)
    4f82:	00 00 00 
    4f85:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4f8b:	89 85 84 e7 ff ff    	mov    %eax,-0x187c(%ebp)
    4f91:	c7 85 88 e7 ff ff ff 	movl   $0x1ff,-0x1878(%ebp)
    4f98:	01 00 00 
    4f9b:	66 c7 85 8c e7 ff ff 	movw   $0x3831,-0x1874(%ebp)
    4fa2:	31 38 
    4fa4:	c6 85 8e e7 ff ff 00 	movb   $0x0,-0x1872(%ebp)
    4fab:	c7 85 90 e7 ff ff 10 	movl   $0x10,-0x1870(%ebp)
    4fb2:	00 00 00 
    4fb5:	c7 85 94 e7 ff ff 10 	movl   $0x10,-0x186c(%ebp)
    4fbc:	00 00 00 
    4fbf:	c7 85 98 e7 ff ff 03 	movl   $0x3,-0x1868(%ebp)
    4fc6:	00 00 00 
    4fc9:	c7 85 9c e7 ff ff 07 	movl   $0x7,-0x1864(%ebp)
    4fd0:	00 00 00 
    4fd3:	c7 85 a0 e7 ff ff 10 	movl   $0x10,-0x1860(%ebp)
    4fda:	00 00 00 
    4fdd:	c7 85 a4 e7 ff ff 00 	movl   $0x0,-0x185c(%ebp)
    4fe4:	00 00 00 
    4fe7:	c7 85 a8 e7 ff ff 00 	movl   $0x0,-0x1858(%ebp)
    4fee:	00 00 00 
    4ff1:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4ff7:	89 85 ac e7 ff ff    	mov    %eax,-0x1854(%ebp)
    4ffd:	c7 85 b0 e7 ff ff ff 	movl   $0x1ff,-0x1850(%ebp)
    5004:	01 00 00 
    5007:	66 c7 85 b4 e7 ff ff 	movw   $0x3931,-0x184c(%ebp)
    500e:	31 39 
    5010:	c6 85 b6 e7 ff ff 00 	movb   $0x0,-0x184a(%ebp)
    5017:	c7 85 b8 e7 ff ff 10 	movl   $0x10,-0x1848(%ebp)
    501e:	00 00 00 
    5021:	c7 85 bc e7 ff ff 10 	movl   $0x10,-0x1844(%ebp)
    5028:	00 00 00 
    502b:	c7 85 c0 e7 ff ff 04 	movl   $0x4,-0x1840(%ebp)
    5032:	00 00 00 
    5035:	c7 85 c4 e7 ff ff 0f 	movl   $0xf,-0x183c(%ebp)
    503c:	00 00 00 
    503f:	c7 85 c8 e7 ff ff 10 	movl   $0x10,-0x1838(%ebp)
    5046:	00 00 00 
    5049:	c7 85 cc e7 ff ff 00 	movl   $0x0,-0x1834(%ebp)
    5050:	00 00 00 
    5053:	c7 85 d0 e7 ff ff 00 	movl   $0x0,-0x1830(%ebp)
    505a:	00 00 00 
    505d:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    5063:	89 85 d4 e7 ff ff    	mov    %eax,-0x182c(%ebp)
    5069:	c7 85 d8 e7 ff ff ff 	movl   $0x1ff,-0x1828(%ebp)
    5070:	01 00 00 
    5073:	66 c7 85 dc e7 ff ff 	movw   $0x3032,-0x1824(%ebp)
    507a:	32 30 
    507c:	c6 85 de e7 ff ff 00 	movb   $0x0,-0x1822(%ebp)
    5083:	c7 85 e0 e7 ff ff 10 	movl   $0x10,-0x1820(%ebp)
    508a:	00 00 00 
    508d:	c7 85 e4 e7 ff ff 10 	movl   $0x10,-0x181c(%ebp)
    5094:	00 00 00 
    5097:	c7 85 e8 e7 ff ff 06 	movl   $0x6,-0x1818(%ebp)
    509e:	00 00 00 
    50a1:	c7 85 ec e7 ff ff 3f 	movl   $0x3f,-0x1814(%ebp)
    50a8:	00 00 00 
    50ab:	c7 85 f0 e7 ff ff 10 	movl   $0x10,-0x1810(%ebp)
    50b2:	00 00 00 
    50b5:	c7 85 f4 e7 ff ff 00 	movl   $0x0,-0x180c(%ebp)
    50bc:	00 00 00 
    50bf:	c7 85 f8 e7 ff ff 00 	movl   $0x0,-0x1808(%ebp)
    50c6:	00 00 00 
    50c9:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    50cf:	89 85 fc e7 ff ff    	mov    %eax,-0x1804(%ebp)
    50d5:	c7 85 00 e8 ff ff ff 	movl   $0x1ff,-0x1800(%ebp)
    50dc:	01 00 00 
    50df:	66 c7 85 04 e8 ff ff 	movw   $0x3132,-0x17fc(%ebp)
    50e6:	32 31 
    50e8:	c6 85 06 e8 ff ff 00 	movb   $0x0,-0x17fa(%ebp)
    50ef:	c7 85 08 e8 ff ff 10 	movl   $0x10,-0x17f8(%ebp)
    50f6:	00 00 00 
    50f9:	c7 85 0c e8 ff ff 10 	movl   $0x10,-0x17f4(%ebp)
    5100:	00 00 00 
    5103:	c7 85 10 e8 ff ff 08 	movl   $0x8,-0x17f0(%ebp)
    510a:	00 00 00 
    510d:	c7 85 14 e8 ff ff ff 	movl   $0xff,-0x17ec(%ebp)
    5114:	00 00 00 
    5117:	c7 85 18 e8 ff ff 10 	movl   $0x10,-0x17e8(%ebp)
    511e:	00 00 00 
    5121:	c7 85 1c e8 ff ff 00 	movl   $0x0,-0x17e4(%ebp)
    5128:	00 00 00 
    512b:	c7 85 20 e8 ff ff 00 	movl   $0x0,-0x17e0(%ebp)
    5132:	00 00 00 
    5135:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    513b:	89 85 24 e8 ff ff    	mov    %eax,-0x17dc(%ebp)
    5141:	c7 85 28 e8 ff ff ff 	movl   $0x1ff,-0x17d8(%ebp)
    5148:	01 00 00 
    514b:	66 c7 85 2c e8 ff ff 	movw   $0x3232,-0x17d4(%ebp)
    5152:	32 32 
    5154:	c6 85 2e e8 ff ff 00 	movb   $0x0,-0x17d2(%ebp)
    515b:	c7 85 30 e8 ff ff 10 	movl   $0x10,-0x17d0(%ebp)
    5162:	00 00 00 
    5165:	c7 85 34 e8 ff ff 10 	movl   $0x10,-0x17cc(%ebp)
    516c:	00 00 00 
    516f:	c7 85 38 e8 ff ff 0a 	movl   $0xa,-0x17c8(%ebp)
    5176:	00 00 00 
    5179:	c7 85 3c e8 ff ff ff 	movl   $0x3ff,-0x17c4(%ebp)
    5180:	03 00 00 
    5183:	c7 85 40 e8 ff ff 10 	movl   $0x10,-0x17c0(%ebp)
    518a:	00 00 00 
    518d:	c7 85 44 e8 ff ff 00 	movl   $0x0,-0x17bc(%ebp)
    5194:	00 00 00 
    5197:	c7 85 48 e8 ff ff 00 	movl   $0x0,-0x17b8(%ebp)
    519e:	00 00 00 
    51a1:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    51a7:	89 85 4c e8 ff ff    	mov    %eax,-0x17b4(%ebp)
    51ad:	c7 85 50 e8 ff ff ff 	movl   $0x1ff,-0x17b0(%ebp)
    51b4:	01 00 00 
    51b7:	66 c7 85 54 e8 ff ff 	movw   $0x3332,-0x17ac(%ebp)
    51be:	32 33 
    51c0:	c6 85 56 e8 ff ff 00 	movb   $0x0,-0x17aa(%ebp)
    51c7:	c7 85 58 e8 ff ff 10 	movl   $0x10,-0x17a8(%ebp)
    51ce:	00 00 00 
    51d1:	c7 85 5c e8 ff ff 10 	movl   $0x10,-0x17a4(%ebp)
    51d8:	00 00 00 
    51db:	c7 85 60 e8 ff ff 0d 	movl   $0xd,-0x17a0(%ebp)
    51e2:	00 00 00 
    51e5:	c7 85 64 e8 ff ff ff 	movl   $0x1fff,-0x179c(%ebp)
    51ec:	1f 00 00 
    51ef:	c7 85 68 e8 ff ff 10 	movl   $0x10,-0x1798(%ebp)
    51f6:	00 00 00 
    51f9:	c7 85 6c e8 ff ff 00 	movl   $0x0,-0x1794(%ebp)
    5200:	00 00 00 
    5203:	c7 85 70 e8 ff ff 00 	movl   $0x0,-0x1790(%ebp)
    520a:	00 00 00 
    520d:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    5213:	89 85 74 e8 ff ff    	mov    %eax,-0x178c(%ebp)
    5219:	c7 85 78 e8 ff ff ff 	movl   $0x1ff,-0x1788(%ebp)
    5220:	01 00 00 
    5223:	66 c7 85 7c e8 ff ff 	movw   $0x3432,-0x1784(%ebp)
    522a:	32 34 
    522c:	c6 85 7e e8 ff ff 00 	movb   $0x0,-0x1782(%ebp)
    5233:	c7 85 80 e8 ff ff 10 	movl   $0x10,-0x1780(%ebp)
    523a:	00 00 00 
    523d:	c7 85 84 e8 ff ff 10 	movl   $0x10,-0x177c(%ebp)
    5244:	00 00 00 
    5247:	c7 85 88 e8 ff ff 04 	movl   $0x4,-0x1778(%ebp)
    524e:	00 00 00 
    5251:	c7 85 8c e8 ff ff 0f 	movl   $0xf,-0x1774(%ebp)
    5258:	00 00 00 
    525b:	c7 85 90 e8 ff ff ff 	movl   $0xffffffff,-0x1770(%ebp)
    5262:	ff ff ff 
    5265:	c7 85 94 e8 ff ff 00 	movl   $0x0,-0x176c(%ebp)
    526c:	00 00 00 
    526f:	c7 85 98 e8 ff ff 00 	movl   $0x0,-0x1768(%ebp)
    5276:	00 00 00 
    5279:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    527f:	89 85 9c e8 ff ff    	mov    %eax,-0x1764(%ebp)
    5285:	c7 85 a0 e8 ff ff 00 	movl   $0x200,-0x1760(%ebp)
    528c:	02 00 00 
    528f:	66 c7 85 a4 e8 ff ff 	movw   $0x3532,-0x175c(%ebp)
    5296:	32 35 
    5298:	c6 85 a6 e8 ff ff 00 	movb   $0x0,-0x175a(%ebp)
    529f:	c7 85 a8 e8 ff ff 10 	movl   $0x10,-0x1758(%ebp)
    52a6:	00 00 00 
    52a9:	c7 85 ac e8 ff ff 10 	movl   $0x10,-0x1754(%ebp)
    52b0:	00 00 00 
    52b3:	c7 85 b0 e8 ff ff 05 	movl   $0x5,-0x1750(%ebp)
    52ba:	00 00 00 
    52bd:	c7 85 b4 e8 ff ff 1f 	movl   $0x1f,-0x174c(%ebp)
    52c4:	00 00 00 
    52c7:	c7 85 b8 e8 ff ff 18 	movl   $0x18,-0x1748(%ebp)
    52ce:	00 00 00 
    52d1:	c7 85 bc e8 ff ff 00 	movl   $0x0,-0x1744(%ebp)
    52d8:	00 00 00 
    52db:	c7 85 c0 e8 ff ff 00 	movl   $0x0,-0x1740(%ebp)
    52e2:	00 00 00 
    52e5:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    52eb:	89 85 c4 e8 ff ff    	mov    %eax,-0x173c(%ebp)
    52f1:	c7 85 c8 e8 ff ff 00 	movl   $0x200,-0x1738(%ebp)
    52f8:	02 00 00 
    52fb:	66 c7 85 cc e8 ff ff 	movw   $0x3632,-0x1734(%ebp)
    5302:	32 36 
    5304:	c6 85 ce e8 ff ff 00 	movb   $0x0,-0x1732(%ebp)
    530b:	c7 85 d0 e8 ff ff 10 	movl   $0x10,-0x1730(%ebp)
    5312:	00 00 00 
    5315:	c7 85 d4 e8 ff ff 10 	movl   $0x10,-0x172c(%ebp)
    531c:	00 00 00 
    531f:	c7 85 d8 e8 ff ff 06 	movl   $0x6,-0x1728(%ebp)
    5326:	00 00 00 
    5329:	c7 85 dc e8 ff ff 3f 	movl   $0x3f,-0x1724(%ebp)
    5330:	00 00 00 
    5333:	c7 85 e0 e8 ff ff 18 	movl   $0x18,-0x1720(%ebp)
    533a:	00 00 00 
    533d:	c7 85 e4 e8 ff ff 00 	movl   $0x0,-0x171c(%ebp)
    5344:	00 00 00 
    5347:	c7 85 e8 e8 ff ff 00 	movl   $0x0,-0x1718(%ebp)
    534e:	00 00 00 
    5351:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    5357:	89 85 ec e8 ff ff    	mov    %eax,-0x1714(%ebp)
    535d:	c7 85 f0 e8 ff ff 00 	movl   $0x200,-0x1710(%ebp)
    5364:	02 00 00 
    5367:	66 c7 85 f4 e8 ff ff 	movw   $0x3732,-0x170c(%ebp)
    536e:	32 37 
    5370:	c6 85 f6 e8 ff ff 00 	movb   $0x0,-0x170a(%ebp)
    5377:	c7 85 f8 e8 ff ff 10 	movl   $0x10,-0x1708(%ebp)
    537e:	00 00 00 
    5381:	c7 85 fc e8 ff ff 10 	movl   $0x10,-0x1704(%ebp)
    5388:	00 00 00 
    538b:	c7 85 00 e9 ff ff 07 	movl   $0x7,-0x1700(%ebp)
    5392:	00 00 00 
    5395:	c7 85 04 e9 ff ff 7f 	movl   $0x7f,-0x16fc(%ebp)
    539c:	00 00 00 
    539f:	c7 85 08 e9 ff ff 18 	movl   $0x18,-0x16f8(%ebp)
    53a6:	00 00 00 
    53a9:	c7 85 0c e9 ff ff 00 	movl   $0x0,-0x16f4(%ebp)
    53b0:	00 00 00 
    53b3:	c7 85 10 e9 ff ff 00 	movl   $0x0,-0x16f0(%ebp)
    53ba:	00 00 00 
    53bd:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    53c3:	89 85 14 e9 ff ff    	mov    %eax,-0x16ec(%ebp)
    53c9:	c7 85 18 e9 ff ff 00 	movl   $0x200,-0x16e8(%ebp)
    53d0:	02 00 00 
    53d3:	66 c7 85 1c e9 ff ff 	movw   $0x3832,-0x16e4(%ebp)
    53da:	32 38 
    53dc:	c6 85 1e e9 ff ff 00 	movb   $0x0,-0x16e2(%ebp)
    53e3:	c7 85 20 e9 ff ff 10 	movl   $0x10,-0x16e0(%ebp)
    53ea:	00 00 00 
    53ed:	c7 85 24 e9 ff ff 10 	movl   $0x10,-0x16dc(%ebp)
    53f4:	00 00 00 
    53f7:	c7 85 28 e9 ff ff 08 	movl   $0x8,-0x16d8(%ebp)
    53fe:	00 00 00 
    5401:	c7 85 2c e9 ff ff ff 	movl   $0xff,-0x16d4(%ebp)
    5408:	00 00 00 
    540b:	c7 85 30 e9 ff ff 18 	movl   $0x18,-0x16d0(%ebp)
    5412:	00 00 00 
    5415:	c7 85 34 e9 ff ff 00 	movl   $0x0,-0x16cc(%ebp)
    541c:	00 00 00 
    541f:	c7 85 38 e9 ff ff 00 	movl   $0x0,-0x16c8(%ebp)
    5426:	00 00 00 
    5429:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    542f:	89 85 3c e9 ff ff    	mov    %eax,-0x16c4(%ebp)
    5435:	c7 85 40 e9 ff ff 00 	movl   $0x200,-0x16c0(%ebp)
    543c:	02 00 00 
    543f:	66 c7 85 44 e9 ff ff 	movw   $0x3932,-0x16bc(%ebp)
    5446:	32 39 
    5448:	c6 85 46 e9 ff ff 00 	movb   $0x0,-0x16ba(%ebp)
    544f:	c7 85 48 e9 ff ff 10 	movl   $0x10,-0x16b8(%ebp)
    5456:	00 00 00 
    5459:	c7 85 4c e9 ff ff 10 	movl   $0x10,-0x16b4(%ebp)
    5460:	00 00 00 
    5463:	c7 85 50 e9 ff ff 09 	movl   $0x9,-0x16b0(%ebp)
    546a:	00 00 00 
    546d:	c7 85 54 e9 ff ff ff 	movl   $0x1ff,-0x16ac(%ebp)
    5474:	01 00 00 
    5477:	c7 85 58 e9 ff ff 18 	movl   $0x18,-0x16a8(%ebp)
    547e:	00 00 00 
    5481:	c7 85 5c e9 ff ff 00 	movl   $0x0,-0x16a4(%ebp)
    5488:	00 00 00 
    548b:	c7 85 60 e9 ff ff 00 	movl   $0x0,-0x16a0(%ebp)
    5492:	00 00 00 
    5495:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    549b:	89 85 64 e9 ff ff    	mov    %eax,-0x169c(%ebp)
    54a1:	c7 85 68 e9 ff ff 00 	movl   $0x200,-0x1698(%ebp)
    54a8:	02 00 00 
    54ab:	66 c7 85 6c e9 ff ff 	movw   $0x3033,-0x1694(%ebp)
    54b2:	33 30 
    54b4:	c6 85 6e e9 ff ff 00 	movb   $0x0,-0x1692(%ebp)
    54bb:	c7 85 70 e9 ff ff 10 	movl   $0x10,-0x1690(%ebp)
    54c2:	00 00 00 
    54c5:	c7 85 74 e9 ff ff 10 	movl   $0x10,-0x168c(%ebp)
    54cc:	00 00 00 
    54cf:	c7 85 78 e9 ff ff 0b 	movl   $0xb,-0x1688(%ebp)
    54d6:	00 00 00 
    54d9:	c7 85 7c e9 ff ff ff 	movl   $0x7ff,-0x1684(%ebp)
    54e0:	07 00 00 
    54e3:	c7 85 80 e9 ff ff 18 	movl   $0x18,-0x1680(%ebp)
    54ea:	00 00 00 
    54ed:	c7 85 84 e9 ff ff 00 	movl   $0x0,-0x167c(%ebp)
    54f4:	00 00 00 
    54f7:	c7 85 88 e9 ff ff 00 	movl   $0x0,-0x1678(%ebp)
    54fe:	00 00 00 
    5501:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    5507:	89 85 8c e9 ff ff    	mov    %eax,-0x1674(%ebp)
    550d:	c7 85 90 e9 ff ff 00 	movl   $0x200,-0x1670(%ebp)
    5514:	02 00 00 
    5517:	66 c7 85 94 e9 ff ff 	movw   $0x3133,-0x166c(%ebp)
    551e:	33 31 
    5520:	c6 85 96 e9 ff ff 00 	movb   $0x0,-0x166a(%ebp)
    5527:	c7 85 98 e9 ff ff 10 	movl   $0x10,-0x1668(%ebp)
    552e:	00 00 00 
    5531:	c7 85 9c e9 ff ff 10 	movl   $0x10,-0x1664(%ebp)
    5538:	00 00 00 
    553b:	c7 85 a0 e9 ff ff 0d 	movl   $0xd,-0x1660(%ebp)
    5542:	00 00 00 
    5545:	c7 85 a4 e9 ff ff ff 	movl   $0x1fff,-0x165c(%ebp)
    554c:	1f 00 00 
    554f:	c7 85 a8 e9 ff ff 18 	movl   $0x18,-0x1658(%ebp)
    5556:	00 00 00 
    5559:	c7 85 ac e9 ff ff 00 	movl   $0x0,-0x1654(%ebp)
    5560:	00 00 00 
    5563:	c7 85 b0 e9 ff ff 00 	movl   $0x0,-0x1650(%ebp)
    556a:	00 00 00 
    556d:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    5573:	89 85 b4 e9 ff ff    	mov    %eax,-0x164c(%ebp)
    5579:	c7 85 b8 e9 ff ff 00 	movl   $0x200,-0x1648(%ebp)
    5580:	02 00 00 
    5583:	66 c7 85 bc e9 ff ff 	movw   $0x3233,-0x1644(%ebp)
    558a:	33 32 
    558c:	c6 85 be e9 ff ff 00 	movb   $0x0,-0x1642(%ebp)
    5593:	c7 85 c0 e9 ff ff 01 	movl   $0x1,-0x1640(%ebp)
    559a:	00 00 00 
    559d:	c7 85 c4 e9 ff ff 10 	movl   $0x10,-0x163c(%ebp)
    55a4:	00 00 00 
    55a7:	c7 85 c8 e9 ff ff 00 	movl   $0x0,-0x1638(%ebp)
    55ae:	00 00 00 
    55b1:	c7 85 cc e9 ff ff 00 	movl   $0x0,-0x1634(%ebp)
    55b8:	00 00 00 
    55bb:	c7 85 d0 e9 ff ff ff 	movl   $0xffffffff,-0x1630(%ebp)
    55c2:	ff ff ff 
    55c5:	c7 85 d4 e9 ff ff 00 	movl   $0x0,-0x162c(%ebp)
    55cc:	00 00 00 
    55cf:	c7 85 d8 e9 ff ff 00 	movl   $0x0,-0x1628(%ebp)
    55d6:	00 00 00 
    55d9:	8d 85 4a ea ff ff    	lea    -0x15b6(%ebp),%eax
    55df:	89 85 dc e9 ff ff    	mov    %eax,-0x1624(%ebp)
    55e5:	c7 85 e0 e9 ff ff 1f 	movl   $0x1f,-0x1620(%ebp)
    55ec:	00 00 00 
    55ef:	66 c7 85 e4 e9 ff ff 	movw   $0x3333,-0x161c(%ebp)
    55f6:	33 33 
    55f8:	c6 85 e6 e9 ff ff 00 	movb   $0x0,-0x161a(%ebp)
    55ff:	c7 85 e8 e9 ff ff 01 	movl   $0x1,-0x1618(%ebp)
    5606:	00 00 00 
    5609:	c7 85 ec e9 ff ff 10 	movl   $0x10,-0x1614(%ebp)
    5610:	00 00 00 
    5613:	c7 85 f0 e9 ff ff 00 	movl   $0x0,-0x1610(%ebp)
    561a:	00 00 00 
    561d:	c7 85 f4 e9 ff ff 00 	movl   $0x0,-0x160c(%ebp)
    5624:	00 00 00 
    5627:	c7 85 f8 e9 ff ff ff 	movl   $0xffffffff,-0x1608(%ebp)
    562e:	ff ff ff 
    5631:	c7 85 fc e9 ff ff 00 	movl   $0x0,-0x1604(%ebp)
    5638:	00 00 00 
    563b:	c7 85 00 ea ff ff 00 	movl   $0x0,-0x1600(%ebp)
    5642:	00 00 00 
    5645:	8d 85 0c ea ff ff    	lea    -0x15f4(%ebp),%eax
    564b:	89 85 04 ea ff ff    	mov    %eax,-0x15fc(%ebp)
    5651:	c7 85 08 ea ff ff 1f 	movl   $0x1f,-0x15f8(%ebp)
    5658:	00 00 00 
		{"31", 16, 16, 13, 8191, 24, 0, 0, h24, 512},
		{"32", 1, 16, 0, 0, -1, 0, 0, hA, 31},
		{"33", 1, 16, 0, 0, -1, 0, 0, hB, 31}
	};
	ht[0] = ht[0];
}
    565b:	81 c4 40 1b 00 00    	add    $0x1b40,%esp
    5661:	5b                   	pop    %ebx
    5662:	5e                   	pop    %esi
    5663:	5f                   	pop    %edi
    5664:	5d                   	pop    %ebp
    5665:	c3                   	ret    

00005666 <huffman_decoder>:


/* ����huffman����	*/
/* ע��! ��counta,countb - 4 bit ֵ �� y����, discard x */
int huffman_decoder(struct huffcodetab *h, int *x, int *y, int *v, int *w)
{  
    5666:	55                   	push   %ebp
    5667:	89 e5                	mov    %esp,%ebp
    5669:	53                   	push   %ebx
    566a:	83 ec 24             	sub    $0x24,%esp
  HUFFBITS level;
  int point = 0;
    566d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int error = 1;
    5674:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  level     = dmask;
    567b:	a1 70 ce 00 00       	mov    0xce70,%eax
    5680:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (h->val == 0) return 2;
    5683:	8b 45 08             	mov    0x8(%ebp),%eax
    5686:	8b 40 20             	mov    0x20(%eax),%eax
    5689:	85 c0                	test   %eax,%eax
    568b:	75 0a                	jne    5697 <huffman_decoder+0x31>
    568d:	b8 02 00 00 00       	mov    $0x2,%eax
    5692:	e9 0d 03 00 00       	jmp    59a4 <huffman_decoder+0x33e>

  /* table 0 ����Ҫ bits */
  if ( h->treelen == 0)
    5697:	8b 45 08             	mov    0x8(%ebp),%eax
    569a:	8b 40 24             	mov    0x24(%eax),%eax
    569d:	85 c0                	test   %eax,%eax
    569f:	75 1d                	jne    56be <huffman_decoder+0x58>
  {  *x = *y = 0;
    56a1:	8b 45 10             	mov    0x10(%ebp),%eax
    56a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    56aa:	8b 45 10             	mov    0x10(%ebp),%eax
    56ad:	8b 10                	mov    (%eax),%edx
    56af:	8b 45 0c             	mov    0xc(%ebp),%eax
    56b2:	89 10                	mov    %edx,(%eax)
     return 0;
    56b4:	b8 00 00 00 00       	mov    $0x0,%eax
    56b9:	e9 e6 02 00 00       	jmp    59a4 <huffman_decoder+0x33e>


  /* ���� Huffman table. */

  do {
    if (h->val[point][0]==0) {   /*���Ľ�β*/
    56be:	8b 45 08             	mov    0x8(%ebp),%eax
    56c1:	8b 40 20             	mov    0x20(%eax),%eax
    56c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    56c7:	01 d2                	add    %edx,%edx
    56c9:	01 d0                	add    %edx,%eax
    56cb:	0f b6 00             	movzbl (%eax),%eax
    56ce:	84 c0                	test   %al,%al
    56d0:	75 46                	jne    5718 <huffman_decoder+0xb2>
      *x = h->val[point][1] >> 4;
    56d2:	8b 45 08             	mov    0x8(%ebp),%eax
    56d5:	8b 40 20             	mov    0x20(%eax),%eax
    56d8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    56db:	01 d2                	add    %edx,%edx
    56dd:	01 d0                	add    %edx,%eax
    56df:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    56e3:	c0 e8 04             	shr    $0x4,%al
    56e6:	0f b6 d0             	movzbl %al,%edx
    56e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    56ec:	89 10                	mov    %edx,(%eax)
      *y = h->val[point][1] & 0xf;
    56ee:	8b 45 08             	mov    0x8(%ebp),%eax
    56f1:	8b 40 20             	mov    0x20(%eax),%eax
    56f4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    56f7:	01 d2                	add    %edx,%edx
    56f9:	01 d0                	add    %edx,%eax
    56fb:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    56ff:	0f b6 c0             	movzbl %al,%eax
    5702:	83 e0 0f             	and    $0xf,%eax
    5705:	89 c2                	mov    %eax,%edx
    5707:	8b 45 10             	mov    0x10(%ebp),%eax
    570a:	89 10                	mov    %edx,(%eax)

      error = 0;
    570c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      break;
    5713:	e9 af 00 00 00       	jmp    57c7 <huffman_decoder+0x161>
    } 
    if (hget1bit()) {
    5718:	e8 a7 e6 ff ff       	call   3dc4 <hget1bit>
    571d:	85 c0                	test   %eax,%eax
    571f:	74 47                	je     5768 <huffman_decoder+0x102>
      while (h->val[point][1] >= MXOFF) point += h->val[point][1]; 
    5721:	eb 17                	jmp    573a <huffman_decoder+0xd4>
    5723:	8b 45 08             	mov    0x8(%ebp),%eax
    5726:	8b 40 20             	mov    0x20(%eax),%eax
    5729:	8b 55 f0             	mov    -0x10(%ebp),%edx
    572c:	01 d2                	add    %edx,%edx
    572e:	01 d0                	add    %edx,%eax
    5730:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5734:	0f b6 c0             	movzbl %al,%eax
    5737:	01 45 f0             	add    %eax,-0x10(%ebp)
    573a:	8b 45 08             	mov    0x8(%ebp),%eax
    573d:	8b 40 20             	mov    0x20(%eax),%eax
    5740:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5743:	01 d2                	add    %edx,%edx
    5745:	01 d0                	add    %edx,%eax
    5747:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    574b:	3c f9                	cmp    $0xf9,%al
    574d:	77 d4                	ja     5723 <huffman_decoder+0xbd>
      point += h->val[point][1];
    574f:	8b 45 08             	mov    0x8(%ebp),%eax
    5752:	8b 40 20             	mov    0x20(%eax),%eax
    5755:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5758:	01 d2                	add    %edx,%edx
    575a:	01 d0                	add    %edx,%eax
    575c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5760:	0f b6 c0             	movzbl %al,%eax
    5763:	01 45 f0             	add    %eax,-0x10(%ebp)
    5766:	eb 42                	jmp    57aa <huffman_decoder+0x144>
    }
    else {
      while (h->val[point][0] >= MXOFF) point += h->val[point][0]; 
    5768:	eb 16                	jmp    5780 <huffman_decoder+0x11a>
    576a:	8b 45 08             	mov    0x8(%ebp),%eax
    576d:	8b 40 20             	mov    0x20(%eax),%eax
    5770:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5773:	01 d2                	add    %edx,%edx
    5775:	01 d0                	add    %edx,%eax
    5777:	0f b6 00             	movzbl (%eax),%eax
    577a:	0f b6 c0             	movzbl %al,%eax
    577d:	01 45 f0             	add    %eax,-0x10(%ebp)
    5780:	8b 45 08             	mov    0x8(%ebp),%eax
    5783:	8b 40 20             	mov    0x20(%eax),%eax
    5786:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5789:	01 d2                	add    %edx,%edx
    578b:	01 d0                	add    %edx,%eax
    578d:	0f b6 00             	movzbl (%eax),%eax
    5790:	3c f9                	cmp    $0xf9,%al
    5792:	77 d6                	ja     576a <huffman_decoder+0x104>
      point += h->val[point][0];
    5794:	8b 45 08             	mov    0x8(%ebp),%eax
    5797:	8b 40 20             	mov    0x20(%eax),%eax
    579a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    579d:	01 d2                	add    %edx,%edx
    579f:	01 d0                	add    %edx,%eax
    57a1:	0f b6 00             	movzbl (%eax),%eax
    57a4:	0f b6 c0             	movzbl %al,%eax
    57a7:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    level >>= 1;
    57aa:	d1 6d f4             	shrl   -0xc(%ebp)
  } while (level  || (point < ht->treelen) );
    57ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    57b1:	0f 85 07 ff ff ff    	jne    56be <huffman_decoder+0x58>
    57b7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    57ba:	a1 04 02 01 00       	mov    0x10204,%eax
    57bf:	39 c2                	cmp    %eax,%edx
    57c1:	0f 82 f7 fe ff ff    	jb     56be <huffman_decoder+0x58>
  
  /* ������ */
  
  if (error) { /* ���� x �� y Ϊһ�м�ֵ */
    57c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    57cb:	74 24                	je     57f1 <huffman_decoder+0x18b>
    //print(0, "Illegal Huffman code in data.\n");
    *x = ((h->xlen-1) << 1);
    57cd:	8b 45 08             	mov    0x8(%ebp),%eax
    57d0:	8b 40 04             	mov    0x4(%eax),%eax
    57d3:	83 e8 01             	sub    $0x1,%eax
    57d6:	01 c0                	add    %eax,%eax
    57d8:	89 c2                	mov    %eax,%edx
    57da:	8b 45 0c             	mov    0xc(%ebp),%eax
    57dd:	89 10                	mov    %edx,(%eax)
    *y = ((h->ylen-1) << 1);
    57df:	8b 45 08             	mov    0x8(%ebp),%eax
    57e2:	8b 40 08             	mov    0x8(%eax),%eax
    57e5:	83 e8 01             	sub    $0x1,%eax
    57e8:	01 c0                	add    %eax,%eax
    57ea:	89 c2                	mov    %eax,%edx
    57ec:	8b 45 10             	mov    0x10(%ebp),%eax
    57ef:	89 10                	mov    %edx,(%eax)
  }

  /* �����źű��� */

  if (h->tablename[0] == '3'
    57f1:	8b 45 08             	mov    0x8(%ebp),%eax
    57f4:	0f b6 00             	movzbl (%eax),%eax
    57f7:	3c 33                	cmp    $0x33,%al
    57f9:	0f 85 ec 00 00 00    	jne    58eb <huffman_decoder+0x285>
      && (h->tablename[1] == '2' || h->tablename[1] == '3')) {
    57ff:	8b 45 08             	mov    0x8(%ebp),%eax
    5802:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5806:	3c 32                	cmp    $0x32,%al
    5808:	74 0f                	je     5819 <huffman_decoder+0x1b3>
    580a:	8b 45 08             	mov    0x8(%ebp),%eax
    580d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5811:	3c 33                	cmp    $0x33,%al
    5813:	0f 85 d2 00 00 00    	jne    58eb <huffman_decoder+0x285>
     *v = (*y>>3) & 1;
    5819:	8b 45 10             	mov    0x10(%ebp),%eax
    581c:	8b 00                	mov    (%eax),%eax
    581e:	c1 f8 03             	sar    $0x3,%eax
    5821:	83 e0 01             	and    $0x1,%eax
    5824:	89 c2                	mov    %eax,%edx
    5826:	8b 45 14             	mov    0x14(%ebp),%eax
    5829:	89 10                	mov    %edx,(%eax)
     *w = (*y>>2) & 1;
    582b:	8b 45 10             	mov    0x10(%ebp),%eax
    582e:	8b 00                	mov    (%eax),%eax
    5830:	c1 f8 02             	sar    $0x2,%eax
    5833:	83 e0 01             	and    $0x1,%eax
    5836:	89 c2                	mov    %eax,%edx
    5838:	8b 45 18             	mov    0x18(%ebp),%eax
    583b:	89 10                	mov    %edx,(%eax)
     *x = (*y>>1) & 1;
    583d:	8b 45 10             	mov    0x10(%ebp),%eax
    5840:	8b 00                	mov    (%eax),%eax
    5842:	d1 f8                	sar    %eax
    5844:	83 e0 01             	and    $0x1,%eax
    5847:	89 c2                	mov    %eax,%edx
    5849:	8b 45 0c             	mov    0xc(%ebp),%eax
    584c:	89 10                	mov    %edx,(%eax)
     *y = *y & 1;
    584e:	8b 45 10             	mov    0x10(%ebp),%eax
    5851:	8b 00                	mov    (%eax),%eax
    5853:	83 e0 01             	and    $0x1,%eax
    5856:	89 c2                	mov    %eax,%edx
    5858:	8b 45 10             	mov    0x10(%ebp),%eax
    585b:	89 10                	mov    %edx,(%eax)
     /* v, w, x �� y �ڱ��������ǵߵ��ģ��������� 
         */
     
/*   {int i=*v; *v=*y; *y=i; i=*w; *w=*x; *x=i;}  MI */

     if (*v)
    585d:	8b 45 14             	mov    0x14(%ebp),%eax
    5860:	8b 00                	mov    (%eax),%eax
    5862:	85 c0                	test   %eax,%eax
    5864:	74 18                	je     587e <huffman_decoder+0x218>
        if (hget1bit() == 1) *v = -*v;
    5866:	e8 59 e5 ff ff       	call   3dc4 <hget1bit>
    586b:	83 f8 01             	cmp    $0x1,%eax
    586e:	75 0e                	jne    587e <huffman_decoder+0x218>
    5870:	8b 45 14             	mov    0x14(%ebp),%eax
    5873:	8b 00                	mov    (%eax),%eax
    5875:	f7 d8                	neg    %eax
    5877:	89 c2                	mov    %eax,%edx
    5879:	8b 45 14             	mov    0x14(%ebp),%eax
    587c:	89 10                	mov    %edx,(%eax)
     if (*w)
    587e:	8b 45 18             	mov    0x18(%ebp),%eax
    5881:	8b 00                	mov    (%eax),%eax
    5883:	85 c0                	test   %eax,%eax
    5885:	74 18                	je     589f <huffman_decoder+0x239>
        if (hget1bit() == 1) *w = -*w;
    5887:	e8 38 e5 ff ff       	call   3dc4 <hget1bit>
    588c:	83 f8 01             	cmp    $0x1,%eax
    588f:	75 0e                	jne    589f <huffman_decoder+0x239>
    5891:	8b 45 18             	mov    0x18(%ebp),%eax
    5894:	8b 00                	mov    (%eax),%eax
    5896:	f7 d8                	neg    %eax
    5898:	89 c2                	mov    %eax,%edx
    589a:	8b 45 18             	mov    0x18(%ebp),%eax
    589d:	89 10                	mov    %edx,(%eax)
     if (*x)
    589f:	8b 45 0c             	mov    0xc(%ebp),%eax
    58a2:	8b 00                	mov    (%eax),%eax
    58a4:	85 c0                	test   %eax,%eax
    58a6:	74 18                	je     58c0 <huffman_decoder+0x25a>
        if (hget1bit() == 1) *x = -*x;
    58a8:	e8 17 e5 ff ff       	call   3dc4 <hget1bit>
    58ad:	83 f8 01             	cmp    $0x1,%eax
    58b0:	75 0e                	jne    58c0 <huffman_decoder+0x25a>
    58b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    58b5:	8b 00                	mov    (%eax),%eax
    58b7:	f7 d8                	neg    %eax
    58b9:	89 c2                	mov    %eax,%edx
    58bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    58be:	89 10                	mov    %edx,(%eax)
     if (*y)
    58c0:	8b 45 10             	mov    0x10(%ebp),%eax
    58c3:	8b 00                	mov    (%eax),%eax
    58c5:	85 c0                	test   %eax,%eax
    58c7:	74 1d                	je     58e6 <huffman_decoder+0x280>
        if (hget1bit() == 1) *y = -*y;
    58c9:	e8 f6 e4 ff ff       	call   3dc4 <hget1bit>
    58ce:	83 f8 01             	cmp    $0x1,%eax
    58d1:	75 13                	jne    58e6 <huffman_decoder+0x280>
    58d3:	8b 45 10             	mov    0x10(%ebp),%eax
    58d6:	8b 00                	mov    (%eax),%eax
    58d8:	f7 d8                	neg    %eax
    58da:	89 c2                	mov    %eax,%edx
    58dc:	8b 45 10             	mov    0x10(%ebp),%eax
    58df:	89 10                	mov    %edx,(%eax)
        if (hget1bit() == 1) *v = -*v;
     if (*w)
        if (hget1bit() == 1) *w = -*w;
     if (*x)
        if (hget1bit() == 1) *x = -*x;
     if (*y)
    58e1:	e9 bb 00 00 00       	jmp    59a1 <huffman_decoder+0x33b>
    58e6:	e9 b6 00 00 00       	jmp    59a1 <huffman_decoder+0x33b>
  else {
  
      /* �ڲ��Ա�������x �� y�ǵߵ��� 
         ����ߵ� x �� y ʹ���Ա��������� */
    
     if (h->linbits)
    58eb:	8b 45 08             	mov    0x8(%ebp),%eax
    58ee:	8b 40 0c             	mov    0xc(%eax),%eax
    58f1:	85 c0                	test   %eax,%eax
    58f3:	74 30                	je     5925 <huffman_decoder+0x2bf>
       if ((h->xlen-1) == *x) 
    58f5:	8b 45 08             	mov    0x8(%ebp),%eax
    58f8:	8b 40 04             	mov    0x4(%eax),%eax
    58fb:	8d 50 ff             	lea    -0x1(%eax),%edx
    58fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    5901:	8b 00                	mov    (%eax),%eax
    5903:	39 c2                	cmp    %eax,%edx
    5905:	75 1e                	jne    5925 <huffman_decoder+0x2bf>
         *x += hgetbits(h->linbits);
    5907:	8b 45 0c             	mov    0xc(%ebp),%eax
    590a:	8b 00                	mov    (%eax),%eax
    590c:	89 c3                	mov    %eax,%ebx
    590e:	8b 45 08             	mov    0x8(%ebp),%eax
    5911:	8b 40 0c             	mov    0xc(%eax),%eax
    5914:	89 04 24             	mov    %eax,(%esp)
    5917:	e8 8d e4 ff ff       	call   3da9 <hgetbits>
    591c:	01 d8                	add    %ebx,%eax
    591e:	89 c2                	mov    %eax,%edx
    5920:	8b 45 0c             	mov    0xc(%ebp),%eax
    5923:	89 10                	mov    %edx,(%eax)
     if (*x)
    5925:	8b 45 0c             	mov    0xc(%ebp),%eax
    5928:	8b 00                	mov    (%eax),%eax
    592a:	85 c0                	test   %eax,%eax
    592c:	74 18                	je     5946 <huffman_decoder+0x2e0>
        if (hget1bit() == 1) *x = -*x;
    592e:	e8 91 e4 ff ff       	call   3dc4 <hget1bit>
    5933:	83 f8 01             	cmp    $0x1,%eax
    5936:	75 0e                	jne    5946 <huffman_decoder+0x2e0>
    5938:	8b 45 0c             	mov    0xc(%ebp),%eax
    593b:	8b 00                	mov    (%eax),%eax
    593d:	f7 d8                	neg    %eax
    593f:	89 c2                	mov    %eax,%edx
    5941:	8b 45 0c             	mov    0xc(%ebp),%eax
    5944:	89 10                	mov    %edx,(%eax)
     if (h->linbits)	  
    5946:	8b 45 08             	mov    0x8(%ebp),%eax
    5949:	8b 40 0c             	mov    0xc(%eax),%eax
    594c:	85 c0                	test   %eax,%eax
    594e:	74 30                	je     5980 <huffman_decoder+0x31a>
       if ((h->ylen-1) == *y)
    5950:	8b 45 08             	mov    0x8(%ebp),%eax
    5953:	8b 40 08             	mov    0x8(%eax),%eax
    5956:	8d 50 ff             	lea    -0x1(%eax),%edx
    5959:	8b 45 10             	mov    0x10(%ebp),%eax
    595c:	8b 00                	mov    (%eax),%eax
    595e:	39 c2                	cmp    %eax,%edx
    5960:	75 1e                	jne    5980 <huffman_decoder+0x31a>
         *y += hgetbits(h->linbits);
    5962:	8b 45 10             	mov    0x10(%ebp),%eax
    5965:	8b 00                	mov    (%eax),%eax
    5967:	89 c3                	mov    %eax,%ebx
    5969:	8b 45 08             	mov    0x8(%ebp),%eax
    596c:	8b 40 0c             	mov    0xc(%eax),%eax
    596f:	89 04 24             	mov    %eax,(%esp)
    5972:	e8 32 e4 ff ff       	call   3da9 <hgetbits>
    5977:	01 d8                	add    %ebx,%eax
    5979:	89 c2                	mov    %eax,%edx
    597b:	8b 45 10             	mov    0x10(%ebp),%eax
    597e:	89 10                	mov    %edx,(%eax)
     if (*y)
    5980:	8b 45 10             	mov    0x10(%ebp),%eax
    5983:	8b 00                	mov    (%eax),%eax
    5985:	85 c0                	test   %eax,%eax
    5987:	74 18                	je     59a1 <huffman_decoder+0x33b>
        if (hget1bit() == 1) *y = -*y;
    5989:	e8 36 e4 ff ff       	call   3dc4 <hget1bit>
    598e:	83 f8 01             	cmp    $0x1,%eax
    5991:	75 0e                	jne    59a1 <huffman_decoder+0x33b>
    5993:	8b 45 10             	mov    0x10(%ebp),%eax
    5996:	8b 00                	mov    (%eax),%eax
    5998:	f7 d8                	neg    %eax
    599a:	89 c2                	mov    %eax,%edx
    599c:	8b 45 10             	mov    0x10(%ebp),%eax
    599f:	89 10                	mov    %edx,(%eax)
     }
	  
  return error;  
    59a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    59a4:	83 c4 24             	add    $0x24,%esp
    59a7:	5b                   	pop    %ebx
    59a8:	5d                   	pop    %ebp
    59a9:	c3                   	ret    

000059aa <decode_info>:
#include "common.h"
#include "decode.h"
#include "huffman.h"

void decode_info(Bit_stream_struc *bs, struct frame_params *fr_ps)
{
    59aa:	55                   	push   %ebp
    59ab:	89 e5                	mov    %esp,%ebp
    59ad:	83 ec 28             	sub    $0x28,%esp
    layer *hdr = fr_ps->header;
    59b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    59b3:	8b 00                	mov    (%eax),%eax
    59b5:	89 45 f4             	mov    %eax,-0xc(%ebp)

    hdr->version = get1bit(bs);
    59b8:	8b 45 08             	mov    0x8(%ebp),%eax
    59bb:	89 04 24             	mov    %eax,(%esp)
    59be:	e8 6c df ff ff       	call   392f <get1bit>
    59c3:	89 c2                	mov    %eax,%edx
    59c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    59c8:	89 10                	mov    %edx,(%eax)
    hdr->lay = 4-getbits(bs,2);
    59ca:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    59d1:	00 
    59d2:	8b 45 08             	mov    0x8(%ebp),%eax
    59d5:	89 04 24             	mov    %eax,(%esp)
    59d8:	e8 64 e0 ff ff       	call   3a41 <getbits>
    59dd:	ba 04 00 00 00       	mov    $0x4,%edx
    59e2:	29 c2                	sub    %eax,%edx
    59e4:	89 d0                	mov    %edx,%eax
    59e6:	89 c2                	mov    %eax,%edx
    59e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    59eb:	89 50 04             	mov    %edx,0x4(%eax)
    hdr->error_protection = !get1bit(bs); /* ���󱣻�. TRUE/FALSE */
    59ee:	8b 45 08             	mov    0x8(%ebp),%eax
    59f1:	89 04 24             	mov    %eax,(%esp)
    59f4:	e8 36 df ff ff       	call   392f <get1bit>
    59f9:	85 c0                	test   %eax,%eax
    59fb:	0f 94 c0             	sete   %al
    59fe:	0f b6 d0             	movzbl %al,%edx
    5a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a04:	89 50 08             	mov    %edx,0x8(%eax)
    hdr->bitrate_index = getbits(bs,4);
    5a07:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    5a0e:	00 
    5a0f:	8b 45 08             	mov    0x8(%ebp),%eax
    5a12:	89 04 24             	mov    %eax,(%esp)
    5a15:	e8 27 e0 ff ff       	call   3a41 <getbits>
    5a1a:	89 c2                	mov    %eax,%edx
    5a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a1f:	89 50 0c             	mov    %edx,0xc(%eax)
    hdr->sampling_frequency = getbits(bs,2);
    5a22:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    5a29:	00 
    5a2a:	8b 45 08             	mov    0x8(%ebp),%eax
    5a2d:	89 04 24             	mov    %eax,(%esp)
    5a30:	e8 0c e0 ff ff       	call   3a41 <getbits>
    5a35:	89 c2                	mov    %eax,%edx
    5a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a3a:	89 50 10             	mov    %edx,0x10(%eax)
    hdr->padding = get1bit(bs);
    5a3d:	8b 45 08             	mov    0x8(%ebp),%eax
    5a40:	89 04 24             	mov    %eax,(%esp)
    5a43:	e8 e7 de ff ff       	call   392f <get1bit>
    5a48:	89 c2                	mov    %eax,%edx
    5a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a4d:	89 50 14             	mov    %edx,0x14(%eax)
    hdr->extension = get1bit(bs);
    5a50:	8b 45 08             	mov    0x8(%ebp),%eax
    5a53:	89 04 24             	mov    %eax,(%esp)
    5a56:	e8 d4 de ff ff       	call   392f <get1bit>
    5a5b:	89 c2                	mov    %eax,%edx
    5a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a60:	89 50 18             	mov    %edx,0x18(%eax)
    hdr->mode = getbits(bs,2);
    5a63:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    5a6a:	00 
    5a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    5a6e:	89 04 24             	mov    %eax,(%esp)
    5a71:	e8 cb df ff ff       	call   3a41 <getbits>
    5a76:	89 c2                	mov    %eax,%edx
    5a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a7b:	89 50 1c             	mov    %edx,0x1c(%eax)
    hdr->mode_ext = getbits(bs,2);
    5a7e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    5a85:	00 
    5a86:	8b 45 08             	mov    0x8(%ebp),%eax
    5a89:	89 04 24             	mov    %eax,(%esp)
    5a8c:	e8 b0 df ff ff       	call   3a41 <getbits>
    5a91:	89 c2                	mov    %eax,%edx
    5a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a96:	89 50 20             	mov    %edx,0x20(%eax)
    hdr->copyright = get1bit(bs);
    5a99:	8b 45 08             	mov    0x8(%ebp),%eax
    5a9c:	89 04 24             	mov    %eax,(%esp)
    5a9f:	e8 8b de ff ff       	call   392f <get1bit>
    5aa4:	89 c2                	mov    %eax,%edx
    5aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5aa9:	89 50 24             	mov    %edx,0x24(%eax)
    hdr->original = get1bit(bs);
    5aac:	8b 45 08             	mov    0x8(%ebp),%eax
    5aaf:	89 04 24             	mov    %eax,(%esp)
    5ab2:	e8 78 de ff ff       	call   392f <get1bit>
    5ab7:	89 c2                	mov    %eax,%edx
    5ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5abc:	89 50 28             	mov    %edx,0x28(%eax)
    hdr->emphasis = getbits(bs,2);
    5abf:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    5ac6:	00 
    5ac7:	8b 45 08             	mov    0x8(%ebp),%eax
    5aca:	89 04 24             	mov    %eax,(%esp)
    5acd:	e8 6f df ff ff       	call   3a41 <getbits>
    5ad2:	89 c2                	mov    %eax,%edx
    5ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5ad7:	89 50 2c             	mov    %edx,0x2c(%eax)
}
    5ada:	c9                   	leave  
    5adb:	c3                   	ret    

00005adc <III_get_side_info>:

void III_get_side_info(Bit_stream_struc *bs, struct III_side_info_t *si, struct frame_params *fr_ps)
{
    5adc:	55                   	push   %ebp
    5add:	89 e5                	mov    %esp,%ebp
    5adf:	56                   	push   %esi
    5ae0:	53                   	push   %ebx
    5ae1:	83 ec 20             	sub    $0x20,%esp
	int ch, gr, i;
	int stereo = fr_ps->stereo;
    5ae4:	8b 45 10             	mov    0x10(%ebp),%eax
    5ae7:	8b 40 08             	mov    0x8(%eax),%eax
    5aea:	89 45 e8             	mov    %eax,-0x18(%ebp)

	si->main_data_begin = getbits(bs, 9);
    5aed:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    5af4:	00 
    5af5:	8b 45 08             	mov    0x8(%ebp),%eax
    5af8:	89 04 24             	mov    %eax,(%esp)
    5afb:	e8 41 df ff ff       	call   3a41 <getbits>
    5b00:	8b 55 0c             	mov    0xc(%ebp),%edx
    5b03:	89 02                	mov    %eax,(%edx)
	if (stereo == 1)
    5b05:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
    5b09:	75 1b                	jne    5b26 <III_get_side_info+0x4a>
		si->private_bits = getbits(bs,5);
    5b0b:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    5b12:	00 
    5b13:	8b 45 08             	mov    0x8(%ebp),%eax
    5b16:	89 04 24             	mov    %eax,(%esp)
    5b19:	e8 23 df ff ff       	call   3a41 <getbits>
    5b1e:	8b 55 0c             	mov    0xc(%ebp),%edx
    5b21:	89 42 04             	mov    %eax,0x4(%edx)
    5b24:	eb 19                	jmp    5b3f <III_get_side_info+0x63>
	else
		si->private_bits = getbits(bs,3);
    5b26:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    5b2d:	00 
    5b2e:	8b 45 08             	mov    0x8(%ebp),%eax
    5b31:	89 04 24             	mov    %eax,(%esp)
    5b34:	e8 08 df ff ff       	call   3a41 <getbits>
    5b39:	8b 55 0c             	mov    0xc(%ebp),%edx
    5b3c:	89 42 04             	mov    %eax,0x4(%edx)

	for (ch=0; ch<stereo; ch++)
    5b3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    5b46:	eb 3d                	jmp    5b85 <III_get_side_info+0xa9>
		for (i=0; i<4; i++)
    5b48:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5b4f:	eb 2a                	jmp    5b7b <III_get_side_info+0x9f>
			si->ch[ch].scfsi[i] = get1bit(bs);
    5b51:	8b 45 08             	mov    0x8(%ebp),%eax
    5b54:	89 04 24             	mov    %eax,(%esp)
    5b57:	e8 d3 dd ff ff       	call   392f <get1bit>
    5b5c:	89 c1                	mov    %eax,%ecx
    5b5e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5b61:	8b 55 f4             	mov    -0xc(%ebp),%edx
    5b64:	89 d0                	mov    %edx,%eax
    5b66:	c1 e0 02             	shl    $0x2,%eax
    5b69:	01 d0                	add    %edx,%eax
    5b6b:	c1 e0 03             	shl    $0x3,%eax
    5b6e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    5b71:	01 d0                	add    %edx,%eax
    5b73:	89 4c 83 08          	mov    %ecx,0x8(%ebx,%eax,4)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
    5b77:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5b7b:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
    5b7f:	7e d0                	jle    5b51 <III_get_side_info+0x75>
	if (stereo == 1)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
    5b81:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5b88:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    5b8b:	7c bb                	jl     5b48 <III_get_side_info+0x6c>
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    5b8d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    5b94:	e9 c5 05 00 00       	jmp    615e <III_get_side_info+0x682>
		for (ch=0; ch<stereo; ch++) {
    5b99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    5ba0:	e9 a9 05 00 00       	jmp    614e <III_get_side_info+0x672>
			si->ch[ch].gr[gr].part2_3_length = getbits(bs, 12);
    5ba5:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
    5bac:	00 
    5bad:	8b 45 08             	mov    0x8(%ebp),%eax
    5bb0:	89 04 24             	mov    %eax,(%esp)
    5bb3:	e8 89 de ff ff       	call   3a41 <getbits>
    5bb8:	89 c3                	mov    %eax,%ebx
    5bba:	8b 75 0c             	mov    0xc(%ebp),%esi
    5bbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5bc0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5bc3:	89 c2                	mov    %eax,%edx
    5bc5:	c1 e2 03             	shl    $0x3,%edx
    5bc8:	01 c2                	add    %eax,%edx
    5bca:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5bd1:	89 c2                	mov    %eax,%edx
    5bd3:	89 c8                	mov    %ecx,%eax
    5bd5:	c1 e0 02             	shl    $0x2,%eax
    5bd8:	01 c8                	add    %ecx,%eax
    5bda:	c1 e0 05             	shl    $0x5,%eax
    5bdd:	01 d0                	add    %edx,%eax
    5bdf:	01 f0                	add    %esi,%eax
    5be1:	83 c0 18             	add    $0x18,%eax
    5be4:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].big_values = getbits(bs, 9);
    5be6:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    5bed:	00 
    5bee:	8b 45 08             	mov    0x8(%ebp),%eax
    5bf1:	89 04 24             	mov    %eax,(%esp)
    5bf4:	e8 48 de ff ff       	call   3a41 <getbits>
    5bf9:	89 c3                	mov    %eax,%ebx
    5bfb:	8b 75 0c             	mov    0xc(%ebp),%esi
    5bfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5c01:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5c04:	89 c2                	mov    %eax,%edx
    5c06:	c1 e2 03             	shl    $0x3,%edx
    5c09:	01 c2                	add    %eax,%edx
    5c0b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5c12:	89 c2                	mov    %eax,%edx
    5c14:	89 c8                	mov    %ecx,%eax
    5c16:	c1 e0 02             	shl    $0x2,%eax
    5c19:	01 c8                	add    %ecx,%eax
    5c1b:	c1 e0 05             	shl    $0x5,%eax
    5c1e:	01 d0                	add    %edx,%eax
    5c20:	01 f0                	add    %esi,%eax
    5c22:	83 c0 1c             	add    $0x1c,%eax
    5c25:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].global_gain = getbits(bs, 8);
    5c27:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    5c2e:	00 
    5c2f:	8b 45 08             	mov    0x8(%ebp),%eax
    5c32:	89 04 24             	mov    %eax,(%esp)
    5c35:	e8 07 de ff ff       	call   3a41 <getbits>
    5c3a:	89 c3                	mov    %eax,%ebx
    5c3c:	8b 75 0c             	mov    0xc(%ebp),%esi
    5c3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5c42:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5c45:	89 c2                	mov    %eax,%edx
    5c47:	c1 e2 03             	shl    $0x3,%edx
    5c4a:	01 c2                	add    %eax,%edx
    5c4c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5c53:	89 c2                	mov    %eax,%edx
    5c55:	89 c8                	mov    %ecx,%eax
    5c57:	c1 e0 02             	shl    $0x2,%eax
    5c5a:	01 c8                	add    %ecx,%eax
    5c5c:	c1 e0 05             	shl    $0x5,%eax
    5c5f:	01 d0                	add    %edx,%eax
    5c61:	01 f0                	add    %esi,%eax
    5c63:	83 c0 20             	add    $0x20,%eax
    5c66:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
    5c68:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    5c6f:	00 
    5c70:	8b 45 08             	mov    0x8(%ebp),%eax
    5c73:	89 04 24             	mov    %eax,(%esp)
    5c76:	e8 c6 dd ff ff       	call   3a41 <getbits>
    5c7b:	89 c3                	mov    %eax,%ebx
    5c7d:	8b 75 0c             	mov    0xc(%ebp),%esi
    5c80:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5c83:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5c86:	89 c2                	mov    %eax,%edx
    5c88:	c1 e2 03             	shl    $0x3,%edx
    5c8b:	01 c2                	add    %eax,%edx
    5c8d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5c94:	89 c2                	mov    %eax,%edx
    5c96:	89 c8                	mov    %ecx,%eax
    5c98:	c1 e0 02             	shl    $0x2,%eax
    5c9b:	01 c8                	add    %ecx,%eax
    5c9d:	c1 e0 05             	shl    $0x5,%eax
    5ca0:	01 d0                	add    %edx,%eax
    5ca2:	01 f0                	add    %esi,%eax
    5ca4:	83 c0 24             	add    $0x24,%eax
    5ca7:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
    5ca9:	8b 45 08             	mov    0x8(%ebp),%eax
    5cac:	89 04 24             	mov    %eax,(%esp)
    5caf:	e8 7b dc ff ff       	call   392f <get1bit>
    5cb4:	89 c3                	mov    %eax,%ebx
    5cb6:	8b 75 0c             	mov    0xc(%ebp),%esi
    5cb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5cbc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5cbf:	89 c2                	mov    %eax,%edx
    5cc1:	c1 e2 03             	shl    $0x3,%edx
    5cc4:	01 c2                	add    %eax,%edx
    5cc6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5ccd:	89 c2                	mov    %eax,%edx
    5ccf:	89 c8                	mov    %ecx,%eax
    5cd1:	c1 e0 02             	shl    $0x2,%eax
    5cd4:	01 c8                	add    %ecx,%eax
    5cd6:	c1 e0 05             	shl    $0x5,%eax
    5cd9:	01 d0                	add    %edx,%eax
    5cdb:	01 f0                	add    %esi,%eax
    5cdd:	83 c0 28             	add    $0x28,%eax
    5ce0:	89 18                	mov    %ebx,(%eax)
			if (si->ch[ch].gr[gr].window_switching_flag) {
    5ce2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5ce5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5ce8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5ceb:	89 c2                	mov    %eax,%edx
    5ced:	c1 e2 03             	shl    $0x3,%edx
    5cf0:	01 c2                	add    %eax,%edx
    5cf2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5cf9:	89 c2                	mov    %eax,%edx
    5cfb:	89 c8                	mov    %ecx,%eax
    5cfd:	c1 e0 02             	shl    $0x2,%eax
    5d00:	01 c8                	add    %ecx,%eax
    5d02:	c1 e0 05             	shl    $0x5,%eax
    5d05:	01 d0                	add    %edx,%eax
    5d07:	01 d8                	add    %ebx,%eax
    5d09:	83 c0 28             	add    $0x28,%eax
    5d0c:	8b 00                	mov    (%eax),%eax
    5d0e:	85 c0                	test   %eax,%eax
    5d10:	0f 84 82 02 00 00    	je     5f98 <III_get_side_info+0x4bc>
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
    5d16:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    5d1d:	00 
    5d1e:	8b 45 08             	mov    0x8(%ebp),%eax
    5d21:	89 04 24             	mov    %eax,(%esp)
    5d24:	e8 18 dd ff ff       	call   3a41 <getbits>
    5d29:	89 c3                	mov    %eax,%ebx
    5d2b:	8b 75 0c             	mov    0xc(%ebp),%esi
    5d2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5d31:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5d34:	89 c2                	mov    %eax,%edx
    5d36:	c1 e2 03             	shl    $0x3,%edx
    5d39:	01 c2                	add    %eax,%edx
    5d3b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5d42:	89 c2                	mov    %eax,%edx
    5d44:	89 c8                	mov    %ecx,%eax
    5d46:	c1 e0 02             	shl    $0x2,%eax
    5d49:	01 c8                	add    %ecx,%eax
    5d4b:	c1 e0 05             	shl    $0x5,%eax
    5d4e:	01 d0                	add    %edx,%eax
    5d50:	01 f0                	add    %esi,%eax
    5d52:	83 c0 2c             	add    $0x2c,%eax
    5d55:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
    5d57:	8b 45 08             	mov    0x8(%ebp),%eax
    5d5a:	89 04 24             	mov    %eax,(%esp)
    5d5d:	e8 cd db ff ff       	call   392f <get1bit>
    5d62:	89 c3                	mov    %eax,%ebx
    5d64:	8b 75 0c             	mov    0xc(%ebp),%esi
    5d67:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5d6a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5d6d:	89 c2                	mov    %eax,%edx
    5d6f:	c1 e2 03             	shl    $0x3,%edx
    5d72:	01 c2                	add    %eax,%edx
    5d74:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5d7b:	89 c2                	mov    %eax,%edx
    5d7d:	89 c8                	mov    %ecx,%eax
    5d7f:	c1 e0 02             	shl    $0x2,%eax
    5d82:	01 c8                	add    %ecx,%eax
    5d84:	c1 e0 05             	shl    $0x5,%eax
    5d87:	01 d0                	add    %edx,%eax
    5d89:	01 f0                	add    %esi,%eax
    5d8b:	83 c0 30             	add    $0x30,%eax
    5d8e:	89 18                	mov    %ebx,(%eax)
				for (i=0; i<2; i++)
    5d90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5d97:	eb 46                	jmp    5ddf <III_get_side_info+0x303>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    5d99:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    5da0:	00 
    5da1:	8b 45 08             	mov    0x8(%ebp),%eax
    5da4:	89 04 24             	mov    %eax,(%esp)
    5da7:	e8 95 dc ff ff       	call   3a41 <getbits>
    5dac:	89 c3                	mov    %eax,%ebx
    5dae:	8b 75 0c             	mov    0xc(%ebp),%esi
    5db1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5db4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5db7:	89 c2                	mov    %eax,%edx
    5db9:	c1 e2 03             	shl    $0x3,%edx
    5dbc:	01 c2                	add    %eax,%edx
    5dbe:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5dc1:	89 c2                	mov    %eax,%edx
    5dc3:	89 c8                	mov    %ecx,%eax
    5dc5:	c1 e0 02             	shl    $0x2,%eax
    5dc8:	01 c8                	add    %ecx,%eax
    5dca:	c1 e0 03             	shl    $0x3,%eax
    5dcd:	01 c2                	add    %eax,%edx
    5dcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5dd2:	01 d0                	add    %edx,%eax
    5dd4:	83 c0 08             	add    $0x8,%eax
    5dd7:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
    5ddb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5ddf:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    5de3:	7e b4                	jle    5d99 <III_get_side_info+0x2bd>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    5de5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5dec:	eb 46                	jmp    5e34 <III_get_side_info+0x358>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);
    5dee:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    5df5:	00 
    5df6:	8b 45 08             	mov    0x8(%ebp),%eax
    5df9:	89 04 24             	mov    %eax,(%esp)
    5dfc:	e8 40 dc ff ff       	call   3a41 <getbits>
    5e01:	89 c3                	mov    %eax,%ebx
    5e03:	8b 75 0c             	mov    0xc(%ebp),%esi
    5e06:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5e09:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5e0c:	89 c2                	mov    %eax,%edx
    5e0e:	c1 e2 03             	shl    $0x3,%edx
    5e11:	01 c2                	add    %eax,%edx
    5e13:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5e16:	89 c2                	mov    %eax,%edx
    5e18:	89 c8                	mov    %ecx,%eax
    5e1a:	c1 e0 02             	shl    $0x2,%eax
    5e1d:	01 c8                	add    %ecx,%eax
    5e1f:	c1 e0 03             	shl    $0x3,%eax
    5e22:	01 c2                	add    %eax,%edx
    5e24:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5e27:	01 d0                	add    %edx,%eax
    5e29:	83 c0 0c             	add    $0xc,%eax
    5e2c:	89 5c 86 10          	mov    %ebx,0x10(%esi,%eax,4)
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    5e30:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5e34:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5e38:	7e b4                	jle    5dee <III_get_side_info+0x312>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);

				/* Set region_count parameters since they are implicit in this case. */

				if (si->ch[ch].gr[gr].block_type == 0) {
    5e3a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5e3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5e40:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5e43:	89 c2                	mov    %eax,%edx
    5e45:	c1 e2 03             	shl    $0x3,%edx
    5e48:	01 c2                	add    %eax,%edx
    5e4a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5e51:	89 c2                	mov    %eax,%edx
    5e53:	89 c8                	mov    %ecx,%eax
    5e55:	c1 e0 02             	shl    $0x2,%eax
    5e58:	01 c8                	add    %ecx,%eax
    5e5a:	c1 e0 05             	shl    $0x5,%eax
    5e5d:	01 d0                	add    %edx,%eax
    5e5f:	01 d8                	add    %ebx,%eax
    5e61:	83 c0 2c             	add    $0x2c,%eax
    5e64:	8b 00                	mov    (%eax),%eax
    5e66:	85 c0                	test   %eax,%eax
    5e68:	75 05                	jne    5e6f <III_get_side_info+0x393>
					//printf("Side info bad: block_type == 0 in split block.\n");
					exit();
    5e6a:	e8 84 cb ff ff       	call   29f3 <exit>
				}
				else if (si->ch[ch].gr[gr].block_type == 2
    5e6f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5e72:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5e75:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5e78:	89 c2                	mov    %eax,%edx
    5e7a:	c1 e2 03             	shl    $0x3,%edx
    5e7d:	01 c2                	add    %eax,%edx
    5e7f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5e86:	89 c2                	mov    %eax,%edx
    5e88:	89 c8                	mov    %ecx,%eax
    5e8a:	c1 e0 02             	shl    $0x2,%eax
    5e8d:	01 c8                	add    %ecx,%eax
    5e8f:	c1 e0 05             	shl    $0x5,%eax
    5e92:	01 d0                	add    %edx,%eax
    5e94:	01 d8                	add    %ebx,%eax
    5e96:	83 c0 2c             	add    $0x2c,%eax
    5e99:	8b 00                	mov    (%eax),%eax
    5e9b:	83 f8 02             	cmp    $0x2,%eax
    5e9e:	75 62                	jne    5f02 <III_get_side_info+0x426>
						&& si->ch[ch].gr[gr].mixed_block_flag == 0)
    5ea0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5ea6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5ea9:	89 c2                	mov    %eax,%edx
    5eab:	c1 e2 03             	shl    $0x3,%edx
    5eae:	01 c2                	add    %eax,%edx
    5eb0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5eb7:	89 c2                	mov    %eax,%edx
    5eb9:	89 c8                	mov    %ecx,%eax
    5ebb:	c1 e0 02             	shl    $0x2,%eax
    5ebe:	01 c8                	add    %ecx,%eax
    5ec0:	c1 e0 05             	shl    $0x5,%eax
    5ec3:	01 d0                	add    %edx,%eax
    5ec5:	01 d8                	add    %ebx,%eax
    5ec7:	83 c0 30             	add    $0x30,%eax
    5eca:	8b 00                	mov    (%eax),%eax
    5ecc:	85 c0                	test   %eax,%eax
    5ece:	75 32                	jne    5f02 <III_get_side_info+0x426>
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
    5ed0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5ed3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5ed6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5ed9:	89 c2                	mov    %eax,%edx
    5edb:	c1 e2 03             	shl    $0x3,%edx
    5ede:	01 c2                	add    %eax,%edx
    5ee0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5ee7:	89 c2                	mov    %eax,%edx
    5ee9:	89 c8                	mov    %ecx,%eax
    5eeb:	c1 e0 02             	shl    $0x2,%eax
    5eee:	01 c8                	add    %ecx,%eax
    5ef0:	c1 e0 05             	shl    $0x5,%eax
    5ef3:	01 d0                	add    %edx,%eax
    5ef5:	01 d8                	add    %ebx,%eax
    5ef7:	83 c0 4c             	add    $0x4c,%eax
    5efa:	c7 00 08 00 00 00    	movl   $0x8,(%eax)
    5f00:	eb 30                	jmp    5f32 <III_get_side_info+0x456>
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
    5f02:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5f05:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5f08:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5f0b:	89 c2                	mov    %eax,%edx
    5f0d:	c1 e2 03             	shl    $0x3,%edx
    5f10:	01 c2                	add    %eax,%edx
    5f12:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5f19:	89 c2                	mov    %eax,%edx
    5f1b:	89 c8                	mov    %ecx,%eax
    5f1d:	c1 e0 02             	shl    $0x2,%eax
    5f20:	01 c8                	add    %ecx,%eax
    5f22:	c1 e0 05             	shl    $0x5,%eax
    5f25:	01 d0                	add    %edx,%eax
    5f27:	01 d8                	add    %ebx,%eax
    5f29:	83 c0 4c             	add    $0x4c,%eax
    5f2c:	c7 00 07 00 00 00    	movl   $0x7,(%eax)
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
    5f32:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5f35:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5f38:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5f3b:	89 c2                	mov    %eax,%edx
    5f3d:	c1 e2 03             	shl    $0x3,%edx
    5f40:	01 c2                	add    %eax,%edx
    5f42:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5f49:	89 c2                	mov    %eax,%edx
    5f4b:	89 c8                	mov    %ecx,%eax
    5f4d:	c1 e0 02             	shl    $0x2,%eax
    5f50:	01 c8                	add    %ecx,%eax
    5f52:	c1 e0 05             	shl    $0x5,%eax
    5f55:	01 d0                	add    %edx,%eax
    5f57:	01 d8                	add    %ebx,%eax
    5f59:	83 c0 4c             	add    $0x4c,%eax
    5f5c:	8b 00                	mov    (%eax),%eax
    5f5e:	ba 14 00 00 00       	mov    $0x14,%edx
    5f63:	89 d3                	mov    %edx,%ebx
    5f65:	29 c3                	sub    %eax,%ebx
    5f67:	8b 75 0c             	mov    0xc(%ebp),%esi
    5f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5f6d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5f70:	89 c2                	mov    %eax,%edx
    5f72:	c1 e2 03             	shl    $0x3,%edx
    5f75:	01 c2                	add    %eax,%edx
    5f77:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5f7e:	89 c2                	mov    %eax,%edx
    5f80:	89 c8                	mov    %ecx,%eax
    5f82:	c1 e0 02             	shl    $0x2,%eax
    5f85:	01 c8                	add    %ecx,%eax
    5f87:	c1 e0 05             	shl    $0x5,%eax
    5f8a:	01 d0                	add    %edx,%eax
    5f8c:	01 f0                	add    %esi,%eax
    5f8e:	83 c0 50             	add    $0x50,%eax
    5f91:	89 18                	mov    %ebx,(%eax)
    5f93:	e9 07 01 00 00       	jmp    609f <III_get_side_info+0x5c3>
			}
			else {
				for (i=0; i<3; i++)
    5f98:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5f9f:	eb 46                	jmp    5fe7 <III_get_side_info+0x50b>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    5fa1:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    5fa8:	00 
    5fa9:	8b 45 08             	mov    0x8(%ebp),%eax
    5fac:	89 04 24             	mov    %eax,(%esp)
    5faf:	e8 8d da ff ff       	call   3a41 <getbits>
    5fb4:	89 c3                	mov    %eax,%ebx
    5fb6:	8b 75 0c             	mov    0xc(%ebp),%esi
    5fb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5fbc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5fbf:	89 c2                	mov    %eax,%edx
    5fc1:	c1 e2 03             	shl    $0x3,%edx
    5fc4:	01 c2                	add    %eax,%edx
    5fc6:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5fc9:	89 c2                	mov    %eax,%edx
    5fcb:	89 c8                	mov    %ecx,%eax
    5fcd:	c1 e0 02             	shl    $0x2,%eax
    5fd0:	01 c8                	add    %ecx,%eax
    5fd2:	c1 e0 03             	shl    $0x3,%eax
    5fd5:	01 c2                	add    %eax,%edx
    5fd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5fda:	01 d0                	add    %edx,%eax
    5fdc:	83 c0 08             	add    $0x8,%eax
    5fdf:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
			}
			else {
				for (i=0; i<3; i++)
    5fe3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5fe7:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5feb:	7e b4                	jle    5fa1 <III_get_side_info+0x4c5>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				si->ch[ch].gr[gr].region0_count = getbits(bs, 4);
    5fed:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    5ff4:	00 
    5ff5:	8b 45 08             	mov    0x8(%ebp),%eax
    5ff8:	89 04 24             	mov    %eax,(%esp)
    5ffb:	e8 41 da ff ff       	call   3a41 <getbits>
    6000:	89 c3                	mov    %eax,%ebx
    6002:	8b 75 0c             	mov    0xc(%ebp),%esi
    6005:	8b 45 f0             	mov    -0x10(%ebp),%eax
    6008:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    600b:	89 c2                	mov    %eax,%edx
    600d:	c1 e2 03             	shl    $0x3,%edx
    6010:	01 c2                	add    %eax,%edx
    6012:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6019:	89 c2                	mov    %eax,%edx
    601b:	89 c8                	mov    %ecx,%eax
    601d:	c1 e0 02             	shl    $0x2,%eax
    6020:	01 c8                	add    %ecx,%eax
    6022:	c1 e0 05             	shl    $0x5,%eax
    6025:	01 d0                	add    %edx,%eax
    6027:	01 f0                	add    %esi,%eax
    6029:	83 c0 4c             	add    $0x4c,%eax
    602c:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].region1_count = getbits(bs, 3);
    602e:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    6035:	00 
    6036:	8b 45 08             	mov    0x8(%ebp),%eax
    6039:	89 04 24             	mov    %eax,(%esp)
    603c:	e8 00 da ff ff       	call   3a41 <getbits>
    6041:	89 c3                	mov    %eax,%ebx
    6043:	8b 75 0c             	mov    0xc(%ebp),%esi
    6046:	8b 45 f0             	mov    -0x10(%ebp),%eax
    6049:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    604c:	89 c2                	mov    %eax,%edx
    604e:	c1 e2 03             	shl    $0x3,%edx
    6051:	01 c2                	add    %eax,%edx
    6053:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    605a:	89 c2                	mov    %eax,%edx
    605c:	89 c8                	mov    %ecx,%eax
    605e:	c1 e0 02             	shl    $0x2,%eax
    6061:	01 c8                	add    %ecx,%eax
    6063:	c1 e0 05             	shl    $0x5,%eax
    6066:	01 d0                	add    %edx,%eax
    6068:	01 f0                	add    %esi,%eax
    606a:	83 c0 50             	add    $0x50,%eax
    606d:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].block_type = 0;
    606f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6072:	8b 45 f0             	mov    -0x10(%ebp),%eax
    6075:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    6078:	89 c2                	mov    %eax,%edx
    607a:	c1 e2 03             	shl    $0x3,%edx
    607d:	01 c2                	add    %eax,%edx
    607f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6086:	89 c2                	mov    %eax,%edx
    6088:	89 c8                	mov    %ecx,%eax
    608a:	c1 e0 02             	shl    $0x2,%eax
    608d:	01 c8                	add    %ecx,%eax
    608f:	c1 e0 05             	shl    $0x5,%eax
    6092:	01 d0                	add    %edx,%eax
    6094:	01 d8                	add    %ebx,%eax
    6096:	83 c0 2c             	add    $0x2c,%eax
    6099:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
			}
			si->ch[ch].gr[gr].preflag = get1bit(bs);
    609f:	8b 45 08             	mov    0x8(%ebp),%eax
    60a2:	89 04 24             	mov    %eax,(%esp)
    60a5:	e8 85 d8 ff ff       	call   392f <get1bit>
    60aa:	89 c3                	mov    %eax,%ebx
    60ac:	8b 75 0c             	mov    0xc(%ebp),%esi
    60af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    60b2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    60b5:	89 c2                	mov    %eax,%edx
    60b7:	c1 e2 03             	shl    $0x3,%edx
    60ba:	01 c2                	add    %eax,%edx
    60bc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    60c3:	89 c2                	mov    %eax,%edx
    60c5:	89 c8                	mov    %ecx,%eax
    60c7:	c1 e0 02             	shl    $0x2,%eax
    60ca:	01 c8                	add    %ecx,%eax
    60cc:	c1 e0 05             	shl    $0x5,%eax
    60cf:	01 d0                	add    %edx,%eax
    60d1:	01 f0                	add    %esi,%eax
    60d3:	83 c0 54             	add    $0x54,%eax
    60d6:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
    60d8:	8b 45 08             	mov    0x8(%ebp),%eax
    60db:	89 04 24             	mov    %eax,(%esp)
    60de:	e8 4c d8 ff ff       	call   392f <get1bit>
    60e3:	89 c3                	mov    %eax,%ebx
    60e5:	8b 75 0c             	mov    0xc(%ebp),%esi
    60e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    60eb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    60ee:	89 c2                	mov    %eax,%edx
    60f0:	c1 e2 03             	shl    $0x3,%edx
    60f3:	01 c2                	add    %eax,%edx
    60f5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    60fc:	89 c2                	mov    %eax,%edx
    60fe:	89 c8                	mov    %ecx,%eax
    6100:	c1 e0 02             	shl    $0x2,%eax
    6103:	01 c8                	add    %ecx,%eax
    6105:	c1 e0 05             	shl    $0x5,%eax
    6108:	01 d0                	add    %edx,%eax
    610a:	01 f0                	add    %esi,%eax
    610c:	83 c0 58             	add    $0x58,%eax
    610f:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
    6111:	8b 45 08             	mov    0x8(%ebp),%eax
    6114:	89 04 24             	mov    %eax,(%esp)
    6117:	e8 13 d8 ff ff       	call   392f <get1bit>
    611c:	89 c3                	mov    %eax,%ebx
    611e:	8b 75 0c             	mov    0xc(%ebp),%esi
    6121:	8b 45 f0             	mov    -0x10(%ebp),%eax
    6124:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    6127:	89 c2                	mov    %eax,%edx
    6129:	c1 e2 03             	shl    $0x3,%edx
    612c:	01 c2                	add    %eax,%edx
    612e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6135:	89 c2                	mov    %eax,%edx
    6137:	89 c8                	mov    %ecx,%eax
    6139:	c1 e0 02             	shl    $0x2,%eax
    613c:	01 c8                	add    %ecx,%eax
    613e:	c1 e0 05             	shl    $0x5,%eax
    6141:	01 d0                	add    %edx,%eax
    6143:	01 f0                	add    %esi,%eax
    6145:	83 c0 5c             	add    $0x5c,%eax
    6148:	89 18                	mov    %ebx,(%eax)
	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
		for (ch=0; ch<stereo; ch++) {
    614a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    614e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6151:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    6154:	0f 8c 4b fa ff ff    	jl     5ba5 <III_get_side_info+0xc9>

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    615a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    615e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    6162:	0f 8e 31 fa ff ff    	jle    5b99 <III_get_side_info+0xbd>
			si->ch[ch].gr[gr].preflag = get1bit(bs);
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
         }
	}
}
    6168:	83 c4 20             	add    $0x20,%esp
    616b:	5b                   	pop    %ebx
    616c:	5e                   	pop    %esi
    616d:	5d                   	pop    %ebp
    616e:	c3                   	ret    

0000616f <III_get_scale_factors>:
	{{0,4,8,12,16,20,24,30,36,44,54,66,82,102,126,156,194,240,296,364,448,550,576},
		{0,4,8,12,16,22,30,42,58,78,104,138,180,192}}
};

void III_get_scale_factors(III_scalefac_t *scalefac, struct III_side_info_t *si, int gr, int ch, struct frame_params *fr_ps)
{
    616f:	55                   	push   %ebp
    6170:	89 e5                	mov    %esp,%ebp
    6172:	56                   	push   %esi
    6173:	53                   	push   %ebx
    6174:	83 ec 20             	sub    $0x20,%esp
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);
    6177:	8b 45 10             	mov    0x10(%ebp),%eax
    617a:	89 c2                	mov    %eax,%edx
    617c:	c1 e2 03             	shl    $0x3,%edx
    617f:	01 c2                	add    %eax,%edx
    6181:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6188:	89 c2                	mov    %eax,%edx
    618a:	8b 4d 14             	mov    0x14(%ebp),%ecx
    618d:	89 c8                	mov    %ecx,%eax
    618f:	c1 e0 02             	shl    $0x2,%eax
    6192:	01 c8                	add    %ecx,%eax
    6194:	c1 e0 05             	shl    $0x5,%eax
    6197:	01 d0                	add    %edx,%eax
    6199:	8d 50 10             	lea    0x10(%eax),%edx
    619c:	8b 45 0c             	mov    0xc(%ebp),%eax
    619f:	01 d0                	add    %edx,%eax
    61a1:	83 c0 08             	add    $0x8,%eax
    61a4:	89 45 e8             	mov    %eax,-0x18(%ebp)

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    61a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    61aa:	8b 40 10             	mov    0x10(%eax),%eax
    61ad:	85 c0                	test   %eax,%eax
    61af:	0f 84 7e 02 00 00    	je     6433 <III_get_scale_factors+0x2c4>
    61b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    61b8:	8b 40 14             	mov    0x14(%eax),%eax
    61bb:	83 f8 02             	cmp    $0x2,%eax
    61be:	0f 85 6f 02 00 00    	jne    6433 <III_get_scale_factors+0x2c4>
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    61c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    61c7:	8b 40 18             	mov    0x18(%eax),%eax
    61ca:	85 c0                	test   %eax,%eax
    61cc:	0f 84 6b 01 00 00    	je     633d <III_get_scale_factors+0x1ce>
			for (sfb = 0; sfb < 8; sfb++)
    61d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    61d9:	eb 32                	jmp    620d <III_get_scale_factors+0x9e>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
    61db:	8b 45 e8             	mov    -0x18(%ebp),%eax
    61de:	8b 40 0c             	mov    0xc(%eax),%eax
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
    61e1:	8b 04 85 a0 ce 00 00 	mov    0xcea0(,%eax,4),%eax
    61e8:	89 04 24             	mov    %eax,(%esp)
    61eb:	e8 b9 db ff ff       	call   3da9 <hgetbits>
    61f0:	89 c3                	mov    %eax,%ebx
    61f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    61f5:	8b 45 14             	mov    0x14(%ebp),%eax
    61f8:	01 c0                	add    %eax,%eax
    61fa:	89 c2                	mov    %eax,%edx
    61fc:	c1 e2 05             	shl    $0x5,%edx
    61ff:	29 c2                	sub    %eax,%edx
    6201:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6204:	01 d0                	add    %edx,%eax
    6206:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
    6209:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    620d:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    6211:	7e c8                	jle    61db <III_get_scale_factors+0x6c>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    6213:	c7 45 f4 03 00 00 00 	movl   $0x3,-0xc(%ebp)
    621a:	eb 5c                	jmp    6278 <III_get_scale_factors+0x109>
				for (window=0; window<3; window++)
    621c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    6223:	eb 49                	jmp    626e <III_get_scale_factors+0xff>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
    6225:	8b 45 e8             	mov    -0x18(%ebp),%eax
    6228:	8b 40 0c             	mov    0xc(%eax),%eax
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    622b:	8b 04 85 a0 ce 00 00 	mov    0xcea0(,%eax,4),%eax
    6232:	89 04 24             	mov    %eax,(%esp)
    6235:	e8 6f db ff ff       	call   3da9 <hgetbits>
    623a:	89 c6                	mov    %eax,%esi
    623c:	8b 5d 08             	mov    0x8(%ebp),%ebx
    623f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6242:	8b 4d 14             	mov    0x14(%ebp),%ecx
    6245:	89 d0                	mov    %edx,%eax
    6247:	01 c0                	add    %eax,%eax
    6249:	01 d0                	add    %edx,%eax
    624b:	c1 e0 02             	shl    $0x2,%eax
    624e:	01 d0                	add    %edx,%eax
    6250:	89 ca                	mov    %ecx,%edx
    6252:	01 d2                	add    %edx,%edx
    6254:	89 d1                	mov    %edx,%ecx
    6256:	c1 e1 05             	shl    $0x5,%ecx
    6259:	29 d1                	sub    %edx,%ecx
    625b:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    625e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6261:	01 d0                	add    %edx,%eax
    6263:	83 c0 14             	add    $0x14,%eax
    6266:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
    626a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    626e:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    6272:	7e b1                	jle    6225 <III_get_scale_factors+0xb6>
	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    6274:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    6278:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    627c:	7e 9e                	jle    621c <III_get_scale_factors+0xad>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    627e:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    6285:	eb 5f                	jmp    62e6 <III_get_scale_factors+0x177>
				for (window=0; window<3; window++)
    6287:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    628e:	eb 4c                	jmp    62dc <III_get_scale_factors+0x16d>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
    6290:	8b 45 e8             	mov    -0x18(%ebp),%eax
    6293:	8b 40 0c             	mov    0xc(%eax),%eax
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    6296:	83 c0 10             	add    $0x10,%eax
    6299:	8b 04 85 a0 ce 00 00 	mov    0xcea0(,%eax,4),%eax
    62a0:	89 04 24             	mov    %eax,(%esp)
    62a3:	e8 01 db ff ff       	call   3da9 <hgetbits>
    62a8:	89 c6                	mov    %eax,%esi
    62aa:	8b 5d 08             	mov    0x8(%ebp),%ebx
    62ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
    62b0:	8b 4d 14             	mov    0x14(%ebp),%ecx
    62b3:	89 d0                	mov    %edx,%eax
    62b5:	01 c0                	add    %eax,%eax
    62b7:	01 d0                	add    %edx,%eax
    62b9:	c1 e0 02             	shl    $0x2,%eax
    62bc:	01 d0                	add    %edx,%eax
    62be:	89 ca                	mov    %ecx,%edx
    62c0:	01 d2                	add    %edx,%edx
    62c2:	89 d1                	mov    %edx,%ecx
    62c4:	c1 e1 05             	shl    $0x5,%ecx
    62c7:	29 d1                	sub    %edx,%ecx
    62c9:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    62cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    62cf:	01 d0                	add    %edx,%eax
    62d1:	83 c0 14             	add    $0x14,%eax
    62d4:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
    62d8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    62dc:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    62e0:	7e ae                	jle    6290 <III_get_scale_factors+0x121>
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    62e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    62e6:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    62ea:	7e 9b                	jle    6287 <III_get_scale_factors+0x118>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    62ec:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    62f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    62fa:	eb 36                	jmp    6332 <III_get_scale_factors+0x1c3>
				(*scalefac)[ch].s[window][sfb] = 0;
    62fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    62ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6302:	8b 4d 14             	mov    0x14(%ebp),%ecx
    6305:	89 d0                	mov    %edx,%eax
    6307:	01 c0                	add    %eax,%eax
    6309:	01 d0                	add    %edx,%eax
    630b:	c1 e0 02             	shl    $0x2,%eax
    630e:	01 d0                	add    %edx,%eax
    6310:	89 ca                	mov    %ecx,%edx
    6312:	01 d2                	add    %edx,%edx
    6314:	89 d1                	mov    %edx,%ecx
    6316:	c1 e1 05             	shl    $0x5,%ecx
    6319:	29 d1                	sub    %edx,%ecx
    631b:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    631e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6321:	01 d0                	add    %edx,%eax
    6323:	83 c0 14             	add    $0x14,%eax
    6326:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    632d:	00 
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    632e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6332:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    6336:	7e c4                	jle    62fc <III_get_scale_factors+0x18d>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    6338:	e9 b1 01 00 00       	jmp    64ee <III_get_scale_factors+0x37f>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    633d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    6344:	e9 8f 00 00 00       	jmp    63d8 <III_get_scale_factors+0x269>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    6349:	8b 45 f0             	mov    -0x10(%ebp),%eax
    634c:	83 c0 04             	add    $0x4,%eax
    634f:	8b 04 85 84 ce 00 00 	mov    0xce84(,%eax,4),%eax
    6356:	89 45 f4             	mov    %eax,-0xc(%ebp)
    6359:	eb 64                	jmp    63bf <III_get_scale_factors+0x250>
					for (window=0; window<3; window++)
    635b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    6362:	eb 51                	jmp    63b5 <III_get_scale_factors+0x246>
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
    6364:	8b 45 e8             	mov    -0x18(%ebp),%eax
    6367:	8b 40 0c             	mov    0xc(%eax),%eax
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
    636a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    636d:	c1 e2 04             	shl    $0x4,%edx
    6370:	01 d0                	add    %edx,%eax
    6372:	8b 04 85 a0 ce 00 00 	mov    0xcea0(,%eax,4),%eax
    6379:	89 04 24             	mov    %eax,(%esp)
    637c:	e8 28 da ff ff       	call   3da9 <hgetbits>
    6381:	89 c6                	mov    %eax,%esi
    6383:	8b 5d 08             	mov    0x8(%ebp),%ebx
    6386:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6389:	8b 4d 14             	mov    0x14(%ebp),%ecx
    638c:	89 d0                	mov    %edx,%eax
    638e:	01 c0                	add    %eax,%eax
    6390:	01 d0                	add    %edx,%eax
    6392:	c1 e0 02             	shl    $0x2,%eax
    6395:	01 d0                	add    %edx,%eax
    6397:	89 ca                	mov    %ecx,%edx
    6399:	01 d2                	add    %edx,%edx
    639b:	89 d1                	mov    %edx,%ecx
    639d:	c1 e1 05             	shl    $0x5,%ecx
    63a0:	29 d1                	sub    %edx,%ecx
    63a2:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    63a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    63a8:	01 d0                	add    %edx,%eax
    63aa:	83 c0 14             	add    $0x14,%eax
    63ad:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
    63b1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    63b5:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    63b9:	7e a9                	jle    6364 <III_get_scale_factors+0x1f5>
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    63bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    63bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    63c2:	83 c0 01             	add    $0x1,%eax
    63c5:	83 c0 04             	add    $0x4,%eax
    63c8:	8b 04 85 84 ce 00 00 	mov    0xce84(,%eax,4),%eax
    63cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    63d2:	7f 87                	jg     635b <III_get_scale_factors+0x1ec>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    63d4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    63d8:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    63dc:	0f 8e 67 ff ff ff    	jle    6349 <III_get_scale_factors+0x1da>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    63e2:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    63e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    63f0:	eb 36                	jmp    6428 <III_get_scale_factors+0x2b9>
					(*scalefac)[ch].s[window][sfb] = 0;
    63f2:	8b 5d 08             	mov    0x8(%ebp),%ebx
    63f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    63f8:	8b 4d 14             	mov    0x14(%ebp),%ecx
    63fb:	89 d0                	mov    %edx,%eax
    63fd:	01 c0                	add    %eax,%eax
    63ff:	01 d0                	add    %edx,%eax
    6401:	c1 e0 02             	shl    $0x2,%eax
    6404:	01 d0                	add    %edx,%eax
    6406:	89 ca                	mov    %ecx,%edx
    6408:	01 d2                	add    %edx,%edx
    640a:	89 d1                	mov    %edx,%ecx
    640c:	c1 e1 05             	shl    $0x5,%ecx
    640f:	29 d1                	sub    %edx,%ecx
    6411:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    6414:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6417:	01 d0                	add    %edx,%eax
    6419:	83 c0 14             	add    $0x14,%eax
    641c:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    6423:	00 
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    6424:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6428:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    642c:	7e c4                	jle    63f2 <III_get_scale_factors+0x283>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    642e:	e9 bb 00 00 00       	jmp    64ee <III_get_scale_factors+0x37f>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    6433:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    643a:	e9 89 00 00 00       	jmp    64c8 <III_get_scale_factors+0x359>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
    643f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    6442:	8b 55 14             	mov    0x14(%ebp),%edx
    6445:	89 d0                	mov    %edx,%eax
    6447:	c1 e0 02             	shl    $0x2,%eax
    644a:	01 d0                	add    %edx,%eax
    644c:	c1 e0 03             	shl    $0x3,%eax
    644f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6452:	01 d0                	add    %edx,%eax
    6454:	8b 44 81 08          	mov    0x8(%ecx,%eax,4),%eax
    6458:	85 c0                	test   %eax,%eax
    645a:	74 06                	je     6462 <III_get_scale_factors+0x2f3>
    645c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    6460:	75 62                	jne    64c4 <III_get_scale_factors+0x355>
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    6462:	8b 45 f0             	mov    -0x10(%ebp),%eax
    6465:	8b 04 85 80 ce 00 00 	mov    0xce80(,%eax,4),%eax
    646c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    646f:	eb 41                	jmp    64b2 <III_get_scale_factors+0x343>
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
    6471:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    6475:	0f 9f c0             	setg   %al
    6478:	0f b6 d0             	movzbl %al,%edx
    647b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    647e:	8b 40 0c             	mov    0xc(%eax),%eax
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
    6481:	c1 e2 04             	shl    $0x4,%edx
    6484:	01 d0                	add    %edx,%eax
    6486:	8b 04 85 a0 ce 00 00 	mov    0xcea0(,%eax,4),%eax
    648d:	89 04 24             	mov    %eax,(%esp)
    6490:	e8 14 d9 ff ff       	call   3da9 <hgetbits>
    6495:	89 c3                	mov    %eax,%ebx
    6497:	8b 4d 08             	mov    0x8(%ebp),%ecx
    649a:	8b 45 14             	mov    0x14(%ebp),%eax
    649d:	01 c0                	add    %eax,%eax
    649f:	89 c2                	mov    %eax,%edx
    64a1:	c1 e2 05             	shl    $0x5,%edx
    64a4:	29 c2                	sub    %eax,%edx
    64a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    64a9:	01 d0                	add    %edx,%eax
    64ab:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    64ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    64b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    64b5:	83 c0 01             	add    $0x1,%eax
    64b8:	8b 04 85 80 ce 00 00 	mov    0xce80(,%eax,4),%eax
    64bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    64c2:	7f ad                	jg     6471 <III_get_scale_factors+0x302>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    64c4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    64c8:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    64cc:	0f 8e 6d ff ff ff    	jle    643f <III_get_scale_factors+0x2d0>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
		}
		(*scalefac)[ch].l[22] = 0;
    64d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    64d5:	8b 45 14             	mov    0x14(%ebp),%eax
    64d8:	c1 e0 03             	shl    $0x3,%eax
    64db:	89 c2                	mov    %eax,%edx
    64dd:	c1 e2 05             	shl    $0x5,%edx
    64e0:	29 c2                	sub    %eax,%edx
    64e2:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    64e5:	83 c0 58             	add    $0x58,%eax
    64e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
}
    64ee:	83 c4 20             	add    $0x20,%esp
    64f1:	5b                   	pop    %ebx
    64f2:	5e                   	pop    %esi
    64f3:	5d                   	pop    %ebp
    64f4:	c3                   	ret    

000064f5 <initialize_huffman>:
struct huffcodetab ht[HTN];
*/
int huffman_initialized = FALSE;

void initialize_huffman()
{
    64f5:	55                   	push   %ebp
    64f6:	89 e5                	mov    %esp,%ebp
    64f8:	83 ec 08             	sub    $0x8,%esp
	if (huffman_initialized) return;
    64fb:	a1 c0 d1 00 00       	mov    0xd1c0,%eax
    6500:	85 c0                	test   %eax,%eax
    6502:	74 02                	je     6506 <initialize_huffman+0x11>
    6504:	eb 0f                	jmp    6515 <initialize_huffman+0x20>
	read_decoder_table();
    6506:	e8 03 d9 ff ff       	call   3e0e <read_decoder_table>
	huffman_initialized = TRUE;
    650b:	c7 05 c0 d1 00 00 01 	movl   $0x1,0xd1c0
    6512:	00 00 00 
}
    6515:	c9                   	leave  
    6516:	c3                   	ret    

00006517 <III_hufman_decode>:


void III_hufman_decode(long int is[SBLIMIT][SSLIMIT], struct III_side_info_t *si, int ch, int gr, int part2_start, struct frame_params *fr_ps)
{
    6517:	55                   	push   %ebp
    6518:	89 e5                	mov    %esp,%ebp
    651a:	57                   	push   %edi
    651b:	56                   	push   %esi
    651c:	53                   	push   %ebx
    651d:	83 ec 4c             	sub    $0x4c,%esp
   struct huffcodetab *h;
   int region1Start;
   int region2Start;
   //int bt = (*si).ch[ch].gr[gr].window_switching_flag && ((*si).ch[ch].gr[gr].block_type == 2);

   initialize_huffman();
    6520:	e8 d0 ff ff ff       	call   64f5 <initialize_huffman>

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    6525:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6528:	8b 45 14             	mov    0x14(%ebp),%eax
    652b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    652e:	89 c2                	mov    %eax,%edx
    6530:	c1 e2 03             	shl    $0x3,%edx
    6533:	01 c2                	add    %eax,%edx
    6535:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    653c:	89 c2                	mov    %eax,%edx
    653e:	89 c8                	mov    %ecx,%eax
    6540:	c1 e0 02             	shl    $0x2,%eax
    6543:	01 c8                	add    %ecx,%eax
    6545:	c1 e0 05             	shl    $0x5,%eax
    6548:	01 d0                	add    %edx,%eax
    654a:	01 d8                	add    %ebx,%eax
    654c:	83 c0 28             	add    $0x28,%eax
    654f:	8b 00                	mov    (%eax),%eax
    6551:	85 c0                	test   %eax,%eax
    6553:	74 44                	je     6599 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {
    6555:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6558:	8b 45 14             	mov    0x14(%ebp),%eax
    655b:	8b 4d 10             	mov    0x10(%ebp),%ecx
    655e:	89 c2                	mov    %eax,%edx
    6560:	c1 e2 03             	shl    $0x3,%edx
    6563:	01 c2                	add    %eax,%edx
    6565:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    656c:	89 c2                	mov    %eax,%edx
    656e:	89 c8                	mov    %ecx,%eax
    6570:	c1 e0 02             	shl    $0x2,%eax
    6573:	01 c8                	add    %ecx,%eax
    6575:	c1 e0 05             	shl    $0x5,%eax
    6578:	01 d0                	add    %edx,%eax
    657a:	01 d8                	add    %ebx,%eax
    657c:	83 c0 2c             	add    $0x2c,%eax
    657f:	8b 00                	mov    (%eax),%eax

   initialize_huffman();

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    6581:	83 f8 02             	cmp    $0x2,%eax
    6584:	75 13                	jne    6599 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {

      /* Region2. */

      region1Start = 36;  /* sfb[9/3]*3=36 */
    6586:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      region2Start = 576; /* No Region2 for short block case. */
    658d:	c7 45 d8 40 02 00 00 	movl   $0x240,-0x28(%ebp)
    6594:	e9 cc 00 00 00       	jmp    6665 <III_hufman_decode+0x14e>
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    6599:	8b 45 1c             	mov    0x1c(%ebp),%eax
    659c:	8b 00                	mov    (%eax),%eax
    659e:	8b 48 10             	mov    0x10(%eax),%ecx
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
    65a1:	8b 75 0c             	mov    0xc(%ebp),%esi
    65a4:	8b 45 14             	mov    0x14(%ebp),%eax
    65a7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    65aa:	89 c2                	mov    %eax,%edx
    65ac:	c1 e2 03             	shl    $0x3,%edx
    65af:	01 c2                	add    %eax,%edx
    65b1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    65b8:	89 c2                	mov    %eax,%edx
    65ba:	89 d8                	mov    %ebx,%eax
    65bc:	c1 e0 02             	shl    $0x2,%eax
    65bf:	01 d8                	add    %ebx,%eax
    65c1:	c1 e0 05             	shl    $0x5,%eax
    65c4:	01 d0                	add    %edx,%eax
    65c6:	01 f0                	add    %esi,%eax
    65c8:	83 c0 4c             	add    $0x4c,%eax
    65cb:	8b 00                	mov    (%eax),%eax
    65cd:	8d 50 01             	lea    0x1(%eax),%edx
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    65d0:	89 c8                	mov    %ecx,%eax
    65d2:	c1 e0 03             	shl    $0x3,%eax
    65d5:	01 c8                	add    %ecx,%eax
    65d7:	c1 e0 02             	shl    $0x2,%eax
    65da:	01 c8                	add    %ecx,%eax
    65dc:	01 d0                	add    %edx,%eax
    65de:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    65e5:	89 45 dc             	mov    %eax,-0x24(%ebp)
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    65e8:	8b 45 1c             	mov    0x1c(%ebp),%eax
    65eb:	8b 00                	mov    (%eax),%eax
    65ed:	8b 48 10             	mov    0x10(%eax),%ecx
                              .l[(*si).ch[ch].gr[gr].region0_count +
    65f0:	8b 75 0c             	mov    0xc(%ebp),%esi
    65f3:	8b 45 14             	mov    0x14(%ebp),%eax
    65f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    65f9:	89 c2                	mov    %eax,%edx
    65fb:	c1 e2 03             	shl    $0x3,%edx
    65fe:	01 c2                	add    %eax,%edx
    6600:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6607:	89 c2                	mov    %eax,%edx
    6609:	89 d8                	mov    %ebx,%eax
    660b:	c1 e0 02             	shl    $0x2,%eax
    660e:	01 d8                	add    %ebx,%eax
    6610:	c1 e0 05             	shl    $0x5,%eax
    6613:	01 d0                	add    %edx,%eax
    6615:	01 f0                	add    %esi,%eax
    6617:	83 c0 4c             	add    $0x4c,%eax
    661a:	8b 30                	mov    (%eax),%esi
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    661c:	8b 7d 0c             	mov    0xc(%ebp),%edi
    661f:	8b 45 14             	mov    0x14(%ebp),%eax
    6622:	8b 5d 10             	mov    0x10(%ebp),%ebx
    6625:	89 c2                	mov    %eax,%edx
    6627:	c1 e2 03             	shl    $0x3,%edx
    662a:	01 c2                	add    %eax,%edx
    662c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6633:	89 c2                	mov    %eax,%edx
    6635:	89 d8                	mov    %ebx,%eax
    6637:	c1 e0 02             	shl    $0x2,%eax
    663a:	01 d8                	add    %ebx,%eax
    663c:	c1 e0 05             	shl    $0x5,%eax
    663f:	01 d0                	add    %edx,%eax
    6641:	01 f8                	add    %edi,%eax
    6643:	83 c0 50             	add    $0x50,%eax
    6646:	8b 00                	mov    (%eax),%eax
   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
                              .l[(*si).ch[ch].gr[gr].region0_count +
    6648:	01 f0                	add    %esi,%eax
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    664a:	8d 50 02             	lea    0x2(%eax),%edx

   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    664d:	89 c8                	mov    %ecx,%eax
    664f:	c1 e0 03             	shl    $0x3,%eax
    6652:	01 c8                	add    %ecx,%eax
    6654:	c1 e0 02             	shl    $0x2,%eax
    6657:	01 c8                	add    %ecx,%eax
    6659:	01 d0                	add    %edx,%eax
    665b:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    6662:	89 45 d8             	mov    %eax,-0x28(%ebp)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    6665:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    666c:	e9 ac 01 00 00       	jmp    681d <III_hufman_decode+0x306>
      if      (i<region1Start) h = &ht[(*si).ch[ch].gr[gr].table_select[0]];
    6671:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    6674:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    6677:	7d 43                	jge    66bc <III_hufman_decode+0x1a5>
    6679:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    667c:	8b 45 14             	mov    0x14(%ebp),%eax
    667f:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6682:	89 c2                	mov    %eax,%edx
    6684:	c1 e2 03             	shl    $0x3,%edx
    6687:	01 c2                	add    %eax,%edx
    6689:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6690:	89 c2                	mov    %eax,%edx
    6692:	89 c8                	mov    %ecx,%eax
    6694:	c1 e0 02             	shl    $0x2,%eax
    6697:	01 c8                	add    %ecx,%eax
    6699:	c1 e0 05             	shl    $0x5,%eax
    669c:	01 d0                	add    %edx,%eax
    669e:	01 d8                	add    %ebx,%eax
    66a0:	83 c0 34             	add    $0x34,%eax
    66a3:	8b 10                	mov    (%eax),%edx
    66a5:	89 d0                	mov    %edx,%eax
    66a7:	c1 e0 02             	shl    $0x2,%eax
    66aa:	01 d0                	add    %edx,%eax
    66ac:	c1 e0 03             	shl    $0x3,%eax
    66af:	05 e0 01 01 00       	add    $0x101e0,%eax
    66b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    66b7:	e9 86 00 00 00       	jmp    6742 <III_hufman_decode+0x22b>
      else if (i<region2Start) h = &ht[(*si).ch[ch].gr[gr].table_select[1]];
    66bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    66bf:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    66c2:	7d 40                	jge    6704 <III_hufman_decode+0x1ed>
    66c4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    66c7:	8b 45 14             	mov    0x14(%ebp),%eax
    66ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
    66cd:	89 c2                	mov    %eax,%edx
    66cf:	c1 e2 03             	shl    $0x3,%edx
    66d2:	01 c2                	add    %eax,%edx
    66d4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    66db:	89 c2                	mov    %eax,%edx
    66dd:	89 c8                	mov    %ecx,%eax
    66df:	c1 e0 02             	shl    $0x2,%eax
    66e2:	01 c8                	add    %ecx,%eax
    66e4:	c1 e0 05             	shl    $0x5,%eax
    66e7:	01 d0                	add    %edx,%eax
    66e9:	01 d8                	add    %ebx,%eax
    66eb:	83 c0 38             	add    $0x38,%eax
    66ee:	8b 10                	mov    (%eax),%edx
    66f0:	89 d0                	mov    %edx,%eax
    66f2:	c1 e0 02             	shl    $0x2,%eax
    66f5:	01 d0                	add    %edx,%eax
    66f7:	c1 e0 03             	shl    $0x3,%eax
    66fa:	05 e0 01 01 00       	add    $0x101e0,%eax
    66ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
    6702:	eb 3e                	jmp    6742 <III_hufman_decode+0x22b>
           else                h = &ht[(*si).ch[ch].gr[gr].table_select[2]];
    6704:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6707:	8b 45 14             	mov    0x14(%ebp),%eax
    670a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    670d:	89 c2                	mov    %eax,%edx
    670f:	c1 e2 03             	shl    $0x3,%edx
    6712:	01 c2                	add    %eax,%edx
    6714:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    671b:	89 c2                	mov    %eax,%edx
    671d:	89 c8                	mov    %ecx,%eax
    671f:	c1 e0 02             	shl    $0x2,%eax
    6722:	01 c8                	add    %ecx,%eax
    6724:	c1 e0 05             	shl    $0x5,%eax
    6727:	01 d0                	add    %edx,%eax
    6729:	01 d8                	add    %ebx,%eax
    672b:	83 c0 3c             	add    $0x3c,%eax
    672e:	8b 10                	mov    (%eax),%edx
    6730:	89 d0                	mov    %edx,%eax
    6732:	c1 e0 02             	shl    $0x2,%eax
    6735:	01 d0                	add    %edx,%eax
    6737:	c1 e0 03             	shl    $0x3,%eax
    673a:	05 e0 01 01 00       	add    $0x101e0,%eax
    673f:	89 45 e0             	mov    %eax,-0x20(%ebp)
      huffman_decoder(h, &x, &y, &v, &w);
    6742:	8d 45 c8             	lea    -0x38(%ebp),%eax
    6745:	89 44 24 10          	mov    %eax,0x10(%esp)
    6749:	8d 45 cc             	lea    -0x34(%ebp),%eax
    674c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    6750:	8d 45 d0             	lea    -0x30(%ebp),%eax
    6753:	89 44 24 08          	mov    %eax,0x8(%esp)
    6757:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    675a:	89 44 24 04          	mov    %eax,0x4(%esp)
    675e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    6761:	89 04 24             	mov    %eax,(%esp)
    6764:	e8 fd ee ff ff       	call   5666 <huffman_decoder>
      is[i/SSLIMIT][i%SSLIMIT] = x;
    6769:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    676c:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6771:	89 c8                	mov    %ecx,%eax
    6773:	f7 ea                	imul   %edx
    6775:	c1 fa 02             	sar    $0x2,%edx
    6778:	89 c8                	mov    %ecx,%eax
    677a:	c1 f8 1f             	sar    $0x1f,%eax
    677d:	29 c2                	sub    %eax,%edx
    677f:	89 d0                	mov    %edx,%eax
    6781:	89 c2                	mov    %eax,%edx
    6783:	89 d0                	mov    %edx,%eax
    6785:	c1 e0 03             	shl    $0x3,%eax
    6788:	01 d0                	add    %edx,%eax
    678a:	c1 e0 03             	shl    $0x3,%eax
    678d:	89 c2                	mov    %eax,%edx
    678f:	8b 45 08             	mov    0x8(%ebp),%eax
    6792:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6795:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    6798:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    679d:	89 c8                	mov    %ecx,%eax
    679f:	f7 ea                	imul   %edx
    67a1:	c1 fa 02             	sar    $0x2,%edx
    67a4:	89 c8                	mov    %ecx,%eax
    67a6:	c1 f8 1f             	sar    $0x1f,%eax
    67a9:	29 c2                	sub    %eax,%edx
    67ab:	89 d0                	mov    %edx,%eax
    67ad:	c1 e0 03             	shl    $0x3,%eax
    67b0:	01 d0                	add    %edx,%eax
    67b2:	01 c0                	add    %eax,%eax
    67b4:	29 c1                	sub    %eax,%ecx
    67b6:	89 ca                	mov    %ecx,%edx
    67b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    67bb:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
    67be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    67c1:	8d 48 01             	lea    0x1(%eax),%ecx
    67c4:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    67c9:	89 c8                	mov    %ecx,%eax
    67cb:	f7 ea                	imul   %edx
    67cd:	c1 fa 02             	sar    $0x2,%edx
    67d0:	89 c8                	mov    %ecx,%eax
    67d2:	c1 f8 1f             	sar    $0x1f,%eax
    67d5:	29 c2                	sub    %eax,%edx
    67d7:	89 d0                	mov    %edx,%eax
    67d9:	89 c2                	mov    %eax,%edx
    67db:	89 d0                	mov    %edx,%eax
    67dd:	c1 e0 03             	shl    $0x3,%eax
    67e0:	01 d0                	add    %edx,%eax
    67e2:	c1 e0 03             	shl    $0x3,%eax
    67e5:	89 c2                	mov    %eax,%edx
    67e7:	8b 45 08             	mov    0x8(%ebp),%eax
    67ea:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    67ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    67f0:	8d 48 01             	lea    0x1(%eax),%ecx
    67f3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    67f8:	89 c8                	mov    %ecx,%eax
    67fa:	f7 ea                	imul   %edx
    67fc:	c1 fa 02             	sar    $0x2,%edx
    67ff:	89 c8                	mov    %ecx,%eax
    6801:	c1 f8 1f             	sar    $0x1f,%eax
    6804:	29 c2                	sub    %eax,%edx
    6806:	89 d0                	mov    %edx,%eax
    6808:	c1 e0 03             	shl    $0x3,%eax
    680b:	01 d0                	add    %edx,%eax
    680d:	01 c0                	add    %eax,%eax
    680f:	29 c1                	sub    %eax,%ecx
    6811:	89 ca                	mov    %ecx,%edx
    6813:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6816:	89 04 93             	mov    %eax,(%ebx,%edx,4)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    6819:	83 45 e4 02          	addl   $0x2,-0x1c(%ebp)
    681d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    6820:	8b 75 0c             	mov    0xc(%ebp),%esi
    6823:	8b 45 14             	mov    0x14(%ebp),%eax
    6826:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6829:	89 c2                	mov    %eax,%edx
    682b:	c1 e2 03             	shl    $0x3,%edx
    682e:	01 c2                	add    %eax,%edx
    6830:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6837:	89 c2                	mov    %eax,%edx
    6839:	89 c8                	mov    %ecx,%eax
    683b:	c1 e0 02             	shl    $0x2,%eax
    683e:	01 c8                	add    %ecx,%eax
    6840:	c1 e0 05             	shl    $0x5,%eax
    6843:	01 d0                	add    %edx,%eax
    6845:	01 f0                	add    %esi,%eax
    6847:	83 c0 1c             	add    $0x1c,%eax
    684a:	8b 00                	mov    (%eax),%eax
    684c:	01 c0                	add    %eax,%eax
    684e:	39 c3                	cmp    %eax,%ebx
    6850:	0f 82 1b fe ff ff    	jb     6671 <III_hufman_decode+0x15a>
      is[i/SSLIMIT][i%SSLIMIT] = x;
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
    6856:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6859:	8b 45 14             	mov    0x14(%ebp),%eax
    685c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    685f:	89 c2                	mov    %eax,%edx
    6861:	c1 e2 03             	shl    $0x3,%edx
    6864:	01 c2                	add    %eax,%edx
    6866:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    686d:	89 c2                	mov    %eax,%edx
    686f:	89 c8                	mov    %ecx,%eax
    6871:	c1 e0 02             	shl    $0x2,%eax
    6874:	01 c8                	add    %ecx,%eax
    6876:	c1 e0 05             	shl    $0x5,%eax
    6879:	01 d0                	add    %edx,%eax
    687b:	01 d8                	add    %ebx,%eax
    687d:	83 c0 5c             	add    $0x5c,%eax
    6880:	8b 00                	mov    (%eax),%eax
    6882:	8d 50 20             	lea    0x20(%eax),%edx
    6885:	89 d0                	mov    %edx,%eax
    6887:	c1 e0 02             	shl    $0x2,%eax
    688a:	01 d0                	add    %edx,%eax
    688c:	c1 e0 03             	shl    $0x3,%eax
    688f:	05 e0 01 01 00       	add    $0x101e0,%eax
    6894:	89 45 e0             	mov    %eax,-0x20(%ebp)
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    6897:	e9 91 01 00 00       	jmp    6a2d <III_hufman_decode+0x516>
     ( i < SSLIMIT*SBLIMIT )) {
      huffman_decoder(h, &x, &y, &v, &w);
    689c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    689f:	89 44 24 10          	mov    %eax,0x10(%esp)
    68a3:	8d 45 cc             	lea    -0x34(%ebp),%eax
    68a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
    68aa:	8d 45 d0             	lea    -0x30(%ebp),%eax
    68ad:	89 44 24 08          	mov    %eax,0x8(%esp)
    68b1:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    68b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    68b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    68bb:	89 04 24             	mov    %eax,(%esp)
    68be:	e8 a3 ed ff ff       	call   5666 <huffman_decoder>
      is[i/SSLIMIT][i%SSLIMIT] = v;
    68c3:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    68c6:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    68cb:	89 c8                	mov    %ecx,%eax
    68cd:	f7 ea                	imul   %edx
    68cf:	c1 fa 02             	sar    $0x2,%edx
    68d2:	89 c8                	mov    %ecx,%eax
    68d4:	c1 f8 1f             	sar    $0x1f,%eax
    68d7:	29 c2                	sub    %eax,%edx
    68d9:	89 d0                	mov    %edx,%eax
    68db:	89 c2                	mov    %eax,%edx
    68dd:	89 d0                	mov    %edx,%eax
    68df:	c1 e0 03             	shl    $0x3,%eax
    68e2:	01 d0                	add    %edx,%eax
    68e4:	c1 e0 03             	shl    $0x3,%eax
    68e7:	89 c2                	mov    %eax,%edx
    68e9:	8b 45 08             	mov    0x8(%ebp),%eax
    68ec:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    68ef:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    68f2:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    68f7:	89 c8                	mov    %ecx,%eax
    68f9:	f7 ea                	imul   %edx
    68fb:	c1 fa 02             	sar    $0x2,%edx
    68fe:	89 c8                	mov    %ecx,%eax
    6900:	c1 f8 1f             	sar    $0x1f,%eax
    6903:	29 c2                	sub    %eax,%edx
    6905:	89 d0                	mov    %edx,%eax
    6907:	c1 e0 03             	shl    $0x3,%eax
    690a:	01 d0                	add    %edx,%eax
    690c:	01 c0                	add    %eax,%eax
    690e:	29 c1                	sub    %eax,%ecx
    6910:	89 ca                	mov    %ecx,%edx
    6912:	8b 45 cc             	mov    -0x34(%ebp),%eax
    6915:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = w;
    6918:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    691b:	8d 48 01             	lea    0x1(%eax),%ecx
    691e:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6923:	89 c8                	mov    %ecx,%eax
    6925:	f7 ea                	imul   %edx
    6927:	c1 fa 02             	sar    $0x2,%edx
    692a:	89 c8                	mov    %ecx,%eax
    692c:	c1 f8 1f             	sar    $0x1f,%eax
    692f:	29 c2                	sub    %eax,%edx
    6931:	89 d0                	mov    %edx,%eax
    6933:	89 c2                	mov    %eax,%edx
    6935:	89 d0                	mov    %edx,%eax
    6937:	c1 e0 03             	shl    $0x3,%eax
    693a:	01 d0                	add    %edx,%eax
    693c:	c1 e0 03             	shl    $0x3,%eax
    693f:	89 c2                	mov    %eax,%edx
    6941:	8b 45 08             	mov    0x8(%ebp),%eax
    6944:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6947:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    694a:	8d 48 01             	lea    0x1(%eax),%ecx
    694d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6952:	89 c8                	mov    %ecx,%eax
    6954:	f7 ea                	imul   %edx
    6956:	c1 fa 02             	sar    $0x2,%edx
    6959:	89 c8                	mov    %ecx,%eax
    695b:	c1 f8 1f             	sar    $0x1f,%eax
    695e:	29 c2                	sub    %eax,%edx
    6960:	89 d0                	mov    %edx,%eax
    6962:	c1 e0 03             	shl    $0x3,%eax
    6965:	01 d0                	add    %edx,%eax
    6967:	01 c0                	add    %eax,%eax
    6969:	29 c1                	sub    %eax,%ecx
    696b:	89 ca                	mov    %ecx,%edx
    696d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    6970:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
    6973:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    6976:	8d 48 02             	lea    0x2(%eax),%ecx
    6979:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    697e:	89 c8                	mov    %ecx,%eax
    6980:	f7 ea                	imul   %edx
    6982:	c1 fa 02             	sar    $0x2,%edx
    6985:	89 c8                	mov    %ecx,%eax
    6987:	c1 f8 1f             	sar    $0x1f,%eax
    698a:	29 c2                	sub    %eax,%edx
    698c:	89 d0                	mov    %edx,%eax
    698e:	89 c2                	mov    %eax,%edx
    6990:	89 d0                	mov    %edx,%eax
    6992:	c1 e0 03             	shl    $0x3,%eax
    6995:	01 d0                	add    %edx,%eax
    6997:	c1 e0 03             	shl    $0x3,%eax
    699a:	89 c2                	mov    %eax,%edx
    699c:	8b 45 08             	mov    0x8(%ebp),%eax
    699f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    69a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    69a5:	8d 48 02             	lea    0x2(%eax),%ecx
    69a8:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    69ad:	89 c8                	mov    %ecx,%eax
    69af:	f7 ea                	imul   %edx
    69b1:	c1 fa 02             	sar    $0x2,%edx
    69b4:	89 c8                	mov    %ecx,%eax
    69b6:	c1 f8 1f             	sar    $0x1f,%eax
    69b9:	29 c2                	sub    %eax,%edx
    69bb:	89 d0                	mov    %edx,%eax
    69bd:	c1 e0 03             	shl    $0x3,%eax
    69c0:	01 d0                	add    %edx,%eax
    69c2:	01 c0                	add    %eax,%eax
    69c4:	29 c1                	sub    %eax,%ecx
    69c6:	89 ca                	mov    %ecx,%edx
    69c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    69cb:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
    69ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    69d1:	8d 48 03             	lea    0x3(%eax),%ecx
    69d4:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    69d9:	89 c8                	mov    %ecx,%eax
    69db:	f7 ea                	imul   %edx
    69dd:	c1 fa 02             	sar    $0x2,%edx
    69e0:	89 c8                	mov    %ecx,%eax
    69e2:	c1 f8 1f             	sar    $0x1f,%eax
    69e5:	29 c2                	sub    %eax,%edx
    69e7:	89 d0                	mov    %edx,%eax
    69e9:	89 c2                	mov    %eax,%edx
    69eb:	89 d0                	mov    %edx,%eax
    69ed:	c1 e0 03             	shl    $0x3,%eax
    69f0:	01 d0                	add    %edx,%eax
    69f2:	c1 e0 03             	shl    $0x3,%eax
    69f5:	89 c2                	mov    %eax,%edx
    69f7:	8b 45 08             	mov    0x8(%ebp),%eax
    69fa:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    69fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    6a00:	8d 48 03             	lea    0x3(%eax),%ecx
    6a03:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6a08:	89 c8                	mov    %ecx,%eax
    6a0a:	f7 ea                	imul   %edx
    6a0c:	c1 fa 02             	sar    $0x2,%edx
    6a0f:	89 c8                	mov    %ecx,%eax
    6a11:	c1 f8 1f             	sar    $0x1f,%eax
    6a14:	29 c2                	sub    %eax,%edx
    6a16:	89 d0                	mov    %edx,%eax
    6a18:	c1 e0 03             	shl    $0x3,%eax
    6a1b:	01 d0                	add    %edx,%eax
    6a1d:	01 c0                	add    %eax,%eax
    6a1f:	29 c1                	sub    %eax,%ecx
    6a21:	89 ca                	mov    %ecx,%edx
    6a23:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6a26:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      i += 4;
    6a29:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    6a2d:	e8 5b d3 ff ff       	call   3d8d <hsstell>
    6a32:	89 c3                	mov    %eax,%ebx
    6a34:	8b 75 0c             	mov    0xc(%ebp),%esi
    6a37:	8b 45 14             	mov    0x14(%ebp),%eax
    6a3a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6a3d:	89 c2                	mov    %eax,%edx
    6a3f:	c1 e2 03             	shl    $0x3,%edx
    6a42:	01 c2                	add    %eax,%edx
    6a44:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6a4b:	89 c2                	mov    %eax,%edx
    6a4d:	89 c8                	mov    %ecx,%eax
    6a4f:	c1 e0 02             	shl    $0x2,%eax
    6a52:	01 c8                	add    %ecx,%eax
    6a54:	c1 e0 05             	shl    $0x5,%eax
    6a57:	01 d0                	add    %edx,%eax
    6a59:	01 f0                	add    %esi,%eax
    6a5b:	83 c0 18             	add    $0x18,%eax
    6a5e:	8b 10                	mov    (%eax),%edx
    6a60:	8b 45 18             	mov    0x18(%ebp),%eax
    6a63:	01 d0                	add    %edx,%eax
    6a65:	39 c3                	cmp    %eax,%ebx
    6a67:	73 0d                	jae    6a76 <III_hufman_decode+0x55f>
    6a69:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    6a70:	0f 8e 26 fe ff ff    	jle    689c <III_hufman_decode+0x385>
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
      i += 4;
      }

   if (hsstell() > part2_start + (*si).ch[ch].gr[gr].part2_3_length)
    6a76:	e8 12 d3 ff ff       	call   3d8d <hsstell>
    6a7b:	89 c3                	mov    %eax,%ebx
    6a7d:	8b 75 0c             	mov    0xc(%ebp),%esi
    6a80:	8b 45 14             	mov    0x14(%ebp),%eax
    6a83:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6a86:	89 c2                	mov    %eax,%edx
    6a88:	c1 e2 03             	shl    $0x3,%edx
    6a8b:	01 c2                	add    %eax,%edx
    6a8d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6a94:	89 c2                	mov    %eax,%edx
    6a96:	89 c8                	mov    %ecx,%eax
    6a98:	c1 e0 02             	shl    $0x2,%eax
    6a9b:	01 c8                	add    %ecx,%eax
    6a9d:	c1 e0 05             	shl    $0x5,%eax
    6aa0:	01 d0                	add    %edx,%eax
    6aa2:	01 f0                	add    %esi,%eax
    6aa4:	83 c0 18             	add    $0x18,%eax
    6aa7:	8b 10                	mov    (%eax),%edx
    6aa9:	8b 45 18             	mov    0x18(%ebp),%eax
    6aac:	01 d0                	add    %edx,%eax
    6aae:	39 c3                	cmp    %eax,%ebx
    6ab0:	76 48                	jbe    6afa <III_hufman_decode+0x5e3>
   {  i -=4;
    6ab2:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
      rewindNbits(hsstell()-part2_start - (*si).ch[ch].gr[gr].part2_3_length);
    6ab6:	e8 d2 d2 ff ff       	call   3d8d <hsstell>
    6abb:	8b 55 18             	mov    0x18(%ebp),%edx
    6abe:	29 d0                	sub    %edx,%eax
    6ac0:	89 c6                	mov    %eax,%esi
    6ac2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6ac5:	8b 45 14             	mov    0x14(%ebp),%eax
    6ac8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6acb:	89 c2                	mov    %eax,%edx
    6acd:	c1 e2 03             	shl    $0x3,%edx
    6ad0:	01 c2                	add    %eax,%edx
    6ad2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6ad9:	89 c2                	mov    %eax,%edx
    6adb:	89 c8                	mov    %ecx,%eax
    6add:	c1 e0 02             	shl    $0x2,%eax
    6ae0:	01 c8                	add    %ecx,%eax
    6ae2:	c1 e0 05             	shl    $0x5,%eax
    6ae5:	01 d0                	add    %edx,%eax
    6ae7:	01 d8                	add    %ebx,%eax
    6ae9:	83 c0 18             	add    $0x18,%eax
    6aec:	8b 00                	mov    (%eax),%eax
    6aee:	29 c6                	sub    %eax,%esi
    6af0:	89 f0                	mov    %esi,%eax
    6af2:	89 04 24             	mov    %eax,(%esp)
    6af5:	e8 de d2 ff ff       	call   3dd8 <rewindNbits>
   }

   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
    6afa:	e8 8e d2 ff ff       	call   3d8d <hsstell>
    6aff:	89 c3                	mov    %eax,%ebx
    6b01:	8b 75 0c             	mov    0xc(%ebp),%esi
    6b04:	8b 45 14             	mov    0x14(%ebp),%eax
    6b07:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6b0a:	89 c2                	mov    %eax,%edx
    6b0c:	c1 e2 03             	shl    $0x3,%edx
    6b0f:	01 c2                	add    %eax,%edx
    6b11:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6b18:	89 c2                	mov    %eax,%edx
    6b1a:	89 c8                	mov    %ecx,%eax
    6b1c:	c1 e0 02             	shl    $0x2,%eax
    6b1f:	01 c8                	add    %ecx,%eax
    6b21:	c1 e0 05             	shl    $0x5,%eax
    6b24:	01 d0                	add    %edx,%eax
    6b26:	01 f0                	add    %esi,%eax
    6b28:	83 c0 18             	add    $0x18,%eax
    6b2b:	8b 10                	mov    (%eax),%edx
    6b2d:	8b 45 18             	mov    0x18(%ebp),%eax
    6b30:	01 d0                	add    %edx,%eax
    6b32:	39 c3                	cmp    %eax,%ebx
    6b34:	73 45                	jae    6b7b <III_hufman_decode+0x664>
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());
    6b36:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6b39:	8b 45 14             	mov    0x14(%ebp),%eax
    6b3c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6b3f:	89 c2                	mov    %eax,%edx
    6b41:	c1 e2 03             	shl    $0x3,%edx
    6b44:	01 c2                	add    %eax,%edx
    6b46:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6b4d:	89 c2                	mov    %eax,%edx
    6b4f:	89 c8                	mov    %ecx,%eax
    6b51:	c1 e0 02             	shl    $0x2,%eax
    6b54:	01 c8                	add    %ecx,%eax
    6b56:	c1 e0 05             	shl    $0x5,%eax
    6b59:	01 d0                	add    %edx,%eax
    6b5b:	01 d8                	add    %ebx,%eax
    6b5d:	83 c0 18             	add    $0x18,%eax
    6b60:	8b 10                	mov    (%eax),%edx
    6b62:	8b 45 18             	mov    0x18(%ebp),%eax
    6b65:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6b68:	e8 20 d2 ff ff       	call   3d8d <hsstell>
    6b6d:	29 c3                	sub    %eax,%ebx
    6b6f:	89 d8                	mov    %ebx,%eax
    6b71:	89 04 24             	mov    %eax,(%esp)
    6b74:	e8 30 d2 ff ff       	call   3da9 <hgetbits>

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    6b79:	eb 5c                	jmp    6bd7 <III_hufman_decode+0x6c0>
    6b7b:	eb 5a                	jmp    6bd7 <III_hufman_decode+0x6c0>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
    6b7d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    6b80:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6b85:	89 c8                	mov    %ecx,%eax
    6b87:	f7 ea                	imul   %edx
    6b89:	c1 fa 02             	sar    $0x2,%edx
    6b8c:	89 c8                	mov    %ecx,%eax
    6b8e:	c1 f8 1f             	sar    $0x1f,%eax
    6b91:	29 c2                	sub    %eax,%edx
    6b93:	89 d0                	mov    %edx,%eax
    6b95:	89 c2                	mov    %eax,%edx
    6b97:	89 d0                	mov    %edx,%eax
    6b99:	c1 e0 03             	shl    $0x3,%eax
    6b9c:	01 d0                	add    %edx,%eax
    6b9e:	c1 e0 03             	shl    $0x3,%eax
    6ba1:	89 c2                	mov    %eax,%edx
    6ba3:	8b 45 08             	mov    0x8(%ebp),%eax
    6ba6:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6ba9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    6bac:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6bb1:	89 c8                	mov    %ecx,%eax
    6bb3:	f7 ea                	imul   %edx
    6bb5:	c1 fa 02             	sar    $0x2,%edx
    6bb8:	89 c8                	mov    %ecx,%eax
    6bba:	c1 f8 1f             	sar    $0x1f,%eax
    6bbd:	29 c2                	sub    %eax,%edx
    6bbf:	89 d0                	mov    %edx,%eax
    6bc1:	c1 e0 03             	shl    $0x3,%eax
    6bc4:	01 d0                	add    %edx,%eax
    6bc6:	01 c0                	add    %eax,%eax
    6bc8:	29 c1                	sub    %eax,%ecx
    6bca:	89 ca                	mov    %ecx,%edx
    6bcc:	c7 04 93 00 00 00 00 	movl   $0x0,(%ebx,%edx,4)
   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    6bd3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    6bd7:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    6bde:	7e 9d                	jle    6b7d <III_hufman_decode+0x666>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
}
    6be0:	83 c4 4c             	add    $0x4c,%esp
    6be3:	5b                   	pop    %ebx
    6be4:	5e                   	pop    %esi
    6be5:	5f                   	pop    %edi
    6be6:	5d                   	pop    %ebp
    6be7:	c3                   	ret    

00006be8 <III_dequantize_sample>:


int pretab[22] = {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,3,3,3,2,0};

void III_dequantize_sample(long int is[SBLIMIT][SSLIMIT], double xr[SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, int ch, struct frame_params *fr_ps)
{
    6be8:	55                   	push   %ebp
    6be9:	89 e5                	mov    %esp,%ebp
    6beb:	56                   	push   %esi
    6bec:	53                   	push   %ebx
    6bed:	83 ec 50             	sub    $0x50,%esp
	int ss,sb,cb=0,sfreq=fr_ps->header->sampling_frequency;
    6bf0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    6bf7:	8b 45 1c             	mov    0x1c(%ebp),%eax
    6bfa:	8b 00                	mov    (%eax),%eax
    6bfc:	8b 40 10             	mov    0x10(%eax),%eax
    6bff:	89 45 dc             	mov    %eax,-0x24(%ebp)
	//int stereo = fr_ps->stereo;
	int next_cb_boundary, cb_begin, cb_width = 0, sign;
    6c02:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
    6c09:	8b 45 14             	mov    0x14(%ebp),%eax
    6c0c:	8b 40 10             	mov    0x10(%eax),%eax
    6c0f:	85 c0                	test   %eax,%eax
    6c11:	74 61                	je     6c74 <III_dequantize_sample+0x8c>
    6c13:	8b 45 14             	mov    0x14(%ebp),%eax
    6c16:	8b 40 14             	mov    0x14(%eax),%eax
    6c19:	83 f8 02             	cmp    $0x2,%eax
    6c1c:	75 56                	jne    6c74 <III_dequantize_sample+0x8c>
		if (gr_info->mixed_block_flag)
    6c1e:	8b 45 14             	mov    0x14(%ebp),%eax
    6c21:	8b 40 18             	mov    0x18(%eax),%eax
    6c24:	85 c0                	test   %eax,%eax
    6c26:	74 15                	je     6c3d <III_dequantize_sample+0x55>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    6c28:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6c2b:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6c31:	05 24 cf 00 00       	add    $0xcf24,%eax
    6c36:	8b 00                	mov    (%eax),%eax
    6c38:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    6c3b:	eb 4a                	jmp    6c87 <III_dequantize_sample+0x9f>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
		else {
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
    6c3d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6c40:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6c46:	05 74 cf 00 00       	add    $0xcf74,%eax
    6c4b:	8b 50 0c             	mov    0xc(%eax),%edx
    6c4e:	89 d0                	mov    %edx,%eax
    6c50:	01 c0                	add    %eax,%eax
    6c52:	01 d0                	add    %edx,%eax
    6c54:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cb_width = sfBandIndex[sfreq].s[1];
    6c57:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6c5a:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6c60:	05 74 cf 00 00       	add    $0xcf74,%eax
    6c65:	8b 40 0c             	mov    0xc(%eax),%eax
    6c68:	89 45 e0             	mov    %eax,-0x20(%ebp)
			cb_begin = 0;
    6c6b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    6c72:	eb 13                	jmp    6c87 <III_dequantize_sample+0x9f>
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
			cb_width = sfBandIndex[sfreq].s[1];
			cb_begin = 0;
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    6c74:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6c77:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6c7d:	05 24 cf 00 00       	add    $0xcf24,%eax
    6c82:	8b 00                	mov    (%eax),%eax
    6c84:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    6c87:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    6c8e:	e9 3d 06 00 00       	jmp    72d0 <III_dequantize_sample+0x6e8>
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    6c93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    6c9a:	e9 23 06 00 00       	jmp    72c2 <III_dequantize_sample+0x6da>
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
    6c9f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6ca2:	89 d0                	mov    %edx,%eax
    6ca4:	c1 e0 03             	shl    $0x3,%eax
    6ca7:	01 d0                	add    %edx,%eax
    6ca9:	01 c0                	add    %eax,%eax
    6cab:	89 c2                	mov    %eax,%edx
    6cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6cb0:	01 d0                	add    %edx,%eax
    6cb2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    6cb5:	0f 85 9e 02 00 00    	jne    6f59 <III_dequantize_sample+0x371>
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    6cbb:	8b 45 14             	mov    0x14(%ebp),%eax
    6cbe:	8b 40 10             	mov    0x10(%eax),%eax
    6cc1:	85 c0                	test   %eax,%eax
    6cc3:	0f 84 6b 02 00 00    	je     6f34 <III_dequantize_sample+0x34c>
    6cc9:	8b 45 14             	mov    0x14(%ebp),%eax
    6ccc:	8b 40 14             	mov    0x14(%eax),%eax
    6ccf:	83 f8 02             	cmp    $0x2,%eax
    6cd2:	0f 85 5c 02 00 00    	jne    6f34 <III_dequantize_sample+0x34c>
					if (gr_info->mixed_block_flag) {
    6cd8:	8b 45 14             	mov    0x14(%ebp),%eax
    6cdb:	8b 40 18             	mov    0x18(%eax),%eax
    6cde:	85 c0                	test   %eax,%eax
    6ce0:	0f 84 af 01 00 00    	je     6e95 <III_dequantize_sample+0x2ad>
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
    6ce6:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6ce9:	89 d0                	mov    %edx,%eax
    6ceb:	c1 e0 03             	shl    $0x3,%eax
    6cee:	01 d0                	add    %edx,%eax
    6cf0:	01 c0                	add    %eax,%eax
    6cf2:	89 c2                	mov    %eax,%edx
    6cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6cf7:	01 c2                	add    %eax,%edx
    6cf9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6cfc:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6d02:	05 40 cf 00 00       	add    $0xcf40,%eax
    6d07:	8b 00                	mov    (%eax),%eax
    6d09:	39 c2                	cmp    %eax,%edx
    6d0b:	0f 85 93 00 00 00    	jne    6da4 <III_dequantize_sample+0x1bc>
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
    6d11:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6d14:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6d1a:	05 80 cf 00 00       	add    $0xcf80,%eax
    6d1f:	8b 50 0c             	mov    0xc(%eax),%edx
    6d22:	89 d0                	mov    %edx,%eax
    6d24:	01 c0                	add    %eax,%eax
    6d26:	01 d0                	add    %edx,%eax
    6d28:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb = 3;
    6d2b:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    6d32:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6d35:	8d 48 01             	lea    0x1(%eax),%ecx
    6d38:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6d3b:	89 d0                	mov    %edx,%eax
    6d3d:	c1 e0 03             	shl    $0x3,%eax
    6d40:	01 d0                	add    %edx,%eax
    6d42:	c1 e0 02             	shl    $0x2,%eax
    6d45:	01 d0                	add    %edx,%eax
    6d47:	01 c8                	add    %ecx,%eax
    6d49:	83 c0 14             	add    $0x14,%eax
    6d4c:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    6d53:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6d56:	89 d0                	mov    %edx,%eax
    6d58:	c1 e0 03             	shl    $0x3,%eax
    6d5b:	01 d0                	add    %edx,%eax
    6d5d:	c1 e0 02             	shl    $0x2,%eax
    6d60:	01 d0                	add    %edx,%eax
    6d62:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6d65:	01 d0                	add    %edx,%eax
    6d67:	83 c0 14             	add    $0x14,%eax
    6d6a:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
							cb = 3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    6d71:	29 c1                	sub    %eax,%ecx
    6d73:	89 c8                	mov    %ecx,%eax
    6d75:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    6d78:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6d7b:	89 d0                	mov    %edx,%eax
    6d7d:	c1 e0 03             	shl    $0x3,%eax
    6d80:	01 d0                	add    %edx,%eax
    6d82:	c1 e0 02             	shl    $0x2,%eax
    6d85:	01 d0                	add    %edx,%eax
    6d87:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6d8a:	01 d0                	add    %edx,%eax
    6d8c:	83 c0 14             	add    $0x14,%eax
    6d8f:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    6d96:	89 d0                	mov    %edx,%eax
    6d98:	01 c0                	add    %eax,%eax
    6d9a:	01 d0                	add    %edx,%eax
    6d9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    6d9f:	e9 8e 01 00 00       	jmp    6f32 <III_dequantize_sample+0x34a>
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
    6da4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6da7:	89 d0                	mov    %edx,%eax
    6da9:	c1 e0 03             	shl    $0x3,%eax
    6dac:	01 d0                	add    %edx,%eax
    6dae:	01 c0                	add    %eax,%eax
    6db0:	89 c2                	mov    %eax,%edx
    6db2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6db5:	01 c2                	add    %eax,%edx
    6db7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6dba:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6dc0:	05 40 cf 00 00       	add    $0xcf40,%eax
    6dc5:	8b 00                	mov    (%eax),%eax
    6dc7:	39 c2                	cmp    %eax,%edx
    6dc9:	7d 2a                	jge    6df5 <III_dequantize_sample+0x20d>
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    6dcb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6dcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6dd2:	8d 48 01             	lea    0x1(%eax),%ecx
    6dd5:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6dd8:	89 d0                	mov    %edx,%eax
    6dda:	c1 e0 03             	shl    $0x3,%eax
    6ddd:	01 d0                	add    %edx,%eax
    6ddf:	c1 e0 02             	shl    $0x2,%eax
    6de2:	01 d0                	add    %edx,%eax
    6de4:	01 c8                	add    %ecx,%eax
    6de6:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    6ded:	89 45 e8             	mov    %eax,-0x18(%ebp)
    6df0:	e9 3d 01 00 00       	jmp    6f32 <III_dequantize_sample+0x34a>
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    6df5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6df9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6dfc:	8d 48 01             	lea    0x1(%eax),%ecx
    6dff:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6e02:	89 d0                	mov    %edx,%eax
    6e04:	c1 e0 03             	shl    $0x3,%eax
    6e07:	01 d0                	add    %edx,%eax
    6e09:	c1 e0 02             	shl    $0x2,%eax
    6e0c:	01 d0                	add    %edx,%eax
    6e0e:	01 c8                	add    %ecx,%eax
    6e10:	83 c0 14             	add    $0x14,%eax
    6e13:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    6e1a:	89 d0                	mov    %edx,%eax
    6e1c:	01 c0                	add    %eax,%eax
    6e1e:	01 d0                	add    %edx,%eax
    6e20:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    6e23:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6e26:	8d 48 01             	lea    0x1(%eax),%ecx
    6e29:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6e2c:	89 d0                	mov    %edx,%eax
    6e2e:	c1 e0 03             	shl    $0x3,%eax
    6e31:	01 d0                	add    %edx,%eax
    6e33:	c1 e0 02             	shl    $0x2,%eax
    6e36:	01 d0                	add    %edx,%eax
    6e38:	01 c8                	add    %ecx,%eax
    6e3a:	83 c0 14             	add    $0x14,%eax
    6e3d:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    6e44:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6e47:	89 d0                	mov    %edx,%eax
    6e49:	c1 e0 03             	shl    $0x3,%eax
    6e4c:	01 d0                	add    %edx,%eax
    6e4e:	c1 e0 02             	shl    $0x2,%eax
    6e51:	01 d0                	add    %edx,%eax
    6e53:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6e56:	01 d0                	add    %edx,%eax
    6e58:	83 c0 14             	add    $0x14,%eax
    6e5b:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    6e62:	29 c1                	sub    %eax,%ecx
    6e64:	89 c8                	mov    %ecx,%eax
    6e66:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    6e69:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6e6c:	89 d0                	mov    %edx,%eax
    6e6e:	c1 e0 03             	shl    $0x3,%eax
    6e71:	01 d0                	add    %edx,%eax
    6e73:	c1 e0 02             	shl    $0x2,%eax
    6e76:	01 d0                	add    %edx,%eax
    6e78:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6e7b:	01 d0                	add    %edx,%eax
    6e7d:	83 c0 14             	add    $0x14,%eax
    6e80:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    6e87:	89 d0                	mov    %edx,%eax
    6e89:	01 c0                	add    %eax,%eax
    6e8b:	01 d0                	add    %edx,%eax
    6e8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    6e90:	e9 c4 00 00 00       	jmp    6f59 <III_dequantize_sample+0x371>
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    6e95:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6e99:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6e9c:	8d 48 01             	lea    0x1(%eax),%ecx
    6e9f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6ea2:	89 d0                	mov    %edx,%eax
    6ea4:	c1 e0 03             	shl    $0x3,%eax
    6ea7:	01 d0                	add    %edx,%eax
    6ea9:	c1 e0 02             	shl    $0x2,%eax
    6eac:	01 d0                	add    %edx,%eax
    6eae:	01 c8                	add    %ecx,%eax
    6eb0:	83 c0 14             	add    $0x14,%eax
    6eb3:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    6eba:	89 d0                	mov    %edx,%eax
    6ebc:	01 c0                	add    %eax,%eax
    6ebe:	01 d0                	add    %edx,%eax
    6ec0:	89 45 e8             	mov    %eax,-0x18(%ebp)
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    6ec3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6ec6:	8d 48 01             	lea    0x1(%eax),%ecx
    6ec9:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6ecc:	89 d0                	mov    %edx,%eax
    6ece:	c1 e0 03             	shl    $0x3,%eax
    6ed1:	01 d0                	add    %edx,%eax
    6ed3:	c1 e0 02             	shl    $0x2,%eax
    6ed6:	01 d0                	add    %edx,%eax
    6ed8:	01 c8                	add    %ecx,%eax
    6eda:	83 c0 14             	add    $0x14,%eax
    6edd:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
									sfBandIndex[sfreq].s[cb];
    6ee4:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6ee7:	89 d0                	mov    %edx,%eax
    6ee9:	c1 e0 03             	shl    $0x3,%eax
    6eec:	01 d0                	add    %edx,%eax
    6eee:	c1 e0 02             	shl    $0x2,%eax
    6ef1:	01 d0                	add    %edx,%eax
    6ef3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6ef6:	01 d0                	add    %edx,%eax
    6ef8:	83 c0 14             	add    $0x14,%eax
    6efb:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    6f02:	29 c1                	sub    %eax,%ecx
    6f04:	89 c8                	mov    %ecx,%eax
    6f06:	89 45 e0             	mov    %eax,-0x20(%ebp)
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
    6f09:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6f0c:	89 d0                	mov    %edx,%eax
    6f0e:	c1 e0 03             	shl    $0x3,%eax
    6f11:	01 d0                	add    %edx,%eax
    6f13:	c1 e0 02             	shl    $0x2,%eax
    6f16:	01 d0                	add    %edx,%eax
    6f18:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6f1b:	01 d0                	add    %edx,%eax
    6f1d:	83 c0 14             	add    $0x14,%eax
    6f20:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    6f27:	89 d0                	mov    %edx,%eax
    6f29:	01 c0                	add    %eax,%eax
    6f2b:	01 d0                	add    %edx,%eax
    6f2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    6f30:	eb 27                	jmp    6f59 <III_dequantize_sample+0x371>
    6f32:	eb 25                	jmp    6f59 <III_dequantize_sample+0x371>
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
					}
				}
	            else /* long blocks */
		           next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    6f34:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6f38:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6f3b:	8d 48 01             	lea    0x1(%eax),%ecx
    6f3e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6f41:	89 d0                	mov    %edx,%eax
    6f43:	c1 e0 03             	shl    $0x3,%eax
    6f46:	01 d0                	add    %edx,%eax
    6f48:	c1 e0 02             	shl    $0x2,%eax
    6f4b:	01 d0                	add    %edx,%eax
    6f4d:	01 c8                	add    %ecx,%eax
    6f4f:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    6f56:	89 45 e8             	mov    %eax,-0x18(%ebp)
			}

			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));
    6f59:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6f5c:	89 d0                	mov    %edx,%eax
    6f5e:	c1 e0 03             	shl    $0x3,%eax
    6f61:	01 d0                	add    %edx,%eax
    6f63:	c1 e0 04             	shl    $0x4,%eax
    6f66:	89 c2                	mov    %eax,%edx
    6f68:	8b 45 0c             	mov    0xc(%ebp),%eax
    6f6b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6f6e:	8b 45 14             	mov    0x14(%ebp),%eax
    6f71:	8b 40 08             	mov    0x8(%eax),%eax
    6f74:	ba 00 00 00 00       	mov    $0x0,%edx
    6f79:	89 45 c8             	mov    %eax,-0x38(%ebp)
    6f7c:	89 55 cc             	mov    %edx,-0x34(%ebp)
    6f7f:	df 6d c8             	fildll -0x38(%ebp)
    6f82:	dd 05 30 bd 00 00    	fldl   0xbd30
    6f88:	de e9                	fsubrp %st,%st(1)
    6f8a:	dd 05 38 bd 00 00    	fldl   0xbd38
    6f90:	de c9                	fmulp  %st,%st(1)
    6f92:	dd 5c 24 08          	fstpl  0x8(%esp)
    6f96:	dd 05 40 bd 00 00    	fldl   0xbd40
    6f9c:	dd 1c 24             	fstpl  (%esp)
    6f9f:	e8 0c c1 ff ff       	call   30b0 <pow>
    6fa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6fa7:	dd 1c c3             	fstpl  (%ebx,%eax,8)

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    6faa:	8b 45 14             	mov    0x14(%ebp),%eax
    6fad:	8b 40 10             	mov    0x10(%eax),%eax
    6fb0:	85 c0                	test   %eax,%eax
    6fb2:	0f 84 86 01 00 00    	je     713e <III_dequantize_sample+0x556>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    6fb8:	8b 45 14             	mov    0x14(%ebp),%eax
    6fbb:	8b 40 14             	mov    0x14(%eax),%eax
			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    6fbe:	83 f8 02             	cmp    $0x2,%eax
    6fc1:	75 0a                	jne    6fcd <III_dequantize_sample+0x3e5>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    6fc3:	8b 45 14             	mov    0x14(%ebp),%eax
    6fc6:	8b 40 18             	mov    0x18(%eax),%eax
    6fc9:	85 c0                	test   %eax,%eax
    6fcb:	74 27                	je     6ff4 <III_dequantize_sample+0x40c>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    6fcd:	8b 45 14             	mov    0x14(%ebp),%eax
    6fd0:	8b 40 14             	mov    0x14(%eax),%eax
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    6fd3:	83 f8 02             	cmp    $0x2,%eax
    6fd6:	0f 85 62 01 00 00    	jne    713e <III_dequantize_sample+0x556>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    6fdc:	8b 45 14             	mov    0x14(%ebp),%eax
    6fdf:	8b 40 18             	mov    0x18(%eax),%eax
    6fe2:	85 c0                	test   %eax,%eax
    6fe4:	0f 84 54 01 00 00    	je     713e <III_dequantize_sample+0x556>
    6fea:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    6fee:	0f 8e 4a 01 00 00    	jle    713e <III_dequantize_sample+0x556>

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    6ff4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6ff7:	89 d0                	mov    %edx,%eax
    6ff9:	c1 e0 03             	shl    $0x3,%eax
    6ffc:	01 d0                	add    %edx,%eax
    6ffe:	c1 e0 04             	shl    $0x4,%eax
    7001:	89 c2                	mov    %eax,%edx
    7003:	8b 45 0c             	mov    0xc(%ebp),%eax
    7006:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    7009:	8b 55 f0             	mov    -0x10(%ebp),%edx
    700c:	89 d0                	mov    %edx,%eax
    700e:	c1 e0 03             	shl    $0x3,%eax
    7011:	01 d0                	add    %edx,%eax
    7013:	c1 e0 04             	shl    $0x4,%eax
    7016:	89 c2                	mov    %eax,%edx
    7018:	8b 45 0c             	mov    0xc(%ebp),%eax
    701b:	01 c2                	add    %eax,%edx
    701d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7020:	dd 04 c2             	fldl   (%edx,%eax,8)
    7023:	dd 5d c0             	fstpl  -0x40(%ebp)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
    7026:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7029:	89 d0                	mov    %edx,%eax
    702b:	c1 e0 03             	shl    $0x3,%eax
    702e:	01 d0                	add    %edx,%eax
    7030:	01 c0                	add    %eax,%eax
    7032:	89 c2                	mov    %eax,%edx
    7034:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7037:	01 d0                	add    %edx,%eax
    7039:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    703c:	99                   	cltd   
    703d:	f7 7d e0             	idivl  -0x20(%ebp)
    7040:	89 c2                	mov    %eax,%edx
    7042:	8b 45 14             	mov    0x14(%ebp),%eax
    7045:	83 c2 08             	add    $0x8,%edx
    7048:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    704c:	ba 00 00 00 00       	mov    $0x0,%edx
    7051:	89 45 c8             	mov    %eax,-0x38(%ebp)
    7054:	89 55 cc             	mov    %edx,-0x34(%ebp)
    7057:	df 6d c8             	fildll -0x38(%ebp)
    705a:	dd 05 48 bd 00 00    	fldl   0xbd48
    7060:	de c9                	fmulp  %st,%st(1)
    7062:	dd 5c 24 08          	fstpl  0x8(%esp)
    7066:	dd 05 40 bd 00 00    	fldl   0xbd40
    706c:	dd 1c 24             	fstpl  (%esp)
    706f:	e8 3c c0 ff ff       	call   30b0 <pow>
    7074:	dc 4d c0             	fmull  -0x40(%ebp)
    7077:	8b 45 f4             	mov    -0xc(%ebp),%eax
    707a:	dd 1c c3             	fstpl  (%ebx,%eax,8)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    707d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7080:	89 d0                	mov    %edx,%eax
    7082:	c1 e0 03             	shl    $0x3,%eax
    7085:	01 d0                	add    %edx,%eax
    7087:	c1 e0 04             	shl    $0x4,%eax
    708a:	89 c2                	mov    %eax,%edx
    708c:	8b 45 0c             	mov    0xc(%ebp),%eax
    708f:	8d 34 02             	lea    (%edx,%eax,1),%esi
    7092:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7095:	89 d0                	mov    %edx,%eax
    7097:	c1 e0 03             	shl    $0x3,%eax
    709a:	01 d0                	add    %edx,%eax
    709c:	c1 e0 04             	shl    $0x4,%eax
    709f:	89 c2                	mov    %eax,%edx
    70a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    70a4:	01 c2                	add    %eax,%edx
    70a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    70a9:	dd 04 c2             	fldl   (%edx,%eax,8)
    70ac:	dd 5d c0             	fstpl  -0x40(%ebp)
    70af:	8b 45 14             	mov    0x14(%ebp),%eax
    70b2:	8b 40 40             	mov    0x40(%eax),%eax
    70b5:	ba 00 00 00 00       	mov    $0x0,%edx
    70ba:	89 45 c8             	mov    %eax,-0x38(%ebp)
    70bd:	89 55 cc             	mov    %edx,-0x34(%ebp)
    70c0:	df 6d c8             	fildll -0x38(%ebp)
    70c3:	d9 e8                	fld1   
    70c5:	de c1                	faddp  %st,%st(1)
    70c7:	dd 05 50 bd 00 00    	fldl   0xbd50
    70cd:	de c9                	fmulp  %st,%st(1)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
    70cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
    70d2:	89 d0                	mov    %edx,%eax
    70d4:	c1 e0 03             	shl    $0x3,%eax
    70d7:	01 d0                	add    %edx,%eax
    70d9:	01 c0                	add    %eax,%eax
    70db:	89 c2                	mov    %eax,%edx
    70dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    70e0:	01 d0                	add    %edx,%eax
    70e2:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    70e5:	99                   	cltd   
    70e6:	f7 7d e0             	idivl  -0x20(%ebp)
    70e9:	89 c2                	mov    %eax,%edx
    70eb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    70ee:	8b 4d 18             	mov    0x18(%ebp),%ecx
    70f1:	89 d0                	mov    %edx,%eax
    70f3:	01 c0                	add    %eax,%eax
    70f5:	01 d0                	add    %edx,%eax
    70f7:	c1 e0 02             	shl    $0x2,%eax
    70fa:	01 d0                	add    %edx,%eax
    70fc:	89 ca                	mov    %ecx,%edx
    70fe:	01 d2                	add    %edx,%edx
    7100:	89 d1                	mov    %edx,%ecx
    7102:	c1 e1 05             	shl    $0x5,%ecx
    7105:	29 d1                	sub    %edx,%ecx
    7107:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    710a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    710d:	01 d0                	add    %edx,%eax
    710f:	83 c0 14             	add    $0x14,%eax
    7112:	8b 44 83 0c          	mov    0xc(%ebx,%eax,4),%eax
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    7116:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    7119:	db 45 d4             	fildl  -0x2c(%ebp)
    711c:	de c9                	fmulp  %st,%st(1)
    711e:	dd 5c 24 08          	fstpl  0x8(%esp)
    7122:	dd 05 40 bd 00 00    	fldl   0xbd40
    7128:	dd 1c 24             	fstpl  (%esp)
    712b:	e8 80 bf ff ff       	call   30b0 <pow>
    7130:	dc 4d c0             	fmull  -0x40(%ebp)
    7133:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7136:	dd 1c c6             	fstpl  (%esi,%eax,8)
    7139:	e9 ab 00 00 00       	jmp    71e9 <III_dequantize_sample+0x601>
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    713e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7141:	89 d0                	mov    %edx,%eax
    7143:	c1 e0 03             	shl    $0x3,%eax
    7146:	01 d0                	add    %edx,%eax
    7148:	c1 e0 04             	shl    $0x4,%eax
    714b:	89 c2                	mov    %eax,%edx
    714d:	8b 45 0c             	mov    0xc(%ebp),%eax
    7150:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    7153:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7156:	89 d0                	mov    %edx,%eax
    7158:	c1 e0 03             	shl    $0x3,%eax
    715b:	01 d0                	add    %edx,%eax
    715d:	c1 e0 04             	shl    $0x4,%eax
    7160:	89 c2                	mov    %eax,%edx
    7162:	8b 45 0c             	mov    0xc(%ebp),%eax
    7165:	01 c2                	add    %eax,%edx
    7167:	8b 45 f4             	mov    -0xc(%ebp),%eax
    716a:	dd 04 c2             	fldl   (%edx,%eax,8)
    716d:	dd 5d c0             	fstpl  -0x40(%ebp)
    7170:	8b 45 14             	mov    0x14(%ebp),%eax
    7173:	8b 40 40             	mov    0x40(%eax),%eax
    7176:	ba 00 00 00 00       	mov    $0x0,%edx
    717b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    717e:	89 55 cc             	mov    %edx,-0x34(%ebp)
    7181:	df 6d c8             	fildll -0x38(%ebp)
    7184:	d9 e8                	fld1   
    7186:	de c1                	faddp  %st,%st(1)
    7188:	dd 05 50 bd 00 00    	fldl   0xbd50
    718e:	de c9                	fmulp  %st,%st(1)
								* ((*scalefac)[ch].l[cb]
    7190:	8b 4d 10             	mov    0x10(%ebp),%ecx
    7193:	8b 45 18             	mov    0x18(%ebp),%eax
    7196:	01 c0                	add    %eax,%eax
    7198:	89 c2                	mov    %eax,%edx
    719a:	c1 e2 05             	shl    $0x5,%edx
    719d:	29 c2                	sub    %eax,%edx
    719f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    71a2:	01 d0                	add    %edx,%eax
    71a4:	8b 04 81             	mov    (%ecx,%eax,4),%eax
								+ gr_info->preflag * pretab[cb]));
    71a7:	89 c2                	mov    %eax,%edx
    71a9:	8b 45 14             	mov    0x14(%ebp),%eax
    71ac:	8b 48 3c             	mov    0x3c(%eax),%ecx
    71af:	8b 45 ec             	mov    -0x14(%ebp),%eax
    71b2:	8b 04 85 e0 d0 00 00 	mov    0xd0e0(,%eax,4),%eax
    71b9:	0f af c1             	imul   %ecx,%eax
    71bc:	01 d0                	add    %edx,%eax
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    71be:	ba 00 00 00 00       	mov    $0x0,%edx
    71c3:	89 45 c8             	mov    %eax,-0x38(%ebp)
    71c6:	89 55 cc             	mov    %edx,-0x34(%ebp)
    71c9:	df 6d c8             	fildll -0x38(%ebp)
    71cc:	de c9                	fmulp  %st,%st(1)
    71ce:	dd 5c 24 08          	fstpl  0x8(%esp)
    71d2:	dd 05 40 bd 00 00    	fldl   0xbd40
    71d8:	dd 1c 24             	fstpl  (%esp)
    71db:	e8 d0 be ff ff       	call   30b0 <pow>
    71e0:	dc 4d c0             	fmull  -0x40(%ebp)
    71e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    71e6:	dd 1c c3             	fstpl  (%ebx,%eax,8)
								+ gr_info->preflag * pretab[cb]));
			}

			/* Scale quantized value. */

			sign = (is[sb][ss]<0) ? 1 : 0;
    71e9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    71ec:	89 d0                	mov    %edx,%eax
    71ee:	c1 e0 03             	shl    $0x3,%eax
    71f1:	01 d0                	add    %edx,%eax
    71f3:	c1 e0 03             	shl    $0x3,%eax
    71f6:	89 c2                	mov    %eax,%edx
    71f8:	8b 45 08             	mov    0x8(%ebp),%eax
    71fb:	01 c2                	add    %eax,%edx
    71fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7200:	8b 04 82             	mov    (%edx,%eax,4),%eax
    7203:	c1 e8 1f             	shr    $0x1f,%eax
    7206:	0f b6 c0             	movzbl %al,%eax
    7209:	89 45 d8             	mov    %eax,-0x28(%ebp)
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
    720c:	8b 55 f0             	mov    -0x10(%ebp),%edx
    720f:	89 d0                	mov    %edx,%eax
    7211:	c1 e0 03             	shl    $0x3,%eax
    7214:	01 d0                	add    %edx,%eax
    7216:	c1 e0 04             	shl    $0x4,%eax
    7219:	89 c2                	mov    %eax,%edx
    721b:	8b 45 0c             	mov    0xc(%ebp),%eax
    721e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    7221:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7224:	89 d0                	mov    %edx,%eax
    7226:	c1 e0 03             	shl    $0x3,%eax
    7229:	01 d0                	add    %edx,%eax
    722b:	c1 e0 04             	shl    $0x4,%eax
    722e:	89 c2                	mov    %eax,%edx
    7230:	8b 45 0c             	mov    0xc(%ebp),%eax
    7233:	01 c2                	add    %eax,%edx
    7235:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7238:	dd 04 c2             	fldl   (%edx,%eax,8)
    723b:	dd 5d c0             	fstpl  -0x40(%ebp)
    723e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7241:	89 d0                	mov    %edx,%eax
    7243:	c1 e0 03             	shl    $0x3,%eax
    7246:	01 d0                	add    %edx,%eax
    7248:	c1 e0 03             	shl    $0x3,%eax
    724b:	89 c2                	mov    %eax,%edx
    724d:	8b 45 08             	mov    0x8(%ebp),%eax
    7250:	01 c2                	add    %eax,%edx
    7252:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7255:	8b 04 82             	mov    (%edx,%eax,4),%eax
    7258:	89 04 24             	mov    %eax,(%esp)
    725b:	e8 47 bd ff ff       	call   2fa7 <abs>
    7260:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    7263:	db 45 d4             	fildl  -0x2c(%ebp)
    7266:	dd 05 58 bd 00 00    	fldl   0xbd58
    726c:	dd 5c 24 08          	fstpl  0x8(%esp)
    7270:	dd 1c 24             	fstpl  (%esp)
    7273:	e8 38 be ff ff       	call   30b0 <pow>
    7278:	dc 4d c0             	fmull  -0x40(%ebp)
    727b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    727e:	dd 1c c3             	fstpl  (%ebx,%eax,8)
			if (sign) xr[sb][ss] = -xr[sb][ss];
    7281:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    7285:	74 37                	je     72be <III_dequantize_sample+0x6d6>
    7287:	8b 55 f0             	mov    -0x10(%ebp),%edx
    728a:	89 d0                	mov    %edx,%eax
    728c:	c1 e0 03             	shl    $0x3,%eax
    728f:	01 d0                	add    %edx,%eax
    7291:	c1 e0 04             	shl    $0x4,%eax
    7294:	89 c2                	mov    %eax,%edx
    7296:	8b 45 0c             	mov    0xc(%ebp),%eax
    7299:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    729c:	8b 55 f0             	mov    -0x10(%ebp),%edx
    729f:	89 d0                	mov    %edx,%eax
    72a1:	c1 e0 03             	shl    $0x3,%eax
    72a4:	01 d0                	add    %edx,%eax
    72a6:	c1 e0 04             	shl    $0x4,%eax
    72a9:	89 c2                	mov    %eax,%edx
    72ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    72ae:	01 c2                	add    %eax,%edx
    72b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    72b3:	dd 04 c2             	fldl   (%edx,%eax,8)
    72b6:	d9 e0                	fchs   
    72b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    72bb:	dd 1c c1             	fstpl  (%ecx,%eax,8)
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    72be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    72c2:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    72c6:	0f 8e d3 f9 ff ff    	jle    6c9f <III_dequantize_sample+0xb7>
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    72cc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    72d0:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    72d4:	0f 8e b9 f9 ff ff    	jle    6c93 <III_dequantize_sample+0xab>
			sign = (is[sb][ss]<0) ? 1 : 0;
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
			if (sign) xr[sb][ss] = -xr[sb][ss];
		}
	}
}
    72da:	83 c4 50             	add    $0x50,%esp
    72dd:	5b                   	pop    %ebx
    72de:	5e                   	pop    %esi
    72df:	5d                   	pop    %ebp
    72e0:	c3                   	ret    

000072e1 <III_reorder>:


void III_reorder(double xr[SBLIMIT][SSLIMIT], double ro[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    72e1:	55                   	push   %ebp
    72e2:	89 e5                	mov    %esp,%ebp
    72e4:	57                   	push   %edi
    72e5:	56                   	push   %esi
    72e6:	53                   	push   %ebx
    72e7:	83 ec 34             	sub    $0x34,%esp
   int sfreq=fr_ps->header->sampling_frequency;
    72ea:	8b 45 14             	mov    0x14(%ebp),%eax
    72ed:	8b 00                	mov    (%eax),%eax
    72ef:	8b 40 10             	mov    0x10(%eax),%eax
    72f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    72f5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    72fc:	eb 33                	jmp    7331 <III_reorder+0x50>
      for(ss=0;ss<SSLIMIT;ss++)
    72fe:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    7305:	eb 20                	jmp    7327 <III_reorder+0x46>
         ro[sb][ss] = 0;
    7307:	8b 55 e0             	mov    -0x20(%ebp),%edx
    730a:	89 d0                	mov    %edx,%eax
    730c:	c1 e0 03             	shl    $0x3,%eax
    730f:	01 d0                	add    %edx,%eax
    7311:	c1 e0 04             	shl    $0x4,%eax
    7314:	89 c2                	mov    %eax,%edx
    7316:	8b 45 0c             	mov    0xc(%ebp),%eax
    7319:	01 c2                	add    %eax,%edx
    731b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    731e:	d9 ee                	fldz   
    7320:	dd 1c c2             	fstpl  (%edx,%eax,8)
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
    7323:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    7327:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    732b:	7e da                	jle    7307 <III_reorder+0x26>
{
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    732d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    7331:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    7335:	7e c7                	jle    72fe <III_reorder+0x1d>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    7337:	8b 45 10             	mov    0x10(%ebp),%eax
    733a:	8b 40 10             	mov    0x10(%eax),%eax
    733d:	85 c0                	test   %eax,%eax
    733f:	0f 84 af 03 00 00    	je     76f4 <III_reorder+0x413>
    7345:	8b 45 10             	mov    0x10(%ebp),%eax
    7348:	8b 40 14             	mov    0x14(%eax),%eax
    734b:	83 f8 02             	cmp    $0x2,%eax
    734e:	0f 85 a0 03 00 00    	jne    76f4 <III_reorder+0x413>
      if (gr_info->mixed_block_flag) {
    7354:	8b 45 10             	mov    0x10(%ebp),%eax
    7357:	8b 40 18             	mov    0x18(%eax),%eax
    735a:	85 c0                	test   %eax,%eax
    735c:	0f 84 00 02 00 00    	je     7562 <III_reorder+0x281>
         for (sb=0 ; sb < 2 ; sb++)
    7362:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    7369:	eb 4c                	jmp    73b7 <III_reorder+0xd6>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    736b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    7372:	eb 39                	jmp    73ad <III_reorder+0xcc>
               ro[sb][ss] = xr[sb][ss];
    7374:	8b 55 e0             	mov    -0x20(%ebp),%edx
    7377:	89 d0                	mov    %edx,%eax
    7379:	c1 e0 03             	shl    $0x3,%eax
    737c:	01 d0                	add    %edx,%eax
    737e:	c1 e0 04             	shl    $0x4,%eax
    7381:	89 c2                	mov    %eax,%edx
    7383:	8b 45 0c             	mov    0xc(%ebp),%eax
    7386:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    7389:	8b 55 e0             	mov    -0x20(%ebp),%edx
    738c:	89 d0                	mov    %edx,%eax
    738e:	c1 e0 03             	shl    $0x3,%eax
    7391:	01 d0                	add    %edx,%eax
    7393:	c1 e0 04             	shl    $0x4,%eax
    7396:	89 c2                	mov    %eax,%edx
    7398:	8b 45 08             	mov    0x8(%ebp),%eax
    739b:	01 c2                	add    %eax,%edx
    739d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    73a0:	dd 04 c2             	fldl   (%edx,%eax,8)
    73a3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    73a6:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    73a9:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    73ad:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    73b1:	7e c1                	jle    7374 <III_reorder+0x93>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
    73b3:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    73b7:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    73bb:	7e ae                	jle    736b <III_reorder+0x8a>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    73bd:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    73c4:	8b 45 d0             	mov    -0x30(%ebp),%eax
    73c7:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    73cd:	05 7c cf 00 00       	add    $0xcf7c,%eax
    73d2:	8b 40 0c             	mov    0xc(%eax),%eax
    73d5:	89 45 e8             	mov    %eax,-0x18(%ebp)
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
    73d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    73db:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    73e1:	05 80 cf 00 00       	add    $0xcf80,%eax
    73e6:	8b 40 0c             	mov    0xc(%eax),%eax
    73e9:	2b 45 e8             	sub    -0x18(%ebp),%eax
    73ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    73ef:	e9 5f 01 00 00       	jmp    7553 <III_reorder+0x272>
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    73f4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    73fb:	e9 fd 00 00 00       	jmp    74fd <III_reorder+0x21c>
                  for(freq=0;freq<sfb_lines;freq++) {
    7400:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    7407:	e9 e1 00 00 00       	jmp    74ed <III_reorder+0x20c>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    740c:	8b 55 e8             	mov    -0x18(%ebp),%edx
    740f:	89 d0                	mov    %edx,%eax
    7411:	01 c0                	add    %eax,%eax
    7413:	01 c2                	add    %eax,%edx
    7415:	8b 45 d8             	mov    -0x28(%ebp),%eax
    7418:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    741c:	01 c2                	add    %eax,%edx
    741e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    7421:	01 d0                	add    %edx,%eax
    7423:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    7426:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7429:	89 d0                	mov    %edx,%eax
    742b:	01 c0                	add    %eax,%eax
    742d:	01 c2                	add    %eax,%edx
    742f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    7432:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    7435:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    7438:	89 d0                	mov    %edx,%eax
    743a:	01 c0                	add    %eax,%eax
    743c:	01 d0                	add    %edx,%eax
    743e:	01 c8                	add    %ecx,%eax
    7440:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    7443:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    7446:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    744b:	89 c8                	mov    %ecx,%eax
    744d:	f7 ea                	imul   %edx
    744f:	c1 fa 02             	sar    $0x2,%edx
    7452:	89 c8                	mov    %ecx,%eax
    7454:	c1 f8 1f             	sar    $0x1f,%eax
    7457:	29 c2                	sub    %eax,%edx
    7459:	89 d0                	mov    %edx,%eax
    745b:	89 c2                	mov    %eax,%edx
    745d:	89 d0                	mov    %edx,%eax
    745f:	c1 e0 03             	shl    $0x3,%eax
    7462:	01 d0                	add    %edx,%eax
    7464:	c1 e0 04             	shl    $0x4,%eax
    7467:	89 c2                	mov    %eax,%edx
    7469:	8b 45 0c             	mov    0xc(%ebp),%eax
    746c:	8d 34 02             	lea    (%edx,%eax,1),%esi
    746f:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    7472:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7477:	89 d8                	mov    %ebx,%eax
    7479:	f7 ea                	imul   %edx
    747b:	c1 fa 02             	sar    $0x2,%edx
    747e:	89 d8                	mov    %ebx,%eax
    7480:	c1 f8 1f             	sar    $0x1f,%eax
    7483:	89 d1                	mov    %edx,%ecx
    7485:	29 c1                	sub    %eax,%ecx
    7487:	89 c8                	mov    %ecx,%eax
    7489:	c1 e0 03             	shl    $0x3,%eax
    748c:	01 c8                	add    %ecx,%eax
    748e:	01 c0                	add    %eax,%eax
    7490:	29 c3                	sub    %eax,%ebx
    7492:	89 d9                	mov    %ebx,%ecx
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
    7494:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    7497:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    749c:	89 d8                	mov    %ebx,%eax
    749e:	f7 ea                	imul   %edx
    74a0:	c1 fa 02             	sar    $0x2,%edx
    74a3:	89 d8                	mov    %ebx,%eax
    74a5:	c1 f8 1f             	sar    $0x1f,%eax
    74a8:	29 c2                	sub    %eax,%edx
    74aa:	89 d0                	mov    %edx,%eax
    74ac:	89 c2                	mov    %eax,%edx
    74ae:	89 d0                	mov    %edx,%eax
    74b0:	c1 e0 03             	shl    $0x3,%eax
    74b3:	01 d0                	add    %edx,%eax
    74b5:	c1 e0 04             	shl    $0x4,%eax
    74b8:	89 c2                	mov    %eax,%edx
    74ba:	8b 45 08             	mov    0x8(%ebp),%eax
    74bd:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    74c0:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    74c3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    74c8:	89 d8                	mov    %ebx,%eax
    74ca:	f7 ea                	imul   %edx
    74cc:	c1 fa 02             	sar    $0x2,%edx
    74cf:	89 d8                	mov    %ebx,%eax
    74d1:	c1 f8 1f             	sar    $0x1f,%eax
    74d4:	29 c2                	sub    %eax,%edx
    74d6:	89 d0                	mov    %edx,%eax
    74d8:	c1 e0 03             	shl    $0x3,%eax
    74db:	01 d0                	add    %edx,%eax
    74dd:	01 c0                	add    %eax,%eax
    74df:	29 c3                	sub    %eax,%ebx
    74e1:	89 da                	mov    %ebx,%edx
    74e3:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    74e6:	dd 1c ce             	fstpl  (%esi,%ecx,8)
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    74e9:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    74ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    74f0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    74f3:	0f 8c 13 ff ff ff    	jl     740c <III_reorder+0x12b>
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    74f9:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    74fd:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    7501:	0f 8e f9 fe ff ff    	jle    7400 <III_reorder+0x11f>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    7507:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    750b:	8b 55 d0             	mov    -0x30(%ebp),%edx
    750e:	89 d0                	mov    %edx,%eax
    7510:	c1 e0 03             	shl    $0x3,%eax
    7513:	01 d0                	add    %edx,%eax
    7515:	c1 e0 02             	shl    $0x2,%eax
    7518:	01 d0                	add    %edx,%eax
    751a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    751d:	01 d0                	add    %edx,%eax
    751f:	83 c0 14             	add    $0x14,%eax
    7522:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    7529:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    752c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    752f:	8d 48 01             	lea    0x1(%eax),%ecx
    7532:	8b 55 d0             	mov    -0x30(%ebp),%edx
    7535:	89 d0                	mov    %edx,%eax
    7537:	c1 e0 03             	shl    $0x3,%eax
    753a:	01 d0                	add    %edx,%eax
    753c:	c1 e0 02             	shl    $0x2,%eax
    753f:	01 d0                	add    %edx,%eax
    7541:	01 c8                	add    %ecx,%eax
    7543:	83 c0 14             	add    $0x14,%eax
    7546:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    754d:	2b 45 e8             	sub    -0x18(%ebp),%eax
    7550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    7553:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    7557:	0f 8e 97 fe ff ff    	jle    73f4 <III_reorder+0x113>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    755d:	e9 ed 01 00 00       	jmp    774f <III_reorder+0x46e>
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    7562:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7569:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    7570:	8b 45 d0             	mov    -0x30(%ebp),%eax
    7573:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7579:	05 74 cf 00 00       	add    $0xcf74,%eax
    757e:	8b 40 0c             	mov    0xc(%eax),%eax
    7581:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    7584:	e9 5f 01 00 00       	jmp    76e8 <III_reorder+0x407>
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    7589:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    7590:	e9 fd 00 00 00       	jmp    7692 <III_reorder+0x3b1>
                  for(freq=0;freq<sfb_lines;freq++) {
    7595:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    759c:	e9 e1 00 00 00       	jmp    7682 <III_reorder+0x3a1>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    75a1:	8b 55 e8             	mov    -0x18(%ebp),%edx
    75a4:	89 d0                	mov    %edx,%eax
    75a6:	01 c0                	add    %eax,%eax
    75a8:	01 c2                	add    %eax,%edx
    75aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
    75ad:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    75b1:	01 c2                	add    %eax,%edx
    75b3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    75b6:	01 d0                	add    %edx,%eax
    75b8:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    75bb:	8b 55 e8             	mov    -0x18(%ebp),%edx
    75be:	89 d0                	mov    %edx,%eax
    75c0:	01 c0                	add    %eax,%eax
    75c2:	01 c2                	add    %eax,%edx
    75c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    75c7:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    75ca:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    75cd:	89 d0                	mov    %edx,%eax
    75cf:	01 c0                	add    %eax,%eax
    75d1:	01 d0                	add    %edx,%eax
    75d3:	01 c8                	add    %ecx,%eax
    75d5:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    75d8:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    75db:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    75e0:	89 c8                	mov    %ecx,%eax
    75e2:	f7 ea                	imul   %edx
    75e4:	c1 fa 02             	sar    $0x2,%edx
    75e7:	89 c8                	mov    %ecx,%eax
    75e9:	c1 f8 1f             	sar    $0x1f,%eax
    75ec:	29 c2                	sub    %eax,%edx
    75ee:	89 d0                	mov    %edx,%eax
    75f0:	89 c2                	mov    %eax,%edx
    75f2:	89 d0                	mov    %edx,%eax
    75f4:	c1 e0 03             	shl    $0x3,%eax
    75f7:	01 d0                	add    %edx,%eax
    75f9:	c1 e0 04             	shl    $0x4,%eax
    75fc:	89 c2                	mov    %eax,%edx
    75fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    7601:	8d 34 02             	lea    (%edx,%eax,1),%esi
    7604:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    7607:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    760c:	89 d8                	mov    %ebx,%eax
    760e:	f7 ea                	imul   %edx
    7610:	c1 fa 02             	sar    $0x2,%edx
    7613:	89 d8                	mov    %ebx,%eax
    7615:	c1 f8 1f             	sar    $0x1f,%eax
    7618:	89 d1                	mov    %edx,%ecx
    761a:	29 c1                	sub    %eax,%ecx
    761c:	89 c8                	mov    %ecx,%eax
    761e:	c1 e0 03             	shl    $0x3,%eax
    7621:	01 c8                	add    %ecx,%eax
    7623:	01 c0                	add    %eax,%eax
    7625:	29 c3                	sub    %eax,%ebx
    7627:	89 d9                	mov    %ebx,%ecx
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
    7629:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    762c:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7631:	89 d8                	mov    %ebx,%eax
    7633:	f7 ea                	imul   %edx
    7635:	c1 fa 02             	sar    $0x2,%edx
    7638:	89 d8                	mov    %ebx,%eax
    763a:	c1 f8 1f             	sar    $0x1f,%eax
    763d:	29 c2                	sub    %eax,%edx
    763f:	89 d0                	mov    %edx,%eax
    7641:	89 c2                	mov    %eax,%edx
    7643:	89 d0                	mov    %edx,%eax
    7645:	c1 e0 03             	shl    $0x3,%eax
    7648:	01 d0                	add    %edx,%eax
    764a:	c1 e0 04             	shl    $0x4,%eax
    764d:	89 c2                	mov    %eax,%edx
    764f:	8b 45 08             	mov    0x8(%ebp),%eax
    7652:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    7655:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    7658:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    765d:	89 d8                	mov    %ebx,%eax
    765f:	f7 ea                	imul   %edx
    7661:	c1 fa 02             	sar    $0x2,%edx
    7664:	89 d8                	mov    %ebx,%eax
    7666:	c1 f8 1f             	sar    $0x1f,%eax
    7669:	29 c2                	sub    %eax,%edx
    766b:	89 d0                	mov    %edx,%eax
    766d:	c1 e0 03             	shl    $0x3,%eax
    7670:	01 d0                	add    %edx,%eax
    7672:	01 c0                	add    %eax,%eax
    7674:	29 c3                	sub    %eax,%ebx
    7676:	89 da                	mov    %ebx,%edx
    7678:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    767b:	dd 1c ce             	fstpl  (%esi,%ecx,8)
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    767e:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    7682:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    7685:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    7688:	0f 8c 13 ff ff ff    	jl     75a1 <III_reorder+0x2c0>
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    768e:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    7692:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    7696:	0f 8e f9 fe ff ff    	jle    7595 <III_reorder+0x2b4>
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    769c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    76a0:	8b 55 d0             	mov    -0x30(%ebp),%edx
    76a3:	89 d0                	mov    %edx,%eax
    76a5:	c1 e0 03             	shl    $0x3,%eax
    76a8:	01 d0                	add    %edx,%eax
    76aa:	c1 e0 02             	shl    $0x2,%eax
    76ad:	01 d0                	add    %edx,%eax
    76af:	8b 55 ec             	mov    -0x14(%ebp),%edx
    76b2:	01 d0                	add    %edx,%eax
    76b4:	83 c0 14             	add    $0x14,%eax
    76b7:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    76be:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    76c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    76c4:	8d 48 01             	lea    0x1(%eax),%ecx
    76c7:	8b 55 d0             	mov    -0x30(%ebp),%edx
    76ca:	89 d0                	mov    %edx,%eax
    76cc:	c1 e0 03             	shl    $0x3,%eax
    76cf:	01 d0                	add    %edx,%eax
    76d1:	c1 e0 02             	shl    $0x2,%eax
    76d4:	01 d0                	add    %edx,%eax
    76d6:	01 c8                	add    %ecx,%eax
    76d8:	83 c0 14             	add    $0x14,%eax
    76db:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    76e2:	2b 45 e8             	sub    -0x18(%ebp),%eax
    76e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    76e8:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    76ec:	0f 8e 97 fe ff ff    	jle    7589 <III_reorder+0x2a8>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    76f2:	eb 5b                	jmp    774f <III_reorder+0x46e>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    76f4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    76fb:	eb 4c                	jmp    7749 <III_reorder+0x468>
         for (ss=0 ; ss < SSLIMIT ; ss++)
    76fd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    7704:	eb 39                	jmp    773f <III_reorder+0x45e>
            ro[sb][ss] = xr[sb][ss];
    7706:	8b 55 e0             	mov    -0x20(%ebp),%edx
    7709:	89 d0                	mov    %edx,%eax
    770b:	c1 e0 03             	shl    $0x3,%eax
    770e:	01 d0                	add    %edx,%eax
    7710:	c1 e0 04             	shl    $0x4,%eax
    7713:	89 c2                	mov    %eax,%edx
    7715:	8b 45 0c             	mov    0xc(%ebp),%eax
    7718:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    771b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    771e:	89 d0                	mov    %edx,%eax
    7720:	c1 e0 03             	shl    $0x3,%eax
    7723:	01 d0                	add    %edx,%eax
    7725:	c1 e0 04             	shl    $0x4,%eax
    7728:	89 c2                	mov    %eax,%edx
    772a:	8b 45 08             	mov    0x8(%ebp),%eax
    772d:	01 c2                	add    %eax,%edx
    772f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    7732:	dd 04 c2             	fldl   (%edx,%eax,8)
    7735:	8b 45 dc             	mov    -0x24(%ebp),%eax
    7738:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
         for (ss=0 ; ss < SSLIMIT ; ss++)
    773b:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    773f:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    7743:	7e c1                	jle    7706 <III_reorder+0x425>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    7745:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    7749:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    774d:	7e ae                	jle    76fd <III_reorder+0x41c>
         for (ss=0 ; ss < SSLIMIT ; ss++)
            ro[sb][ss] = xr[sb][ss];
   }
}
    774f:	83 c4 34             	add    $0x34,%esp
    7752:	5b                   	pop    %ebx
    7753:	5e                   	pop    %esi
    7754:	5f                   	pop    %edi
    7755:	5d                   	pop    %ebp
    7756:	c3                   	ret    

00007757 <III_stereo>:


void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    7757:	55                   	push   %ebp
    7758:	89 e5                	mov    %esp,%ebp
    775a:	56                   	push   %esi
    775b:	53                   	push   %ebx
    775c:	81 ec 50 1b 00 00    	sub    $0x1b50,%esp
   int sfreq = fr_ps->header->sampling_frequency;
    7762:	8b 45 18             	mov    0x18(%ebp),%eax
    7765:	8b 00                	mov    (%eax),%eax
    7767:	8b 40 10             	mov    0x10(%eax),%eax
    776a:	89 45 c8             	mov    %eax,-0x38(%ebp)
   int stereo = fr_ps->stereo;
    776d:	8b 45 18             	mov    0x18(%ebp),%eax
    7770:	8b 40 08             	mov    0x8(%eax),%eax
    7773:	89 45 c4             	mov    %eax,-0x3c(%ebp)
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    7776:	8b 45 18             	mov    0x18(%ebp),%eax
    7779:	8b 00                	mov    (%eax),%eax
    777b:	8b 40 1c             	mov    0x1c(%eax),%eax
    777e:	83 f8 01             	cmp    $0x1,%eax
    7781:	75 16                	jne    7799 <III_stereo+0x42>
                   (fr_ps->header->mode_ext & 0x2);
    7783:	8b 45 18             	mov    0x18(%ebp),%eax
    7786:	8b 00                	mov    (%eax),%eax
    7788:	8b 40 20             	mov    0x20(%eax),%eax
    778b:	83 e0 02             	and    $0x2,%eax

void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    778e:	85 c0                	test   %eax,%eax
    7790:	74 07                	je     7799 <III_stereo+0x42>
    7792:	b8 01 00 00 00       	mov    $0x1,%eax
    7797:	eb 05                	jmp    779e <III_stereo+0x47>
    7799:	b8 00 00 00 00       	mov    $0x0,%eax
    779e:	89 45 c0             	mov    %eax,-0x40(%ebp)
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    77a1:	8b 45 18             	mov    0x18(%ebp),%eax
    77a4:	8b 00                	mov    (%eax),%eax
    77a6:	8b 40 1c             	mov    0x1c(%eax),%eax
    77a9:	83 f8 01             	cmp    $0x1,%eax
    77ac:	75 16                	jne    77c4 <III_stereo+0x6d>
                  (fr_ps->header->mode_ext & 0x1);
    77ae:	8b 45 18             	mov    0x18(%ebp),%eax
    77b1:	8b 00                	mov    (%eax),%eax
    77b3:	8b 40 20             	mov    0x20(%eax),%eax
    77b6:	83 e0 01             	and    $0x1,%eax
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    77b9:	85 c0                	test   %eax,%eax
    77bb:	74 07                	je     77c4 <III_stereo+0x6d>
    77bd:	b8 01 00 00 00       	mov    $0x1,%eax
    77c2:	eb 05                	jmp    77c9 <III_stereo+0x72>
    77c4:	b8 00 00 00 00       	mov    $0x0,%eax
    77c9:	89 45 bc             	mov    %eax,-0x44(%ebp)
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    77cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    77d3:	eb 12                	jmp    77e7 <III_stereo+0x90>
      is_pos[i] = 7;
    77d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    77d8:	c7 84 85 bc f6 ff ff 	movl   $0x7,-0x944(%ebp,%eax,4)
    77df:	07 00 00 00 
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    77e3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    77e7:	81 7d f0 3f 02 00 00 	cmpl   $0x23f,-0x10(%ebp)
    77ee:	7e e5                	jle    77d5 <III_stereo+0x7e>
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
    77f0:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    77f4:	0f 85 18 0a 00 00    	jne    8212 <III_stereo+0xabb>
    77fa:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    77fe:	0f 84 0e 0a 00 00    	je     8212 <III_stereo+0xabb>
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
    7804:	8b 45 14             	mov    0x14(%ebp),%eax
    7807:	8b 40 10             	mov    0x10(%eax),%eax
    780a:	85 c0                	test   %eax,%eax
    780c:	0f 84 10 08 00 00    	je     8022 <III_stereo+0x8cb>
    7812:	8b 45 14             	mov    0x14(%ebp),%eax
    7815:	8b 40 14             	mov    0x14(%eax),%eax
    7818:	83 f8 02             	cmp    $0x2,%eax
    781b:	0f 85 01 08 00 00    	jne    8022 <III_stereo+0x8cb>
      {  if( gr_info->mixed_block_flag )
    7821:	8b 45 14             	mov    0x14(%ebp),%eax
    7824:	8b 40 18             	mov    0x18(%eax),%eax
    7827:	85 c0                	test   %eax,%eax
    7829:	0f 84 d0 04 00 00    	je     7cff <III_stereo+0x5a8>
         {  int max_sfb = 0;
    782f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)

            for ( j=0; j<3; j++ )
    7836:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    783d:	e9 1b 03 00 00       	jmp    7b5d <III_stereo+0x406>
            {  int sfbcnt;
               sfbcnt = 2;
    7842:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
               for( sfb=12; sfb >=3; sfb-- )
    7849:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    7850:	e9 0f 01 00 00       	jmp    7964 <III_stereo+0x20d>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    7855:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7858:	8d 48 01             	lea    0x1(%eax),%ecx
    785b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    785e:	89 d0                	mov    %edx,%eax
    7860:	c1 e0 03             	shl    $0x3,%eax
    7863:	01 d0                	add    %edx,%eax
    7865:	c1 e0 02             	shl    $0x2,%eax
    7868:	01 d0                	add    %edx,%eax
    786a:	01 c8                	add    %ecx,%eax
    786c:	83 c0 14             	add    $0x14,%eax
    786f:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
    7876:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7879:	89 d0                	mov    %edx,%eax
    787b:	c1 e0 03             	shl    $0x3,%eax
    787e:	01 d0                	add    %edx,%eax
    7880:	c1 e0 02             	shl    $0x2,%eax
    7883:	01 d0                	add    %edx,%eax
    7885:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7888:	01 d0                	add    %edx,%eax
    788a:	83 c0 14             	add    $0x14,%eax
    788d:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    7894:	29 c1                	sub    %eax,%ecx
    7896:	89 c8                	mov    %ecx,%eax
    7898:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    789b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    789e:	89 d0                	mov    %edx,%eax
    78a0:	c1 e0 03             	shl    $0x3,%eax
    78a3:	01 d0                	add    %edx,%eax
    78a5:	c1 e0 02             	shl    $0x2,%eax
    78a8:	01 d0                	add    %edx,%eax
    78aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
    78ad:	01 d0                	add    %edx,%eax
    78af:	83 c0 14             	add    $0x14,%eax
    78b2:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    78b9:	89 d0                	mov    %edx,%eax
    78bb:	01 c0                	add    %eax,%eax
    78bd:	01 c2                	add    %eax,%edx
    78bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    78c2:	83 c0 01             	add    $0x1,%eax
    78c5:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    78c9:	01 d0                	add    %edx,%eax
    78cb:	83 e8 01             	sub    $0x1,%eax
    78ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    78d1:	e9 80 00 00 00       	jmp    7956 <III_stereo+0x1ff>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    78d6:	8b 45 08             	mov    0x8(%ebp),%eax
    78d9:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    78df:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    78e2:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    78e7:	89 c8                	mov    %ecx,%eax
    78e9:	f7 ea                	imul   %edx
    78eb:	c1 fa 02             	sar    $0x2,%edx
    78ee:	89 c8                	mov    %ecx,%eax
    78f0:	c1 f8 1f             	sar    $0x1f,%eax
    78f3:	89 d3                	mov    %edx,%ebx
    78f5:	29 c3                	sub    %eax,%ebx
    78f7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    78fa:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    78ff:	89 c8                	mov    %ecx,%eax
    7901:	f7 ea                	imul   %edx
    7903:	c1 fa 02             	sar    $0x2,%edx
    7906:	89 c8                	mov    %ecx,%eax
    7908:	c1 f8 1f             	sar    $0x1f,%eax
    790b:	29 c2                	sub    %eax,%edx
    790d:	89 d0                	mov    %edx,%eax
    790f:	c1 e0 03             	shl    $0x3,%eax
    7912:	01 d0                	add    %edx,%eax
    7914:	01 c0                	add    %eax,%eax
    7916:	29 c1                	sub    %eax,%ecx
    7918:	89 ca                	mov    %ecx,%edx
    791a:	89 d8                	mov    %ebx,%eax
    791c:	c1 e0 03             	shl    $0x3,%eax
    791f:	01 d8                	add    %ebx,%eax
    7921:	01 c0                	add    %eax,%eax
    7923:	01 d0                	add    %edx,%eax
    7925:	dd 04 c6             	fldl   (%esi,%eax,8)
    7928:	d9 ee                	fldz   
    792a:	df e9                	fucomip %st(1),%st
    792c:	7a 0a                	jp     7938 <III_stereo+0x1e1>
    792e:	d9 ee                	fldz   
    7930:	df e9                	fucomip %st(1),%st
    7932:	dd d8                	fstp   %st(0)
    7934:	74 18                	je     794e <III_stereo+0x1f7>
    7936:	eb 02                	jmp    793a <III_stereo+0x1e3>
    7938:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    793a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    793d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                        sfb = -10;
    7940:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    7947:	c7 45 d4 f6 ff ff ff 	movl   $0xfffffff6,-0x2c(%ebp)
                     }
                     lines--;
    794e:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
                     i--;
    7952:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    7956:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    795a:	0f 8f 76 ff ff ff    	jg     78d6 <III_stereo+0x17f>
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
    7960:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    7964:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    7968:	0f 8f e7 fe ff ff    	jg     7855 <III_stereo+0xfe>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    796e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    7971:	83 c0 01             	add    $0x1,%eax
    7974:	89 45 f4             	mov    %eax,-0xc(%ebp)

               if ( sfb > max_sfb )
    7977:	8b 45 f4             	mov    -0xc(%ebp),%eax
    797a:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    797d:	7e 0b                	jle    798a <III_stereo+0x233>
                  max_sfb = sfb;
    797f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7982:	89 45 dc             	mov    %eax,-0x24(%ebp)

               while( sfb<12 )
    7985:	e9 f5 00 00 00       	jmp    7a7f <III_stereo+0x328>
    798a:	e9 f0 00 00 00       	jmp    7a7f <III_stereo+0x328>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    798f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7992:	8d 48 01             	lea    0x1(%eax),%ecx
    7995:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7998:	89 d0                	mov    %edx,%eax
    799a:	c1 e0 03             	shl    $0x3,%eax
    799d:	01 d0                	add    %edx,%eax
    799f:	c1 e0 02             	shl    $0x2,%eax
    79a2:	01 d0                	add    %edx,%eax
    79a4:	01 c8                	add    %ecx,%eax
    79a6:	83 c0 14             	add    $0x14,%eax
    79a9:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
    79b0:	8b 55 c8             	mov    -0x38(%ebp),%edx
    79b3:	89 d0                	mov    %edx,%eax
    79b5:	c1 e0 03             	shl    $0x3,%eax
    79b8:	01 d0                	add    %edx,%eax
    79ba:	c1 e0 02             	shl    $0x2,%eax
    79bd:	01 d0                	add    %edx,%eax
    79bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
    79c2:	01 d0                	add    %edx,%eax
    79c4:	83 c0 14             	add    $0x14,%eax
    79c7:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    79ce:	29 c1                	sub    %eax,%ecx
    79d0:	89 c8                	mov    %ecx,%eax
    79d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    79d5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    79d8:	89 d0                	mov    %edx,%eax
    79da:	c1 e0 03             	shl    $0x3,%eax
    79dd:	01 d0                	add    %edx,%eax
    79df:	c1 e0 02             	shl    $0x2,%eax
    79e2:	01 d0                	add    %edx,%eax
    79e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    79e7:	01 d0                	add    %edx,%eax
    79e9:	83 c0 14             	add    $0x14,%eax
    79ec:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    79f3:	89 d0                	mov    %edx,%eax
    79f5:	01 c0                	add    %eax,%eax
    79f7:	01 c2                	add    %eax,%edx
    79f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    79fc:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7a00:	01 d0                	add    %edx,%eax
    7a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    7a05:	eb 6e                	jmp    7a75 <III_stereo+0x31e>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    7a07:	8b 4d 10             	mov    0x10(%ebp),%ecx
    7a0a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7a0d:	89 d0                	mov    %edx,%eax
    7a0f:	01 c0                	add    %eax,%eax
    7a11:	01 d0                	add    %edx,%eax
    7a13:	c1 e0 02             	shl    $0x2,%eax
    7a16:	01 d0                	add    %edx,%eax
    7a18:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7a1b:	01 d0                	add    %edx,%eax
    7a1d:	83 c0 52             	add    $0x52,%eax
    7a20:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    7a24:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a27:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    7a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a31:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7a38:	83 f8 07             	cmp    $0x7,%eax
    7a3b:	74 30                	je     7a6d <III_stereo+0x316>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    7a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a40:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7a47:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    7a4d:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    7a53:	dd 05 60 bd 00 00    	fldl   0xbd60
    7a59:	de c9                	fmulp  %st,%st(1)
    7a5b:	dd 1c 24             	fstpl  (%esp)
    7a5e:	e8 1d b6 ff ff       	call   3080 <tan>
    7a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a66:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    7a6d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  max_sfb = sfb;

               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    7a71:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7a75:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7a79:	7f 8c                	jg     7a07 <III_stereo+0x2b0>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    7a7b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
               sfb = sfbcnt + 1;

               if ( sfb > max_sfb )
                  max_sfb = sfb;

               while( sfb<12 )
    7a7f:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    7a83:	0f 8e 06 ff ff ff    	jle    798f <III_stereo+0x238>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    7a89:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7a8c:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7a92:	05 9c cf 00 00       	add    $0xcf9c,%eax
    7a97:	8b 50 0c             	mov    0xc(%eax),%edx
    7a9a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7a9d:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7aa3:	05 98 cf 00 00       	add    $0xcf98,%eax
    7aa8:	8b 40 0c             	mov    0xc(%eax),%eax
    7aab:	29 c2                	sub    %eax,%edx
    7aad:	89 d0                	mov    %edx,%eax
    7aaf:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    7ab2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7ab5:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7abb:	05 98 cf 00 00       	add    $0xcf98,%eax
    7ac0:	8b 50 0c             	mov    0xc(%eax),%edx
    7ac3:	89 d0                	mov    %edx,%eax
    7ac5:	01 c0                	add    %eax,%eax
    7ac7:	01 c2                	add    %eax,%edx
    7ac9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7acc:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7ad0:	01 d0                	add    %edx,%eax
    7ad2:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    7ad5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7ad8:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7ade:	05 a0 cf 00 00       	add    $0xcfa0,%eax
    7ae3:	8b 50 0c             	mov    0xc(%eax),%edx
    7ae6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7ae9:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7aef:	05 9c cf 00 00       	add    $0xcf9c,%eax
    7af4:	8b 40 0c             	mov    0xc(%eax),%eax
    7af7:	29 c2                	sub    %eax,%edx
    7af9:	89 d0                	mov    %edx,%eax
    7afb:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    7afe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7b01:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7b07:	05 9c cf 00 00       	add    $0xcf9c,%eax
    7b0c:	8b 50 0c             	mov    0xc(%eax),%edx
    7b0f:	89 d0                	mov    %edx,%eax
    7b11:	01 c0                	add    %eax,%eax
    7b13:	01 c2                	add    %eax,%edx
    7b15:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7b18:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7b1c:	01 d0                	add    %edx,%eax
    7b1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    7b21:	eb 30                	jmp    7b53 <III_stereo+0x3fc>
               {  is_pos[i] = is_pos[sfb];
    7b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b26:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    7b2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b30:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    7b37:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b3a:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    7b41:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b44:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    7b4b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    7b4f:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7b53:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7b57:	7f ca                	jg     7b23 <III_stereo+0x3cc>
   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
    7b59:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7b5d:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7b61:	0f 8e db fc ff ff    	jle    7842 <III_stereo+0xeb>
               {  is_pos[i] = is_pos[sfb];
                  is_ratio[i] = is_ratio[sfb];
                  i++;
               }
             }
             if ( max_sfb <= 3 )
    7b67:	83 7d dc 03          	cmpl   $0x3,-0x24(%ebp)
    7b6b:	0f 8f 89 01 00 00    	jg     7cfa <III_stereo+0x5a3>
             {  i = 2;
    7b71:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
                ss = 17;
    7b78:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
                sb = -1;
    7b7f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
                while ( i >= 0 )
    7b86:	eb 63                	jmp    7beb <III_stereo+0x494>
                {  if ( xr[1][i][ss] != 0.0 )
    7b88:	8b 45 08             	mov    0x8(%ebp),%eax
    7b8b:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    7b91:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7b94:	89 d0                	mov    %edx,%eax
    7b96:	c1 e0 03             	shl    $0x3,%eax
    7b99:	01 d0                	add    %edx,%eax
    7b9b:	01 c0                	add    %eax,%eax
    7b9d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7ba0:	01 d0                	add    %edx,%eax
    7ba2:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7ba5:	d9 ee                	fldz   
    7ba7:	df e9                	fucomip %st(1),%st
    7ba9:	7a 0a                	jp     7bb5 <III_stereo+0x45e>
    7bab:	d9 ee                	fldz   
    7bad:	df e9                	fucomip %st(1),%st
    7baf:	dd d8                	fstp   %st(0)
    7bb1:	74 23                	je     7bd6 <III_stereo+0x47f>
    7bb3:	eb 02                	jmp    7bb7 <III_stereo+0x460>
    7bb5:	dd d8                	fstp   %st(0)
                   {  sb = i*18+ss;
    7bb7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7bba:	89 d0                	mov    %edx,%eax
    7bbc:	c1 e0 03             	shl    $0x3,%eax
    7bbf:	01 d0                	add    %edx,%eax
    7bc1:	01 c0                	add    %eax,%eax
    7bc3:	89 c2                	mov    %eax,%edx
    7bc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    7bc8:	01 d0                	add    %edx,%eax
    7bca:	89 45 e8             	mov    %eax,-0x18(%ebp)
                      i = -1;
    7bcd:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    7bd4:	eb 15                	jmp    7beb <III_stereo+0x494>
                   } else
                   {  ss--;
    7bd6:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
                      if ( ss < 0 )
    7bda:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    7bde:	79 0b                	jns    7beb <III_stereo+0x494>
                      {  i--;
    7be0:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                         ss = 17;
    7be4:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
             }
             if ( max_sfb <= 3 )
             {  i = 2;
                ss = 17;
                sb = -1;
                while ( i >= 0 )
    7beb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    7bef:	79 97                	jns    7b88 <III_stereo+0x431>
                      {  i--;
                         ss = 17;
                      }
                   }
                }
                i = 0;
    7bf1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                while ( sfBandIndex[sfreq].l[i] <= sb )
    7bf8:	eb 04                	jmp    7bfe <III_stereo+0x4a7>
                   i++;
    7bfa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                         ss = 17;
                      }
                   }
                }
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
    7bfe:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7c01:	89 d0                	mov    %edx,%eax
    7c03:	c1 e0 03             	shl    $0x3,%eax
    7c06:	01 d0                	add    %edx,%eax
    7c08:	c1 e0 02             	shl    $0x2,%eax
    7c0b:	01 d0                	add    %edx,%eax
    7c0d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7c10:	01 d0                	add    %edx,%eax
    7c12:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    7c19:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    7c1c:	7e dc                	jle    7bfa <III_stereo+0x4a3>
                   i++;
                sfb = i;
    7c1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c21:	89 45 f4             	mov    %eax,-0xc(%ebp)
                i = sfBandIndex[sfreq].l[i];
    7c24:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7c27:	89 d0                	mov    %edx,%eax
    7c29:	c1 e0 03             	shl    $0x3,%eax
    7c2c:	01 d0                	add    %edx,%eax
    7c2e:	c1 e0 02             	shl    $0x2,%eax
    7c31:	01 d0                	add    %edx,%eax
    7c33:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7c36:	01 d0                	add    %edx,%eax
    7c38:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    7c3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
                for ( ; sfb<8; sfb++ )
    7c42:	e9 a9 00 00 00       	jmp    7cf0 <III_stereo+0x599>
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
    7c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7c4a:	8d 48 01             	lea    0x1(%eax),%ecx
    7c4d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7c50:	89 d0                	mov    %edx,%eax
    7c52:	c1 e0 03             	shl    $0x3,%eax
    7c55:	01 d0                	add    %edx,%eax
    7c57:	c1 e0 02             	shl    $0x2,%eax
    7c5a:	01 d0                	add    %edx,%eax
    7c5c:	01 c8                	add    %ecx,%eax
    7c5e:	8b 0c 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%ecx
    7c65:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7c68:	89 d0                	mov    %edx,%eax
    7c6a:	c1 e0 03             	shl    $0x3,%eax
    7c6d:	01 d0                	add    %edx,%eax
    7c6f:	c1 e0 02             	shl    $0x2,%eax
    7c72:	01 d0                	add    %edx,%eax
    7c74:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7c77:	01 d0                	add    %edx,%eax
    7c79:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    7c80:	29 c1                	sub    %eax,%ecx
    7c82:	89 c8                	mov    %ecx,%eax
    7c84:	89 45 e8             	mov    %eax,-0x18(%ebp)
                   for ( ; sb > 0; sb--)
    7c87:	eb 5d                	jmp    7ce6 <III_stereo+0x58f>
                   {  is_pos[i] = (*scalefac)[1].l[sfb];
    7c89:	8b 45 10             	mov    0x10(%ebp),%eax
    7c8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7c8f:	83 c2 3e             	add    $0x3e,%edx
    7c92:	8b 14 90             	mov    (%eax,%edx,4),%edx
    7c95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c98:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                      if ( is_pos[i] != 7 )
    7c9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ca2:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7ca9:	83 f8 07             	cmp    $0x7,%eax
    7cac:	74 30                	je     7cde <III_stereo+0x587>
                         is_ratio[i] = tan( is_pos[i] * (PI / 12));
    7cae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7cb1:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7cb8:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    7cbe:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    7cc4:	dd 05 60 bd 00 00    	fldl   0xbd60
    7cca:	de c9                	fmulp  %st,%st(1)
    7ccc:	dd 1c 24             	fstpl  (%esp)
    7ccf:	e8 ac b3 ff ff       	call   3080 <tan>
    7cd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7cd7:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                      i++;
    7cde:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
                   for ( ; sb > 0; sb--)
    7ce2:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7ce6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7cea:	7f 9d                	jg     7c89 <III_stereo+0x532>
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
    7cec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7cf0:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    7cf4:	0f 8e 4d ff ff ff    	jle    7c47 <III_stereo+0x4f0>
    7cfa:	e9 1e 03 00 00       	jmp    801d <III_stereo+0x8c6>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    7cff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7d06:	e9 08 03 00 00       	jmp    8013 <III_stereo+0x8bc>
            {  int sfbcnt;
               sfbcnt = -1;
    7d0b:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
               for( sfb=12; sfb >=0; sfb-- )
    7d12:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    7d19:	e9 0f 01 00 00       	jmp    7e2d <III_stereo+0x6d6>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    7d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7d21:	8d 48 01             	lea    0x1(%eax),%ecx
    7d24:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7d27:	89 d0                	mov    %edx,%eax
    7d29:	c1 e0 03             	shl    $0x3,%eax
    7d2c:	01 d0                	add    %edx,%eax
    7d2e:	c1 e0 02             	shl    $0x2,%eax
    7d31:	01 d0                	add    %edx,%eax
    7d33:	01 c8                	add    %ecx,%eax
    7d35:	83 c0 14             	add    $0x14,%eax
    7d38:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
    7d3f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7d42:	89 d0                	mov    %edx,%eax
    7d44:	c1 e0 03             	shl    $0x3,%eax
    7d47:	01 d0                	add    %edx,%eax
    7d49:	c1 e0 02             	shl    $0x2,%eax
    7d4c:	01 d0                	add    %edx,%eax
    7d4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7d51:	01 d0                	add    %edx,%eax
    7d53:	83 c0 14             	add    $0x14,%eax
    7d56:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    7d5d:	29 c1                	sub    %eax,%ecx
    7d5f:	89 c8                	mov    %ecx,%eax
    7d61:	89 45 cc             	mov    %eax,-0x34(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    7d64:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7d67:	89 d0                	mov    %edx,%eax
    7d69:	c1 e0 03             	shl    $0x3,%eax
    7d6c:	01 d0                	add    %edx,%eax
    7d6e:	c1 e0 02             	shl    $0x2,%eax
    7d71:	01 d0                	add    %edx,%eax
    7d73:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7d76:	01 d0                	add    %edx,%eax
    7d78:	83 c0 14             	add    $0x14,%eax
    7d7b:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    7d82:	89 d0                	mov    %edx,%eax
    7d84:	01 c0                	add    %eax,%eax
    7d86:	01 c2                	add    %eax,%edx
    7d88:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7d8b:	83 c0 01             	add    $0x1,%eax
    7d8e:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    7d92:	01 d0                	add    %edx,%eax
    7d94:	83 e8 01             	sub    $0x1,%eax
    7d97:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    7d9a:	e9 80 00 00 00       	jmp    7e1f <III_stereo+0x6c8>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    7d9f:	8b 45 08             	mov    0x8(%ebp),%eax
    7da2:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    7da8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    7dab:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7db0:	89 c8                	mov    %ecx,%eax
    7db2:	f7 ea                	imul   %edx
    7db4:	c1 fa 02             	sar    $0x2,%edx
    7db7:	89 c8                	mov    %ecx,%eax
    7db9:	c1 f8 1f             	sar    $0x1f,%eax
    7dbc:	89 d3                	mov    %edx,%ebx
    7dbe:	29 c3                	sub    %eax,%ebx
    7dc0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    7dc3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7dc8:	89 c8                	mov    %ecx,%eax
    7dca:	f7 ea                	imul   %edx
    7dcc:	c1 fa 02             	sar    $0x2,%edx
    7dcf:	89 c8                	mov    %ecx,%eax
    7dd1:	c1 f8 1f             	sar    $0x1f,%eax
    7dd4:	29 c2                	sub    %eax,%edx
    7dd6:	89 d0                	mov    %edx,%eax
    7dd8:	c1 e0 03             	shl    $0x3,%eax
    7ddb:	01 d0                	add    %edx,%eax
    7ddd:	01 c0                	add    %eax,%eax
    7ddf:	29 c1                	sub    %eax,%ecx
    7de1:	89 ca                	mov    %ecx,%edx
    7de3:	89 d8                	mov    %ebx,%eax
    7de5:	c1 e0 03             	shl    $0x3,%eax
    7de8:	01 d8                	add    %ebx,%eax
    7dea:	01 c0                	add    %eax,%eax
    7dec:	01 d0                	add    %edx,%eax
    7dee:	dd 04 c6             	fldl   (%esi,%eax,8)
    7df1:	d9 ee                	fldz   
    7df3:	df e9                	fucomip %st(1),%st
    7df5:	7a 0a                	jp     7e01 <III_stereo+0x6aa>
    7df7:	d9 ee                	fldz   
    7df9:	df e9                	fucomip %st(1),%st
    7dfb:	dd d8                	fstp   %st(0)
    7dfd:	74 18                	je     7e17 <III_stereo+0x6c0>
    7dff:	eb 02                	jmp    7e03 <III_stereo+0x6ac>
    7e01:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    7e03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7e06:	89 45 d0             	mov    %eax,-0x30(%ebp)
                        sfb = -10;
    7e09:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    7e10:	c7 45 cc f6 ff ff ff 	movl   $0xfffffff6,-0x34(%ebp)
                     }
                     lines--;
    7e17:	83 6d cc 01          	subl   $0x1,-0x34(%ebp)
                     i--;
    7e1b:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    7e1f:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    7e23:	0f 8f 76 ff ff ff    	jg     7d9f <III_stereo+0x648>
            }
         } else
         {  for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
    7e29:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    7e2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    7e31:	0f 89 e7 fe ff ff    	jns    7d1e <III_stereo+0x5c7>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    7e37:	8b 45 d0             	mov    -0x30(%ebp),%eax
    7e3a:	83 c0 01             	add    $0x1,%eax
    7e3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
               while( sfb<12 )
    7e40:	e9 f0 00 00 00       	jmp    7f35 <III_stereo+0x7de>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    7e45:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7e48:	8d 48 01             	lea    0x1(%eax),%ecx
    7e4b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7e4e:	89 d0                	mov    %edx,%eax
    7e50:	c1 e0 03             	shl    $0x3,%eax
    7e53:	01 d0                	add    %edx,%eax
    7e55:	c1 e0 02             	shl    $0x2,%eax
    7e58:	01 d0                	add    %edx,%eax
    7e5a:	01 c8                	add    %ecx,%eax
    7e5c:	83 c0 14             	add    $0x14,%eax
    7e5f:	8b 0c 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%ecx
    7e66:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7e69:	89 d0                	mov    %edx,%eax
    7e6b:	c1 e0 03             	shl    $0x3,%eax
    7e6e:	01 d0                	add    %edx,%eax
    7e70:	c1 e0 02             	shl    $0x2,%eax
    7e73:	01 d0                	add    %edx,%eax
    7e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7e78:	01 d0                	add    %edx,%eax
    7e7a:	83 c0 14             	add    $0x14,%eax
    7e7d:	8b 04 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%eax
    7e84:	29 c1                	sub    %eax,%ecx
    7e86:	89 c8                	mov    %ecx,%eax
    7e88:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    7e8b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7e8e:	89 d0                	mov    %edx,%eax
    7e90:	c1 e0 03             	shl    $0x3,%eax
    7e93:	01 d0                	add    %edx,%eax
    7e95:	c1 e0 02             	shl    $0x2,%eax
    7e98:	01 d0                	add    %edx,%eax
    7e9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7e9d:	01 d0                	add    %edx,%eax
    7e9f:	83 c0 14             	add    $0x14,%eax
    7ea2:	8b 14 85 2c cf 00 00 	mov    0xcf2c(,%eax,4),%edx
    7ea9:	89 d0                	mov    %edx,%eax
    7eab:	01 c0                	add    %eax,%eax
    7ead:	01 c2                	add    %eax,%edx
    7eaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7eb2:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7eb6:	01 d0                	add    %edx,%eax
    7eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    7ebb:	eb 6e                	jmp    7f2b <III_stereo+0x7d4>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    7ebd:	8b 4d 10             	mov    0x10(%ebp),%ecx
    7ec0:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7ec3:	89 d0                	mov    %edx,%eax
    7ec5:	01 c0                	add    %eax,%eax
    7ec7:	01 d0                	add    %edx,%eax
    7ec9:	c1 e0 02             	shl    $0x2,%eax
    7ecc:	01 d0                	add    %edx,%eax
    7ece:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7ed1:	01 d0                	add    %edx,%eax
    7ed3:	83 c0 52             	add    $0x52,%eax
    7ed6:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    7eda:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7edd:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    7ee4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ee7:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7eee:	83 f8 07             	cmp    $0x7,%eax
    7ef1:	74 30                	je     7f23 <III_stereo+0x7cc>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    7ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ef6:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7efd:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    7f03:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    7f09:	dd 05 60 bd 00 00    	fldl   0xbd60
    7f0f:	de c9                	fmulp  %st,%st(1)
    7f11:	dd 1c 24             	fstpl  (%esp)
    7f14:	e8 67 b1 ff ff       	call   3080 <tan>
    7f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7f1c:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    7f23:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    7f27:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7f2b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7f2f:	7f 8c                	jg     7ebd <III_stereo+0x766>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    7f31:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
    7f35:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    7f39:	0f 8e 06 ff ff ff    	jle    7e45 <III_stereo+0x6ee>
                     i++;
                  }
                  sfb++;
               }

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    7f3f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7f42:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7f48:	05 9c cf 00 00       	add    $0xcf9c,%eax
    7f4d:	8b 50 0c             	mov    0xc(%eax),%edx
    7f50:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7f53:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7f59:	05 98 cf 00 00       	add    $0xcf98,%eax
    7f5e:	8b 40 0c             	mov    0xc(%eax),%eax
    7f61:	29 c2                	sub    %eax,%edx
    7f63:	89 d0                	mov    %edx,%eax
    7f65:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    7f68:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7f6b:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7f71:	05 98 cf 00 00       	add    $0xcf98,%eax
    7f76:	8b 50 0c             	mov    0xc(%eax),%edx
    7f79:	89 d0                	mov    %edx,%eax
    7f7b:	01 c0                	add    %eax,%eax
    7f7d:	01 c2                	add    %eax,%edx
    7f7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7f82:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7f86:	01 d0                	add    %edx,%eax
    7f88:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    7f8b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7f8e:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7f94:	05 a0 cf 00 00       	add    $0xcfa0,%eax
    7f99:	8b 50 0c             	mov    0xc(%eax),%edx
    7f9c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7f9f:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7fa5:	05 9c cf 00 00       	add    $0xcf9c,%eax
    7faa:	8b 40 0c             	mov    0xc(%eax),%eax
    7fad:	29 c2                	sub    %eax,%edx
    7faf:	89 d0                	mov    %edx,%eax
    7fb1:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    7fb4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7fb7:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7fbd:	05 9c cf 00 00       	add    $0xcf9c,%eax
    7fc2:	8b 50 0c             	mov    0xc(%eax),%edx
    7fc5:	89 d0                	mov    %edx,%eax
    7fc7:	01 c0                	add    %eax,%eax
    7fc9:	01 c2                	add    %eax,%edx
    7fcb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7fce:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7fd2:	01 d0                	add    %edx,%eax
    7fd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    7fd7:	eb 30                	jmp    8009 <III_stereo+0x8b2>
               {  is_pos[i] = is_pos[sfb];
    7fd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7fdc:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    7fe3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7fe6:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    7fed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7ff0:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    7ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ffa:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    8001:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    8005:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    8009:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    800d:	7f ca                	jg     7fd9 <III_stereo+0x882>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    800f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8013:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    8017:	0f 8e ee fc ff ff    	jle    7d0b <III_stereo+0x5b4>
   for ( i=0; i<576; i++ )
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
    801d:	e9 f0 01 00 00       	jmp    8212 <III_stereo+0xabb>
                  i++;
               }
            }
         }
      } else
      {  i = 31;
    8022:	c7 45 f0 1f 00 00 00 	movl   $0x1f,-0x10(%ebp)
         ss = 17;
    8029:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         sb = 0;
    8030:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
         while ( i >= 0 )
    8037:	eb 63                	jmp    809c <III_stereo+0x945>
         {  if ( xr[1][i][ss] != 0.0 )
    8039:	8b 45 08             	mov    0x8(%ebp),%eax
    803c:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    8042:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8045:	89 d0                	mov    %edx,%eax
    8047:	c1 e0 03             	shl    $0x3,%eax
    804a:	01 d0                	add    %edx,%eax
    804c:	01 c0                	add    %eax,%eax
    804e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8051:	01 d0                	add    %edx,%eax
    8053:	dd 04 c1             	fldl   (%ecx,%eax,8)
    8056:	d9 ee                	fldz   
    8058:	df e9                	fucomip %st(1),%st
    805a:	7a 0a                	jp     8066 <III_stereo+0x90f>
    805c:	d9 ee                	fldz   
    805e:	df e9                	fucomip %st(1),%st
    8060:	dd d8                	fstp   %st(0)
    8062:	74 23                	je     8087 <III_stereo+0x930>
    8064:	eb 02                	jmp    8068 <III_stereo+0x911>
    8066:	dd d8                	fstp   %st(0)
            {  sb = i*18+ss;
    8068:	8b 55 f0             	mov    -0x10(%ebp),%edx
    806b:	89 d0                	mov    %edx,%eax
    806d:	c1 e0 03             	shl    $0x3,%eax
    8070:	01 d0                	add    %edx,%eax
    8072:	01 c0                	add    %eax,%eax
    8074:	89 c2                	mov    %eax,%edx
    8076:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8079:	01 d0                	add    %edx,%eax
    807b:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = -1;
    807e:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    8085:	eb 15                	jmp    809c <III_stereo+0x945>
            } else
            {  ss--;
    8087:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
               if ( ss < 0 )
    808b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    808f:	79 0b                	jns    809c <III_stereo+0x945>
               {  i--;
    8091:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                  ss = 17;
    8095:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         }
      } else
      {  i = 31;
         ss = 17;
         sb = 0;
         while ( i >= 0 )
    809c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    80a0:	79 97                	jns    8039 <III_stereo+0x8e2>
               {  i--;
                  ss = 17;
               }
            }
         }
         i = 0;
    80a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
         while ( sfBandIndex[sfreq].l[i] <= sb )
    80a9:	eb 04                	jmp    80af <III_stereo+0x958>
            i++;
    80ab:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  ss = 17;
               }
            }
         }
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
    80af:	8b 55 c8             	mov    -0x38(%ebp),%edx
    80b2:	89 d0                	mov    %edx,%eax
    80b4:	c1 e0 03             	shl    $0x3,%eax
    80b7:	01 d0                	add    %edx,%eax
    80b9:	c1 e0 02             	shl    $0x2,%eax
    80bc:	01 d0                	add    %edx,%eax
    80be:	8b 55 f0             	mov    -0x10(%ebp),%edx
    80c1:	01 d0                	add    %edx,%eax
    80c3:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    80ca:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    80cd:	7e dc                	jle    80ab <III_stereo+0x954>
            i++;
         sfb = i;
    80cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    80d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
         i = sfBandIndex[sfreq].l[i];
    80d5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    80d8:	89 d0                	mov    %edx,%eax
    80da:	c1 e0 03             	shl    $0x3,%eax
    80dd:	01 d0                	add    %edx,%eax
    80df:	c1 e0 02             	shl    $0x2,%eax
    80e2:	01 d0                	add    %edx,%eax
    80e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    80e7:	01 d0                	add    %edx,%eax
    80e9:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    80f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
         for ( ; sfb<21; sfb++ )
    80f3:	e9 a9 00 00 00       	jmp    81a1 <III_stereo+0xa4a>
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
    80f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    80fb:	8d 48 01             	lea    0x1(%eax),%ecx
    80fe:	8b 55 c8             	mov    -0x38(%ebp),%edx
    8101:	89 d0                	mov    %edx,%eax
    8103:	c1 e0 03             	shl    $0x3,%eax
    8106:	01 d0                	add    %edx,%eax
    8108:	c1 e0 02             	shl    $0x2,%eax
    810b:	01 d0                	add    %edx,%eax
    810d:	01 c8                	add    %ecx,%eax
    810f:	8b 0c 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%ecx
    8116:	8b 55 c8             	mov    -0x38(%ebp),%edx
    8119:	89 d0                	mov    %edx,%eax
    811b:	c1 e0 03             	shl    $0x3,%eax
    811e:	01 d0                	add    %edx,%eax
    8120:	c1 e0 02             	shl    $0x2,%eax
    8123:	01 d0                	add    %edx,%eax
    8125:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8128:	01 d0                	add    %edx,%eax
    812a:	8b 04 85 20 cf 00 00 	mov    0xcf20(,%eax,4),%eax
    8131:	29 c1                	sub    %eax,%ecx
    8133:	89 c8                	mov    %ecx,%eax
    8135:	89 45 e8             	mov    %eax,-0x18(%ebp)
            for ( ; sb > 0; sb--)
    8138:	eb 5d                	jmp    8197 <III_stereo+0xa40>
            {  is_pos[i] = (*scalefac)[1].l[sfb];
    813a:	8b 45 10             	mov    0x10(%ebp),%eax
    813d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8140:	83 c2 3e             	add    $0x3e,%edx
    8143:	8b 14 90             	mov    (%eax,%edx,4),%edx
    8146:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8149:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
               if ( is_pos[i] != 7 )
    8150:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8153:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    815a:	83 f8 07             	cmp    $0x7,%eax
    815d:	74 30                	je     818f <III_stereo+0xa38>
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
    815f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8162:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    8169:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    816f:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    8175:	dd 05 60 bd 00 00    	fldl   0xbd60
    817b:	de c9                	fmulp  %st,%st(1)
    817d:	dd 1c 24             	fstpl  (%esp)
    8180:	e8 fb ae ff ff       	call   3080 <tan>
    8185:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8188:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
               i++;
    818f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
            for ( ; sb > 0; sb--)
    8193:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    8197:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    819b:	7f 9d                	jg     813a <III_stereo+0x9e3>
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
    819d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    81a1:	83 7d f4 14          	cmpl   $0x14,-0xc(%ebp)
    81a5:	0f 8e 4d ff ff ff    	jle    80f8 <III_stereo+0x9a1>
               if ( is_pos[i] != 7 )
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
    81ab:	8b 45 c8             	mov    -0x38(%ebp),%eax
    81ae:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    81b4:	05 70 cf 00 00       	add    $0xcf70,%eax
    81b9:	8b 00                	mov    (%eax),%eax
    81bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    81be:	8b 45 c8             	mov    -0x38(%ebp),%eax
    81c1:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    81c7:	05 74 cf 00 00       	add    $0xcf74,%eax
    81cc:	8b 00                	mov    (%eax),%eax
    81ce:	ba 40 02 00 00       	mov    $0x240,%edx
    81d3:	29 c2                	sub    %eax,%edx
    81d5:	89 d0                	mov    %edx,%eax
    81d7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    81da:	eb 30                	jmp    820c <III_stereo+0xab5>
         {  is_pos[i] = is_pos[sfb];
    81dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    81df:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    81e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    81e9:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
            is_ratio[i] = is_ratio[sfb];
    81f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    81f3:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    81fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    81fd:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
            i++;
    8204:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    8208:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    820c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    8210:	7f ca                	jg     81dc <III_stereo+0xa85>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    8212:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    8219:	eb 55                	jmp    8270 <III_stereo+0xb19>
      for(sb=0;sb<SBLIMIT;sb++)
    821b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    8222:	eb 42                	jmp    8266 <III_stereo+0xb0f>
         for(ss=0;ss<SSLIMIT;ss++)
    8224:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    822b:	eb 2f                	jmp    825c <III_stereo+0xb05>
            lr[ch][sb][ss] = 0;
    822d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    8230:	89 d0                	mov    %edx,%eax
    8232:	c1 e0 03             	shl    $0x3,%eax
    8235:	01 d0                	add    %edx,%eax
    8237:	c1 e0 09             	shl    $0x9,%eax
    823a:	89 c2                	mov    %eax,%edx
    823c:	8b 45 0c             	mov    0xc(%ebp),%eax
    823f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8242:	8b 55 e8             	mov    -0x18(%ebp),%edx
    8245:	89 d0                	mov    %edx,%eax
    8247:	c1 e0 03             	shl    $0x3,%eax
    824a:	01 d0                	add    %edx,%eax
    824c:	01 c0                	add    %eax,%eax
    824e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8251:	01 d0                	add    %edx,%eax
    8253:	d9 ee                	fldz   
    8255:	dd 1c c1             	fstpl  (%ecx,%eax,8)
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    8258:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    825c:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    8260:	7e cb                	jle    822d <III_stereo+0xad6>
         }
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
    8262:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    8266:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    826a:	7e b8                	jle    8224 <III_stereo+0xacd>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    826c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    8270:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    8274:	7e a5                	jle    821b <III_stereo+0xac4>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
    8276:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    827a:	0f 85 3d 02 00 00    	jne    84bd <III_stereo+0xd66>
      for(sb=0;sb<SBLIMIT;sb++)
    8280:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    8287:	e9 25 02 00 00       	jmp    84b1 <III_stereo+0xd5a>
         for(ss=0;ss<SSLIMIT;ss++) {
    828c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    8293:	e9 0b 02 00 00       	jmp    84a3 <III_stereo+0xd4c>
            i = (sb*18)+ss;
    8298:	8b 55 e8             	mov    -0x18(%ebp),%edx
    829b:	89 d0                	mov    %edx,%eax
    829d:	c1 e0 03             	shl    $0x3,%eax
    82a0:	01 d0                	add    %edx,%eax
    82a2:	01 c0                	add    %eax,%eax
    82a4:	89 c2                	mov    %eax,%edx
    82a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    82a9:	01 d0                	add    %edx,%eax
    82ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
            if ( is_pos[i] == 7 ) {
    82ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    82b1:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    82b8:	83 f8 07             	cmp    $0x7,%eax
    82bb:	0f 85 2c 01 00 00    	jne    83ed <III_stereo+0xc96>
               if ( ms_stereo ) {
    82c1:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
    82c5:	0f 84 b5 00 00 00    	je     8380 <III_stereo+0xc29>
                  lr[0][sb][ss] = (xr[0][sb][ss]+xr[1][sb][ss])/1.41421356;
    82cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    82ce:	8b 55 e8             	mov    -0x18(%ebp),%edx
    82d1:	89 d0                	mov    %edx,%eax
    82d3:	c1 e0 03             	shl    $0x3,%eax
    82d6:	01 d0                	add    %edx,%eax
    82d8:	01 c0                	add    %eax,%eax
    82da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    82dd:	01 d0                	add    %edx,%eax
    82df:	dd 04 c1             	fldl   (%ecx,%eax,8)
    82e2:	8b 45 08             	mov    0x8(%ebp),%eax
    82e5:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    82eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
    82ee:	89 d0                	mov    %edx,%eax
    82f0:	c1 e0 03             	shl    $0x3,%eax
    82f3:	01 d0                	add    %edx,%eax
    82f5:	01 c0                	add    %eax,%eax
    82f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    82fa:	01 d0                	add    %edx,%eax
    82fc:	dd 04 c1             	fldl   (%ecx,%eax,8)
    82ff:	de c1                	faddp  %st,%st(1)
    8301:	dd 05 68 bd 00 00    	fldl   0xbd68
    8307:	de f9                	fdivrp %st,%st(1)
    8309:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    830c:	8b 55 e8             	mov    -0x18(%ebp),%edx
    830f:	89 d0                	mov    %edx,%eax
    8311:	c1 e0 03             	shl    $0x3,%eax
    8314:	01 d0                	add    %edx,%eax
    8316:	01 c0                	add    %eax,%eax
    8318:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    831b:	01 d0                	add    %edx,%eax
    831d:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = (xr[0][sb][ss]-xr[1][sb][ss])/1.41421356;
    8320:	8b 45 0c             	mov    0xc(%ebp),%eax
    8323:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    8329:	8b 4d 08             	mov    0x8(%ebp),%ecx
    832c:	8b 55 e8             	mov    -0x18(%ebp),%edx
    832f:	89 d0                	mov    %edx,%eax
    8331:	c1 e0 03             	shl    $0x3,%eax
    8334:	01 d0                	add    %edx,%eax
    8336:	01 c0                	add    %eax,%eax
    8338:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    833b:	01 d0                	add    %edx,%eax
    833d:	dd 04 c1             	fldl   (%ecx,%eax,8)
    8340:	8b 45 08             	mov    0x8(%ebp),%eax
    8343:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    8349:	8b 55 e8             	mov    -0x18(%ebp),%edx
    834c:	89 d0                	mov    %edx,%eax
    834e:	c1 e0 03             	shl    $0x3,%eax
    8351:	01 d0                	add    %edx,%eax
    8353:	01 c0                	add    %eax,%eax
    8355:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8358:	01 d0                	add    %edx,%eax
    835a:	dd 04 c1             	fldl   (%ecx,%eax,8)
    835d:	de e9                	fsubrp %st,%st(1)
    835f:	dd 05 68 bd 00 00    	fldl   0xbd68
    8365:	de f9                	fdivrp %st,%st(1)
    8367:	8b 55 e8             	mov    -0x18(%ebp),%edx
    836a:	89 d0                	mov    %edx,%eax
    836c:	c1 e0 03             	shl    $0x3,%eax
    836f:	01 d0                	add    %edx,%eax
    8371:	01 c0                	add    %eax,%eax
    8373:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8376:	01 d0                	add    %edx,%eax
    8378:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    837b:	e9 1f 01 00 00       	jmp    849f <III_stereo+0xd48>
               }
               else {
                  lr[0][sb][ss] = xr[0][sb][ss];
    8380:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8383:	8b 55 e8             	mov    -0x18(%ebp),%edx
    8386:	89 d0                	mov    %edx,%eax
    8388:	c1 e0 03             	shl    $0x3,%eax
    838b:	01 d0                	add    %edx,%eax
    838d:	01 c0                	add    %eax,%eax
    838f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8392:	01 d0                	add    %edx,%eax
    8394:	dd 04 c1             	fldl   (%ecx,%eax,8)
    8397:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    839a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    839d:	89 d0                	mov    %edx,%eax
    839f:	c1 e0 03             	shl    $0x3,%eax
    83a2:	01 d0                	add    %edx,%eax
    83a4:	01 c0                	add    %eax,%eax
    83a6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    83a9:	01 d0                	add    %edx,%eax
    83ab:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = xr[1][sb][ss];
    83ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    83b1:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    83b7:	8b 45 08             	mov    0x8(%ebp),%eax
    83ba:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    83c0:	8b 55 e8             	mov    -0x18(%ebp),%edx
    83c3:	89 d0                	mov    %edx,%eax
    83c5:	c1 e0 03             	shl    $0x3,%eax
    83c8:	01 d0                	add    %edx,%eax
    83ca:	01 c0                	add    %eax,%eax
    83cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    83cf:	01 d0                	add    %edx,%eax
    83d1:	dd 04 c3             	fldl   (%ebx,%eax,8)
    83d4:	8b 55 e8             	mov    -0x18(%ebp),%edx
    83d7:	89 d0                	mov    %edx,%eax
    83d9:	c1 e0 03             	shl    $0x3,%eax
    83dc:	01 d0                	add    %edx,%eax
    83de:	01 c0                	add    %eax,%eax
    83e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    83e3:	01 d0                	add    %edx,%eax
    83e5:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    83e8:	e9 b2 00 00 00       	jmp    849f <III_stereo+0xd48>
               }
            }
            else if (i_stereo ) {
    83ed:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    83f1:	0f 84 94 00 00 00    	je     848b <III_stereo+0xd34>
               lr[0][sb][ss] = xr[0][sb][ss] * (is_ratio[i]/(1+is_ratio[i]));
    83f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    83fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
    83fd:	89 d0                	mov    %edx,%eax
    83ff:	c1 e0 03             	shl    $0x3,%eax
    8402:	01 d0                	add    %edx,%eax
    8404:	01 c0                	add    %eax,%eax
    8406:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8409:	01 d0                	add    %edx,%eax
    840b:	dd 04 c1             	fldl   (%ecx,%eax,8)
    840e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8411:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    8418:	8b 45 f0             	mov    -0x10(%ebp),%eax
    841b:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    8422:	d9 e8                	fld1   
    8424:	de c1                	faddp  %st,%st(1)
    8426:	de f9                	fdivrp %st,%st(1)
    8428:	de c9                	fmulp  %st,%st(1)
    842a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    842d:	8b 55 e8             	mov    -0x18(%ebp),%edx
    8430:	89 d0                	mov    %edx,%eax
    8432:	c1 e0 03             	shl    $0x3,%eax
    8435:	01 d0                	add    %edx,%eax
    8437:	01 c0                	add    %eax,%eax
    8439:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    843c:	01 d0                	add    %edx,%eax
    843e:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               lr[1][sb][ss] = xr[0][sb][ss] * (1/(1+is_ratio[i]));
    8441:	8b 45 0c             	mov    0xc(%ebp),%eax
    8444:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    844a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    844d:	8b 55 e8             	mov    -0x18(%ebp),%edx
    8450:	89 d0                	mov    %edx,%eax
    8452:	c1 e0 03             	shl    $0x3,%eax
    8455:	01 d0                	add    %edx,%eax
    8457:	01 c0                	add    %eax,%eax
    8459:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    845c:	01 d0                	add    %edx,%eax
    845e:	dd 04 c1             	fldl   (%ecx,%eax,8)
    8461:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8464:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    846b:	d9 e8                	fld1   
    846d:	de c1                	faddp  %st,%st(1)
    846f:	d9 e8                	fld1   
    8471:	de f1                	fdivp  %st,%st(1)
    8473:	de c9                	fmulp  %st,%st(1)
    8475:	8b 55 e8             	mov    -0x18(%ebp),%edx
    8478:	89 d0                	mov    %edx,%eax
    847a:	c1 e0 03             	shl    $0x3,%eax
    847d:	01 d0                	add    %edx,%eax
    847f:	01 c0                	add    %eax,%eax
    8481:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    8484:	01 d0                	add    %edx,%eax
    8486:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    8489:	eb 14                	jmp    849f <III_stereo+0xd48>
            }
            else {
               printf(0,"Error in streo processing\n");
    848b:	c7 44 24 04 00 ad 00 	movl   $0xad00,0x4(%esp)
    8492:	00 
    8493:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    849a:	e8 3c a7 ff ff       	call   2bdb <printf>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++) {
    849f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    84a3:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    84a7:	0f 8e eb fd ff ff    	jle    8298 <III_stereo+0xb41>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
    84ad:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    84b1:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    84b5:	0f 8e d1 fd ff ff    	jle    828c <III_stereo+0xb35>
    84bb:	eb 54                	jmp    8511 <III_stereo+0xdba>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    84bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    84c4:	eb 45                	jmp    850b <III_stereo+0xdb4>
         for(ss=0;ss<SSLIMIT;ss++)
    84c6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    84cd:	eb 32                	jmp    8501 <III_stereo+0xdaa>
            lr[0][sb][ss] = xr[0][sb][ss];
    84cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
    84d2:	8b 55 e8             	mov    -0x18(%ebp),%edx
    84d5:	89 d0                	mov    %edx,%eax
    84d7:	c1 e0 03             	shl    $0x3,%eax
    84da:	01 d0                	add    %edx,%eax
    84dc:	01 c0                	add    %eax,%eax
    84de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    84e1:	01 d0                	add    %edx,%eax
    84e3:	dd 04 c1             	fldl   (%ecx,%eax,8)
    84e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    84e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
    84ec:	89 d0                	mov    %edx,%eax
    84ee:	c1 e0 03             	shl    $0x3,%eax
    84f1:	01 d0                	add    %edx,%eax
    84f3:	01 c0                	add    %eax,%eax
    84f5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    84f8:	01 d0                	add    %edx,%eax
    84fa:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    84fd:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    8501:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    8505:	7e c8                	jle    84cf <III_stereo+0xd78>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    8507:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    850b:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    850f:	7e b5                	jle    84c6 <III_stereo+0xd6f>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[0][sb][ss] = xr[0][sb][ss];

}
    8511:	81 c4 50 1b 00 00    	add    $0x1b50,%esp
    8517:	5b                   	pop    %ebx
    8518:	5e                   	pop    %esi
    8519:	5d                   	pop    %ebp
    851a:	c3                   	ret    

0000851b <III_antialias>:


double Ci[8]={-0.6,-0.535,-0.33,-0.185,-0.095,-0.041,-0.0142,-0.0037};
void III_antialias(double xr[SBLIMIT][SSLIMIT], double hybridIn[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    851b:	55                   	push   %ebp
    851c:	89 e5                	mov    %esp,%ebp
    851e:	83 ec 48             	sub    $0x48,%esp
   static int    init = 1;
   static double ca[8],cs[8];
   double        bu,bd;  /* upper and lower butterfly inputs */
   int           ss,sb,sblim;

   if (init) {
    8521:	a1 80 d1 00 00       	mov    0xd180,%eax
    8526:	85 c0                	test   %eax,%eax
    8528:	74 68                	je     8592 <III_antialias+0x77>
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    852a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    8531:	eb 4f                	jmp    8582 <III_antialias+0x67>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
    8533:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8536:	dd 04 c5 40 d1 00 00 	fldl   0xd140(,%eax,8)
    853d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8540:	dd 04 c5 40 d1 00 00 	fldl   0xd140(,%eax,8)
    8547:	de c9                	fmulp  %st,%st(1)
    8549:	d9 e8                	fld1   
    854b:	de c1                	faddp  %st,%st(1)
    854d:	dd 1c 24             	fstpl  (%esp)
    8550:	e8 de ac ff ff       	call   3233 <sqrt>
    8555:	dd 5d e0             	fstpl  -0x20(%ebp)
         cs[i] = 1.0/sq;
    8558:	d9 e8                	fld1   
    855a:	dc 75 e0             	fdivl  -0x20(%ebp)
    855d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8560:	dd 1c c5 e0 d1 00 00 	fstpl  0xd1e0(,%eax,8)
         ca[i] = Ci[i]/sq;
    8567:	8b 45 e8             	mov    -0x18(%ebp),%eax
    856a:	dd 04 c5 40 d1 00 00 	fldl   0xd140(,%eax,8)
    8571:	dc 75 e0             	fdivl  -0x20(%ebp)
    8574:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8577:	dd 1c c5 20 d2 00 00 	fstpl  0xd220(,%eax,8)
   int           ss,sb,sblim;

   if (init) {
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    857e:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    8582:	83 7d e8 07          	cmpl   $0x7,-0x18(%ebp)
    8586:	7e ab                	jle    8533 <III_antialias+0x18>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
         cs[i] = 1.0/sq;
         ca[i] = Ci[i]/sq;
      }
      init = 0;
    8588:	c7 05 80 d1 00 00 00 	movl   $0x0,0xd180
    858f:	00 00 00 
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    8592:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8599:	eb 4c                	jmp    85e7 <III_antialias+0xcc>
       for(ss=0;ss<SSLIMIT;ss++)
    859b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    85a2:	eb 39                	jmp    85dd <III_antialias+0xc2>
          hybridIn[sb][ss] = xr[sb][ss];
    85a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    85a7:	89 d0                	mov    %edx,%eax
    85a9:	c1 e0 03             	shl    $0x3,%eax
    85ac:	01 d0                	add    %edx,%eax
    85ae:	c1 e0 04             	shl    $0x4,%eax
    85b1:	89 c2                	mov    %eax,%edx
    85b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    85b6:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    85b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    85bc:	89 d0                	mov    %edx,%eax
    85be:	c1 e0 03             	shl    $0x3,%eax
    85c1:	01 d0                	add    %edx,%eax
    85c3:	c1 e0 04             	shl    $0x4,%eax
    85c6:	89 c2                	mov    %eax,%edx
    85c8:	8b 45 08             	mov    0x8(%ebp),%eax
    85cb:	01 c2                	add    %eax,%edx
    85cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    85d0:	dd 04 c2             	fldl   (%edx,%eax,8)
    85d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    85d6:	dd 1c c1             	fstpl  (%ecx,%eax,8)
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
    85d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    85dd:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    85e1:	7e c1                	jle    85a4 <III_antialias+0x89>
      init = 0;
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    85e3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    85e7:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    85eb:	7e ae                	jle    859b <III_antialias+0x80>
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    85ed:	8b 45 10             	mov    0x10(%ebp),%eax
    85f0:	8b 40 10             	mov    0x10(%eax),%eax
    85f3:	85 c0                	test   %eax,%eax
    85f5:	74 1a                	je     8611 <III_antialias+0xf6>
    85f7:	8b 45 10             	mov    0x10(%ebp),%eax
    85fa:	8b 40 14             	mov    0x14(%eax),%eax
    85fd:	83 f8 02             	cmp    $0x2,%eax
    8600:	75 0f                	jne    8611 <III_antialias+0xf6>
       !gr_info->mixed_block_flag ) return;
    8602:	8b 45 10             	mov    0x10(%ebp),%eax
    8605:	8b 40 18             	mov    0x18(%eax),%eax

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    8608:	85 c0                	test   %eax,%eax
    860a:	75 05                	jne    8611 <III_antialias+0xf6>
       !gr_info->mixed_block_flag ) return;
    860c:	e9 1c 01 00 00       	jmp    872d <III_antialias+0x212>

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    8611:	8b 45 10             	mov    0x10(%ebp),%eax
    8614:	8b 40 10             	mov    0x10(%eax),%eax
    8617:	85 c0                	test   %eax,%eax
    8619:	74 1e                	je     8639 <III_antialias+0x11e>
    861b:	8b 45 10             	mov    0x10(%ebp),%eax
    861e:	8b 40 18             	mov    0x18(%eax),%eax
    8621:	85 c0                	test   %eax,%eax
    8623:	74 14                	je     8639 <III_antialias+0x11e>
     (gr_info->block_type == 2))
    8625:	8b 45 10             	mov    0x10(%ebp),%eax
    8628:	8b 40 14             	mov    0x14(%eax),%eax
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
       !gr_info->mixed_block_flag ) return;

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    862b:	83 f8 02             	cmp    $0x2,%eax
    862e:	75 09                	jne    8639 <III_antialias+0x11e>
     (gr_info->block_type == 2))
      sblim = 1;
    8630:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    8637:	eb 07                	jmp    8640 <III_antialias+0x125>
   else
      sblim = SBLIMIT-1;
    8639:	c7 45 ec 1f 00 00 00 	movl   $0x1f,-0x14(%ebp)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    8640:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8647:	e9 d5 00 00 00       	jmp    8721 <III_antialias+0x206>
      for(ss=0;ss<8;ss++) {
    864c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8653:	e9 bb 00 00 00       	jmp    8713 <III_antialias+0x1f8>
         bu = xr[sb][17-ss];
    8658:	8b 55 f0             	mov    -0x10(%ebp),%edx
    865b:	89 d0                	mov    %edx,%eax
    865d:	c1 e0 03             	shl    $0x3,%eax
    8660:	01 d0                	add    %edx,%eax
    8662:	c1 e0 04             	shl    $0x4,%eax
    8665:	89 c2                	mov    %eax,%edx
    8667:	8b 45 08             	mov    0x8(%ebp),%eax
    866a:	01 c2                	add    %eax,%edx
    866c:	b8 11 00 00 00       	mov    $0x11,%eax
    8671:	2b 45 f4             	sub    -0xc(%ebp),%eax
    8674:	dd 04 c2             	fldl   (%edx,%eax,8)
    8677:	dd 5d d8             	fstpl  -0x28(%ebp)
         bd = xr[sb+1][ss];
    867a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    867d:	8d 50 01             	lea    0x1(%eax),%edx
    8680:	89 d0                	mov    %edx,%eax
    8682:	c1 e0 03             	shl    $0x3,%eax
    8685:	01 d0                	add    %edx,%eax
    8687:	c1 e0 04             	shl    $0x4,%eax
    868a:	89 c2                	mov    %eax,%edx
    868c:	8b 45 08             	mov    0x8(%ebp),%eax
    868f:	01 c2                	add    %eax,%edx
    8691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8694:	dd 04 c2             	fldl   (%edx,%eax,8)
    8697:	dd 5d d0             	fstpl  -0x30(%ebp)
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
    869a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    869d:	89 d0                	mov    %edx,%eax
    869f:	c1 e0 03             	shl    $0x3,%eax
    86a2:	01 d0                	add    %edx,%eax
    86a4:	c1 e0 04             	shl    $0x4,%eax
    86a7:	89 c2                	mov    %eax,%edx
    86a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    86ac:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    86af:	b8 11 00 00 00       	mov    $0x11,%eax
    86b4:	2b 45 f4             	sub    -0xc(%ebp),%eax
    86b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    86ba:	dd 04 d5 e0 d1 00 00 	fldl   0xd1e0(,%edx,8)
    86c1:	dc 4d d8             	fmull  -0x28(%ebp)
    86c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    86c7:	dd 04 d5 20 d2 00 00 	fldl   0xd220(,%edx,8)
    86ce:	dc 4d d0             	fmull  -0x30(%ebp)
    86d1:	de e9                	fsubrp %st,%st(1)
    86d3:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
    86d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    86d9:	8d 50 01             	lea    0x1(%eax),%edx
    86dc:	89 d0                	mov    %edx,%eax
    86de:	c1 e0 03             	shl    $0x3,%eax
    86e1:	01 d0                	add    %edx,%eax
    86e3:	c1 e0 04             	shl    $0x4,%eax
    86e6:	89 c2                	mov    %eax,%edx
    86e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    86eb:	01 c2                	add    %eax,%edx
    86ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    86f0:	dd 04 c5 e0 d1 00 00 	fldl   0xd1e0(,%eax,8)
    86f7:	dc 4d d0             	fmull  -0x30(%ebp)
    86fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    86fd:	dd 04 c5 20 d2 00 00 	fldl   0xd220(,%eax,8)
    8704:	dc 4d d8             	fmull  -0x28(%ebp)
    8707:	de c1                	faddp  %st,%st(1)
    8709:	8b 45 f4             	mov    -0xc(%ebp),%eax
    870c:	dd 1c c2             	fstpl  (%edx,%eax,8)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
      for(ss=0;ss<8;ss++) {
    870f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8713:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    8717:	0f 8e 3b ff ff ff    	jle    8658 <III_antialias+0x13d>
      sblim = SBLIMIT-1;

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    871d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8721:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8724:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    8727:	0f 8c 1f ff ff ff    	jl     864c <III_antialias+0x131>
         bu = xr[sb][17-ss];
         bd = xr[sb+1][ss];
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
         }
}
    872d:	c9                   	leave  
    872e:	c3                   	ret    

0000872f <inv_mdct>:


void inv_mdct(double in[18], double out[36], int block_type)
{
    872f:	55                   	push   %ebp
    8730:	89 e5                	mov    %esp,%ebp
    8732:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	double  tmp[12],sum;
	static  double  win[4][36];
	static  int init=0;
	static  double COS[4*36];

    if(init==0){
    8738:	a1 60 d2 00 00       	mov    0xd260,%eax
    873d:	85 c0                	test   %eax,%eax
    873f:	0f 85 59 02 00 00    	jne    899e <inv_mdct+0x26f>

    /* type 0 */
      for(i=0;i<36;i++)
    8745:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    874c:	eb 29                	jmp    8777 <inv_mdct+0x48>
         win[0][i] = sin( PI/36 *(i+0.5) );
    874e:	db 45 f4             	fildl  -0xc(%ebp)
    8751:	dd 05 70 bd 00 00    	fldl   0xbd70
    8757:	de c1                	faddp  %st,%st(1)
    8759:	dd 05 78 bd 00 00    	fldl   0xbd78
    875f:	de c9                	fmulp  %st,%st(1)
    8761:	dd 1c 24             	fstpl  (%esp)
    8764:	e8 53 a8 ff ff       	call   2fbc <sin>
    8769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    876c:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
	static  double COS[4*36];

    if(init==0){

    /* type 0 */
      for(i=0;i<36;i++)
    8773:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8777:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    877b:	7e d1                	jle    874e <inv_mdct+0x1f>
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    877d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8784:	eb 2c                	jmp    87b2 <inv_mdct+0x83>
         win[1][i] = sin( PI/36 *(i+0.5) );
    8786:	db 45 f4             	fildl  -0xc(%ebp)
    8789:	dd 05 70 bd 00 00    	fldl   0xbd70
    878f:	de c1                	faddp  %st,%st(1)
    8791:	dd 05 78 bd 00 00    	fldl   0xbd78
    8797:	de c9                	fmulp  %st,%st(1)
    8799:	dd 1c 24             	fstpl  (%esp)
    879c:	e8 1b a8 ff ff       	call   2fbc <sin>
    87a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    87a4:	83 c0 24             	add    $0x24,%eax
    87a7:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
    /* type 0 */
      for(i=0;i<36;i++)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    87ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    87b2:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    87b6:	7e ce                	jle    8786 <inv_mdct+0x57>
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    87b8:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    87bf:	eb 13                	jmp    87d4 <inv_mdct+0xa5>
         win[1][i] = 1.0;
    87c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    87c4:	83 c0 24             	add    $0x24,%eax
    87c7:	d9 e8                	fld1   
    87c9:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    87d0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    87d4:	83 7d f4 17          	cmpl   $0x17,-0xc(%ebp)
    87d8:	7e e7                	jle    87c1 <inv_mdct+0x92>
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    87da:	c7 45 f4 18 00 00 00 	movl   $0x18,-0xc(%ebp)
    87e1:	eb 34                	jmp    8817 <inv_mdct+0xe8>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
    87e3:	db 45 f4             	fildl  -0xc(%ebp)
    87e6:	dd 05 70 bd 00 00    	fldl   0xbd70
    87ec:	de c1                	faddp  %st,%st(1)
    87ee:	dd 05 80 bd 00 00    	fldl   0xbd80
    87f4:	de e9                	fsubrp %st,%st(1)
    87f6:	dd 05 60 bd 00 00    	fldl   0xbd60
    87fc:	de c9                	fmulp  %st,%st(1)
    87fe:	dd 1c 24             	fstpl  (%esp)
    8801:	e8 b6 a7 ff ff       	call   2fbc <sin>
    8806:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8809:	83 c0 24             	add    $0x24,%eax
    880c:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    8813:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8817:	83 7d f4 1d          	cmpl   $0x1d,-0xc(%ebp)
    881b:	7e c6                	jle    87e3 <inv_mdct+0xb4>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    881d:	c7 45 f4 1e 00 00 00 	movl   $0x1e,-0xc(%ebp)
    8824:	eb 13                	jmp    8839 <inv_mdct+0x10a>
         win[1][i] = 0.0;
    8826:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8829:	83 c0 24             	add    $0x24,%eax
    882c:	d9 ee                	fldz   
    882e:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    8835:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8839:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    883d:	7e e7                	jle    8826 <inv_mdct+0xf7>
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    883f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8846:	eb 13                	jmp    885b <inv_mdct+0x12c>
         win[3][i] = 0.0;
    8848:	8b 45 f4             	mov    -0xc(%ebp),%eax
    884b:	83 c0 6c             	add    $0x6c,%eax
    884e:	d9 ee                	fldz   
    8850:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    8857:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    885b:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    885f:	7e e7                	jle    8848 <inv_mdct+0x119>
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    8861:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    8868:	eb 34                	jmp    889e <inv_mdct+0x16f>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
    886a:	db 45 f4             	fildl  -0xc(%ebp)
    886d:	dd 05 70 bd 00 00    	fldl   0xbd70
    8873:	de c1                	faddp  %st,%st(1)
    8875:	dd 05 88 bd 00 00    	fldl   0xbd88
    887b:	de e9                	fsubrp %st,%st(1)
    887d:	dd 05 60 bd 00 00    	fldl   0xbd60
    8883:	de c9                	fmulp  %st,%st(1)
    8885:	dd 1c 24             	fstpl  (%esp)
    8888:	e8 2f a7 ff ff       	call   2fbc <sin>
    888d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8890:	83 c0 6c             	add    $0x6c,%eax
    8893:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    889a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    889e:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    88a2:	7e c6                	jle    886a <inv_mdct+0x13b>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    88a4:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    88ab:	eb 13                	jmp    88c0 <inv_mdct+0x191>
         win[3][i] =1.0;
    88ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    88b0:	83 c0 6c             	add    $0x6c,%eax
    88b3:	d9 e8                	fld1   
    88b5:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    88bc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    88c0:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    88c4:	7e e7                	jle    88ad <inv_mdct+0x17e>
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    88c6:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    88cd:	eb 2c                	jmp    88fb <inv_mdct+0x1cc>
         win[3][i] = sin( PI/36*(i+0.5) );
    88cf:	db 45 f4             	fildl  -0xc(%ebp)
    88d2:	dd 05 70 bd 00 00    	fldl   0xbd70
    88d8:	de c1                	faddp  %st,%st(1)
    88da:	dd 05 78 bd 00 00    	fldl   0xbd78
    88e0:	de c9                	fmulp  %st,%st(1)
    88e2:	dd 1c 24             	fstpl  (%esp)
    88e5:	e8 d2 a6 ff ff       	call   2fbc <sin>
    88ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    88ed:	83 c0 6c             	add    $0x6c,%eax
    88f0:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    88f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    88fb:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    88ff:	7e ce                	jle    88cf <inv_mdct+0x1a0>
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    8901:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8908:	eb 2c                	jmp    8936 <inv_mdct+0x207>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
    890a:	db 45 f4             	fildl  -0xc(%ebp)
    890d:	dd 05 70 bd 00 00    	fldl   0xbd70
    8913:	de c1                	faddp  %st,%st(1)
    8915:	dd 05 60 bd 00 00    	fldl   0xbd60
    891b:	de c9                	fmulp  %st,%st(1)
    891d:	dd 1c 24             	fstpl  (%esp)
    8920:	e8 97 a6 ff ff       	call   2fbc <sin>
    8925:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8928:	83 c0 48             	add    $0x48,%eax
    892b:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    8932:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8936:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    893a:	7e ce                	jle    890a <inv_mdct+0x1db>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    893c:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8943:	eb 13                	jmp    8958 <inv_mdct+0x229>
         win[2][i] = 0.0 ;
    8945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8948:	83 c0 48             	add    $0x48,%eax
    894b:	d9 ee                	fldz   
    894d:	dd 1c c5 80 d2 00 00 	fstpl  0xd280(,%eax,8)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    8954:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8958:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    895c:	7e e7                	jle    8945 <inv_mdct+0x216>
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    895e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8965:	eb 21                	jmp    8988 <inv_mdct+0x259>
         COS[i] = cos(PI/(2*36) * i);
    8967:	db 45 f4             	fildl  -0xc(%ebp)
    896a:	dd 05 90 bd 00 00    	fldl   0xbd90
    8970:	de c9                	fmulp  %st,%st(1)
    8972:	dd 1c 24             	fstpl  (%esp)
    8975:	e8 e1 a6 ff ff       	call   305b <cos>
    897a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    897d:	dd 1c c5 00 d7 00 00 	fstpl  0xd700(,%eax,8)
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    8984:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8988:	81 7d f4 8f 00 00 00 	cmpl   $0x8f,-0xc(%ebp)
    898f:	7e d6                	jle    8967 <inv_mdct+0x238>
         COS[i] = cos(PI/(2*36) * i);

      init++;
    8991:	a1 60 d2 00 00       	mov    0xd260,%eax
    8996:	83 c0 01             	add    $0x1,%eax
    8999:	a3 60 d2 00 00       	mov    %eax,0xd260
    }

    for(i=0;i<36;i++)
    899e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    89a5:	eb 17                	jmp    89be <inv_mdct+0x28f>
       out[i]=0;
    89a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    89aa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    89b1:	8b 45 0c             	mov    0xc(%ebp),%eax
    89b4:	01 d0                	add    %edx,%eax
    89b6:	d9 ee                	fldz   
    89b8:	dd 18                	fstpl  (%eax)
         COS[i] = cos(PI/(2*36) * i);

      init++;
    }

    for(i=0;i<36;i++)
    89ba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    89be:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    89c2:	7e e3                	jle    89a7 <inv_mdct+0x278>
       out[i]=0;

    if(block_type == 2){
    89c4:	83 7d 10 02          	cmpl   $0x2,0x10(%ebp)
    89c8:	0f 85 85 01 00 00    	jne    8b53 <inv_mdct+0x424>
       N=12;
    89ce:	c7 45 dc 0c 00 00 00 	movl   $0xc,-0x24(%ebp)
       for(i=0;i<3;i++){
    89d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    89dc:	e9 63 01 00 00       	jmp    8b44 <inv_mdct+0x415>
          for(p= 0;p<N;p++){
    89e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    89e8:	e9 df 00 00 00       	jmp    8acc <inv_mdct+0x39d>
             sum = 0.0;
    89ed:	d9 ee                	fldz   
    89ef:	dd 5d e0             	fstpl  -0x20(%ebp)
             for(m=0;m<N/2;m++)
    89f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    89f9:	e9 8f 00 00 00       	jmp    8a8d <inv_mdct+0x35e>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
    89fe:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8a01:	89 d0                	mov    %edx,%eax
    8a03:	01 c0                	add    %eax,%eax
    8a05:	01 c2                	add    %eax,%edx
    8a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8a0a:	01 d0                	add    %edx,%eax
    8a0c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8a13:	8b 45 08             	mov    0x8(%ebp),%eax
    8a16:	01 d0                	add    %edx,%eax
    8a18:	dd 00                	fldl   (%eax)
    8a1a:	dd 9d 68 ff ff ff    	fstpl  -0x98(%ebp)
    8a20:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8a23:	01 c0                	add    %eax,%eax
    8a25:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    8a2b:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    8a31:	dd 05 98 bd 00 00    	fldl   0xbd98
    8a37:	de f1                	fdivp  %st,%st(1)
    8a39:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8a3c:	01 c0                	add    %eax,%eax
    8a3e:	8d 50 01             	lea    0x1(%eax),%edx
    8a41:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8a44:	89 c1                	mov    %eax,%ecx
    8a46:	c1 e9 1f             	shr    $0x1f,%ecx
    8a49:	01 c8                	add    %ecx,%eax
    8a4b:	d1 f8                	sar    %eax
    8a4d:	01 d0                	add    %edx,%eax
    8a4f:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    8a55:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    8a5b:	de c9                	fmulp  %st,%st(1)
    8a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8a60:	01 c0                	add    %eax,%eax
    8a62:	83 c0 01             	add    $0x1,%eax
    8a65:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    8a6b:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    8a71:	de c9                	fmulp  %st,%st(1)
    8a73:	dd 1c 24             	fstpl  (%esp)
    8a76:	e8 e0 a5 ff ff       	call   305b <cos>
    8a7b:	dc 8d 68 ff ff ff    	fmull  -0x98(%ebp)
    8a81:	dd 45 e0             	fldl   -0x20(%ebp)
    8a84:	de c1                	faddp  %st,%st(1)
    8a86:	dd 5d e0             	fstpl  -0x20(%ebp)
    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
             sum = 0.0;
             for(m=0;m<N/2;m++)
    8a89:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8a8d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8a90:	89 c2                	mov    %eax,%edx
    8a92:	c1 ea 1f             	shr    $0x1f,%edx
    8a95:	01 d0                	add    %edx,%eax
    8a97:	d1 f8                	sar    %eax
    8a99:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    8a9c:	0f 8f 5c ff ff ff    	jg     89fe <inv_mdct+0x2cf>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
    8aa2:	8b 55 10             	mov    0x10(%ebp),%edx
    8aa5:	89 d0                	mov    %edx,%eax
    8aa7:	c1 e0 03             	shl    $0x3,%eax
    8aaa:	01 d0                	add    %edx,%eax
    8aac:	c1 e0 02             	shl    $0x2,%eax
    8aaf:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8ab2:	01 d0                	add    %edx,%eax
    8ab4:	dd 04 c5 80 d2 00 00 	fldl   0xd280(,%eax,8)
    8abb:	dc 4d e0             	fmull  -0x20(%ebp)
    8abe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8ac1:	dd 9c c5 78 ff ff ff 	fstpl  -0x88(%ebp,%eax,8)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
    8ac8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8acc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8acf:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    8ad2:	0f 8c 15 ff ff ff    	jl     89ed <inv_mdct+0x2be>
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    8ad8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8adf:	eb 57                	jmp    8b38 <inv_mdct+0x409>
             out[6*i+p+6] += tmp[p];
    8ae1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8ae4:	89 d0                	mov    %edx,%eax
    8ae6:	01 c0                	add    %eax,%eax
    8ae8:	01 d0                	add    %edx,%eax
    8aea:	01 c0                	add    %eax,%eax
    8aec:	89 c2                	mov    %eax,%edx
    8aee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8af1:	01 d0                	add    %edx,%eax
    8af3:	83 c0 06             	add    $0x6,%eax
    8af6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8afd:	8b 45 0c             	mov    0xc(%ebp),%eax
    8b00:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8b03:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8b06:	89 d0                	mov    %edx,%eax
    8b08:	01 c0                	add    %eax,%eax
    8b0a:	01 d0                	add    %edx,%eax
    8b0c:	01 c0                	add    %eax,%eax
    8b0e:	89 c2                	mov    %eax,%edx
    8b10:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b13:	01 d0                	add    %edx,%eax
    8b15:	83 c0 06             	add    $0x6,%eax
    8b18:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8b1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    8b22:	01 d0                	add    %edx,%eax
    8b24:	dd 00                	fldl   (%eax)
    8b26:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b29:	dd 84 c5 78 ff ff ff 	fldl   -0x88(%ebp,%eax,8)
    8b30:	de c1                	faddp  %st,%st(1)
    8b32:	dd 19                	fstpl  (%ecx)
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    8b34:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b3b:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    8b3e:	7c a1                	jl     8ae1 <inv_mdct+0x3b2>
    for(i=0;i<36;i++)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
    8b40:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8b44:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    8b48:	0f 8e 93 fe ff ff    	jle    89e1 <inv_mdct+0x2b2>
    8b4e:	e9 da 00 00 00       	jmp    8c2d <inv_mdct+0x4fe>
          for(p=0;p<N;p++)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
    8b53:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      for(p= 0;p<N;p++){
    8b5a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8b61:	e9 bb 00 00 00       	jmp    8c21 <inv_mdct+0x4f2>
         sum = 0.0;
    8b66:	d9 ee                	fldz   
    8b68:	dd 5d e0             	fstpl  -0x20(%ebp)
         for(m=0;m<N/2;m++)
    8b6b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8b72:	eb 6a                	jmp    8bde <inv_mdct+0x4af>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
    8b74:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8b77:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8b7e:	8b 45 08             	mov    0x8(%ebp),%eax
    8b81:	01 d0                	add    %edx,%eax
    8b83:	dd 00                	fldl   (%eax)
    8b85:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b88:	01 c0                	add    %eax,%eax
    8b8a:	8d 50 01             	lea    0x1(%eax),%edx
    8b8d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8b90:	89 c1                	mov    %eax,%ecx
    8b92:	c1 e9 1f             	shr    $0x1f,%ecx
    8b95:	01 c8                	add    %ecx,%eax
    8b97:	d1 f8                	sar    %eax
    8b99:	01 c2                	add    %eax,%edx
    8b9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8b9e:	01 c0                	add    %eax,%eax
    8ba0:	83 c0 01             	add    $0x1,%eax
    8ba3:	89 d1                	mov    %edx,%ecx
    8ba5:	0f af c8             	imul   %eax,%ecx
    8ba8:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8bad:	89 c8                	mov    %ecx,%eax
    8baf:	f7 ea                	imul   %edx
    8bb1:	c1 fa 05             	sar    $0x5,%edx
    8bb4:	89 c8                	mov    %ecx,%eax
    8bb6:	c1 f8 1f             	sar    $0x1f,%eax
    8bb9:	29 c2                	sub    %eax,%edx
    8bbb:	89 d0                	mov    %edx,%eax
    8bbd:	c1 e0 03             	shl    $0x3,%eax
    8bc0:	01 d0                	add    %edx,%eax
    8bc2:	c1 e0 04             	shl    $0x4,%eax
    8bc5:	29 c1                	sub    %eax,%ecx
    8bc7:	89 ca                	mov    %ecx,%edx
    8bc9:	dd 04 d5 00 d7 00 00 	fldl   0xd700(,%edx,8)
    8bd0:	de c9                	fmulp  %st,%st(1)
    8bd2:	dd 45 e0             	fldl   -0x20(%ebp)
    8bd5:	de c1                	faddp  %st,%st(1)
    8bd7:	dd 5d e0             	fstpl  -0x20(%ebp)
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
         sum = 0.0;
         for(m=0;m<N/2;m++)
    8bda:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8bde:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8be1:	89 c2                	mov    %eax,%edx
    8be3:	c1 ea 1f             	shr    $0x1f,%edx
    8be6:	01 d0                	add    %edx,%eax
    8be8:	d1 f8                	sar    %eax
    8bea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    8bed:	7f 85                	jg     8b74 <inv_mdct+0x445>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
    8bef:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8bf2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8bf9:	8b 45 0c             	mov    0xc(%ebp),%eax
    8bfc:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8bff:	8b 55 10             	mov    0x10(%ebp),%edx
    8c02:	89 d0                	mov    %edx,%eax
    8c04:	c1 e0 03             	shl    $0x3,%eax
    8c07:	01 d0                	add    %edx,%eax
    8c09:	c1 e0 02             	shl    $0x2,%eax
    8c0c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8c0f:	01 d0                	add    %edx,%eax
    8c11:	dd 04 c5 80 d2 00 00 	fldl   0xd280(,%eax,8)
    8c18:	dc 4d e0             	fmull  -0x20(%ebp)
    8c1b:	dd 19                	fstpl  (%ecx)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
    8c1d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8c21:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8c24:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    8c27:	0f 8c 39 ff ff ff    	jl     8b66 <inv_mdct+0x437>
         for(m=0;m<N/2;m++)
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
      }
    }
}
    8c2d:	c9                   	leave  
    8c2e:	c3                   	ret    

00008c2f <III_hybrid>:


void III_hybrid(double fsIn[SSLIMIT], double tsOut[SSLIMIT], int sb, int ch, struct gr_info_s *gr_info, struct frame_params *fr_ps)
/* fsIn:freq samples per subband in */
/* tsOut:time samples per subband out */
{
    8c2f:	55                   	push   %ebp
    8c30:	89 e5                	mov    %esp,%ebp
    8c32:	53                   	push   %ebx
    8c33:	81 ec 54 01 00 00    	sub    $0x154,%esp
   double rawout[36];
   static double prevblck[2][SBLIMIT][SSLIMIT];
   static int init = 1;
   int bt;

   if (init) {
    8c39:	a1 84 d1 00 00       	mov    0xd184,%eax
    8c3e:	85 c0                	test   %eax,%eax
    8c40:	74 6f                	je     8cb1 <III_hybrid+0x82>
      int i,j,k;

      for(i=0;i<2;i++)
    8c42:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8c49:	eb 56                	jmp    8ca1 <III_hybrid+0x72>
         for(j=0;j<SBLIMIT;j++)
    8c4b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8c52:	eb 43                	jmp    8c97 <III_hybrid+0x68>
            for(k=0;k<SSLIMIT;k++)
    8c54:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    8c5b:	eb 30                	jmp    8c8d <III_hybrid+0x5e>
               prevblck[i][j][k]=0.0;
    8c5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8c60:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    8c63:	89 c2                	mov    %eax,%edx
    8c65:	c1 e2 03             	shl    $0x3,%edx
    8c68:	01 c2                	add    %eax,%edx
    8c6a:	8d 04 12             	lea    (%edx,%edx,1),%eax
    8c6d:	89 c2                	mov    %eax,%edx
    8c6f:	89 c8                	mov    %ecx,%eax
    8c71:	c1 e0 03             	shl    $0x3,%eax
    8c74:	01 c8                	add    %ecx,%eax
    8c76:	c1 e0 06             	shl    $0x6,%eax
    8c79:	01 c2                	add    %eax,%edx
    8c7b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8c7e:	01 d0                	add    %edx,%eax
    8c80:	d9 ee                	fldz   
    8c82:	dd 1c c5 80 db 00 00 	fstpl  0xdb80(,%eax,8)
   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
    8c89:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    8c8d:	83 7d e8 11          	cmpl   $0x11,-0x18(%ebp)
    8c91:	7e ca                	jle    8c5d <III_hybrid+0x2e>

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
    8c93:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8c97:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
    8c9b:	7e b7                	jle    8c54 <III_hybrid+0x25>
   int bt;

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
    8c9d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8ca1:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    8ca5:	7e a4                	jle    8c4b <III_hybrid+0x1c>
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
    8ca7:	c7 05 84 d1 00 00 00 	movl   $0x0,0xd184
    8cae:	00 00 00 
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    8cb1:	8b 45 18             	mov    0x18(%ebp),%eax
    8cb4:	8b 40 10             	mov    0x10(%eax),%eax
    8cb7:	85 c0                	test   %eax,%eax
    8cb9:	74 10                	je     8ccb <III_hybrid+0x9c>
    8cbb:	8b 45 18             	mov    0x18(%ebp),%eax
    8cbe:	8b 40 18             	mov    0x18(%eax),%eax
    8cc1:	85 c0                	test   %eax,%eax
    8cc3:	74 06                	je     8ccb <III_hybrid+0x9c>
    8cc5:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
    8cc9:	7e 08                	jle    8cd3 <III_hybrid+0xa4>
          (sb < 2)) ? 0 : gr_info->block_type;
    8ccb:	8b 45 18             	mov    0x18(%ebp),%eax
    8cce:	8b 40 14             	mov    0x14(%eax),%eax
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    8cd1:	eb 05                	jmp    8cd8 <III_hybrid+0xa9>
    8cd3:	b8 00 00 00 00       	mov    $0x0,%eax
    8cd8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);
    8cdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8cde:	89 44 24 08          	mov    %eax,0x8(%esp)
    8ce2:	8d 85 c0 fe ff ff    	lea    -0x140(%ebp),%eax
    8ce8:	89 44 24 04          	mov    %eax,0x4(%esp)
    8cec:	8b 45 08             	mov    0x8(%ebp),%eax
    8cef:	89 04 24             	mov    %eax,(%esp)
    8cf2:	e8 38 fa ff ff       	call   872f <inv_mdct>

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    8cf7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8cfe:	e9 83 00 00 00       	jmp    8d86 <III_hybrid+0x157>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
    8d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d06:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
    8d10:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d16:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    8d1d:	8b 45 10             	mov    0x10(%ebp),%eax
    8d20:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8d23:	89 c2                	mov    %eax,%edx
    8d25:	c1 e2 03             	shl    $0x3,%edx
    8d28:	01 c2                	add    %eax,%edx
    8d2a:	8d 04 12             	lea    (%edx,%edx,1),%eax
    8d2d:	89 c2                	mov    %eax,%edx
    8d2f:	89 c8                	mov    %ecx,%eax
    8d31:	c1 e0 03             	shl    $0x3,%eax
    8d34:	01 c8                	add    %ecx,%eax
    8d36:	c1 e0 06             	shl    $0x6,%eax
    8d39:	01 c2                	add    %eax,%edx
    8d3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d3e:	01 d0                	add    %edx,%eax
    8d40:	dd 04 c5 80 db 00 00 	fldl   0xdb80(,%eax,8)
    8d47:	de c1                	faddp  %st,%st(1)
    8d49:	dd 1b                	fstpl  (%ebx)
      prevblck[ch][sb][ss] = rawout[ss+18];
    8d4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d4e:	83 c0 12             	add    $0x12,%eax
    8d51:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    8d58:	8b 45 10             	mov    0x10(%ebp),%eax
    8d5b:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8d5e:	89 c2                	mov    %eax,%edx
    8d60:	c1 e2 03             	shl    $0x3,%edx
    8d63:	01 c2                	add    %eax,%edx
    8d65:	8d 04 12             	lea    (%edx,%edx,1),%eax
    8d68:	89 c2                	mov    %eax,%edx
    8d6a:	89 c8                	mov    %ecx,%eax
    8d6c:	c1 e0 03             	shl    $0x3,%eax
    8d6f:	01 c8                	add    %ecx,%eax
    8d71:	c1 e0 06             	shl    $0x6,%eax
    8d74:	01 c2                	add    %eax,%edx
    8d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d79:	01 d0                	add    %edx,%eax
    8d7b:	dd 1c c5 80 db 00 00 	fstpl  0xdb80(,%eax,8)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    8d82:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8d86:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    8d8a:	0f 8e 73 ff ff ff    	jle    8d03 <III_hybrid+0xd4>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
      prevblck[ch][sb][ss] = rawout[ss+18];
   }
}
    8d90:	81 c4 54 01 00 00    	add    $0x154,%esp
    8d96:	5b                   	pop    %ebx
    8d97:	5d                   	pop    %ebp
    8d98:	c3                   	ret    

00008d99 <create_syn_filter>:


/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
    8d99:	55                   	push   %ebp
    8d9a:	89 e5                	mov    %esp,%ebp
    8d9c:	57                   	push   %edi
    8d9d:	56                   	push   %esi
    8d9e:	53                   	push   %ebx
    8d9f:	83 ec 1c             	sub    $0x1c,%esp
	register int i,k;

	for (i=0; i<64; i++)
    8da2:	be 00 00 00 00       	mov    $0x0,%esi
    8da7:	e9 1c 01 00 00       	jmp    8ec8 <create_syn_filter+0x12f>
		for (k=0; k<32; k++) {
    8dac:	bb 00 00 00 00       	mov    $0x0,%ebx
    8db1:	e9 06 01 00 00       	jmp    8ebc <create_syn_filter+0x123>
			if ((filter[i][k] = 1e9*cos((double)((PI64*i+PI4)*(2*k+1)))) >= 0)
    8db6:	89 f0                	mov    %esi,%eax
    8db8:	c1 e0 08             	shl    $0x8,%eax
    8dbb:	89 c2                	mov    %eax,%edx
    8dbd:	8b 45 08             	mov    0x8(%ebp),%eax
    8dc0:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    8dc3:	89 75 e0             	mov    %esi,-0x20(%ebp)
    8dc6:	db 45 e0             	fildl  -0x20(%ebp)
    8dc9:	dd 05 a0 bd 00 00    	fldl   0xbda0
    8dcf:	de c9                	fmulp  %st,%st(1)
    8dd1:	dd 05 a8 bd 00 00    	fldl   0xbda8
    8dd7:	de c1                	faddp  %st,%st(1)
    8dd9:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
    8ddc:	83 c0 01             	add    $0x1,%eax
    8ddf:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8de2:	db 45 e0             	fildl  -0x20(%ebp)
    8de5:	de c9                	fmulp  %st,%st(1)
    8de7:	dd 1c 24             	fstpl  (%esp)
    8dea:	e8 6c a2 ff ff       	call   305b <cos>
    8def:	dd 05 b0 bd 00 00    	fldl   0xbdb0
    8df5:	de c9                	fmulp  %st,%st(1)
    8df7:	dd 1c df             	fstpl  (%edi,%ebx,8)
    8dfa:	dd 04 df             	fldl   (%edi,%ebx,8)
    8dfd:	d9 ee                	fldz   
    8dff:	d9 c9                	fxch   %st(1)
    8e01:	df e9                	fucomip %st(1),%st
    8e03:	dd d8                	fstp   %st(0)
    8e05:	72 47                	jb     8e4e <create_syn_filter+0xb5>
				filter[i][k] = (int)(filter[i][k]+0.5);
    8e07:	89 f0                	mov    %esi,%eax
    8e09:	c1 e0 08             	shl    $0x8,%eax
    8e0c:	89 c2                	mov    %eax,%edx
    8e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    8e11:	01 c2                	add    %eax,%edx
    8e13:	89 f0                	mov    %esi,%eax
    8e15:	c1 e0 08             	shl    $0x8,%eax
    8e18:	89 c1                	mov    %eax,%ecx
    8e1a:	8b 45 08             	mov    0x8(%ebp),%eax
    8e1d:	01 c8                	add    %ecx,%eax
    8e1f:	dd 04 d8             	fldl   (%eax,%ebx,8)
    8e22:	dd 05 70 bd 00 00    	fldl   0xbd70
    8e28:	de c1                	faddp  %st,%st(1)
    8e2a:	d9 7d e6             	fnstcw -0x1a(%ebp)
    8e2d:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    8e31:	b4 0c                	mov    $0xc,%ah
    8e33:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    8e37:	d9 6d e4             	fldcw  -0x1c(%ebp)
    8e3a:	db 5d e0             	fistpl -0x20(%ebp)
    8e3d:	d9 6d e6             	fldcw  -0x1a(%ebp)
    8e40:	8b 45 e0             	mov    -0x20(%ebp),%eax
    8e43:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8e46:	db 45 e0             	fildl  -0x20(%ebp)
    8e49:	dd 1c da             	fstpl  (%edx,%ebx,8)
    8e4c:	eb 45                	jmp    8e93 <create_syn_filter+0xfa>
				//modf(filter[i][k]+0.5, &filter[i][k]);
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
    8e4e:	89 f0                	mov    %esi,%eax
    8e50:	c1 e0 08             	shl    $0x8,%eax
    8e53:	89 c2                	mov    %eax,%edx
    8e55:	8b 45 08             	mov    0x8(%ebp),%eax
    8e58:	01 c2                	add    %eax,%edx
    8e5a:	89 f0                	mov    %esi,%eax
    8e5c:	c1 e0 08             	shl    $0x8,%eax
    8e5f:	89 c1                	mov    %eax,%ecx
    8e61:	8b 45 08             	mov    0x8(%ebp),%eax
    8e64:	01 c8                	add    %ecx,%eax
    8e66:	dd 04 d8             	fldl   (%eax,%ebx,8)
    8e69:	dd 05 70 bd 00 00    	fldl   0xbd70
    8e6f:	de e9                	fsubrp %st,%st(1)
    8e71:	d9 7d e6             	fnstcw -0x1a(%ebp)
    8e74:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    8e78:	b4 0c                	mov    $0xc,%ah
    8e7a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    8e7e:	d9 6d e4             	fldcw  -0x1c(%ebp)
    8e81:	db 5d e0             	fistpl -0x20(%ebp)
    8e84:	d9 6d e6             	fldcw  -0x1a(%ebp)
    8e87:	8b 45 e0             	mov    -0x20(%ebp),%eax
    8e8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8e8d:	db 45 e0             	fildl  -0x20(%ebp)
    8e90:	dd 1c da             	fstpl  (%edx,%ebx,8)
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
    8e93:	89 f0                	mov    %esi,%eax
    8e95:	c1 e0 08             	shl    $0x8,%eax
    8e98:	89 c2                	mov    %eax,%edx
    8e9a:	8b 45 08             	mov    0x8(%ebp),%eax
    8e9d:	01 d0                	add    %edx,%eax
    8e9f:	89 f2                	mov    %esi,%edx
    8ea1:	89 d1                	mov    %edx,%ecx
    8ea3:	c1 e1 08             	shl    $0x8,%ecx
    8ea6:	8b 55 08             	mov    0x8(%ebp),%edx
    8ea9:	01 ca                	add    %ecx,%edx
    8eab:	dd 04 da             	fldl   (%edx,%ebx,8)
    8eae:	dd 05 b8 bd 00 00    	fldl   0xbdb8
    8eb4:	de c9                	fmulp  %st,%st(1)
    8eb6:	dd 1c d8             	fstpl  (%eax,%ebx,8)
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
		for (k=0; k<32; k++) {
    8eb9:	83 c3 01             	add    $0x1,%ebx
    8ebc:	83 fb 1f             	cmp    $0x1f,%ebx
    8ebf:	0f 8e f1 fe ff ff    	jle    8db6 <create_syn_filter+0x1d>
/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
    8ec5:	83 c6 01             	add    $0x1,%esi
    8ec8:	83 fe 3f             	cmp    $0x3f,%esi
    8ecb:	0f 8e db fe ff ff    	jle    8dac <create_syn_filter+0x13>
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
		}
}
    8ed1:	83 c4 1c             	add    $0x1c,%esp
    8ed4:	5b                   	pop    %ebx
    8ed5:	5e                   	pop    %esi
    8ed6:	5f                   	pop    %edi
    8ed7:	5d                   	pop    %ebp
    8ed8:	c3                   	ret    

00008ed9 <read_syn_window>:



/* read in synthesis window */
void read_syn_window(double window[HAN_SIZE])
{
    8ed9:	55                   	push   %ebp
    8eda:	89 e5                	mov    %esp,%ebp
    8edc:	57                   	push   %edi
    8edd:	56                   	push   %esi
    8ede:	53                   	push   %ebx
    8edf:	81 ec 14 10 00 00    	sub    $0x1014,%esp
	double gb_window[HAN_SIZE] = {0.0000000000, -0.0000152590, -0.0000152590, -0.0000152590,
    8ee5:	8d 95 e8 ef ff ff    	lea    -0x1018(%ebp),%edx
    8eeb:	bb 20 ad 00 00       	mov    $0xad20,%ebx
    8ef0:	b8 00 04 00 00       	mov    $0x400,%eax
    8ef5:	89 d7                	mov    %edx,%edi
    8ef7:	89 de                	mov    %ebx,%esi
    8ef9:	89 c1                	mov    %eax,%ecx
    8efb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		0.0000762940, 0.0000762940, 0.0000610350, 0.0000610350,
		0.0000457760, 0.0000457760, 0.0000305180, 0.0000305180,
		0.0000305180, 0.0000305180, 0.0000152590, 0.0000152590,
		0.0000152590, 0.0000152590, 0.0000152590, 0.0000152590,
	};
	window = gb_window;
    8efd:	8d 85 e8 ef ff ff    	lea    -0x1018(%ebp),%eax
    8f03:	89 45 ec             	mov    %eax,-0x14(%ebp)
}
    8f06:	81 c4 14 10 00 00    	add    $0x1014,%esp
    8f0c:	5b                   	pop    %ebx
    8f0d:	5e                   	pop    %esi
    8f0e:	5f                   	pop    %edi
    8f0f:	5d                   	pop    %ebp
    8f10:	c3                   	ret    

00008f11 <SubBandSynthesis>:

int SubBandSynthesis (double *bandPtr, int channel, short *samples)
{
    8f11:	55                   	push   %ebp
    8f12:	89 e5                	mov    %esp,%ebp
    8f14:	57                   	push   %edi
    8f15:	56                   	push   %esi
    8f16:	53                   	push   %ebx
    8f17:	83 ec 2c             	sub    $0x2c,%esp
	static NN *filter;
	typedef double BB[2][2*HAN_SIZE];
	static BB *buf;
	static int bufOffset[2] = {64,64};
	static double *window;
	int clip = 0;               /* count & return how many samples clipped */
    8f1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	if (init) {
    8f21:	a1 88 d1 00 00       	mov    0xd188,%eax
    8f26:	85 c0                	test   %eax,%eax
    8f28:	74 6f                	je     8f99 <SubBandSynthesis+0x88>
		buf = (BB *) mem_alloc(sizeof(BB),"BB");
    8f2a:	c7 44 24 04 20 bd 00 	movl   $0xbd20,0x4(%esp)
    8f31:	00 
    8f32:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    8f39:	e8 15 a8 ff ff       	call   3753 <mem_alloc>
    8f3e:	a3 80 ff 00 00       	mov    %eax,0xff80
		filter = (NN *) mem_alloc(sizeof(NN), "NN");
    8f43:	c7 44 24 04 23 bd 00 	movl   $0xbd23,0x4(%esp)
    8f4a:	00 
    8f4b:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    8f52:	e8 fc a7 ff ff       	call   3753 <mem_alloc>
    8f57:	a3 84 ff 00 00       	mov    %eax,0xff84
		create_syn_filter(*filter);
    8f5c:	a1 84 ff 00 00       	mov    0xff84,%eax
    8f61:	89 04 24             	mov    %eax,(%esp)
    8f64:	e8 30 fe ff ff       	call   8d99 <create_syn_filter>
		window = (double *) mem_alloc(sizeof(double) * HAN_SIZE, "WIN");
    8f69:	c7 44 24 04 26 bd 00 	movl   $0xbd26,0x4(%esp)
    8f70:	00 
    8f71:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    8f78:	e8 d6 a7 ff ff       	call   3753 <mem_alloc>
    8f7d:	a3 88 ff 00 00       	mov    %eax,0xff88
		read_syn_window(window);
    8f82:	a1 88 ff 00 00       	mov    0xff88,%eax
    8f87:	89 04 24             	mov    %eax,(%esp)
    8f8a:	e8 4a ff ff ff       	call   8ed9 <read_syn_window>
		init = 0;
    8f8f:	c7 05 88 d1 00 00 00 	movl   $0x0,0xd188
    8f96:	00 00 00 
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    8f99:	8b 45 0c             	mov    0xc(%ebp),%eax
    8f9c:	8b 04 85 8c d1 00 00 	mov    0xd18c(,%eax,4),%eax
    8fa3:	83 e8 40             	sub    $0x40,%eax
    8fa6:	25 ff 03 00 00       	and    $0x3ff,%eax
    8fab:	89 c2                	mov    %eax,%edx
    8fad:	8b 45 0c             	mov    0xc(%ebp),%eax
    8fb0:	89 14 85 8c d1 00 00 	mov    %edx,0xd18c(,%eax,4)
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);
    8fb7:	8b 15 80 ff 00 00    	mov    0xff80,%edx
    8fbd:	8b 45 0c             	mov    0xc(%ebp),%eax
    8fc0:	8b 04 85 8c d1 00 00 	mov    0xd18c(,%eax,4),%eax
    8fc7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    8fca:	c1 e1 0a             	shl    $0xa,%ecx
    8fcd:	01 c8                	add    %ecx,%eax
    8fcf:	c1 e0 03             	shl    $0x3,%eax
    8fd2:	8d 3c 02             	lea    (%edx,%eax,1),%edi

	for (i=0; i<64; i++) {
    8fd5:	bb 00 00 00 00       	mov    $0x0,%ebx
    8fda:	eb 40                	jmp    901c <SubBandSynthesis+0x10b>
		sum = 0;
    8fdc:	d9 ee                	fldz   
		for (k=0; k<32; k++)
    8fde:	be 00 00 00 00       	mov    $0x0,%esi
    8fe3:	eb 26                	jmp    900b <SubBandSynthesis+0xfa>
			sum += bandPtr[k] * (*filter)[i][k];
    8fe5:	89 f0                	mov    %esi,%eax
    8fe7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8fee:	8b 45 08             	mov    0x8(%ebp),%eax
    8ff1:	01 d0                	add    %edx,%eax
    8ff3:	dd 00                	fldl   (%eax)
    8ff5:	a1 84 ff 00 00       	mov    0xff84,%eax
    8ffa:	89 da                	mov    %ebx,%edx
    8ffc:	c1 e2 05             	shl    $0x5,%edx
    8fff:	01 f2                	add    %esi,%edx
    9001:	dd 04 d0             	fldl   (%eax,%edx,8)
    9004:	de c9                	fmulp  %st,%st(1)
    9006:	de c1                	faddp  %st,%st(1)
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
		sum = 0;
		for (k=0; k<32; k++)
    9008:	83 c6 01             	add    $0x1,%esi
    900b:	83 fe 1f             	cmp    $0x1f,%esi
    900e:	7e d5                	jle    8fe5 <SubBandSynthesis+0xd4>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
    9010:	89 d8                	mov    %ebx,%eax
    9012:	c1 e0 03             	shl    $0x3,%eax
    9015:	01 f8                	add    %edi,%eax
    9017:	dd 18                	fstpl  (%eax)
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
    9019:	83 c3 01             	add    $0x1,%ebx
    901c:	83 fb 3f             	cmp    $0x3f,%ebx
    901f:	7e bb                	jle    8fdc <SubBandSynthesis+0xcb>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    9021:	bf 00 00 00 00       	mov    $0x0,%edi
    9026:	e9 c7 00 00 00       	jmp    90f2 <SubBandSynthesis+0x1e1>
		sum = 0;
    902b:	d9 ee                	fldz   
		for (i=0; i<16; i++) {
    902d:	bb 00 00 00 00       	mov    $0x0,%ebx
    9032:	eb 4c                	jmp    9080 <SubBandSynthesis+0x16f>
			k = j + (i<<5);
    9034:	89 d8                	mov    %ebx,%eax
    9036:	c1 e0 05             	shl    $0x5,%eax
    9039:	8d 34 38             	lea    (%eax,%edi,1),%esi
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    903c:	a1 88 ff 00 00       	mov    0xff88,%eax
    9041:	89 f2                	mov    %esi,%edx
    9043:	c1 e2 03             	shl    $0x3,%edx
    9046:	01 d0                	add    %edx,%eax
    9048:	dd 00                	fldl   (%eax)
    904a:	a1 80 ff 00 00       	mov    0xff80,%eax
    904f:	8d 53 01             	lea    0x1(%ebx),%edx
    9052:	d1 fa                	sar    %edx
    9054:	c1 e2 06             	shl    $0x6,%edx
    9057:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
												bufOffset[channel]) & 0x3ff];
    905a:	8b 55 0c             	mov    0xc(%ebp),%edx
    905d:	8b 14 95 8c d1 00 00 	mov    0xd18c(,%edx,4),%edx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    9064:	01 ca                	add    %ecx,%edx
												bufOffset[channel]) & 0x3ff];
    9066:	89 d1                	mov    %edx,%ecx
    9068:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    906e:	8b 55 0c             	mov    0xc(%ebp),%edx
    9071:	c1 e2 0a             	shl    $0xa,%edx
    9074:	01 ca                	add    %ecx,%edx
    9076:	dd 04 d0             	fldl   (%eax,%edx,8)
    9079:	de c9                	fmulp  %st,%st(1)
    907b:	de c1                	faddp  %st,%st(1)
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
    907d:	83 c3 01             	add    $0x1,%ebx
    9080:	83 fb 0f             	cmp    $0xf,%ebx
    9083:	7e af                	jle    9034 <SubBandSynthesis+0x123>
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
												bufOffset[channel]) & 0x3ff];
		}
		{
			/*long foo = (sum > 0) ? sum * SCALE + 0.5 : sum * SCALE - 0.5; */
			long foo = sum * SCALE;
    9085:	dd 05 c0 bd 00 00    	fldl   0xbdc0
    908b:	de c9                	fmulp  %st,%st(1)
    908d:	d9 7d d6             	fnstcw -0x2a(%ebp)
    9090:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    9094:	b4 0c                	mov    $0xc,%ah
    9096:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    909a:	d9 6d d4             	fldcw  -0x2c(%ebp)
    909d:	db 5d e0             	fistpl -0x20(%ebp)
    90a0:	d9 6d d6             	fldcw  -0x2a(%ebp)
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
    90a3:	81 7d e0 ff 7f 00 00 	cmpl   $0x7fff,-0x20(%ebp)
    90aa:	7e 15                	jle    90c1 <SubBandSynthesis+0x1b0>
    90ac:	89 f8                	mov    %edi,%eax
    90ae:	8d 14 00             	lea    (%eax,%eax,1),%edx
    90b1:	8b 45 10             	mov    0x10(%ebp),%eax
    90b4:	01 d0                	add    %edx,%eax
    90b6:	66 c7 00 ff 7f       	movw   $0x7fff,(%eax)
    90bb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    90bf:	eb 2e                	jmp    90ef <SubBandSynthesis+0x1de>
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
    90c1:	81 7d e0 00 80 ff ff 	cmpl   $0xffff8000,-0x20(%ebp)
    90c8:	7d 15                	jge    90df <SubBandSynthesis+0x1ce>
    90ca:	89 f8                	mov    %edi,%eax
    90cc:	8d 14 00             	lea    (%eax,%eax,1),%edx
    90cf:	8b 45 10             	mov    0x10(%ebp),%eax
    90d2:	01 d0                	add    %edx,%eax
    90d4:	66 c7 00 00 80       	movw   $0x8000,(%eax)
    90d9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    90dd:	eb 10                	jmp    90ef <SubBandSynthesis+0x1de>
			else                           samples[j] = foo;
    90df:	89 f8                	mov    %edi,%eax
    90e1:	8d 14 00             	lea    (%eax,%eax,1),%edx
    90e4:	8b 45 10             	mov    0x10(%ebp),%eax
    90e7:	01 c2                	add    %eax,%edx
    90e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    90ec:	66 89 02             	mov    %ax,(%edx)
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    90ef:	83 c7 01             	add    $0x1,%edi
    90f2:	83 ff 1f             	cmp    $0x1f,%edi
    90f5:	0f 8e 30 ff ff ff    	jle    902b <SubBandSynthesis+0x11a>
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
			else                           samples[j] = foo;
		}
	}
    return(clip);
    90fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    90fe:	83 c4 2c             	add    $0x2c,%esp
    9101:	5b                   	pop    %ebx
    9102:	5e                   	pop    %esi
    9103:	5f                   	pop    %edi
    9104:	5d                   	pop    %ebp
    9105:	c3                   	ret    

00009106 <out_fifo>:

void out_fifo(short pcm_sample[2][SSLIMIT][SBLIMIT], int num, struct frame_params *fr_ps, unsigned long *psampFrames)
{
    9106:	55                   	push   %ebp
    9107:	89 e5                	mov    %esp,%ebp
    9109:	83 ec 10             	sub    $0x10,%esp
	int i,j,l;
	int stereo = fr_ps->stereo;
    910c:	8b 45 10             	mov    0x10(%ebp),%eax
    910f:	8b 40 08             	mov    0x8(%eax),%eax
    9112:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    9115:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    911c:	eb 75                	jmp    9193 <out_fifo+0x8d>
    911e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    9125:	eb 62                	jmp    9189 <out_fifo+0x83>
            (*psampFrames)++;
    9127:	8b 45 14             	mov    0x14(%ebp),%eax
    912a:	8b 00                	mov    (%eax),%eax
    912c:	8d 50 01             	lea    0x1(%eax),%edx
    912f:	8b 45 14             	mov    0x14(%ebp),%eax
    9132:	89 10                	mov    %edx,(%eax)
            for (l=0;l<stereo;l++) {
    9134:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    913b:	eb 40                	jmp    917d <out_fifo+0x77>
                if (!(k%1600) && k) {
    913d:	8b 0d 8c ff 00 00    	mov    0xff8c,%ecx
    9143:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    9148:	89 c8                	mov    %ecx,%eax
    914a:	f7 ea                	imul   %edx
    914c:	c1 fa 09             	sar    $0x9,%edx
    914f:	89 c8                	mov    %ecx,%eax
    9151:	c1 f8 1f             	sar    $0x1f,%eax
    9154:	29 c2                	sub    %eax,%edx
    9156:	89 d0                	mov    %edx,%eax
    9158:	69 c0 40 06 00 00    	imul   $0x640,%eax,%eax
    915e:	29 c1                	sub    %eax,%ecx
    9160:	89 c8                	mov    %ecx,%eax
    9162:	85 c0                	test   %eax,%eax
    9164:	75 13                	jne    9179 <out_fifo+0x73>
    9166:	a1 8c ff 00 00       	mov    0xff8c,%eax
    916b:	85 c0                	test   %eax,%eax
    916d:	74 0a                	je     9179 <out_fifo+0x73>
                    //fwrite(outsamp,2,1600,outFile);
                    k = 0;
    916f:	c7 05 8c ff 00 00 00 	movl   $0x0,0xff8c
    9176:	00 00 00 
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
            (*psampFrames)++;
            for (l=0;l<stereo;l++) {
    9179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    917d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9180:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    9183:	7c b8                	jl     913d <out_fifo+0x37>
	int i,j,l;
	int stereo = fr_ps->stereo;
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    9185:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    9189:	83 7d f8 1f          	cmpl   $0x1f,-0x8(%ebp)
    918d:	7e 98                	jle    9127 <out_fifo+0x21>
    918f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    9193:	8b 45 fc             	mov    -0x4(%ebp),%eax
    9196:	3b 45 0c             	cmp    0xc(%ebp),%eax
    9199:	7c 83                	jl     911e <out_fifo+0x18>
                    k = 0;
                }
                //outsamp[k++] = pcm_sample[l][i][j];
            }
        }
}
    919b:	c9                   	leave  
    919c:	c3                   	ret    

0000919d <buffer_CRC>:


void  buffer_CRC(Bit_stream_struc *bs, unsigned int *old_crc)
{
    919d:	55                   	push   %ebp
    919e:	89 e5                	mov    %esp,%ebp
    91a0:	83 ec 18             	sub    $0x18,%esp
    *old_crc = getbits(bs, 16);
    91a3:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    91aa:	00 
    91ab:	8b 45 08             	mov    0x8(%ebp),%eax
    91ae:	89 04 24             	mov    %eax,(%esp)
    91b1:	e8 8b a8 ff ff       	call   3a41 <getbits>
    91b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    91b9:	89 02                	mov    %eax,(%edx)
}
    91bb:	c9                   	leave  
    91bc:	c3                   	ret    

000091bd <main_data_slots>:

extern int bitrate[3][15];
extern double s_freq[4];
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
    91bd:	55                   	push   %ebp
    91be:	89 e5                	mov    %esp,%ebp
    91c0:	83 ec 18             	sub    $0x18,%esp
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    91c3:	8b 45 08             	mov    0x8(%ebp),%eax
    91c6:	8b 40 0c             	mov    0xc(%eax),%eax
    91c9:	83 c0 1e             	add    $0x1e,%eax
    91cc:	8b 14 85 e0 cc 00 00 	mov    0xcce0(,%eax,4),%edx
    91d3:	89 d0                	mov    %edx,%eax
    91d5:	c1 e0 03             	shl    $0x3,%eax
    91d8:	01 d0                	add    %edx,%eax
    91da:	c1 e0 04             	shl    $0x4,%eax
			/ s_freq[fr_ps.header->sampling_frequency];
    91dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    91e0:	db 45 ec             	fildl  -0x14(%ebp)
    91e3:	8b 45 08             	mov    0x8(%ebp),%eax
    91e6:	8b 40 10             	mov    0x10(%eax),%eax
    91e9:	dd 04 c5 a0 cd 00 00 	fldl   0xcda0(,%eax,8)
    91f0:	de f9                	fdivrp %st,%st(1)
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    91f2:	d9 7d ea             	fnstcw -0x16(%ebp)
    91f5:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
    91f9:	b4 0c                	mov    $0xc,%ah
    91fb:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
    91ff:	d9 6d e8             	fldcw  -0x18(%ebp)
    9202:	db 5d fc             	fistpl -0x4(%ebp)
    9205:	d9 6d ea             	fldcw  -0x16(%ebp)
			/ s_freq[fr_ps.header->sampling_frequency];
	if (fr_ps.header->padding) nSlots++;
    9208:	8b 45 08             	mov    0x8(%ebp),%eax
    920b:	8b 40 14             	mov    0x14(%eax),%eax
    920e:	85 c0                	test   %eax,%eax
    9210:	74 04                	je     9216 <main_data_slots+0x59>
    9212:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	nSlots -= 4;
    9216:	83 6d fc 04          	subl   $0x4,-0x4(%ebp)
	if (fr_ps.header->error_protection)
    921a:	8b 45 08             	mov    0x8(%ebp),%eax
    921d:	8b 40 08             	mov    0x8(%eax),%eax
    9220:	85 c0                	test   %eax,%eax
    9222:	74 04                	je     9228 <main_data_slots+0x6b>
		nSlots -= 2;
    9224:	83 6d fc 02          	subl   $0x2,-0x4(%ebp)
	if (fr_ps.stereo == 1)
    9228:	8b 45 10             	mov    0x10(%ebp),%eax
    922b:	83 f8 01             	cmp    $0x1,%eax
    922e:	75 06                	jne    9236 <main_data_slots+0x79>
		nSlots -= 17;
    9230:	83 6d fc 11          	subl   $0x11,-0x4(%ebp)
    9234:	eb 04                	jmp    923a <main_data_slots+0x7d>
	else
		nSlots -=32;
    9236:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)
	return(nSlots);
    923a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    923d:	c9                   	leave  
    923e:	c3                   	ret    
