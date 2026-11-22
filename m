Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306718;
	b=N1PFyx+8chcPcpMCxC9z47a5KpqqAlWQ91zPdV1RtF+hj796dL7BampdY+fQIeCQLOt3
	 JfuD7DNUO+IuErijh+pZq5R7yb80bWsxBKMYFVIiu0c1HZd9sYf6ucMKsU7glg5fb+KCr
	 WJ5biMxKOj9IifDNecN/y4SgP6VDdoEq7180JtgDfMZW20GJoRdG9BOMquTL/kmNJMe30
	 oDYRtw6QmUzpZFapaV91b3/b+d/h48u3qWLR1nAP0vgUZDiT7hD1jFJvuOixSFdbT10Lj
	 ZU32BKwEDJ5AMfc8pU4ftoIjSf24IMKe2RNUEKYlfhKsMU3RFVwvVmPZ1TuLmBF1aog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306718;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=MwfqkXqrvzQI+Lq7eYOVXI3WLvfgCGVzqZRqBbT9lcQ=;
	b=LvOv1f9JCs82JF4NnX9ywPZw/J4bG5x/W1OKXAddqu9YM1mMXYww71tcldABQIuWeOrt
	 pfDJ2mAlsbXAlpr85QDx5G5tdeY0BV7hF1HEypZ7+AxMZzJF9OeEsId8FL7aKieZEdjG0
	 o8S/1KYjNWtiwdSbxyutKlN+NNz7w0ejx+dx87FKsJS3ia07B4PtGWYvwYTWslvdP6FF1
	 aQONcRQTC9qlMYtvAacGPCdAfkSxIyrJzIGMtnWTtYTOcvAbNw9CJeKApYX6SO2zSs4lk
	 yNM3HQzvADHwDubkAb0+EHevAJ5nfWwOb63W+Ie0nTv/W5b9feD0unYM2EvxonlQAtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A8606A69D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 00:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898A8606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-464fb819ac5so2123642fac.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 16:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795306716; x=1795911516;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MwfqkXqrvzQI+Lq7eYOVXI3WLvfgCGVzqZRqBbT9lcQ=;
        b=q4rb3bz1rtsmPyCCBTPvJphz/c1pQvZWlKDpXuRMFGbzPTWOPjv1cWgeXNa6Dso6CL
         jFMOiWnBgC/kGxT+QWWYmhIVKv9C2iQQP2ei4Chhqi7hKm7da+7OBMc70p9XiOOc/NTV
         2hz3YAtV6VLXB6P4bGKrvceqc+CEU1mMxikDyyBRSJsWoQ1rdYWrIo0aCCWinaqKZg9k
         t7JgY+TSw2QmIPdoWfbUgor0n/4QkRnvFZnulKuQwYnoHYVD1WpsfPV/M51HdVHoLZAK
         /BUN/nMn6GQNbDfU+VWxEagmOimWtiSsrVcc6IqCBSIv7PVnMkHpU/cJ0ejOq0N/mRZp
         ekuA==
X-Forwarded-Encrypted: i=1; AL+hErHPgjstAf3QXMP/WIN3eHGiimsskurR6wUHEBDwYY+5hue8ru2hlndwx/1FsRD8+dQlYGd+E7TG6mMzdQi8+DG/+d0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lHvqEcqgA2QUlUWYwuKu9S/kuVJoAtNAVW/XIQW1BAEJG7wF3
	4RsWaZFocFnB9ChPZqk0XnB4xMY+fjBHlUO8UXaUIwInv4jjlbI7W3u83vpbP+vmCOKSD2zyXag
	ZJavbFr/7EeEysPYZO6/SSz+Iext2dtt5JKApx+Ymy37GaJtEPkdC8c8UBzg=
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2208:b0:4d6:92b3:5c8d with SMTP id
 5614622812f47-57a0dd479f9mr9859349b6e.67.1795306716624; Sat, 21 Nov 2026
 16:18:36 -0800 (PST)
Date: Sat, 21 Nov 2026 16:18:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b0234dc.44b41460.34b83f.0019.GAE@google.com>
Subject: [syzbot] [trace?] KCSAN: data-race in __trace_trigger_soft_disabled / apply_subsystem_event_filter
From: syzbot <syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0f871bfb831 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12708a03580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=886d2ddd2d6b664e
dashboard link: https://syzkaller.appspot.com/bug?extid=1faa12be48036b80e416
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/018edb90159d/disk-d0f871bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b27112368dea/vmlinux-d0f871bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f2c7b502c76/bzImage-d0f871bf.xz

