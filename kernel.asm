
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp
8010002d:	b8 a0 2e 10 80       	mov    $0x80102ea0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 20 72 10 80       	push   $0x80107220
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 a5 42 00 00       	call   80104300 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 72 10 80       	push   $0x80107227
80100097:	50                   	push   %eax
80100098:	e8 33 41 00 00       	call   801041d0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 87 43 00 00       	call   80104470 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 99 44 00 00       	call   80104600 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 9e 40 00 00       	call   80104210 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 9d 1f 00 00       	call   80102120 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 2e 72 10 80       	push   $0x8010722e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 fd 40 00 00       	call   801042b0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 3f 72 10 80       	push   $0x8010723f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 bc 40 00 00       	call   801042b0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 6c 40 00 00       	call   80104270 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 60 42 00 00       	call   80104470 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 9f 43 00 00       	jmp    80104600 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 72 10 80       	push   $0x80107246
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 db 14 00 00       	call   80101760 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 df 41 00 00       	call   80104470 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002a7:	39 15 c4 ff 10 80    	cmp    %edx,0x8010ffc4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 c0 ff 10 80       	push   $0x8010ffc0
801002c5:	e8 b6 3a 00 00       	call   80103d80 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 c0 ff 10 80    	mov    0x8010ffc0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 c4 ff 10 80    	cmp    0x8010ffc4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 00 35 00 00       	call   801037e0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 0c 43 00 00       	call   80104600 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 84 13 00 00       	call   80101680 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 40 ff 10 80 	movsbl -0x7fef00c0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 ae 42 00 00       	call   80104600 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 26 13 00 00       	call   80101680 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 82 23 00 00       	call   80102730 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 4d 72 10 80       	push   $0x8010724d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 ab 7b 10 80 	movl   $0x80107bab,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 73 3f 00 00       	call   80104350 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 61 72 10 80       	push   $0x80107261
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 e1 59 00 00       	call   80105e20 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 2f 59 00 00       	call   80105e20 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 23 59 00 00       	call   80105e20 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 17 59 00 00       	call   80105e20 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 37 42 00 00       	call   80104760 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 6a 41 00 00       	call   801046b0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 65 72 10 80       	push   $0x80107265
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 90 72 10 80 	movzbl -0x7fef8d70(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 4c 11 00 00       	call   80101760 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 50 3e 00 00       	call   80104470 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 b4 3f 00 00       	call   80104600 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 2b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 dc 3e 00 00       	call   80104600 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 78 72 10 80       	mov    $0x80107278,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 7b 3c 00 00       	call   80104470 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 7f 72 10 80       	push   $0x8010727f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 48 3c 00 00       	call   80104470 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100856:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 73 3d 00 00       	call   80104600 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
80100911:	68 c0 ff 10 80       	push   $0x8010ffc0
80100916:	e8 15 36 00 00       	call   80103f30 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010093d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100964:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 74 36 00 00       	jmp    80104010 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 88 72 10 80       	push   $0x80107288
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 2b 39 00 00       	call   80104300 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 d2 18 00 00       	call   801022d0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 bf 2d 00 00       	call   801037e0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 74 21 00 00       	call   80102ba0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 a9 14 00 00       	call   80101ee0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 33 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 02 0f 00 00       	call   80101960 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 a1 0e 00 00       	call   80101910 <iunlockput>
    end_op();
80100a6f:	e8 9c 21 00 00       	call   80102c10 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 d7 64 00 00       	call   80106f70 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8c 02 00 00    	je     80100d4b <exec+0x33b>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 95 62 00 00       	call   80106d90 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 a3 61 00 00       	call   80106cd0 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 03 0e 00 00       	call   80101960 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 79 63 00 00       	call   80106ef0 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 76 0d 00 00       	call   80101910 <iunlockput>
  end_op();
80100b9a:	e8 71 20 00 00       	call   80102c10 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 e1 61 00 00       	call   80106d90 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 2a 63 00 00       	call   80106ef0 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 38 20 00 00       	call   80102c10 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 a1 72 10 80       	push   $0x801072a1
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 05 64 00 00       	call   80107010 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 92 3c 00 00       	call   801048d0 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 7f 3c 00 00       	call   801048d0 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 0e 65 00 00       	call   80107170 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 a4 64 00 00       	call   80107170 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 81 3b 00 00       	call   80104890 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d31:	89 0c 24             	mov    %ecx,(%esp)
80100d34:	e8 07 5e 00 00       	call   80106b40 <switchuvm>
  freevm(oldpgdir);
80100d39:	89 3c 24             	mov    %edi,(%esp)
80100d3c:	e8 af 61 00 00       	call   80106ef0 <freevm>
  return 0;
80100d41:	83 c4 10             	add    $0x10,%esp
80100d44:	31 c0                	xor    %eax,%eax
80100d46:	e9 31 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d50:	e9 3c fe ff ff       	jmp    80100b91 <exec+0x181>
80100d55:	66 90                	xchg   %ax,%ax
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 ad 72 10 80       	push   $0x801072ad
80100d6b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d70:	e8 8b 35 00 00       	call   80104300 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d91:	e8 da 36 00 00       	call   80104470 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dc1:	e8 3a 38 00 00       	call   80104600 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dda:	e8 21 38 00 00       	call   80104600 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dff:	e8 6c 36 00 00       	call   80104470 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e1c:	e8 df 37 00 00       	call   80104600 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 b4 72 10 80       	push   $0x801072b4
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e51:	e8 1a 36 00 00       	call   80104470 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 7f 37 00 00       	jmp    80104600 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 e0 ff 10 80       	push   $0x8010ffe0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 53 37 00 00       	call   80104600 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 7a 24 00 00       	call   80103350 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 bb 1c 00 00       	call   80102ba0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 c0 08 00 00       	call   801017b0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 11 1d 00 00       	jmp    80102c10 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 bc 72 10 80       	push   $0x801072bc
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 56 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 f9 09 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 20 08 00 00       	call   80101760 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 f1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 c4 09 00 00       	call   80101960 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 ad 07 00 00       	call   80101760 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 2e 25 00 00       	jmp    80103500 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 c6 72 10 80       	push   $0x801072c6
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 17 07 00 00       	call   80101760 <iunlock>
      end_op();
80101049:	e8 c2 1b 00 00       	call   80102c10 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 25 1b 00 00       	call   80102ba0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 fa 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 c8 09 00 00       	call   80101a60 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 b3 06 00 00       	call   80101760 <iunlock>
      end_op();
801010ad:	e8 5e 1b 00 00       	call   80102c10 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 fe 22 00 00       	jmp    801033f0 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 cf 72 10 80       	push   $0x801072cf
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 d5 72 10 80       	push   $0x801072d5
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	56                   	push   %esi
80101114:	53                   	push   %ebx
80101115:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101117:	c1 ea 0c             	shr    $0xc,%edx
8010111a:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101120:	83 ec 08             	sub    $0x8,%esp
80101123:	52                   	push   %edx
80101124:	50                   	push   %eax
80101125:	e8 a6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010112a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010112f:	ba 01 00 00 00       	mov    $0x1,%edx
80101134:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101137:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010113d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101140:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101142:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101147:	85 d1                	test   %edx,%ecx
80101149:	74 25                	je     80101170 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010114b:	f7 d2                	not    %edx
8010114d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010114f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101152:	21 ca                	and    %ecx,%edx
80101154:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101158:	56                   	push   %esi
80101159:	e8 12 1c 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010115e:	89 34 24             	mov    %esi,(%esp)
80101161:	e8 7a f0 ff ff       	call   801001e0 <brelse>
}
80101166:	83 c4 10             	add    $0x10,%esp
80101169:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010116c:	5b                   	pop    %ebx
8010116d:	5e                   	pop    %esi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
    panic("freeing free block");
80101170:	83 ec 0c             	sub    $0xc,%esp
80101173:	68 df 72 10 80       	push   $0x801072df
80101178:	e8 13 f2 ff ff       	call   80100390 <panic>
8010117d:	8d 76 00             	lea    0x0(%esi),%esi

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101189:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
8010118f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101192:	85 c9                	test   %ecx,%ecx
80101194:	0f 84 87 00 00 00    	je     80101221 <balloc+0xa1>
8010119a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a4:	83 ec 08             	sub    $0x8,%esp
801011a7:	89 f0                	mov    %esi,%eax
801011a9:	c1 f8 0c             	sar    $0xc,%eax
801011ac:	03 05 f8 09 11 80    	add    0x801109f8,%eax
801011b2:	50                   	push   %eax
801011b3:	ff 75 d8             	pushl  -0x28(%ebp)
801011b6:	e8 15 ef ff ff       	call   801000d0 <bread>
801011bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011be:	a1 e0 09 11 80       	mov    0x801109e0,%eax
801011c3:	83 c4 10             	add    $0x10,%esp
801011c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011c9:	31 c0                	xor    %eax,%eax
801011cb:	eb 2f                	jmp    801011fc <balloc+0x7c>
801011cd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011d0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011d5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011df:	89 c1                	mov    %eax,%ecx
801011e1:	c1 f9 03             	sar    $0x3,%ecx
801011e4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011e9:	85 df                	test   %ebx,%edi
801011eb:	89 fa                	mov    %edi,%edx
801011ed:	74 41                	je     80101230 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ef:	83 c0 01             	add    $0x1,%eax
801011f2:	83 c6 01             	add    $0x1,%esi
801011f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fa:	74 05                	je     80101201 <balloc+0x81>
801011fc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ff:	77 cf                	ja     801011d0 <balloc+0x50>
    brelse(bp);
80101201:	83 ec 0c             	sub    $0xc,%esp
80101204:	ff 75 e4             	pushl  -0x1c(%ebp)
80101207:	e8 d4 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010121f:	77 80                	ja     801011a1 <balloc+0x21>
  panic("balloc: out of blocks");
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	68 f2 72 10 80       	push   $0x801072f2
80101229:	e8 62 f1 ff ff       	call   80100390 <panic>
8010122e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101230:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101233:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101236:	09 da                	or     %ebx,%edx
80101238:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010123c:	57                   	push   %edi
8010123d:	e8 2e 1b 00 00       	call   80102d70 <log_write>
        brelse(bp);
80101242:	89 3c 24             	mov    %edi,(%esp)
80101245:	e8 96 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	56                   	push   %esi
8010124d:	ff 75 d8             	pushl  -0x28(%ebp)
80101250:	e8 7b ee ff ff       	call   801000d0 <bread>
80101255:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101257:	8d 40 5c             	lea    0x5c(%eax),%eax
8010125a:	83 c4 0c             	add    $0xc,%esp
8010125d:	68 00 02 00 00       	push   $0x200
80101262:	6a 00                	push   $0x0
80101264:	50                   	push   %eax
80101265:	e8 46 34 00 00       	call   801046b0 <memset>
  log_write(bp);
8010126a:	89 1c 24             	mov    %ebx,(%esp)
8010126d:	e8 fe 1a 00 00       	call   80102d70 <log_write>
  brelse(bp);
80101272:	89 1c 24             	mov    %ebx,(%esp)
80101275:	e8 66 ef ff ff       	call   801001e0 <brelse>
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010128a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101290 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101298:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
8010129f:	83 ec 28             	sub    $0x28,%esp
801012a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012a5:	68 00 0a 11 80       	push   $0x80110a00
801012aa:	e8 c1 31 00 00       	call   80104470 <acquire>
801012af:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012b5:	eb 17                	jmp    801012ce <iget+0x3e>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012c0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012c6:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801012cc:	73 22                	jae    801012f0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012d1:	85 c9                	test   %ecx,%ecx
801012d3:	7e 04                	jle    801012d9 <iget+0x49>
801012d5:	39 3b                	cmp    %edi,(%ebx)
801012d7:	74 4f                	je     80101328 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d9:	85 f6                	test   %esi,%esi
801012db:	75 e3                	jne    801012c0 <iget+0x30>
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012e8:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801012ee:	72 de                	jb     801012ce <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f0:	85 f6                	test   %esi,%esi
801012f2:	74 5b                	je     8010134f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012f4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012f7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012f9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012fc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101303:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010130a:	68 00 0a 11 80       	push   $0x80110a00
8010130f:	e8 ec 32 00 00       	call   80104600 <release>

  return ip;
80101314:	83 c4 10             	add    $0x10,%esp
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	89 f0                	mov    %esi,%eax
8010131c:	5b                   	pop    %ebx
8010131d:	5e                   	pop    %esi
8010131e:	5f                   	pop    %edi
8010131f:	5d                   	pop    %ebp
80101320:	c3                   	ret    
80101321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101328:	39 53 04             	cmp    %edx,0x4(%ebx)
8010132b:	75 ac                	jne    801012d9 <iget+0x49>
      release(&icache.lock);
8010132d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101330:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101333:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101335:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
8010133a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010133d:	e8 be 32 00 00       	call   80104600 <release>
      return ip;
80101342:	83 c4 10             	add    $0x10,%esp
}
80101345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101348:	89 f0                	mov    %esi,%eax
8010134a:	5b                   	pop    %ebx
8010134b:	5e                   	pop    %esi
8010134c:	5f                   	pop    %edi
8010134d:	5d                   	pop    %ebp
8010134e:	c3                   	ret    
    panic("iget: no inodes");
8010134f:	83 ec 0c             	sub    $0xc,%esp
80101352:	68 08 73 10 80       	push   $0x80107308
80101357:	e8 34 f0 ff ff       	call   80100390 <panic>
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c6                	mov    %eax,%esi
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101376:	85 db                	test   %ebx,%ebx
80101378:	74 76                	je     801013f0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010137d:	89 d8                	mov    %ebx,%eax
8010137f:	5b                   	pop    %ebx
80101380:	5e                   	pop    %esi
80101381:	5f                   	pop    %edi
80101382:	5d                   	pop    %ebp
80101383:	c3                   	ret    
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101388:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010138b:	83 fb 7f             	cmp    $0x7f,%ebx
8010138e:	0f 87 90 00 00 00    	ja     80101424 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101394:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010139a:	8b 00                	mov    (%eax),%eax
8010139c:	85 d2                	test   %edx,%edx
8010139e:	74 70                	je     80101410 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013a0:	83 ec 08             	sub    $0x8,%esp
801013a3:	52                   	push   %edx
801013a4:	50                   	push   %eax
801013a5:	e8 26 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013aa:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013ae:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013b1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013b3:	8b 1a                	mov    (%edx),%ebx
801013b5:	85 db                	test   %ebx,%ebx
801013b7:	75 1d                	jne    801013d6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801013b9:	8b 06                	mov    (%esi),%eax
801013bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013be:	e8 bd fd ff ff       	call   80101180 <balloc>
801013c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013c6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801013c9:	89 c3                	mov    %eax,%ebx
801013cb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013cd:	57                   	push   %edi
801013ce:	e8 9d 19 00 00       	call   80102d70 <log_write>
801013d3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801013d6:	83 ec 0c             	sub    $0xc,%esp
801013d9:	57                   	push   %edi
801013da:	e8 01 ee ff ff       	call   801001e0 <brelse>
801013df:	83 c4 10             	add    $0x10,%esp
}
801013e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e5:	89 d8                	mov    %ebx,%eax
801013e7:	5b                   	pop    %ebx
801013e8:	5e                   	pop    %esi
801013e9:	5f                   	pop    %edi
801013ea:	5d                   	pop    %ebp
801013eb:	c3                   	ret    
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801013f0:	8b 00                	mov    (%eax),%eax
801013f2:	e8 89 fd ff ff       	call   80101180 <balloc>
801013f7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801013fd:	89 c3                	mov    %eax,%ebx
}
801013ff:	89 d8                	mov    %ebx,%eax
80101401:	5b                   	pop    %ebx
80101402:	5e                   	pop    %esi
80101403:	5f                   	pop    %edi
80101404:	5d                   	pop    %ebp
80101405:	c3                   	ret    
80101406:	8d 76 00             	lea    0x0(%esi),%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101410:	e8 6b fd ff ff       	call   80101180 <balloc>
80101415:	89 c2                	mov    %eax,%edx
80101417:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010141d:	8b 06                	mov    (%esi),%eax
8010141f:	e9 7c ff ff ff       	jmp    801013a0 <bmap+0x40>
  panic("bmap: out of range");
80101424:	83 ec 0c             	sub    $0xc,%esp
80101427:	68 18 73 10 80       	push   $0x80107318
8010142c:	e8 5f ef ff ff       	call   80100390 <panic>
80101431:	eb 0d                	jmp    80101440 <readsb>
80101433:	90                   	nop
80101434:	90                   	nop
80101435:	90                   	nop
80101436:	90                   	nop
80101437:	90                   	nop
80101438:	90                   	nop
80101439:	90                   	nop
8010143a:	90                   	nop
8010143b:	90                   	nop
8010143c:	90                   	nop
8010143d:	90                   	nop
8010143e:	90                   	nop
8010143f:	90                   	nop

80101440 <readsb>:
{
80101440:	55                   	push   %ebp
80101441:	89 e5                	mov    %esp,%ebp
80101443:	56                   	push   %esi
80101444:	53                   	push   %ebx
80101445:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101448:	83 ec 08             	sub    $0x8,%esp
8010144b:	6a 01                	push   $0x1
8010144d:	ff 75 08             	pushl  0x8(%ebp)
80101450:	e8 7b ec ff ff       	call   801000d0 <bread>
80101455:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101457:	8d 40 5c             	lea    0x5c(%eax),%eax
8010145a:	83 c4 0c             	add    $0xc,%esp
8010145d:	6a 1c                	push   $0x1c
8010145f:	50                   	push   %eax
80101460:	56                   	push   %esi
80101461:	e8 fa 32 00 00       	call   80104760 <memmove>
  brelse(bp);
80101466:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101469:	83 c4 10             	add    $0x10,%esp
}
8010146c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5d                   	pop    %ebp
  brelse(bp);
80101472:	e9 69 ed ff ff       	jmp    801001e0 <brelse>
80101477:	89 f6                	mov    %esi,%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101480 <iinit>:
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
80101484:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101489:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010148c:	68 2b 73 10 80       	push   $0x8010732b
80101491:	68 00 0a 11 80       	push   $0x80110a00
80101496:	e8 65 2e 00 00       	call   80104300 <initlock>
8010149b:	83 c4 10             	add    $0x10,%esp
8010149e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	83 ec 08             	sub    $0x8,%esp
801014a3:	68 32 73 10 80       	push   $0x80107332
801014a8:	53                   	push   %ebx
801014a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014af:	e8 1c 2d 00 00       	call   801041d0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014b4:	83 c4 10             	add    $0x10,%esp
801014b7:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
801014bd:	75 e1                	jne    801014a0 <iinit+0x20>
  readsb(dev, &sb);
801014bf:	83 ec 08             	sub    $0x8,%esp
801014c2:	68 e0 09 11 80       	push   $0x801109e0
801014c7:	ff 75 08             	pushl  0x8(%ebp)
801014ca:	e8 71 ff ff ff       	call   80101440 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014cf:	ff 35 f8 09 11 80    	pushl  0x801109f8
801014d5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801014db:	ff 35 f0 09 11 80    	pushl  0x801109f0
801014e1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801014e7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801014ed:	ff 35 e4 09 11 80    	pushl  0x801109e4
801014f3:	ff 35 e0 09 11 80    	pushl  0x801109e0
801014f9:	68 98 73 10 80       	push   $0x80107398
801014fe:	e8 5d f1 ff ff       	call   80100660 <cprintf>
}
80101503:	83 c4 30             	add    $0x30,%esp
80101506:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101509:	c9                   	leave  
8010150a:	c3                   	ret    
8010150b:	90                   	nop
8010150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101510 <ialloc>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 94 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 64 eb ff ff       	call   801000d0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 1d 31 00 00       	call   801046b0 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 cb 17 00 00       	call   80102d70 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 33 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801015bb:	e9 d0 fc ff ff       	jmp    80101290 <iget>
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 38 73 10 80       	push   $0x80107338
801015c8:	e8 c3 ed ff ff       	call   80100390 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ee:	e8 dd ea ff ff       	call   801000d0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 2a 31 00 00       	call   80104760 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 32 17 00 00       	call   80102d70 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  brelse(bp);
8010164a:	e9 91 eb ff ff       	jmp    801001e0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 00 0a 11 80       	push   $0x80110a00
8010165f:	e8 0c 2e 00 00       	call   80104470 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010166f:	e8 8c 2f 00 00       	call   80104600 <release>
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 b7 00 00 00    	je     80101747 <ilock+0xc7>
80101690:	8b 53 08             	mov    0x8(%ebx),%edx
80101693:	85 d2                	test   %edx,%edx
80101695:	0f 8e ac 00 00 00    	jle    80101747 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010169b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010169e:	83 ec 0c             	sub    $0xc,%esp
801016a1:	50                   	push   %eax
801016a2:	e8 69 2b 00 00       	call   80104210 <acquiresleep>
  if(ip->valid == 0){
801016a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016aa:	83 c4 10             	add    $0x10,%esp
801016ad:	85 c0                	test   %eax,%eax
801016af:	74 0f                	je     801016c0 <ilock+0x40>
}
801016b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016b4:	5b                   	pop    %ebx
801016b5:	5e                   	pop    %esi
801016b6:	5d                   	pop    %ebp
801016b7:	c3                   	ret    
801016b8:	90                   	nop
801016b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016c0:	8b 43 04             	mov    0x4(%ebx),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	c1 e8 03             	shr    $0x3,%eax
801016c9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016cf:	50                   	push   %eax
801016d0:	ff 33                	pushl  (%ebx)
801016d2:	e8 f9 e9 ff ff       	call   801000d0 <bread>
801016d7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016d9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016df:	83 e0 07             	and    $0x7,%eax
801016e2:	c1 e0 06             	shl    $0x6,%eax
801016e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101703:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101707:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010170b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010170e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101711:	6a 34                	push   $0x34
80101713:	50                   	push   %eax
80101714:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101717:	50                   	push   %eax
80101718:	e8 43 30 00 00       	call   80104760 <memmove>
    brelse(bp);
8010171d:	89 34 24             	mov    %esi,(%esp)
80101720:	e8 bb ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101725:	83 c4 10             	add    $0x10,%esp
80101728:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010172d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101734:	0f 85 77 ff ff ff    	jne    801016b1 <ilock+0x31>
      panic("ilock: no type");
8010173a:	83 ec 0c             	sub    $0xc,%esp
8010173d:	68 50 73 10 80       	push   $0x80107350
80101742:	e8 49 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101747:	83 ec 0c             	sub    $0xc,%esp
8010174a:	68 4a 73 10 80       	push   $0x8010734a
8010174f:	e8 3c ec ff ff       	call   80100390 <panic>
80101754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010175a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101760 <iunlock>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	56                   	push   %esi
80101764:	53                   	push   %ebx
80101765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101768:	85 db                	test   %ebx,%ebx
8010176a:	74 28                	je     80101794 <iunlock+0x34>
8010176c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010176f:	83 ec 0c             	sub    $0xc,%esp
80101772:	56                   	push   %esi
80101773:	e8 38 2b 00 00       	call   801042b0 <holdingsleep>
80101778:	83 c4 10             	add    $0x10,%esp
8010177b:	85 c0                	test   %eax,%eax
8010177d:	74 15                	je     80101794 <iunlock+0x34>
8010177f:	8b 43 08             	mov    0x8(%ebx),%eax
80101782:	85 c0                	test   %eax,%eax
80101784:	7e 0e                	jle    80101794 <iunlock+0x34>
  releasesleep(&ip->lock);
80101786:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101789:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178c:	5b                   	pop    %ebx
8010178d:	5e                   	pop    %esi
8010178e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010178f:	e9 dc 2a 00 00       	jmp    80104270 <releasesleep>
    panic("iunlock");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 5f 73 10 80       	push   $0x8010735f
8010179c:	e8 ef eb ff ff       	call   80100390 <panic>
801017a1:	eb 0d                	jmp    801017b0 <iput>
801017a3:	90                   	nop
801017a4:	90                   	nop
801017a5:	90                   	nop
801017a6:	90                   	nop
801017a7:	90                   	nop
801017a8:	90                   	nop
801017a9:	90                   	nop
801017aa:	90                   	nop
801017ab:	90                   	nop
801017ac:	90                   	nop
801017ad:	90                   	nop
801017ae:	90                   	nop
801017af:	90                   	nop

801017b0 <iput>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	83 ec 28             	sub    $0x28,%esp
801017b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017bf:	57                   	push   %edi
801017c0:	e8 4b 2a 00 00       	call   80104210 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017c8:	83 c4 10             	add    $0x10,%esp
801017cb:	85 d2                	test   %edx,%edx
801017cd:	74 07                	je     801017d6 <iput+0x26>
801017cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017d4:	74 32                	je     80101808 <iput+0x58>
  releasesleep(&ip->lock);
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	57                   	push   %edi
801017da:	e8 91 2a 00 00       	call   80104270 <releasesleep>
  acquire(&icache.lock);
801017df:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801017e6:	e8 85 2c 00 00       	call   80104470 <acquire>
  ip->ref--;
801017eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ef:	83 c4 10             	add    $0x10,%esp
801017f2:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801017f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017fc:	5b                   	pop    %ebx
801017fd:	5e                   	pop    %esi
801017fe:	5f                   	pop    %edi
801017ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101800:	e9 fb 2d 00 00       	jmp    80104600 <release>
80101805:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101808:	83 ec 0c             	sub    $0xc,%esp
8010180b:	68 00 0a 11 80       	push   $0x80110a00
80101810:	e8 5b 2c 00 00       	call   80104470 <acquire>
    int r = ip->ref;
80101815:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101818:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010181f:	e8 dc 2d 00 00       	call   80104600 <release>
    if(r == 1){
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	83 fe 01             	cmp    $0x1,%esi
8010182a:	75 aa                	jne    801017d6 <iput+0x26>
8010182c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101832:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101835:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101838:	89 cf                	mov    %ecx,%edi
8010183a:	eb 0b                	jmp    80101847 <iput+0x97>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101840:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101843:	39 fe                	cmp    %edi,%esi
80101845:	74 19                	je     80101860 <iput+0xb0>
    if(ip->addrs[i]){
80101847:	8b 16                	mov    (%esi),%edx
80101849:	85 d2                	test   %edx,%edx
8010184b:	74 f3                	je     80101840 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010184d:	8b 03                	mov    (%ebx),%eax
8010184f:	e8 bc f8 ff ff       	call   80101110 <bfree>
      ip->addrs[i] = 0;
80101854:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010185a:	eb e4                	jmp    80101840 <iput+0x90>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101860:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101866:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101869:	85 c0                	test   %eax,%eax
8010186b:	75 33                	jne    801018a0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010186d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101870:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101877:	53                   	push   %ebx
80101878:	e8 53 fd ff ff       	call   801015d0 <iupdate>
      ip->type = 0;
8010187d:	31 c0                	xor    %eax,%eax
8010187f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101883:	89 1c 24             	mov    %ebx,(%esp)
80101886:	e8 45 fd ff ff       	call   801015d0 <iupdate>
      ip->valid = 0;
8010188b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101892:	83 c4 10             	add    $0x10,%esp
80101895:	e9 3c ff ff ff       	jmp    801017d6 <iput+0x26>
8010189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a0:	83 ec 08             	sub    $0x8,%esp
801018a3:	50                   	push   %eax
801018a4:	ff 33                	pushl  (%ebx)
801018a6:	e8 25 e8 ff ff       	call   801000d0 <bread>
801018ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018b1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018b7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	89 cf                	mov    %ecx,%edi
801018bf:	eb 0e                	jmp    801018cf <iput+0x11f>
801018c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018c8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018cb:	39 fe                	cmp    %edi,%esi
801018cd:	74 0f                	je     801018de <iput+0x12e>
      if(a[j])
801018cf:	8b 16                	mov    (%esi),%edx
801018d1:	85 d2                	test   %edx,%edx
801018d3:	74 f3                	je     801018c8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018d5:	8b 03                	mov    (%ebx),%eax
801018d7:	e8 34 f8 ff ff       	call   80101110 <bfree>
801018dc:	eb ea                	jmp    801018c8 <iput+0x118>
    brelse(bp);
801018de:	83 ec 0c             	sub    $0xc,%esp
801018e1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018e4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018e7:	e8 f4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018ec:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801018f2:	8b 03                	mov    (%ebx),%eax
801018f4:	e8 17 f8 ff ff       	call   80101110 <bfree>
    ip->addrs[NDIRECT] = 0;
801018f9:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101900:	00 00 00 
80101903:	83 c4 10             	add    $0x10,%esp
80101906:	e9 62 ff ff ff       	jmp    8010186d <iput+0xbd>
8010190b:	90                   	nop
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 10             	sub    $0x10,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	53                   	push   %ebx
8010191b:	e8 40 fe ff ff       	call   80101760 <iunlock>
  iput(ip);
80101920:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101923:	83 c4 10             	add    $0x10,%esp
}
80101926:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101929:	c9                   	leave  
  iput(ip);
8010192a:	e9 81 fe ff ff       	jmp    801017b0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 1c             	sub    $0x1c,%esp
80101969:	8b 45 08             	mov    0x8(%ebp),%eax
8010196c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010196f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101972:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101977:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010197a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010197d:	8b 75 10             	mov    0x10(%ebp),%esi
80101980:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101983:	0f 84 a7 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101989:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010198c:	8b 40 58             	mov    0x58(%eax),%eax
8010198f:	39 c6                	cmp    %eax,%esi
80101991:	0f 87 ba 00 00 00    	ja     80101a51 <readi+0xf1>
80101997:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010199a:	89 f9                	mov    %edi,%ecx
8010199c:	01 f1                	add    %esi,%ecx
8010199e:	0f 82 ad 00 00 00    	jb     80101a51 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019a4:	89 c2                	mov    %eax,%edx
801019a6:	29 f2                	sub    %esi,%edx
801019a8:	39 c8                	cmp    %ecx,%eax
801019aa:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ad:	31 ff                	xor    %edi,%edi
801019af:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019b1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019b4:	74 6c                	je     80101a22 <readi+0xc2>
801019b6:	8d 76 00             	lea    0x0(%esi),%esi
801019b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019c0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019c3:	89 f2                	mov    %esi,%edx
801019c5:	c1 ea 09             	shr    $0x9,%edx
801019c8:	89 d8                	mov    %ebx,%eax
801019ca:	e8 91 f9 ff ff       	call   80101360 <bmap>
801019cf:	83 ec 08             	sub    $0x8,%esp
801019d2:	50                   	push   %eax
801019d3:	ff 33                	pushl  (%ebx)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019dd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019df:	89 f0                	mov    %esi,%eax
801019e1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019eb:	83 c4 0c             	add    $0xc,%esp
801019ee:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019f4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	29 fb                	sub    %edi,%ebx
801019f9:	39 d9                	cmp    %ebx,%ecx
801019fb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fe:	53                   	push   %ebx
801019ff:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a00:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a05:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a07:	e8 54 2d 00 00       	call   80104760 <memmove>
    brelse(bp);
80101a0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a0f:	89 14 24             	mov    %edx,(%esp)
80101a12:	e8 c9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a17:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a20:	77 9e                	ja     801019c0 <readi+0x60>
  }
  return n;
80101a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a28:	5b                   	pop    %ebx
80101a29:	5e                   	pop    %esi
80101a2a:	5f                   	pop    %edi
80101a2b:	5d                   	pop    %ebp
80101a2c:	c3                   	ret    
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 17                	ja     80101a51 <readi+0xf1>
80101a3a:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 0c                	je     80101a51 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a4b:	5b                   	pop    %ebx
80101a4c:	5e                   	pop    %esi
80101a4d:	5f                   	pop    %edi
80101a4e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a4f:	ff e0                	jmp    *%eax
      return -1;
80101a51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a56:	eb cd                	jmp    80101a25 <readi+0xc5>
80101a58:	90                   	nop
80101a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 1c             	sub    $0x1c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a7d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a80:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 eb 00 00 00    	jb     80101b80 <writei+0x120>
80101a95:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a98:	31 d2                	xor    %edx,%edx
80101a9a:	89 f8                	mov    %edi,%eax
80101a9c:	01 f0                	add    %esi,%eax
80101a9e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa6:	0f 87 d4 00 00 00    	ja     80101b80 <writei+0x120>
80101aac:	85 d2                	test   %edx,%edx
80101aae:	0f 85 cc 00 00 00    	jne    80101b80 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ab4:	85 ff                	test   %edi,%edi
80101ab6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101abd:	74 72                	je     80101b31 <writei+0xd1>
80101abf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ac3:	89 f2                	mov    %esi,%edx
80101ac5:	c1 ea 09             	shr    $0x9,%edx
80101ac8:	89 f8                	mov    %edi,%eax
80101aca:	e8 91 f8 ff ff       	call   80101360 <bmap>
80101acf:	83 ec 08             	sub    $0x8,%esp
80101ad2:	50                   	push   %eax
80101ad3:	ff 37                	pushl  (%edi)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101add:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae2:	89 f0                	mov    %esi,%eax
80101ae4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ae9:	83 c4 0c             	add    $0xc,%esp
80101aec:	25 ff 01 00 00       	and    $0x1ff,%eax
80101af1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101af7:	39 d9                	cmp    %ebx,%ecx
80101af9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101afc:	53                   	push   %ebx
80101afd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b00:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b02:	50                   	push   %eax
80101b03:	e8 58 2c 00 00       	call   80104760 <memmove>
    log_write(bp);
80101b08:	89 3c 24             	mov    %edi,(%esp)
80101b0b:	e8 60 12 00 00       	call   80102d70 <log_write>
    brelse(bp);
80101b10:	89 3c 24             	mov    %edi,(%esp)
80101b13:	e8 c8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b18:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b1e:	83 c4 10             	add    $0x10,%esp
80101b21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b24:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b27:	77 97                	ja     80101ac0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b2f:	77 37                	ja     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b31:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b37:	5b                   	pop    %ebx
80101b38:	5e                   	pop    %esi
80101b39:	5f                   	pop    %edi
80101b3a:	5d                   	pop    %ebp
80101b3b:	c3                   	ret    
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 36                	ja     80101b80 <writei+0x120>
80101b4a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 2b                	je     80101b80 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b6b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b6e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b71:	50                   	push   %eax
80101b72:	e8 59 fa ff ff       	call   801015d0 <iupdate>
80101b77:	83 c4 10             	add    $0x10,%esp
80101b7a:	eb b5                	jmp    80101b31 <writei+0xd1>
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b85:	eb ad                	jmp    80101b34 <writei+0xd4>
80101b87:	89 f6                	mov    %esi,%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	6a 0e                	push   $0xe
80101b98:	ff 75 0c             	pushl  0xc(%ebp)
80101b9b:	ff 75 08             	pushl  0x8(%ebp)
80101b9e:	e8 2d 2c 00 00       	call   801047d0 <strncmp>
}
80101ba3:	c9                   	leave  
80101ba4:	c3                   	ret    
80101ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	57                   	push   %edi
80101bb4:	56                   	push   %esi
80101bb5:	53                   	push   %ebx
80101bb6:	83 ec 1c             	sub    $0x1c,%esp
80101bb9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bc1:	0f 85 85 00 00 00    	jne    80101c4c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bc7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bca:	31 ff                	xor    %edi,%edi
80101bcc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bcf:	85 d2                	test   %edx,%edx
80101bd1:	74 3e                	je     80101c11 <dirlookup+0x61>
80101bd3:	90                   	nop
80101bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bd8:	6a 10                	push   $0x10
80101bda:	57                   	push   %edi
80101bdb:	56                   	push   %esi
80101bdc:	53                   	push   %ebx
80101bdd:	e8 7e fd ff ff       	call   80101960 <readi>
80101be2:	83 c4 10             	add    $0x10,%esp
80101be5:	83 f8 10             	cmp    $0x10,%eax
80101be8:	75 55                	jne    80101c3f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bef:	74 18                	je     80101c09 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101bf1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bf4:	83 ec 04             	sub    $0x4,%esp
80101bf7:	6a 0e                	push   $0xe
80101bf9:	50                   	push   %eax
80101bfa:	ff 75 0c             	pushl  0xc(%ebp)
80101bfd:	e8 ce 2b 00 00       	call   801047d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	85 c0                	test   %eax,%eax
80101c07:	74 17                	je     80101c20 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c09:	83 c7 10             	add    $0x10,%edi
80101c0c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c0f:	72 c7                	jb     80101bd8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c11:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c14:	31 c0                	xor    %eax,%eax
}
80101c16:	5b                   	pop    %ebx
80101c17:	5e                   	pop    %esi
80101c18:	5f                   	pop    %edi
80101c19:	5d                   	pop    %ebp
80101c1a:	c3                   	ret    
80101c1b:	90                   	nop
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c20:	8b 45 10             	mov    0x10(%ebp),%eax
80101c23:	85 c0                	test   %eax,%eax
80101c25:	74 05                	je     80101c2c <dirlookup+0x7c>
        *poff = off;
80101c27:	8b 45 10             	mov    0x10(%ebp),%eax
80101c2a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c2c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c30:	8b 03                	mov    (%ebx),%eax
80101c32:	e8 59 f6 ff ff       	call   80101290 <iget>
}
80101c37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3a:	5b                   	pop    %ebx
80101c3b:	5e                   	pop    %esi
80101c3c:	5f                   	pop    %edi
80101c3d:	5d                   	pop    %ebp
80101c3e:	c3                   	ret    
      panic("dirlookup read");
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	68 79 73 10 80       	push   $0x80107379
80101c47:	e8 44 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c4c:	83 ec 0c             	sub    $0xc,%esp
80101c4f:	68 67 73 10 80       	push   $0x80107367
80101c54:	e8 37 e7 ff ff       	call   80100390 <panic>
80101c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	89 cf                	mov    %ecx,%edi
80101c68:	89 c3                	mov    %eax,%ebx
80101c6a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c6d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c70:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c73:	0f 84 67 01 00 00    	je     80101de0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c79:	e8 62 1b 00 00       	call   801037e0 <myproc>
  acquire(&icache.lock);
80101c7e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c81:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c84:	68 00 0a 11 80       	push   $0x80110a00
80101c89:	e8 e2 27 00 00       	call   80104470 <acquire>
  ip->ref++;
80101c8e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c92:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c99:	e8 62 29 00 00       	call   80104600 <release>
80101c9e:	83 c4 10             	add    $0x10,%esp
80101ca1:	eb 08                	jmp    80101cab <namex+0x4b>
80101ca3:	90                   	nop
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ca8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cab:	0f b6 03             	movzbl (%ebx),%eax
80101cae:	3c 2f                	cmp    $0x2f,%al
80101cb0:	74 f6                	je     80101ca8 <namex+0x48>
  if(*path == 0)
80101cb2:	84 c0                	test   %al,%al
80101cb4:	0f 84 ee 00 00 00    	je     80101da8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cba:	0f b6 03             	movzbl (%ebx),%eax
80101cbd:	3c 2f                	cmp    $0x2f,%al
80101cbf:	0f 84 b3 00 00 00    	je     80101d78 <namex+0x118>
80101cc5:	84 c0                	test   %al,%al
80101cc7:	89 da                	mov    %ebx,%edx
80101cc9:	75 09                	jne    80101cd4 <namex+0x74>
80101ccb:	e9 a8 00 00 00       	jmp    80101d78 <namex+0x118>
80101cd0:	84 c0                	test   %al,%al
80101cd2:	74 0a                	je     80101cde <namex+0x7e>
    path++;
80101cd4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cd7:	0f b6 02             	movzbl (%edx),%eax
80101cda:	3c 2f                	cmp    $0x2f,%al
80101cdc:	75 f2                	jne    80101cd0 <namex+0x70>
80101cde:	89 d1                	mov    %edx,%ecx
80101ce0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ce2:	83 f9 0d             	cmp    $0xd,%ecx
80101ce5:	0f 8e 91 00 00 00    	jle    80101d7c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101ceb:	83 ec 04             	sub    $0x4,%esp
80101cee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cf1:	6a 0e                	push   $0xe
80101cf3:	53                   	push   %ebx
80101cf4:	57                   	push   %edi
80101cf5:	e8 66 2a 00 00       	call   80104760 <memmove>
    path++;
80101cfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101cfd:	83 c4 10             	add    $0x10,%esp
    path++;
80101d00:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d02:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d05:	75 11                	jne    80101d18 <namex+0xb8>
80101d07:	89 f6                	mov    %esi,%esi
80101d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d13:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d16:	74 f8                	je     80101d10 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
80101d1b:	56                   	push   %esi
80101d1c:	e8 5f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d21:	83 c4 10             	add    $0x10,%esp
80101d24:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d29:	0f 85 91 00 00 00    	jne    80101dc0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d2f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d32:	85 d2                	test   %edx,%edx
80101d34:	74 09                	je     80101d3f <namex+0xdf>
80101d36:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d39:	0f 84 b7 00 00 00    	je     80101df6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d3f:	83 ec 04             	sub    $0x4,%esp
80101d42:	6a 00                	push   $0x0
80101d44:	57                   	push   %edi
80101d45:	56                   	push   %esi
80101d46:	e8 65 fe ff ff       	call   80101bb0 <dirlookup>
80101d4b:	83 c4 10             	add    $0x10,%esp
80101d4e:	85 c0                	test   %eax,%eax
80101d50:	74 6e                	je     80101dc0 <namex+0x160>
  iunlock(ip);
80101d52:	83 ec 0c             	sub    $0xc,%esp
80101d55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d58:	56                   	push   %esi
80101d59:	e8 02 fa ff ff       	call   80101760 <iunlock>
  iput(ip);
80101d5e:	89 34 24             	mov    %esi,(%esp)
80101d61:	e8 4a fa ff ff       	call   801017b0 <iput>
80101d66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d69:	83 c4 10             	add    $0x10,%esp
80101d6c:	89 c6                	mov    %eax,%esi
80101d6e:	e9 38 ff ff ff       	jmp    80101cab <namex+0x4b>
80101d73:	90                   	nop
80101d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d78:	89 da                	mov    %ebx,%edx
80101d7a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d7c:	83 ec 04             	sub    $0x4,%esp
80101d7f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d82:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d85:	51                   	push   %ecx
80101d86:	53                   	push   %ebx
80101d87:	57                   	push   %edi
80101d88:	e8 d3 29 00 00       	call   80104760 <memmove>
    name[len] = 0;
80101d8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d90:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d9a:	89 d3                	mov    %edx,%ebx
80101d9c:	e9 61 ff ff ff       	jmp    80101d02 <namex+0xa2>
80101da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101da8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dab:	85 c0                	test   %eax,%eax
80101dad:	75 5d                	jne    80101e0c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101daf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101db2:	89 f0                	mov    %esi,%eax
80101db4:	5b                   	pop    %ebx
80101db5:	5e                   	pop    %esi
80101db6:	5f                   	pop    %edi
80101db7:	5d                   	pop    %ebp
80101db8:	c3                   	ret    
80101db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dc0:	83 ec 0c             	sub    $0xc,%esp
80101dc3:	56                   	push   %esi
80101dc4:	e8 97 f9 ff ff       	call   80101760 <iunlock>
  iput(ip);
80101dc9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dcc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dce:	e8 dd f9 ff ff       	call   801017b0 <iput>
      return 0;
80101dd3:	83 c4 10             	add    $0x10,%esp
}
80101dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd9:	89 f0                	mov    %esi,%eax
80101ddb:	5b                   	pop    %ebx
80101ddc:	5e                   	pop    %esi
80101ddd:	5f                   	pop    %edi
80101dde:	5d                   	pop    %ebp
80101ddf:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101de0:	ba 01 00 00 00       	mov    $0x1,%edx
80101de5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dea:	e8 a1 f4 ff ff       	call   80101290 <iget>
80101def:	89 c6                	mov    %eax,%esi
80101df1:	e9 b5 fe ff ff       	jmp    80101cab <namex+0x4b>
      iunlock(ip);
80101df6:	83 ec 0c             	sub    $0xc,%esp
80101df9:	56                   	push   %esi
80101dfa:	e8 61 f9 ff ff       	call   80101760 <iunlock>
      return ip;
80101dff:	83 c4 10             	add    $0x10,%esp
}
80101e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e05:	89 f0                	mov    %esi,%eax
80101e07:	5b                   	pop    %ebx
80101e08:	5e                   	pop    %esi
80101e09:	5f                   	pop    %edi
80101e0a:	5d                   	pop    %ebp
80101e0b:	c3                   	ret    
    iput(ip);
80101e0c:	83 ec 0c             	sub    $0xc,%esp
80101e0f:	56                   	push   %esi
    return 0;
80101e10:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e12:	e8 99 f9 ff ff       	call   801017b0 <iput>
    return 0;
80101e17:	83 c4 10             	add    $0x10,%esp
80101e1a:	eb 93                	jmp    80101daf <namex+0x14f>
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 20             	sub    $0x20,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	6a 00                	push   $0x0
80101e2e:	ff 75 0c             	pushl  0xc(%ebp)
80101e31:	53                   	push   %ebx
80101e32:	e8 79 fd ff ff       	call   80101bb0 <dirlookup>
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	85 c0                	test   %eax,%eax
80101e3c:	75 67                	jne    80101ea5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e3e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e41:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e44:	85 ff                	test   %edi,%edi
80101e46:	74 29                	je     80101e71 <dirlink+0x51>
80101e48:	31 ff                	xor    %edi,%edi
80101e4a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e4d:	eb 09                	jmp    80101e58 <dirlink+0x38>
80101e4f:	90                   	nop
80101e50:	83 c7 10             	add    $0x10,%edi
80101e53:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e56:	73 19                	jae    80101e71 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e58:	6a 10                	push   $0x10
80101e5a:	57                   	push   %edi
80101e5b:	56                   	push   %esi
80101e5c:	53                   	push   %ebx
80101e5d:	e8 fe fa ff ff       	call   80101960 <readi>
80101e62:	83 c4 10             	add    $0x10,%esp
80101e65:	83 f8 10             	cmp    $0x10,%eax
80101e68:	75 4e                	jne    80101eb8 <dirlink+0x98>
    if(de.inum == 0)
80101e6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e6f:	75 df                	jne    80101e50 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e71:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e74:	83 ec 04             	sub    $0x4,%esp
80101e77:	6a 0e                	push   $0xe
80101e79:	ff 75 0c             	pushl  0xc(%ebp)
80101e7c:	50                   	push   %eax
80101e7d:	e8 ae 29 00 00       	call   80104830 <strncpy>
  de.inum = inum;
80101e82:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e85:	6a 10                	push   $0x10
80101e87:	57                   	push   %edi
80101e88:	56                   	push   %esi
80101e89:	53                   	push   %ebx
  de.inum = inum;
80101e8a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e8e:	e8 cd fb ff ff       	call   80101a60 <writei>
80101e93:	83 c4 20             	add    $0x20,%esp
80101e96:	83 f8 10             	cmp    $0x10,%eax
80101e99:	75 2a                	jne    80101ec5 <dirlink+0xa5>
  return 0;
80101e9b:	31 c0                	xor    %eax,%eax
}
80101e9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea0:	5b                   	pop    %ebx
80101ea1:	5e                   	pop    %esi
80101ea2:	5f                   	pop    %edi
80101ea3:	5d                   	pop    %ebp
80101ea4:	c3                   	ret    
    iput(ip);
80101ea5:	83 ec 0c             	sub    $0xc,%esp
80101ea8:	50                   	push   %eax
80101ea9:	e8 02 f9 ff ff       	call   801017b0 <iput>
    return -1;
80101eae:	83 c4 10             	add    $0x10,%esp
80101eb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb6:	eb e5                	jmp    80101e9d <dirlink+0x7d>
      panic("dirlink read");
80101eb8:	83 ec 0c             	sub    $0xc,%esp
80101ebb:	68 88 73 10 80       	push   $0x80107388
80101ec0:	e8 cb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	68 86 79 10 80       	push   $0x80107986
80101ecd:	e8 be e4 ff ff       	call   80100390 <panic>
80101ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ee0 <namei>:

struct inode*
namei(char *path)
{
80101ee0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ee1:	31 d2                	xor    %edx,%edx
{
80101ee3:	89 e5                	mov    %esp,%ebp
80101ee5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eeb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101eee:	e8 6d fd ff ff       	call   80101c60 <namex>
}
80101ef3:	c9                   	leave  
80101ef4:	c3                   	ret    
80101ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f00:	55                   	push   %ebp
  return namex(path, 1, name);
80101f01:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f06:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f0e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f0f:	e9 4c fd ff ff       	jmp    80101c60 <namex>
80101f14:	66 90                	xchg   %ax,%ax
80101f16:	66 90                	xchg   %ax,%ax
80101f18:	66 90                	xchg   %ax,%ax
80101f1a:	66 90                	xchg   %ax,%ax
80101f1c:	66 90                	xchg   %ax,%ax
80101f1e:	66 90                	xchg   %ax,%ax

80101f20 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	57                   	push   %edi
80101f24:	56                   	push   %esi
80101f25:	53                   	push   %ebx
80101f26:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f29:	85 c0                	test   %eax,%eax
80101f2b:	0f 84 b4 00 00 00    	je     80101fe5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f31:	8b 58 08             	mov    0x8(%eax),%ebx
80101f34:	89 c6                	mov    %eax,%esi
80101f36:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f3c:	0f 87 96 00 00 00    	ja     80101fd8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f42:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f47:	89 f6                	mov    %esi,%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f50:	89 ca                	mov    %ecx,%edx
80101f52:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f53:	83 e0 c0             	and    $0xffffffc0,%eax
80101f56:	3c 40                	cmp    $0x40,%al
80101f58:	75 f6                	jne    80101f50 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f5a:	31 ff                	xor    %edi,%edi
80101f5c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f61:	89 f8                	mov    %edi,%eax
80101f63:	ee                   	out    %al,(%dx)
80101f64:	b8 01 00 00 00       	mov    $0x1,%eax
80101f69:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f6e:	ee                   	out    %al,(%dx)
80101f6f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f74:	89 d8                	mov    %ebx,%eax
80101f76:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f7e:	c1 f8 08             	sar    $0x8,%eax
80101f81:	ee                   	out    %al,(%dx)
80101f82:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f87:	89 f8                	mov    %edi,%eax
80101f89:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f8a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f8e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f93:	c1 e0 04             	shl    $0x4,%eax
80101f96:	83 e0 10             	and    $0x10,%eax
80101f99:	83 c8 e0             	or     $0xffffffe0,%eax
80101f9c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f9d:	f6 06 04             	testb  $0x4,(%esi)
80101fa0:	75 16                	jne    80101fb8 <idestart+0x98>
80101fa2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fa7:	89 ca                	mov    %ecx,%edx
80101fa9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fad:	5b                   	pop    %ebx
80101fae:	5e                   	pop    %esi
80101faf:	5f                   	pop    %edi
80101fb0:	5d                   	pop    %ebp
80101fb1:	c3                   	ret    
80101fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fb8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fbd:	89 ca                	mov    %ecx,%edx
80101fbf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fc5:	83 c6 5c             	add    $0x5c,%esi
80101fc8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fcd:	fc                   	cld    
80101fce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fd3:	5b                   	pop    %ebx
80101fd4:	5e                   	pop    %esi
80101fd5:	5f                   	pop    %edi
80101fd6:	5d                   	pop    %ebp
80101fd7:	c3                   	ret    
    panic("incorrect blockno");
80101fd8:	83 ec 0c             	sub    $0xc,%esp
80101fdb:	68 f4 73 10 80       	push   $0x801073f4
80101fe0:	e8 ab e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101fe5:	83 ec 0c             	sub    $0xc,%esp
80101fe8:	68 eb 73 10 80       	push   $0x801073eb
80101fed:	e8 9e e3 ff ff       	call   80100390 <panic>
80101ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102006:	68 06 74 10 80       	push   $0x80107406
8010200b:	68 80 a5 10 80       	push   $0x8010a580
80102010:	e8 eb 22 00 00       	call   80104300 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102015:	58                   	pop    %eax
80102016:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010201b:	5a                   	pop    %edx
8010201c:	83 e8 01             	sub    $0x1,%eax
8010201f:	50                   	push   %eax
80102020:	6a 0e                	push   $0xe
80102022:	e8 a9 02 00 00       	call   801022d0 <ioapicenable>
80102027:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010202a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010202f:	90                   	nop
80102030:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102031:	83 e0 c0             	and    $0xffffffc0,%eax
80102034:	3c 40                	cmp    $0x40,%al
80102036:	75 f8                	jne    80102030 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102038:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010203d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102042:	ee                   	out    %al,(%dx)
80102043:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102048:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204d:	eb 06                	jmp    80102055 <ideinit+0x55>
8010204f:	90                   	nop
  for(i=0; i<1000; i++){
80102050:	83 e9 01             	sub    $0x1,%ecx
80102053:	74 0f                	je     80102064 <ideinit+0x64>
80102055:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102056:	84 c0                	test   %al,%al
80102058:	74 f6                	je     80102050 <ideinit+0x50>
      havedisk1 = 1;
8010205a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102061:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102064:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102069:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010206e:	ee                   	out    %al,(%dx)
}
8010206f:	c9                   	leave  
80102070:	c3                   	ret    
80102071:	eb 0d                	jmp    80102080 <ideintr>
80102073:	90                   	nop
80102074:	90                   	nop
80102075:	90                   	nop
80102076:	90                   	nop
80102077:	90                   	nop
80102078:	90                   	nop
80102079:	90                   	nop
8010207a:	90                   	nop
8010207b:	90                   	nop
8010207c:	90                   	nop
8010207d:	90                   	nop
8010207e:	90                   	nop
8010207f:	90                   	nop

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	68 80 a5 10 80       	push   $0x8010a580
8010208e:	e8 dd 23 00 00       	call   80104470 <acquire>

  if((b = idequeue) == 0){
80102093:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102099:	83 c4 10             	add    $0x10,%esp
8010209c:	85 db                	test   %ebx,%ebx
8010209e:	74 67                	je     80102107 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020a0:	8b 43 58             	mov    0x58(%ebx),%eax
801020a3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a8:	8b 3b                	mov    (%ebx),%edi
801020aa:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020b0:	75 31                	jne    801020e3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c1:	89 c6                	mov    %eax,%esi
801020c3:	83 e6 c0             	and    $0xffffffc0,%esi
801020c6:	89 f1                	mov    %esi,%ecx
801020c8:	80 f9 40             	cmp    $0x40,%cl
801020cb:	75 f3                	jne    801020c0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020cd:	a8 21                	test   $0x21,%al
801020cf:	75 12                	jne    801020e3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020d1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020d4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020d9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020de:	fc                   	cld    
801020df:	f3 6d                	rep insl (%dx),%es:(%edi)
801020e1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020e6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020e9:	89 f9                	mov    %edi,%ecx
801020eb:	83 c9 02             	or     $0x2,%ecx
801020ee:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801020f0:	53                   	push   %ebx
801020f1:	e8 3a 1e 00 00       	call   80103f30 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020fb:	83 c4 10             	add    $0x10,%esp
801020fe:	85 c0                	test   %eax,%eax
80102100:	74 05                	je     80102107 <ideintr+0x87>
    idestart(idequeue);
80102102:	e8 19 fe ff ff       	call   80101f20 <idestart>
    release(&idelock);
80102107:	83 ec 0c             	sub    $0xc,%esp
8010210a:	68 80 a5 10 80       	push   $0x8010a580
8010210f:	e8 ec 24 00 00       	call   80104600 <release>

  release(&idelock);
}
80102114:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102117:	5b                   	pop    %ebx
80102118:	5e                   	pop    %esi
80102119:	5f                   	pop    %edi
8010211a:	5d                   	pop    %ebp
8010211b:	c3                   	ret    
8010211c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 10             	sub    $0x10,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	50                   	push   %eax
8010212e:	e8 7d 21 00 00       	call   801042b0 <holdingsleep>
80102133:	83 c4 10             	add    $0x10,%esp
80102136:	85 c0                	test   %eax,%eax
80102138:	0f 84 c6 00 00 00    	je     80102204 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213e:	8b 03                	mov    (%ebx),%eax
80102140:	83 e0 06             	and    $0x6,%eax
80102143:	83 f8 02             	cmp    $0x2,%eax
80102146:	0f 84 ab 00 00 00    	je     801021f7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214c:	8b 53 04             	mov    0x4(%ebx),%edx
8010214f:	85 d2                	test   %edx,%edx
80102151:	74 0d                	je     80102160 <iderw+0x40>
80102153:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102158:	85 c0                	test   %eax,%eax
8010215a:	0f 84 b1 00 00 00    	je     80102211 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102160:	83 ec 0c             	sub    $0xc,%esp
80102163:	68 80 a5 10 80       	push   $0x8010a580
80102168:	e8 03 23 00 00       	call   80104470 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102173:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102176:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	85 d2                	test   %edx,%edx
8010217f:	75 09                	jne    8010218a <iderw+0x6a>
80102181:	eb 6d                	jmp    801021f0 <iderw+0xd0>
80102183:	90                   	nop
80102184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102188:	89 c2                	mov    %eax,%edx
8010218a:	8b 42 58             	mov    0x58(%edx),%eax
8010218d:	85 c0                	test   %eax,%eax
8010218f:	75 f7                	jne    80102188 <iderw+0x68>
80102191:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102194:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102196:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010219c:	74 42                	je     801021e0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010219e:	8b 03                	mov    (%ebx),%eax
801021a0:	83 e0 06             	and    $0x6,%eax
801021a3:	83 f8 02             	cmp    $0x2,%eax
801021a6:	74 23                	je     801021cb <iderw+0xab>
801021a8:	90                   	nop
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021b0:	83 ec 08             	sub    $0x8,%esp
801021b3:	68 80 a5 10 80       	push   $0x8010a580
801021b8:	53                   	push   %ebx
801021b9:	e8 c2 1b 00 00       	call   80103d80 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 c4 10             	add    $0x10,%esp
801021c3:	83 e0 06             	and    $0x6,%eax
801021c6:	83 f8 02             	cmp    $0x2,%eax
801021c9:	75 e5                	jne    801021b0 <iderw+0x90>
  }


  release(&idelock);
801021cb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021d5:	c9                   	leave  
  release(&idelock);
801021d6:	e9 25 24 00 00       	jmp    80104600 <release>
801021db:	90                   	nop
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021e0:	89 d8                	mov    %ebx,%eax
801021e2:	e8 39 fd ff ff       	call   80101f20 <idestart>
801021e7:	eb b5                	jmp    8010219e <iderw+0x7e>
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021f0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021f5:	eb 9d                	jmp    80102194 <iderw+0x74>
    panic("iderw: nothing to do");
801021f7:	83 ec 0c             	sub    $0xc,%esp
801021fa:	68 20 74 10 80       	push   $0x80107420
801021ff:	e8 8c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102204:	83 ec 0c             	sub    $0xc,%esp
80102207:	68 0a 74 10 80       	push   $0x8010740a
8010220c:	e8 7f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102211:	83 ec 0c             	sub    $0xc,%esp
80102214:	68 35 74 10 80       	push   $0x80107435
80102219:	e8 72 e1 ff ff       	call   80100390 <panic>
8010221e:	66 90                	xchg   %ax,%ax

80102220 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102220:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102221:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102228:	00 c0 fe 
{
8010222b:	89 e5                	mov    %esp,%ebp
8010222d:	56                   	push   %esi
8010222e:	53                   	push   %ebx
  ioapic->reg = reg;
8010222f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102236:	00 00 00 
  return ioapic->data;
80102239:	a1 54 26 11 80       	mov    0x80112654,%eax
8010223e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102241:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102247:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010224d:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102254:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102257:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010225a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010225d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102260:	39 c2                	cmp    %eax,%edx
80102262:	74 16                	je     8010227a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102264:	83 ec 0c             	sub    $0xc,%esp
80102267:	68 54 74 10 80       	push   $0x80107454
8010226c:	e8 ef e3 ff ff       	call   80100660 <cprintf>
80102271:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102277:	83 c4 10             	add    $0x10,%esp
8010227a:	83 c3 21             	add    $0x21,%ebx
{
8010227d:	ba 10 00 00 00       	mov    $0x10,%edx
80102282:	b8 20 00 00 00       	mov    $0x20,%eax
80102287:	89 f6                	mov    %esi,%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102290:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102292:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102298:	89 c6                	mov    %eax,%esi
8010229a:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022a0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022a3:	89 71 10             	mov    %esi,0x10(%ecx)
801022a6:	8d 72 01             	lea    0x1(%edx),%esi
801022a9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022ac:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ae:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022b0:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801022b6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022bd:	75 d1                	jne    80102290 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022c2:	5b                   	pop    %ebx
801022c3:	5e                   	pop    %esi
801022c4:	5d                   	pop    %ebp
801022c5:	c3                   	ret    
801022c6:	8d 76 00             	lea    0x0(%esi),%esi
801022c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022d0:	55                   	push   %ebp
  ioapic->reg = reg;
801022d1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
{
801022d7:	89 e5                	mov    %esp,%ebp
801022d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022dc:	8d 50 20             	lea    0x20(%eax),%edx
801022df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022e5:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ee:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801022f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f6:	a1 54 26 11 80       	mov    0x80112654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801022fe:	89 50 10             	mov    %edx,0x10(%eax)
}
80102301:	5d                   	pop    %ebp
80102302:	c3                   	ret    
80102303:	66 90                	xchg   %ax,%ax
80102305:	66 90                	xchg   %ax,%ax
80102307:	66 90                	xchg   %ax,%ax
80102309:	66 90                	xchg   %ax,%ax
8010230b:	66 90                	xchg   %ax,%ax
8010230d:	66 90                	xchg   %ax,%ax
8010230f:	90                   	nop

80102310 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	53                   	push   %ebx
80102314:	83 ec 04             	sub    $0x4,%esp
80102317:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010231a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102320:	75 70                	jne    80102392 <kfree+0x82>
80102322:	81 fb c8 54 11 80    	cmp    $0x801154c8,%ebx
80102328:	72 68                	jb     80102392 <kfree+0x82>
8010232a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102330:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102335:	77 5b                	ja     80102392 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102337:	83 ec 04             	sub    $0x4,%esp
8010233a:	68 00 10 00 00       	push   $0x1000
8010233f:	6a 01                	push   $0x1
80102341:	53                   	push   %ebx
80102342:	e8 69 23 00 00       	call   801046b0 <memset>

  if(kmem.use_lock)
80102347:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	85 d2                	test   %edx,%edx
80102352:	75 2c                	jne    80102380 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102354:	a1 98 26 11 80       	mov    0x80112698,%eax
80102359:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010235b:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102360:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102366:	85 c0                	test   %eax,%eax
80102368:	75 06                	jne    80102370 <kfree+0x60>
    release(&kmem.lock);
}
8010236a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010236d:	c9                   	leave  
8010236e:	c3                   	ret    
8010236f:	90                   	nop
    release(&kmem.lock);
80102370:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
80102377:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237a:	c9                   	leave  
    release(&kmem.lock);
8010237b:	e9 80 22 00 00       	jmp    80104600 <release>
    acquire(&kmem.lock);
80102380:	83 ec 0c             	sub    $0xc,%esp
80102383:	68 60 26 11 80       	push   $0x80112660
80102388:	e8 e3 20 00 00       	call   80104470 <acquire>
8010238d:	83 c4 10             	add    $0x10,%esp
80102390:	eb c2                	jmp    80102354 <kfree+0x44>
    panic("kfree");
80102392:	83 ec 0c             	sub    $0xc,%esp
80102395:	68 86 74 10 80       	push   $0x80107486
8010239a:	e8 f1 df ff ff       	call   80100390 <panic>
8010239f:	90                   	nop

801023a0 <freerange>:
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	56                   	push   %esi
801023a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023bd:	39 de                	cmp    %ebx,%esi
801023bf:	72 23                	jb     801023e4 <freerange+0x44>
801023c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023c8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ce:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023d7:	50                   	push   %eax
801023d8:	e8 33 ff ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023dd:	83 c4 10             	add    $0x10,%esp
801023e0:	39 f3                	cmp    %esi,%ebx
801023e2:	76 e4                	jbe    801023c8 <freerange+0x28>
}
801023e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023e7:	5b                   	pop    %ebx
801023e8:	5e                   	pop    %esi
801023e9:	5d                   	pop    %ebp
801023ea:	c3                   	ret    
801023eb:	90                   	nop
801023ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023f0 <kinit1>:
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
801023f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023f8:	83 ec 08             	sub    $0x8,%esp
801023fb:	68 8c 74 10 80       	push   $0x8010748c
80102400:	68 60 26 11 80       	push   $0x80112660
80102405:	e8 f6 1e 00 00       	call   80104300 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010240a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102410:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102417:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102420:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102426:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010242c:	39 de                	cmp    %ebx,%esi
8010242e:	72 1c                	jb     8010244c <kinit1+0x5c>
    kfree(p);
80102430:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102436:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102439:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010243f:	50                   	push   %eax
80102440:	e8 cb fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102445:	83 c4 10             	add    $0x10,%esp
80102448:	39 de                	cmp    %ebx,%esi
8010244a:	73 e4                	jae    80102430 <kinit1+0x40>
}
8010244c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010244f:	5b                   	pop    %ebx
80102450:	5e                   	pop    %esi
80102451:	5d                   	pop    %ebp
80102452:	c3                   	ret    
80102453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102460 <kinit2>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102468:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010246b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102471:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102477:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010247d:	39 de                	cmp    %ebx,%esi
8010247f:	72 23                	jb     801024a4 <kinit2+0x44>
80102481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102488:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010248e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102491:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102497:	50                   	push   %eax
80102498:	e8 73 fe ff ff       	call   80102310 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249d:	83 c4 10             	add    $0x10,%esp
801024a0:	39 de                	cmp    %ebx,%esi
801024a2:	73 e4                	jae    80102488 <kinit2+0x28>
  kmem.use_lock = 1;
801024a4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024ab:	00 00 00 
}
801024ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024b1:	5b                   	pop    %ebx
801024b2:	5e                   	pop    %esi
801024b3:	5d                   	pop    %ebp
801024b4:	c3                   	ret    
801024b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024c0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024c0:	a1 94 26 11 80       	mov    0x80112694,%eax
801024c5:	85 c0                	test   %eax,%eax
801024c7:	75 1f                	jne    801024e8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024c9:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
801024ce:	85 c0                	test   %eax,%eax
801024d0:	74 0e                	je     801024e0 <kalloc+0x20>
    kmem.freelist = r->next;
801024d2:	8b 10                	mov    (%eax),%edx
801024d4:	89 15 98 26 11 80    	mov    %edx,0x80112698
801024da:	c3                   	ret    
801024db:	90                   	nop
801024dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024e0:	f3 c3                	repz ret 
801024e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024e8:	55                   	push   %ebp
801024e9:	89 e5                	mov    %esp,%ebp
801024eb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024ee:	68 60 26 11 80       	push   $0x80112660
801024f3:	e8 78 1f 00 00       	call   80104470 <acquire>
  r = kmem.freelist;
801024f8:	a1 98 26 11 80       	mov    0x80112698,%eax
  if(r)
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102506:	85 c0                	test   %eax,%eax
80102508:	74 08                	je     80102512 <kalloc+0x52>
    kmem.freelist = r->next;
8010250a:	8b 08                	mov    (%eax),%ecx
8010250c:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
  if(kmem.use_lock)
80102512:	85 d2                	test   %edx,%edx
80102514:	74 16                	je     8010252c <kalloc+0x6c>
    release(&kmem.lock);
80102516:	83 ec 0c             	sub    $0xc,%esp
80102519:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010251c:	68 60 26 11 80       	push   $0x80112660
80102521:	e8 da 20 00 00       	call   80104600 <release>
  return (char*)r;
80102526:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102529:	83 c4 10             	add    $0x10,%esp
}
8010252c:	c9                   	leave  
8010252d:	c3                   	ret    
8010252e:	66 90                	xchg   %ax,%ax

80102530 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102530:	ba 64 00 00 00       	mov    $0x64,%edx
80102535:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102536:	a8 01                	test   $0x1,%al
80102538:	0f 84 c2 00 00 00    	je     80102600 <kbdgetc+0xd0>
8010253e:	ba 60 00 00 00       	mov    $0x60,%edx
80102543:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102544:	0f b6 d0             	movzbl %al,%edx
80102547:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010254d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102553:	0f 84 7f 00 00 00    	je     801025d8 <kbdgetc+0xa8>
{
80102559:	55                   	push   %ebp
8010255a:	89 e5                	mov    %esp,%ebp
8010255c:	53                   	push   %ebx
8010255d:	89 cb                	mov    %ecx,%ebx
8010255f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102562:	84 c0                	test   %al,%al
80102564:	78 4a                	js     801025b0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102566:	85 db                	test   %ebx,%ebx
80102568:	74 09                	je     80102573 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010256a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010256d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102570:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102573:	0f b6 82 c0 75 10 80 	movzbl -0x7fef8a40(%edx),%eax
8010257a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010257c:	0f b6 82 c0 74 10 80 	movzbl -0x7fef8b40(%edx),%eax
80102583:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102585:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102587:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010258d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102590:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102593:	8b 04 85 a0 74 10 80 	mov    -0x7fef8b60(,%eax,4),%eax
8010259a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010259e:	74 31                	je     801025d1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025a0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025a3:	83 fa 19             	cmp    $0x19,%edx
801025a6:	77 40                	ja     801025e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025a8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025ab:	5b                   	pop    %ebx
801025ac:	5d                   	pop    %ebp
801025ad:	c3                   	ret    
801025ae:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025b0:	83 e0 7f             	and    $0x7f,%eax
801025b3:	85 db                	test   %ebx,%ebx
801025b5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025b8:	0f b6 82 c0 75 10 80 	movzbl -0x7fef8a40(%edx),%eax
801025bf:	83 c8 40             	or     $0x40,%eax
801025c2:	0f b6 c0             	movzbl %al,%eax
801025c5:	f7 d0                	not    %eax
801025c7:	21 c1                	and    %eax,%ecx
    return 0;
801025c9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025cb:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025d1:	5b                   	pop    %ebx
801025d2:	5d                   	pop    %ebp
801025d3:	c3                   	ret    
801025d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025d8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025db:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025dd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025eb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025ee:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ef:	83 f9 1a             	cmp    $0x1a,%ecx
801025f2:	0f 42 c2             	cmovb  %edx,%eax
}
801025f5:	5d                   	pop    %ebp
801025f6:	c3                   	ret    
801025f7:	89 f6                	mov    %esi,%esi
801025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102605:	c3                   	ret    
80102606:	8d 76 00             	lea    0x0(%esi),%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102610 <kbdintr>:

void
kbdintr(void)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102616:	68 30 25 10 80       	push   $0x80102530
8010261b:	e8 f0 e1 ff ff       	call   80100810 <consoleintr>
}
80102620:	83 c4 10             	add    $0x10,%esp
80102623:	c9                   	leave  
80102624:	c3                   	ret    
80102625:	66 90                	xchg   %ax,%ax
80102627:	66 90                	xchg   %ax,%ax
80102629:	66 90                	xchg   %ax,%ax
8010262b:	66 90                	xchg   %ax,%ax
8010262d:	66 90                	xchg   %ax,%ax
8010262f:	90                   	nop

80102630 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102630:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102635:	55                   	push   %ebp
80102636:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102638:	85 c0                	test   %eax,%eax
8010263a:	0f 84 c8 00 00 00    	je     80102708 <lapicinit+0xd8>
  lapic[index] = value;
80102640:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102647:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010264a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010264d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102654:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102657:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102661:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102664:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102667:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010266e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102671:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102674:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010267b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010267e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102681:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102688:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010268e:	8b 50 30             	mov    0x30(%eax),%edx
80102691:	c1 ea 10             	shr    $0x10,%edx
80102694:	80 fa 03             	cmp    $0x3,%dl
80102697:	77 77                	ja     80102710 <lapicinit+0xe0>
  lapic[index] = value;
80102699:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026a0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026cd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026da:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026e1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026e4:	8b 50 20             	mov    0x20(%eax),%edx
801026e7:	89 f6                	mov    %esi,%esi
801026e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026f0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026f6:	80 e6 10             	and    $0x10,%dh
801026f9:	75 f5                	jne    801026f0 <lapicinit+0xc0>
  lapic[index] = value;
801026fb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102702:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102705:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102708:	5d                   	pop    %ebp
80102709:	c3                   	ret    
8010270a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102710:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102717:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010271a:	8b 50 20             	mov    0x20(%eax),%edx
8010271d:	e9 77 ff ff ff       	jmp    80102699 <lapicinit+0x69>
80102722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102730 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102730:	8b 15 9c 26 11 80    	mov    0x8011269c,%edx
{
80102736:	55                   	push   %ebp
80102737:	31 c0                	xor    %eax,%eax
80102739:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010273b:	85 d2                	test   %edx,%edx
8010273d:	74 06                	je     80102745 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010273f:	8b 42 20             	mov    0x20(%edx),%eax
80102742:	c1 e8 18             	shr    $0x18,%eax
}
80102745:	5d                   	pop    %ebp
80102746:	c3                   	ret    
80102747:	89 f6                	mov    %esi,%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102750:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102755:	55                   	push   %ebp
80102756:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102758:	85 c0                	test   %eax,%eax
8010275a:	74 0d                	je     80102769 <lapiceoi+0x19>
  lapic[index] = value;
8010275c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102763:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102766:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret    
8010276b:	90                   	nop
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102770 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
}
80102773:	5d                   	pop    %ebp
80102774:	c3                   	ret    
80102775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102780:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102781:	b8 0f 00 00 00       	mov    $0xf,%eax
80102786:	ba 70 00 00 00       	mov    $0x70,%edx
8010278b:	89 e5                	mov    %esp,%ebp
8010278d:	53                   	push   %ebx
8010278e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102791:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102794:	ee                   	out    %al,(%dx)
80102795:	b8 0a 00 00 00       	mov    $0xa,%eax
8010279a:	ba 71 00 00 00       	mov    $0x71,%edx
8010279f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027a0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027a2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027a5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027ab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027ad:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027b0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027b3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027b5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027b8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027be:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027c3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027cc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027d3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027d9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027e0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027e6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102801:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010280a:	5b                   	pop    %ebx
8010280b:	5d                   	pop    %ebp
8010280c:	c3                   	ret    
8010280d:	8d 76 00             	lea    0x0(%esi),%esi

80102810 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102810:	55                   	push   %ebp
80102811:	b8 0b 00 00 00       	mov    $0xb,%eax
80102816:	ba 70 00 00 00       	mov    $0x70,%edx
8010281b:	89 e5                	mov    %esp,%ebp
8010281d:	57                   	push   %edi
8010281e:	56                   	push   %esi
8010281f:	53                   	push   %ebx
80102820:	83 ec 4c             	sub    $0x4c,%esp
80102823:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102824:	ba 71 00 00 00       	mov    $0x71,%edx
80102829:	ec                   	in     (%dx),%al
8010282a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010282d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102832:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102835:	8d 76 00             	lea    0x0(%esi),%esi
80102838:	31 c0                	xor    %eax,%eax
8010283a:	89 da                	mov    %ebx,%edx
8010283c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102842:	89 ca                	mov    %ecx,%edx
80102844:	ec                   	in     (%dx),%al
80102845:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102848:	89 da                	mov    %ebx,%edx
8010284a:	b8 02 00 00 00       	mov    $0x2,%eax
8010284f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102850:	89 ca                	mov    %ecx,%edx
80102852:	ec                   	in     (%dx),%al
80102853:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102856:	89 da                	mov    %ebx,%edx
80102858:	b8 04 00 00 00       	mov    $0x4,%eax
8010285d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285e:	89 ca                	mov    %ecx,%edx
80102860:	ec                   	in     (%dx),%al
80102861:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102864:	89 da                	mov    %ebx,%edx
80102866:	b8 07 00 00 00       	mov    $0x7,%eax
8010286b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286c:	89 ca                	mov    %ecx,%edx
8010286e:	ec                   	in     (%dx),%al
8010286f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102872:	89 da                	mov    %ebx,%edx
80102874:	b8 08 00 00 00       	mov    $0x8,%eax
80102879:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287a:	89 ca                	mov    %ecx,%edx
8010287c:	ec                   	in     (%dx),%al
8010287d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010287f:	89 da                	mov    %ebx,%edx
80102881:	b8 09 00 00 00       	mov    $0x9,%eax
80102886:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102887:	89 ca                	mov    %ecx,%edx
80102889:	ec                   	in     (%dx),%al
8010288a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288c:	89 da                	mov    %ebx,%edx
8010288e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102893:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102894:	89 ca                	mov    %ecx,%edx
80102896:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102897:	84 c0                	test   %al,%al
80102899:	78 9d                	js     80102838 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010289b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010289f:	89 fa                	mov    %edi,%edx
801028a1:	0f b6 fa             	movzbl %dl,%edi
801028a4:	89 f2                	mov    %esi,%edx
801028a6:	0f b6 f2             	movzbl %dl,%esi
801028a9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028b1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028b4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028b8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028bb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028bf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028c2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028c9:	31 c0                	xor    %eax,%eax
801028cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cc:	89 ca                	mov    %ecx,%edx
801028ce:	ec                   	in     (%dx),%al
801028cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d2:	89 da                	mov    %ebx,%edx
801028d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028d7:	b8 02 00 00 00       	mov    $0x2,%eax
801028dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dd:	89 ca                	mov    %ecx,%edx
801028df:	ec                   	in     (%dx),%al
801028e0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e3:	89 da                	mov    %ebx,%edx
801028e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028e8:	b8 04 00 00 00       	mov    $0x4,%eax
801028ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ee:	89 ca                	mov    %ecx,%edx
801028f0:	ec                   	in     (%dx),%al
801028f1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f4:	89 da                	mov    %ebx,%edx
801028f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028f9:	b8 07 00 00 00       	mov    $0x7,%eax
801028fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ff:	89 ca                	mov    %ecx,%edx
80102901:	ec                   	in     (%dx),%al
80102902:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102905:	89 da                	mov    %ebx,%edx
80102907:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010290a:	b8 08 00 00 00       	mov    $0x8,%eax
8010290f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102910:	89 ca                	mov    %ecx,%edx
80102912:	ec                   	in     (%dx),%al
80102913:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102916:	89 da                	mov    %ebx,%edx
80102918:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010291b:	b8 09 00 00 00       	mov    $0x9,%eax
80102920:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102921:	89 ca                	mov    %ecx,%edx
80102923:	ec                   	in     (%dx),%al
80102924:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102927:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010292a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010292d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102930:	6a 18                	push   $0x18
80102932:	50                   	push   %eax
80102933:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102936:	50                   	push   %eax
80102937:	e8 c4 1d 00 00       	call   80104700 <memcmp>
8010293c:	83 c4 10             	add    $0x10,%esp
8010293f:	85 c0                	test   %eax,%eax
80102941:	0f 85 f1 fe ff ff    	jne    80102838 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102947:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010294b:	75 78                	jne    801029c5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010294d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102950:	89 c2                	mov    %eax,%edx
80102952:	83 e0 0f             	and    $0xf,%eax
80102955:	c1 ea 04             	shr    $0x4,%edx
80102958:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010295b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102961:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102964:	89 c2                	mov    %eax,%edx
80102966:	83 e0 0f             	and    $0xf,%eax
80102969:	c1 ea 04             	shr    $0x4,%edx
8010296c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102972:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102975:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102978:	89 c2                	mov    %eax,%edx
8010297a:	83 e0 0f             	and    $0xf,%eax
8010297d:	c1 ea 04             	shr    $0x4,%edx
80102980:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102983:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102986:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102989:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010298c:	89 c2                	mov    %eax,%edx
8010298e:	83 e0 0f             	and    $0xf,%eax
80102991:	c1 ea 04             	shr    $0x4,%edx
80102994:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102997:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010299a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010299d:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029a0:	89 c2                	mov    %eax,%edx
801029a2:	83 e0 0f             	and    $0xf,%eax
801029a5:	c1 ea 04             	shr    $0x4,%edx
801029a8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029ab:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b4:	89 c2                	mov    %eax,%edx
801029b6:	83 e0 0f             	and    $0xf,%eax
801029b9:	c1 ea 04             	shr    $0x4,%edx
801029bc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029c2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029c5:	8b 75 08             	mov    0x8(%ebp),%esi
801029c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029cb:	89 06                	mov    %eax,(%esi)
801029cd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029d0:	89 46 04             	mov    %eax,0x4(%esi)
801029d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029d6:	89 46 08             	mov    %eax,0x8(%esi)
801029d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029dc:	89 46 0c             	mov    %eax,0xc(%esi)
801029df:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029e2:	89 46 10             	mov    %eax,0x10(%esi)
801029e5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029e8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029eb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029f5:	5b                   	pop    %ebx
801029f6:	5e                   	pop    %esi
801029f7:	5f                   	pop    %edi
801029f8:	5d                   	pop    %ebp
801029f9:	c3                   	ret    
801029fa:	66 90                	xchg   %ax,%ax
801029fc:	66 90                	xchg   %ax,%ax
801029fe:	66 90                	xchg   %ax,%ax

80102a00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a00:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102a06:	85 c9                	test   %ecx,%ecx
80102a08:	0f 8e 8a 00 00 00    	jle    80102a98 <install_trans+0x98>
{
80102a0e:	55                   	push   %ebp
80102a0f:	89 e5                	mov    %esp,%ebp
80102a11:	57                   	push   %edi
80102a12:	56                   	push   %esi
80102a13:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a14:	31 db                	xor    %ebx,%ebx
{
80102a16:	83 ec 0c             	sub    $0xc,%esp
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a20:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102a25:	83 ec 08             	sub    $0x8,%esp
80102a28:	01 d8                	add    %ebx,%eax
80102a2a:	83 c0 01             	add    $0x1,%eax
80102a2d:	50                   	push   %eax
80102a2e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102a34:	e8 97 d6 ff ff       	call   801000d0 <bread>
80102a39:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a3b:	58                   	pop    %eax
80102a3c:	5a                   	pop    %edx
80102a3d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102a44:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102a4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4d:	e8 7e d6 ff ff       	call   801000d0 <bread>
80102a52:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a54:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a57:	83 c4 0c             	add    $0xc,%esp
80102a5a:	68 00 02 00 00       	push   $0x200
80102a5f:	50                   	push   %eax
80102a60:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a63:	50                   	push   %eax
80102a64:	e8 f7 1c 00 00       	call   80104760 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a69:	89 34 24             	mov    %esi,(%esp)
80102a6c:	e8 2f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a71:	89 3c 24             	mov    %edi,(%esp)
80102a74:	e8 67 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 5f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a81:	83 c4 10             	add    $0x10,%esp
80102a84:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102a8a:	7f 94                	jg     80102a20 <install_trans+0x20>
  }
}
80102a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a8f:	5b                   	pop    %ebx
80102a90:	5e                   	pop    %esi
80102a91:	5f                   	pop    %edi
80102a92:	5d                   	pop    %ebp
80102a93:	c3                   	ret    
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a98:	f3 c3                	repz ret 
80102a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102aa0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	56                   	push   %esi
80102aa4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102aa5:	83 ec 08             	sub    $0x8,%esp
80102aa8:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102aae:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ab4:	e8 17 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ab9:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102abf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ac2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ac4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ac6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ac9:	7e 16                	jle    80102ae1 <write_head+0x41>
80102acb:	c1 e3 02             	shl    $0x2,%ebx
80102ace:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ad0:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102ad6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102ada:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102add:	39 da                	cmp    %ebx,%edx
80102adf:	75 ef                	jne    80102ad0 <write_head+0x30>
  }
  bwrite(buf);
80102ae1:	83 ec 0c             	sub    $0xc,%esp
80102ae4:	56                   	push   %esi
80102ae5:	e8 b6 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102aea:	89 34 24             	mov    %esi,(%esp)
80102aed:	e8 ee d6 ff ff       	call   801001e0 <brelse>
}
80102af2:	83 c4 10             	add    $0x10,%esp
80102af5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102af8:	5b                   	pop    %ebx
80102af9:	5e                   	pop    %esi
80102afa:	5d                   	pop    %ebp
80102afb:	c3                   	ret    
80102afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b00 <initlog>:
{
80102b00:	55                   	push   %ebp
80102b01:	89 e5                	mov    %esp,%ebp
80102b03:	53                   	push   %ebx
80102b04:	83 ec 2c             	sub    $0x2c,%esp
80102b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b0a:	68 c0 76 10 80       	push   $0x801076c0
80102b0f:	68 a0 26 11 80       	push   $0x801126a0
80102b14:	e8 e7 17 00 00       	call   80104300 <initlock>
  readsb(dev, &sb);
80102b19:	58                   	pop    %eax
80102b1a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b1d:	5a                   	pop    %edx
80102b1e:	50                   	push   %eax
80102b1f:	53                   	push   %ebx
80102b20:	e8 1b e9 ff ff       	call   80101440 <readsb>
  log.size = sb.nlog;
80102b25:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b28:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b2b:	59                   	pop    %ecx
  log.dev = dev;
80102b2c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102b32:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102b38:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 8b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b45:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b48:	83 c4 10             	add    $0x10,%esp
80102b4b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b4d:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102b53:	7e 1c                	jle    80102b71 <initlog+0x71>
80102b55:	c1 e3 02             	shl    $0x2,%ebx
80102b58:	31 d2                	xor    %edx,%edx
80102b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b60:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b64:	83 c2 04             	add    $0x4,%edx
80102b67:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b6d:	39 d3                	cmp    %edx,%ebx
80102b6f:	75 ef                	jne    80102b60 <initlog+0x60>
  brelse(buf);
80102b71:	83 ec 0c             	sub    $0xc,%esp
80102b74:	50                   	push   %eax
80102b75:	e8 66 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b7a:	e8 81 fe ff ff       	call   80102a00 <install_trans>
  log.lh.n = 0;
80102b7f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102b86:	00 00 00 
  write_head(); // clear the log
80102b89:	e8 12 ff ff ff       	call   80102aa0 <write_head>
}
80102b8e:	83 c4 10             	add    $0x10,%esp
80102b91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b94:	c9                   	leave  
80102b95:	c3                   	ret    
80102b96:	8d 76 00             	lea    0x0(%esi),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ba0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102ba6:	68 a0 26 11 80       	push   $0x801126a0
80102bab:	e8 c0 18 00 00       	call   80104470 <acquire>
80102bb0:	83 c4 10             	add    $0x10,%esp
80102bb3:	eb 18                	jmp    80102bcd <begin_op+0x2d>
80102bb5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bb8:	83 ec 08             	sub    $0x8,%esp
80102bbb:	68 a0 26 11 80       	push   $0x801126a0
80102bc0:	68 a0 26 11 80       	push   $0x801126a0
80102bc5:	e8 b6 11 00 00       	call   80103d80 <sleep>
80102bca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bcd:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102bd2:	85 c0                	test   %eax,%eax
80102bd4:	75 e2                	jne    80102bb8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bd6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102bdb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102be1:	83 c0 01             	add    $0x1,%eax
80102be4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102be7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bea:	83 fa 1e             	cmp    $0x1e,%edx
80102bed:	7f c9                	jg     80102bb8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102bf2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102bf7:	68 a0 26 11 80       	push   $0x801126a0
80102bfc:	e8 ff 19 00 00       	call   80104600 <release>
      break;
    }
  }
}
80102c01:	83 c4 10             	add    $0x10,%esp
80102c04:	c9                   	leave  
80102c05:	c3                   	ret    
80102c06:	8d 76 00             	lea    0x0(%esi),%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c10 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	57                   	push   %edi
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
80102c16:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c19:	68 a0 26 11 80       	push   $0x801126a0
80102c1e:	e8 4d 18 00 00       	call   80104470 <acquire>
  log.outstanding -= 1;
80102c23:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102c28:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102c2e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c31:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c34:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c36:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102c3c:	0f 85 1a 01 00 00    	jne    80102d5c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c42:	85 db                	test   %ebx,%ebx
80102c44:	0f 85 ee 00 00 00    	jne    80102d38 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c4a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c4d:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102c54:	00 00 00 
  release(&log.lock);
80102c57:	68 a0 26 11 80       	push   $0x801126a0
80102c5c:	e8 9f 19 00 00       	call   80104600 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c61:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102c67:	83 c4 10             	add    $0x10,%esp
80102c6a:	85 c9                	test   %ecx,%ecx
80102c6c:	0f 8e 85 00 00 00    	jle    80102cf7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c72:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c77:	83 ec 08             	sub    $0x8,%esp
80102c7a:	01 d8                	add    %ebx,%eax
80102c7c:	83 c0 01             	add    $0x1,%eax
80102c7f:	50                   	push   %eax
80102c80:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102c86:	e8 45 d4 ff ff       	call   801000d0 <bread>
80102c8b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c8d:	58                   	pop    %eax
80102c8e:	5a                   	pop    %edx
80102c8f:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102c96:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c9c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c9f:	e8 2c d4 ff ff       	call   801000d0 <bread>
80102ca4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ca6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ca9:	83 c4 0c             	add    $0xc,%esp
80102cac:	68 00 02 00 00       	push   $0x200
80102cb1:	50                   	push   %eax
80102cb2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cb5:	50                   	push   %eax
80102cb6:	e8 a5 1a 00 00       	call   80104760 <memmove>
    bwrite(to);  // write the log
80102cbb:	89 34 24             	mov    %esi,(%esp)
80102cbe:	e8 dd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cc3:	89 3c 24             	mov    %edi,(%esp)
80102cc6:	e8 15 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ccb:	89 34 24             	mov    %esi,(%esp)
80102cce:	e8 0d d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cd3:	83 c4 10             	add    $0x10,%esp
80102cd6:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102cdc:	7c 94                	jl     80102c72 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cde:	e8 bd fd ff ff       	call   80102aa0 <write_head>
    install_trans(); // Now install writes to home locations
80102ce3:	e8 18 fd ff ff       	call   80102a00 <install_trans>
    log.lh.n = 0;
80102ce8:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102cef:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cf2:	e8 a9 fd ff ff       	call   80102aa0 <write_head>
    acquire(&log.lock);
80102cf7:	83 ec 0c             	sub    $0xc,%esp
80102cfa:	68 a0 26 11 80       	push   $0x801126a0
80102cff:	e8 6c 17 00 00       	call   80104470 <acquire>
    wakeup(&log);
80102d04:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102d0b:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d12:	00 00 00 
    wakeup(&log);
80102d15:	e8 16 12 00 00       	call   80103f30 <wakeup>
    release(&log.lock);
80102d1a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d21:	e8 da 18 00 00       	call   80104600 <release>
80102d26:	83 c4 10             	add    $0x10,%esp
}
80102d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d2c:	5b                   	pop    %ebx
80102d2d:	5e                   	pop    %esi
80102d2e:	5f                   	pop    %edi
80102d2f:	5d                   	pop    %ebp
80102d30:	c3                   	ret    
80102d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d38:	83 ec 0c             	sub    $0xc,%esp
80102d3b:	68 a0 26 11 80       	push   $0x801126a0
80102d40:	e8 eb 11 00 00       	call   80103f30 <wakeup>
  release(&log.lock);
80102d45:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d4c:	e8 af 18 00 00       	call   80104600 <release>
80102d51:	83 c4 10             	add    $0x10,%esp
}
80102d54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d57:	5b                   	pop    %ebx
80102d58:	5e                   	pop    %esi
80102d59:	5f                   	pop    %edi
80102d5a:	5d                   	pop    %ebp
80102d5b:	c3                   	ret    
    panic("log.committing");
80102d5c:	83 ec 0c             	sub    $0xc,%esp
80102d5f:	68 c4 76 10 80       	push   $0x801076c4
80102d64:	e8 27 d6 ff ff       	call   80100390 <panic>
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d70 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	53                   	push   %ebx
80102d74:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d77:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102d7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d80:	83 fa 1d             	cmp    $0x1d,%edx
80102d83:	0f 8f 9d 00 00 00    	jg     80102e26 <log_write+0xb6>
80102d89:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102d8e:	83 e8 01             	sub    $0x1,%eax
80102d91:	39 c2                	cmp    %eax,%edx
80102d93:	0f 8d 8d 00 00 00    	jge    80102e26 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d99:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d9e:	85 c0                	test   %eax,%eax
80102da0:	0f 8e 8d 00 00 00    	jle    80102e33 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102da6:	83 ec 0c             	sub    $0xc,%esp
80102da9:	68 a0 26 11 80       	push   $0x801126a0
80102dae:	e8 bd 16 00 00       	call   80104470 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102db3:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102db9:	83 c4 10             	add    $0x10,%esp
80102dbc:	83 f9 00             	cmp    $0x0,%ecx
80102dbf:	7e 57                	jle    80102e18 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102dc4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dc6:	3b 15 ec 26 11 80    	cmp    0x801126ec,%edx
80102dcc:	75 0b                	jne    80102dd9 <log_write+0x69>
80102dce:	eb 38                	jmp    80102e08 <log_write+0x98>
80102dd0:	39 14 85 ec 26 11 80 	cmp    %edx,-0x7feed914(,%eax,4)
80102dd7:	74 2f                	je     80102e08 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102dd9:	83 c0 01             	add    $0x1,%eax
80102ddc:	39 c1                	cmp    %eax,%ecx
80102dde:	75 f0                	jne    80102dd0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102de0:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102de7:	83 c0 01             	add    $0x1,%eax
80102dea:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102def:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102df2:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102df9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dfc:	c9                   	leave  
  release(&log.lock);
80102dfd:	e9 fe 17 00 00       	jmp    80104600 <release>
80102e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e08:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
80102e0f:	eb de                	jmp    80102def <log_write+0x7f>
80102e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e18:	8b 43 08             	mov    0x8(%ebx),%eax
80102e1b:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102e20:	75 cd                	jne    80102def <log_write+0x7f>
80102e22:	31 c0                	xor    %eax,%eax
80102e24:	eb c1                	jmp    80102de7 <log_write+0x77>
    panic("too big a transaction");
80102e26:	83 ec 0c             	sub    $0xc,%esp
80102e29:	68 d3 76 10 80       	push   $0x801076d3
80102e2e:	e8 5d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e33:	83 ec 0c             	sub    $0xc,%esp
80102e36:	68 e9 76 10 80       	push   $0x801076e9
80102e3b:	e8 50 d5 ff ff       	call   80100390 <panic>

80102e40 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e40:	55                   	push   %ebp
80102e41:	89 e5                	mov    %esp,%ebp
80102e43:	53                   	push   %ebx
80102e44:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e47:	e8 74 09 00 00       	call   801037c0 <cpuid>
80102e4c:	89 c3                	mov    %eax,%ebx
80102e4e:	e8 6d 09 00 00       	call   801037c0 <cpuid>
80102e53:	83 ec 04             	sub    $0x4,%esp
80102e56:	53                   	push   %ebx
80102e57:	50                   	push   %eax
80102e58:	68 04 77 10 80       	push   $0x80107704
80102e5d:	e8 fe d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e62:	e8 c9 2b 00 00       	call   80105a30 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e67:	e8 d4 08 00 00       	call   80103740 <mycpu>
80102e6c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e6e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e73:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e7a:	e8 21 0c 00 00       	call   80103aa0 <scheduler>
80102e7f:	90                   	nop

80102e80 <mpenter>:
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e86:	e8 95 3c 00 00       	call   80106b20 <switchkvm>
  seginit();
80102e8b:	e8 00 3c 00 00       	call   80106a90 <seginit>
  lapicinit();
80102e90:	e8 9b f7 ff ff       	call   80102630 <lapicinit>
  mpmain();
80102e95:	e8 a6 ff ff ff       	call   80102e40 <mpmain>
80102e9a:	66 90                	xchg   %ax,%ax
80102e9c:	66 90                	xchg   %ax,%ax
80102e9e:	66 90                	xchg   %ax,%ax

80102ea0 <main>:
{
80102ea0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ea4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ea7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eaa:	55                   	push   %ebp
80102eab:	89 e5                	mov    %esp,%ebp
80102ead:	53                   	push   %ebx
80102eae:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102eaf:	83 ec 08             	sub    $0x8,%esp
80102eb2:	68 00 00 40 80       	push   $0x80400000
80102eb7:	68 c8 54 11 80       	push   $0x801154c8
80102ebc:	e8 2f f5 ff ff       	call   801023f0 <kinit1>
  kvmalloc();      // kernel page table
80102ec1:	e8 2a 41 00 00       	call   80106ff0 <kvmalloc>
  mpinit();        // detect other processors
80102ec6:	e8 75 01 00 00       	call   80103040 <mpinit>
  lapicinit();     // interrupt controller
80102ecb:	e8 60 f7 ff ff       	call   80102630 <lapicinit>
  seginit();       // segment descriptors
80102ed0:	e8 bb 3b 00 00       	call   80106a90 <seginit>
  picinit();       // disable pic
80102ed5:	e8 46 03 00 00       	call   80103220 <picinit>
  ioapicinit();    // another interrupt controller
80102eda:	e8 41 f3 ff ff       	call   80102220 <ioapicinit>
  consoleinit();   // console hardware
80102edf:	e8 dc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102ee4:	e8 77 2e 00 00       	call   80105d60 <uartinit>
  pinit();         // process table
80102ee9:	e8 32 08 00 00       	call   80103720 <pinit>
  tvinit();        // trap vectors
80102eee:	e8 bd 2a 00 00       	call   801059b0 <tvinit>
  binit();         // buffer cache
80102ef3:	e8 48 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ef8:	e8 63 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102efd:	e8 fe f0 ff ff       	call   80102000 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f02:	83 c4 0c             	add    $0xc,%esp
80102f05:	68 8a 00 00 00       	push   $0x8a
80102f0a:	68 8c a4 10 80       	push   $0x8010a48c
80102f0f:	68 00 70 00 80       	push   $0x80007000
80102f14:	e8 47 18 00 00       	call   80104760 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f19:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102f20:	00 00 00 
80102f23:	83 c4 10             	add    $0x10,%esp
80102f26:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f2b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80102f30:	76 71                	jbe    80102fa3 <main+0x103>
80102f32:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80102f37:	89 f6                	mov    %esi,%esi
80102f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f40:	e8 fb 07 00 00       	call   80103740 <mycpu>
80102f45:	39 d8                	cmp    %ebx,%eax
80102f47:	74 41                	je     80102f8a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f49:	e8 72 f5 ff ff       	call   801024c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f4e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f53:	c7 05 f8 6f 00 80 80 	movl   $0x80102e80,0x80006ff8
80102f5a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f5d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f64:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f67:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f6c:	0f b6 03             	movzbl (%ebx),%eax
80102f6f:	83 ec 08             	sub    $0x8,%esp
80102f72:	68 00 70 00 00       	push   $0x7000
80102f77:	50                   	push   %eax
80102f78:	e8 03 f8 ff ff       	call   80102780 <lapicstartap>
80102f7d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f80:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f86:	85 c0                	test   %eax,%eax
80102f88:	74 f6                	je     80102f80 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f8a:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102f91:	00 00 00 
80102f94:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f9a:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f9f:	39 c3                	cmp    %eax,%ebx
80102fa1:	72 9d                	jb     80102f40 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fa3:	83 ec 08             	sub    $0x8,%esp
80102fa6:	68 00 00 00 8e       	push   $0x8e000000
80102fab:	68 00 00 40 80       	push   $0x80400000
80102fb0:	e8 ab f4 ff ff       	call   80102460 <kinit2>
  userinit();      // first user process
80102fb5:	e8 56 08 00 00       	call   80103810 <userinit>
  mpmain();        // finish this processor's setup
80102fba:	e8 81 fe ff ff       	call   80102e40 <mpmain>
80102fbf:	90                   	nop

80102fc0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	57                   	push   %edi
80102fc4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fc5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102fcb:	53                   	push   %ebx
  e = addr+len;
80102fcc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fcf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102fd2:	39 de                	cmp    %ebx,%esi
80102fd4:	72 10                	jb     80102fe6 <mpsearch1+0x26>
80102fd6:	eb 50                	jmp    80103028 <mpsearch1+0x68>
80102fd8:	90                   	nop
80102fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe0:	39 fb                	cmp    %edi,%ebx
80102fe2:	89 fe                	mov    %edi,%esi
80102fe4:	76 42                	jbe    80103028 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fe6:	83 ec 04             	sub    $0x4,%esp
80102fe9:	8d 7e 10             	lea    0x10(%esi),%edi
80102fec:	6a 04                	push   $0x4
80102fee:	68 18 77 10 80       	push   $0x80107718
80102ff3:	56                   	push   %esi
80102ff4:	e8 07 17 00 00       	call   80104700 <memcmp>
80102ff9:	83 c4 10             	add    $0x10,%esp
80102ffc:	85 c0                	test   %eax,%eax
80102ffe:	75 e0                	jne    80102fe0 <mpsearch1+0x20>
80103000:	89 f1                	mov    %esi,%ecx
80103002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103008:	0f b6 11             	movzbl (%ecx),%edx
8010300b:	83 c1 01             	add    $0x1,%ecx
8010300e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103010:	39 f9                	cmp    %edi,%ecx
80103012:	75 f4                	jne    80103008 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103014:	84 c0                	test   %al,%al
80103016:	75 c8                	jne    80102fe0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103018:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010301b:	89 f0                	mov    %esi,%eax
8010301d:	5b                   	pop    %ebx
8010301e:	5e                   	pop    %esi
8010301f:	5f                   	pop    %edi
80103020:	5d                   	pop    %ebp
80103021:	c3                   	ret    
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103028:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010302b:	31 f6                	xor    %esi,%esi
}
8010302d:	89 f0                	mov    %esi,%eax
8010302f:	5b                   	pop    %ebx
80103030:	5e                   	pop    %esi
80103031:	5f                   	pop    %edi
80103032:	5d                   	pop    %ebp
80103033:	c3                   	ret    
80103034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010303a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103040 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	57                   	push   %edi
80103044:	56                   	push   %esi
80103045:	53                   	push   %ebx
80103046:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103049:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103050:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103057:	c1 e0 08             	shl    $0x8,%eax
8010305a:	09 d0                	or     %edx,%eax
8010305c:	c1 e0 04             	shl    $0x4,%eax
8010305f:	85 c0                	test   %eax,%eax
80103061:	75 1b                	jne    8010307e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103063:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010306a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103071:	c1 e0 08             	shl    $0x8,%eax
80103074:	09 d0                	or     %edx,%eax
80103076:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103079:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010307e:	ba 00 04 00 00       	mov    $0x400,%edx
80103083:	e8 38 ff ff ff       	call   80102fc0 <mpsearch1>
80103088:	85 c0                	test   %eax,%eax
8010308a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010308d:	0f 84 3d 01 00 00    	je     801031d0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103093:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103096:	8b 58 04             	mov    0x4(%eax),%ebx
80103099:	85 db                	test   %ebx,%ebx
8010309b:	0f 84 4f 01 00 00    	je     801031f0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030a1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030a7:	83 ec 04             	sub    $0x4,%esp
801030aa:	6a 04                	push   $0x4
801030ac:	68 35 77 10 80       	push   $0x80107735
801030b1:	56                   	push   %esi
801030b2:	e8 49 16 00 00       	call   80104700 <memcmp>
801030b7:	83 c4 10             	add    $0x10,%esp
801030ba:	85 c0                	test   %eax,%eax
801030bc:	0f 85 2e 01 00 00    	jne    801031f0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030c2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030c9:	3c 01                	cmp    $0x1,%al
801030cb:	0f 95 c2             	setne  %dl
801030ce:	3c 04                	cmp    $0x4,%al
801030d0:	0f 95 c0             	setne  %al
801030d3:	20 c2                	and    %al,%dl
801030d5:	0f 85 15 01 00 00    	jne    801031f0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030db:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801030e2:	66 85 ff             	test   %di,%di
801030e5:	74 1a                	je     80103101 <mpinit+0xc1>
801030e7:	89 f0                	mov    %esi,%eax
801030e9:	01 f7                	add    %esi,%edi
  sum = 0;
801030eb:	31 d2                	xor    %edx,%edx
801030ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801030f0:	0f b6 08             	movzbl (%eax),%ecx
801030f3:	83 c0 01             	add    $0x1,%eax
801030f6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801030f8:	39 c7                	cmp    %eax,%edi
801030fa:	75 f4                	jne    801030f0 <mpinit+0xb0>
801030fc:	84 d2                	test   %dl,%dl
801030fe:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103101:	85 f6                	test   %esi,%esi
80103103:	0f 84 e7 00 00 00    	je     801031f0 <mpinit+0x1b0>
80103109:	84 d2                	test   %dl,%dl
8010310b:	0f 85 df 00 00 00    	jne    801031f0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103111:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103117:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010311c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103123:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103129:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312e:	01 d6                	add    %edx,%esi
80103130:	39 c6                	cmp    %eax,%esi
80103132:	76 23                	jbe    80103157 <mpinit+0x117>
    switch(*p){
80103134:	0f b6 10             	movzbl (%eax),%edx
80103137:	80 fa 04             	cmp    $0x4,%dl
8010313a:	0f 87 ca 00 00 00    	ja     8010320a <mpinit+0x1ca>
80103140:	ff 24 95 5c 77 10 80 	jmp    *-0x7fef88a4(,%edx,4)
80103147:	89 f6                	mov    %esi,%esi
80103149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103150:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103153:	39 c6                	cmp    %eax,%esi
80103155:	77 dd                	ja     80103134 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103157:	85 db                	test   %ebx,%ebx
80103159:	0f 84 9e 00 00 00    	je     801031fd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010315f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103162:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103166:	74 15                	je     8010317d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103168:	b8 70 00 00 00       	mov    $0x70,%eax
8010316d:	ba 22 00 00 00       	mov    $0x22,%edx
80103172:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103173:	ba 23 00 00 00       	mov    $0x23,%edx
80103178:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103179:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010317c:	ee                   	out    %al,(%dx)
  }
}
8010317d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103180:	5b                   	pop    %ebx
80103181:	5e                   	pop    %esi
80103182:	5f                   	pop    %edi
80103183:	5d                   	pop    %ebp
80103184:	c3                   	ret    
80103185:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103188:	8b 0d 20 2d 11 80    	mov    0x80112d20,%ecx
8010318e:	83 f9 07             	cmp    $0x7,%ecx
80103191:	7f 19                	jg     801031ac <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103193:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103197:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010319d:	83 c1 01             	add    $0x1,%ecx
801031a0:	89 0d 20 2d 11 80    	mov    %ecx,0x80112d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a6:	88 97 a0 27 11 80    	mov    %dl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
801031ac:	83 c0 14             	add    $0x14,%eax
      continue;
801031af:	e9 7c ff ff ff       	jmp    80103130 <mpinit+0xf0>
801031b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031bc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031bf:	88 15 80 27 11 80    	mov    %dl,0x80112780
      continue;
801031c5:	e9 66 ff ff ff       	jmp    80103130 <mpinit+0xf0>
801031ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031d0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031d5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031da:	e8 e1 fd ff ff       	call   80102fc0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031df:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031e4:	0f 85 a9 fe ff ff    	jne    80103093 <mpinit+0x53>
801031ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801031f0:	83 ec 0c             	sub    $0xc,%esp
801031f3:	68 1d 77 10 80       	push   $0x8010771d
801031f8:	e8 93 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801031fd:	83 ec 0c             	sub    $0xc,%esp
80103200:	68 3c 77 10 80       	push   $0x8010773c
80103205:	e8 86 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010320a:	31 db                	xor    %ebx,%ebx
8010320c:	e9 26 ff ff ff       	jmp    80103137 <mpinit+0xf7>
80103211:	66 90                	xchg   %ax,%ax
80103213:	66 90                	xchg   %ax,%ax
80103215:	66 90                	xchg   %ax,%ax
80103217:	66 90                	xchg   %ax,%ax
80103219:	66 90                	xchg   %ax,%ax
8010321b:	66 90                	xchg   %ax,%ax
8010321d:	66 90                	xchg   %ax,%ax
8010321f:	90                   	nop

80103220 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103220:	55                   	push   %ebp
80103221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103226:	ba 21 00 00 00       	mov    $0x21,%edx
8010322b:	89 e5                	mov    %esp,%ebp
8010322d:	ee                   	out    %al,(%dx)
8010322e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103233:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103234:	5d                   	pop    %ebp
80103235:	c3                   	ret    
80103236:	66 90                	xchg   %ax,%ax
80103238:	66 90                	xchg   %ax,%ax
8010323a:	66 90                	xchg   %ax,%ax
8010323c:	66 90                	xchg   %ax,%ax
8010323e:	66 90                	xchg   %ax,%ax

80103240 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	57                   	push   %edi
80103244:	56                   	push   %esi
80103245:	53                   	push   %ebx
80103246:	83 ec 0c             	sub    $0xc,%esp
80103249:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010324c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010324f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103255:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010325b:	e8 20 db ff ff       	call   80100d80 <filealloc>
80103260:	85 c0                	test   %eax,%eax
80103262:	89 03                	mov    %eax,(%ebx)
80103264:	74 22                	je     80103288 <pipealloc+0x48>
80103266:	e8 15 db ff ff       	call   80100d80 <filealloc>
8010326b:	85 c0                	test   %eax,%eax
8010326d:	89 06                	mov    %eax,(%esi)
8010326f:	74 3f                	je     801032b0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103271:	e8 4a f2 ff ff       	call   801024c0 <kalloc>
80103276:	85 c0                	test   %eax,%eax
80103278:	89 c7                	mov    %eax,%edi
8010327a:	75 54                	jne    801032d0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010327c:	8b 03                	mov    (%ebx),%eax
8010327e:	85 c0                	test   %eax,%eax
80103280:	75 34                	jne    801032b6 <pipealloc+0x76>
80103282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103288:	8b 06                	mov    (%esi),%eax
8010328a:	85 c0                	test   %eax,%eax
8010328c:	74 0c                	je     8010329a <pipealloc+0x5a>
    fileclose(*f1);
8010328e:	83 ec 0c             	sub    $0xc,%esp
80103291:	50                   	push   %eax
80103292:	e8 a9 db ff ff       	call   80100e40 <fileclose>
80103297:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010329a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010329d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032a2:	5b                   	pop    %ebx
801032a3:	5e                   	pop    %esi
801032a4:	5f                   	pop    %edi
801032a5:	5d                   	pop    %ebp
801032a6:	c3                   	ret    
801032a7:	89 f6                	mov    %esi,%esi
801032a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032b0:	8b 03                	mov    (%ebx),%eax
801032b2:	85 c0                	test   %eax,%eax
801032b4:	74 e4                	je     8010329a <pipealloc+0x5a>
    fileclose(*f0);
801032b6:	83 ec 0c             	sub    $0xc,%esp
801032b9:	50                   	push   %eax
801032ba:	e8 81 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032bf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032c1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032c4:	85 c0                	test   %eax,%eax
801032c6:	75 c6                	jne    8010328e <pipealloc+0x4e>
801032c8:	eb d0                	jmp    8010329a <pipealloc+0x5a>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032d0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032d3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032da:	00 00 00 
  p->writeopen = 1;
801032dd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032e4:	00 00 00 
  p->nwrite = 0;
801032e7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032ee:	00 00 00 
  p->nread = 0;
801032f1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032f8:	00 00 00 
  initlock(&p->lock, "pipe");
801032fb:	68 70 77 10 80       	push   $0x80107770
80103300:	50                   	push   %eax
80103301:	e8 fa 0f 00 00       	call   80104300 <initlock>
  (*f0)->type = FD_PIPE;
80103306:	8b 03                	mov    (%ebx),%eax
  return 0;
80103308:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010330b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103311:	8b 03                	mov    (%ebx),%eax
80103313:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103317:	8b 03                	mov    (%ebx),%eax
80103319:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010331d:	8b 03                	mov    (%ebx),%eax
8010331f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103322:	8b 06                	mov    (%esi),%eax
80103324:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010332a:	8b 06                	mov    (%esi),%eax
8010332c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103330:	8b 06                	mov    (%esi),%eax
80103332:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103336:	8b 06                	mov    (%esi),%eax
80103338:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010333b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010333e:	31 c0                	xor    %eax,%eax
}
80103340:	5b                   	pop    %ebx
80103341:	5e                   	pop    %esi
80103342:	5f                   	pop    %edi
80103343:	5d                   	pop    %ebp
80103344:	c3                   	ret    
80103345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103350 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	56                   	push   %esi
80103354:	53                   	push   %ebx
80103355:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103358:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010335b:	83 ec 0c             	sub    $0xc,%esp
8010335e:	53                   	push   %ebx
8010335f:	e8 0c 11 00 00       	call   80104470 <acquire>
  if(writable){
80103364:	83 c4 10             	add    $0x10,%esp
80103367:	85 f6                	test   %esi,%esi
80103369:	74 45                	je     801033b0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010336b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103371:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103374:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010337b:	00 00 00 
    wakeup(&p->nread);
8010337e:	50                   	push   %eax
8010337f:	e8 ac 0b 00 00       	call   80103f30 <wakeup>
80103384:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103387:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010338d:	85 d2                	test   %edx,%edx
8010338f:	75 0a                	jne    8010339b <pipeclose+0x4b>
80103391:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103397:	85 c0                	test   %eax,%eax
80103399:	74 35                	je     801033d0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010339b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010339e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033a1:	5b                   	pop    %ebx
801033a2:	5e                   	pop    %esi
801033a3:	5d                   	pop    %ebp
    release(&p->lock);
801033a4:	e9 57 12 00 00       	jmp    80104600 <release>
801033a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033b0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033b6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033c0:	00 00 00 
    wakeup(&p->nwrite);
801033c3:	50                   	push   %eax
801033c4:	e8 67 0b 00 00       	call   80103f30 <wakeup>
801033c9:	83 c4 10             	add    $0x10,%esp
801033cc:	eb b9                	jmp    80103387 <pipeclose+0x37>
801033ce:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033d0:	83 ec 0c             	sub    $0xc,%esp
801033d3:	53                   	push   %ebx
801033d4:	e8 27 12 00 00       	call   80104600 <release>
    kfree((char*)p);
801033d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033dc:	83 c4 10             	add    $0x10,%esp
}
801033df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033e2:	5b                   	pop    %ebx
801033e3:	5e                   	pop    %esi
801033e4:	5d                   	pop    %ebp
    kfree((char*)p);
801033e5:	e9 26 ef ff ff       	jmp    80102310 <kfree>
801033ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 28             	sub    $0x28,%esp
801033f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033fc:	53                   	push   %ebx
801033fd:	e8 6e 10 00 00       	call   80104470 <acquire>
  for(i = 0; i < n; i++){
80103402:	8b 45 10             	mov    0x10(%ebp),%eax
80103405:	83 c4 10             	add    $0x10,%esp
80103408:	85 c0                	test   %eax,%eax
8010340a:	0f 8e c9 00 00 00    	jle    801034d9 <pipewrite+0xe9>
80103410:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103413:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103419:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010341f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103422:	03 4d 10             	add    0x10(%ebp),%ecx
80103425:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103428:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010342e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103434:	39 d0                	cmp    %edx,%eax
80103436:	75 71                	jne    801034a9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103438:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010343e:	85 c0                	test   %eax,%eax
80103440:	74 4e                	je     80103490 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103442:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103448:	eb 3a                	jmp    80103484 <pipewrite+0x94>
8010344a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103450:	83 ec 0c             	sub    $0xc,%esp
80103453:	57                   	push   %edi
80103454:	e8 d7 0a 00 00       	call   80103f30 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103459:	5a                   	pop    %edx
8010345a:	59                   	pop    %ecx
8010345b:	53                   	push   %ebx
8010345c:	56                   	push   %esi
8010345d:	e8 1e 09 00 00       	call   80103d80 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103462:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103468:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010346e:	83 c4 10             	add    $0x10,%esp
80103471:	05 00 02 00 00       	add    $0x200,%eax
80103476:	39 c2                	cmp    %eax,%edx
80103478:	75 36                	jne    801034b0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010347a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103480:	85 c0                	test   %eax,%eax
80103482:	74 0c                	je     80103490 <pipewrite+0xa0>
80103484:	e8 57 03 00 00       	call   801037e0 <myproc>
80103489:	8b 40 24             	mov    0x24(%eax),%eax
8010348c:	85 c0                	test   %eax,%eax
8010348e:	74 c0                	je     80103450 <pipewrite+0x60>
        release(&p->lock);
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	53                   	push   %ebx
80103494:	e8 67 11 00 00       	call   80104600 <release>
        return -1;
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034a4:	5b                   	pop    %ebx
801034a5:	5e                   	pop    %esi
801034a6:	5f                   	pop    %edi
801034a7:	5d                   	pop    %ebp
801034a8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034a9:	89 c2                	mov    %eax,%edx
801034ab:	90                   	nop
801034ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034b0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034b3:	8d 42 01             	lea    0x1(%edx),%eax
801034b6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034bc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034c2:	83 c6 01             	add    $0x1,%esi
801034c5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034c9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034cc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034cf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034d3:	0f 85 4f ff ff ff    	jne    80103428 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034d9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034df:	83 ec 0c             	sub    $0xc,%esp
801034e2:	50                   	push   %eax
801034e3:	e8 48 0a 00 00       	call   80103f30 <wakeup>
  release(&p->lock);
801034e8:	89 1c 24             	mov    %ebx,(%esp)
801034eb:	e8 10 11 00 00       	call   80104600 <release>
  return n;
801034f0:	83 c4 10             	add    $0x10,%esp
801034f3:	8b 45 10             	mov    0x10(%ebp),%eax
801034f6:	eb a9                	jmp    801034a1 <pipewrite+0xb1>
801034f8:	90                   	nop
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103500 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	57                   	push   %edi
80103504:	56                   	push   %esi
80103505:	53                   	push   %ebx
80103506:	83 ec 18             	sub    $0x18,%esp
80103509:	8b 75 08             	mov    0x8(%ebp),%esi
8010350c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010350f:	56                   	push   %esi
80103510:	e8 5b 0f 00 00       	call   80104470 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103515:	83 c4 10             	add    $0x10,%esp
80103518:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010351e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103524:	75 6a                	jne    80103590 <piperead+0x90>
80103526:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010352c:	85 db                	test   %ebx,%ebx
8010352e:	0f 84 c4 00 00 00    	je     801035f8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103534:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010353a:	eb 2d                	jmp    80103569 <piperead+0x69>
8010353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103540:	83 ec 08             	sub    $0x8,%esp
80103543:	56                   	push   %esi
80103544:	53                   	push   %ebx
80103545:	e8 36 08 00 00       	call   80103d80 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010354a:	83 c4 10             	add    $0x10,%esp
8010354d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103553:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103559:	75 35                	jne    80103590 <piperead+0x90>
8010355b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103561:	85 d2                	test   %edx,%edx
80103563:	0f 84 8f 00 00 00    	je     801035f8 <piperead+0xf8>
    if(myproc()->killed){
80103569:	e8 72 02 00 00       	call   801037e0 <myproc>
8010356e:	8b 48 24             	mov    0x24(%eax),%ecx
80103571:	85 c9                	test   %ecx,%ecx
80103573:	74 cb                	je     80103540 <piperead+0x40>
      release(&p->lock);
80103575:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103578:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010357d:	56                   	push   %esi
8010357e:	e8 7d 10 00 00       	call   80104600 <release>
      return -1;
80103583:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103586:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103589:	89 d8                	mov    %ebx,%eax
8010358b:	5b                   	pop    %ebx
8010358c:	5e                   	pop    %esi
8010358d:	5f                   	pop    %edi
8010358e:	5d                   	pop    %ebp
8010358f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103590:	8b 45 10             	mov    0x10(%ebp),%eax
80103593:	85 c0                	test   %eax,%eax
80103595:	7e 61                	jle    801035f8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103597:	31 db                	xor    %ebx,%ebx
80103599:	eb 13                	jmp    801035ae <piperead+0xae>
8010359b:	90                   	nop
8010359c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035a0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035a6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035ac:	74 1f                	je     801035cd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035ae:	8d 41 01             	lea    0x1(%ecx),%eax
801035b1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035b7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035bd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035c2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c5:	83 c3 01             	add    $0x1,%ebx
801035c8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035cb:	75 d3                	jne    801035a0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035cd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035d3:	83 ec 0c             	sub    $0xc,%esp
801035d6:	50                   	push   %eax
801035d7:	e8 54 09 00 00       	call   80103f30 <wakeup>
  release(&p->lock);
801035dc:	89 34 24             	mov    %esi,(%esp)
801035df:	e8 1c 10 00 00       	call   80104600 <release>
  return i;
801035e4:	83 c4 10             	add    $0x10,%esp
}
801035e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035ea:	89 d8                	mov    %ebx,%eax
801035ec:	5b                   	pop    %ebx
801035ed:	5e                   	pop    %esi
801035ee:	5f                   	pop    %edi
801035ef:	5d                   	pop    %ebp
801035f0:	c3                   	ret    
801035f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f8:	31 db                	xor    %ebx,%ebx
801035fa:	eb d1                	jmp    801035cd <piperead+0xcd>
801035fc:	66 90                	xchg   %ax,%ax
801035fe:	66 90                	xchg   %ax,%ax

80103600 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103604:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80103609:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010360c:	68 40 2d 11 80       	push   $0x80112d40
80103611:	e8 5a 0e 00 00       	call   80104470 <acquire>
80103616:	83 c4 10             	add    $0x10,%esp
80103619:	eb 10                	jmp    8010362b <allocproc+0x2b>
8010361b:	90                   	nop
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103620:	83 c3 7c             	add    $0x7c,%ebx
80103623:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103629:	73 75                	jae    801036a0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010362b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010362e:	85 c0                	test   %eax,%eax
80103630:	75 ee                	jne    80103620 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103632:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103637:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010363a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103641:	8d 50 01             	lea    0x1(%eax),%edx
80103644:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103647:	68 40 2d 11 80       	push   $0x80112d40
  p->pid = nextpid++;
8010364c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103652:	e8 a9 0f 00 00       	call   80104600 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103657:	e8 64 ee ff ff       	call   801024c0 <kalloc>
8010365c:	83 c4 10             	add    $0x10,%esp
8010365f:	85 c0                	test   %eax,%eax
80103661:	89 43 08             	mov    %eax,0x8(%ebx)
80103664:	74 53                	je     801036b9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103666:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010366c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010366f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103674:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103677:	c7 40 14 97 59 10 80 	movl   $0x80105997,0x14(%eax)
  p->context = (struct context*)sp;
8010367e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103681:	6a 14                	push   $0x14
80103683:	6a 00                	push   $0x0
80103685:	50                   	push   %eax
80103686:	e8 25 10 00 00       	call   801046b0 <memset>
  p->context->eip = (uint)forkret;
8010368b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010368e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103691:	c7 40 10 d0 36 10 80 	movl   $0x801036d0,0x10(%eax)
}
80103698:	89 d8                	mov    %ebx,%eax
8010369a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010369d:	c9                   	leave  
8010369e:	c3                   	ret    
8010369f:	90                   	nop
  release(&ptable.lock);
801036a0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036a3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036a5:	68 40 2d 11 80       	push   $0x80112d40
801036aa:	e8 51 0f 00 00       	call   80104600 <release>
}
801036af:	89 d8                	mov    %ebx,%eax
  return 0;
801036b1:	83 c4 10             	add    $0x10,%esp
}
801036b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036b7:	c9                   	leave  
801036b8:	c3                   	ret    
    p->state = UNUSED;
801036b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036c0:	31 db                	xor    %ebx,%ebx
801036c2:	eb d4                	jmp    80103698 <allocproc+0x98>
801036c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036d6:	68 40 2d 11 80       	push   $0x80112d40
801036db:	e8 20 0f 00 00       	call   80104600 <release>

  if (first) {
801036e0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801036e5:	83 c4 10             	add    $0x10,%esp
801036e8:	85 c0                	test   %eax,%eax
801036ea:	75 04                	jne    801036f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036ec:	c9                   	leave  
801036ed:	c3                   	ret    
801036ee:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801036f0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801036f3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801036fa:	00 00 00 
    iinit(ROOTDEV);
801036fd:	6a 01                	push   $0x1
801036ff:	e8 7c dd ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
80103704:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010370b:	e8 f0 f3 ff ff       	call   80102b00 <initlog>
80103710:	83 c4 10             	add    $0x10,%esp
}
80103713:	c9                   	leave  
80103714:	c3                   	ret    
80103715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <pinit>:
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103726:	68 75 77 10 80       	push   $0x80107775
8010372b:	68 40 2d 11 80       	push   $0x80112d40
80103730:	e8 cb 0b 00 00       	call   80104300 <initlock>
}
80103735:	83 c4 10             	add    $0x10,%esp
80103738:	c9                   	leave  
80103739:	c3                   	ret    
8010373a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103740 <mycpu>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	56                   	push   %esi
80103744:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103745:	9c                   	pushf  
80103746:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103747:	f6 c4 02             	test   $0x2,%ah
8010374a:	75 5e                	jne    801037aa <mycpu+0x6a>
  apicid = lapicid();
8010374c:	e8 df ef ff ff       	call   80102730 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103751:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
80103757:	85 f6                	test   %esi,%esi
80103759:	7e 42                	jle    8010379d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010375b:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
80103762:	39 d0                	cmp    %edx,%eax
80103764:	74 30                	je     80103796 <mycpu+0x56>
80103766:	b9 50 28 11 80       	mov    $0x80112850,%ecx
  for (i = 0; i < ncpu; ++i) {
8010376b:	31 d2                	xor    %edx,%edx
8010376d:	8d 76 00             	lea    0x0(%esi),%esi
80103770:	83 c2 01             	add    $0x1,%edx
80103773:	39 f2                	cmp    %esi,%edx
80103775:	74 26                	je     8010379d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103777:	0f b6 19             	movzbl (%ecx),%ebx
8010377a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103780:	39 c3                	cmp    %eax,%ebx
80103782:	75 ec                	jne    80103770 <mycpu+0x30>
80103784:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010378a:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
8010378f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103792:	5b                   	pop    %ebx
80103793:	5e                   	pop    %esi
80103794:	5d                   	pop    %ebp
80103795:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103796:	b8 a0 27 11 80       	mov    $0x801127a0,%eax
      return &cpus[i];
8010379b:	eb f2                	jmp    8010378f <mycpu+0x4f>
  panic("unknown apicid\n");
8010379d:	83 ec 0c             	sub    $0xc,%esp
801037a0:	68 7c 77 10 80       	push   $0x8010777c
801037a5:	e8 e6 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801037aa:	83 ec 0c             	sub    $0xc,%esp
801037ad:	68 58 78 10 80       	push   $0x80107858
801037b2:	e8 d9 cb ff ff       	call   80100390 <panic>
801037b7:	89 f6                	mov    %esi,%esi
801037b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037c0 <cpuid>:
cpuid() {
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037c6:	e8 75 ff ff ff       	call   80103740 <mycpu>
801037cb:	2d a0 27 11 80       	sub    $0x801127a0,%eax
}
801037d0:	c9                   	leave  
  return mycpu()-cpus;
801037d1:	c1 f8 04             	sar    $0x4,%eax
801037d4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037da:	c3                   	ret    
801037db:	90                   	nop
801037dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037e0 <myproc>:
myproc(void) {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	53                   	push   %ebx
801037e4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801037e7:	e8 b4 0b 00 00       	call   801043a0 <pushcli>
  c = mycpu();
801037ec:	e8 4f ff ff ff       	call   80103740 <mycpu>
  p = c->proc;
801037f1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037f7:	e8 e4 0b 00 00       	call   801043e0 <popcli>
}
801037fc:	83 c4 04             	add    $0x4,%esp
801037ff:	89 d8                	mov    %ebx,%eax
80103801:	5b                   	pop    %ebx
80103802:	5d                   	pop    %ebp
80103803:	c3                   	ret    
80103804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010380a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103810 <userinit>:
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103817:	e8 e4 fd ff ff       	call   80103600 <allocproc>
8010381c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010381e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103823:	e8 48 37 00 00       	call   80106f70 <setupkvm>
80103828:	85 c0                	test   %eax,%eax
8010382a:	89 43 04             	mov    %eax,0x4(%ebx)
8010382d:	0f 84 bd 00 00 00    	je     801038f0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103833:	83 ec 04             	sub    $0x4,%esp
80103836:	68 2c 00 00 00       	push   $0x2c
8010383b:	68 60 a4 10 80       	push   $0x8010a460
80103840:	50                   	push   %eax
80103841:	e8 0a 34 00 00       	call   80106c50 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103846:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103849:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010384f:	6a 4c                	push   $0x4c
80103851:	6a 00                	push   $0x0
80103853:	ff 73 18             	pushl  0x18(%ebx)
80103856:	e8 55 0e 00 00       	call   801046b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010385b:	8b 43 18             	mov    0x18(%ebx),%eax
8010385e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103863:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103868:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010386b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010386f:	8b 43 18             	mov    0x18(%ebx),%eax
80103872:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103876:	8b 43 18             	mov    0x18(%ebx),%eax
80103879:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010387d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103881:	8b 43 18             	mov    0x18(%ebx),%eax
80103884:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103888:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010388c:	8b 43 18             	mov    0x18(%ebx),%eax
8010388f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103896:	8b 43 18             	mov    0x18(%ebx),%eax
80103899:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038a0:	8b 43 18             	mov    0x18(%ebx),%eax
801038a3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801038aa:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038ad:	6a 10                	push   $0x10
801038af:	68 a5 77 10 80       	push   $0x801077a5
801038b4:	50                   	push   %eax
801038b5:	e8 d6 0f 00 00       	call   80104890 <safestrcpy>
  p->cwd = namei("/");
801038ba:	c7 04 24 ae 77 10 80 	movl   $0x801077ae,(%esp)
801038c1:	e8 1a e6 ff ff       	call   80101ee0 <namei>
801038c6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801038c9:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801038d0:	e8 9b 0b 00 00       	call   80104470 <acquire>
  p->state = RUNNABLE;
801038d5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801038dc:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801038e3:	e8 18 0d 00 00       	call   80104600 <release>
}
801038e8:	83 c4 10             	add    $0x10,%esp
801038eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038ee:	c9                   	leave  
801038ef:	c3                   	ret    
    panic("userinit: out of memory?");
801038f0:	83 ec 0c             	sub    $0xc,%esp
801038f3:	68 8c 77 10 80       	push   $0x8010778c
801038f8:	e8 93 ca ff ff       	call   80100390 <panic>
801038fd:	8d 76 00             	lea    0x0(%esi),%esi

80103900 <growproc>:
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	56                   	push   %esi
80103904:	53                   	push   %ebx
80103905:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103908:	e8 93 0a 00 00       	call   801043a0 <pushcli>
  c = mycpu();
8010390d:	e8 2e fe ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103912:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103918:	e8 c3 0a 00 00       	call   801043e0 <popcli>
  if(n > 0){
8010391d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103920:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103922:	7f 1c                	jg     80103940 <growproc+0x40>
  } else if(n < 0){
80103924:	75 3a                	jne    80103960 <growproc+0x60>
  switchuvm(curproc);
80103926:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103929:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010392b:	53                   	push   %ebx
8010392c:	e8 0f 32 00 00       	call   80106b40 <switchuvm>
  return 0;
80103931:	83 c4 10             	add    $0x10,%esp
80103934:	31 c0                	xor    %eax,%eax
}
80103936:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103939:	5b                   	pop    %ebx
8010393a:	5e                   	pop    %esi
8010393b:	5d                   	pop    %ebp
8010393c:	c3                   	ret    
8010393d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103940:	83 ec 04             	sub    $0x4,%esp
80103943:	01 c6                	add    %eax,%esi
80103945:	56                   	push   %esi
80103946:	50                   	push   %eax
80103947:	ff 73 04             	pushl  0x4(%ebx)
8010394a:	e8 41 34 00 00       	call   80106d90 <allocuvm>
8010394f:	83 c4 10             	add    $0x10,%esp
80103952:	85 c0                	test   %eax,%eax
80103954:	75 d0                	jne    80103926 <growproc+0x26>
      return -1;
80103956:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010395b:	eb d9                	jmp    80103936 <growproc+0x36>
8010395d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103960:	83 ec 04             	sub    $0x4,%esp
80103963:	01 c6                	add    %eax,%esi
80103965:	56                   	push   %esi
80103966:	50                   	push   %eax
80103967:	ff 73 04             	pushl  0x4(%ebx)
8010396a:	e8 51 35 00 00       	call   80106ec0 <deallocuvm>
8010396f:	83 c4 10             	add    $0x10,%esp
80103972:	85 c0                	test   %eax,%eax
80103974:	75 b0                	jne    80103926 <growproc+0x26>
80103976:	eb de                	jmp    80103956 <growproc+0x56>
80103978:	90                   	nop
80103979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103980 <fork>:
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	57                   	push   %edi
80103984:	56                   	push   %esi
80103985:	53                   	push   %ebx
80103986:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103989:	e8 12 0a 00 00       	call   801043a0 <pushcli>
  c = mycpu();
8010398e:	e8 ad fd ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103993:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103999:	e8 42 0a 00 00       	call   801043e0 <popcli>
  if((np = allocproc()) == 0){
8010399e:	e8 5d fc ff ff       	call   80103600 <allocproc>
801039a3:	85 c0                	test   %eax,%eax
801039a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039a8:	0f 84 b7 00 00 00    	je     80103a65 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039ae:	83 ec 08             	sub    $0x8,%esp
801039b1:	ff 33                	pushl  (%ebx)
801039b3:	ff 73 04             	pushl  0x4(%ebx)
801039b6:	89 c7                	mov    %eax,%edi
801039b8:	e8 83 36 00 00       	call   80107040 <copyuvm>
801039bd:	83 c4 10             	add    $0x10,%esp
801039c0:	85 c0                	test   %eax,%eax
801039c2:	89 47 04             	mov    %eax,0x4(%edi)
801039c5:	0f 84 a1 00 00 00    	je     80103a6c <fork+0xec>
  np->sz = curproc->sz;
801039cb:	8b 03                	mov    (%ebx),%eax
801039cd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039d0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039d2:	89 59 14             	mov    %ebx,0x14(%ecx)
801039d5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
801039d7:	8b 79 18             	mov    0x18(%ecx),%edi
801039da:	8b 73 18             	mov    0x18(%ebx),%esi
801039dd:	b9 13 00 00 00       	mov    $0x13,%ecx
801039e2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801039e4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801039e6:	8b 40 18             	mov    0x18(%eax),%eax
801039e9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801039f0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039f4:	85 c0                	test   %eax,%eax
801039f6:	74 13                	je     80103a0b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039f8:	83 ec 0c             	sub    $0xc,%esp
801039fb:	50                   	push   %eax
801039fc:	e8 ef d3 ff ff       	call   80100df0 <filedup>
80103a01:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a04:	83 c4 10             	add    $0x10,%esp
80103a07:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103a0b:	83 c6 01             	add    $0x1,%esi
80103a0e:	83 fe 10             	cmp    $0x10,%esi
80103a11:	75 dd                	jne    801039f0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103a13:	83 ec 0c             	sub    $0xc,%esp
80103a16:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a19:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103a1c:	e8 2f dc ff ff       	call   80101650 <idup>
80103a21:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a24:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a27:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a2a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a2d:	6a 10                	push   $0x10
80103a2f:	53                   	push   %ebx
80103a30:	50                   	push   %eax
80103a31:	e8 5a 0e 00 00       	call   80104890 <safestrcpy>
  pid = np->pid;
80103a36:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a39:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a40:	e8 2b 0a 00 00       	call   80104470 <acquire>
  np->state = RUNNABLE;
80103a45:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a4c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a53:	e8 a8 0b 00 00       	call   80104600 <release>
  return pid;
80103a58:	83 c4 10             	add    $0x10,%esp
}
80103a5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5e:	89 d8                	mov    %ebx,%eax
80103a60:	5b                   	pop    %ebx
80103a61:	5e                   	pop    %esi
80103a62:	5f                   	pop    %edi
80103a63:	5d                   	pop    %ebp
80103a64:	c3                   	ret    
    return -1;
80103a65:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a6a:	eb ef                	jmp    80103a5b <fork+0xdb>
    kfree(np->kstack);
80103a6c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103a6f:	83 ec 0c             	sub    $0xc,%esp
80103a72:	ff 73 08             	pushl  0x8(%ebx)
80103a75:	e8 96 e8 ff ff       	call   80102310 <kfree>
    np->kstack = 0;
80103a7a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103a81:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103a88:	83 c4 10             	add    $0x10,%esp
80103a8b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a90:	eb c9                	jmp    80103a5b <fork+0xdb>
80103a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103aa0 <scheduler>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	57                   	push   %edi
80103aa4:	56                   	push   %esi
80103aa5:	53                   	push   %ebx
80103aa6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103aa9:	e8 92 fc ff ff       	call   80103740 <mycpu>
80103aae:	8d 78 04             	lea    0x4(%eax),%edi
80103ab1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ab3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103aba:	00 00 00 
80103abd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103ac0:	fb                   	sti    
    acquire(&ptable.lock);
80103ac1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ac4:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
80103ac9:	68 40 2d 11 80       	push   $0x80112d40
80103ace:	e8 9d 09 00 00       	call   80104470 <acquire>
80103ad3:	83 c4 10             	add    $0x10,%esp
80103ad6:	8d 76 00             	lea    0x0(%esi),%esi
80103ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103ae0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103ae4:	75 33                	jne    80103b19 <scheduler+0x79>
      switchuvm(p);
80103ae6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103ae9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103aef:	53                   	push   %ebx
80103af0:	e8 4b 30 00 00       	call   80106b40 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103af5:	58                   	pop    %eax
80103af6:	5a                   	pop    %edx
80103af7:	ff 73 1c             	pushl  0x1c(%ebx)
80103afa:	57                   	push   %edi
      p->state = RUNNING;
80103afb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103b02:	e8 e4 0d 00 00       	call   801048eb <swtch>
      switchkvm();
80103b07:	e8 14 30 00 00       	call   80106b20 <switchkvm>
      c->proc = 0;
80103b0c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b13:	00 00 00 
80103b16:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b19:	83 c3 7c             	add    $0x7c,%ebx
80103b1c:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103b22:	72 bc                	jb     80103ae0 <scheduler+0x40>
    release(&ptable.lock);
80103b24:	83 ec 0c             	sub    $0xc,%esp
80103b27:	68 40 2d 11 80       	push   $0x80112d40
80103b2c:	e8 cf 0a 00 00       	call   80104600 <release>
    sti();
80103b31:	83 c4 10             	add    $0x10,%esp
80103b34:	eb 8a                	jmp    80103ac0 <scheduler+0x20>
80103b36:	8d 76 00             	lea    0x0(%esi),%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b40 <sched>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	56                   	push   %esi
80103b44:	53                   	push   %ebx
  pushcli();
80103b45:	e8 56 08 00 00       	call   801043a0 <pushcli>
  c = mycpu();
80103b4a:	e8 f1 fb ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103b4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b55:	e8 86 08 00 00       	call   801043e0 <popcli>
  if(!holding(&ptable.lock))
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	68 40 2d 11 80       	push   $0x80112d40
80103b62:	e8 d9 08 00 00       	call   80104440 <holding>
80103b67:	83 c4 10             	add    $0x10,%esp
80103b6a:	85 c0                	test   %eax,%eax
80103b6c:	74 4f                	je     80103bbd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103b6e:	e8 cd fb ff ff       	call   80103740 <mycpu>
80103b73:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b7a:	75 68                	jne    80103be4 <sched+0xa4>
  if(p->state == RUNNING)
80103b7c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b80:	74 55                	je     80103bd7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b82:	9c                   	pushf  
80103b83:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b84:	f6 c4 02             	test   $0x2,%ah
80103b87:	75 41                	jne    80103bca <sched+0x8a>
  intena = mycpu()->intena;
80103b89:	e8 b2 fb ff ff       	call   80103740 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b8e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103b91:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b97:	e8 a4 fb ff ff       	call   80103740 <mycpu>
80103b9c:	83 ec 08             	sub    $0x8,%esp
80103b9f:	ff 70 04             	pushl  0x4(%eax)
80103ba2:	53                   	push   %ebx
80103ba3:	e8 43 0d 00 00       	call   801048eb <swtch>
  mycpu()->intena = intena;
80103ba8:	e8 93 fb ff ff       	call   80103740 <mycpu>
}
80103bad:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103bb0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bb9:	5b                   	pop    %ebx
80103bba:	5e                   	pop    %esi
80103bbb:	5d                   	pop    %ebp
80103bbc:	c3                   	ret    
    panic("sched ptable.lock");
80103bbd:	83 ec 0c             	sub    $0xc,%esp
80103bc0:	68 b0 77 10 80       	push   $0x801077b0
80103bc5:	e8 c6 c7 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103bca:	83 ec 0c             	sub    $0xc,%esp
80103bcd:	68 dc 77 10 80       	push   $0x801077dc
80103bd2:	e8 b9 c7 ff ff       	call   80100390 <panic>
    panic("sched running");
80103bd7:	83 ec 0c             	sub    $0xc,%esp
80103bda:	68 ce 77 10 80       	push   $0x801077ce
80103bdf:	e8 ac c7 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103be4:	83 ec 0c             	sub    $0xc,%esp
80103be7:	68 c2 77 10 80       	push   $0x801077c2
80103bec:	e8 9f c7 ff ff       	call   80100390 <panic>
80103bf1:	eb 0d                	jmp    80103c00 <exit>
80103bf3:	90                   	nop
80103bf4:	90                   	nop
80103bf5:	90                   	nop
80103bf6:	90                   	nop
80103bf7:	90                   	nop
80103bf8:	90                   	nop
80103bf9:	90                   	nop
80103bfa:	90                   	nop
80103bfb:	90                   	nop
80103bfc:	90                   	nop
80103bfd:	90                   	nop
80103bfe:	90                   	nop
80103bff:	90                   	nop

80103c00 <exit>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103c09:	e8 92 07 00 00       	call   801043a0 <pushcli>
  c = mycpu();
80103c0e:	e8 2d fb ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103c13:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103c19:	e8 c2 07 00 00       	call   801043e0 <popcli>
  if(curproc == initproc)
80103c1e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103c24:	8d 5e 28             	lea    0x28(%esi),%ebx
80103c27:	8d 7e 68             	lea    0x68(%esi),%edi
80103c2a:	0f 84 e7 00 00 00    	je     80103d17 <exit+0x117>
    if(curproc->ofile[fd]){
80103c30:	8b 03                	mov    (%ebx),%eax
80103c32:	85 c0                	test   %eax,%eax
80103c34:	74 12                	je     80103c48 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103c36:	83 ec 0c             	sub    $0xc,%esp
80103c39:	50                   	push   %eax
80103c3a:	e8 01 d2 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103c3f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103c45:	83 c4 10             	add    $0x10,%esp
80103c48:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103c4b:	39 fb                	cmp    %edi,%ebx
80103c4d:	75 e1                	jne    80103c30 <exit+0x30>
  begin_op();
80103c4f:	e8 4c ef ff ff       	call   80102ba0 <begin_op>
  iput(curproc->cwd);
80103c54:	83 ec 0c             	sub    $0xc,%esp
80103c57:	ff 76 68             	pushl  0x68(%esi)
80103c5a:	e8 51 db ff ff       	call   801017b0 <iput>
  end_op();
80103c5f:	e8 ac ef ff ff       	call   80102c10 <end_op>
  curproc->cwd = 0;
80103c64:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103c6b:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103c72:	e8 f9 07 00 00       	call   80104470 <acquire>
  wakeup1(curproc->parent);
80103c77:	8b 56 14             	mov    0x14(%esi),%edx
80103c7a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c7d:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103c82:	eb 0e                	jmp    80103c92 <exit+0x92>
80103c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c88:	83 c0 7c             	add    $0x7c,%eax
80103c8b:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103c90:	73 1c                	jae    80103cae <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103c92:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c96:	75 f0                	jne    80103c88 <exit+0x88>
80103c98:	3b 50 20             	cmp    0x20(%eax),%edx
80103c9b:	75 eb                	jne    80103c88 <exit+0x88>
      p->state = RUNNABLE;
80103c9d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ca4:	83 c0 7c             	add    $0x7c,%eax
80103ca7:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103cac:	72 e4                	jb     80103c92 <exit+0x92>
      p->parent = initproc;
80103cae:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cb4:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103cb9:	eb 10                	jmp    80103ccb <exit+0xcb>
80103cbb:	90                   	nop
80103cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cc0:	83 c2 7c             	add    $0x7c,%edx
80103cc3:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80103cc9:	73 33                	jae    80103cfe <exit+0xfe>
    if(p->parent == curproc){
80103ccb:	39 72 14             	cmp    %esi,0x14(%edx)
80103cce:	75 f0                	jne    80103cc0 <exit+0xc0>
      if(p->state == ZOMBIE)
80103cd0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103cd4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103cd7:	75 e7                	jne    80103cc0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cd9:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103cde:	eb 0a                	jmp    80103cea <exit+0xea>
80103ce0:	83 c0 7c             	add    $0x7c,%eax
80103ce3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103ce8:	73 d6                	jae    80103cc0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103cea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cee:	75 f0                	jne    80103ce0 <exit+0xe0>
80103cf0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103cf3:	75 eb                	jne    80103ce0 <exit+0xe0>
      p->state = RUNNABLE;
80103cf5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103cfc:	eb e2                	jmp    80103ce0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103cfe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103d05:	e8 36 fe ff ff       	call   80103b40 <sched>
  panic("zombie exit");
80103d0a:	83 ec 0c             	sub    $0xc,%esp
80103d0d:	68 fd 77 10 80       	push   $0x801077fd
80103d12:	e8 79 c6 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103d17:	83 ec 0c             	sub    $0xc,%esp
80103d1a:	68 f0 77 10 80       	push   $0x801077f0
80103d1f:	e8 6c c6 ff ff       	call   80100390 <panic>
80103d24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d30 <yield>:
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	53                   	push   %ebx
80103d34:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d37:	68 40 2d 11 80       	push   $0x80112d40
80103d3c:	e8 2f 07 00 00       	call   80104470 <acquire>
  pushcli();
80103d41:	e8 5a 06 00 00       	call   801043a0 <pushcli>
  c = mycpu();
80103d46:	e8 f5 f9 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103d4b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d51:	e8 8a 06 00 00       	call   801043e0 <popcli>
  myproc()->state = RUNNABLE;
80103d56:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103d5d:	e8 de fd ff ff       	call   80103b40 <sched>
  release(&ptable.lock);
80103d62:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103d69:	e8 92 08 00 00       	call   80104600 <release>
}
80103d6e:	83 c4 10             	add    $0x10,%esp
80103d71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d74:	c9                   	leave  
80103d75:	c3                   	ret    
80103d76:	8d 76 00             	lea    0x0(%esi),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d80 <sleep>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	57                   	push   %edi
80103d84:	56                   	push   %esi
80103d85:	53                   	push   %ebx
80103d86:	83 ec 0c             	sub    $0xc,%esp
80103d89:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d8c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103d8f:	e8 0c 06 00 00       	call   801043a0 <pushcli>
  c = mycpu();
80103d94:	e8 a7 f9 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103d99:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d9f:	e8 3c 06 00 00       	call   801043e0 <popcli>
  if(p == 0)
80103da4:	85 db                	test   %ebx,%ebx
80103da6:	0f 84 87 00 00 00    	je     80103e33 <sleep+0xb3>
  if(lk == 0)
80103dac:	85 f6                	test   %esi,%esi
80103dae:	74 76                	je     80103e26 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103db0:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80103db6:	74 50                	je     80103e08 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103db8:	83 ec 0c             	sub    $0xc,%esp
80103dbb:	68 40 2d 11 80       	push   $0x80112d40
80103dc0:	e8 ab 06 00 00       	call   80104470 <acquire>
    release(lk);
80103dc5:	89 34 24             	mov    %esi,(%esp)
80103dc8:	e8 33 08 00 00       	call   80104600 <release>
  p->chan = chan;
80103dcd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103dd0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103dd7:	e8 64 fd ff ff       	call   80103b40 <sched>
  p->chan = 0;
80103ddc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103de3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103dea:	e8 11 08 00 00       	call   80104600 <release>
    acquire(lk);
80103def:	89 75 08             	mov    %esi,0x8(%ebp)
80103df2:	83 c4 10             	add    $0x10,%esp
}
80103df5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103df8:	5b                   	pop    %ebx
80103df9:	5e                   	pop    %esi
80103dfa:	5f                   	pop    %edi
80103dfb:	5d                   	pop    %ebp
    acquire(lk);
80103dfc:	e9 6f 06 00 00       	jmp    80104470 <acquire>
80103e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103e08:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e0b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e12:	e8 29 fd ff ff       	call   80103b40 <sched>
  p->chan = 0;
80103e17:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e21:	5b                   	pop    %ebx
80103e22:	5e                   	pop    %esi
80103e23:	5f                   	pop    %edi
80103e24:	5d                   	pop    %ebp
80103e25:	c3                   	ret    
    panic("sleep without lk");
80103e26:	83 ec 0c             	sub    $0xc,%esp
80103e29:	68 0f 78 10 80       	push   $0x8010780f
80103e2e:	e8 5d c5 ff ff       	call   80100390 <panic>
    panic("sleep");
80103e33:	83 ec 0c             	sub    $0xc,%esp
80103e36:	68 09 78 10 80       	push   $0x80107809
80103e3b:	e8 50 c5 ff ff       	call   80100390 <panic>

80103e40 <wait>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	56                   	push   %esi
80103e44:	53                   	push   %ebx
  pushcli();
80103e45:	e8 56 05 00 00       	call   801043a0 <pushcli>
  c = mycpu();
80103e4a:	e8 f1 f8 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103e4f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e55:	e8 86 05 00 00       	call   801043e0 <popcli>
  acquire(&ptable.lock);
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 40 2d 11 80       	push   $0x80112d40
80103e62:	e8 09 06 00 00       	call   80104470 <acquire>
80103e67:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103e6a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e6c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103e71:	eb 10                	jmp    80103e83 <wait+0x43>
80103e73:	90                   	nop
80103e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e78:	83 c3 7c             	add    $0x7c,%ebx
80103e7b:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103e81:	73 1b                	jae    80103e9e <wait+0x5e>
      if(p->parent != curproc)
80103e83:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e86:	75 f0                	jne    80103e78 <wait+0x38>
      if(p->state == ZOMBIE){
80103e88:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e8c:	74 32                	je     80103ec0 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e8e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103e91:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e96:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103e9c:	72 e5                	jb     80103e83 <wait+0x43>
    if(!havekids || curproc->killed){
80103e9e:	85 c0                	test   %eax,%eax
80103ea0:	74 74                	je     80103f16 <wait+0xd6>
80103ea2:	8b 46 24             	mov    0x24(%esi),%eax
80103ea5:	85 c0                	test   %eax,%eax
80103ea7:	75 6d                	jne    80103f16 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103ea9:	83 ec 08             	sub    $0x8,%esp
80103eac:	68 40 2d 11 80       	push   $0x80112d40
80103eb1:	56                   	push   %esi
80103eb2:	e8 c9 fe ff ff       	call   80103d80 <sleep>
    havekids = 0;
80103eb7:	83 c4 10             	add    $0x10,%esp
80103eba:	eb ae                	jmp    80103e6a <wait+0x2a>
80103ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103ec0:	83 ec 0c             	sub    $0xc,%esp
80103ec3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103ec6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103ec9:	e8 42 e4 ff ff       	call   80102310 <kfree>
        freevm(p->pgdir);
80103ece:	5a                   	pop    %edx
80103ecf:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103ed2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103ed9:	e8 12 30 00 00       	call   80106ef0 <freevm>
        release(&ptable.lock);
80103ede:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        p->pid = 0;
80103ee5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103eec:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103ef3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ef7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103efe:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f05:	e8 f6 06 00 00       	call   80104600 <release>
        return pid;
80103f0a:	83 c4 10             	add    $0x10,%esp
}
80103f0d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f10:	89 f0                	mov    %esi,%eax
80103f12:	5b                   	pop    %ebx
80103f13:	5e                   	pop    %esi
80103f14:	5d                   	pop    %ebp
80103f15:	c3                   	ret    
      release(&ptable.lock);
80103f16:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103f19:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103f1e:	68 40 2d 11 80       	push   $0x80112d40
80103f23:	e8 d8 06 00 00       	call   80104600 <release>
      return -1;
80103f28:	83 c4 10             	add    $0x10,%esp
80103f2b:	eb e0                	jmp    80103f0d <wait+0xcd>
80103f2d:	8d 76 00             	lea    0x0(%esi),%esi

80103f30 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	53                   	push   %ebx
80103f34:	83 ec 10             	sub    $0x10,%esp
80103f37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f3a:	68 40 2d 11 80       	push   $0x80112d40
80103f3f:	e8 2c 05 00 00       	call   80104470 <acquire>
80103f44:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f47:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103f4c:	eb 0c                	jmp    80103f5a <wakeup+0x2a>
80103f4e:	66 90                	xchg   %ax,%ax
80103f50:	83 c0 7c             	add    $0x7c,%eax
80103f53:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103f58:	73 1c                	jae    80103f76 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103f5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f5e:	75 f0                	jne    80103f50 <wakeup+0x20>
80103f60:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f63:	75 eb                	jne    80103f50 <wakeup+0x20>
      p->state = RUNNABLE;
80103f65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f6c:	83 c0 7c             	add    $0x7c,%eax
80103f6f:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103f74:	72 e4                	jb     80103f5a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80103f76:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
80103f7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f80:	c9                   	leave  
  release(&ptable.lock);
80103f81:	e9 7a 06 00 00       	jmp    80104600 <release>
80103f86:	8d 76 00             	lea    0x0(%esi),%esi
80103f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f90 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	53                   	push   %ebx
80103f94:	83 ec 10             	sub    $0x10,%esp
80103f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103f9a:	68 40 2d 11 80       	push   $0x80112d40
80103f9f:	e8 cc 04 00 00       	call   80104470 <acquire>
80103fa4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fa7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80103fac:	eb 0c                	jmp    80103fba <kill+0x2a>
80103fae:	66 90                	xchg   %ax,%ax
80103fb0:	83 c0 7c             	add    $0x7c,%eax
80103fb3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80103fb8:	73 36                	jae    80103ff0 <kill+0x60>
    if(p->pid == pid){
80103fba:	39 58 10             	cmp    %ebx,0x10(%eax)
80103fbd:	75 f1                	jne    80103fb0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fbf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80103fc3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80103fca:	75 07                	jne    80103fd3 <kill+0x43>
        p->state = RUNNABLE;
80103fcc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80103fd3:	83 ec 0c             	sub    $0xc,%esp
80103fd6:	68 40 2d 11 80       	push   $0x80112d40
80103fdb:	e8 20 06 00 00       	call   80104600 <release>
      return 0;
80103fe0:	83 c4 10             	add    $0x10,%esp
80103fe3:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103fe5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fe8:	c9                   	leave  
80103fe9:	c3                   	ret    
80103fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103ff0:	83 ec 0c             	sub    $0xc,%esp
80103ff3:	68 40 2d 11 80       	push   $0x80112d40
80103ff8:	e8 03 06 00 00       	call   80104600 <release>
  return -1;
80103ffd:	83 c4 10             	add    $0x10,%esp
80104000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104005:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104008:	c9                   	leave  
80104009:	c3                   	ret    
8010400a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104010 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	57                   	push   %edi
80104014:	56                   	push   %esi
80104015:	53                   	push   %ebx
80104016:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104019:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
8010401e:	83 ec 3c             	sub    $0x3c,%esp
80104021:	eb 24                	jmp    80104047 <procdump+0x37>
80104023:	90                   	nop
80104024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104028:	83 ec 0c             	sub    $0xc,%esp
8010402b:	68 ab 7b 10 80       	push   $0x80107bab
80104030:	e8 2b c6 ff ff       	call   80100660 <cprintf>
80104035:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104038:	83 c3 7c             	add    $0x7c,%ebx
8010403b:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104041:	0f 83 81 00 00 00    	jae    801040c8 <procdump+0xb8>
    if(p->state == UNUSED)
80104047:	8b 43 0c             	mov    0xc(%ebx),%eax
8010404a:	85 c0                	test   %eax,%eax
8010404c:	74 ea                	je     80104038 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010404e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104051:	ba 20 78 10 80       	mov    $0x80107820,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104056:	77 11                	ja     80104069 <procdump+0x59>
80104058:	8b 14 85 80 78 10 80 	mov    -0x7fef8780(,%eax,4),%edx
      state = "???";
8010405f:	b8 20 78 10 80       	mov    $0x80107820,%eax
80104064:	85 d2                	test   %edx,%edx
80104066:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104069:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010406c:	50                   	push   %eax
8010406d:	52                   	push   %edx
8010406e:	ff 73 10             	pushl  0x10(%ebx)
80104071:	68 24 78 10 80       	push   $0x80107824
80104076:	e8 e5 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010407b:	83 c4 10             	add    $0x10,%esp
8010407e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104082:	75 a4                	jne    80104028 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104084:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104087:	83 ec 08             	sub    $0x8,%esp
8010408a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010408d:	50                   	push   %eax
8010408e:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104091:	8b 40 0c             	mov    0xc(%eax),%eax
80104094:	83 c0 08             	add    $0x8,%eax
80104097:	50                   	push   %eax
80104098:	e8 b3 02 00 00       	call   80104350 <getcallerpcs>
8010409d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801040a0:	8b 17                	mov    (%edi),%edx
801040a2:	85 d2                	test   %edx,%edx
801040a4:	74 82                	je     80104028 <procdump+0x18>
        cprintf(" %p", pc[i]);
801040a6:	83 ec 08             	sub    $0x8,%esp
801040a9:	83 c7 04             	add    $0x4,%edi
801040ac:	52                   	push   %edx
801040ad:	68 61 72 10 80       	push   $0x80107261
801040b2:	e8 a9 c5 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801040b7:	83 c4 10             	add    $0x10,%esp
801040ba:	39 fe                	cmp    %edi,%esi
801040bc:	75 e2                	jne    801040a0 <procdump+0x90>
801040be:	e9 65 ff ff ff       	jmp    80104028 <procdump+0x18>
801040c3:	90                   	nop
801040c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
801040c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040cb:	5b                   	pop    %ebx
801040cc:	5e                   	pop    %esi
801040cd:	5f                   	pop    %edi
801040ce:	5d                   	pop    %ebp
801040cf:	c3                   	ret    

801040d0 <sleep_process>:



int
sleep_process(int pid)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 10             	sub    $0x10,%esp
801040d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  acquire(&ptable.lock);
801040da:	68 40 2d 11 80       	push   $0x80112d40
801040df:	e8 8c 03 00 00       	call   80104470 <acquire>
801040e4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040e7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801040ec:	eb 0c                	jmp    801040fa <sleep_process+0x2a>
801040ee:	66 90                	xchg   %ax,%ax
801040f0:	83 c0 7c             	add    $0x7c,%eax
801040f3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801040f8:	73 2e                	jae    80104128 <sleep_process+0x58>
    if(p->pid == pid){
801040fa:	39 58 10             	cmp    %ebx,0x10(%eax)
801040fd:	75 f1                	jne    801040f0 <sleep_process+0x20>
      if(p->state == RUNNABLE)
801040ff:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104103:	75 07                	jne    8010410c <sleep_process+0x3c>
        p->state = SLEEPING;
80104105:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
      release(&ptable.lock);
8010410c:	83 ec 0c             	sub    $0xc,%esp
8010410f:	68 40 2d 11 80       	push   $0x80112d40
80104114:	e8 e7 04 00 00       	call   80104600 <release>
      return 0;
80104119:	83 c4 10             	add    $0x10,%esp
8010411c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010411e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104121:	c9                   	leave  
80104122:	c3                   	ret    
80104123:	90                   	nop
80104124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 40 2d 11 80       	push   $0x80112d40
80104130:	e8 cb 04 00 00       	call   80104600 <release>
  return -1;
80104135:	83 c4 10             	add    $0x10,%esp
80104138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010413d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104140:	c9                   	leave  
80104141:	c3                   	ret    
80104142:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104150 <wakeup_process>:

int
wakeup_process(int pid)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	53                   	push   %ebx
80104154:	83 ec 10             	sub    $0x10,%esp
80104157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  acquire(&ptable.lock);
8010415a:	68 40 2d 11 80       	push   $0x80112d40
8010415f:	e8 0c 03 00 00       	call   80104470 <acquire>
80104164:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104167:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010416c:	eb 0c                	jmp    8010417a <wakeup_process+0x2a>
8010416e:	66 90                	xchg   %ax,%ax
80104170:	83 c0 7c             	add    $0x7c,%eax
80104173:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104178:	73 2e                	jae    801041a8 <wakeup_process+0x58>
    if(p->pid == pid){
8010417a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010417d:	75 f1                	jne    80104170 <wakeup_process+0x20>
      if(p->state == SLEEPING)
8010417f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104183:	75 07                	jne    8010418c <wakeup_process+0x3c>
        p->state = RUNNABLE;
80104185:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
8010418c:	83 ec 0c             	sub    $0xc,%esp
8010418f:	68 40 2d 11 80       	push   $0x80112d40
80104194:	e8 67 04 00 00       	call   80104600 <release>
      return 0;
80104199:	83 c4 10             	add    $0x10,%esp
8010419c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010419e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041a1:	c9                   	leave  
801041a2:	c3                   	ret    
801041a3:	90                   	nop
801041a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	68 40 2d 11 80       	push   $0x80112d40
801041b0:	e8 4b 04 00 00       	call   80104600 <release>
  return -1;
801041b5:	83 c4 10             	add    $0x10,%esp
801041b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041c0:	c9                   	leave  
801041c1:	c3                   	ret    
801041c2:	66 90                	xchg   %ax,%ax
801041c4:	66 90                	xchg   %ax,%ax
801041c6:	66 90                	xchg   %ax,%ax
801041c8:	66 90                	xchg   %ax,%ax
801041ca:	66 90                	xchg   %ax,%ax
801041cc:	66 90                	xchg   %ax,%ax
801041ce:	66 90                	xchg   %ax,%ax

801041d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	83 ec 0c             	sub    $0xc,%esp
801041d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041da:	68 98 78 10 80       	push   $0x80107898
801041df:	8d 43 04             	lea    0x4(%ebx),%eax
801041e2:	50                   	push   %eax
801041e3:	e8 18 01 00 00       	call   80104300 <initlock>
  lk->name = name;
801041e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041eb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801041f1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801041f4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801041fb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801041fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104201:	c9                   	leave  
80104202:	c3                   	ret    
80104203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104210 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	56                   	push   %esi
80104214:	53                   	push   %ebx
80104215:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104218:	83 ec 0c             	sub    $0xc,%esp
8010421b:	8d 73 04             	lea    0x4(%ebx),%esi
8010421e:	56                   	push   %esi
8010421f:	e8 4c 02 00 00       	call   80104470 <acquire>
  while (lk->locked) {
80104224:	8b 13                	mov    (%ebx),%edx
80104226:	83 c4 10             	add    $0x10,%esp
80104229:	85 d2                	test   %edx,%edx
8010422b:	74 16                	je     80104243 <acquiresleep+0x33>
8010422d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104230:	83 ec 08             	sub    $0x8,%esp
80104233:	56                   	push   %esi
80104234:	53                   	push   %ebx
80104235:	e8 46 fb ff ff       	call   80103d80 <sleep>
  while (lk->locked) {
8010423a:	8b 03                	mov    (%ebx),%eax
8010423c:	83 c4 10             	add    $0x10,%esp
8010423f:	85 c0                	test   %eax,%eax
80104241:	75 ed                	jne    80104230 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104243:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104249:	e8 92 f5 ff ff       	call   801037e0 <myproc>
8010424e:	8b 40 10             	mov    0x10(%eax),%eax
80104251:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104254:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104257:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010425a:	5b                   	pop    %ebx
8010425b:	5e                   	pop    %esi
8010425c:	5d                   	pop    %ebp
  release(&lk->lk);
8010425d:	e9 9e 03 00 00       	jmp    80104600 <release>
80104262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104270 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
80104275:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104278:	83 ec 0c             	sub    $0xc,%esp
8010427b:	8d 73 04             	lea    0x4(%ebx),%esi
8010427e:	56                   	push   %esi
8010427f:	e8 ec 01 00 00       	call   80104470 <acquire>
  lk->locked = 0;
80104284:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010428a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104291:	89 1c 24             	mov    %ebx,(%esp)
80104294:	e8 97 fc ff ff       	call   80103f30 <wakeup>
  release(&lk->lk);
80104299:	89 75 08             	mov    %esi,0x8(%ebp)
8010429c:	83 c4 10             	add    $0x10,%esp
}
8010429f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042a2:	5b                   	pop    %ebx
801042a3:	5e                   	pop    %esi
801042a4:	5d                   	pop    %ebp
  release(&lk->lk);
801042a5:	e9 56 03 00 00       	jmp    80104600 <release>
801042aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042b0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	57                   	push   %edi
801042b4:	56                   	push   %esi
801042b5:	53                   	push   %ebx
801042b6:	31 ff                	xor    %edi,%edi
801042b8:	83 ec 18             	sub    $0x18,%esp
801042bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801042be:	8d 73 04             	lea    0x4(%ebx),%esi
801042c1:	56                   	push   %esi
801042c2:	e8 a9 01 00 00       	call   80104470 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801042c7:	8b 03                	mov    (%ebx),%eax
801042c9:	83 c4 10             	add    $0x10,%esp
801042cc:	85 c0                	test   %eax,%eax
801042ce:	74 13                	je     801042e3 <holdingsleep+0x33>
801042d0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801042d3:	e8 08 f5 ff ff       	call   801037e0 <myproc>
801042d8:	39 58 10             	cmp    %ebx,0x10(%eax)
801042db:	0f 94 c0             	sete   %al
801042de:	0f b6 c0             	movzbl %al,%eax
801042e1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801042e3:	83 ec 0c             	sub    $0xc,%esp
801042e6:	56                   	push   %esi
801042e7:	e8 14 03 00 00       	call   80104600 <release>
  return r;
}
801042ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042ef:	89 f8                	mov    %edi,%eax
801042f1:	5b                   	pop    %ebx
801042f2:	5e                   	pop    %esi
801042f3:	5f                   	pop    %edi
801042f4:	5d                   	pop    %ebp
801042f5:	c3                   	ret    
801042f6:	66 90                	xchg   %ax,%ax
801042f8:	66 90                	xchg   %ax,%ax
801042fa:	66 90                	xchg   %ax,%ax
801042fc:	66 90                	xchg   %ax,%ax
801042fe:	66 90                	xchg   %ax,%ax

80104300 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104306:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104309:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010430f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104312:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104319:	5d                   	pop    %ebp
8010431a:	c3                   	ret    
8010431b:	90                   	nop
8010431c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104320 <initReentrantSpinlock>:

void
initReentrantSpinlock (struct spinLockReentrant *lk, char *name) {
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104326:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->pid = -1;
80104329:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  lk->name = name;
8010432f:	89 50 08             	mov    %edx,0x8(%eax)
  lk->locked = 0;
80104332:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  lk->cpu = 0;
80104339:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  initlock(&(lk->sl), name);
}
80104340:	5d                   	pop    %ebp
80104341:	c3                   	ret    
80104342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104350 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104350:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104351:	31 d2                	xor    %edx,%edx
{
80104353:	89 e5                	mov    %esp,%ebp
80104355:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104356:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104359:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010435c:	83 e8 08             	sub    $0x8,%eax
8010435f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104360:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104366:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010436c:	77 1a                	ja     80104388 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010436e:	8b 58 04             	mov    0x4(%eax),%ebx
80104371:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104374:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104377:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104379:	83 fa 0a             	cmp    $0xa,%edx
8010437c:	75 e2                	jne    80104360 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010437e:	5b                   	pop    %ebx
8010437f:	5d                   	pop    %ebp
80104380:	c3                   	ret    
80104381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104388:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010438b:	83 c1 28             	add    $0x28,%ecx
8010438e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104390:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104396:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104399:	39 c1                	cmp    %eax,%ecx
8010439b:	75 f3                	jne    80104390 <getcallerpcs+0x40>
}
8010439d:	5b                   	pop    %ebx
8010439e:	5d                   	pop    %ebp
8010439f:	c3                   	ret    

801043a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 04             	sub    $0x4,%esp
801043a7:	9c                   	pushf  
801043a8:	5b                   	pop    %ebx
  asm volatile("cli");
801043a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801043aa:	e8 91 f3 ff ff       	call   80103740 <mycpu>
801043af:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043b5:	85 c0                	test   %eax,%eax
801043b7:	75 11                	jne    801043ca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801043b9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801043bf:	e8 7c f3 ff ff       	call   80103740 <mycpu>
801043c4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801043ca:	e8 71 f3 ff ff       	call   80103740 <mycpu>
801043cf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801043d6:	83 c4 04             	add    $0x4,%esp
801043d9:	5b                   	pop    %ebx
801043da:	5d                   	pop    %ebp
801043db:	c3                   	ret    
801043dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043e0 <popcli>:

void
popcli(void)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043e6:	9c                   	pushf  
801043e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801043e8:	f6 c4 02             	test   $0x2,%ah
801043eb:	75 35                	jne    80104422 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801043ed:	e8 4e f3 ff ff       	call   80103740 <mycpu>
801043f2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801043f9:	78 34                	js     8010442f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043fb:	e8 40 f3 ff ff       	call   80103740 <mycpu>
80104400:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104406:	85 d2                	test   %edx,%edx
80104408:	74 06                	je     80104410 <popcli+0x30>
    sti();
}
8010440a:	c9                   	leave  
8010440b:	c3                   	ret    
8010440c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104410:	e8 2b f3 ff ff       	call   80103740 <mycpu>
80104415:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010441b:	85 c0                	test   %eax,%eax
8010441d:	74 eb                	je     8010440a <popcli+0x2a>
  asm volatile("sti");
8010441f:	fb                   	sti    
}
80104420:	c9                   	leave  
80104421:	c3                   	ret    
    panic("popcli - interruptible");
80104422:	83 ec 0c             	sub    $0xc,%esp
80104425:	68 a3 78 10 80       	push   $0x801078a3
8010442a:	e8 61 bf ff ff       	call   80100390 <panic>
    panic("popcli");
8010442f:	83 ec 0c             	sub    $0xc,%esp
80104432:	68 ba 78 10 80       	push   $0x801078ba
80104437:	e8 54 bf ff ff       	call   80100390 <panic>
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <holding>:
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
80104445:	8b 75 08             	mov    0x8(%ebp),%esi
80104448:	31 db                	xor    %ebx,%ebx
  pushcli();
8010444a:	e8 51 ff ff ff       	call   801043a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010444f:	8b 06                	mov    (%esi),%eax
80104451:	85 c0                	test   %eax,%eax
80104453:	74 10                	je     80104465 <holding+0x25>
80104455:	8b 5e 08             	mov    0x8(%esi),%ebx
80104458:	e8 e3 f2 ff ff       	call   80103740 <mycpu>
8010445d:	39 c3                	cmp    %eax,%ebx
8010445f:	0f 94 c3             	sete   %bl
80104462:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104465:	e8 76 ff ff ff       	call   801043e0 <popcli>
}
8010446a:	89 d8                	mov    %ebx,%eax
8010446c:	5b                   	pop    %ebx
8010446d:	5e                   	pop    %esi
8010446e:	5d                   	pop    %ebp
8010446f:	c3                   	ret    

80104470 <acquire>:
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104475:	e8 26 ff ff ff       	call   801043a0 <pushcli>
  if(holding(lk))
8010447a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010447d:	83 ec 0c             	sub    $0xc,%esp
80104480:	53                   	push   %ebx
80104481:	e8 ba ff ff ff       	call   80104440 <holding>
80104486:	83 c4 10             	add    $0x10,%esp
80104489:	85 c0                	test   %eax,%eax
8010448b:	0f 85 83 00 00 00    	jne    80104514 <acquire+0xa4>
80104491:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104493:	ba 01 00 00 00       	mov    $0x1,%edx
80104498:	eb 09                	jmp    801044a3 <acquire+0x33>
8010449a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044a3:	89 d0                	mov    %edx,%eax
801044a5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801044a8:	85 c0                	test   %eax,%eax
801044aa:	75 f4                	jne    801044a0 <acquire+0x30>
  __sync_synchronize();
801044ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801044b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044b4:	e8 87 f2 ff ff       	call   80103740 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801044b9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801044bc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801044bf:	89 e8                	mov    %ebp,%eax
801044c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044c8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801044ce:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801044d4:	77 1a                	ja     801044f0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801044d6:	8b 48 04             	mov    0x4(%eax),%ecx
801044d9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801044dc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801044df:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801044e1:	83 fe 0a             	cmp    $0xa,%esi
801044e4:	75 e2                	jne    801044c8 <acquire+0x58>
}
801044e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044e9:	5b                   	pop    %ebx
801044ea:	5e                   	pop    %esi
801044eb:	5d                   	pop    %ebp
801044ec:	c3                   	ret    
801044ed:	8d 76 00             	lea    0x0(%esi),%esi
801044f0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801044f3:	83 c2 28             	add    $0x28,%edx
801044f6:	8d 76 00             	lea    0x0(%esi),%esi
801044f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104500:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104506:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104509:	39 d0                	cmp    %edx,%eax
8010450b:	75 f3                	jne    80104500 <acquire+0x90>
}
8010450d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104510:	5b                   	pop    %ebx
80104511:	5e                   	pop    %esi
80104512:	5d                   	pop    %ebp
80104513:	c3                   	ret    
    panic("acquire");
80104514:	83 ec 0c             	sub    $0xc,%esp
80104517:	68 c1 78 10 80       	push   $0x801078c1
8010451c:	e8 6f be ff ff       	call   80100390 <panic>
80104521:	eb 0d                	jmp    80104530 <acquireReentrant>
80104523:	90                   	nop
80104524:	90                   	nop
80104525:	90                   	nop
80104526:	90                   	nop
80104527:	90                   	nop
80104528:	90                   	nop
80104529:	90                   	nop
8010452a:	90                   	nop
8010452b:	90                   	nop
8010452c:	90                   	nop
8010452d:	90                   	nop
8010452e:	90                   	nop
8010452f:	90                   	nop

80104530 <acquireReentrant>:
acquireReentrant (struct spinLockReentrant* lk) {
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	56                   	push   %esi
80104535:	53                   	push   %ebx
80104536:	83 ec 0c             	sub    $0xc,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104539:	e8 62 fe ff ff       	call   801043a0 <pushcli>
  int proccessId = myproc()->pid;
8010453e:	e8 9d f2 ff ff       	call   801037e0 <myproc>
  if (holding(&(lk->sl)) && lk->pid == proccessId) {
80104543:	8b 7d 08             	mov    0x8(%ebp),%edi
80104546:	83 ec 0c             	sub    $0xc,%esp
  int proccessId = myproc()->pid;
80104549:	8b 70 10             	mov    0x10(%eax),%esi
  if (holding(&(lk->sl)) && lk->pid == proccessId) {
8010454c:	8d 5f 04             	lea    0x4(%edi),%ebx
8010454f:	53                   	push   %ebx
80104550:	e8 eb fe ff ff       	call   80104440 <holding>
80104555:	83 c4 10             	add    $0x10,%esp
80104558:	85 c0                	test   %eax,%eax
8010455a:	74 08                	je     80104564 <acquireReentrant+0x34>
8010455c:	39 37                	cmp    %esi,(%edi)
8010455e:	0f 84 94 00 00 00    	je     801045f8 <acquireReentrant+0xc8>
80104564:	ba 01 00 00 00       	mov    $0x1,%edx
80104569:	eb 0b                	jmp    80104576 <acquireReentrant+0x46>
8010456b:	90                   	nop
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104570:	8b 45 08             	mov    0x8(%ebp),%eax
80104573:	8d 58 04             	lea    0x4(%eax),%ebx
80104576:	89 d0                	mov    %edx,%eax
80104578:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&((lk->sl).locked), 1) != 0)
8010457b:	85 c0                	test   %eax,%eax
8010457d:	75 f1                	jne    80104570 <acquireReentrant+0x40>
  __sync_synchronize();
8010457f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  (lk->sl).cpu = mycpu();
80104584:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104587:	e8 b4 f1 ff ff       	call   80103740 <mycpu>
  for(i = 0; i < 10; i++){
8010458c:	31 d2                	xor    %edx,%edx
  getcallerpcs(&lk, (lk->sl).pcs);  
8010458e:	8d 4b 10             	lea    0x10(%ebx),%ecx
  (lk->sl).cpu = mycpu();
80104591:	89 43 0c             	mov    %eax,0xc(%ebx)
  lk->pid = proccessId;
80104594:	89 33                	mov    %esi,(%ebx)
  ebp = (uint*)v - 2;
80104596:	89 e8                	mov    %ebp,%eax
80104598:	90                   	nop
80104599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045a0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801045a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045ac:	77 22                	ja     801045d0 <acquireReentrant+0xa0>
    pcs[i] = ebp[1];     // saved %eip
801045ae:	8b 58 04             	mov    0x4(%eax),%ebx
801045b1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801045b4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801045b7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801045b9:	83 fa 0a             	cmp    $0xa,%edx
801045bc:	75 e2                	jne    801045a0 <acquireReentrant+0x70>
}
801045be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045c1:	5b                   	pop    %ebx
801045c2:	5e                   	pop    %esi
801045c3:	5f                   	pop    %edi
801045c4:	5d                   	pop    %ebp
801045c5:	c3                   	ret    
801045c6:	8d 76 00             	lea    0x0(%esi),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801045d0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801045d3:	83 c1 28             	add    $0x28,%ecx
801045d6:	8d 76 00             	lea    0x0(%esi),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801045e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801045e6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801045e9:	39 c1                	cmp    %eax,%ecx
801045eb:	75 f3                	jne    801045e0 <acquireReentrant+0xb0>
}
801045ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045f0:	5b                   	pop    %ebx
801045f1:	5e                   	pop    %esi
801045f2:	5f                   	pop    %edi
801045f3:	5d                   	pop    %ebp
801045f4:	c3                   	ret    
801045f5:	8d 76 00             	lea    0x0(%esi),%esi
    popcli();
801045f8:	e8 e3 fd ff ff       	call   801043e0 <popcli>
    return;
801045fd:	eb bf                	jmp    801045be <acquireReentrant+0x8e>
801045ff:	90                   	nop

80104600 <release>:
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	53                   	push   %ebx
80104604:	83 ec 10             	sub    $0x10,%esp
80104607:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010460a:	53                   	push   %ebx
8010460b:	e8 30 fe ff ff       	call   80104440 <holding>
80104610:	83 c4 10             	add    $0x10,%esp
80104613:	85 c0                	test   %eax,%eax
80104615:	74 22                	je     80104639 <release+0x39>
  lk->pcs[0] = 0;
80104617:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010461e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104625:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010462a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104630:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104633:	c9                   	leave  
  popcli();
80104634:	e9 a7 fd ff ff       	jmp    801043e0 <popcli>
    panic("release");
80104639:	83 ec 0c             	sub    $0xc,%esp
8010463c:	68 c9 78 10 80       	push   $0x801078c9
80104641:	e8 4a bd ff ff       	call   80100390 <panic>
80104646:	8d 76 00             	lea    0x0(%esi),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <releaseReentrant>:
releaseReentrant(struct spinLockReentrant* lk) {
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	53                   	push   %ebx
80104655:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(&(lk->sl)) || (lk->pid != myproc()->pid))
80104658:	83 ec 0c             	sub    $0xc,%esp
8010465b:	8d 43 04             	lea    0x4(%ebx),%eax
8010465e:	50                   	push   %eax
8010465f:	e8 dc fd ff ff       	call   80104440 <holding>
80104664:	83 c4 10             	add    $0x10,%esp
80104667:	85 c0                	test   %eax,%eax
80104669:	74 31                	je     8010469c <releaseReentrant+0x4c>
8010466b:	8b 33                	mov    (%ebx),%esi
8010466d:	e8 6e f1 ff ff       	call   801037e0 <myproc>
80104672:	3b 70 10             	cmp    0x10(%eax),%esi
80104675:	75 25                	jne    8010469c <releaseReentrant+0x4c>
  (lk->sl).pcs[0] = 0;
80104677:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  (lk->sl).cpu = 0;
8010467e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  __sync_synchronize();
80104685:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" ((lk->sl).locked) : );
8010468a:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
}
80104691:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104694:	5b                   	pop    %ebx
80104695:	5e                   	pop    %esi
80104696:	5d                   	pop    %ebp
  popcli();  
80104697:	e9 44 fd ff ff       	jmp    801043e0 <popcli>
    panic("release");
8010469c:	83 ec 0c             	sub    $0xc,%esp
8010469f:	68 c9 78 10 80       	push   $0x801078c9
801046a4:	e8 e7 bc ff ff       	call   80100390 <panic>
801046a9:	66 90                	xchg   %ax,%ax
801046ab:	66 90                	xchg   %ax,%ax
801046ad:	66 90                	xchg   %ax,%ax
801046af:	90                   	nop

801046b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	53                   	push   %ebx
801046b5:	8b 55 08             	mov    0x8(%ebp),%edx
801046b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801046bb:	f6 c2 03             	test   $0x3,%dl
801046be:	75 05                	jne    801046c5 <memset+0x15>
801046c0:	f6 c1 03             	test   $0x3,%cl
801046c3:	74 13                	je     801046d8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801046c5:	89 d7                	mov    %edx,%edi
801046c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ca:	fc                   	cld    
801046cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801046cd:	5b                   	pop    %ebx
801046ce:	89 d0                	mov    %edx,%eax
801046d0:	5f                   	pop    %edi
801046d1:	5d                   	pop    %ebp
801046d2:	c3                   	ret    
801046d3:	90                   	nop
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801046d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801046dc:	c1 e9 02             	shr    $0x2,%ecx
801046df:	89 f8                	mov    %edi,%eax
801046e1:	89 fb                	mov    %edi,%ebx
801046e3:	c1 e0 18             	shl    $0x18,%eax
801046e6:	c1 e3 10             	shl    $0x10,%ebx
801046e9:	09 d8                	or     %ebx,%eax
801046eb:	09 f8                	or     %edi,%eax
801046ed:	c1 e7 08             	shl    $0x8,%edi
801046f0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801046f2:	89 d7                	mov    %edx,%edi
801046f4:	fc                   	cld    
801046f5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801046f7:	5b                   	pop    %ebx
801046f8:	89 d0                	mov    %edx,%eax
801046fa:	5f                   	pop    %edi
801046fb:	5d                   	pop    %ebp
801046fc:	c3                   	ret    
801046fd:	8d 76 00             	lea    0x0(%esi),%esi

80104700 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
80104705:	53                   	push   %ebx
80104706:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104709:	8b 75 08             	mov    0x8(%ebp),%esi
8010470c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010470f:	85 db                	test   %ebx,%ebx
80104711:	74 29                	je     8010473c <memcmp+0x3c>
    if(*s1 != *s2)
80104713:	0f b6 16             	movzbl (%esi),%edx
80104716:	0f b6 0f             	movzbl (%edi),%ecx
80104719:	38 d1                	cmp    %dl,%cl
8010471b:	75 2b                	jne    80104748 <memcmp+0x48>
8010471d:	b8 01 00 00 00       	mov    $0x1,%eax
80104722:	eb 14                	jmp    80104738 <memcmp+0x38>
80104724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104728:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010472c:	83 c0 01             	add    $0x1,%eax
8010472f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104734:	38 ca                	cmp    %cl,%dl
80104736:	75 10                	jne    80104748 <memcmp+0x48>
  while(n-- > 0){
80104738:	39 d8                	cmp    %ebx,%eax
8010473a:	75 ec                	jne    80104728 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010473c:	5b                   	pop    %ebx
  return 0;
8010473d:	31 c0                	xor    %eax,%eax
}
8010473f:	5e                   	pop    %esi
80104740:	5f                   	pop    %edi
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
80104743:	90                   	nop
80104744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104748:	0f b6 c2             	movzbl %dl,%eax
}
8010474b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010474c:	29 c8                	sub    %ecx,%eax
}
8010474e:	5e                   	pop    %esi
8010474f:	5f                   	pop    %edi
80104750:	5d                   	pop    %ebp
80104751:	c3                   	ret    
80104752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104760 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 45 08             	mov    0x8(%ebp),%eax
80104768:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010476b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010476e:	39 c3                	cmp    %eax,%ebx
80104770:	73 26                	jae    80104798 <memmove+0x38>
80104772:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104775:	39 c8                	cmp    %ecx,%eax
80104777:	73 1f                	jae    80104798 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104779:	85 f6                	test   %esi,%esi
8010477b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010477e:	74 0f                	je     8010478f <memmove+0x2f>
      *--d = *--s;
80104780:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104784:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104787:	83 ea 01             	sub    $0x1,%edx
8010478a:	83 fa ff             	cmp    $0xffffffff,%edx
8010478d:	75 f1                	jne    80104780 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010478f:	5b                   	pop    %ebx
80104790:	5e                   	pop    %esi
80104791:	5d                   	pop    %ebp
80104792:	c3                   	ret    
80104793:	90                   	nop
80104794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104798:	31 d2                	xor    %edx,%edx
8010479a:	85 f6                	test   %esi,%esi
8010479c:	74 f1                	je     8010478f <memmove+0x2f>
8010479e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801047a0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801047a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801047a7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801047aa:	39 d6                	cmp    %edx,%esi
801047ac:	75 f2                	jne    801047a0 <memmove+0x40>
}
801047ae:	5b                   	pop    %ebx
801047af:	5e                   	pop    %esi
801047b0:	5d                   	pop    %ebp
801047b1:	c3                   	ret    
801047b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801047c3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801047c4:	eb 9a                	jmp    80104760 <memmove>
801047c6:	8d 76 00             	lea    0x0(%esi),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	57                   	push   %edi
801047d4:	56                   	push   %esi
801047d5:	8b 7d 10             	mov    0x10(%ebp),%edi
801047d8:	53                   	push   %ebx
801047d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801047dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801047df:	85 ff                	test   %edi,%edi
801047e1:	74 2f                	je     80104812 <strncmp+0x42>
801047e3:	0f b6 01             	movzbl (%ecx),%eax
801047e6:	0f b6 1e             	movzbl (%esi),%ebx
801047e9:	84 c0                	test   %al,%al
801047eb:	74 37                	je     80104824 <strncmp+0x54>
801047ed:	38 c3                	cmp    %al,%bl
801047ef:	75 33                	jne    80104824 <strncmp+0x54>
801047f1:	01 f7                	add    %esi,%edi
801047f3:	eb 13                	jmp    80104808 <strncmp+0x38>
801047f5:	8d 76 00             	lea    0x0(%esi),%esi
801047f8:	0f b6 01             	movzbl (%ecx),%eax
801047fb:	84 c0                	test   %al,%al
801047fd:	74 21                	je     80104820 <strncmp+0x50>
801047ff:	0f b6 1a             	movzbl (%edx),%ebx
80104802:	89 d6                	mov    %edx,%esi
80104804:	38 d8                	cmp    %bl,%al
80104806:	75 1c                	jne    80104824 <strncmp+0x54>
    n--, p++, q++;
80104808:	8d 56 01             	lea    0x1(%esi),%edx
8010480b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010480e:	39 fa                	cmp    %edi,%edx
80104810:	75 e6                	jne    801047f8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104812:	5b                   	pop    %ebx
    return 0;
80104813:	31 c0                	xor    %eax,%eax
}
80104815:	5e                   	pop    %esi
80104816:	5f                   	pop    %edi
80104817:	5d                   	pop    %ebp
80104818:	c3                   	ret    
80104819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104820:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104824:	29 d8                	sub    %ebx,%eax
}
80104826:	5b                   	pop    %ebx
80104827:	5e                   	pop    %esi
80104828:	5f                   	pop    %edi
80104829:	5d                   	pop    %ebp
8010482a:	c3                   	ret    
8010482b:	90                   	nop
8010482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104830 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	53                   	push   %ebx
80104835:	8b 45 08             	mov    0x8(%ebp),%eax
80104838:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010483b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010483e:	89 c2                	mov    %eax,%edx
80104840:	eb 19                	jmp    8010485b <strncpy+0x2b>
80104842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104848:	83 c3 01             	add    $0x1,%ebx
8010484b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010484f:	83 c2 01             	add    $0x1,%edx
80104852:	84 c9                	test   %cl,%cl
80104854:	88 4a ff             	mov    %cl,-0x1(%edx)
80104857:	74 09                	je     80104862 <strncpy+0x32>
80104859:	89 f1                	mov    %esi,%ecx
8010485b:	85 c9                	test   %ecx,%ecx
8010485d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104860:	7f e6                	jg     80104848 <strncpy+0x18>
    ;
  while(n-- > 0)
80104862:	31 c9                	xor    %ecx,%ecx
80104864:	85 f6                	test   %esi,%esi
80104866:	7e 17                	jle    8010487f <strncpy+0x4f>
80104868:	90                   	nop
80104869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104870:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104874:	89 f3                	mov    %esi,%ebx
80104876:	83 c1 01             	add    $0x1,%ecx
80104879:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010487b:	85 db                	test   %ebx,%ebx
8010487d:	7f f1                	jg     80104870 <strncpy+0x40>
  return os;
}
8010487f:	5b                   	pop    %ebx
80104880:	5e                   	pop    %esi
80104881:	5d                   	pop    %ebp
80104882:	c3                   	ret    
80104883:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	56                   	push   %esi
80104894:	53                   	push   %ebx
80104895:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104898:	8b 45 08             	mov    0x8(%ebp),%eax
8010489b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010489e:	85 c9                	test   %ecx,%ecx
801048a0:	7e 26                	jle    801048c8 <safestrcpy+0x38>
801048a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801048a6:	89 c1                	mov    %eax,%ecx
801048a8:	eb 17                	jmp    801048c1 <safestrcpy+0x31>
801048aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801048b0:	83 c2 01             	add    $0x1,%edx
801048b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801048b7:	83 c1 01             	add    $0x1,%ecx
801048ba:	84 db                	test   %bl,%bl
801048bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801048bf:	74 04                	je     801048c5 <safestrcpy+0x35>
801048c1:	39 f2                	cmp    %esi,%edx
801048c3:	75 eb                	jne    801048b0 <safestrcpy+0x20>
    ;
  *s = 0;
801048c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801048c8:	5b                   	pop    %ebx
801048c9:	5e                   	pop    %esi
801048ca:	5d                   	pop    %ebp
801048cb:	c3                   	ret    
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048d0 <strlen>:

int
strlen(const char *s)
{
801048d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801048d1:	31 c0                	xor    %eax,%eax
{
801048d3:	89 e5                	mov    %esp,%ebp
801048d5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801048d8:	80 3a 00             	cmpb   $0x0,(%edx)
801048db:	74 0c                	je     801048e9 <strlen+0x19>
801048dd:	8d 76 00             	lea    0x0(%esi),%esi
801048e0:	83 c0 01             	add    $0x1,%eax
801048e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801048e7:	75 f7                	jne    801048e0 <strlen+0x10>
    ;
  return n;
}
801048e9:	5d                   	pop    %ebp
801048ea:	c3                   	ret    

801048eb <swtch>:
801048eb:	8b 44 24 04          	mov    0x4(%esp),%eax
801048ef:	8b 54 24 08          	mov    0x8(%esp),%edx
801048f3:	55                   	push   %ebp
801048f4:	53                   	push   %ebx
801048f5:	56                   	push   %esi
801048f6:	57                   	push   %edi
801048f7:	89 20                	mov    %esp,(%eax)
801048f9:	89 d4                	mov    %edx,%esp
801048fb:	5f                   	pop    %edi
801048fc:	5e                   	pop    %esi
801048fd:	5b                   	pop    %ebx
801048fe:	5d                   	pop    %ebp
801048ff:	c3                   	ret    

80104900 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
80104907:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010490a:	e8 d1 ee ff ff       	call   801037e0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010490f:	8b 00                	mov    (%eax),%eax
80104911:	39 d8                	cmp    %ebx,%eax
80104913:	76 1b                	jbe    80104930 <fetchint+0x30>
80104915:	8d 53 04             	lea    0x4(%ebx),%edx
80104918:	39 d0                	cmp    %edx,%eax
8010491a:	72 14                	jb     80104930 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010491c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010491f:	8b 13                	mov    (%ebx),%edx
80104921:	89 10                	mov    %edx,(%eax)
  return 0;
80104923:	31 c0                	xor    %eax,%eax
}
80104925:	83 c4 04             	add    $0x4,%esp
80104928:	5b                   	pop    %ebx
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    
8010492b:	90                   	nop
8010492c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104935:	eb ee                	jmp    80104925 <fetchint+0x25>
80104937:	89 f6                	mov    %esi,%esi
80104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104940 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	53                   	push   %ebx
80104944:	83 ec 04             	sub    $0x4,%esp
80104947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010494a:	e8 91 ee ff ff       	call   801037e0 <myproc>

  if(addr >= curproc->sz)
8010494f:	39 18                	cmp    %ebx,(%eax)
80104951:	76 29                	jbe    8010497c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104953:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104956:	89 da                	mov    %ebx,%edx
80104958:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010495a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010495c:	39 c3                	cmp    %eax,%ebx
8010495e:	73 1c                	jae    8010497c <fetchstr+0x3c>
    if(*s == 0)
80104960:	80 3b 00             	cmpb   $0x0,(%ebx)
80104963:	75 10                	jne    80104975 <fetchstr+0x35>
80104965:	eb 39                	jmp    801049a0 <fetchstr+0x60>
80104967:	89 f6                	mov    %esi,%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104970:	80 3a 00             	cmpb   $0x0,(%edx)
80104973:	74 1b                	je     80104990 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104975:	83 c2 01             	add    $0x1,%edx
80104978:	39 d0                	cmp    %edx,%eax
8010497a:	77 f4                	ja     80104970 <fetchstr+0x30>
    return -1;
8010497c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104981:	83 c4 04             	add    $0x4,%esp
80104984:	5b                   	pop    %ebx
80104985:	5d                   	pop    %ebp
80104986:	c3                   	ret    
80104987:	89 f6                	mov    %esi,%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104990:	83 c4 04             	add    $0x4,%esp
80104993:	89 d0                	mov    %edx,%eax
80104995:	29 d8                	sub    %ebx,%eax
80104997:	5b                   	pop    %ebx
80104998:	5d                   	pop    %ebp
80104999:	c3                   	ret    
8010499a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801049a0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801049a2:	eb dd                	jmp    80104981 <fetchstr+0x41>
801049a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801049b0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	56                   	push   %esi
801049b4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049b5:	e8 26 ee ff ff       	call   801037e0 <myproc>
801049ba:	8b 40 18             	mov    0x18(%eax),%eax
801049bd:	8b 55 08             	mov    0x8(%ebp),%edx
801049c0:	8b 40 44             	mov    0x44(%eax),%eax
801049c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801049c6:	e8 15 ee ff ff       	call   801037e0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049cb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049cd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049d0:	39 c6                	cmp    %eax,%esi
801049d2:	73 1c                	jae    801049f0 <argint+0x40>
801049d4:	8d 53 08             	lea    0x8(%ebx),%edx
801049d7:	39 d0                	cmp    %edx,%eax
801049d9:	72 15                	jb     801049f0 <argint+0x40>
  *ip = *(int*)(addr);
801049db:	8b 45 0c             	mov    0xc(%ebp),%eax
801049de:	8b 53 04             	mov    0x4(%ebx),%edx
801049e1:	89 10                	mov    %edx,(%eax)
  return 0;
801049e3:	31 c0                	xor    %eax,%eax
}
801049e5:	5b                   	pop    %ebx
801049e6:	5e                   	pop    %esi
801049e7:	5d                   	pop    %ebp
801049e8:	c3                   	ret    
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801049f5:	eb ee                	jmp    801049e5 <argint+0x35>
801049f7:	89 f6                	mov    %esi,%esi
801049f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
80104a05:	83 ec 10             	sub    $0x10,%esp
80104a08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104a0b:	e8 d0 ed ff ff       	call   801037e0 <myproc>
80104a10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104a12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a15:	83 ec 08             	sub    $0x8,%esp
80104a18:	50                   	push   %eax
80104a19:	ff 75 08             	pushl  0x8(%ebp)
80104a1c:	e8 8f ff ff ff       	call   801049b0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a21:	83 c4 10             	add    $0x10,%esp
80104a24:	85 c0                	test   %eax,%eax
80104a26:	78 28                	js     80104a50 <argptr+0x50>
80104a28:	85 db                	test   %ebx,%ebx
80104a2a:	78 24                	js     80104a50 <argptr+0x50>
80104a2c:	8b 16                	mov    (%esi),%edx
80104a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a31:	39 c2                	cmp    %eax,%edx
80104a33:	76 1b                	jbe    80104a50 <argptr+0x50>
80104a35:	01 c3                	add    %eax,%ebx
80104a37:	39 da                	cmp    %ebx,%edx
80104a39:	72 15                	jb     80104a50 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104a3b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a3e:	89 02                	mov    %eax,(%edx)
  return 0;
80104a40:	31 c0                	xor    %eax,%eax
}
80104a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a45:	5b                   	pop    %ebx
80104a46:	5e                   	pop    %esi
80104a47:	5d                   	pop    %ebp
80104a48:	c3                   	ret    
80104a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a55:	eb eb                	jmp    80104a42 <argptr+0x42>
80104a57:	89 f6                	mov    %esi,%esi
80104a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104a66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a69:	50                   	push   %eax
80104a6a:	ff 75 08             	pushl  0x8(%ebp)
80104a6d:	e8 3e ff ff ff       	call   801049b0 <argint>
80104a72:	83 c4 10             	add    $0x10,%esp
80104a75:	85 c0                	test   %eax,%eax
80104a77:	78 17                	js     80104a90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104a79:	83 ec 08             	sub    $0x8,%esp
80104a7c:	ff 75 0c             	pushl  0xc(%ebp)
80104a7f:	ff 75 f4             	pushl  -0xc(%ebp)
80104a82:	e8 b9 fe ff ff       	call   80104940 <fetchstr>
80104a87:	83 c4 10             	add    $0x10,%esp
}
80104a8a:	c9                   	leave  
80104a8b:	c3                   	ret    
80104a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a95:	c9                   	leave  
80104a96:	c3                   	ret    
80104a97:	89 f6                	mov    %esi,%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <syscall>:
[SYS_barrier] sys_barrier,
};

void
syscall(void)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	53                   	push   %ebx
80104aa4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104aa7:	e8 34 ed ff ff       	call   801037e0 <myproc>
80104aac:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104aae:	8b 40 18             	mov    0x18(%eax),%eax
80104ab1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104ab4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104ab7:	83 fa 16             	cmp    $0x16,%edx
80104aba:	77 1c                	ja     80104ad8 <syscall+0x38>
80104abc:	8b 14 85 00 79 10 80 	mov    -0x7fef8700(,%eax,4),%edx
80104ac3:	85 d2                	test   %edx,%edx
80104ac5:	74 11                	je     80104ad8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104ac7:	ff d2                	call   *%edx
80104ac9:	8b 53 18             	mov    0x18(%ebx),%edx
80104acc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104acf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ad2:	c9                   	leave  
80104ad3:	c3                   	ret    
80104ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104ad8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ad9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104adc:	50                   	push   %eax
80104add:	ff 73 10             	pushl  0x10(%ebx)
80104ae0:	68 d1 78 10 80       	push   $0x801078d1
80104ae5:	e8 76 bb ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104aea:	8b 43 18             	mov    0x18(%ebx),%eax
80104aed:	83 c4 10             	add    $0x10,%esp
80104af0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104af7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104afa:	c9                   	leave  
80104afb:	c3                   	ret    
80104afc:	66 90                	xchg   %ax,%ax
80104afe:	66 90                	xchg   %ax,%ax

80104b00 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	57                   	push   %edi
80104b04:	56                   	push   %esi
80104b05:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b06:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104b09:	83 ec 34             	sub    $0x34,%esp
80104b0c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104b0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104b12:	56                   	push   %esi
80104b13:	50                   	push   %eax
{
80104b14:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104b17:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104b1a:	e8 e1 d3 ff ff       	call   80101f00 <nameiparent>
80104b1f:	83 c4 10             	add    $0x10,%esp
80104b22:	85 c0                	test   %eax,%eax
80104b24:	0f 84 46 01 00 00    	je     80104c70 <create+0x170>
    return 0;
  ilock(dp);
80104b2a:	83 ec 0c             	sub    $0xc,%esp
80104b2d:	89 c3                	mov    %eax,%ebx
80104b2f:	50                   	push   %eax
80104b30:	e8 4b cb ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104b35:	83 c4 0c             	add    $0xc,%esp
80104b38:	6a 00                	push   $0x0
80104b3a:	56                   	push   %esi
80104b3b:	53                   	push   %ebx
80104b3c:	e8 6f d0 ff ff       	call   80101bb0 <dirlookup>
80104b41:	83 c4 10             	add    $0x10,%esp
80104b44:	85 c0                	test   %eax,%eax
80104b46:	89 c7                	mov    %eax,%edi
80104b48:	74 36                	je     80104b80 <create+0x80>
    iunlockput(dp);
80104b4a:	83 ec 0c             	sub    $0xc,%esp
80104b4d:	53                   	push   %ebx
80104b4e:	e8 bd cd ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104b53:	89 3c 24             	mov    %edi,(%esp)
80104b56:	e8 25 cb ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104b5b:	83 c4 10             	add    $0x10,%esp
80104b5e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104b63:	0f 85 97 00 00 00    	jne    80104c00 <create+0x100>
80104b69:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104b6e:	0f 85 8c 00 00 00    	jne    80104c00 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b77:	89 f8                	mov    %edi,%eax
80104b79:	5b                   	pop    %ebx
80104b7a:	5e                   	pop    %esi
80104b7b:	5f                   	pop    %edi
80104b7c:	5d                   	pop    %ebp
80104b7d:	c3                   	ret    
80104b7e:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
80104b80:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104b84:	83 ec 08             	sub    $0x8,%esp
80104b87:	50                   	push   %eax
80104b88:	ff 33                	pushl  (%ebx)
80104b8a:	e8 81 c9 ff ff       	call   80101510 <ialloc>
80104b8f:	83 c4 10             	add    $0x10,%esp
80104b92:	85 c0                	test   %eax,%eax
80104b94:	89 c7                	mov    %eax,%edi
80104b96:	0f 84 e8 00 00 00    	je     80104c84 <create+0x184>
  ilock(ip);
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	50                   	push   %eax
80104ba0:	e8 db ca ff ff       	call   80101680 <ilock>
  ip->major = major;
80104ba5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104ba9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104bad:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104bb1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104bb5:	b8 01 00 00 00       	mov    $0x1,%eax
80104bba:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104bbe:	89 3c 24             	mov    %edi,(%esp)
80104bc1:	e8 0a ca ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104bc6:	83 c4 10             	add    $0x10,%esp
80104bc9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104bce:	74 50                	je     80104c20 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104bd0:	83 ec 04             	sub    $0x4,%esp
80104bd3:	ff 77 04             	pushl  0x4(%edi)
80104bd6:	56                   	push   %esi
80104bd7:	53                   	push   %ebx
80104bd8:	e8 43 d2 ff ff       	call   80101e20 <dirlink>
80104bdd:	83 c4 10             	add    $0x10,%esp
80104be0:	85 c0                	test   %eax,%eax
80104be2:	0f 88 8f 00 00 00    	js     80104c77 <create+0x177>
  iunlockput(dp);
80104be8:	83 ec 0c             	sub    $0xc,%esp
80104beb:	53                   	push   %ebx
80104bec:	e8 1f cd ff ff       	call   80101910 <iunlockput>
  return ip;
80104bf1:	83 c4 10             	add    $0x10,%esp
}
80104bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bf7:	89 f8                	mov    %edi,%eax
80104bf9:	5b                   	pop    %ebx
80104bfa:	5e                   	pop    %esi
80104bfb:	5f                   	pop    %edi
80104bfc:	5d                   	pop    %ebp
80104bfd:	c3                   	ret    
80104bfe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104c00:	83 ec 0c             	sub    $0xc,%esp
80104c03:	57                   	push   %edi
    return 0;
80104c04:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104c06:	e8 05 cd ff ff       	call   80101910 <iunlockput>
    return 0;
80104c0b:	83 c4 10             	add    $0x10,%esp
}
80104c0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c11:	89 f8                	mov    %edi,%eax
80104c13:	5b                   	pop    %ebx
80104c14:	5e                   	pop    %esi
80104c15:	5f                   	pop    %edi
80104c16:	5d                   	pop    %ebp
80104c17:	c3                   	ret    
80104c18:	90                   	nop
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104c20:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104c25:	83 ec 0c             	sub    $0xc,%esp
80104c28:	53                   	push   %ebx
80104c29:	e8 a2 c9 ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104c2e:	83 c4 0c             	add    $0xc,%esp
80104c31:	ff 77 04             	pushl  0x4(%edi)
80104c34:	68 7c 79 10 80       	push   $0x8010797c
80104c39:	57                   	push   %edi
80104c3a:	e8 e1 d1 ff ff       	call   80101e20 <dirlink>
80104c3f:	83 c4 10             	add    $0x10,%esp
80104c42:	85 c0                	test   %eax,%eax
80104c44:	78 1c                	js     80104c62 <create+0x162>
80104c46:	83 ec 04             	sub    $0x4,%esp
80104c49:	ff 73 04             	pushl  0x4(%ebx)
80104c4c:	68 7b 79 10 80       	push   $0x8010797b
80104c51:	57                   	push   %edi
80104c52:	e8 c9 d1 ff ff       	call   80101e20 <dirlink>
80104c57:	83 c4 10             	add    $0x10,%esp
80104c5a:	85 c0                	test   %eax,%eax
80104c5c:	0f 89 6e ff ff ff    	jns    80104bd0 <create+0xd0>
      panic("create dots");
80104c62:	83 ec 0c             	sub    $0xc,%esp
80104c65:	68 6f 79 10 80       	push   $0x8010796f
80104c6a:	e8 21 b7 ff ff       	call   80100390 <panic>
80104c6f:	90                   	nop
    return 0;
80104c70:	31 ff                	xor    %edi,%edi
80104c72:	e9 fd fe ff ff       	jmp    80104b74 <create+0x74>
    panic("create: dirlink");
80104c77:	83 ec 0c             	sub    $0xc,%esp
80104c7a:	68 7e 79 10 80       	push   $0x8010797e
80104c7f:	e8 0c b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104c84:	83 ec 0c             	sub    $0xc,%esp
80104c87:	68 60 79 10 80       	push   $0x80107960
80104c8c:	e8 ff b6 ff ff       	call   80100390 <panic>
80104c91:	eb 0d                	jmp    80104ca0 <argfd.constprop.0>
80104c93:	90                   	nop
80104c94:	90                   	nop
80104c95:	90                   	nop
80104c96:	90                   	nop
80104c97:	90                   	nop
80104c98:	90                   	nop
80104c99:	90                   	nop
80104c9a:	90                   	nop
80104c9b:	90                   	nop
80104c9c:	90                   	nop
80104c9d:	90                   	nop
80104c9e:	90                   	nop
80104c9f:	90                   	nop

80104ca0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	56                   	push   %esi
80104ca4:	53                   	push   %ebx
80104ca5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104ca7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104caa:	89 d6                	mov    %edx,%esi
80104cac:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104caf:	50                   	push   %eax
80104cb0:	6a 00                	push   $0x0
80104cb2:	e8 f9 fc ff ff       	call   801049b0 <argint>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	78 2a                	js     80104ce8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104cbe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104cc2:	77 24                	ja     80104ce8 <argfd.constprop.0+0x48>
80104cc4:	e8 17 eb ff ff       	call   801037e0 <myproc>
80104cc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ccc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104cd0:	85 c0                	test   %eax,%eax
80104cd2:	74 14                	je     80104ce8 <argfd.constprop.0+0x48>
  if(pfd)
80104cd4:	85 db                	test   %ebx,%ebx
80104cd6:	74 02                	je     80104cda <argfd.constprop.0+0x3a>
    *pfd = fd;
80104cd8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104cda:	89 06                	mov    %eax,(%esi)
  return 0;
80104cdc:	31 c0                	xor    %eax,%eax
}
80104cde:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ce1:	5b                   	pop    %ebx
80104ce2:	5e                   	pop    %esi
80104ce3:	5d                   	pop    %ebp
80104ce4:	c3                   	ret    
80104ce5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ce8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ced:	eb ef                	jmp    80104cde <argfd.constprop.0+0x3e>
80104cef:	90                   	nop

80104cf0 <sys_dup>:
{
80104cf0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	56                   	push   %esi
80104cf6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104cf7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104cfa:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104cfd:	e8 9e ff ff ff       	call   80104ca0 <argfd.constprop.0>
80104d02:	85 c0                	test   %eax,%eax
80104d04:	78 42                	js     80104d48 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104d06:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104d09:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104d0b:	e8 d0 ea ff ff       	call   801037e0 <myproc>
80104d10:	eb 0e                	jmp    80104d20 <sys_dup+0x30>
80104d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104d18:	83 c3 01             	add    $0x1,%ebx
80104d1b:	83 fb 10             	cmp    $0x10,%ebx
80104d1e:	74 28                	je     80104d48 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104d20:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d24:	85 d2                	test   %edx,%edx
80104d26:	75 f0                	jne    80104d18 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104d28:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104d2c:	83 ec 0c             	sub    $0xc,%esp
80104d2f:	ff 75 f4             	pushl  -0xc(%ebp)
80104d32:	e8 b9 c0 ff ff       	call   80100df0 <filedup>
  return fd;
80104d37:	83 c4 10             	add    $0x10,%esp
}
80104d3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d3d:	89 d8                	mov    %ebx,%eax
80104d3f:	5b                   	pop    %ebx
80104d40:	5e                   	pop    %esi
80104d41:	5d                   	pop    %ebp
80104d42:	c3                   	ret    
80104d43:	90                   	nop
80104d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d48:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d4b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d50:	89 d8                	mov    %ebx,%eax
80104d52:	5b                   	pop    %ebx
80104d53:	5e                   	pop    %esi
80104d54:	5d                   	pop    %ebp
80104d55:	c3                   	ret    
80104d56:	8d 76 00             	lea    0x0(%esi),%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_read>:
{
80104d60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d61:	31 c0                	xor    %eax,%eax
{
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d6b:	e8 30 ff ff ff       	call   80104ca0 <argfd.constprop.0>
80104d70:	85 c0                	test   %eax,%eax
80104d72:	78 4c                	js     80104dc0 <sys_read+0x60>
80104d74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d77:	83 ec 08             	sub    $0x8,%esp
80104d7a:	50                   	push   %eax
80104d7b:	6a 02                	push   $0x2
80104d7d:	e8 2e fc ff ff       	call   801049b0 <argint>
80104d82:	83 c4 10             	add    $0x10,%esp
80104d85:	85 c0                	test   %eax,%eax
80104d87:	78 37                	js     80104dc0 <sys_read+0x60>
80104d89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d8c:	83 ec 04             	sub    $0x4,%esp
80104d8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d92:	50                   	push   %eax
80104d93:	6a 01                	push   $0x1
80104d95:	e8 66 fc ff ff       	call   80104a00 <argptr>
80104d9a:	83 c4 10             	add    $0x10,%esp
80104d9d:	85 c0                	test   %eax,%eax
80104d9f:	78 1f                	js     80104dc0 <sys_read+0x60>
  return fileread(f, p, n);
80104da1:	83 ec 04             	sub    $0x4,%esp
80104da4:	ff 75 f0             	pushl  -0x10(%ebp)
80104da7:	ff 75 f4             	pushl  -0xc(%ebp)
80104daa:	ff 75 ec             	pushl  -0x14(%ebp)
80104dad:	e8 ae c1 ff ff       	call   80100f60 <fileread>
80104db2:	83 c4 10             	add    $0x10,%esp
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <sys_write>:
{
80104dd0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104dd1:	31 c0                	xor    %eax,%eax
{
80104dd3:	89 e5                	mov    %esp,%ebp
80104dd5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104dd8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104ddb:	e8 c0 fe ff ff       	call   80104ca0 <argfd.constprop.0>
80104de0:	85 c0                	test   %eax,%eax
80104de2:	78 4c                	js     80104e30 <sys_write+0x60>
80104de4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104de7:	83 ec 08             	sub    $0x8,%esp
80104dea:	50                   	push   %eax
80104deb:	6a 02                	push   $0x2
80104ded:	e8 be fb ff ff       	call   801049b0 <argint>
80104df2:	83 c4 10             	add    $0x10,%esp
80104df5:	85 c0                	test   %eax,%eax
80104df7:	78 37                	js     80104e30 <sys_write+0x60>
80104df9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dfc:	83 ec 04             	sub    $0x4,%esp
80104dff:	ff 75 f0             	pushl  -0x10(%ebp)
80104e02:	50                   	push   %eax
80104e03:	6a 01                	push   $0x1
80104e05:	e8 f6 fb ff ff       	call   80104a00 <argptr>
80104e0a:	83 c4 10             	add    $0x10,%esp
80104e0d:	85 c0                	test   %eax,%eax
80104e0f:	78 1f                	js     80104e30 <sys_write+0x60>
  return filewrite(f, p, n);
80104e11:	83 ec 04             	sub    $0x4,%esp
80104e14:	ff 75 f0             	pushl  -0x10(%ebp)
80104e17:	ff 75 f4             	pushl  -0xc(%ebp)
80104e1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e1d:	e8 ce c1 ff ff       	call   80100ff0 <filewrite>
80104e22:	83 c4 10             	add    $0x10,%esp
}
80104e25:	c9                   	leave  
80104e26:	c3                   	ret    
80104e27:	89 f6                	mov    %esi,%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e35:	c9                   	leave  
80104e36:	c3                   	ret    
80104e37:	89 f6                	mov    %esi,%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e40 <sys_close>:
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104e46:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104e49:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e4c:	e8 4f fe ff ff       	call   80104ca0 <argfd.constprop.0>
80104e51:	85 c0                	test   %eax,%eax
80104e53:	78 2b                	js     80104e80 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104e55:	e8 86 e9 ff ff       	call   801037e0 <myproc>
80104e5a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104e5d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104e60:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104e67:	00 
  fileclose(f);
80104e68:	ff 75 f4             	pushl  -0xc(%ebp)
80104e6b:	e8 d0 bf ff ff       	call   80100e40 <fileclose>
  return 0;
80104e70:	83 c4 10             	add    $0x10,%esp
80104e73:	31 c0                	xor    %eax,%eax
}
80104e75:	c9                   	leave  
80104e76:	c3                   	ret    
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	89 f6                	mov    %esi,%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <sys_fstat>:
{
80104e90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e91:	31 c0                	xor    %eax,%eax
{
80104e93:	89 e5                	mov    %esp,%ebp
80104e95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e98:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e9b:	e8 00 fe ff ff       	call   80104ca0 <argfd.constprop.0>
80104ea0:	85 c0                	test   %eax,%eax
80104ea2:	78 2c                	js     80104ed0 <sys_fstat+0x40>
80104ea4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ea7:	83 ec 04             	sub    $0x4,%esp
80104eaa:	6a 14                	push   $0x14
80104eac:	50                   	push   %eax
80104ead:	6a 01                	push   $0x1
80104eaf:	e8 4c fb ff ff       	call   80104a00 <argptr>
80104eb4:	83 c4 10             	add    $0x10,%esp
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	78 15                	js     80104ed0 <sys_fstat+0x40>
  return filestat(f, st);
80104ebb:	83 ec 08             	sub    $0x8,%esp
80104ebe:	ff 75 f4             	pushl  -0xc(%ebp)
80104ec1:	ff 75 f0             	pushl  -0x10(%ebp)
80104ec4:	e8 47 c0 ff ff       	call   80100f10 <filestat>
80104ec9:	83 c4 10             	add    $0x10,%esp
}
80104ecc:	c9                   	leave  
80104ecd:	c3                   	ret    
80104ece:	66 90                	xchg   %ax,%ax
    return -1;
80104ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ee0 <sys_link>:
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	57                   	push   %edi
80104ee4:	56                   	push   %esi
80104ee5:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ee6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104ee9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104eec:	50                   	push   %eax
80104eed:	6a 00                	push   $0x0
80104eef:	e8 6c fb ff ff       	call   80104a60 <argstr>
80104ef4:	83 c4 10             	add    $0x10,%esp
80104ef7:	85 c0                	test   %eax,%eax
80104ef9:	0f 88 fb 00 00 00    	js     80104ffa <sys_link+0x11a>
80104eff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104f02:	83 ec 08             	sub    $0x8,%esp
80104f05:	50                   	push   %eax
80104f06:	6a 01                	push   $0x1
80104f08:	e8 53 fb ff ff       	call   80104a60 <argstr>
80104f0d:	83 c4 10             	add    $0x10,%esp
80104f10:	85 c0                	test   %eax,%eax
80104f12:	0f 88 e2 00 00 00    	js     80104ffa <sys_link+0x11a>
  begin_op();
80104f18:	e8 83 dc ff ff       	call   80102ba0 <begin_op>
  if((ip = namei(old)) == 0){
80104f1d:	83 ec 0c             	sub    $0xc,%esp
80104f20:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f23:	e8 b8 cf ff ff       	call   80101ee0 <namei>
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	85 c0                	test   %eax,%eax
80104f2d:	89 c3                	mov    %eax,%ebx
80104f2f:	0f 84 ea 00 00 00    	je     8010501f <sys_link+0x13f>
  ilock(ip);
80104f35:	83 ec 0c             	sub    $0xc,%esp
80104f38:	50                   	push   %eax
80104f39:	e8 42 c7 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
80104f3e:	83 c4 10             	add    $0x10,%esp
80104f41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f46:	0f 84 bb 00 00 00    	je     80105007 <sys_link+0x127>
  ip->nlink++;
80104f4c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f51:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104f54:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104f57:	53                   	push   %ebx
80104f58:	e8 73 c6 ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
80104f5d:	89 1c 24             	mov    %ebx,(%esp)
80104f60:	e8 fb c7 ff ff       	call   80101760 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104f65:	58                   	pop    %eax
80104f66:	5a                   	pop    %edx
80104f67:	57                   	push   %edi
80104f68:	ff 75 d0             	pushl  -0x30(%ebp)
80104f6b:	e8 90 cf ff ff       	call   80101f00 <nameiparent>
80104f70:	83 c4 10             	add    $0x10,%esp
80104f73:	85 c0                	test   %eax,%eax
80104f75:	89 c6                	mov    %eax,%esi
80104f77:	74 5b                	je     80104fd4 <sys_link+0xf4>
  ilock(dp);
80104f79:	83 ec 0c             	sub    $0xc,%esp
80104f7c:	50                   	push   %eax
80104f7d:	e8 fe c6 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f82:	83 c4 10             	add    $0x10,%esp
80104f85:	8b 03                	mov    (%ebx),%eax
80104f87:	39 06                	cmp    %eax,(%esi)
80104f89:	75 3d                	jne    80104fc8 <sys_link+0xe8>
80104f8b:	83 ec 04             	sub    $0x4,%esp
80104f8e:	ff 73 04             	pushl  0x4(%ebx)
80104f91:	57                   	push   %edi
80104f92:	56                   	push   %esi
80104f93:	e8 88 ce ff ff       	call   80101e20 <dirlink>
80104f98:	83 c4 10             	add    $0x10,%esp
80104f9b:	85 c0                	test   %eax,%eax
80104f9d:	78 29                	js     80104fc8 <sys_link+0xe8>
  iunlockput(dp);
80104f9f:	83 ec 0c             	sub    $0xc,%esp
80104fa2:	56                   	push   %esi
80104fa3:	e8 68 c9 ff ff       	call   80101910 <iunlockput>
  iput(ip);
80104fa8:	89 1c 24             	mov    %ebx,(%esp)
80104fab:	e8 00 c8 ff ff       	call   801017b0 <iput>
  end_op();
80104fb0:	e8 5b dc ff ff       	call   80102c10 <end_op>
  return 0;
80104fb5:	83 c4 10             	add    $0x10,%esp
80104fb8:	31 c0                	xor    %eax,%eax
}
80104fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fbd:	5b                   	pop    %ebx
80104fbe:	5e                   	pop    %esi
80104fbf:	5f                   	pop    %edi
80104fc0:	5d                   	pop    %ebp
80104fc1:	c3                   	ret    
80104fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104fc8:	83 ec 0c             	sub    $0xc,%esp
80104fcb:	56                   	push   %esi
80104fcc:	e8 3f c9 ff ff       	call   80101910 <iunlockput>
    goto bad;
80104fd1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104fd4:	83 ec 0c             	sub    $0xc,%esp
80104fd7:	53                   	push   %ebx
80104fd8:	e8 a3 c6 ff ff       	call   80101680 <ilock>
  ip->nlink--;
80104fdd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104fe2:	89 1c 24             	mov    %ebx,(%esp)
80104fe5:	e8 e6 c5 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80104fea:	89 1c 24             	mov    %ebx,(%esp)
80104fed:	e8 1e c9 ff ff       	call   80101910 <iunlockput>
  end_op();
80104ff2:	e8 19 dc ff ff       	call   80102c10 <end_op>
  return -1;
80104ff7:	83 c4 10             	add    $0x10,%esp
}
80104ffa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104ffd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105002:	5b                   	pop    %ebx
80105003:	5e                   	pop    %esi
80105004:	5f                   	pop    %edi
80105005:	5d                   	pop    %ebp
80105006:	c3                   	ret    
    iunlockput(ip);
80105007:	83 ec 0c             	sub    $0xc,%esp
8010500a:	53                   	push   %ebx
8010500b:	e8 00 c9 ff ff       	call   80101910 <iunlockput>
    end_op();
80105010:	e8 fb db ff ff       	call   80102c10 <end_op>
    return -1;
80105015:	83 c4 10             	add    $0x10,%esp
80105018:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010501d:	eb 9b                	jmp    80104fba <sys_link+0xda>
    end_op();
8010501f:	e8 ec db ff ff       	call   80102c10 <end_op>
    return -1;
80105024:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105029:	eb 8f                	jmp    80104fba <sys_link+0xda>
8010502b:	90                   	nop
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105030 <sys_unlink>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105036:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105039:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010503c:	50                   	push   %eax
8010503d:	6a 00                	push   $0x0
8010503f:	e8 1c fa ff ff       	call   80104a60 <argstr>
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	85 c0                	test   %eax,%eax
80105049:	0f 88 77 01 00 00    	js     801051c6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
8010504f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105052:	e8 49 db ff ff       	call   80102ba0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105057:	83 ec 08             	sub    $0x8,%esp
8010505a:	53                   	push   %ebx
8010505b:	ff 75 c0             	pushl  -0x40(%ebp)
8010505e:	e8 9d ce ff ff       	call   80101f00 <nameiparent>
80105063:	83 c4 10             	add    $0x10,%esp
80105066:	85 c0                	test   %eax,%eax
80105068:	89 c6                	mov    %eax,%esi
8010506a:	0f 84 60 01 00 00    	je     801051d0 <sys_unlink+0x1a0>
  ilock(dp);
80105070:	83 ec 0c             	sub    $0xc,%esp
80105073:	50                   	push   %eax
80105074:	e8 07 c6 ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105079:	58                   	pop    %eax
8010507a:	5a                   	pop    %edx
8010507b:	68 7c 79 10 80       	push   $0x8010797c
80105080:	53                   	push   %ebx
80105081:	e8 0a cb ff ff       	call   80101b90 <namecmp>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	85 c0                	test   %eax,%eax
8010508b:	0f 84 03 01 00 00    	je     80105194 <sys_unlink+0x164>
80105091:	83 ec 08             	sub    $0x8,%esp
80105094:	68 7b 79 10 80       	push   $0x8010797b
80105099:	53                   	push   %ebx
8010509a:	e8 f1 ca ff ff       	call   80101b90 <namecmp>
8010509f:	83 c4 10             	add    $0x10,%esp
801050a2:	85 c0                	test   %eax,%eax
801050a4:	0f 84 ea 00 00 00    	je     80105194 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
801050aa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801050ad:	83 ec 04             	sub    $0x4,%esp
801050b0:	50                   	push   %eax
801050b1:	53                   	push   %ebx
801050b2:	56                   	push   %esi
801050b3:	e8 f8 ca ff ff       	call   80101bb0 <dirlookup>
801050b8:	83 c4 10             	add    $0x10,%esp
801050bb:	85 c0                	test   %eax,%eax
801050bd:	89 c3                	mov    %eax,%ebx
801050bf:	0f 84 cf 00 00 00    	je     80105194 <sys_unlink+0x164>
  ilock(ip);
801050c5:	83 ec 0c             	sub    $0xc,%esp
801050c8:	50                   	push   %eax
801050c9:	e8 b2 c5 ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
801050ce:	83 c4 10             	add    $0x10,%esp
801050d1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801050d6:	0f 8e 10 01 00 00    	jle    801051ec <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801050dc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050e1:	74 6d                	je     80105150 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801050e3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050e6:	83 ec 04             	sub    $0x4,%esp
801050e9:	6a 10                	push   $0x10
801050eb:	6a 00                	push   $0x0
801050ed:	50                   	push   %eax
801050ee:	e8 bd f5 ff ff       	call   801046b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050f3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050f6:	6a 10                	push   $0x10
801050f8:	ff 75 c4             	pushl  -0x3c(%ebp)
801050fb:	50                   	push   %eax
801050fc:	56                   	push   %esi
801050fd:	e8 5e c9 ff ff       	call   80101a60 <writei>
80105102:	83 c4 20             	add    $0x20,%esp
80105105:	83 f8 10             	cmp    $0x10,%eax
80105108:	0f 85 eb 00 00 00    	jne    801051f9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010510e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105113:	0f 84 97 00 00 00    	je     801051b0 <sys_unlink+0x180>
  iunlockput(dp);
80105119:	83 ec 0c             	sub    $0xc,%esp
8010511c:	56                   	push   %esi
8010511d:	e8 ee c7 ff ff       	call   80101910 <iunlockput>
  ip->nlink--;
80105122:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105127:	89 1c 24             	mov    %ebx,(%esp)
8010512a:	e8 a1 c4 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010512f:	89 1c 24             	mov    %ebx,(%esp)
80105132:	e8 d9 c7 ff ff       	call   80101910 <iunlockput>
  end_op();
80105137:	e8 d4 da ff ff       	call   80102c10 <end_op>
  return 0;
8010513c:	83 c4 10             	add    $0x10,%esp
8010513f:	31 c0                	xor    %eax,%eax
}
80105141:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105144:	5b                   	pop    %ebx
80105145:	5e                   	pop    %esi
80105146:	5f                   	pop    %edi
80105147:	5d                   	pop    %ebp
80105148:	c3                   	ret    
80105149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105150:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105154:	76 8d                	jbe    801050e3 <sys_unlink+0xb3>
80105156:	bf 20 00 00 00       	mov    $0x20,%edi
8010515b:	eb 0f                	jmp    8010516c <sys_unlink+0x13c>
8010515d:	8d 76 00             	lea    0x0(%esi),%esi
80105160:	83 c7 10             	add    $0x10,%edi
80105163:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105166:	0f 83 77 ff ff ff    	jae    801050e3 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010516c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010516f:	6a 10                	push   $0x10
80105171:	57                   	push   %edi
80105172:	50                   	push   %eax
80105173:	53                   	push   %ebx
80105174:	e8 e7 c7 ff ff       	call   80101960 <readi>
80105179:	83 c4 10             	add    $0x10,%esp
8010517c:	83 f8 10             	cmp    $0x10,%eax
8010517f:	75 5e                	jne    801051df <sys_unlink+0x1af>
    if(de.inum != 0)
80105181:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105186:	74 d8                	je     80105160 <sys_unlink+0x130>
    iunlockput(ip);
80105188:	83 ec 0c             	sub    $0xc,%esp
8010518b:	53                   	push   %ebx
8010518c:	e8 7f c7 ff ff       	call   80101910 <iunlockput>
    goto bad;
80105191:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105194:	83 ec 0c             	sub    $0xc,%esp
80105197:	56                   	push   %esi
80105198:	e8 73 c7 ff ff       	call   80101910 <iunlockput>
  end_op();
8010519d:	e8 6e da ff ff       	call   80102c10 <end_op>
  return -1;
801051a2:	83 c4 10             	add    $0x10,%esp
801051a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051aa:	eb 95                	jmp    80105141 <sys_unlink+0x111>
801051ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801051b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801051b5:	83 ec 0c             	sub    $0xc,%esp
801051b8:	56                   	push   %esi
801051b9:	e8 12 c4 ff ff       	call   801015d0 <iupdate>
801051be:	83 c4 10             	add    $0x10,%esp
801051c1:	e9 53 ff ff ff       	jmp    80105119 <sys_unlink+0xe9>
    return -1;
801051c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051cb:	e9 71 ff ff ff       	jmp    80105141 <sys_unlink+0x111>
    end_op();
801051d0:	e8 3b da ff ff       	call   80102c10 <end_op>
    return -1;
801051d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051da:	e9 62 ff ff ff       	jmp    80105141 <sys_unlink+0x111>
      panic("isdirempty: readi");
801051df:	83 ec 0c             	sub    $0xc,%esp
801051e2:	68 a0 79 10 80       	push   $0x801079a0
801051e7:	e8 a4 b1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801051ec:	83 ec 0c             	sub    $0xc,%esp
801051ef:	68 8e 79 10 80       	push   $0x8010798e
801051f4:	e8 97 b1 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801051f9:	83 ec 0c             	sub    $0xc,%esp
801051fc:	68 b2 79 10 80       	push   $0x801079b2
80105201:	e8 8a b1 ff ff       	call   80100390 <panic>
80105206:	8d 76 00             	lea    0x0(%esi),%esi
80105209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105210 <sys_open>:

int
sys_open(void)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	57                   	push   %edi
80105214:	56                   	push   %esi
80105215:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105216:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105219:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010521c:	50                   	push   %eax
8010521d:	6a 00                	push   $0x0
8010521f:	e8 3c f8 ff ff       	call   80104a60 <argstr>
80105224:	83 c4 10             	add    $0x10,%esp
80105227:	85 c0                	test   %eax,%eax
80105229:	0f 88 1d 01 00 00    	js     8010534c <sys_open+0x13c>
8010522f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105232:	83 ec 08             	sub    $0x8,%esp
80105235:	50                   	push   %eax
80105236:	6a 01                	push   $0x1
80105238:	e8 73 f7 ff ff       	call   801049b0 <argint>
8010523d:	83 c4 10             	add    $0x10,%esp
80105240:	85 c0                	test   %eax,%eax
80105242:	0f 88 04 01 00 00    	js     8010534c <sys_open+0x13c>
    return -1;

  begin_op();
80105248:	e8 53 d9 ff ff       	call   80102ba0 <begin_op>

  if(omode & O_CREATE){
8010524d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105251:	0f 85 a9 00 00 00    	jne    80105300 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105257:	83 ec 0c             	sub    $0xc,%esp
8010525a:	ff 75 e0             	pushl  -0x20(%ebp)
8010525d:	e8 7e cc ff ff       	call   80101ee0 <namei>
80105262:	83 c4 10             	add    $0x10,%esp
80105265:	85 c0                	test   %eax,%eax
80105267:	89 c6                	mov    %eax,%esi
80105269:	0f 84 b2 00 00 00    	je     80105321 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010526f:	83 ec 0c             	sub    $0xc,%esp
80105272:	50                   	push   %eax
80105273:	e8 08 c4 ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105278:	83 c4 10             	add    $0x10,%esp
8010527b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105280:	0f 84 aa 00 00 00    	je     80105330 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105286:	e8 f5 ba ff ff       	call   80100d80 <filealloc>
8010528b:	85 c0                	test   %eax,%eax
8010528d:	89 c7                	mov    %eax,%edi
8010528f:	0f 84 a6 00 00 00    	je     8010533b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105295:	e8 46 e5 ff ff       	call   801037e0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010529a:	31 db                	xor    %ebx,%ebx
8010529c:	eb 0e                	jmp    801052ac <sys_open+0x9c>
8010529e:	66 90                	xchg   %ax,%ax
801052a0:	83 c3 01             	add    $0x1,%ebx
801052a3:	83 fb 10             	cmp    $0x10,%ebx
801052a6:	0f 84 ac 00 00 00    	je     80105358 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801052ac:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052b0:	85 d2                	test   %edx,%edx
801052b2:	75 ec                	jne    801052a0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052b4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801052b7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801052bb:	56                   	push   %esi
801052bc:	e8 9f c4 ff ff       	call   80101760 <iunlock>
  end_op();
801052c1:	e8 4a d9 ff ff       	call   80102c10 <end_op>

  f->type = FD_INODE;
801052c6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052cf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801052d2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801052d5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801052dc:	89 d0                	mov    %edx,%eax
801052de:	f7 d0                	not    %eax
801052e0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052e3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801052e6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052e9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801052ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052f0:	89 d8                	mov    %ebx,%eax
801052f2:	5b                   	pop    %ebx
801052f3:	5e                   	pop    %esi
801052f4:	5f                   	pop    %edi
801052f5:	5d                   	pop    %ebp
801052f6:	c3                   	ret    
801052f7:	89 f6                	mov    %esi,%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105306:	31 c9                	xor    %ecx,%ecx
80105308:	6a 00                	push   $0x0
8010530a:	ba 02 00 00 00       	mov    $0x2,%edx
8010530f:	e8 ec f7 ff ff       	call   80104b00 <create>
    if(ip == 0){
80105314:	83 c4 10             	add    $0x10,%esp
80105317:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105319:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010531b:	0f 85 65 ff ff ff    	jne    80105286 <sys_open+0x76>
      end_op();
80105321:	e8 ea d8 ff ff       	call   80102c10 <end_op>
      return -1;
80105326:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010532b:	eb c0                	jmp    801052ed <sys_open+0xdd>
8010532d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105330:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105333:	85 c9                	test   %ecx,%ecx
80105335:	0f 84 4b ff ff ff    	je     80105286 <sys_open+0x76>
    iunlockput(ip);
8010533b:	83 ec 0c             	sub    $0xc,%esp
8010533e:	56                   	push   %esi
8010533f:	e8 cc c5 ff ff       	call   80101910 <iunlockput>
    end_op();
80105344:	e8 c7 d8 ff ff       	call   80102c10 <end_op>
    return -1;
80105349:	83 c4 10             	add    $0x10,%esp
8010534c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105351:	eb 9a                	jmp    801052ed <sys_open+0xdd>
80105353:	90                   	nop
80105354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105358:	83 ec 0c             	sub    $0xc,%esp
8010535b:	57                   	push   %edi
8010535c:	e8 df ba ff ff       	call   80100e40 <fileclose>
80105361:	83 c4 10             	add    $0x10,%esp
80105364:	eb d5                	jmp    8010533b <sys_open+0x12b>
80105366:	8d 76 00             	lea    0x0(%esi),%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105370 <sys_mkdir>:

int
sys_mkdir(void)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105376:	e8 25 d8 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010537b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010537e:	83 ec 08             	sub    $0x8,%esp
80105381:	50                   	push   %eax
80105382:	6a 00                	push   $0x0
80105384:	e8 d7 f6 ff ff       	call   80104a60 <argstr>
80105389:	83 c4 10             	add    $0x10,%esp
8010538c:	85 c0                	test   %eax,%eax
8010538e:	78 30                	js     801053c0 <sys_mkdir+0x50>
80105390:	83 ec 0c             	sub    $0xc,%esp
80105393:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105396:	31 c9                	xor    %ecx,%ecx
80105398:	6a 00                	push   $0x0
8010539a:	ba 01 00 00 00       	mov    $0x1,%edx
8010539f:	e8 5c f7 ff ff       	call   80104b00 <create>
801053a4:	83 c4 10             	add    $0x10,%esp
801053a7:	85 c0                	test   %eax,%eax
801053a9:	74 15                	je     801053c0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053ab:	83 ec 0c             	sub    $0xc,%esp
801053ae:	50                   	push   %eax
801053af:	e8 5c c5 ff ff       	call   80101910 <iunlockput>
  end_op();
801053b4:	e8 57 d8 ff ff       	call   80102c10 <end_op>
  return 0;
801053b9:	83 c4 10             	add    $0x10,%esp
801053bc:	31 c0                	xor    %eax,%eax
}
801053be:	c9                   	leave  
801053bf:	c3                   	ret    
    end_op();
801053c0:	e8 4b d8 ff ff       	call   80102c10 <end_op>
    return -1;
801053c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053ca:	c9                   	leave  
801053cb:	c3                   	ret    
801053cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053d0 <sys_mknod>:

int
sys_mknod(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053d6:	e8 c5 d7 ff ff       	call   80102ba0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053db:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053de:	83 ec 08             	sub    $0x8,%esp
801053e1:	50                   	push   %eax
801053e2:	6a 00                	push   $0x0
801053e4:	e8 77 f6 ff ff       	call   80104a60 <argstr>
801053e9:	83 c4 10             	add    $0x10,%esp
801053ec:	85 c0                	test   %eax,%eax
801053ee:	78 60                	js     80105450 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053f0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053f3:	83 ec 08             	sub    $0x8,%esp
801053f6:	50                   	push   %eax
801053f7:	6a 01                	push   $0x1
801053f9:	e8 b2 f5 ff ff       	call   801049b0 <argint>
  if((argstr(0, &path)) < 0 ||
801053fe:	83 c4 10             	add    $0x10,%esp
80105401:	85 c0                	test   %eax,%eax
80105403:	78 4b                	js     80105450 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105405:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105408:	83 ec 08             	sub    $0x8,%esp
8010540b:	50                   	push   %eax
8010540c:	6a 02                	push   $0x2
8010540e:	e8 9d f5 ff ff       	call   801049b0 <argint>
     argint(1, &major) < 0 ||
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	78 36                	js     80105450 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010541a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010541e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105421:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105425:	ba 03 00 00 00       	mov    $0x3,%edx
8010542a:	50                   	push   %eax
8010542b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010542e:	e8 cd f6 ff ff       	call   80104b00 <create>
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	74 16                	je     80105450 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010543a:	83 ec 0c             	sub    $0xc,%esp
8010543d:	50                   	push   %eax
8010543e:	e8 cd c4 ff ff       	call   80101910 <iunlockput>
  end_op();
80105443:	e8 c8 d7 ff ff       	call   80102c10 <end_op>
  return 0;
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	31 c0                	xor    %eax,%eax
}
8010544d:	c9                   	leave  
8010544e:	c3                   	ret    
8010544f:	90                   	nop
    end_op();
80105450:	e8 bb d7 ff ff       	call   80102c10 <end_op>
    return -1;
80105455:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010545a:	c9                   	leave  
8010545b:	c3                   	ret    
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105460 <sys_chdir>:

int
sys_chdir(void)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	56                   	push   %esi
80105464:	53                   	push   %ebx
80105465:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105468:	e8 73 e3 ff ff       	call   801037e0 <myproc>
8010546d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010546f:	e8 2c d7 ff ff       	call   80102ba0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105474:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105477:	83 ec 08             	sub    $0x8,%esp
8010547a:	50                   	push   %eax
8010547b:	6a 00                	push   $0x0
8010547d:	e8 de f5 ff ff       	call   80104a60 <argstr>
80105482:	83 c4 10             	add    $0x10,%esp
80105485:	85 c0                	test   %eax,%eax
80105487:	78 77                	js     80105500 <sys_chdir+0xa0>
80105489:	83 ec 0c             	sub    $0xc,%esp
8010548c:	ff 75 f4             	pushl  -0xc(%ebp)
8010548f:	e8 4c ca ff ff       	call   80101ee0 <namei>
80105494:	83 c4 10             	add    $0x10,%esp
80105497:	85 c0                	test   %eax,%eax
80105499:	89 c3                	mov    %eax,%ebx
8010549b:	74 63                	je     80105500 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010549d:	83 ec 0c             	sub    $0xc,%esp
801054a0:	50                   	push   %eax
801054a1:	e8 da c1 ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
801054a6:	83 c4 10             	add    $0x10,%esp
801054a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054ae:	75 30                	jne    801054e0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801054b0:	83 ec 0c             	sub    $0xc,%esp
801054b3:	53                   	push   %ebx
801054b4:	e8 a7 c2 ff ff       	call   80101760 <iunlock>
  iput(curproc->cwd);
801054b9:	58                   	pop    %eax
801054ba:	ff 76 68             	pushl  0x68(%esi)
801054bd:	e8 ee c2 ff ff       	call   801017b0 <iput>
  end_op();
801054c2:	e8 49 d7 ff ff       	call   80102c10 <end_op>
  curproc->cwd = ip;
801054c7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801054ca:	83 c4 10             	add    $0x10,%esp
801054cd:	31 c0                	xor    %eax,%eax
}
801054cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054d2:	5b                   	pop    %ebx
801054d3:	5e                   	pop    %esi
801054d4:	5d                   	pop    %ebp
801054d5:	c3                   	ret    
801054d6:	8d 76 00             	lea    0x0(%esi),%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
801054e0:	83 ec 0c             	sub    $0xc,%esp
801054e3:	53                   	push   %ebx
801054e4:	e8 27 c4 ff ff       	call   80101910 <iunlockput>
    end_op();
801054e9:	e8 22 d7 ff ff       	call   80102c10 <end_op>
    return -1;
801054ee:	83 c4 10             	add    $0x10,%esp
801054f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054f6:	eb d7                	jmp    801054cf <sys_chdir+0x6f>
801054f8:	90                   	nop
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105500:	e8 0b d7 ff ff       	call   80102c10 <end_op>
    return -1;
80105505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010550a:	eb c3                	jmp    801054cf <sys_chdir+0x6f>
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_exec>:

int
sys_exec(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	57                   	push   %edi
80105514:	56                   	push   %esi
80105515:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105516:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010551c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105522:	50                   	push   %eax
80105523:	6a 00                	push   $0x0
80105525:	e8 36 f5 ff ff       	call   80104a60 <argstr>
8010552a:	83 c4 10             	add    $0x10,%esp
8010552d:	85 c0                	test   %eax,%eax
8010552f:	0f 88 87 00 00 00    	js     801055bc <sys_exec+0xac>
80105535:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010553b:	83 ec 08             	sub    $0x8,%esp
8010553e:	50                   	push   %eax
8010553f:	6a 01                	push   $0x1
80105541:	e8 6a f4 ff ff       	call   801049b0 <argint>
80105546:	83 c4 10             	add    $0x10,%esp
80105549:	85 c0                	test   %eax,%eax
8010554b:	78 6f                	js     801055bc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010554d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105553:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105556:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105558:	68 80 00 00 00       	push   $0x80
8010555d:	6a 00                	push   $0x0
8010555f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105565:	50                   	push   %eax
80105566:	e8 45 f1 ff ff       	call   801046b0 <memset>
8010556b:	83 c4 10             	add    $0x10,%esp
8010556e:	eb 2c                	jmp    8010559c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105570:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105576:	85 c0                	test   %eax,%eax
80105578:	74 56                	je     801055d0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010557a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105580:	83 ec 08             	sub    $0x8,%esp
80105583:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105586:	52                   	push   %edx
80105587:	50                   	push   %eax
80105588:	e8 b3 f3 ff ff       	call   80104940 <fetchstr>
8010558d:	83 c4 10             	add    $0x10,%esp
80105590:	85 c0                	test   %eax,%eax
80105592:	78 28                	js     801055bc <sys_exec+0xac>
  for(i=0;; i++){
80105594:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105597:	83 fb 20             	cmp    $0x20,%ebx
8010559a:	74 20                	je     801055bc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010559c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055a2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801055a9:	83 ec 08             	sub    $0x8,%esp
801055ac:	57                   	push   %edi
801055ad:	01 f0                	add    %esi,%eax
801055af:	50                   	push   %eax
801055b0:	e8 4b f3 ff ff       	call   80104900 <fetchint>
801055b5:	83 c4 10             	add    $0x10,%esp
801055b8:	85 c0                	test   %eax,%eax
801055ba:	79 b4                	jns    80105570 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801055bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801055bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055c4:	5b                   	pop    %ebx
801055c5:	5e                   	pop    %esi
801055c6:	5f                   	pop    %edi
801055c7:	5d                   	pop    %ebp
801055c8:	c3                   	ret    
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801055d0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055d6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801055d9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055e0:	00 00 00 00 
  return exec(path, argv);
801055e4:	50                   	push   %eax
801055e5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801055eb:	e8 20 b4 ff ff       	call   80100a10 <exec>
801055f0:	83 c4 10             	add    $0x10,%esp
}
801055f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f6:	5b                   	pop    %ebx
801055f7:	5e                   	pop    %esi
801055f8:	5f                   	pop    %edi
801055f9:	5d                   	pop    %ebp
801055fa:	c3                   	ret    
801055fb:	90                   	nop
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_pipe>:

int
sys_pipe(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	57                   	push   %edi
80105604:	56                   	push   %esi
80105605:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105606:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105609:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010560c:	6a 08                	push   $0x8
8010560e:	50                   	push   %eax
8010560f:	6a 00                	push   $0x0
80105611:	e8 ea f3 ff ff       	call   80104a00 <argptr>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	85 c0                	test   %eax,%eax
8010561b:	0f 88 ae 00 00 00    	js     801056cf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105621:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105624:	83 ec 08             	sub    $0x8,%esp
80105627:	50                   	push   %eax
80105628:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010562b:	50                   	push   %eax
8010562c:	e8 0f dc ff ff       	call   80103240 <pipealloc>
80105631:	83 c4 10             	add    $0x10,%esp
80105634:	85 c0                	test   %eax,%eax
80105636:	0f 88 93 00 00 00    	js     801056cf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010563c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010563f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105641:	e8 9a e1 ff ff       	call   801037e0 <myproc>
80105646:	eb 10                	jmp    80105658 <sys_pipe+0x58>
80105648:	90                   	nop
80105649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105650:	83 c3 01             	add    $0x1,%ebx
80105653:	83 fb 10             	cmp    $0x10,%ebx
80105656:	74 60                	je     801056b8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105658:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010565c:	85 f6                	test   %esi,%esi
8010565e:	75 f0                	jne    80105650 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105660:	8d 73 08             	lea    0x8(%ebx),%esi
80105663:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105667:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010566a:	e8 71 e1 ff ff       	call   801037e0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010566f:	31 d2                	xor    %edx,%edx
80105671:	eb 0d                	jmp    80105680 <sys_pipe+0x80>
80105673:	90                   	nop
80105674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105678:	83 c2 01             	add    $0x1,%edx
8010567b:	83 fa 10             	cmp    $0x10,%edx
8010567e:	74 28                	je     801056a8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105680:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105684:	85 c9                	test   %ecx,%ecx
80105686:	75 f0                	jne    80105678 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105688:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010568c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010568f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105691:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105694:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105697:	31 c0                	xor    %eax,%eax
}
80105699:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010569c:	5b                   	pop    %ebx
8010569d:	5e                   	pop    %esi
8010569e:	5f                   	pop    %edi
8010569f:	5d                   	pop    %ebp
801056a0:	c3                   	ret    
801056a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801056a8:	e8 33 e1 ff ff       	call   801037e0 <myproc>
801056ad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056b4:	00 
801056b5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801056b8:	83 ec 0c             	sub    $0xc,%esp
801056bb:	ff 75 e0             	pushl  -0x20(%ebp)
801056be:	e8 7d b7 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
801056c3:	58                   	pop    %eax
801056c4:	ff 75 e4             	pushl  -0x1c(%ebp)
801056c7:	e8 74 b7 ff ff       	call   80100e40 <fileclose>
    return -1;
801056cc:	83 c4 10             	add    $0x10,%esp
801056cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d4:	eb c3                	jmp    80105699 <sys_pipe+0x99>
801056d6:	66 90                	xchg   %ax,%ax
801056d8:	66 90                	xchg   %ax,%ax
801056da:	66 90                	xchg   %ax,%ax
801056dc:	66 90                	xchg   %ax,%ax
801056de:	66 90                	xchg   %ax,%ax

801056e0 <sys_fork>:
#include "proc.h"
#include "spinlock.h"

int
sys_fork(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801056e3:	5d                   	pop    %ebp
  return fork();
801056e4:	e9 97 e2 ff ff       	jmp    80103980 <fork>
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056f0 <sys_exit>:

int
sys_exit(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801056f6:	e8 05 e5 ff ff       	call   80103c00 <exit>
  return 0;  // not reached
}
801056fb:	31 c0                	xor    %eax,%eax
801056fd:	c9                   	leave  
801056fe:	c3                   	ret    
801056ff:	90                   	nop

80105700 <sys_wait>:

int
sys_wait(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105703:	5d                   	pop    %ebp
  return wait();
80105704:	e9 37 e7 ff ff       	jmp    80103e40 <wait>
80105709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105710 <sys_kill>:

int
sys_kill(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105716:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105719:	50                   	push   %eax
8010571a:	6a 00                	push   $0x0
8010571c:	e8 8f f2 ff ff       	call   801049b0 <argint>
80105721:	83 c4 10             	add    $0x10,%esp
80105724:	85 c0                	test   %eax,%eax
80105726:	78 18                	js     80105740 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105728:	83 ec 0c             	sub    $0xc,%esp
8010572b:	ff 75 f4             	pushl  -0xc(%ebp)
8010572e:	e8 5d e8 ff ff       	call   80103f90 <kill>
80105733:	83 c4 10             	add    $0x10,%esp
}
80105736:	c9                   	leave  
80105737:	c3                   	ret    
80105738:	90                   	nop
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105740:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105745:	c9                   	leave  
80105746:	c3                   	ret    
80105747:	89 f6                	mov    %esi,%esi
80105749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105750 <sys_getpid>:

int
sys_getpid(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105756:	e8 85 e0 ff ff       	call   801037e0 <myproc>
8010575b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010575e:	c9                   	leave  
8010575f:	c3                   	ret    

80105760 <sys_sbrk>:

int
sys_sbrk(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105764:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105767:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010576a:	50                   	push   %eax
8010576b:	6a 00                	push   $0x0
8010576d:	e8 3e f2 ff ff       	call   801049b0 <argint>
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	85 c0                	test   %eax,%eax
80105777:	78 27                	js     801057a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105779:	e8 62 e0 ff ff       	call   801037e0 <myproc>
  if(growproc(n) < 0)
8010577e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105781:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105783:	ff 75 f4             	pushl  -0xc(%ebp)
80105786:	e8 75 e1 ff ff       	call   80103900 <growproc>
8010578b:	83 c4 10             	add    $0x10,%esp
8010578e:	85 c0                	test   %eax,%eax
80105790:	78 0e                	js     801057a0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105792:	89 d8                	mov    %ebx,%eax
80105794:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105797:	c9                   	leave  
80105798:	c3                   	ret    
80105799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801057a5:	eb eb                	jmp    80105792 <sys_sbrk+0x32>
801057a7:	89 f6                	mov    %esi,%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057b0 <sys_sleep>:

int
sys_sleep(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801057b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057ba:	50                   	push   %eax
801057bb:	6a 00                	push   $0x0
801057bd:	e8 ee f1 ff ff       	call   801049b0 <argint>
801057c2:	83 c4 10             	add    $0x10,%esp
801057c5:	85 c0                	test   %eax,%eax
801057c7:	0f 88 8a 00 00 00    	js     80105857 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801057cd:	83 ec 0c             	sub    $0xc,%esp
801057d0:	68 80 4c 11 80       	push   $0x80114c80
801057d5:	e8 96 ec ff ff       	call   80104470 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801057da:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057dd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801057e0:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
  while(ticks - ticks0 < n){
801057e6:	85 d2                	test   %edx,%edx
801057e8:	75 27                	jne    80105811 <sys_sleep+0x61>
801057ea:	eb 54                	jmp    80105840 <sys_sleep+0x90>
801057ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801057f0:	83 ec 08             	sub    $0x8,%esp
801057f3:	68 80 4c 11 80       	push   $0x80114c80
801057f8:	68 c0 54 11 80       	push   $0x801154c0
801057fd:	e8 7e e5 ff ff       	call   80103d80 <sleep>
  while(ticks - ticks0 < n){
80105802:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80105807:	83 c4 10             	add    $0x10,%esp
8010580a:	29 d8                	sub    %ebx,%eax
8010580c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010580f:	73 2f                	jae    80105840 <sys_sleep+0x90>
    if(myproc()->killed){
80105811:	e8 ca df ff ff       	call   801037e0 <myproc>
80105816:	8b 40 24             	mov    0x24(%eax),%eax
80105819:	85 c0                	test   %eax,%eax
8010581b:	74 d3                	je     801057f0 <sys_sleep+0x40>
      release(&tickslock);
8010581d:	83 ec 0c             	sub    $0xc,%esp
80105820:	68 80 4c 11 80       	push   $0x80114c80
80105825:	e8 d6 ed ff ff       	call   80104600 <release>
      return -1;
8010582a:	83 c4 10             	add    $0x10,%esp
8010582d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105832:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105835:	c9                   	leave  
80105836:	c3                   	ret    
80105837:	89 f6                	mov    %esi,%esi
80105839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105840:	83 ec 0c             	sub    $0xc,%esp
80105843:	68 80 4c 11 80       	push   $0x80114c80
80105848:	e8 b3 ed ff ff       	call   80104600 <release>
  return 0;
8010584d:	83 c4 10             	add    $0x10,%esp
80105850:	31 c0                	xor    %eax,%eax
}
80105852:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105855:	c9                   	leave  
80105856:	c3                   	ret    
    return -1;
80105857:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585c:	eb f4                	jmp    80105852 <sys_sleep+0xa2>
8010585e:	66 90                	xchg   %ax,%ax

80105860 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	53                   	push   %ebx
80105864:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105867:	68 80 4c 11 80       	push   $0x80114c80
8010586c:	e8 ff eb ff ff       	call   80104470 <acquire>
  xticks = ticks;
80105871:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
  release(&tickslock);
80105877:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
8010587e:	e8 7d ed ff ff       	call   80104600 <release>
  return xticks;
}
80105883:	89 d8                	mov    %ebx,%eax
80105885:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105888:	c9                   	leave  
80105889:	c3                   	ret    
8010588a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105890 <sys_acquireTest>:

int 
sys_acquireTest(void) {
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	53                   	push   %ebx
  struct spinLockReentrant lk;
  initReentrantSpinlock(&lk, "splinlock");
80105894:	8d 5d c0             	lea    -0x40(%ebp),%ebx
sys_acquireTest(void) {
80105897:	83 ec 4c             	sub    $0x4c,%esp
  initReentrantSpinlock(&lk, "splinlock");
8010589a:	68 c1 79 10 80       	push   $0x801079c1
8010589f:	53                   	push   %ebx
801058a0:	e8 7b ea ff ff       	call   80104320 <initReentrantSpinlock>
  acquireReentrant(&lk);
801058a5:	89 1c 24             	mov    %ebx,(%esp)
801058a8:	e8 83 ec ff ff       	call   80104530 <acquireReentrant>
  acquireReentrant(&lk);
801058ad:	89 1c 24             	mov    %ebx,(%esp)
801058b0:	e8 7b ec ff ff       	call   80104530 <acquireReentrant>
  releaseReentrant(&lk);
801058b5:	89 1c 24             	mov    %ebx,(%esp)
801058b8:	e8 93 ed ff ff       	call   80104650 <releaseReentrant>
  return 0;
}
801058bd:	31 c0                	xor    %eax,%eax
801058bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058c2:	c9                   	leave  
801058c3:	c3                   	ret    
801058c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801058d0 <wakeup_all_processes>:

int waiting_process_pids[PROCESS_NUMBER];
int ind = 0;

int wakeup_all_processes()
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	83 ec 14             	sub    $0x14,%esp
  for (int i = 0; i<PROCESS_NUMBER; i++)
    wakeup_process(waiting_process_pids[i]);
801058d6:	ff 35 74 4c 11 80    	pushl  0x80114c74
801058dc:	e8 6f e8 ff ff       	call   80104150 <wakeup_process>
801058e1:	58                   	pop    %eax
801058e2:	ff 35 78 4c 11 80    	pushl  0x80114c78
801058e8:	e8 63 e8 ff ff       	call   80104150 <wakeup_process>
  return 0;
}
801058ed:	31 c0                	xor    %eax,%eax
801058ef:	c9                   	leave  
801058f0:	c3                   	ret    
801058f1:	eb 0d                	jmp    80105900 <sys_barrier>
801058f3:	90                   	nop
801058f4:	90                   	nop
801058f5:	90                   	nop
801058f6:	90                   	nop
801058f7:	90                   	nop
801058f8:	90                   	nop
801058f9:	90                   	nop
801058fa:	90                   	nop
801058fb:	90                   	nop
801058fc:	90                   	nop
801058fd:	90                   	nop
801058fe:	90                   	nop
801058ff:	90                   	nop

80105900 <sys_barrier>:


int
sys_barrier(void) {
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	83 ec 08             	sub    $0x8,%esp
  waiting_process_pids[ind] = myproc()->pid;
80105906:	e8 d5 de ff ff       	call   801037e0 <myproc>
8010590b:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105911:	8b 40 10             	mov    0x10(%eax),%eax
80105914:	89 04 95 74 4c 11 80 	mov    %eax,-0x7feeb38c(,%edx,4)
  ind++;
8010591b:	83 c2 01             	add    $0x1,%edx
8010591e:	89 15 bc a5 10 80    	mov    %edx,0x8010a5bc
  sleep_process(myproc()->pid);
80105924:	e8 b7 de ff ff       	call   801037e0 <myproc>
80105929:	83 ec 0c             	sub    $0xc,%esp
8010592c:	ff 70 10             	pushl  0x10(%eax)
8010592f:	e8 9c e7 ff ff       	call   801040d0 <sleep_process>
  cprintf("%d\n", myproc()->pid);
80105934:	e8 a7 de ff ff       	call   801037e0 <myproc>
80105939:	5a                   	pop    %edx
8010593a:	59                   	pop    %ecx
8010593b:	ff 70 10             	pushl  0x10(%eax)
8010593e:	68 14 77 10 80       	push   $0x80107714
80105943:	e8 18 ad ff ff       	call   80100660 <cprintf>
  if (ind == PROCESS_NUMBER)
80105948:	83 c4 10             	add    $0x10,%esp
8010594b:	83 3d bc a5 10 80 02 	cmpl   $0x2,0x8010a5bc
80105952:	75 27                	jne    8010597b <sys_barrier+0x7b>
    wakeup_process(waiting_process_pids[i]);
80105954:	83 ec 0c             	sub    $0xc,%esp
80105957:	ff 35 74 4c 11 80    	pushl  0x80114c74
8010595d:	e8 ee e7 ff ff       	call   80104150 <wakeup_process>
80105962:	58                   	pop    %eax
80105963:	ff 35 78 4c 11 80    	pushl  0x80114c78
80105969:	e8 e2 e7 ff ff       	call   80104150 <wakeup_process>
  {
    wakeup_all_processes();
    ind = 0;
8010596e:	c7 05 bc a5 10 80 00 	movl   $0x0,0x8010a5bc
80105975:	00 00 00 
80105978:	83 c4 10             	add    $0x10,%esp
  }
  return 0;
8010597b:	31 c0                	xor    %eax,%eax
8010597d:	c9                   	leave  
8010597e:	c3                   	ret    

8010597f <alltraps>:
8010597f:	1e                   	push   %ds
80105980:	06                   	push   %es
80105981:	0f a0                	push   %fs
80105983:	0f a8                	push   %gs
80105985:	60                   	pusha  
80105986:	66 b8 10 00          	mov    $0x10,%ax
8010598a:	8e d8                	mov    %eax,%ds
8010598c:	8e c0                	mov    %eax,%es
8010598e:	54                   	push   %esp
8010598f:	e8 cc 00 00 00       	call   80105a60 <trap>
80105994:	83 c4 04             	add    $0x4,%esp

80105997 <trapret>:
80105997:	61                   	popa   
80105998:	0f a9                	pop    %gs
8010599a:	0f a1                	pop    %fs
8010599c:	07                   	pop    %es
8010599d:	1f                   	pop    %ds
8010599e:	83 c4 08             	add    $0x8,%esp
801059a1:	cf                   	iret   
801059a2:	66 90                	xchg   %ax,%ax
801059a4:	66 90                	xchg   %ax,%ax
801059a6:	66 90                	xchg   %ax,%ax
801059a8:	66 90                	xchg   %ax,%ax
801059aa:	66 90                	xchg   %ax,%ax
801059ac:	66 90                	xchg   %ax,%ax
801059ae:	66 90                	xchg   %ax,%ax

801059b0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801059b0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801059b1:	31 c0                	xor    %eax,%eax
{
801059b3:	89 e5                	mov    %esp,%ebp
801059b5:	83 ec 08             	sub    $0x8,%esp
801059b8:	90                   	nop
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801059c0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801059c7:	c7 04 c5 c2 4c 11 80 	movl   $0x8e000008,-0x7feeb33e(,%eax,8)
801059ce:	08 00 00 8e 
801059d2:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
801059d9:	80 
801059da:	c1 ea 10             	shr    $0x10,%edx
801059dd:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
801059e4:	80 
  for(i = 0; i < 256; i++)
801059e5:	83 c0 01             	add    $0x1,%eax
801059e8:	3d 00 01 00 00       	cmp    $0x100,%eax
801059ed:	75 d1                	jne    801059c0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059ef:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801059f4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059f7:	c7 05 c2 4e 11 80 08 	movl   $0xef000008,0x80114ec2
801059fe:	00 00 ef 
  initlock(&tickslock, "time");
80105a01:	68 cb 79 10 80       	push   $0x801079cb
80105a06:	68 80 4c 11 80       	push   $0x80114c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a0b:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
80105a11:	c1 e8 10             	shr    $0x10,%eax
80105a14:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6
  initlock(&tickslock, "time");
80105a1a:	e8 e1 e8 ff ff       	call   80104300 <initlock>
}
80105a1f:	83 c4 10             	add    $0x10,%esp
80105a22:	c9                   	leave  
80105a23:	c3                   	ret    
80105a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105a30 <idtinit>:

void
idtinit(void)
{
80105a30:	55                   	push   %ebp
  pd[0] = size-1;
80105a31:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a36:	89 e5                	mov    %esp,%ebp
80105a38:	83 ec 10             	sub    $0x10,%esp
80105a3b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a3f:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
80105a44:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a48:	c1 e8 10             	shr    $0x10,%eax
80105a4b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105a4f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a52:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a55:	c9                   	leave  
80105a56:	c3                   	ret    
80105a57:	89 f6                	mov    %esi,%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a60 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	57                   	push   %edi
80105a64:	56                   	push   %esi
80105a65:	53                   	push   %ebx
80105a66:	83 ec 1c             	sub    $0x1c,%esp
80105a69:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a6c:	8b 47 30             	mov    0x30(%edi),%eax
80105a6f:	83 f8 40             	cmp    $0x40,%eax
80105a72:	0f 84 f0 00 00 00    	je     80105b68 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a78:	83 e8 20             	sub    $0x20,%eax
80105a7b:	83 f8 1f             	cmp    $0x1f,%eax
80105a7e:	77 10                	ja     80105a90 <trap+0x30>
80105a80:	ff 24 85 74 7a 10 80 	jmp    *-0x7fef858c(,%eax,4)
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a90:	e8 4b dd ff ff       	call   801037e0 <myproc>
80105a95:	85 c0                	test   %eax,%eax
80105a97:	8b 5f 38             	mov    0x38(%edi),%ebx
80105a9a:	0f 84 14 02 00 00    	je     80105cb4 <trap+0x254>
80105aa0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105aa4:	0f 84 0a 02 00 00    	je     80105cb4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105aaa:	0f 20 d1             	mov    %cr2,%ecx
80105aad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ab0:	e8 0b dd ff ff       	call   801037c0 <cpuid>
80105ab5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105ab8:	8b 47 34             	mov    0x34(%edi),%eax
80105abb:	8b 77 30             	mov    0x30(%edi),%esi
80105abe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105ac1:	e8 1a dd ff ff       	call   801037e0 <myproc>
80105ac6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ac9:	e8 12 dd ff ff       	call   801037e0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ace:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ad1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ad4:	51                   	push   %ecx
80105ad5:	53                   	push   %ebx
80105ad6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105ad7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ada:	ff 75 e4             	pushl  -0x1c(%ebp)
80105add:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105ade:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ae1:	52                   	push   %edx
80105ae2:	ff 70 10             	pushl  0x10(%eax)
80105ae5:	68 30 7a 10 80       	push   $0x80107a30
80105aea:	e8 71 ab ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105aef:	83 c4 20             	add    $0x20,%esp
80105af2:	e8 e9 dc ff ff       	call   801037e0 <myproc>
80105af7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105afe:	e8 dd dc ff ff       	call   801037e0 <myproc>
80105b03:	85 c0                	test   %eax,%eax
80105b05:	74 1d                	je     80105b24 <trap+0xc4>
80105b07:	e8 d4 dc ff ff       	call   801037e0 <myproc>
80105b0c:	8b 50 24             	mov    0x24(%eax),%edx
80105b0f:	85 d2                	test   %edx,%edx
80105b11:	74 11                	je     80105b24 <trap+0xc4>
80105b13:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b17:	83 e0 03             	and    $0x3,%eax
80105b1a:	66 83 f8 03          	cmp    $0x3,%ax
80105b1e:	0f 84 4c 01 00 00    	je     80105c70 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b24:	e8 b7 dc ff ff       	call   801037e0 <myproc>
80105b29:	85 c0                	test   %eax,%eax
80105b2b:	74 0b                	je     80105b38 <trap+0xd8>
80105b2d:	e8 ae dc ff ff       	call   801037e0 <myproc>
80105b32:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b36:	74 68                	je     80105ba0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b38:	e8 a3 dc ff ff       	call   801037e0 <myproc>
80105b3d:	85 c0                	test   %eax,%eax
80105b3f:	74 19                	je     80105b5a <trap+0xfa>
80105b41:	e8 9a dc ff ff       	call   801037e0 <myproc>
80105b46:	8b 40 24             	mov    0x24(%eax),%eax
80105b49:	85 c0                	test   %eax,%eax
80105b4b:	74 0d                	je     80105b5a <trap+0xfa>
80105b4d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b51:	83 e0 03             	and    $0x3,%eax
80105b54:	66 83 f8 03          	cmp    $0x3,%ax
80105b58:	74 37                	je     80105b91 <trap+0x131>
    exit();
}
80105b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b5d:	5b                   	pop    %ebx
80105b5e:	5e                   	pop    %esi
80105b5f:	5f                   	pop    %edi
80105b60:	5d                   	pop    %ebp
80105b61:	c3                   	ret    
80105b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105b68:	e8 73 dc ff ff       	call   801037e0 <myproc>
80105b6d:	8b 58 24             	mov    0x24(%eax),%ebx
80105b70:	85 db                	test   %ebx,%ebx
80105b72:	0f 85 e8 00 00 00    	jne    80105c60 <trap+0x200>
    myproc()->tf = tf;
80105b78:	e8 63 dc ff ff       	call   801037e0 <myproc>
80105b7d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105b80:	e8 1b ef ff ff       	call   80104aa0 <syscall>
    if(myproc()->killed)
80105b85:	e8 56 dc ff ff       	call   801037e0 <myproc>
80105b8a:	8b 48 24             	mov    0x24(%eax),%ecx
80105b8d:	85 c9                	test   %ecx,%ecx
80105b8f:	74 c9                	je     80105b5a <trap+0xfa>
}
80105b91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b94:	5b                   	pop    %ebx
80105b95:	5e                   	pop    %esi
80105b96:	5f                   	pop    %edi
80105b97:	5d                   	pop    %ebp
      exit();
80105b98:	e9 63 e0 ff ff       	jmp    80103c00 <exit>
80105b9d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ba0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105ba4:	75 92                	jne    80105b38 <trap+0xd8>
    yield();
80105ba6:	e8 85 e1 ff ff       	call   80103d30 <yield>
80105bab:	eb 8b                	jmp    80105b38 <trap+0xd8>
80105bad:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105bb0:	e8 0b dc ff ff       	call   801037c0 <cpuid>
80105bb5:	85 c0                	test   %eax,%eax
80105bb7:	0f 84 c3 00 00 00    	je     80105c80 <trap+0x220>
    lapiceoi();
80105bbd:	e8 8e cb ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bc2:	e8 19 dc ff ff       	call   801037e0 <myproc>
80105bc7:	85 c0                	test   %eax,%eax
80105bc9:	0f 85 38 ff ff ff    	jne    80105b07 <trap+0xa7>
80105bcf:	e9 50 ff ff ff       	jmp    80105b24 <trap+0xc4>
80105bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105bd8:	e8 33 ca ff ff       	call   80102610 <kbdintr>
    lapiceoi();
80105bdd:	e8 6e cb ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105be2:	e8 f9 db ff ff       	call   801037e0 <myproc>
80105be7:	85 c0                	test   %eax,%eax
80105be9:	0f 85 18 ff ff ff    	jne    80105b07 <trap+0xa7>
80105bef:	e9 30 ff ff ff       	jmp    80105b24 <trap+0xc4>
80105bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105bf8:	e8 53 02 00 00       	call   80105e50 <uartintr>
    lapiceoi();
80105bfd:	e8 4e cb ff ff       	call   80102750 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c02:	e8 d9 db ff ff       	call   801037e0 <myproc>
80105c07:	85 c0                	test   %eax,%eax
80105c09:	0f 85 f8 fe ff ff    	jne    80105b07 <trap+0xa7>
80105c0f:	e9 10 ff ff ff       	jmp    80105b24 <trap+0xc4>
80105c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c18:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105c1c:	8b 77 38             	mov    0x38(%edi),%esi
80105c1f:	e8 9c db ff ff       	call   801037c0 <cpuid>
80105c24:	56                   	push   %esi
80105c25:	53                   	push   %ebx
80105c26:	50                   	push   %eax
80105c27:	68 d8 79 10 80       	push   $0x801079d8
80105c2c:	e8 2f aa ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105c31:	e8 1a cb ff ff       	call   80102750 <lapiceoi>
    break;
80105c36:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c39:	e8 a2 db ff ff       	call   801037e0 <myproc>
80105c3e:	85 c0                	test   %eax,%eax
80105c40:	0f 85 c1 fe ff ff    	jne    80105b07 <trap+0xa7>
80105c46:	e9 d9 fe ff ff       	jmp    80105b24 <trap+0xc4>
80105c4b:	90                   	nop
80105c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105c50:	e8 2b c4 ff ff       	call   80102080 <ideintr>
80105c55:	e9 63 ff ff ff       	jmp    80105bbd <trap+0x15d>
80105c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c60:	e8 9b df ff ff       	call   80103c00 <exit>
80105c65:	e9 0e ff ff ff       	jmp    80105b78 <trap+0x118>
80105c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105c70:	e8 8b df ff ff       	call   80103c00 <exit>
80105c75:	e9 aa fe ff ff       	jmp    80105b24 <trap+0xc4>
80105c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	68 80 4c 11 80       	push   $0x80114c80
80105c88:	e8 e3 e7 ff ff       	call   80104470 <acquire>
      wakeup(&ticks);
80105c8d:	c7 04 24 c0 54 11 80 	movl   $0x801154c0,(%esp)
      ticks++;
80105c94:	83 05 c0 54 11 80 01 	addl   $0x1,0x801154c0
      wakeup(&ticks);
80105c9b:	e8 90 e2 ff ff       	call   80103f30 <wakeup>
      release(&tickslock);
80105ca0:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105ca7:	e8 54 e9 ff ff       	call   80104600 <release>
80105cac:	83 c4 10             	add    $0x10,%esp
80105caf:	e9 09 ff ff ff       	jmp    80105bbd <trap+0x15d>
80105cb4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105cb7:	e8 04 db ff ff       	call   801037c0 <cpuid>
80105cbc:	83 ec 0c             	sub    $0xc,%esp
80105cbf:	56                   	push   %esi
80105cc0:	53                   	push   %ebx
80105cc1:	50                   	push   %eax
80105cc2:	ff 77 30             	pushl  0x30(%edi)
80105cc5:	68 fc 79 10 80       	push   $0x801079fc
80105cca:	e8 91 a9 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105ccf:	83 c4 14             	add    $0x14,%esp
80105cd2:	68 d0 79 10 80       	push   $0x801079d0
80105cd7:	e8 b4 a6 ff ff       	call   80100390 <panic>
80105cdc:	66 90                	xchg   %ax,%ax
80105cde:	66 90                	xchg   %ax,%ax

80105ce0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ce0:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
{
80105ce5:	55                   	push   %ebp
80105ce6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ce8:	85 c0                	test   %eax,%eax
80105cea:	74 1c                	je     80105d08 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cec:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cf1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cf2:	a8 01                	test   $0x1,%al
80105cf4:	74 12                	je     80105d08 <uartgetc+0x28>
80105cf6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cfb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105cfc:	0f b6 c0             	movzbl %al,%eax
}
80105cff:	5d                   	pop    %ebp
80105d00:	c3                   	ret    
80105d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d0d:	5d                   	pop    %ebp
80105d0e:	c3                   	ret    
80105d0f:	90                   	nop

80105d10 <uartputc.part.0>:
uartputc(int c)
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
80105d15:	53                   	push   %ebx
80105d16:	89 c7                	mov    %eax,%edi
80105d18:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d1d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d22:	83 ec 0c             	sub    $0xc,%esp
80105d25:	eb 1b                	jmp    80105d42 <uartputc.part.0+0x32>
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105d30:	83 ec 0c             	sub    $0xc,%esp
80105d33:	6a 0a                	push   $0xa
80105d35:	e8 36 ca ff ff       	call   80102770 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d3a:	83 c4 10             	add    $0x10,%esp
80105d3d:	83 eb 01             	sub    $0x1,%ebx
80105d40:	74 07                	je     80105d49 <uartputc.part.0+0x39>
80105d42:	89 f2                	mov    %esi,%edx
80105d44:	ec                   	in     (%dx),%al
80105d45:	a8 20                	test   $0x20,%al
80105d47:	74 e7                	je     80105d30 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d49:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d4e:	89 f8                	mov    %edi,%eax
80105d50:	ee                   	out    %al,(%dx)
}
80105d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d54:	5b                   	pop    %ebx
80105d55:	5e                   	pop    %esi
80105d56:	5f                   	pop    %edi
80105d57:	5d                   	pop    %ebp
80105d58:	c3                   	ret    
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d60 <uartinit>:
{
80105d60:	55                   	push   %ebp
80105d61:	31 c9                	xor    %ecx,%ecx
80105d63:	89 c8                	mov    %ecx,%eax
80105d65:	89 e5                	mov    %esp,%ebp
80105d67:	57                   	push   %edi
80105d68:	56                   	push   %esi
80105d69:	53                   	push   %ebx
80105d6a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d6f:	89 da                	mov    %ebx,%edx
80105d71:	83 ec 0c             	sub    $0xc,%esp
80105d74:	ee                   	out    %al,(%dx)
80105d75:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d7a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d7f:	89 fa                	mov    %edi,%edx
80105d81:	ee                   	out    %al,(%dx)
80105d82:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d87:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d8c:	ee                   	out    %al,(%dx)
80105d8d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d92:	89 c8                	mov    %ecx,%eax
80105d94:	89 f2                	mov    %esi,%edx
80105d96:	ee                   	out    %al,(%dx)
80105d97:	b8 03 00 00 00       	mov    $0x3,%eax
80105d9c:	89 fa                	mov    %edi,%edx
80105d9e:	ee                   	out    %al,(%dx)
80105d9f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105da4:	89 c8                	mov    %ecx,%eax
80105da6:	ee                   	out    %al,(%dx)
80105da7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dac:	89 f2                	mov    %esi,%edx
80105dae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105daf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105db4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105db5:	3c ff                	cmp    $0xff,%al
80105db7:	74 5a                	je     80105e13 <uartinit+0xb3>
  uart = 1;
80105db9:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105dc0:	00 00 00 
80105dc3:	89 da                	mov    %ebx,%edx
80105dc5:	ec                   	in     (%dx),%al
80105dc6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dcb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105dcc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105dcf:	bb f4 7a 10 80       	mov    $0x80107af4,%ebx
  ioapicenable(IRQ_COM1, 0);
80105dd4:	6a 00                	push   $0x0
80105dd6:	6a 04                	push   $0x4
80105dd8:	e8 f3 c4 ff ff       	call   801022d0 <ioapicenable>
80105ddd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105de0:	b8 78 00 00 00       	mov    $0x78,%eax
80105de5:	eb 13                	jmp    80105dfa <uartinit+0x9a>
80105de7:	89 f6                	mov    %esi,%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105df0:	83 c3 01             	add    $0x1,%ebx
80105df3:	0f be 03             	movsbl (%ebx),%eax
80105df6:	84 c0                	test   %al,%al
80105df8:	74 19                	je     80105e13 <uartinit+0xb3>
  if(!uart)
80105dfa:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105e00:	85 d2                	test   %edx,%edx
80105e02:	74 ec                	je     80105df0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105e04:	83 c3 01             	add    $0x1,%ebx
80105e07:	e8 04 ff ff ff       	call   80105d10 <uartputc.part.0>
80105e0c:	0f be 03             	movsbl (%ebx),%eax
80105e0f:	84 c0                	test   %al,%al
80105e11:	75 e7                	jne    80105dfa <uartinit+0x9a>
}
80105e13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e16:	5b                   	pop    %ebx
80105e17:	5e                   	pop    %esi
80105e18:	5f                   	pop    %edi
80105e19:	5d                   	pop    %ebp
80105e1a:	c3                   	ret    
80105e1b:	90                   	nop
80105e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e20 <uartputc>:
  if(!uart)
80105e20:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
{
80105e26:	55                   	push   %ebp
80105e27:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105e29:	85 d2                	test   %edx,%edx
{
80105e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105e2e:	74 10                	je     80105e40 <uartputc+0x20>
}
80105e30:	5d                   	pop    %ebp
80105e31:	e9 da fe ff ff       	jmp    80105d10 <uartputc.part.0>
80105e36:	8d 76 00             	lea    0x0(%esi),%esi
80105e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e40:	5d                   	pop    %ebp
80105e41:	c3                   	ret    
80105e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e50 <uartintr>:

void
uartintr(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e56:	68 e0 5c 10 80       	push   $0x80105ce0
80105e5b:	e8 b0 a9 ff ff       	call   80100810 <consoleintr>
}
80105e60:	83 c4 10             	add    $0x10,%esp
80105e63:	c9                   	leave  
80105e64:	c3                   	ret    

80105e65 <vector0>:
80105e65:	6a 00                	push   $0x0
80105e67:	6a 00                	push   $0x0
80105e69:	e9 11 fb ff ff       	jmp    8010597f <alltraps>

80105e6e <vector1>:
80105e6e:	6a 00                	push   $0x0
80105e70:	6a 01                	push   $0x1
80105e72:	e9 08 fb ff ff       	jmp    8010597f <alltraps>

80105e77 <vector2>:
80105e77:	6a 00                	push   $0x0
80105e79:	6a 02                	push   $0x2
80105e7b:	e9 ff fa ff ff       	jmp    8010597f <alltraps>

80105e80 <vector3>:
80105e80:	6a 00                	push   $0x0
80105e82:	6a 03                	push   $0x3
80105e84:	e9 f6 fa ff ff       	jmp    8010597f <alltraps>

80105e89 <vector4>:
80105e89:	6a 00                	push   $0x0
80105e8b:	6a 04                	push   $0x4
80105e8d:	e9 ed fa ff ff       	jmp    8010597f <alltraps>

80105e92 <vector5>:
80105e92:	6a 00                	push   $0x0
80105e94:	6a 05                	push   $0x5
80105e96:	e9 e4 fa ff ff       	jmp    8010597f <alltraps>

80105e9b <vector6>:
80105e9b:	6a 00                	push   $0x0
80105e9d:	6a 06                	push   $0x6
80105e9f:	e9 db fa ff ff       	jmp    8010597f <alltraps>

80105ea4 <vector7>:
80105ea4:	6a 00                	push   $0x0
80105ea6:	6a 07                	push   $0x7
80105ea8:	e9 d2 fa ff ff       	jmp    8010597f <alltraps>

80105ead <vector8>:
80105ead:	6a 08                	push   $0x8
80105eaf:	e9 cb fa ff ff       	jmp    8010597f <alltraps>

80105eb4 <vector9>:
80105eb4:	6a 00                	push   $0x0
80105eb6:	6a 09                	push   $0x9
80105eb8:	e9 c2 fa ff ff       	jmp    8010597f <alltraps>

80105ebd <vector10>:
80105ebd:	6a 0a                	push   $0xa
80105ebf:	e9 bb fa ff ff       	jmp    8010597f <alltraps>

80105ec4 <vector11>:
80105ec4:	6a 0b                	push   $0xb
80105ec6:	e9 b4 fa ff ff       	jmp    8010597f <alltraps>

80105ecb <vector12>:
80105ecb:	6a 0c                	push   $0xc
80105ecd:	e9 ad fa ff ff       	jmp    8010597f <alltraps>

80105ed2 <vector13>:
80105ed2:	6a 0d                	push   $0xd
80105ed4:	e9 a6 fa ff ff       	jmp    8010597f <alltraps>

80105ed9 <vector14>:
80105ed9:	6a 0e                	push   $0xe
80105edb:	e9 9f fa ff ff       	jmp    8010597f <alltraps>

80105ee0 <vector15>:
80105ee0:	6a 00                	push   $0x0
80105ee2:	6a 0f                	push   $0xf
80105ee4:	e9 96 fa ff ff       	jmp    8010597f <alltraps>

80105ee9 <vector16>:
80105ee9:	6a 00                	push   $0x0
80105eeb:	6a 10                	push   $0x10
80105eed:	e9 8d fa ff ff       	jmp    8010597f <alltraps>

80105ef2 <vector17>:
80105ef2:	6a 11                	push   $0x11
80105ef4:	e9 86 fa ff ff       	jmp    8010597f <alltraps>

80105ef9 <vector18>:
80105ef9:	6a 00                	push   $0x0
80105efb:	6a 12                	push   $0x12
80105efd:	e9 7d fa ff ff       	jmp    8010597f <alltraps>

80105f02 <vector19>:
80105f02:	6a 00                	push   $0x0
80105f04:	6a 13                	push   $0x13
80105f06:	e9 74 fa ff ff       	jmp    8010597f <alltraps>

80105f0b <vector20>:
80105f0b:	6a 00                	push   $0x0
80105f0d:	6a 14                	push   $0x14
80105f0f:	e9 6b fa ff ff       	jmp    8010597f <alltraps>

80105f14 <vector21>:
80105f14:	6a 00                	push   $0x0
80105f16:	6a 15                	push   $0x15
80105f18:	e9 62 fa ff ff       	jmp    8010597f <alltraps>

80105f1d <vector22>:
80105f1d:	6a 00                	push   $0x0
80105f1f:	6a 16                	push   $0x16
80105f21:	e9 59 fa ff ff       	jmp    8010597f <alltraps>

80105f26 <vector23>:
80105f26:	6a 00                	push   $0x0
80105f28:	6a 17                	push   $0x17
80105f2a:	e9 50 fa ff ff       	jmp    8010597f <alltraps>

80105f2f <vector24>:
80105f2f:	6a 00                	push   $0x0
80105f31:	6a 18                	push   $0x18
80105f33:	e9 47 fa ff ff       	jmp    8010597f <alltraps>

80105f38 <vector25>:
80105f38:	6a 00                	push   $0x0
80105f3a:	6a 19                	push   $0x19
80105f3c:	e9 3e fa ff ff       	jmp    8010597f <alltraps>

80105f41 <vector26>:
80105f41:	6a 00                	push   $0x0
80105f43:	6a 1a                	push   $0x1a
80105f45:	e9 35 fa ff ff       	jmp    8010597f <alltraps>

80105f4a <vector27>:
80105f4a:	6a 00                	push   $0x0
80105f4c:	6a 1b                	push   $0x1b
80105f4e:	e9 2c fa ff ff       	jmp    8010597f <alltraps>

80105f53 <vector28>:
80105f53:	6a 00                	push   $0x0
80105f55:	6a 1c                	push   $0x1c
80105f57:	e9 23 fa ff ff       	jmp    8010597f <alltraps>

80105f5c <vector29>:
80105f5c:	6a 00                	push   $0x0
80105f5e:	6a 1d                	push   $0x1d
80105f60:	e9 1a fa ff ff       	jmp    8010597f <alltraps>

80105f65 <vector30>:
80105f65:	6a 00                	push   $0x0
80105f67:	6a 1e                	push   $0x1e
80105f69:	e9 11 fa ff ff       	jmp    8010597f <alltraps>

80105f6e <vector31>:
80105f6e:	6a 00                	push   $0x0
80105f70:	6a 1f                	push   $0x1f
80105f72:	e9 08 fa ff ff       	jmp    8010597f <alltraps>

80105f77 <vector32>:
80105f77:	6a 00                	push   $0x0
80105f79:	6a 20                	push   $0x20
80105f7b:	e9 ff f9 ff ff       	jmp    8010597f <alltraps>

80105f80 <vector33>:
80105f80:	6a 00                	push   $0x0
80105f82:	6a 21                	push   $0x21
80105f84:	e9 f6 f9 ff ff       	jmp    8010597f <alltraps>

80105f89 <vector34>:
80105f89:	6a 00                	push   $0x0
80105f8b:	6a 22                	push   $0x22
80105f8d:	e9 ed f9 ff ff       	jmp    8010597f <alltraps>

80105f92 <vector35>:
80105f92:	6a 00                	push   $0x0
80105f94:	6a 23                	push   $0x23
80105f96:	e9 e4 f9 ff ff       	jmp    8010597f <alltraps>

80105f9b <vector36>:
80105f9b:	6a 00                	push   $0x0
80105f9d:	6a 24                	push   $0x24
80105f9f:	e9 db f9 ff ff       	jmp    8010597f <alltraps>

80105fa4 <vector37>:
80105fa4:	6a 00                	push   $0x0
80105fa6:	6a 25                	push   $0x25
80105fa8:	e9 d2 f9 ff ff       	jmp    8010597f <alltraps>

80105fad <vector38>:
80105fad:	6a 00                	push   $0x0
80105faf:	6a 26                	push   $0x26
80105fb1:	e9 c9 f9 ff ff       	jmp    8010597f <alltraps>

80105fb6 <vector39>:
80105fb6:	6a 00                	push   $0x0
80105fb8:	6a 27                	push   $0x27
80105fba:	e9 c0 f9 ff ff       	jmp    8010597f <alltraps>

80105fbf <vector40>:
80105fbf:	6a 00                	push   $0x0
80105fc1:	6a 28                	push   $0x28
80105fc3:	e9 b7 f9 ff ff       	jmp    8010597f <alltraps>

80105fc8 <vector41>:
80105fc8:	6a 00                	push   $0x0
80105fca:	6a 29                	push   $0x29
80105fcc:	e9 ae f9 ff ff       	jmp    8010597f <alltraps>

80105fd1 <vector42>:
80105fd1:	6a 00                	push   $0x0
80105fd3:	6a 2a                	push   $0x2a
80105fd5:	e9 a5 f9 ff ff       	jmp    8010597f <alltraps>

80105fda <vector43>:
80105fda:	6a 00                	push   $0x0
80105fdc:	6a 2b                	push   $0x2b
80105fde:	e9 9c f9 ff ff       	jmp    8010597f <alltraps>

80105fe3 <vector44>:
80105fe3:	6a 00                	push   $0x0
80105fe5:	6a 2c                	push   $0x2c
80105fe7:	e9 93 f9 ff ff       	jmp    8010597f <alltraps>

80105fec <vector45>:
80105fec:	6a 00                	push   $0x0
80105fee:	6a 2d                	push   $0x2d
80105ff0:	e9 8a f9 ff ff       	jmp    8010597f <alltraps>

80105ff5 <vector46>:
80105ff5:	6a 00                	push   $0x0
80105ff7:	6a 2e                	push   $0x2e
80105ff9:	e9 81 f9 ff ff       	jmp    8010597f <alltraps>

80105ffe <vector47>:
80105ffe:	6a 00                	push   $0x0
80106000:	6a 2f                	push   $0x2f
80106002:	e9 78 f9 ff ff       	jmp    8010597f <alltraps>

80106007 <vector48>:
80106007:	6a 00                	push   $0x0
80106009:	6a 30                	push   $0x30
8010600b:	e9 6f f9 ff ff       	jmp    8010597f <alltraps>

80106010 <vector49>:
80106010:	6a 00                	push   $0x0
80106012:	6a 31                	push   $0x31
80106014:	e9 66 f9 ff ff       	jmp    8010597f <alltraps>

80106019 <vector50>:
80106019:	6a 00                	push   $0x0
8010601b:	6a 32                	push   $0x32
8010601d:	e9 5d f9 ff ff       	jmp    8010597f <alltraps>

80106022 <vector51>:
80106022:	6a 00                	push   $0x0
80106024:	6a 33                	push   $0x33
80106026:	e9 54 f9 ff ff       	jmp    8010597f <alltraps>

8010602b <vector52>:
8010602b:	6a 00                	push   $0x0
8010602d:	6a 34                	push   $0x34
8010602f:	e9 4b f9 ff ff       	jmp    8010597f <alltraps>

80106034 <vector53>:
80106034:	6a 00                	push   $0x0
80106036:	6a 35                	push   $0x35
80106038:	e9 42 f9 ff ff       	jmp    8010597f <alltraps>

8010603d <vector54>:
8010603d:	6a 00                	push   $0x0
8010603f:	6a 36                	push   $0x36
80106041:	e9 39 f9 ff ff       	jmp    8010597f <alltraps>

80106046 <vector55>:
80106046:	6a 00                	push   $0x0
80106048:	6a 37                	push   $0x37
8010604a:	e9 30 f9 ff ff       	jmp    8010597f <alltraps>

8010604f <vector56>:
8010604f:	6a 00                	push   $0x0
80106051:	6a 38                	push   $0x38
80106053:	e9 27 f9 ff ff       	jmp    8010597f <alltraps>

80106058 <vector57>:
80106058:	6a 00                	push   $0x0
8010605a:	6a 39                	push   $0x39
8010605c:	e9 1e f9 ff ff       	jmp    8010597f <alltraps>

80106061 <vector58>:
80106061:	6a 00                	push   $0x0
80106063:	6a 3a                	push   $0x3a
80106065:	e9 15 f9 ff ff       	jmp    8010597f <alltraps>

8010606a <vector59>:
8010606a:	6a 00                	push   $0x0
8010606c:	6a 3b                	push   $0x3b
8010606e:	e9 0c f9 ff ff       	jmp    8010597f <alltraps>

80106073 <vector60>:
80106073:	6a 00                	push   $0x0
80106075:	6a 3c                	push   $0x3c
80106077:	e9 03 f9 ff ff       	jmp    8010597f <alltraps>

8010607c <vector61>:
8010607c:	6a 00                	push   $0x0
8010607e:	6a 3d                	push   $0x3d
80106080:	e9 fa f8 ff ff       	jmp    8010597f <alltraps>

80106085 <vector62>:
80106085:	6a 00                	push   $0x0
80106087:	6a 3e                	push   $0x3e
80106089:	e9 f1 f8 ff ff       	jmp    8010597f <alltraps>

8010608e <vector63>:
8010608e:	6a 00                	push   $0x0
80106090:	6a 3f                	push   $0x3f
80106092:	e9 e8 f8 ff ff       	jmp    8010597f <alltraps>

80106097 <vector64>:
80106097:	6a 00                	push   $0x0
80106099:	6a 40                	push   $0x40
8010609b:	e9 df f8 ff ff       	jmp    8010597f <alltraps>

801060a0 <vector65>:
801060a0:	6a 00                	push   $0x0
801060a2:	6a 41                	push   $0x41
801060a4:	e9 d6 f8 ff ff       	jmp    8010597f <alltraps>

801060a9 <vector66>:
801060a9:	6a 00                	push   $0x0
801060ab:	6a 42                	push   $0x42
801060ad:	e9 cd f8 ff ff       	jmp    8010597f <alltraps>

801060b2 <vector67>:
801060b2:	6a 00                	push   $0x0
801060b4:	6a 43                	push   $0x43
801060b6:	e9 c4 f8 ff ff       	jmp    8010597f <alltraps>

801060bb <vector68>:
801060bb:	6a 00                	push   $0x0
801060bd:	6a 44                	push   $0x44
801060bf:	e9 bb f8 ff ff       	jmp    8010597f <alltraps>

801060c4 <vector69>:
801060c4:	6a 00                	push   $0x0
801060c6:	6a 45                	push   $0x45
801060c8:	e9 b2 f8 ff ff       	jmp    8010597f <alltraps>

801060cd <vector70>:
801060cd:	6a 00                	push   $0x0
801060cf:	6a 46                	push   $0x46
801060d1:	e9 a9 f8 ff ff       	jmp    8010597f <alltraps>

801060d6 <vector71>:
801060d6:	6a 00                	push   $0x0
801060d8:	6a 47                	push   $0x47
801060da:	e9 a0 f8 ff ff       	jmp    8010597f <alltraps>

801060df <vector72>:
801060df:	6a 00                	push   $0x0
801060e1:	6a 48                	push   $0x48
801060e3:	e9 97 f8 ff ff       	jmp    8010597f <alltraps>

801060e8 <vector73>:
801060e8:	6a 00                	push   $0x0
801060ea:	6a 49                	push   $0x49
801060ec:	e9 8e f8 ff ff       	jmp    8010597f <alltraps>

801060f1 <vector74>:
801060f1:	6a 00                	push   $0x0
801060f3:	6a 4a                	push   $0x4a
801060f5:	e9 85 f8 ff ff       	jmp    8010597f <alltraps>

801060fa <vector75>:
801060fa:	6a 00                	push   $0x0
801060fc:	6a 4b                	push   $0x4b
801060fe:	e9 7c f8 ff ff       	jmp    8010597f <alltraps>

80106103 <vector76>:
80106103:	6a 00                	push   $0x0
80106105:	6a 4c                	push   $0x4c
80106107:	e9 73 f8 ff ff       	jmp    8010597f <alltraps>

8010610c <vector77>:
8010610c:	6a 00                	push   $0x0
8010610e:	6a 4d                	push   $0x4d
80106110:	e9 6a f8 ff ff       	jmp    8010597f <alltraps>

80106115 <vector78>:
80106115:	6a 00                	push   $0x0
80106117:	6a 4e                	push   $0x4e
80106119:	e9 61 f8 ff ff       	jmp    8010597f <alltraps>

8010611e <vector79>:
8010611e:	6a 00                	push   $0x0
80106120:	6a 4f                	push   $0x4f
80106122:	e9 58 f8 ff ff       	jmp    8010597f <alltraps>

80106127 <vector80>:
80106127:	6a 00                	push   $0x0
80106129:	6a 50                	push   $0x50
8010612b:	e9 4f f8 ff ff       	jmp    8010597f <alltraps>

80106130 <vector81>:
80106130:	6a 00                	push   $0x0
80106132:	6a 51                	push   $0x51
80106134:	e9 46 f8 ff ff       	jmp    8010597f <alltraps>

80106139 <vector82>:
80106139:	6a 00                	push   $0x0
8010613b:	6a 52                	push   $0x52
8010613d:	e9 3d f8 ff ff       	jmp    8010597f <alltraps>

80106142 <vector83>:
80106142:	6a 00                	push   $0x0
80106144:	6a 53                	push   $0x53
80106146:	e9 34 f8 ff ff       	jmp    8010597f <alltraps>

8010614b <vector84>:
8010614b:	6a 00                	push   $0x0
8010614d:	6a 54                	push   $0x54
8010614f:	e9 2b f8 ff ff       	jmp    8010597f <alltraps>

80106154 <vector85>:
80106154:	6a 00                	push   $0x0
80106156:	6a 55                	push   $0x55
80106158:	e9 22 f8 ff ff       	jmp    8010597f <alltraps>

8010615d <vector86>:
8010615d:	6a 00                	push   $0x0
8010615f:	6a 56                	push   $0x56
80106161:	e9 19 f8 ff ff       	jmp    8010597f <alltraps>

80106166 <vector87>:
80106166:	6a 00                	push   $0x0
80106168:	6a 57                	push   $0x57
8010616a:	e9 10 f8 ff ff       	jmp    8010597f <alltraps>

8010616f <vector88>:
8010616f:	6a 00                	push   $0x0
80106171:	6a 58                	push   $0x58
80106173:	e9 07 f8 ff ff       	jmp    8010597f <alltraps>

80106178 <vector89>:
80106178:	6a 00                	push   $0x0
8010617a:	6a 59                	push   $0x59
8010617c:	e9 fe f7 ff ff       	jmp    8010597f <alltraps>

80106181 <vector90>:
80106181:	6a 00                	push   $0x0
80106183:	6a 5a                	push   $0x5a
80106185:	e9 f5 f7 ff ff       	jmp    8010597f <alltraps>

8010618a <vector91>:
8010618a:	6a 00                	push   $0x0
8010618c:	6a 5b                	push   $0x5b
8010618e:	e9 ec f7 ff ff       	jmp    8010597f <alltraps>

80106193 <vector92>:
80106193:	6a 00                	push   $0x0
80106195:	6a 5c                	push   $0x5c
80106197:	e9 e3 f7 ff ff       	jmp    8010597f <alltraps>

8010619c <vector93>:
8010619c:	6a 00                	push   $0x0
8010619e:	6a 5d                	push   $0x5d
801061a0:	e9 da f7 ff ff       	jmp    8010597f <alltraps>

801061a5 <vector94>:
801061a5:	6a 00                	push   $0x0
801061a7:	6a 5e                	push   $0x5e
801061a9:	e9 d1 f7 ff ff       	jmp    8010597f <alltraps>

801061ae <vector95>:
801061ae:	6a 00                	push   $0x0
801061b0:	6a 5f                	push   $0x5f
801061b2:	e9 c8 f7 ff ff       	jmp    8010597f <alltraps>

801061b7 <vector96>:
801061b7:	6a 00                	push   $0x0
801061b9:	6a 60                	push   $0x60
801061bb:	e9 bf f7 ff ff       	jmp    8010597f <alltraps>

801061c0 <vector97>:
801061c0:	6a 00                	push   $0x0
801061c2:	6a 61                	push   $0x61
801061c4:	e9 b6 f7 ff ff       	jmp    8010597f <alltraps>

801061c9 <vector98>:
801061c9:	6a 00                	push   $0x0
801061cb:	6a 62                	push   $0x62
801061cd:	e9 ad f7 ff ff       	jmp    8010597f <alltraps>

801061d2 <vector99>:
801061d2:	6a 00                	push   $0x0
801061d4:	6a 63                	push   $0x63
801061d6:	e9 a4 f7 ff ff       	jmp    8010597f <alltraps>

801061db <vector100>:
801061db:	6a 00                	push   $0x0
801061dd:	6a 64                	push   $0x64
801061df:	e9 9b f7 ff ff       	jmp    8010597f <alltraps>

801061e4 <vector101>:
801061e4:	6a 00                	push   $0x0
801061e6:	6a 65                	push   $0x65
801061e8:	e9 92 f7 ff ff       	jmp    8010597f <alltraps>

801061ed <vector102>:
801061ed:	6a 00                	push   $0x0
801061ef:	6a 66                	push   $0x66
801061f1:	e9 89 f7 ff ff       	jmp    8010597f <alltraps>

801061f6 <vector103>:
801061f6:	6a 00                	push   $0x0
801061f8:	6a 67                	push   $0x67
801061fa:	e9 80 f7 ff ff       	jmp    8010597f <alltraps>

801061ff <vector104>:
801061ff:	6a 00                	push   $0x0
80106201:	6a 68                	push   $0x68
80106203:	e9 77 f7 ff ff       	jmp    8010597f <alltraps>

80106208 <vector105>:
80106208:	6a 00                	push   $0x0
8010620a:	6a 69                	push   $0x69
8010620c:	e9 6e f7 ff ff       	jmp    8010597f <alltraps>

80106211 <vector106>:
80106211:	6a 00                	push   $0x0
80106213:	6a 6a                	push   $0x6a
80106215:	e9 65 f7 ff ff       	jmp    8010597f <alltraps>

8010621a <vector107>:
8010621a:	6a 00                	push   $0x0
8010621c:	6a 6b                	push   $0x6b
8010621e:	e9 5c f7 ff ff       	jmp    8010597f <alltraps>

80106223 <vector108>:
80106223:	6a 00                	push   $0x0
80106225:	6a 6c                	push   $0x6c
80106227:	e9 53 f7 ff ff       	jmp    8010597f <alltraps>

8010622c <vector109>:
8010622c:	6a 00                	push   $0x0
8010622e:	6a 6d                	push   $0x6d
80106230:	e9 4a f7 ff ff       	jmp    8010597f <alltraps>

80106235 <vector110>:
80106235:	6a 00                	push   $0x0
80106237:	6a 6e                	push   $0x6e
80106239:	e9 41 f7 ff ff       	jmp    8010597f <alltraps>

8010623e <vector111>:
8010623e:	6a 00                	push   $0x0
80106240:	6a 6f                	push   $0x6f
80106242:	e9 38 f7 ff ff       	jmp    8010597f <alltraps>

80106247 <vector112>:
80106247:	6a 00                	push   $0x0
80106249:	6a 70                	push   $0x70
8010624b:	e9 2f f7 ff ff       	jmp    8010597f <alltraps>

80106250 <vector113>:
80106250:	6a 00                	push   $0x0
80106252:	6a 71                	push   $0x71
80106254:	e9 26 f7 ff ff       	jmp    8010597f <alltraps>

80106259 <vector114>:
80106259:	6a 00                	push   $0x0
8010625b:	6a 72                	push   $0x72
8010625d:	e9 1d f7 ff ff       	jmp    8010597f <alltraps>

80106262 <vector115>:
80106262:	6a 00                	push   $0x0
80106264:	6a 73                	push   $0x73
80106266:	e9 14 f7 ff ff       	jmp    8010597f <alltraps>

8010626b <vector116>:
8010626b:	6a 00                	push   $0x0
8010626d:	6a 74                	push   $0x74
8010626f:	e9 0b f7 ff ff       	jmp    8010597f <alltraps>

80106274 <vector117>:
80106274:	6a 00                	push   $0x0
80106276:	6a 75                	push   $0x75
80106278:	e9 02 f7 ff ff       	jmp    8010597f <alltraps>

8010627d <vector118>:
8010627d:	6a 00                	push   $0x0
8010627f:	6a 76                	push   $0x76
80106281:	e9 f9 f6 ff ff       	jmp    8010597f <alltraps>

80106286 <vector119>:
80106286:	6a 00                	push   $0x0
80106288:	6a 77                	push   $0x77
8010628a:	e9 f0 f6 ff ff       	jmp    8010597f <alltraps>

8010628f <vector120>:
8010628f:	6a 00                	push   $0x0
80106291:	6a 78                	push   $0x78
80106293:	e9 e7 f6 ff ff       	jmp    8010597f <alltraps>

80106298 <vector121>:
80106298:	6a 00                	push   $0x0
8010629a:	6a 79                	push   $0x79
8010629c:	e9 de f6 ff ff       	jmp    8010597f <alltraps>

801062a1 <vector122>:
801062a1:	6a 00                	push   $0x0
801062a3:	6a 7a                	push   $0x7a
801062a5:	e9 d5 f6 ff ff       	jmp    8010597f <alltraps>

801062aa <vector123>:
801062aa:	6a 00                	push   $0x0
801062ac:	6a 7b                	push   $0x7b
801062ae:	e9 cc f6 ff ff       	jmp    8010597f <alltraps>

801062b3 <vector124>:
801062b3:	6a 00                	push   $0x0
801062b5:	6a 7c                	push   $0x7c
801062b7:	e9 c3 f6 ff ff       	jmp    8010597f <alltraps>

801062bc <vector125>:
801062bc:	6a 00                	push   $0x0
801062be:	6a 7d                	push   $0x7d
801062c0:	e9 ba f6 ff ff       	jmp    8010597f <alltraps>

801062c5 <vector126>:
801062c5:	6a 00                	push   $0x0
801062c7:	6a 7e                	push   $0x7e
801062c9:	e9 b1 f6 ff ff       	jmp    8010597f <alltraps>

801062ce <vector127>:
801062ce:	6a 00                	push   $0x0
801062d0:	6a 7f                	push   $0x7f
801062d2:	e9 a8 f6 ff ff       	jmp    8010597f <alltraps>

801062d7 <vector128>:
801062d7:	6a 00                	push   $0x0
801062d9:	68 80 00 00 00       	push   $0x80
801062de:	e9 9c f6 ff ff       	jmp    8010597f <alltraps>

801062e3 <vector129>:
801062e3:	6a 00                	push   $0x0
801062e5:	68 81 00 00 00       	push   $0x81
801062ea:	e9 90 f6 ff ff       	jmp    8010597f <alltraps>

801062ef <vector130>:
801062ef:	6a 00                	push   $0x0
801062f1:	68 82 00 00 00       	push   $0x82
801062f6:	e9 84 f6 ff ff       	jmp    8010597f <alltraps>

801062fb <vector131>:
801062fb:	6a 00                	push   $0x0
801062fd:	68 83 00 00 00       	push   $0x83
80106302:	e9 78 f6 ff ff       	jmp    8010597f <alltraps>

80106307 <vector132>:
80106307:	6a 00                	push   $0x0
80106309:	68 84 00 00 00       	push   $0x84
8010630e:	e9 6c f6 ff ff       	jmp    8010597f <alltraps>

80106313 <vector133>:
80106313:	6a 00                	push   $0x0
80106315:	68 85 00 00 00       	push   $0x85
8010631a:	e9 60 f6 ff ff       	jmp    8010597f <alltraps>

8010631f <vector134>:
8010631f:	6a 00                	push   $0x0
80106321:	68 86 00 00 00       	push   $0x86
80106326:	e9 54 f6 ff ff       	jmp    8010597f <alltraps>

8010632b <vector135>:
8010632b:	6a 00                	push   $0x0
8010632d:	68 87 00 00 00       	push   $0x87
80106332:	e9 48 f6 ff ff       	jmp    8010597f <alltraps>

80106337 <vector136>:
80106337:	6a 00                	push   $0x0
80106339:	68 88 00 00 00       	push   $0x88
8010633e:	e9 3c f6 ff ff       	jmp    8010597f <alltraps>

80106343 <vector137>:
80106343:	6a 00                	push   $0x0
80106345:	68 89 00 00 00       	push   $0x89
8010634a:	e9 30 f6 ff ff       	jmp    8010597f <alltraps>

8010634f <vector138>:
8010634f:	6a 00                	push   $0x0
80106351:	68 8a 00 00 00       	push   $0x8a
80106356:	e9 24 f6 ff ff       	jmp    8010597f <alltraps>

8010635b <vector139>:
8010635b:	6a 00                	push   $0x0
8010635d:	68 8b 00 00 00       	push   $0x8b
80106362:	e9 18 f6 ff ff       	jmp    8010597f <alltraps>

80106367 <vector140>:
80106367:	6a 00                	push   $0x0
80106369:	68 8c 00 00 00       	push   $0x8c
8010636e:	e9 0c f6 ff ff       	jmp    8010597f <alltraps>

80106373 <vector141>:
80106373:	6a 00                	push   $0x0
80106375:	68 8d 00 00 00       	push   $0x8d
8010637a:	e9 00 f6 ff ff       	jmp    8010597f <alltraps>

8010637f <vector142>:
8010637f:	6a 00                	push   $0x0
80106381:	68 8e 00 00 00       	push   $0x8e
80106386:	e9 f4 f5 ff ff       	jmp    8010597f <alltraps>

8010638b <vector143>:
8010638b:	6a 00                	push   $0x0
8010638d:	68 8f 00 00 00       	push   $0x8f
80106392:	e9 e8 f5 ff ff       	jmp    8010597f <alltraps>

80106397 <vector144>:
80106397:	6a 00                	push   $0x0
80106399:	68 90 00 00 00       	push   $0x90
8010639e:	e9 dc f5 ff ff       	jmp    8010597f <alltraps>

801063a3 <vector145>:
801063a3:	6a 00                	push   $0x0
801063a5:	68 91 00 00 00       	push   $0x91
801063aa:	e9 d0 f5 ff ff       	jmp    8010597f <alltraps>

801063af <vector146>:
801063af:	6a 00                	push   $0x0
801063b1:	68 92 00 00 00       	push   $0x92
801063b6:	e9 c4 f5 ff ff       	jmp    8010597f <alltraps>

801063bb <vector147>:
801063bb:	6a 00                	push   $0x0
801063bd:	68 93 00 00 00       	push   $0x93
801063c2:	e9 b8 f5 ff ff       	jmp    8010597f <alltraps>

801063c7 <vector148>:
801063c7:	6a 00                	push   $0x0
801063c9:	68 94 00 00 00       	push   $0x94
801063ce:	e9 ac f5 ff ff       	jmp    8010597f <alltraps>

801063d3 <vector149>:
801063d3:	6a 00                	push   $0x0
801063d5:	68 95 00 00 00       	push   $0x95
801063da:	e9 a0 f5 ff ff       	jmp    8010597f <alltraps>

801063df <vector150>:
801063df:	6a 00                	push   $0x0
801063e1:	68 96 00 00 00       	push   $0x96
801063e6:	e9 94 f5 ff ff       	jmp    8010597f <alltraps>

801063eb <vector151>:
801063eb:	6a 00                	push   $0x0
801063ed:	68 97 00 00 00       	push   $0x97
801063f2:	e9 88 f5 ff ff       	jmp    8010597f <alltraps>

801063f7 <vector152>:
801063f7:	6a 00                	push   $0x0
801063f9:	68 98 00 00 00       	push   $0x98
801063fe:	e9 7c f5 ff ff       	jmp    8010597f <alltraps>

80106403 <vector153>:
80106403:	6a 00                	push   $0x0
80106405:	68 99 00 00 00       	push   $0x99
8010640a:	e9 70 f5 ff ff       	jmp    8010597f <alltraps>

8010640f <vector154>:
8010640f:	6a 00                	push   $0x0
80106411:	68 9a 00 00 00       	push   $0x9a
80106416:	e9 64 f5 ff ff       	jmp    8010597f <alltraps>

8010641b <vector155>:
8010641b:	6a 00                	push   $0x0
8010641d:	68 9b 00 00 00       	push   $0x9b
80106422:	e9 58 f5 ff ff       	jmp    8010597f <alltraps>

80106427 <vector156>:
80106427:	6a 00                	push   $0x0
80106429:	68 9c 00 00 00       	push   $0x9c
8010642e:	e9 4c f5 ff ff       	jmp    8010597f <alltraps>

80106433 <vector157>:
80106433:	6a 00                	push   $0x0
80106435:	68 9d 00 00 00       	push   $0x9d
8010643a:	e9 40 f5 ff ff       	jmp    8010597f <alltraps>

8010643f <vector158>:
8010643f:	6a 00                	push   $0x0
80106441:	68 9e 00 00 00       	push   $0x9e
80106446:	e9 34 f5 ff ff       	jmp    8010597f <alltraps>

8010644b <vector159>:
8010644b:	6a 00                	push   $0x0
8010644d:	68 9f 00 00 00       	push   $0x9f
80106452:	e9 28 f5 ff ff       	jmp    8010597f <alltraps>

80106457 <vector160>:
80106457:	6a 00                	push   $0x0
80106459:	68 a0 00 00 00       	push   $0xa0
8010645e:	e9 1c f5 ff ff       	jmp    8010597f <alltraps>

80106463 <vector161>:
80106463:	6a 00                	push   $0x0
80106465:	68 a1 00 00 00       	push   $0xa1
8010646a:	e9 10 f5 ff ff       	jmp    8010597f <alltraps>

8010646f <vector162>:
8010646f:	6a 00                	push   $0x0
80106471:	68 a2 00 00 00       	push   $0xa2
80106476:	e9 04 f5 ff ff       	jmp    8010597f <alltraps>

8010647b <vector163>:
8010647b:	6a 00                	push   $0x0
8010647d:	68 a3 00 00 00       	push   $0xa3
80106482:	e9 f8 f4 ff ff       	jmp    8010597f <alltraps>

80106487 <vector164>:
80106487:	6a 00                	push   $0x0
80106489:	68 a4 00 00 00       	push   $0xa4
8010648e:	e9 ec f4 ff ff       	jmp    8010597f <alltraps>

80106493 <vector165>:
80106493:	6a 00                	push   $0x0
80106495:	68 a5 00 00 00       	push   $0xa5
8010649a:	e9 e0 f4 ff ff       	jmp    8010597f <alltraps>

8010649f <vector166>:
8010649f:	6a 00                	push   $0x0
801064a1:	68 a6 00 00 00       	push   $0xa6
801064a6:	e9 d4 f4 ff ff       	jmp    8010597f <alltraps>

801064ab <vector167>:
801064ab:	6a 00                	push   $0x0
801064ad:	68 a7 00 00 00       	push   $0xa7
801064b2:	e9 c8 f4 ff ff       	jmp    8010597f <alltraps>

801064b7 <vector168>:
801064b7:	6a 00                	push   $0x0
801064b9:	68 a8 00 00 00       	push   $0xa8
801064be:	e9 bc f4 ff ff       	jmp    8010597f <alltraps>

801064c3 <vector169>:
801064c3:	6a 00                	push   $0x0
801064c5:	68 a9 00 00 00       	push   $0xa9
801064ca:	e9 b0 f4 ff ff       	jmp    8010597f <alltraps>

801064cf <vector170>:
801064cf:	6a 00                	push   $0x0
801064d1:	68 aa 00 00 00       	push   $0xaa
801064d6:	e9 a4 f4 ff ff       	jmp    8010597f <alltraps>

801064db <vector171>:
801064db:	6a 00                	push   $0x0
801064dd:	68 ab 00 00 00       	push   $0xab
801064e2:	e9 98 f4 ff ff       	jmp    8010597f <alltraps>

801064e7 <vector172>:
801064e7:	6a 00                	push   $0x0
801064e9:	68 ac 00 00 00       	push   $0xac
801064ee:	e9 8c f4 ff ff       	jmp    8010597f <alltraps>

801064f3 <vector173>:
801064f3:	6a 00                	push   $0x0
801064f5:	68 ad 00 00 00       	push   $0xad
801064fa:	e9 80 f4 ff ff       	jmp    8010597f <alltraps>

801064ff <vector174>:
801064ff:	6a 00                	push   $0x0
80106501:	68 ae 00 00 00       	push   $0xae
80106506:	e9 74 f4 ff ff       	jmp    8010597f <alltraps>

8010650b <vector175>:
8010650b:	6a 00                	push   $0x0
8010650d:	68 af 00 00 00       	push   $0xaf
80106512:	e9 68 f4 ff ff       	jmp    8010597f <alltraps>

80106517 <vector176>:
80106517:	6a 00                	push   $0x0
80106519:	68 b0 00 00 00       	push   $0xb0
8010651e:	e9 5c f4 ff ff       	jmp    8010597f <alltraps>

80106523 <vector177>:
80106523:	6a 00                	push   $0x0
80106525:	68 b1 00 00 00       	push   $0xb1
8010652a:	e9 50 f4 ff ff       	jmp    8010597f <alltraps>

8010652f <vector178>:
8010652f:	6a 00                	push   $0x0
80106531:	68 b2 00 00 00       	push   $0xb2
80106536:	e9 44 f4 ff ff       	jmp    8010597f <alltraps>

8010653b <vector179>:
8010653b:	6a 00                	push   $0x0
8010653d:	68 b3 00 00 00       	push   $0xb3
80106542:	e9 38 f4 ff ff       	jmp    8010597f <alltraps>

80106547 <vector180>:
80106547:	6a 00                	push   $0x0
80106549:	68 b4 00 00 00       	push   $0xb4
8010654e:	e9 2c f4 ff ff       	jmp    8010597f <alltraps>

80106553 <vector181>:
80106553:	6a 00                	push   $0x0
80106555:	68 b5 00 00 00       	push   $0xb5
8010655a:	e9 20 f4 ff ff       	jmp    8010597f <alltraps>

8010655f <vector182>:
8010655f:	6a 00                	push   $0x0
80106561:	68 b6 00 00 00       	push   $0xb6
80106566:	e9 14 f4 ff ff       	jmp    8010597f <alltraps>

8010656b <vector183>:
8010656b:	6a 00                	push   $0x0
8010656d:	68 b7 00 00 00       	push   $0xb7
80106572:	e9 08 f4 ff ff       	jmp    8010597f <alltraps>

80106577 <vector184>:
80106577:	6a 00                	push   $0x0
80106579:	68 b8 00 00 00       	push   $0xb8
8010657e:	e9 fc f3 ff ff       	jmp    8010597f <alltraps>

80106583 <vector185>:
80106583:	6a 00                	push   $0x0
80106585:	68 b9 00 00 00       	push   $0xb9
8010658a:	e9 f0 f3 ff ff       	jmp    8010597f <alltraps>

8010658f <vector186>:
8010658f:	6a 00                	push   $0x0
80106591:	68 ba 00 00 00       	push   $0xba
80106596:	e9 e4 f3 ff ff       	jmp    8010597f <alltraps>

8010659b <vector187>:
8010659b:	6a 00                	push   $0x0
8010659d:	68 bb 00 00 00       	push   $0xbb
801065a2:	e9 d8 f3 ff ff       	jmp    8010597f <alltraps>

801065a7 <vector188>:
801065a7:	6a 00                	push   $0x0
801065a9:	68 bc 00 00 00       	push   $0xbc
801065ae:	e9 cc f3 ff ff       	jmp    8010597f <alltraps>

801065b3 <vector189>:
801065b3:	6a 00                	push   $0x0
801065b5:	68 bd 00 00 00       	push   $0xbd
801065ba:	e9 c0 f3 ff ff       	jmp    8010597f <alltraps>

801065bf <vector190>:
801065bf:	6a 00                	push   $0x0
801065c1:	68 be 00 00 00       	push   $0xbe
801065c6:	e9 b4 f3 ff ff       	jmp    8010597f <alltraps>

801065cb <vector191>:
801065cb:	6a 00                	push   $0x0
801065cd:	68 bf 00 00 00       	push   $0xbf
801065d2:	e9 a8 f3 ff ff       	jmp    8010597f <alltraps>

801065d7 <vector192>:
801065d7:	6a 00                	push   $0x0
801065d9:	68 c0 00 00 00       	push   $0xc0
801065de:	e9 9c f3 ff ff       	jmp    8010597f <alltraps>

801065e3 <vector193>:
801065e3:	6a 00                	push   $0x0
801065e5:	68 c1 00 00 00       	push   $0xc1
801065ea:	e9 90 f3 ff ff       	jmp    8010597f <alltraps>

801065ef <vector194>:
801065ef:	6a 00                	push   $0x0
801065f1:	68 c2 00 00 00       	push   $0xc2
801065f6:	e9 84 f3 ff ff       	jmp    8010597f <alltraps>

801065fb <vector195>:
801065fb:	6a 00                	push   $0x0
801065fd:	68 c3 00 00 00       	push   $0xc3
80106602:	e9 78 f3 ff ff       	jmp    8010597f <alltraps>

80106607 <vector196>:
80106607:	6a 00                	push   $0x0
80106609:	68 c4 00 00 00       	push   $0xc4
8010660e:	e9 6c f3 ff ff       	jmp    8010597f <alltraps>

80106613 <vector197>:
80106613:	6a 00                	push   $0x0
80106615:	68 c5 00 00 00       	push   $0xc5
8010661a:	e9 60 f3 ff ff       	jmp    8010597f <alltraps>

8010661f <vector198>:
8010661f:	6a 00                	push   $0x0
80106621:	68 c6 00 00 00       	push   $0xc6
80106626:	e9 54 f3 ff ff       	jmp    8010597f <alltraps>

8010662b <vector199>:
8010662b:	6a 00                	push   $0x0
8010662d:	68 c7 00 00 00       	push   $0xc7
80106632:	e9 48 f3 ff ff       	jmp    8010597f <alltraps>

80106637 <vector200>:
80106637:	6a 00                	push   $0x0
80106639:	68 c8 00 00 00       	push   $0xc8
8010663e:	e9 3c f3 ff ff       	jmp    8010597f <alltraps>

80106643 <vector201>:
80106643:	6a 00                	push   $0x0
80106645:	68 c9 00 00 00       	push   $0xc9
8010664a:	e9 30 f3 ff ff       	jmp    8010597f <alltraps>

8010664f <vector202>:
8010664f:	6a 00                	push   $0x0
80106651:	68 ca 00 00 00       	push   $0xca
80106656:	e9 24 f3 ff ff       	jmp    8010597f <alltraps>

8010665b <vector203>:
8010665b:	6a 00                	push   $0x0
8010665d:	68 cb 00 00 00       	push   $0xcb
80106662:	e9 18 f3 ff ff       	jmp    8010597f <alltraps>

80106667 <vector204>:
80106667:	6a 00                	push   $0x0
80106669:	68 cc 00 00 00       	push   $0xcc
8010666e:	e9 0c f3 ff ff       	jmp    8010597f <alltraps>

80106673 <vector205>:
80106673:	6a 00                	push   $0x0
80106675:	68 cd 00 00 00       	push   $0xcd
8010667a:	e9 00 f3 ff ff       	jmp    8010597f <alltraps>

8010667f <vector206>:
8010667f:	6a 00                	push   $0x0
80106681:	68 ce 00 00 00       	push   $0xce
80106686:	e9 f4 f2 ff ff       	jmp    8010597f <alltraps>

8010668b <vector207>:
8010668b:	6a 00                	push   $0x0
8010668d:	68 cf 00 00 00       	push   $0xcf
80106692:	e9 e8 f2 ff ff       	jmp    8010597f <alltraps>

80106697 <vector208>:
80106697:	6a 00                	push   $0x0
80106699:	68 d0 00 00 00       	push   $0xd0
8010669e:	e9 dc f2 ff ff       	jmp    8010597f <alltraps>

801066a3 <vector209>:
801066a3:	6a 00                	push   $0x0
801066a5:	68 d1 00 00 00       	push   $0xd1
801066aa:	e9 d0 f2 ff ff       	jmp    8010597f <alltraps>

801066af <vector210>:
801066af:	6a 00                	push   $0x0
801066b1:	68 d2 00 00 00       	push   $0xd2
801066b6:	e9 c4 f2 ff ff       	jmp    8010597f <alltraps>

801066bb <vector211>:
801066bb:	6a 00                	push   $0x0
801066bd:	68 d3 00 00 00       	push   $0xd3
801066c2:	e9 b8 f2 ff ff       	jmp    8010597f <alltraps>

801066c7 <vector212>:
801066c7:	6a 00                	push   $0x0
801066c9:	68 d4 00 00 00       	push   $0xd4
801066ce:	e9 ac f2 ff ff       	jmp    8010597f <alltraps>

801066d3 <vector213>:
801066d3:	6a 00                	push   $0x0
801066d5:	68 d5 00 00 00       	push   $0xd5
801066da:	e9 a0 f2 ff ff       	jmp    8010597f <alltraps>

801066df <vector214>:
801066df:	6a 00                	push   $0x0
801066e1:	68 d6 00 00 00       	push   $0xd6
801066e6:	e9 94 f2 ff ff       	jmp    8010597f <alltraps>

801066eb <vector215>:
801066eb:	6a 00                	push   $0x0
801066ed:	68 d7 00 00 00       	push   $0xd7
801066f2:	e9 88 f2 ff ff       	jmp    8010597f <alltraps>

801066f7 <vector216>:
801066f7:	6a 00                	push   $0x0
801066f9:	68 d8 00 00 00       	push   $0xd8
801066fe:	e9 7c f2 ff ff       	jmp    8010597f <alltraps>

80106703 <vector217>:
80106703:	6a 00                	push   $0x0
80106705:	68 d9 00 00 00       	push   $0xd9
8010670a:	e9 70 f2 ff ff       	jmp    8010597f <alltraps>

8010670f <vector218>:
8010670f:	6a 00                	push   $0x0
80106711:	68 da 00 00 00       	push   $0xda
80106716:	e9 64 f2 ff ff       	jmp    8010597f <alltraps>

8010671b <vector219>:
8010671b:	6a 00                	push   $0x0
8010671d:	68 db 00 00 00       	push   $0xdb
80106722:	e9 58 f2 ff ff       	jmp    8010597f <alltraps>

80106727 <vector220>:
80106727:	6a 00                	push   $0x0
80106729:	68 dc 00 00 00       	push   $0xdc
8010672e:	e9 4c f2 ff ff       	jmp    8010597f <alltraps>

80106733 <vector221>:
80106733:	6a 00                	push   $0x0
80106735:	68 dd 00 00 00       	push   $0xdd
8010673a:	e9 40 f2 ff ff       	jmp    8010597f <alltraps>

8010673f <vector222>:
8010673f:	6a 00                	push   $0x0
80106741:	68 de 00 00 00       	push   $0xde
80106746:	e9 34 f2 ff ff       	jmp    8010597f <alltraps>

8010674b <vector223>:
8010674b:	6a 00                	push   $0x0
8010674d:	68 df 00 00 00       	push   $0xdf
80106752:	e9 28 f2 ff ff       	jmp    8010597f <alltraps>

80106757 <vector224>:
80106757:	6a 00                	push   $0x0
80106759:	68 e0 00 00 00       	push   $0xe0
8010675e:	e9 1c f2 ff ff       	jmp    8010597f <alltraps>

80106763 <vector225>:
80106763:	6a 00                	push   $0x0
80106765:	68 e1 00 00 00       	push   $0xe1
8010676a:	e9 10 f2 ff ff       	jmp    8010597f <alltraps>

8010676f <vector226>:
8010676f:	6a 00                	push   $0x0
80106771:	68 e2 00 00 00       	push   $0xe2
80106776:	e9 04 f2 ff ff       	jmp    8010597f <alltraps>

8010677b <vector227>:
8010677b:	6a 00                	push   $0x0
8010677d:	68 e3 00 00 00       	push   $0xe3
80106782:	e9 f8 f1 ff ff       	jmp    8010597f <alltraps>

80106787 <vector228>:
80106787:	6a 00                	push   $0x0
80106789:	68 e4 00 00 00       	push   $0xe4
8010678e:	e9 ec f1 ff ff       	jmp    8010597f <alltraps>

80106793 <vector229>:
80106793:	6a 00                	push   $0x0
80106795:	68 e5 00 00 00       	push   $0xe5
8010679a:	e9 e0 f1 ff ff       	jmp    8010597f <alltraps>

8010679f <vector230>:
8010679f:	6a 00                	push   $0x0
801067a1:	68 e6 00 00 00       	push   $0xe6
801067a6:	e9 d4 f1 ff ff       	jmp    8010597f <alltraps>

801067ab <vector231>:
801067ab:	6a 00                	push   $0x0
801067ad:	68 e7 00 00 00       	push   $0xe7
801067b2:	e9 c8 f1 ff ff       	jmp    8010597f <alltraps>

801067b7 <vector232>:
801067b7:	6a 00                	push   $0x0
801067b9:	68 e8 00 00 00       	push   $0xe8
801067be:	e9 bc f1 ff ff       	jmp    8010597f <alltraps>

801067c3 <vector233>:
801067c3:	6a 00                	push   $0x0
801067c5:	68 e9 00 00 00       	push   $0xe9
801067ca:	e9 b0 f1 ff ff       	jmp    8010597f <alltraps>

801067cf <vector234>:
801067cf:	6a 00                	push   $0x0
801067d1:	68 ea 00 00 00       	push   $0xea
801067d6:	e9 a4 f1 ff ff       	jmp    8010597f <alltraps>

801067db <vector235>:
801067db:	6a 00                	push   $0x0
801067dd:	68 eb 00 00 00       	push   $0xeb
801067e2:	e9 98 f1 ff ff       	jmp    8010597f <alltraps>

801067e7 <vector236>:
801067e7:	6a 00                	push   $0x0
801067e9:	68 ec 00 00 00       	push   $0xec
801067ee:	e9 8c f1 ff ff       	jmp    8010597f <alltraps>

801067f3 <vector237>:
801067f3:	6a 00                	push   $0x0
801067f5:	68 ed 00 00 00       	push   $0xed
801067fa:	e9 80 f1 ff ff       	jmp    8010597f <alltraps>

801067ff <vector238>:
801067ff:	6a 00                	push   $0x0
80106801:	68 ee 00 00 00       	push   $0xee
80106806:	e9 74 f1 ff ff       	jmp    8010597f <alltraps>

8010680b <vector239>:
8010680b:	6a 00                	push   $0x0
8010680d:	68 ef 00 00 00       	push   $0xef
80106812:	e9 68 f1 ff ff       	jmp    8010597f <alltraps>

80106817 <vector240>:
80106817:	6a 00                	push   $0x0
80106819:	68 f0 00 00 00       	push   $0xf0
8010681e:	e9 5c f1 ff ff       	jmp    8010597f <alltraps>

80106823 <vector241>:
80106823:	6a 00                	push   $0x0
80106825:	68 f1 00 00 00       	push   $0xf1
8010682a:	e9 50 f1 ff ff       	jmp    8010597f <alltraps>

8010682f <vector242>:
8010682f:	6a 00                	push   $0x0
80106831:	68 f2 00 00 00       	push   $0xf2
80106836:	e9 44 f1 ff ff       	jmp    8010597f <alltraps>

8010683b <vector243>:
8010683b:	6a 00                	push   $0x0
8010683d:	68 f3 00 00 00       	push   $0xf3
80106842:	e9 38 f1 ff ff       	jmp    8010597f <alltraps>

80106847 <vector244>:
80106847:	6a 00                	push   $0x0
80106849:	68 f4 00 00 00       	push   $0xf4
8010684e:	e9 2c f1 ff ff       	jmp    8010597f <alltraps>

80106853 <vector245>:
80106853:	6a 00                	push   $0x0
80106855:	68 f5 00 00 00       	push   $0xf5
8010685a:	e9 20 f1 ff ff       	jmp    8010597f <alltraps>

8010685f <vector246>:
8010685f:	6a 00                	push   $0x0
80106861:	68 f6 00 00 00       	push   $0xf6
80106866:	e9 14 f1 ff ff       	jmp    8010597f <alltraps>

8010686b <vector247>:
8010686b:	6a 00                	push   $0x0
8010686d:	68 f7 00 00 00       	push   $0xf7
80106872:	e9 08 f1 ff ff       	jmp    8010597f <alltraps>

80106877 <vector248>:
80106877:	6a 00                	push   $0x0
80106879:	68 f8 00 00 00       	push   $0xf8
8010687e:	e9 fc f0 ff ff       	jmp    8010597f <alltraps>

80106883 <vector249>:
80106883:	6a 00                	push   $0x0
80106885:	68 f9 00 00 00       	push   $0xf9
8010688a:	e9 f0 f0 ff ff       	jmp    8010597f <alltraps>

8010688f <vector250>:
8010688f:	6a 00                	push   $0x0
80106891:	68 fa 00 00 00       	push   $0xfa
80106896:	e9 e4 f0 ff ff       	jmp    8010597f <alltraps>

8010689b <vector251>:
8010689b:	6a 00                	push   $0x0
8010689d:	68 fb 00 00 00       	push   $0xfb
801068a2:	e9 d8 f0 ff ff       	jmp    8010597f <alltraps>

801068a7 <vector252>:
801068a7:	6a 00                	push   $0x0
801068a9:	68 fc 00 00 00       	push   $0xfc
801068ae:	e9 cc f0 ff ff       	jmp    8010597f <alltraps>

801068b3 <vector253>:
801068b3:	6a 00                	push   $0x0
801068b5:	68 fd 00 00 00       	push   $0xfd
801068ba:	e9 c0 f0 ff ff       	jmp    8010597f <alltraps>

801068bf <vector254>:
801068bf:	6a 00                	push   $0x0
801068c1:	68 fe 00 00 00       	push   $0xfe
801068c6:	e9 b4 f0 ff ff       	jmp    8010597f <alltraps>

801068cb <vector255>:
801068cb:	6a 00                	push   $0x0
801068cd:	68 ff 00 00 00       	push   $0xff
801068d2:	e9 a8 f0 ff ff       	jmp    8010597f <alltraps>
801068d7:	66 90                	xchg   %ax,%ax
801068d9:	66 90                	xchg   %ax,%ax
801068db:	66 90                	xchg   %ax,%ax
801068dd:	66 90                	xchg   %ax,%ax
801068df:	90                   	nop

801068e0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	57                   	push   %edi
801068e4:	56                   	push   %esi
801068e5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068e6:	89 d3                	mov    %edx,%ebx
{
801068e8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
801068ea:	c1 eb 16             	shr    $0x16,%ebx
801068ed:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801068f0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801068f3:	8b 06                	mov    (%esi),%eax
801068f5:	a8 01                	test   $0x1,%al
801068f7:	74 27                	je     80106920 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068fe:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106904:	c1 ef 0a             	shr    $0xa,%edi
}
80106907:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010690a:	89 fa                	mov    %edi,%edx
8010690c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106912:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106915:	5b                   	pop    %ebx
80106916:	5e                   	pop    %esi
80106917:	5f                   	pop    %edi
80106918:	5d                   	pop    %ebp
80106919:	c3                   	ret    
8010691a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106920:	85 c9                	test   %ecx,%ecx
80106922:	74 2c                	je     80106950 <walkpgdir+0x70>
80106924:	e8 97 bb ff ff       	call   801024c0 <kalloc>
80106929:	85 c0                	test   %eax,%eax
8010692b:	89 c3                	mov    %eax,%ebx
8010692d:	74 21                	je     80106950 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010692f:	83 ec 04             	sub    $0x4,%esp
80106932:	68 00 10 00 00       	push   $0x1000
80106937:	6a 00                	push   $0x0
80106939:	50                   	push   %eax
8010693a:	e8 71 dd ff ff       	call   801046b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010693f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106945:	83 c4 10             	add    $0x10,%esp
80106948:	83 c8 07             	or     $0x7,%eax
8010694b:	89 06                	mov    %eax,(%esi)
8010694d:	eb b5                	jmp    80106904 <walkpgdir+0x24>
8010694f:	90                   	nop
}
80106950:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106953:	31 c0                	xor    %eax,%eax
}
80106955:	5b                   	pop    %ebx
80106956:	5e                   	pop    %esi
80106957:	5f                   	pop    %edi
80106958:	5d                   	pop    %ebp
80106959:	c3                   	ret    
8010695a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106960 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106960:	55                   	push   %ebp
80106961:	89 e5                	mov    %esp,%ebp
80106963:	57                   	push   %edi
80106964:	56                   	push   %esi
80106965:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106966:	89 d3                	mov    %edx,%ebx
80106968:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010696e:	83 ec 1c             	sub    $0x1c,%esp
80106971:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106974:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106978:	8b 7d 08             	mov    0x8(%ebp),%edi
8010697b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106980:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106983:	8b 45 0c             	mov    0xc(%ebp),%eax
80106986:	29 df                	sub    %ebx,%edi
80106988:	83 c8 01             	or     $0x1,%eax
8010698b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010698e:	eb 15                	jmp    801069a5 <mappages+0x45>
    if(*pte & PTE_P)
80106990:	f6 00 01             	testb  $0x1,(%eax)
80106993:	75 45                	jne    801069da <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106995:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106998:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010699b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010699d:	74 31                	je     801069d0 <mappages+0x70>
      break;
    a += PGSIZE;
8010699f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069a8:	b9 01 00 00 00       	mov    $0x1,%ecx
801069ad:	89 da                	mov    %ebx,%edx
801069af:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801069b2:	e8 29 ff ff ff       	call   801068e0 <walkpgdir>
801069b7:	85 c0                	test   %eax,%eax
801069b9:	75 d5                	jne    80106990 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801069bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801069be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069c3:	5b                   	pop    %ebx
801069c4:	5e                   	pop    %esi
801069c5:	5f                   	pop    %edi
801069c6:	5d                   	pop    %ebp
801069c7:	c3                   	ret    
801069c8:	90                   	nop
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801069d3:	31 c0                	xor    %eax,%eax
}
801069d5:	5b                   	pop    %ebx
801069d6:	5e                   	pop    %esi
801069d7:	5f                   	pop    %edi
801069d8:	5d                   	pop    %ebp
801069d9:	c3                   	ret    
      panic("remap");
801069da:	83 ec 0c             	sub    $0xc,%esp
801069dd:	68 fc 7a 10 80       	push   $0x80107afc
801069e2:	e8 a9 99 ff ff       	call   80100390 <panic>
801069e7:	89 f6                	mov    %esi,%esi
801069e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069f0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069f0:	55                   	push   %ebp
801069f1:	89 e5                	mov    %esp,%ebp
801069f3:	57                   	push   %edi
801069f4:	56                   	push   %esi
801069f5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069f6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069fc:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
801069fe:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a04:	83 ec 1c             	sub    $0x1c,%esp
80106a07:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106a0a:	39 d3                	cmp    %edx,%ebx
80106a0c:	73 66                	jae    80106a74 <deallocuvm.part.0+0x84>
80106a0e:	89 d6                	mov    %edx,%esi
80106a10:	eb 3d                	jmp    80106a4f <deallocuvm.part.0+0x5f>
80106a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a18:	8b 10                	mov    (%eax),%edx
80106a1a:	f6 c2 01             	test   $0x1,%dl
80106a1d:	74 26                	je     80106a45 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a1f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a25:	74 58                	je     80106a7f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a27:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106a2a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a30:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106a33:	52                   	push   %edx
80106a34:	e8 d7 b8 ff ff       	call   80102310 <kfree>
      *pte = 0;
80106a39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a3c:	83 c4 10             	add    $0x10,%esp
80106a3f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106a45:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a4b:	39 f3                	cmp    %esi,%ebx
80106a4d:	73 25                	jae    80106a74 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a4f:	31 c9                	xor    %ecx,%ecx
80106a51:	89 da                	mov    %ebx,%edx
80106a53:	89 f8                	mov    %edi,%eax
80106a55:	e8 86 fe ff ff       	call   801068e0 <walkpgdir>
    if(!pte)
80106a5a:	85 c0                	test   %eax,%eax
80106a5c:	75 ba                	jne    80106a18 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a5e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a64:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106a6a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a70:	39 f3                	cmp    %esi,%ebx
80106a72:	72 db                	jb     80106a4f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106a74:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a7a:	5b                   	pop    %ebx
80106a7b:	5e                   	pop    %esi
80106a7c:	5f                   	pop    %edi
80106a7d:	5d                   	pop    %ebp
80106a7e:	c3                   	ret    
        panic("kfree");
80106a7f:	83 ec 0c             	sub    $0xc,%esp
80106a82:	68 86 74 10 80       	push   $0x80107486
80106a87:	e8 04 99 ff ff       	call   80100390 <panic>
80106a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a90 <seginit>:
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a96:	e8 25 cd ff ff       	call   801037c0 <cpuid>
80106a9b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106aa1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106aa6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106aaa:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106ab1:	ff 00 00 
80106ab4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106abb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106abe:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106ac5:	ff 00 00 
80106ac8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106acf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ad2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106ad9:	ff 00 00 
80106adc:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106ae3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ae6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106aed:	ff 00 00 
80106af0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106af7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106afa:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
80106aff:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b03:	c1 e8 10             	shr    $0x10,%eax
80106b06:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106b0a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b0d:	0f 01 10             	lgdtl  (%eax)
}
80106b10:	c9                   	leave  
80106b11:	c3                   	ret    
80106b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b20 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b20:	a1 c4 54 11 80       	mov    0x801154c4,%eax
{
80106b25:	55                   	push   %ebp
80106b26:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b28:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b2d:	0f 22 d8             	mov    %eax,%cr3
}
80106b30:	5d                   	pop    %ebp
80106b31:	c3                   	ret    
80106b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b40 <switchuvm>:
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	57                   	push   %edi
80106b44:	56                   	push   %esi
80106b45:	53                   	push   %ebx
80106b46:	83 ec 1c             	sub    $0x1c,%esp
80106b49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106b4c:	85 db                	test   %ebx,%ebx
80106b4e:	0f 84 cb 00 00 00    	je     80106c1f <switchuvm+0xdf>
  if(p->kstack == 0)
80106b54:	8b 43 08             	mov    0x8(%ebx),%eax
80106b57:	85 c0                	test   %eax,%eax
80106b59:	0f 84 da 00 00 00    	je     80106c39 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106b5f:	8b 43 04             	mov    0x4(%ebx),%eax
80106b62:	85 c0                	test   %eax,%eax
80106b64:	0f 84 c2 00 00 00    	je     80106c2c <switchuvm+0xec>
  pushcli();
80106b6a:	e8 31 d8 ff ff       	call   801043a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b6f:	e8 cc cb ff ff       	call   80103740 <mycpu>
80106b74:	89 c6                	mov    %eax,%esi
80106b76:	e8 c5 cb ff ff       	call   80103740 <mycpu>
80106b7b:	89 c7                	mov    %eax,%edi
80106b7d:	e8 be cb ff ff       	call   80103740 <mycpu>
80106b82:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b85:	83 c7 08             	add    $0x8,%edi
80106b88:	e8 b3 cb ff ff       	call   80103740 <mycpu>
80106b8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b90:	83 c0 08             	add    $0x8,%eax
80106b93:	ba 67 00 00 00       	mov    $0x67,%edx
80106b98:	c1 e8 18             	shr    $0x18,%eax
80106b9b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106ba2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106ba9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106baf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bb4:	83 c1 08             	add    $0x8,%ecx
80106bb7:	c1 e9 10             	shr    $0x10,%ecx
80106bba:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106bc0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106bc5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bcc:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106bd1:	e8 6a cb ff ff       	call   80103740 <mycpu>
80106bd6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bdd:	e8 5e cb ff ff       	call   80103740 <mycpu>
80106be2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106be6:	8b 73 08             	mov    0x8(%ebx),%esi
80106be9:	e8 52 cb ff ff       	call   80103740 <mycpu>
80106bee:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106bf4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bf7:	e8 44 cb ff ff       	call   80103740 <mycpu>
80106bfc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106c00:	b8 28 00 00 00       	mov    $0x28,%eax
80106c05:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106c08:	8b 43 04             	mov    0x4(%ebx),%eax
80106c0b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c10:	0f 22 d8             	mov    %eax,%cr3
}
80106c13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c16:	5b                   	pop    %ebx
80106c17:	5e                   	pop    %esi
80106c18:	5f                   	pop    %edi
80106c19:	5d                   	pop    %ebp
  popcli();
80106c1a:	e9 c1 d7 ff ff       	jmp    801043e0 <popcli>
    panic("switchuvm: no process");
80106c1f:	83 ec 0c             	sub    $0xc,%esp
80106c22:	68 02 7b 10 80       	push   $0x80107b02
80106c27:	e8 64 97 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106c2c:	83 ec 0c             	sub    $0xc,%esp
80106c2f:	68 2d 7b 10 80       	push   $0x80107b2d
80106c34:	e8 57 97 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106c39:	83 ec 0c             	sub    $0xc,%esp
80106c3c:	68 18 7b 10 80       	push   $0x80107b18
80106c41:	e8 4a 97 ff ff       	call   80100390 <panic>
80106c46:	8d 76 00             	lea    0x0(%esi),%esi
80106c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c50 <inituvm>:
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	57                   	push   %edi
80106c54:	56                   	push   %esi
80106c55:	53                   	push   %ebx
80106c56:	83 ec 1c             	sub    $0x1c,%esp
80106c59:	8b 75 10             	mov    0x10(%ebp),%esi
80106c5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106c62:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106c68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106c6b:	77 49                	ja     80106cb6 <inituvm+0x66>
  mem = kalloc();
80106c6d:	e8 4e b8 ff ff       	call   801024c0 <kalloc>
  memset(mem, 0, PGSIZE);
80106c72:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106c75:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c77:	68 00 10 00 00       	push   $0x1000
80106c7c:	6a 00                	push   $0x0
80106c7e:	50                   	push   %eax
80106c7f:	e8 2c da ff ff       	call   801046b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c84:	58                   	pop    %eax
80106c85:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c8b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c90:	5a                   	pop    %edx
80106c91:	6a 06                	push   $0x6
80106c93:	50                   	push   %eax
80106c94:	31 d2                	xor    %edx,%edx
80106c96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c99:	e8 c2 fc ff ff       	call   80106960 <mappages>
  memmove(mem, init, sz);
80106c9e:	89 75 10             	mov    %esi,0x10(%ebp)
80106ca1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106ca4:	83 c4 10             	add    $0x10,%esp
80106ca7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106caa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cad:	5b                   	pop    %ebx
80106cae:	5e                   	pop    %esi
80106caf:	5f                   	pop    %edi
80106cb0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106cb1:	e9 aa da ff ff       	jmp    80104760 <memmove>
    panic("inituvm: more than a page");
80106cb6:	83 ec 0c             	sub    $0xc,%esp
80106cb9:	68 41 7b 10 80       	push   $0x80107b41
80106cbe:	e8 cd 96 ff ff       	call   80100390 <panic>
80106cc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cd0 <loaduvm>:
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	57                   	push   %edi
80106cd4:	56                   	push   %esi
80106cd5:	53                   	push   %ebx
80106cd6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106cd9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106ce0:	0f 85 91 00 00 00    	jne    80106d77 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106ce6:	8b 75 18             	mov    0x18(%ebp),%esi
80106ce9:	31 db                	xor    %ebx,%ebx
80106ceb:	85 f6                	test   %esi,%esi
80106ced:	75 1a                	jne    80106d09 <loaduvm+0x39>
80106cef:	eb 6f                	jmp    80106d60 <loaduvm+0x90>
80106cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cf8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cfe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d04:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d07:	76 57                	jbe    80106d60 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d09:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d0c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0f:	31 c9                	xor    %ecx,%ecx
80106d11:	01 da                	add    %ebx,%edx
80106d13:	e8 c8 fb ff ff       	call   801068e0 <walkpgdir>
80106d18:	85 c0                	test   %eax,%eax
80106d1a:	74 4e                	je     80106d6a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106d1c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d1e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106d21:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106d26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d2b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d31:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d34:	01 d9                	add    %ebx,%ecx
80106d36:	05 00 00 00 80       	add    $0x80000000,%eax
80106d3b:	57                   	push   %edi
80106d3c:	51                   	push   %ecx
80106d3d:	50                   	push   %eax
80106d3e:	ff 75 10             	pushl  0x10(%ebp)
80106d41:	e8 1a ac ff ff       	call   80101960 <readi>
80106d46:	83 c4 10             	add    $0x10,%esp
80106d49:	39 f8                	cmp    %edi,%eax
80106d4b:	74 ab                	je     80106cf8 <loaduvm+0x28>
}
80106d4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d55:	5b                   	pop    %ebx
80106d56:	5e                   	pop    %esi
80106d57:	5f                   	pop    %edi
80106d58:	5d                   	pop    %ebp
80106d59:	c3                   	ret    
80106d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d60:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106d63:	31 c0                	xor    %eax,%eax
}
80106d65:	5b                   	pop    %ebx
80106d66:	5e                   	pop    %esi
80106d67:	5f                   	pop    %edi
80106d68:	5d                   	pop    %ebp
80106d69:	c3                   	ret    
      panic("loaduvm: address should exist");
80106d6a:	83 ec 0c             	sub    $0xc,%esp
80106d6d:	68 5b 7b 10 80       	push   $0x80107b5b
80106d72:	e8 19 96 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106d77:	83 ec 0c             	sub    $0xc,%esp
80106d7a:	68 fc 7b 10 80       	push   $0x80107bfc
80106d7f:	e8 0c 96 ff ff       	call   80100390 <panic>
80106d84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d90 <allocuvm>:
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106d99:	8b 7d 10             	mov    0x10(%ebp),%edi
80106d9c:	85 ff                	test   %edi,%edi
80106d9e:	0f 88 8e 00 00 00    	js     80106e32 <allocuvm+0xa2>
  if(newsz < oldsz)
80106da4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106da7:	0f 82 93 00 00 00    	jb     80106e40 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106dad:	8b 45 0c             	mov    0xc(%ebp),%eax
80106db0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106db6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106dbc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106dbf:	0f 86 7e 00 00 00    	jbe    80106e43 <allocuvm+0xb3>
80106dc5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106dc8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106dcb:	eb 42                	jmp    80106e0f <allocuvm+0x7f>
80106dcd:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106dd0:	83 ec 04             	sub    $0x4,%esp
80106dd3:	68 00 10 00 00       	push   $0x1000
80106dd8:	6a 00                	push   $0x0
80106dda:	50                   	push   %eax
80106ddb:	e8 d0 d8 ff ff       	call   801046b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106de0:	58                   	pop    %eax
80106de1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106de7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dec:	5a                   	pop    %edx
80106ded:	6a 06                	push   $0x6
80106def:	50                   	push   %eax
80106df0:	89 da                	mov    %ebx,%edx
80106df2:	89 f8                	mov    %edi,%eax
80106df4:	e8 67 fb ff ff       	call   80106960 <mappages>
80106df9:	83 c4 10             	add    $0x10,%esp
80106dfc:	85 c0                	test   %eax,%eax
80106dfe:	78 50                	js     80106e50 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106e00:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e06:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106e09:	0f 86 81 00 00 00    	jbe    80106e90 <allocuvm+0x100>
    mem = kalloc();
80106e0f:	e8 ac b6 ff ff       	call   801024c0 <kalloc>
    if(mem == 0){
80106e14:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106e16:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e18:	75 b6                	jne    80106dd0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106e1a:	83 ec 0c             	sub    $0xc,%esp
80106e1d:	68 79 7b 10 80       	push   $0x80107b79
80106e22:	e8 39 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106e27:	83 c4 10             	add    $0x10,%esp
80106e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e2d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106e30:	77 6e                	ja     80106ea0 <allocuvm+0x110>
}
80106e32:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106e35:	31 ff                	xor    %edi,%edi
}
80106e37:	89 f8                	mov    %edi,%eax
80106e39:	5b                   	pop    %ebx
80106e3a:	5e                   	pop    %esi
80106e3b:	5f                   	pop    %edi
80106e3c:	5d                   	pop    %ebp
80106e3d:	c3                   	ret    
80106e3e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106e40:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106e43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e46:	89 f8                	mov    %edi,%eax
80106e48:	5b                   	pop    %ebx
80106e49:	5e                   	pop    %esi
80106e4a:	5f                   	pop    %edi
80106e4b:	5d                   	pop    %ebp
80106e4c:	c3                   	ret    
80106e4d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	68 91 7b 10 80       	push   $0x80107b91
80106e58:	e8 03 98 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106e5d:	83 c4 10             	add    $0x10,%esp
80106e60:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e63:	39 45 10             	cmp    %eax,0x10(%ebp)
80106e66:	76 0d                	jbe    80106e75 <allocuvm+0xe5>
80106e68:	89 c1                	mov    %eax,%ecx
80106e6a:	8b 55 10             	mov    0x10(%ebp),%edx
80106e6d:	8b 45 08             	mov    0x8(%ebp),%eax
80106e70:	e8 7b fb ff ff       	call   801069f0 <deallocuvm.part.0>
      kfree(mem);
80106e75:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106e78:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106e7a:	56                   	push   %esi
80106e7b:	e8 90 b4 ff ff       	call   80102310 <kfree>
      return 0;
80106e80:	83 c4 10             	add    $0x10,%esp
}
80106e83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e86:	89 f8                	mov    %edi,%eax
80106e88:	5b                   	pop    %ebx
80106e89:	5e                   	pop    %esi
80106e8a:	5f                   	pop    %edi
80106e8b:	5d                   	pop    %ebp
80106e8c:	c3                   	ret    
80106e8d:	8d 76 00             	lea    0x0(%esi),%esi
80106e90:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106e93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e96:	5b                   	pop    %ebx
80106e97:	89 f8                	mov    %edi,%eax
80106e99:	5e                   	pop    %esi
80106e9a:	5f                   	pop    %edi
80106e9b:	5d                   	pop    %ebp
80106e9c:	c3                   	ret    
80106e9d:	8d 76 00             	lea    0x0(%esi),%esi
80106ea0:	89 c1                	mov    %eax,%ecx
80106ea2:	8b 55 10             	mov    0x10(%ebp),%edx
80106ea5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106ea8:	31 ff                	xor    %edi,%edi
80106eaa:	e8 41 fb ff ff       	call   801069f0 <deallocuvm.part.0>
80106eaf:	eb 92                	jmp    80106e43 <allocuvm+0xb3>
80106eb1:	eb 0d                	jmp    80106ec0 <deallocuvm>
80106eb3:	90                   	nop
80106eb4:	90                   	nop
80106eb5:	90                   	nop
80106eb6:	90                   	nop
80106eb7:	90                   	nop
80106eb8:	90                   	nop
80106eb9:	90                   	nop
80106eba:	90                   	nop
80106ebb:	90                   	nop
80106ebc:	90                   	nop
80106ebd:	90                   	nop
80106ebe:	90                   	nop
80106ebf:	90                   	nop

80106ec0 <deallocuvm>:
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ec6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106ecc:	39 d1                	cmp    %edx,%ecx
80106ece:	73 10                	jae    80106ee0 <deallocuvm+0x20>
}
80106ed0:	5d                   	pop    %ebp
80106ed1:	e9 1a fb ff ff       	jmp    801069f0 <deallocuvm.part.0>
80106ed6:	8d 76 00             	lea    0x0(%esi),%esi
80106ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ee0:	89 d0                	mov    %edx,%eax
80106ee2:	5d                   	pop    %ebp
80106ee3:	c3                   	ret    
80106ee4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ef0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	53                   	push   %ebx
80106ef6:	83 ec 0c             	sub    $0xc,%esp
80106ef9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106efc:	85 f6                	test   %esi,%esi
80106efe:	74 59                	je     80106f59 <freevm+0x69>
80106f00:	31 c9                	xor    %ecx,%ecx
80106f02:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f07:	89 f0                	mov    %esi,%eax
80106f09:	e8 e2 fa ff ff       	call   801069f0 <deallocuvm.part.0>
80106f0e:	89 f3                	mov    %esi,%ebx
80106f10:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f16:	eb 0f                	jmp    80106f27 <freevm+0x37>
80106f18:	90                   	nop
80106f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f20:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f23:	39 fb                	cmp    %edi,%ebx
80106f25:	74 23                	je     80106f4a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f27:	8b 03                	mov    (%ebx),%eax
80106f29:	a8 01                	test   $0x1,%al
80106f2b:	74 f3                	je     80106f20 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106f32:	83 ec 0c             	sub    $0xc,%esp
80106f35:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f38:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106f3d:	50                   	push   %eax
80106f3e:	e8 cd b3 ff ff       	call   80102310 <kfree>
80106f43:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106f46:	39 fb                	cmp    %edi,%ebx
80106f48:	75 dd                	jne    80106f27 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106f4a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f50:	5b                   	pop    %ebx
80106f51:	5e                   	pop    %esi
80106f52:	5f                   	pop    %edi
80106f53:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106f54:	e9 b7 b3 ff ff       	jmp    80102310 <kfree>
    panic("freevm: no pgdir");
80106f59:	83 ec 0c             	sub    $0xc,%esp
80106f5c:	68 ad 7b 10 80       	push   $0x80107bad
80106f61:	e8 2a 94 ff ff       	call   80100390 <panic>
80106f66:	8d 76 00             	lea    0x0(%esi),%esi
80106f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f70 <setupkvm>:
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	56                   	push   %esi
80106f74:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106f75:	e8 46 b5 ff ff       	call   801024c0 <kalloc>
80106f7a:	85 c0                	test   %eax,%eax
80106f7c:	89 c6                	mov    %eax,%esi
80106f7e:	74 42                	je     80106fc2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106f80:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f83:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f88:	68 00 10 00 00       	push   $0x1000
80106f8d:	6a 00                	push   $0x0
80106f8f:	50                   	push   %eax
80106f90:	e8 1b d7 ff ff       	call   801046b0 <memset>
80106f95:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106f98:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f9b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f9e:	83 ec 08             	sub    $0x8,%esp
80106fa1:	8b 13                	mov    (%ebx),%edx
80106fa3:	ff 73 0c             	pushl  0xc(%ebx)
80106fa6:	50                   	push   %eax
80106fa7:	29 c1                	sub    %eax,%ecx
80106fa9:	89 f0                	mov    %esi,%eax
80106fab:	e8 b0 f9 ff ff       	call   80106960 <mappages>
80106fb0:	83 c4 10             	add    $0x10,%esp
80106fb3:	85 c0                	test   %eax,%eax
80106fb5:	78 19                	js     80106fd0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fb7:	83 c3 10             	add    $0x10,%ebx
80106fba:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106fc0:	75 d6                	jne    80106f98 <setupkvm+0x28>
}
80106fc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fc5:	89 f0                	mov    %esi,%eax
80106fc7:	5b                   	pop    %ebx
80106fc8:	5e                   	pop    %esi
80106fc9:	5d                   	pop    %ebp
80106fca:	c3                   	ret    
80106fcb:	90                   	nop
80106fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106fd0:	83 ec 0c             	sub    $0xc,%esp
80106fd3:	56                   	push   %esi
      return 0;
80106fd4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106fd6:	e8 15 ff ff ff       	call   80106ef0 <freevm>
      return 0;
80106fdb:	83 c4 10             	add    $0x10,%esp
}
80106fde:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fe1:	89 f0                	mov    %esi,%eax
80106fe3:	5b                   	pop    %ebx
80106fe4:	5e                   	pop    %esi
80106fe5:	5d                   	pop    %ebp
80106fe6:	c3                   	ret    
80106fe7:	89 f6                	mov    %esi,%esi
80106fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ff0 <kvmalloc>:
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106ff6:	e8 75 ff ff ff       	call   80106f70 <setupkvm>
80106ffb:	a3 c4 54 11 80       	mov    %eax,0x801154c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107000:	05 00 00 00 80       	add    $0x80000000,%eax
80107005:	0f 22 d8             	mov    %eax,%cr3
}
80107008:	c9                   	leave  
80107009:	c3                   	ret    
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107010 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107010:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107011:	31 c9                	xor    %ecx,%ecx
{
80107013:	89 e5                	mov    %esp,%ebp
80107015:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107018:	8b 55 0c             	mov    0xc(%ebp),%edx
8010701b:	8b 45 08             	mov    0x8(%ebp),%eax
8010701e:	e8 bd f8 ff ff       	call   801068e0 <walkpgdir>
  if(pte == 0)
80107023:	85 c0                	test   %eax,%eax
80107025:	74 05                	je     8010702c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107027:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010702a:	c9                   	leave  
8010702b:	c3                   	ret    
    panic("clearpteu");
8010702c:	83 ec 0c             	sub    $0xc,%esp
8010702f:	68 be 7b 10 80       	push   $0x80107bbe
80107034:	e8 57 93 ff ff       	call   80100390 <panic>
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107040 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	57                   	push   %edi
80107044:	56                   	push   %esi
80107045:	53                   	push   %ebx
80107046:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107049:	e8 22 ff ff ff       	call   80106f70 <setupkvm>
8010704e:	85 c0                	test   %eax,%eax
80107050:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107053:	0f 84 9f 00 00 00    	je     801070f8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107059:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010705c:	85 c9                	test   %ecx,%ecx
8010705e:	0f 84 94 00 00 00    	je     801070f8 <copyuvm+0xb8>
80107064:	31 ff                	xor    %edi,%edi
80107066:	eb 4a                	jmp    801070b2 <copyuvm+0x72>
80107068:	90                   	nop
80107069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107070:	83 ec 04             	sub    $0x4,%esp
80107073:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107079:	68 00 10 00 00       	push   $0x1000
8010707e:	53                   	push   %ebx
8010707f:	50                   	push   %eax
80107080:	e8 db d6 ff ff       	call   80104760 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107085:	58                   	pop    %eax
80107086:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010708c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107091:	5a                   	pop    %edx
80107092:	ff 75 e4             	pushl  -0x1c(%ebp)
80107095:	50                   	push   %eax
80107096:	89 fa                	mov    %edi,%edx
80107098:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010709b:	e8 c0 f8 ff ff       	call   80106960 <mappages>
801070a0:	83 c4 10             	add    $0x10,%esp
801070a3:	85 c0                	test   %eax,%eax
801070a5:	78 61                	js     80107108 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801070a7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801070ad:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801070b0:	76 46                	jbe    801070f8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801070b2:	8b 45 08             	mov    0x8(%ebp),%eax
801070b5:	31 c9                	xor    %ecx,%ecx
801070b7:	89 fa                	mov    %edi,%edx
801070b9:	e8 22 f8 ff ff       	call   801068e0 <walkpgdir>
801070be:	85 c0                	test   %eax,%eax
801070c0:	74 61                	je     80107123 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801070c2:	8b 00                	mov    (%eax),%eax
801070c4:	a8 01                	test   $0x1,%al
801070c6:	74 4e                	je     80107116 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801070c8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801070ca:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801070cf:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801070d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801070d8:	e8 e3 b3 ff ff       	call   801024c0 <kalloc>
801070dd:	85 c0                	test   %eax,%eax
801070df:	89 c6                	mov    %eax,%esi
801070e1:	75 8d                	jne    80107070 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801070e3:	83 ec 0c             	sub    $0xc,%esp
801070e6:	ff 75 e0             	pushl  -0x20(%ebp)
801070e9:	e8 02 fe ff ff       	call   80106ef0 <freevm>
  return 0;
801070ee:	83 c4 10             	add    $0x10,%esp
801070f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801070f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070fe:	5b                   	pop    %ebx
801070ff:	5e                   	pop    %esi
80107100:	5f                   	pop    %edi
80107101:	5d                   	pop    %ebp
80107102:	c3                   	ret    
80107103:	90                   	nop
80107104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107108:	83 ec 0c             	sub    $0xc,%esp
8010710b:	56                   	push   %esi
8010710c:	e8 ff b1 ff ff       	call   80102310 <kfree>
      goto bad;
80107111:	83 c4 10             	add    $0x10,%esp
80107114:	eb cd                	jmp    801070e3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107116:	83 ec 0c             	sub    $0xc,%esp
80107119:	68 e2 7b 10 80       	push   $0x80107be2
8010711e:	e8 6d 92 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107123:	83 ec 0c             	sub    $0xc,%esp
80107126:	68 c8 7b 10 80       	push   $0x80107bc8
8010712b:	e8 60 92 ff ff       	call   80100390 <panic>

80107130 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107130:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107131:	31 c9                	xor    %ecx,%ecx
{
80107133:	89 e5                	mov    %esp,%ebp
80107135:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107138:	8b 55 0c             	mov    0xc(%ebp),%edx
8010713b:	8b 45 08             	mov    0x8(%ebp),%eax
8010713e:	e8 9d f7 ff ff       	call   801068e0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107143:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107145:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107146:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107148:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010714d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107150:	05 00 00 00 80       	add    $0x80000000,%eax
80107155:	83 fa 05             	cmp    $0x5,%edx
80107158:	ba 00 00 00 00       	mov    $0x0,%edx
8010715d:	0f 45 c2             	cmovne %edx,%eax
}
80107160:	c3                   	ret    
80107161:	eb 0d                	jmp    80107170 <copyout>
80107163:	90                   	nop
80107164:	90                   	nop
80107165:	90                   	nop
80107166:	90                   	nop
80107167:	90                   	nop
80107168:	90                   	nop
80107169:	90                   	nop
8010716a:	90                   	nop
8010716b:	90                   	nop
8010716c:	90                   	nop
8010716d:	90                   	nop
8010716e:	90                   	nop
8010716f:	90                   	nop

80107170 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 1c             	sub    $0x1c,%esp
80107179:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010717c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010717f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107182:	85 db                	test   %ebx,%ebx
80107184:	75 40                	jne    801071c6 <copyout+0x56>
80107186:	eb 70                	jmp    801071f8 <copyout+0x88>
80107188:	90                   	nop
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107190:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107193:	89 f1                	mov    %esi,%ecx
80107195:	29 d1                	sub    %edx,%ecx
80107197:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010719d:	39 d9                	cmp    %ebx,%ecx
8010719f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801071a2:	29 f2                	sub    %esi,%edx
801071a4:	83 ec 04             	sub    $0x4,%esp
801071a7:	01 d0                	add    %edx,%eax
801071a9:	51                   	push   %ecx
801071aa:	57                   	push   %edi
801071ab:	50                   	push   %eax
801071ac:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801071af:	e8 ac d5 ff ff       	call   80104760 <memmove>
    len -= n;
    buf += n;
801071b4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801071b7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801071ba:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801071c0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801071c2:	29 cb                	sub    %ecx,%ebx
801071c4:	74 32                	je     801071f8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801071c6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071c8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801071cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801071ce:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071d4:	56                   	push   %esi
801071d5:	ff 75 08             	pushl  0x8(%ebp)
801071d8:	e8 53 ff ff ff       	call   80107130 <uva2ka>
    if(pa0 == 0)
801071dd:	83 c4 10             	add    $0x10,%esp
801071e0:	85 c0                	test   %eax,%eax
801071e2:	75 ac                	jne    80107190 <copyout+0x20>
  }
  return 0;
}
801071e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801071e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071ec:	5b                   	pop    %ebx
801071ed:	5e                   	pop    %esi
801071ee:	5f                   	pop    %edi
801071ef:	5d                   	pop    %ebp
801071f0:	c3                   	ret    
801071f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801071fb:	31 c0                	xor    %eax,%eax
}
801071fd:	5b                   	pop    %ebx
801071fe:	5e                   	pop    %esi
801071ff:	5f                   	pop    %edi
80107200:	5d                   	pop    %ebp
80107201:	c3                   	ret    
