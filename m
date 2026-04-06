Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426438E5DA
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505339; cv=none; b=lDXcG1jjnVniFcLwWvX3xiLnUpNj4PQAJDeTeAuWhCKZUsgwBkw8LAAxQLuZCGHp34qaqBI1I3A5qWcq5N4uNpW2puE3dBVFUmZpYuibGCehMukfhmixHZwy9zaLQEklmA9Z910GpZMSgiXIFkJinH/PXS6yJoeB4PeKP0vT/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505339; c=relaxed/simple;
	bh=rQKXXgAqWTg/Dsw0TFfIaXYDxtgCvJ8D3RvPHxOrsZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vB5o/MJLtzr0yzi+0iJaLpggjX7LA7fIL1YbWY/n3yfzs2F36XM1D4szbZxeXBd9J4Fc5XPov/9X4Pffw13UT91bKnPIPrMEyGjVsZzvGw/jlY2MiE1B9mGMA1lKx+QoorYaNemRkigGwvc8Np5GRkYWkB7olvGIsSk+dfZQoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-68582ad07ffso1665209eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 12:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505337; x=1776110137;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDGeSu520UhCd3KRfrM/IDTj8HADwTneGXTVFyZaoHY=;
        b=JdOXv93DlqSjWNaZLk3OKYTnVdzfBP6z2OnxMM8PQhqURs3qVjsfc6NnQhtFuOE+LC
         /Kl8seGYJi3G3RdsR3oWy0uKz8reBtgWg6VpknJ/i27S4J17AbPJ4rwbNSRrroeowhsb
         Np4rr6pV6n9M1MtrsZE9KlExvuuXUn2sCqQHc9/JJHOvDM6AZvBFvX9uI2k+RY5xtO6S
         VAYGlXadgPTOenPewwyIR2hhh52Q/kpQHLYv1ZRAxqygyVEqpYF/fwvyMXzgB5sxzpXP
         z2A2pAuwHsRLNr7uEh1RxRb0LF3R+wR0nsxJ4EVWP7/vej/gVdARSMSBS/NGJnyXjjgo
         0K9g==
X-Forwarded-Encrypted: i=1; AJvYcCVEDYvPnlcMdeyZ6w8ZAY7W8zCKDxE96quWeIvJCc1uYvUGfKXU2FvbElqVdQNU9Vh8BNyPUeI/QFg58gheiSIDXEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KBWE3ZtsRCNqxR266ZJ1VO9BS6pEToX1/suoIV9bGMQqfP2z
	IZo2Vp1I0mIv3nui0CMCWJis4+5U/u9OOSenAfx/qfMsZBeISYfG73em2wdUBACsx8Y2lP5gFR1
	+2jkPqgqC+wMr5cMQcaEafIs5X8+gSHEidnm93TZ7FgAy1OTui42fsPKfrO8=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2088:b0:67d:ec7b:cc9b with SMTP id
 006d021491bc7-6821d83c79emr9482036eaf.16.1775505337374; Mon, 06 Apr 2026
 12:55:37 -0700 (PDT)
Date: Mon, 06 Apr 2026 12:55:37 -0700
In-Reply-To: <691367ae.a70a0220.22f260.0141.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d40fb9.a70a0220.a26f2.003d.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_startstop
From: syzbot <syzbot+774863666ef5b025c9d0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    591cd656a1bf Linux 7.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129136ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
dashboard link: https://syzkaller.appspot.com/bug?extid=774863666ef5b025c9d0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268ad4e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1580b3da580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6382829d7cc5/disk-591cd656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17a325d524d5/vmlinux-591cd656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a06ea295210/bzImage-591cd656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+774863666ef5b025c9d0@syzkaller.appspotmail.com

INFO: task syz.2.19:6128 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:27960 pid:6128  tgid:6125  ppid:5955   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x15dd/0x52d0 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7008
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7065
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7fe/0x1300 kernel/locking/mutex.c:776
 blk_debugfs_lock_nomemsave block/blk.h:740 [inline]
 blk_trace_startstop+0x8f/0x610 kernel/trace/blktrace.c:903
 blk_trace_ioctl+0x314/0x920 kernel/trace/blktrace.c:949
 blkdev_common_ioctl+0x13a7/0x3250 block/ioctl.c:724
 blkdev_ioctl+0x528/0x740 block/ioctl.c:798
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f6ab9c819
RSP: 002b:00007f7f6baad028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7f6ae16090 RCX: 00007f7f6ab9c819
RDX: 0000000000000000 RSI: 0000000000001274 RDI: 0000000000000003
RBP: 00007f7f6ac32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
