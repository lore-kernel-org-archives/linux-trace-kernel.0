Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7C20010B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339390; cv=none; b=bm5sTl3RSqAiNUdvhQx29jsvKHAwQtvs/pfnXWqtA8VF6dv9RJMMsj5oKW3h+eq8fr4P9PS3PjkivGXjWzQgmdZ5jQG+mqxdt8FNbIpys4UlPlkm2XRsnXdbxP8Au072dtG8OfTekgGPA18HAO7RSRWeJdA0qTf2vlkCxGy7zXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339390; c=relaxed/simple;
	bh=qHy8pe6BJZ/CNAHEzIVHbAuPyQL9DFoR782xOYMDW3M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ImQXutv6jiureslH7RjJmD1LRx9ox7kc4P+SEm1pAPglw1dg8D/AhXmBmC7+vI5bLUJkEuf6cywxsJcNwXVmGZmtSKLFn2Hz+z9f4xR1EiryFBWFPglHYiyK41pBZPZDwHoY7xzbWlV6ux/PtGTE+UsedRy/pGxPhqGWrHE62rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so85146195ab.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734339387; x=1734944187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l60Dua/WtRR5J4wn9Myw1KA8V4e7z1uHssTczWLt9JY=;
        b=n3vJvGLOrMVj9prhQYNk32ioDB30QFEcGZS2tsnuxQPsJyEbkUtK2BtfoHlrpWAS1G
         8Uq7Qr+sobXL3eTtcMYo4Z2/iljQiOaC6i1fSFzDquw6oPuHoATuh609Y9nUglpZzzzk
         9berr8dULSFBm/0lknp6yJXuZAeOskVuUsK/nreMD9QjTxOAwvB6FLj9u+jo+CA+iucG
         1BWdC53Eqfr/c7fFOzpdA4z4dwvaMNsI6ZM1qgaFR1s+qpHj9JDBo9OORQSBJMrjuCwX
         Rsk0orhNKVf00emULuK19JTOhjov4lh7ly4jxZDFt5oE4AQdRD2iTP+ruPHMKy500YpA
         OkDw==
X-Forwarded-Encrypted: i=1; AJvYcCX2Nuw2Zh8Xwdm56ah2lFBS3FyAMLqptDcqRKBdgUVumpsySjZQWFBo1ctN6s72PES+trNOtyJl6Yciox2hwece5rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9j0xsDbSFPkyDzYOOdUeODlLLRHw7D/aPuf11gxO6w651dyM/
	LhRSF+TClH8rEYerPJL9IzDm6FZMpaNBQwdk4gXlDty43z2vzjAMtqtOY+FtvUz28nyqtaml2CC
	kTnimzSv6zKshD9jfBjdMrI1V0IL2e2n+YrZENNsZ0x8h6/Wlgc3GxxY=
X-Google-Smtp-Source: AGHT+IEzamfjcvk4wbGxi4HkqRFj7xXF3MP0C4LAUNUsuYXgZa/dX56WSWA9Ds7VgnsqMfxRudxB5Uo/wb4TS0q2LtXElAECnGcN
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3afeee7a120mr89281705ab.14.1734339387306; Mon, 16 Dec 2024
 00:56:27 -0800 (PST)
Date: Mon, 16 Dec 2024 00:56:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675feb3b.050a0220.37aaf.0120.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in ring_buffer_map
From: syzbot <syzbot+648bb824605554d08bff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1764b20f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=648bb824605554d08bff
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150b04f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b04f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+648bb824605554d08bff@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5834 at kernel/trace/ring_buffer.c:7061 __rb_map_vma+0x881/0xae0 kernel/trace/ring_buffer.c:7061
Modules linked in:
CPU: 1 UID: 0 PID: 5834 Comm: syz-executor239 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__rb_map_vma+0x881/0xae0 kernel/trace/ring_buffer.c:7061
Code: 04 25 28 00 00 00 0f 85 11 02 00 00 48 81 c4 b0 00 00 00 89 d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 40 7c fd ff 90 <0f> 0b 90 bb ea ff ff ff eb 96 e8 30 7c fd ff 48 8b 44 24 20 be ff
RSP: 0018:ffffc90003a27790 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000007ff RCX: ffffffff819bbf0b
RDX: ffff888059005a00 RSI: ffffffff819bc1b0 RDI: 0000000000000006
RBP: ffff888078d9c578 R08: 0000000000000006 R09: 00000000000007ff
R10: 0000000000000003 R11: ffffffff8b200130 R12: ffffea000007bb80
R13: ffff88807ab41bc0 R14: 0000000000000003 R15: 0000000000000001
FS:  0000555581f4d480(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f183f3b20f0 CR3: 0000000032d56000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
 tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1786/0x2670 mm/vma.c:2456
 mmap_region+0x127/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f183f33c5d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6456a698 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f183f33c5d9
RDX: 0000000000000009 RSI: 0000000000001000 RDI: 0000000020ffe000
RBP: 00007f183f3831e4 R08: 0000000000000003 R09: 0000000000800000
R10: 0000000000000011 R11: 0000000000000246 R12: 00007f183f38917c
R13: 00007f183f383169 R14: 00007ffd6456a6f0 R15: 00007f183f3b441c
 </TASK>


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
