Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775032;
	b=usrntHv12myYn5TQwhU6fNnAPOX8JFjw2EC4MfyR2CpUEZbPtJwjAtAQZhGBymyw3LEN
	 q9n4JPqfFZJUD4CLPhGDN3edAr4vDE3jarioiPF8QcC3kNMj9SX2lC2gmPUPd8v+ltFd+
	 eBiJwTRqYHR0i6dV7cKiBlvo2TBOoK0qWErcO13Fs+KFZ5bY3VNHI61kKogm0MTB5STbi
	 Hvu2nSE/KIj5+WXZosHYLmzOu3Mo8UhKRQReLhiIT+4nrZ3uU+In9b05cAv5oWd0uGW6g
	 tY/eG/3d0AZDHn7zpvtcNWiVtFPO4d85tIKHHMemCjAhYb6l5wkplk8oGKC6smkdHAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775032;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=Ypv/4GADrMZHlAccc4Me/qsRWylAusYCSwJJTgXIk/4=;
	b=mbAPPq1Rtlql7TAJfb2adSSLIi6OEUnLT4E0mH69F6ssnBqn4mZM4RK6qZPTFXcLykwi
	 AGxw74biZX0D+MEmBe9oCdGfKqmwQA/p74Av/batMAgzjMtkw+x2GtzwpMPvF+zzUm4h4
	 Tm+qZY0W8QV62YGqZqCw7rJlJYjc48jWuyd6s1K4taWJsCTb4EDsjtP4WtfOPu0X9ZE/Y
	 SpCwV9u1Bxio0JDPVG4IanRdaQXxGmTtDpZZBeHG6Q2jPeAsdkMRDQ3IPP9iqCNja6o40
	 O4jmcN4edT9AE7JIfRewUwSB45UEK19oY0GwAhouY3lFWhxj2QU0Tdap84pwM6WTrvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDD606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 06:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FDD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab260600easo2286904b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 22:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793775031; x=1794379831;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ypv/4GADrMZHlAccc4Me/qsRWylAusYCSwJJTgXIk/4=;
        b=FIJ62GgMioShwC2oMooJ8iINcMY9HPATzVN0W3d3fMr2J0PfiQEn8B7Ldjn03mMAh2
         TnJzxFmdVaz28IHDg5P3zrDBM2iehbIzB7B5YaGn9sGfjvTcWZu+nAt+roCpkGi1NJFc
         zxkG1Q3sc4TL2VH57i7wvHxkDZZj4NmMl5JZV9l3Zy9ecC7RuORDi4TlsAfwQYEReegr
         WyMgHvkVZUtIxoL2vg+cN15wYpRdfCszaUUhrmTfvWxl9Ni2YmbdPAQux+8xpq/x991t
         5YXJGIzYrg98+ypT7WJE1yjD9lmwEI4iMfYfwKZLHCM9Y82eZjmfe4K3YV1GqMVIL5DA
         E3Pw==
X-Forwarded-Encrypted: i=1; AKwUvBwyOyac6g3dc93hJCvwWrGeYlzcgHoZ67JiqqdnMTn6c35VpMW2+5V4P//fKpw+sxNlgYDzNAxuXX2z65zE/XYk/co=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FjkqFVaO+UijKUgFnjQvspHwMNe95Saq11zY5EMh8nZmwPYv/
	XT58PTEji8B2O2n52Bai+0PZ3X7pY6XKPWjm7Wa4lWoVNPpGsnZ6L9u1XVG5ck0cJvTMhuoEbgd
	8IEBDb9689k4VfZa5HwMSfiK0lRU0AHbPGi5NuuRciCoHO+RnpWS6VE1xhmo=
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:120c:b0:4b8:4703:db92 with SMTP id
 5614622812f47-563ef9fad63mr9780361b6e.27.1793775031319; Tue, 03 Nov 2026
 22:50:31 -0800 (PST)
Date: Tue, 03 Nov 2026 22:50:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aead5b7.fc50a118.dd1b.0002.GAE@google.com>
Subject: [syzbot] [trace?] [block?] BUG: unable to handle kernel NULL pointer
 dereference in print_one_line
From: syzbot <syzbot+2fca70610179be6c24a4@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2637bdec0535 Add linux-next specific files for 20261102
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15de1eea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82467d52d846ff27
dashboard link: https://syzkaller.appspot.com/bug?extid=2fca70610179be6c24a4
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1276162d580000

AI-generated root cause summary:
When blktrace events are recorded with version 1 (configured via the
BLKTRACESETUP ioctl) while the blk ftrace tracer is enabled, __blk_add_trace()
writes events using the v1 struct blk_io_trace layout instead of the v2 struct
blk_io_trace2 layout expected by ftrace. In print_one_line(), the entry is
unconditionally cast to struct blk_io_trace2, interpreting the process PID (at
offset 32 in v1) as the action field (at offset 32 in v2). If this value
corresponds to 14 (__BLK_TA_BOUNCE), the bounds check against
ARRAY_SIZE(what2act) passes, but what2act[14].print is NULL because
__BLK_TA_BOUNCE is an uninitialized entry in what2act[], leading to an
instruction fetch at address 0x0 and a kernel panic.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=2fca70610179be6c24a4

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fca70610179be6c24a4@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0010 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6058 Comm: syz-executor155 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900039cf9f8 EFLAGS: 00010206
RAX: 1ffff1100f6dc81e RBX: 0000000000000000 RCX: ffff888027a8ddc0
RDX: 0000000000000001 RSI: ffff88807b428004 RDI: ffff88807b6e20f0
RBP: ffffffff8c334eb0 R08: ffff88807b6e215d R09: 1ffff1100f6dc42b
R10: dffffc0000000000 R11: 0000000000000000 R12: ffff88807b6e0000
R13: ffffffff81d21760 R14: ffff88807b6e20f0 R15: ffff88807b6e40f0
FS:  000055555b9db400(0000) GS:ffff8881234ff000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000005d394000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 print_one_line+0x29d/0x300 kernel/trace/blktrace.c:1757
 s_show+0x142/0x320 kernel/trace/trace.c:3332
 seq_read_iter+0x8d5/0xca0 fs/seq_file.c:273
 seq_read+0x367/0x480 fs/seq_file.c:163
 vfs_read+0x213/0xa80 fs/read_write.c:572
 ksys_read+0x150/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc3268e9437
Code: 48 89 fa 4c 89 df e8 98 1e 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffe64d7f280 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055555b9db400 RCX: 00007fc3268e9437
RDX: 0000000000001000 RSI: 00007ffe64d7f530 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc326926928
R13: 0000000000000004 R14: 00007ffe64d7f430 R15: 00007ffe64d7f2fc
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900039cf9f8 EFLAGS: 00010206
RAX: 1ffff1100f6dc81e RBX: 0000000000000000 RCX: ffff888027a8ddc0
RDX: 0000000000000001 RSI: ffff88807b428004 RDI: ffff88807b6e20f0
RBP: ffffffff8c334eb0 R08: ffff88807b6e215d R09: 1ffff1100f6dc42b
R10: dffffc0000000000 R11: 0000000000000000 R12: ffff88807b6e0000
R13: ffffffff81d21760 R14: ffff88807b6e20f0 R15: ffff88807b6e40f0
FS:  000055555b9db400(0000) GS:ffff8881234ff000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000005d394000 CR4: 00000000003526f0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
