Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF618DB37
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773026306; cv=none; b=LkjQu4MvQvEtS1DuQWZuNFFQ8ZZ4krgdst6xzUVtrdd5O5VBkbqwPQmhO+2s7TAQIMUpEQwcekIMiT8k0/uOFYay+T3/33GXIwRJ0ByTPYr9XP0VPwIMvV3xiHpo+ojWkz+SBrZI2AD/UWnLj1ZeLxnXGrFI7vc+lQK1JCneD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773026306; c=relaxed/simple;
	bh=ZgUd83HYbXnzE4yuTbBpQMYTVblYpQTEFj/3IWHq7bM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tG9+umG/o3OWS9yGijKsSCxtSaqydMayCcYTLbogU4j3haKpy8x4YrKALnm3uM/sX5PExx8tY2WmuaWGxWlKAcMFR7moBO+ITreL0YWAJgxUgBvTlBqpC6a58YxIE+6/c04W9/EjdjsPoY2nQcr4W3VizXfoaI4V37zajNzayL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bb58103daso2728768eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Mar 2026 20:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773026304; x=1773631104;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GD8bcTWofBjnYQ3aQVNTHpJCJ5pB4DTaYb3sbZFn2BU=;
        b=b4dF2GIrZEi3a5Kk0u5CbM4P9evY2viyXCSZ1K4ZmRqhfAtH8Ha6uXkdxbaXrGRkeN
         3A1D8X+7vhOSI+4wj99vLjPgcpyfZCJshbJqx09CVTha2hFS+QS5fK3XFTCuCg2b9XH6
         jYM6jLBGP0eTM4uDuFc1gSY6D8vzqCVKVZwgeqOB6jSjOWeo4yrvdIb2AV/0mggbmE5W
         XoOzG1yuvjZj1yNH+IoQq0+Vcnx62ymByTsv7NUgF3oDyv7FMbCLy/jifkWGgI8mGkl5
         J8zucLghU0n7SWTbFyoET8SnTaK52vVaQU1ahcDr2rt5ugO617Ule+vSgXWps2U/nJRv
         XWCw==
X-Forwarded-Encrypted: i=1; AJvYcCVUdfR+66yX/dDjSKAG4ub7DyPVYJcHYEZmBtfSf4yrPOibXFw2cBlHex25Gk8BVHDDVgbnVlMd04HYzUz/h/ksHrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnMNv2x0oUCrcqRNtOGNTIjirzxPh2Pyo5XTK3rUhfqZsEqdT
	9wgyaFHEiEuXTtqc4aji1aw1Buv9mhUQlcKXVJV7VEUKpJWSTgYCXVV+UWKdP9ct5zxKt0dYkxY
	VNfUnoXQjGnA6se/h/2H6McbzjTSQI0fEHv/HdvZOcB+NJZXo322vFk52s1c=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f022:b0:67b:b77d:70aa with SMTP id
 006d021491bc7-67bb77d74ecmr178913eaf.15.1773026304519; Sun, 08 Mar 2026
 20:18:24 -0700 (PDT)
Date: Sun, 08 Mar 2026 20:18:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ae3c00.050a0220.310d8.0013.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in ring_buffer_nr_dirty_pages
From: syzbot <syzbot+855a87cfc76c52ce7a59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    ecc64d2dc9ff Merge tag 'sysctl-7.00-fixes-rc3' of git://gi.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D109bf0ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D163cf0fb07ea84d=
3
dashboard link: https://syzkaller.appspot.com/bug?extid=3D855a87cfc76c52ce7=
a59
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23b82e01c157/disk-=
ecc64d2d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e98b1b4abbdf/vmlinux-=
ecc64d2d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41e18c482bbb/bzI=
mage-ecc64d2d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+855a87cfc76c52ce7a59@syzkaller.appspotmail.com

Invalid ELF header magic: !=3D =7FELF
------------[ cut here ]------------
read > cnt + 1
WARNING: kernel/trace/ring_buffer.c:788 at ring_buffer_nr_dirty_pages+0x207=
/0x290 kernel/trace/ring_buffer.c:788, CPU#1: syz.1.4985/28848
Modules linked in:
CPU: 1 UID: 0 PID: 28848 Comm: syz.1.4985 Tainted: G     U       L      syz=
kaller #0 PREEMPT(full)=20
Tainted: [U]=3DUSER, [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/12/2026
RIP: 0010:ring_buffer_nr_dirty_pages+0x207/0x290 kernel/trace/ring_buffer.c=
:788
Code: 83 c3 01 48 89 ee 48 89 df e8 95 24 fc ff 48 39 eb 72 11 31 db eb cc =
e8 67 2a fc ff 90 0f 0b 90 31 db eb bf e8 5a 2a fc ff 90 <0f> 0b 90 31 db e=
b b2 4c 89 e7 e8 4a af 67 00 e9 f8 fe ff ff 4c 89
RSP: 0018:ffffc900052875c0 EFLAGS: 00010087
RAX: 000000000000014d RBX: 0000000000000001 RCX: ffffc90007725000
RDX: 0000000000080000 RSI: ffffffff820be6e6 RDI: ffff88805e5f0000
RBP: 0000000000000002 R08: 0000000000000006 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88813fea5000 R14: ffff88813fe5a4b0 R15: ffff88813fea5000
FS:  00007f8292df66c0(0000) GS:ffff88812444e000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e2ebff8 CR3: 00000000621de000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 full_hit kernel/trace/ring_buffer.c:810 [inline]
 rb_watermark_hit+0x1f5/0x300 kernel/trace/ring_buffer.c:907
 ring_buffer_poll_wait+0x2b2/0x490 kernel/trace/ring_buffer.c:1064
 trace_poll kernel/trace/trace.c:5895 [inline]
 tracing_buffers_poll+0x1cf/0x250 kernel/trace/trace.c:7841
 vfs_poll include/linux/poll.h:82 [inline]
 select_poll_one fs/select.c:480 [inline]
 do_select+0xd54/0x1850 fs/select.c:536
 core_sys_select+0x55b/0xbb0 fs/select.c:677
 kern_select+0x20c/0x270 fs/select.c:718
 __do_sys_select fs/select.c:725 [inline]
 __se_sys_select fs/select.c:722 [inline]
 __x64_sys_select+0xbd/0x160 fs/select.c:722
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8294b9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8292df6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007f8294e15fa0 RCX: 00007f8294b9c799
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000e
RBP: 00007f8294c32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 00002000000002c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8294e16038 R14: 00007f8294e15fa0 R15: 00007ffe7dd14a88
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
