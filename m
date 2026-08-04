Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED023EA66
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804756; cv=none; b=CTsvTYBW9fkMfFtwUL9TvzUUaRs6eLSeCTNcElmpuLQgfdka7kC5nPXE1hOoHn0E6GiuU4SkHE6XD2JSdT+0TnXAy97jS7eKwIYjhU4tj4Nm2mgXJ/79IzyXoYYdMwnERjJtEIg9ImrNcMEV1l9upA4h+69eSAVrnOwkgj1p4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804756; c=relaxed/simple;
	bh=0Tx6L4Qo8QGQ19/5hZu680HpO1CBZ7gX+mTlSQEcrwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=upISPHfX/ECmZuvgxReoo+ZT0iltci0QYy9a17Khq6ygRM2KjzQG8mM0Sxqa7bhhfCdwyjqi1sPoX4zGlDv/Oz5gd7w96icVi/wbmCp5M1vQrZNmZtM0VNqUdBRrlxczQddEvx3T1AqcmeaM351DItDGm5zeMpNDHiQgGfYI5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4ab260600easo720218b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 17:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804753; x=1786409553;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Zx4nePtidX2LpRe4z3+M8DWQniD422Mg2mRzXdHuLw=;
        b=J/vSuRzj8UpCyW6a3T3Fc5PP1uvq+CQ8hgZ7SDUieenA9QwSCQId0TeMA8g5bq2exn
         2Z8c0t4FXjrP1Tsgb7qVwY67BkgZQ4LCZx+Mgiwy/OwPUtPSnkAviX4gUaOHO3BreRtA
         Ef7mAOEWd3gA8yjMjY4XreYiMbWosPvXb+z+qZw4lCqO9qfMbrn4lBnHBHi3lt/AattD
         YvdmTdFw2F9i0EeL/eDOzYMMtaOEmmrGq6ZXrBObwLaZUuUP5GwaAAYq0vdoeW5DtF9F
         d73nb8x+rWf7K3ushUq9aUz/1jfbIbtvBqI7m/RT1cjN8YildXFfSv4w1tRHE9WQc15u
         877A==
X-Forwarded-Encrypted: i=1; AHgh+RrzBZx/hgKTBcgJwasLj9P2J5dngsuuFW5I4UQVZs1ToEzWMRE/p41YyiDFYShFB/kJkMfMRxAfuNbN0Radf8qeBUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxco4176k9hvlrj1zmbRKbmIx/IPp13+stNuqyc1TUnGxlvZFrj
	Q2pl6isJnwnjnBr59Cp7AF/MWoiBlQh3HFIoMHdrZFPC2zDwAp3+bmklktXJJD65vw0o77P9w9J
	RqMLUgOUfx7nmm52tASxN6sRmc1njE2+ia0/taFvTDTZwr5RTkAkHC2IokSI=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6413:b0:4a4:66f8:1275 with SMTP id
 5614622812f47-4af98a95c14mr2353931b6e.14.1785804753279; Mon, 03 Aug 2026
 17:52:33 -0700 (PDT)
Date: Mon, 03 Aug 2026 17:52:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7137d1.40259c87.584f4.04ab.GAE@google.com>
Subject: [syzbot] [trace?] KASAN: slab-use-after-free Read in ring_buffer_iter_advance
From: syzbot <syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17954aea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=e0cc44465d6bae735679
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dbf4cb7b4116/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77761f1559a8/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb1ed2bbff0e/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rb_page_size kernel/trace/ring_buffer.c:391 [inline]
BUG: KASAN: slab-use-after-free in rb_advance_iter+0x40e/0x460 kernel/trace/ring_buffer.c:6024
Read of size 8 at addr ffff88802d79b8b8 by task syz.4.389/6869

CPU: 0 UID: 0 PID: 6869 Comm: syz.4.389 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 rb_page_size kernel/trace/ring_buffer.c:391 [inline]
 rb_advance_iter+0x40e/0x460 kernel/trace/ring_buffer.c:6024
 ring_buffer_iter_advance+0x69/0x90 kernel/trace/ring_buffer.c:6445
 trace_find_next_entry_inc kernel/trace/trace.c:2679 [inline]
 s_next+0x270/0x410 kernel/trace/trace.c:2711
 seq_read_iter+0xac5/0x1270 fs/seq_file.c:263
 seq_read+0x344/0x4d0 fs/seq_file.c:163
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f734c99df99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f734d820028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f734cc25fa0 RCX: 00007f734c99df99
RDX: 0000000000001000 RSI: 0000200000000340 RDI: 0000000000000005
RBP: 00007f734ca34ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f734cc26038 R14: 00007f734cc25fa0 R15: 00007ffcf813c748
 </TASK>

Allocated by task 6869:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_node_noprof+0x339/0x830 mm/slub.c:5346
 _kmalloc_node_noprof include/linux/slab.h:1197 [inline]
 __rb_allocate_pages+0x399/0x10a0 kernel/trace/ring_buffer.c:2402
 ring_buffer_subbuf_order_set+0x3ef/0x18a0 kernel/trace/ring_buffer.c:7379
 buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:8221
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6871:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6692
 free_buffer_page kernel/trace/ring_buffer.c:399 [inline]
 ring_buffer_subbuf_order_set+0x116b/0x18a0 kernel/trace/ring_buffer.c:7439
 buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:8221
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802d79b880
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 56 bytes inside of
 freed 64-byte region [ffff88802d79b880, ffff88802d79b8c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d79b
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88813fe238c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 13416095140, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x66d/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 handler_new_ref+0x1ab/0xc60 drivers/media/v4l2-core/v4l2-ctrls-core.c:1895
 v4l2_ctrl_add_handler drivers/media/v4l2-core/v4l2-ctrls-core.c:2456 [inline]
 v4l2_ctrl_add_handler+0x223/0x300 drivers/media/v4l2-core/v4l2-ctrls-core.c:2430
 vivid_create_controls+0x33ce/0x3e80 drivers/media/test-drivers/vivid/vivid-ctrls.c:2072
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1933 [inline]
 vivid_probe.cold+0x4f1e/0x921e drivers/media/test-drivers/vivid/vivid-core.c:2095
 platform_probe+0x106/0x1d0 drivers/base/platform.c:1439
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __driver_attach+0x21f/0x5b0 drivers/base/dd.c:1292
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802d79b780: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88802d79b800: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88802d79b880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                        ^
 ffff88802d79b900: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88802d79b980: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
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
