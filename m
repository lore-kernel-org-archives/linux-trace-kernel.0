Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6B1494C3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513799; cv=none; b=WBCPAItUnIhV6b3X42w4tsLzBxPg4g6npfNMHNDM6i9qXsvBb27NYL3d8mf7DzzqtJlNirnzdlA7B9eG86mB4OSiRYh3SeztedOJfcwOcW68DUs3fN1gFDh77ZB3xjG46SP5sMN82RSU37WsVCYYORmxGCKGqkIskTRkLLC1VoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513799; c=relaxed/simple;
	bh=zD1vWO5j3cvBS3yC2axd/UvlqPESp9ZRK1JuBY9btpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a7m5/EvERWDO2wCSFRJmM2QOfFvsD9R83pv592n+1Ya2U6rI4HQS5iA/LlDv1kFmdxx4OBtGFciVCou4UMT5Tz4YpdiuN5uEcvxyX5A/jLe0eHAMrUPVa1Ch83uXusRAD4R2zadsnrR2LdEcgkHINZ8fwjjoWvvD6APiujgP5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso5066965ab.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 01:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513797; x=1735118597;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Gm4AIONcbryyishD6kljR6h0p006gry2hUY3AfYz9o=;
        b=QG7QNs81OsYYznKkFdGWNPfu6uy8ug7C2bSx/kQdQEpcAFpuX6wt0cGl+0B/lnblDg
         gf27x8X+iDqobqFM929RHRyLw5MaFebfEdGwrmugIGcL1BIo4uO4E61Nj9V4nzE/dEX4
         cAd8CvWnjNXycaduUpjT7EB2OIA+fVzZ4h053oreDa5YIqk2FHWsqZ6ozpXAm2BUsmux
         RdhsT7S0kF89tWc2TuPdeZgOZeovm06aGDvbxET/sspbpUl+WRZ4QfVHx4yfuL/4F0jD
         W/FwpUuBm2AUS4o8auGzVfIm1PmFAYSiXbc1JxoJMxMJyneXOpy2rQyBZX4aRT0A+dhB
         SuYA==
X-Forwarded-Encrypted: i=1; AJvYcCWHeMdg+kEc2jjYc6U/MaOQIrM0SRlRMQArBM8zWH6FYVx8iS4PUtAxYBxJ322DiPhAfD3IV0KUZTRQNxkfIVLZx7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgovPRaU2xpqNWOM7hlRDeTD+SD2EBCbT/vgB/0ncghAhVwv2a
	iOjG9Whubdphh2RoNCUNXsm7bM7cE9me/WRrmJBDe4lFRqkY4yeTUWH/HOZLt4MkgPZ6wstDZ23
	AX6JGui7XFfOhOfltNU5I5lXLAkT5yHHDm2yqsv7sVR788tpUYP1V8xg=
X-Google-Smtp-Source: AGHT+IFPsmNf9S/8l3yAJmSYMD14svUDcuAExsGOG/Ev0wrwZEE/wBFO+jtrO1fiDmt2SIrhomcApzjXVRWXeUuGsjr4lgw9FkAY
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3bde3b2160amr16671365ab.9.1734513797263; Wed, 18 Dec 2024
 01:23:17 -0800 (PST)
Date: Wed, 18 Dec 2024 01:23:17 -0800
In-Reply-To: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67629485.050a0220.29fcd0.008b.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracepoint_probe_unregister (3)
From: syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    aef25be35d23 hexagon: Disable constant extender optimizati..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b2cb44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175342df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17140cf8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa655a321f64/disk-aef25be3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/222a3010db12/vmlinux-aef25be3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7eab659ce042/bzImage-aef25be3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5829 at kernel/tracepoint.c:358 tracepoint_remove_func kernel/tracepoint.c:358 [inline]
WARNING: CPU: 1 PID: 5829 at kernel/tracepoint.c:358 tracepoint_probe_unregister+0x894/0xd70 kernel/tracepoint.c:504
Modules linked in:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor241 Not tainted 6.13.0-rc3-syzkaller-00044-gaef25be35d23 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:tracepoint_remove_func kernel/tracepoint.c:358 [inline]
RIP: 0010:tracepoint_probe_unregister+0x894/0xd70 kernel/tracepoint.c:504
Code: 41 5e 41 5f c3 cc cc cc cc e8 68 27 fe ff 48 c7 c6 60 16 9b 81 48 89 df e8 49 52 e5 ff eb 9f bb fe ff ff ff e8 4d 27 fe ff 90 <0f> 0b 90 eb 91 e8 42 27 fe ff 48 89 da 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc90003e0f898 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffffe RCX: ffffffff819b24ff
RDX: ffff88802f9c1e00 RSI: ffffffff819b27a3 RDI: 0000000000000005
RBP: ffffffff8ecbca40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffffff81a0eb30
R13: 0000000000000402 R14: 0000000000000002 R15: ffffffff8de3fcd8
FS:  000055556e1df380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 00000000763aa000 CR4: 00000000003526f0
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
RIP: 0033:0x7efe2dcdd6e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6660cd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efe2dcdd6e9
RDX: 0000000000020201 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 0000000000010bb4 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6660cd2c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
