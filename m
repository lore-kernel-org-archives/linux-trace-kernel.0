Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4052F6569
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880734; cv=none; b=XiBsYKYCxZf4f7wdsCrW2h6bl1jShCs4hoKGcIzdd1kZB2375CQoqwq2mPFIJI6kGFh8tVwNdQxtrctlVnrVso18haoP+S4SHkj/Uuca+8kVzlZ5CjHOnioKrO+Ge+C1QrcOf3asVUn5bKTuSOdgAwMQCFvOJoqLUTMEtUcGdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880734; c=relaxed/simple;
	bh=qp0RRiEutX6eCycXlI9EKKhM8Uj8NTrir4RbBICQTUI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s24NeWw5ZR5N5aB8ODY6ME+CS4Hy8Dl0/0IX4GSswjjqGid5BhAjPN3aoIemjOfXmfA75xF01xAkp5qE3zoI42tSfC1akUE67TYCh2iq3LGCJzRDy0dhCATpZGJYdJ+3hR1Lk1omO8hDWh3xgluyINr+gS0Q9PuJ6CusiWn4030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43321627eabso149514965ab.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880731; x=1763485531;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9yKtfw3pKsNX9vM4edxJj/PHOhyabFZR69IHBRtPhc=;
        b=de6JS7U/Z11Y4Jna+nhjc2ZsT5++p4kCUH6ZORiEzyJwotspOsOL1UuKKWBfkB+GtJ
         5X8lw4t9DKzKMpx+ziAX4XkW7+sw4NaT0ZlqCOpflSkJEx/oU5iKbaXDYId2vOzp3p5U
         MA0PdbSmV2Bi/Fwy8PI8cKifHPpUPCRyBcQdVBuJOalSLWKz5mojw5rvyl9Vl9HZ5DFC
         tsqFbWF5trYFYLFSH3tHUiQnBJTUHTEgLLzOLkIAsrAuMqZMbUkf2TQuYs4u2DAEb01M
         lg5U33DbKNjb3vF2ZotGfH7rxwlzTqFaxtbAGf/Kn76ScOaXZtu9pYLS11CRuj8W1sIP
         iLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsXRJDc3LkAWWmO9SPRo2ChUFuZltILrqeje33Zwv3AHUKvw4mAiZLOcBnKzCRG7TxCSKx0fJXCaZnxUNJU5uFOAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhZDYNks0CZopTaGHt1aebQdXx8KyvCE/wtGSL0qpLykfFbYO
	i5GlY1qTpMR4VJy7H3CjDFLmTrVkg/eSS0kv5CwF+MTBoVJr1rYp+sB3F5BEvztL9m5SIaAzDE3
	E5RhlM93XSQkyoS8NP0YaZ6WI9lUqNytvCGiHatn496nWrLnNxB4twx+vCUs=
X-Google-Smtp-Source: AGHT+IH1+QOtpU0ZeJvkc+GVxbQCyrhe2jplHbaU6/sA2aEZpmAiopJJyTBYYmlJjU102ujthHBLrhG03Jls6RAWPkKTIT7r/0gN
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2301:b0:433:7900:f1c5 with SMTP id
 e9e14a558f8ab-4337900f3bcmr142898585ab.7.1762880731335; Tue, 11 Nov 2025
 09:05:31 -0800 (PST)
Date: Tue, 11 Nov 2025 09:05:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69136cdb.a70a0220.22f260.0142.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (2)
From: syzbot <syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127c3bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=a72c325b042aae6403c7
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fb5342580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167c3bcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0885fd14dc45/disk-4a0c9b33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d090edb8df65/vmlinux-4a0c9b33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe620e34d128/bzImage-4a0c9b33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5989 at kernel/trace/trace.c:8780 tracing_buffers_mmap_close kernel/trace/trace.c:8780 [inline]
WARNING: CPU: 0 PID: 5989 at kernel/trace/trace.c:8780 tracing_buffers_mmap_close+0xdd/0x130 kernel/trace/trace.c:8775
Modules linked in:
CPU: 0 UID: 0 PID: 5989 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:tracing_buffers_mmap_close kernel/trace/trace.c:8780 [inline]
RIP: 0010:tracing_buffers_mmap_close+0xdd/0x130 kernel/trace/trace.c:8775
Code: 75 46 48 8b 7b 08 e8 b2 94 ff ff 31 ff 89 c3 89 c6 e8 07 4b fb ff 85 db 75 0a 48 83 c4 08 5b e9 b9 4f fb ff e8 b4 4f fb ff 90 <0f> 0b 90 48 83 c4 08 5b e9 a6 4f fb ff e8 b1 e6 62 00 eb 87 e8 da
RSP: 0018:ffffc90003047ba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffed RCX: ffffffff81c11d89
RDX: ffff888020713c80 RSI: ffffffff81c11d9c RDI: 0000000000000005
RBP: ffffffff81c11cc0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffff8880217512c8
R13: dffffc0000000000 R14: ffffc90003047c30 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124a0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555606ff808 CR3: 000000000e182000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vma_close mm/internal.h:190 [inline]
 remove_vma+0x88/0x160 mm/vma.c:464
 exit_mmap+0x50a/0xb90 mm/mmap.c:1305
 __mmput+0x12a/0x410 kernel/fork.c:1133
 mmput+0x62/0x70 kernel/fork.c:1156
 exit_mm kernel/exit.c:582 [inline]
 do_exit+0x7c7/0x2bf0 kernel/exit.c:954
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1107
 __do_sys_exit_group kernel/exit.c:1118 [inline]
 __se_sys_exit_group kernel/exit.c:1116 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1116
 x64_sys_call+0x150b/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f168a18f6c9
Code: Unable to access opcode bytes at 0x7f168a18f69f.
RSP: 002b:00007ffff8c604f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f168a18f6c9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 00000004f8c605ef R09: 00007f168a3b1280
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f168a3b1280 R14: 0000000000000003 R15: 00007ffff8c605b0
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
