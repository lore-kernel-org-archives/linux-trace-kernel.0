Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CE38F927
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Aug 2026 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833761; cv=none; b=j8G/B7WezSE3pERwKa9luozdF8pSkPs9oPfZD+FsfxTbHZjhzNzfaiRYwsx+vf1+fWeNOL6YFDQbFO9MVku3IpA+8MfGZLCD/W3prsWwFh6w9msn6v6OqfZEWVuz+3F0UPQgcYZQYAsNGaa2R+JMLyqKXGy40Q2zEWHPVetaQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833761; c=relaxed/simple;
	bh=taFlypfKrizkgo1VMdBvvtQKRCn6dfhCIfDYFu/Rx/4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QRRo6KINmM3GdZqmyNMW79HXAbxP345yubpB9lJM4631rwbzIfNKZhhqPCoDMCXuGwR9sPZMC5DFxEIfCF4FmgqDvXg7jDsdpBGmm8FDn/mYqBPX/RQuKu0uflSKtg1jgc9xIpUsK9YSYOYgcclIexFSE6MHpsGXS0E0jvafjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7ee4eec47bbso3118847a34.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Aug 2026 15:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786833758; x=1787438558;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NT73SiAUaTbYTOnE9lEy0UO8wuGbNtq67ysS9z3zuo=;
        b=q1lmth2FCWo7adipREtCHFwqhN4pqZZcCq9I24KwI1poWm/BKEZW1mTTyT2acS6sf+
         jMXtPzwvnhJt8ZouubnINsxOqnq/JPG/uokpMXLD/N2hwH/b69QQYX08sYCj/faF0GHF
         Pmjefi19v5QNvvoFnSu+qIRAHtG3EVVZf6fsxYW3xRvVLlCpJenHKggTa7ZGj3qlxbF4
         iZN9RCgiIWBDt4zMWnjA/Pxk4h/1fBun5xZPmKcngzqfXlgHZrEIEdhHUClQVtTRTCjV
         NnFhlkWeUKsNuc4MfpbXAHwO8PEovGEF4UT6DAhmrR4zI91ARiKR/afwtl+H3NXn1Ixv
         Mw0w==
X-Forwarded-Encrypted: i=1; AHgh+Ro3cRHvlp/IsyxBsNS3JKnqvDMRwW3t64kf7Iysh/RCvRspwoqqQO6Sbe8OH3BKIn7YPGAODYtmfuFJOmctsCa6Jck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOi5QCDgrQ2PzPoB2U6D1crW6nsVdqfPKIOcvxKqqLAw31eavy
	Z9eg9BAYpEFLOXVsuVh7ec6PulCngUUTG66VLXdiLYkUOEaaDMpqpsImRIPNa7JFIukcRIrY3jg
	+nq5EkpipGFpAwWwDyG4Ku2RyicC7H90HB4SOGoVBkQnbUm6C+DcyM3mBwNo=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c08:b0:69e:98c0:4bd6 with SMTP id
 006d021491bc7-6b0d5fd35a8mr15031996eaf.1.1786833758609; Sat, 15 Aug 2026
 15:42:38 -0700 (PDT)
Date: Sat, 15 Aug 2026 15:42:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a80eb5e.dbb3a75c.20434b.0020.GAE@google.com>
Subject: [syzbot] [trace?] INFO: task hung in ftrace_set_clr_event
From: syzbot <syzbot+1b4a3085f6696737b17c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5bbbfec59b4 Merge tag 'probes-fixes-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e49079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaf0da806f995318
dashboard link: https://syzkaller.appspot.com/bug?extid=1b4a3085f6696737b17c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150d92c6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08bbc8b1ab0d/disk-f5bbbfec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88902debf200/vmlinux-f5bbbfec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6cb284c6dea8/bzImage-f5bbbfec.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b4a3085f6696737b17c@syzkaller.appspotmail.com

INFO: task syz.0.17:6034 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27496 pid:6034  tgid:6033  ppid:5744   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 __ftrace_set_clr_event kernel/trace/trace_events.c:1409 [inline]
 ftrace_set_clr_event+0x3ba/0x5c0 kernel/trace/trace_events.c:1460
 ftrace_event_write+0x1fe/0x2b0 kernel/trace/trace_events.c:1548
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc695d9e0d9
RSP: 002b:00007fc696c90028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc696025fa0 RCX: 00007fc695d9e0d9
RDX: 0000000000000002 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007fc695e35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc696026038 R14: 00007fc696025fa0 R15: 00007ffd5a54d898
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/12:
4 locks held by kworker/1:0/24:
 #0: ffff88801b02b140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801b02b140 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc900001e7c40 (reg_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc900001e7c40 (reg_work){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff90027f40 (rtnl_mutex){+.+.}-{4:4}, at: reg_todo+0x1c/0xa40 net/wireless/reg.c:3205
 #3: ffff88806a4807a0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6884 [inline]
 #3: ffff88806a4807a0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_process_self_managed_hints+0x8d/0x160 net/wireless/reg.c:3195
1 lock held by khungtaskd/32:


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