AI-generated root cause summary:
`filter_disable()` (and its counterpart `event_set_filtered_flag()`) in
`kernel/trace/trace_events_filter.c` updates `struct trace_event_file::flags`
using non-atomic read-modify-write operations (`file->flags &=
~EVENT_FILE_FL_FILTERED`) instead of atomic bit operations
(`test_and_clear_bit()`/`test_and_set_bit()`). Meanwhile, tracepoint handlers
such as `trace_trigger_soft_disabled()` and `__trace_trigger_soft_disabled()`
read `file->flags` locklessly without `READ_ONCE()`. Writing a failing subsystem
filter via `subsystem_filter_write()` triggers `filter_disable()` while
`sched_switch` concurrently executes `__trace_trigger_soft_disabled()` on
another CPU, causing a KCSAN data race on `file->flags`.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=1faa12be48036b80e416

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1faa12be48036b80e416@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __trace_trigger_soft_disabled / apply_subsystem_event_filter

write to 0xffff888100172888 of 8 bytes by task 5433 on cpu 0:
 filter_disable kernel/trace/trace_events_filter.c:1325 [inline]
 process_system_preds kernel/trace/trace_events_filter.c:2331 [inline]
 create_system_filter kernel/trace/trace_events_filter.c:2486 [inline]
 apply_subsystem_event_filter+0x28f/0xcd0 kernel/trace/trace_events_filter.c:2574
 subsystem_filter_write+0x79/0xd0 kernel/trace/trace_events.c:2523
 vfs_write+0x24f/0x9b0 fs/read_write.c:665
 ksys_write+0xdc/0x1a0 fs/read_write.c:719
 __do_sys_write fs/read_write.c:730 [inline]
 __se_sys_write fs/read_write.c:727 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:727
 x64_sys_call+0x154e/0x2550 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x11e/0x3a0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888100172888 of 8 bytes by task 5440 on cpu 1:
 __trace_trigger_soft_disabled+0x20/0x1a0 kernel/trace/trace_events_trigger.c:217
 trace_trigger_soft_disabled include/linux/trace_events.h:777 [inline]
 do_trace_event_raw_event_sched_switch include/trace/events/sched.h:220 [inline]
 trace_event_raw_event_sched_switch+0x186/0x1a0 include/trace/events/sched.h:220
 __traceiter_sched_switch+0x3f/0x60 include/trace/events/sched.h:220
 __do_trace_sched_switch include/trace/events/sched.h:220 [inline]
 trace_sched_switch include/trace/events/sched.h:220 [inline]
 __schedule+0xc3d/0xd30 kernel/sched/core.c:7383
 preempt_schedule_common+0x12/0x40 kernel/sched/core.c:7565
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:201 [inline]
 _raw_spin_unlock+0x1e/0x30 kernel/locking/spinlock.c:213
 spin_unlock include/linux/spinlock.h:401 [inline]
 zap_pte_range mm/memory.c:2076 [inline]
 zap_pmd_range mm/memory.c:2134 [inline]
 zap_pud_range mm/memory.c:2162 [inline]
 zap_p4d_range mm/memory.c:2183 [inline]
 __zap_vma_range+0x273e/0x2ed0 mm/memory.c:2223
 unmap_vmas+0x216/0x310 mm/memory.c:2292
 exit_mmap+0x1a2/0x650 mm/mmap.c:1315
 __mmput+0x28/0x1f0 kernel/fork.c:1192
 mmput+0x51/0x60 kernel/fork.c:1215
 exit_mm+0x12d/0x1d0 kernel/exit.c:586
 do_exit+0x44a/0x1530 kernel/exit.c:967
 do_group_exit+0xfe/0x140 kernel/exit.c:1123
 get_signal+0xc49/0xd30 kernel/signal.c:3113
 arch_do_signal_or_restart+0x96/0x480 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x161/0x940 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x23b/0x3a0 arch/x86/entry/syscall_64.c:107
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 5440 Comm: syz.1.454 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
==================================================================


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
