Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE654503B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323916; cv=none; b=uCWXGf0hc6B07eN1o0fUK0TRMqB0j3woqUraYaoVl0KWWqZCubD2jXpY8kXFJUqBviV3SfnL2eqa/tdrGurdWWwiDvGk4z/VE+5GBbPYmBa8/Za7RFYSE9yGlvZ0+sYMym+I2QKIlcvEDObJqZheVTzNMGGlVeGktdethnMbIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323916; c=relaxed/simple;
	bh=EIWscoL1sZJXZipgcopR2FTLNKvLij6HrG2U5h9147E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ug2DMkmXtfOM/w9o4oWSrehveoMoMtuEtef5gqPIW+UZ16faqp7LCa7dUA2/LpA6qfoE8OqBtxDbQhXtkso/ByCz+bwn4ZR9MpVa5na+CbFUIeuOYBE46vdpdnZrISltGZgj4sbbZXIqU9dgQysmu5rV9VnWzBPALkW7cYMrEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-46f178d813bso3729768fac.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 14:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791323913; x=1791928713;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Ngh51C6aq2fAaM84ZdR4WSPgJ6AgaXWQPLoIXBZa0o=;
        b=ErZG6Wj3qQo1ZpPp0Xt4CX3nWUwTvU6KPOe4GNXqV4GYGYt+SZndROBnb4X2HCn+Be
         DzW3gspKQJQ9z9tefHCPEvgfm56/cYgmPgTCXGAXeo/VxGDC0HgebKjAlzF16yFqyrTA
         tp5tfK2djOatUtErOqc0O4jrUEerzwlCkj5Cr9wg5raWpkSwWtLgZ2k6sOIKAxR8naGa
         zsb4Ay53Osyp3tqwQlvlVgxLgJw2ltye7mNlY+PsjNBpfAd/SFHxxeoHJYUF+/OI+VaM
         tRA2XqxAyGXNzvGgXq2gMBdIVImwEiXNAgkiod74X6tdVnGmFqRwLOe8Dh4q44CLwMF2
         QzTA==
X-Forwarded-Encrypted: i=1; AKwUvBw+SS8jXnPs7JaCJLN2u4fgs+MgYqsgcgsSejNBRU+aeG9yNOaLKJi0bY6cF8kBkCEceo98rOr3QRq3flpEMpuGE0k=@vger.kernel.org
X-Gm-Message-State: AFuF++mOosCD2g4clfGI7tqrfDUZQkl8xM4vd4tzSj3rZb6JdkdwBr6X
	1fAe5qyG/EfsqBOvrCBNIYN/G8RtRuOi9MbZ0PrLz3vi5CSi04PHXUJ+HP++HSwhqlLkkJDMsv3
	GLtpRqowd/23VfdnT92oJqpN8j2Tz5qeic40P4l9w+annRU+UGHn7suhxBBM=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1996:b0:4f6:5279:5c75 with SMTP id
 5614622812f47-4fc46f966ffmr745267b6e.28.1791323913450; Tue, 06 Oct 2026
 14:58:33 -0700 (PDT)
Date: Tue, 06 Oct 2026 14:58:33 -0700
In-Reply-To: <6aafebec.a6af0033.177e91.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac56f09.fe639fcc.32b100.000d.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in check_buffer
From: syzbot <syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    69f80fef3153 Merge tag 'ata-7.3-rc7' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1266a715580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc812281b37d1115
dashboard link: https://syzkaller.appspot.com/bug?extid=eb74dca0d1eb3ec227a7
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1666a715580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com

 0x90: [80897807093] delta:0 TIME EXTEND
 0x98:  [80897807093] delta:0 .
expected end:0xb0 last event actually ended at:0xb0
------------[ cut here ]------------
system_state != SYSTEM_BOOTING
WARNING: kernel/trace/ring_buffer.c:4783 at check_buffer.cold+0x1a2/0x1ef kernel/trace/ring_buffer.c:4783, CPU#2: syz-executor270/6036
Modules linked in:
CPU: 2 UID: 0 PID: 6036 Comm: syz-executor270 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:check_buffer.cold+0x1a2/0x1ef kernel/trace/ring_buffer.c:4783
Code: 03 0f b6 14 11 38 d0 7c 04 84 d2 75 5c 8b 2d cc 17 22 10 31 ff 89 ee e8 9f 78 e8 00 85 ed 0f 84 18 13 eb 00 e8 22 7e e8 00 90 <0f> 0b 90 e9 c3 10 eb 00 49 c7 c7 00 5e f6 8b e9 51 fe ff ff e8 38
RSP: 0000:ffffc900037cf9a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920006f9f3a RCX: 0000000000000002
RDX: ffff888021a98000 RSI: ffffffff812327ce RDI: ffff888021a98000
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000005c85
R13: ffff88801d6c4000 R14: ffff88801cf70000 R15: ffffffff8bf659a0
FS:  0000000000000000(0000) GS:ffff888096b52000(0063) knlGS:00000000f5e91b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f5e916d8 CR3: 0000000055cc8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __rb_reserve_next.constprop.0+0x486/0x1640 kernel/trace/ring_buffer.c:4873
 rb_reserve_next_event kernel/trace/ring_buffer.c:5010 [inline]
 ring_buffer_lock_reserve+0x49a/0x1220 kernel/trace/ring_buffer.c:5069
 __trace_buffer_lock_reserve kernel/trace/trace.h:1677 [inline]
 write_marker_to_buffer+0x88/0x5f0 kernel/trace/trace.c:5936
 tracing_mark_write+0x215/0x3b0 kernel/trace/trace.c:6322
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x1f8/0x250 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x166/0x650 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf7ee27eb
Code: 57 56 53 8b 44 24 14 f6 00 08 75 23 8b 44 24 18 8b 5c 24 1c 8b 4c 24 20 8b 54 24 24 8b 74 24 28 8b 7c 24 2c 8b 6c 24 30 cd 80 <5b> 5e 5f 5d c3 5b 5e 5f 5d e9 57 dd ff ff 66 90 66 90 66 90 90 55
RSP: 002b:00000000f5e9161c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00000000f7f2dde3
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	57                   	push   %rdi
   1:	56                   	push   %rsi
   2:	53                   	push   %rbx
   3:	8b 44 24 14          	mov    0x14(%rsp),%eax
   7:	f6 00 08             	testb  $0x8,(%rax)
   a:	75 23                	jne    0x2f
   c:	8b 44 24 18          	mov    0x18(%rsp),%eax
  10:	8b 5c 24 1c          	mov    0x1c(%rsp),%ebx
  14:	8b 4c 24 20          	mov    0x20(%rsp),%ecx
  18:	8b 54 24 24          	mov    0x24(%rsp),%edx
  1c:	8b 74 24 28          	mov    0x28(%rsp),%esi
  20:	8b 7c 24 2c          	mov    0x2c(%rsp),%edi
  24:	8b 6c 24 30          	mov    0x30(%rsp),%ebp
  28:	cd 80                	int    $0x80
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	5e                   	pop    %rsi
  2c:	5f                   	pop    %rdi
  2d:	5d                   	pop    %rbp
  2e:	c3                   	ret
  2f:	5b                   	pop    %rbx
  30:	5e                   	pop    %rsi
  31:	5f                   	pop    %rdi
  32:	5d                   	pop    %rbp
  33:	e9 57 dd ff ff       	jmp    0xffffdd8f
  38:	66 90                	xchg   %ax,%ax
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	90                   	nop
  3f:	55                   	push   %rbp


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
