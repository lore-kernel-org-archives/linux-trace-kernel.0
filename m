Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192504A23
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470071; cv=none; b=JKbrVUnji3mcDiQ+EzYpwddRaeMVUXzsX2COUVZ6H4xzurv/PGWLThn7MOVSrEgwa4pN+cnAjFaSopreMxVd7tfnAMqS63ERujI6XaYirP9OkjXQNnPUGZxWgwm5dwoGR6tlvYfSoEraMZET3JErV7bz3Gk4Fw6Wmf6CX5gf01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470071; c=relaxed/simple;
	bh=9xBp3Q6BZBAKb/GN+sG/0O1+WQF9iXHiKxw6DZ0ibWI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AQMgVHBxM6OyZAMu1yXyBr1aA7PQ5KkDIGijbpu+89a2haEX0/boukzAxnCQSSC9z1IXwane6jkajzuAT1LgsPcyRN7JN3QSnr1Ka7g56qYkUsBLlDeoWGoy1LFA6W+6jplOjjxCkurKfHw+94Vdi/3k+HkWYgiZRMJ6oL47jmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso63754645ab.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734470069; x=1735074869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hH56uLGmiLkVM1SZkVq06DtgThwgZTTbZifYFmgn0Ck=;
        b=bePD0joR2tf2AmF+7CBhNBimtdmjFwsekJbmbj/IUTk0WZB5oJWVohvcs7lBWxI4V9
         5diArdnEBu8swjdctJtFkJfr0KFloZbtJbFriSCrkEJRgztKx5FKkh7KcyF6muMpZIT/
         jmPK4hJwHFP8Zzem9ysQBAECQyMiLWK02cYFLxI0tsAUbFPlF2OYS4kaoRkNCmPV+Szp
         LCrwpnJ6cQiDZ0tHKhO6nHDim4csxSPVgcb3NI2tdwwQW0XsTXAiY9umA2vV1Ri1gia7
         z2aZAUBUsoGWNmR3xhbYuSRc0CzPdA1YvjMdKpPxv2w+LVD4Vql1taCcY//3a0yRqKKt
         pN+w==
X-Forwarded-Encrypted: i=1; AJvYcCVh2ObujoVGyOrVrY2+yaVbW2ozf/OWMtuCrst5tnJWKYw+9DKW8vLiE6Tf9HnxXoHG/PYfY9pDZArA7hKe8r6Egmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ43xTluwFr4327rQXs/VDaiBEFHd4i8fkexdtThPbwgHwhGRA
	gSTQLaLZcOKWE2U74ipZ/x0PyNvW70+W5UoZ1AmXS2i0oV8VhddbfDB4w0YyChlK+JKpFJ7vxY/
	Qr3LeIAks7p6xF0WUxQ9DF/IlnyqZk0BgO385AV/RAppZkwQ5IyQD2eU=
X-Google-Smtp-Source: AGHT+IE4IYNeQIJkvtXY1a26MoxHx13hpOhcZN8eUR7LGcieBhzAi45gBOcQUciC35MP/dFu9sk/CHWT0pMsMekykgH75g9r6pWk
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a01:b0:3a7:d082:651 with SMTP id
 e9e14a558f8ab-3bdc1b2a9aamr5013145ab.12.1734470069221; Tue, 17 Dec 2024
 13:14:29 -0800 (PST)
Date: Tue, 17 Dec 2024 13:14:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracepoint_probe_unregister (3)
From: syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1310a4f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/939c742e99e7/disk-243f750a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76db565b11d6/vmlinux-243f750a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/822230eb0753/bzImage-243f750a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8817 at kernel/tracepoint.c:358 tracepoint_remove_func kernel/tracepoint.c:358 [inline]
WARNING: CPU: 0 PID: 8817 at kernel/tracepoint.c:358 tracepoint_probe_unregister+0x894/0xd70 kernel/tracepoint.c:504
Modules linked in:
CPU: 0 UID: 0 PID: 8817 Comm: syz.3.789 Not tainted 6.13.0-rc2-syzkaller-00192-g243f750a2df0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:tracepoint_remove_func kernel/tracepoint.c:358 [inline]
RIP: 0010:tracepoint_probe_unregister+0x894/0xd70 kernel/tracepoint.c:504
Code: 41 5e 41 5f c3 cc cc cc cc e8 68 27 fe ff 48 c7 c6 60 05 9b 81 48 89 df e8 79 52 e5 ff eb 9f bb fe ff ff ff e8 4d 27 fe ff 90 <0f> 0b 90 eb 91 e8 42 27 fe ff 48 89 da 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc90003427898 EFLAGS: 00010287
RAX: 000000000000951e RBX: 00000000fffffffe RCX: ffffc9000c9ec000
RDX: 0000000000080000 RSI: ffffffff819b16a3 RDI: 0000000000000005
RBP: ffffffff8ecbb240 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffffff81a0da30
R13: 0000000000000602 R14: 0000000000000002 R15: ffffffff8de3f8d8
FS:  00007fe8b075e6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe8b075df98 CR3: 000000007a564000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unregister_trace_sched_switch include/trace/events/sched.h:222 [inline]
 tracing_sched_unregister kernel/trace/trace_sched_switch.c:87 [inline]
 tracing_stop_sched_switch kernel/trace/trace_sched_switch.c:129 [inline]
 tracing_stop_cmdline_record+0x66/0xa0 kernel/trace/trace_sched_switch.c:140
 __ftrace_event_enable_disable+0x73f/0x850 kernel/trace/trace_events.c:645
 ftrace_event_enable_disable kernel/trace/trace_events.c:730 [inline]
 ftrace_clear_events kernel/trace/trace_events.c:739 [inline]
 ftrace_event_set_open+0x238/0x2d0 kernel/trace/trace_events.c:2270
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe8af985d19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe8b075e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fe8afb75fa0 RCX: 00007fe8af985d19
RDX: 0000000000020201 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 00007fe8afa01a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe8afb75fa0 R15: 00007ffd25015738
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
