Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5C281357
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078805; cv=none; b=NCuQ4KAdjJbfNPmRcK45s9VK+c0TwTsDfM11fB51mfwePjbMYouo3xDELwSWXrvkzhtlNzEnvzeu6hDHLw/VC/h/6IMB+rNo+o9e+JrpsygE18SKF400EY0dmJi9yD3YZEsjjbMiUz1+GE/3OUklISH8F6ZOWT3mwJ4sVO9ytcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078805; c=relaxed/simple;
	bh=7O6weSkC5G2oKb3y1fSj3gZzdqOZl5EWcRMGocctpUE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E2BJ7zdIa0lFlw0U0/A03RY34FTO/Gpv5zIwnATiQqMena7yBxtRqXlM5+be3V5ZmifwCliu78owzGKKpnwSSliOch575rJwaFIzozvpDeDJsYSDpjJfHtiozY86ixUqVyf0Bp6dkxn0/5I811prxXoh6lcyCAvUjIbT6Hsxans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c54e29f6so3176510eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 20:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078803; x=1772683603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dy3wY2j/QIgKTNp83IJwqxoTttmThtOYJaKBvc98KNg=;
        b=JlNcYHi+flAoi/z9Lp12AQTc4RNNOUT953a6VHStVgE6gIH301HotxJRxMjRCQWNhy
         We3CoEEpkEcBLpTXs6eBVxtXK/pTkrfkQvC4PdV+0uPKTAftl1zTUW3JAotVCkgbov7q
         dfYQPMigY0RkWvC6UXFJT8bEw/EOnPUNaadgzQ878CQmjJxHm7WoWwoD/v27mbJYxIDi
         WOHxWeNtvpE7sDHnI0uRqZr9Bg76TVbJlkvsCTl89NTPUeuQSjTK/3J84jaA1GTF8DD0
         h1FLz2jJxkOXMWSwBC8nbNvM8XFA1Lgi9U1DSSH/2zHDKPitXtzZ10BsQYcysxQEXGjx
         WQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkUdzYmLfkfXQvIobVoYularAptkIE8fKTZagMvJbpEbzZ63EYL/Dg0DklmjJw2ABILWi3mQOKWF7K9GeTZHc7sUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxab1EYId0C+Zd384IWgjXXfXkLDTdMs5kuDboBgzfuvG/yJXsI
	ZsgXZSyohJtDkfEazw9fy6XlZNZk4p8/RgFVkLVezWljEyZBqUOl3hqk8B5LS51rLZWQlKzQCKa
	uYbyiNzvkyOwOxnRvDeVatL5JTZdyCawqxcORHVJOsHg6Dwv/iqoY22+hfhE=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1611:b0:65c:f9c1:cba0 with SMTP id
 006d021491bc7-679ef97d1e9mr1255647eaf.37.1772078803608; Wed, 25 Feb 2026
 20:06:43 -0800 (PST)
Date: Wed, 25 Feb 2026 20:06:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699fc6d3.a00a0220.21906d.0073.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
From: syzbot <syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7dff99b35460 Remove WARN_ALL_UNSEEDED_RANDOM kernel config..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc2006580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356
dashboard link: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bc4202580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107f155a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45c7b6686727/disk-7dff99b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36fcc9cd6296/vmlinux-7dff99b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe952fd2745b/bzImage-7dff99b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com

------------[ cut here ]------------
ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file)
WARNING: kernel/trace/trace.c:8221 at tracing_buffers_mmap_close kernel/trace/trace.c:8221 [inline], CPU#0: syz.0.17/5983
WARNING: kernel/trace/trace.c:8221 at tracing_buffers_mmap_close+0xea/0x140 kernel/trace/trace.c:8216, CPU#0: syz.0.17/5983
Modules linked in:
CPU: 0 UID: 0 PID: 5983 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:tracing_buffers_mmap_close kernel/trace/trace.c:8221 [inline]
RIP: 0010:tracing_buffers_mmap_close+0xea/0x140 kernel/trace/trace.c:8216
Code: 08 e8 3a 74 ff ff 31 ff 89 c3 89 c6 e8 2f 50 fb ff 85 db 75 0f e8 76 55 fb ff 48 83 c4 08 5b e9 cc 45 83 09 e8 67 55 fb ff 90 <0f> 0b 90 e8 5e 55 fb ff 48 83 c4 08 5b c3 cc cc cc cc e8 df bd 66
RSP: 0018:ffffc90003ff7ab8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffed RCX: ffffffff820ca5c1
RDX: ffff88802a299e40 RSI: ffffffff820ca5d9 RDI: ffff88802a299e40
RBP: ffffffff820ca4f0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffff88807fc6ecc8
R13: 0000000000000001 R14: 0000000000000005 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888124351000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc3f6e17dac CR3: 000000000e598000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vma_close mm/internal.h:190 [inline]
 remove_vma+0x88/0x160 mm/vma.c:466
 tear_down_vmas+0x2a5/0x600 mm/mmap.c:1264
 exit_mmap+0x469/0xa30 mm/mmap.c:1322
 __mmput+0x12a/0x410 kernel/fork.c:1174
 mmput+0x67/0x80 kernel/fork.c:1197
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x78a/0x2aa0 kernel/exit.c:959
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1121
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc3f6b9c629
Code: Unable to access opcode bytes at 0x7fc3f6b9c5ff.
RSP: 002b:00007ffc852ef4c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc3f6b9c629
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fc3f6de53e0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc3f6de53e0 R14: 0000000000000003 R15: 00007ffc852ef580
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
