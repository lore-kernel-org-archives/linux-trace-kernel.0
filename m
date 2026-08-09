Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD58B640
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786312293; cv=none; b=t5cSBgvwbWIh162vdPgZOX74OVk9ZtRiE9U1by7G+8sFnzsS7uZ6aHqvKdnfN1vM9oJpbmGkiU+s7dpS6Lq8rdkDoW0yEYA5op9KLf8FcLJYNK8v9/gPtftEbJqW/RKqN3r1mUoq/b5E7BYMcdxsx/2Q/beGjynZEalom9h22UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786312293; c=relaxed/simple;
	bh=WY9FAFiTekcTQzamWFn7NLA8/c0tUAy11t7oHE+rePY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T2BVHTNzT4YL/uOclSYeVYmDPX5mrphxU09msJMuDwOlwPiMi3tqUtce7DuE6oUQVeeOUfPpYhj9bd0j4HzdelntnAaHrqlu+oIQ/SOrnCYBMKN5eCbbiBjayZVuaO4C4Xkhbp33ktezNUzr3iTNG6ytd5RzhgW/Oq/B6a8nJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6aaefd6909fso498607eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 09 Aug 2026 14:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786312290; x=1786917090;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1ZlWHjVY7ndYW1ZsOFi+iZRZGVj81O6tO9Dw18q/yM=;
        b=dv43Yz0PAx1K0p1AH/GLqUjTrByrbl4UYmdqOgY3eCQeuxSNIKumEGnH/2G5hdh6V8
         8eOInRG15lkCxM7QWYnQoggqi2Lh02EvRFCEfRMpzvrQFRLXDKzOZ5wIktT9UVqfS0I6
         aJTirOdR0LW83XMj+eFSBmtt/ttlv7qRFbNVhAxE7c45TC+6RXUCQ/Qd4qvGUdC7kYEo
         J0hV1fxyqpHifFGZkSLmow58ZPcbv2AQAXZXEId6MJymHS3BOTRHj0jL05xp0GPI5cqG
         h8/R84W0CMhgkLBzND+2/SBHZCSW0XDMm9Jo4YI8ZcnxY4mgKlUeXY0KPzg0mFs2M6f7
         a9bQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwlL35TEJBXYWewKKGEDEIAwp6Ai0cFcF4zXLcBIRARW7J1jZwzGk8aikiLnQ1+DzO78a6y5vbIXEOg1fDPf25TNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdf3STb2s5l1PeZ0OOHl6Niu4XQjfdQ+gsCmfZ++grhPnL3M09
	hFJhkG85N9SlA+SOuPwjQgakbnSUPFxkoGvOE7hPoJS107zxproUsm96y3UkSHRBJaUWFlV3DgV
	zEVViklp5PRlaA1QukhMxJ8SzQ9wMSk7uYOjimouSGuU9xtd/kER8L6XAG74=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:208c:b0:69e:3e6b:c07 with SMTP id
 006d021491bc7-6ae96c1edb3mr19908278eaf.5.1786312290501; Sun, 09 Aug 2026
 14:51:30 -0700 (PDT)
Date: Sun, 09 Aug 2026 14:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a78f662.b50370da.49fe0.0045.GAE@google.com>
Subject: [syzbot] [trace?] KASAN: use-after-free Read in ignore_event
From: syzbot <syzbot+0b5074bf48547b3a63ac@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3708dd948844 Merge tag 'pm-7.2-rc6' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17557a49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7079b368dcec295
dashboard link: https://syzkaller.appspot.com/bug?extid=0b5074bf48547b3a63ac
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3cbcba767cb8/disk-3708dd94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37b77da165c5/vmlinux-3708dd94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f4930dc3972/bzImage-3708dd94.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b5074bf48547b3a63ac@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ignore_event+0x83e/0xaa0 kernel/trace/trace.c:2526
Read of size 2 at addr ffff88804705a1ac by task syz.6.1383/11771

CPU: 0 UID: 0 PID: 11771 Comm: syz.6.1383 Tainted: G S                  syzkaller #0 PREEMPT(full) 
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 ignore_event+0x83e/0xaa0 kernel/trace/trace.c:2526
 trace_event_printf+0xb5/0x160 kernel/trace/trace_output.c:356
 trace_raw_output_sys_enter+0x4c/0x60 include/trace/events/syscalls.h:18
 print_trace_fmt kernel/trace/trace.c:3071 [inline]
 print_trace_line+0x97d/0x1790 kernel/trace/trace.c:3237
 tracing_read_pipe+0x586/0xd60 kernel/trace/trace.c:5444
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f48cdd9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f48cebb5028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f48ce025fa0 RCX: 00007f48cdd9e019
RDX: 0000000000002000 RSI: 0000200000001000 RDI: 0000000000000003
RBP: 00007f48cde3500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f48ce026038 R14: 00007f48ce025fa0 R15: 00007ffe7508fde8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4705a
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00009a6048 ffffea00007bac08 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x44dc0(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 9023, tgid 9022 (syz.6.770), ts 304966657874, free_ts 587151444439
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 __alloc_pages_noprof+0xb/0x110 mm/page_alloc.c:5338
 __alloc_pages_node_noprof include/linux/gfp.h:291 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:318 [inline]
 alloc_cpu_data+0x60/0x160 kernel/trace/ring_buffer.c:427
 __rb_allocate_pages+0xbd5/0x10a0 kernel/trace/ring_buffer.c:2436
 ring_buffer_resize+0x6df/0x1e80 kernel/trace/ring_buffer.c:3270
 __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:4738
 __tracing_resize_ring_buffer kernel/trace/trace.c:4732 [inline]
 tracing_update_buffers+0xd4/0xf0 kernel/trace/trace.c:4977
 event_enable_write+0x23f/0x340 kernel/trace/trace_events.c:1926
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 11775 tgid 11774 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 free_buffer_page kernel/trace/ring_buffer.c:398 [inline]
 ring_buffer_subbuf_order_set+0x12d5/0x18a0 kernel/trace/ring_buffer.c:7439
 buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:8221
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804705a080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804705a100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88804705a180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                  ^
 ffff88804705a200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804705a280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
