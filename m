Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6512874E1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Sep 2026 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383657; cv=none; b=L1aAG0vFSHX+3UbKe7GgWKi1svkBtAlkudJ/C5PUI20tx6PpC+aG+1ErYjGMGQe1yOoNVh4UwyTpX+nP3NAAaV9wQvM57F31KteLkLcd5dcp/Ckejw/jJjmHdVNQqm5BB7IQOmuW1RyQoa+WHByRLpk5SUex+BMCBcR/IPkaBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383657; c=relaxed/simple;
	bh=mdiAinkAXpYmukwdbXC7tbisseyfTRTZ7VY+P5Y1t6M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TYsLa54Dzptes93f9ZKac5/al1nKVDqMQp1nzGm9Hr1HrE4ycLpxsVAxdyR+FWOBnOyoUX+J2bj25kf2kRCQtNOVmx17+lbbUcBSMLIzn7tEnArK83AJxx/s8mzmcqgZU9dI4ZT7BMJoS4/T1L46Il8LbZRH2Kiqg/XJUWtxYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cc89e86e4dso2331332b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 17:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790383654; x=1790988454;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzxPm1cEHIXiNkm6IxNTThQZMsXNUzjdddUDfC8itYU=;
        b=Jre08u2nxr0bqaovshpL0JBObLcIBoKoQ+KVqQ8+wIA3w0+Ru8cXoNxbZitelmLY3e
         B22dxScY6zSyZeJX75mIWKU7ohwDbZk+WWCmrd6lQsdlj7tSTgKF+xk9cMiOnhl2s2n0
         ysImwWLp8eIoshC2KVl3QJfO6IEyj206lBeGAJTgxWuWh+CJMzNjRpu9JJwDSOGE6pjq
         4agYMuRbX9600wf7Nb9NzUR0IkP31KP3YKmBqeWwwPgcbL9fbtSAhhpMPV0YlY0epZcF
         /1eVvxT9wKAAVijM6i242eaKGprvkdoTjVPFpU1PdqKsQWfrLEJ30SYQ0Dn5heXogy8q
         uplQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyRuoUjYK+T+LEgS2yqVERYWozewFDBWYVhmNmEqzdMV21dlFFcP5igh/e2HSD8b1e/gbjdAuWr+OG6NYxjBEwRHI=@vger.kernel.org
X-Gm-Message-State: AFuF++lLTYr0AHkTESbZDedP4l6ssk/s1Z/N34zt2Q3jSXoGGGS9Jv4d
	TvcfE5ERSKjODukLUqMZ38bVcIrIj3dL9KaH0WIcIDdcSIRR+Dq5SPWhMBSBHaqqus5Ov1f6vCb
	HaV88gSXwt3IoKc9WIHA26jyTeRyQWAWSrNq9PFJyDueVyEftqRV22ei7NTY=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1816:b0:4cb:f21b:6f95 with SMTP id
 5614622812f47-4d73045f8b7mr7440366b6e.40.1790383653981; Fri, 25 Sep 2026
 17:47:33 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:47:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab71625.80e1c6cc.1e8e5f.003e.GAE@google.com>
Subject: [syzbot] [trace?] KASAN: slab-use-after-free Read in ring_buffer_lock_reserve
From: syzbot <syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    518e5b794c06 Merge tag 'for-7.3-rc3-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f9a005580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=37e1793bdb0061ea3a47
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e68973061b3/disk-518e5b79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a77cf97afca/vmlinux-518e5b79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70ecbc754c60/bzImage-518e5b79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rb_is_reader_page kernel/trace/ring_buffer.c:1353 [inline]
BUG: KASAN: slab-use-after-free in rb_move_tail+0x1653/0x19e0 kernel/trace/ring_buffer.c:3964
Read of size 8 at addr ffff888033712280 by task syz-executor/6764

CPU: 0 UID: 0 PID: 6764 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 rb_is_reader_page kernel/trace/ring_buffer.c:1353 [inline]
 rb_move_tail+0x1653/0x19e0 kernel/trace/ring_buffer.c:3964
 __rb_reserve_next.constprop.0+0x8cf/0x1640 kernel/trace/ring_buffer.c:4854
 rb_reserve_next_event kernel/trace/ring_buffer.c:5010 [inline]
 ring_buffer_lock_reserve+0x49a/0x1220 kernel/trace/ring_buffer.c:5069
 __trace_buffer_lock_reserve kernel/trace/trace.h:1677 [inline]
 trace_event_buffer_lock_reserve+0x123/0x6f0 kernel/trace/trace.c:1924
 trace_event_buffer_reserve+0x1f9/0x350 kernel/trace/trace_events.c:715
 do_trace_event_raw_event_lock include/trace/events/lock.h:49 [inline]
 trace_event_raw_event_lock+0x124/0x2b0 include/trace/events/lock.h:49
 __do_trace_lock_release include/trace/events/lock.h:68 [inline]
 trace_lock_release include/trace/events/lock.h:68 [inline]
 lock_release+0x218/0x310 kernel/locking/lockdep.c:5954
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:208 [inline]
 _raw_spin_unlock_irqrestore+0x1a/0x80 kernel/locking/spinlock.c:221
 debug_object_activate+0x343/0x4b0 lib/debugobjects.c:891
 debug_hrtimer_activate kernel/time/hrtimer.c:486 [inline]
 debug_activate kernel/time/hrtimer.c:529 [inline]
 enqueue_hrtimer+0x75/0x2f0 kernel/time/hrtimer.c:1136
 __run_hrtimer kernel/time/hrtimer.c:2090 [inline]
 __hrtimer_run_queues+0x6ed/0x9c0 kernel/time/hrtimer.c:2131
 hrtimer_interrupt+0x441/0xaa0 kernel/time/hrtimer.c:2250
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x109/0x470 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x51/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:in_softirq_really kernel/kcov.c:167 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:179 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x27/0x70 kernel/kcov.c:213
Code: 90 90 90 f3 0f 1e fa 65 48 8b 05 6c 80 80 12 48 8b 34 24 65 48 8b 15 50 80 80 12 48 63 c8 a9 00 01 00 ff 74 1e f6 c4 01 74 44 <a9> 00 00 00 0f 75 3d f7 c1 00 00 00 f0 75 35 8b 82 3c 17 00 00 85
RSP: 0018:ffffc90000007c80 EFLAGS: 00000202
RAX: 0000000000000104 RBX: ffffc90000007d00 RCX: 0000000000000104
RDX: ffff88802e8e4b00 RSI: ffffffff821554d0 RDI: ffffc90000007d00
RBP: ffff88801d29d600 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8edec4a0
R13: 0000000000000026 R14: ffffffff8bf19b80 R15: ffff88801d29d600
 trace_event_buffer_reserve+0x20/0x350 kernel/trace/trace_events.c:699
 do_trace_event_raw_event_lock include/trace/events/lock.h:49 [inline]
 trace_event_raw_event_lock+0x124/0x2b0 include/trace/events/lock.h:49
 __do_trace_lock_release include/trace/events/lock.h:68 [inline]
 trace_lock_release include/trace/events/lock.h:68 [inline]
 lock_release+0x218/0x310 kernel/locking/lockdep.c:5954
 rcu_lock_release include/linux/rcupdate.h:319 [inline]
 rcu_read_unlock include/linux/rcupdate.h:880 [inline]
 taprio_dequeue+0x161/0x5f0 net/sched/sch_taprio.c:868
 dequeue_skb net/sched/sch_generic.c:322 [inline]
 qdisc_restart net/sched/sch_generic.c:427 [inline]
 __qdisc_run+0x1be/0x1b20 net/sched/sch_generic.c:445
 qdisc_run include/net/pkt_sched.h:121 [inline]
 qdisc_run include/net/pkt_sched.h:118 [inline]
 net_tx_action+0x549/0xf50 net/core/dev.c:5915
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__rb_reserve_next.constprop.0+0x394/0x1640 kernel/trace/ring_buffer.c:4859
Code: 89 ff e8 8f 2b fd ff 4d 39 e7 0f 85 c4 07 00 00 e8 a1 31 fd ff 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <0f> 85 f5 0f 00 00 4c 8b 7c 24 28 be 08 00 00 00 4c 8b 23 4c 89 ff
RSP: 0018:ffffc90005f1f3e8 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffffc90005f1f530 RCX: 0000000000000002
RDX: 1ffff92000be3ea6 RSI: ffffffff820eee0f RDI: ffff88802e8e4b00
RBP: ffff88801c095000 R08: 0000000000000006 R09: 0000000000000228
R10: 0000000000000228 R11: 0000000000000000 R12: 0000000000000228
R13: ffff88801c095150 R14: ffff88801c08c680 R15: 0000000000000228
 rb_reserve_next_event kernel/trace/ring_buffer.c:5010 [inline]
 ring_buffer_lock_reserve+0x49a/0x1220 kernel/trace/ring_buffer.c:5069
 __trace_buffer_lock_reserve kernel/trace/trace.h:1677 [inline]
 trace_event_buffer_lock_reserve+0x123/0x6f0 kernel/trace/trace.c:1924
 trace_event_buffer_reserve+0x1f9/0x350 kernel/trace/trace_events.c:715
 do_trace_event_raw_event_lock include/trace/events/lock.h:49 [inline]
 trace_event_raw_event_lock+0x124/0x2b0 include/trace/events/lock.h:49
 __do_trace_lock_release include/trace/events/lock.h:68 [inline]
 trace_lock_release include/trace/events/lock.h:68 [inline]
 lock_release+0x218/0x310 kernel/locking/lockdep.c:5954
 might_alloc include/linux/sched/mm.h:316 [inline]
 slab_pre_alloc_hook mm/slub.c:4636 [inline]
 slab_alloc_node mm/slub.c:4974 [inline]
 kmem_cache_alloc_noprof+0x63/0x6a0 mm/slub.c:5010
 anon_vma_alloc mm/rmap.c:94 [inline]
 anon_vma_fork+0x8d/0x6a0 mm/rmap.c:391
 dup_mmap+0x10e6/0x2370 mm/mmap.c:1781
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm kernel/fork.c:1595 [inline]
 copy_process+0x4811/0x8370 kernel/fork.c:2310
 kernel_clone+0x176/0x9d0 kernel/fork.c:2769
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2911
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f122a9c6bd2
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007fffda742550 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fffda742550 RCX: 00007f122a9c6bd2
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fffda7426dc R08: 0000000000000000 R09: 0000000000000001
R10: 000055557d0397d0 R11: 0000000000000246 R12: 0000000000000001
R13: 000055557d04ca10 R14: 000000000008d88f R15: 00007fffda742730
 </TASK>

Allocated by task 6453:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5414 [inline]
 __kmalloc_node_noprof+0x342/0x880 mm/slub.c:5426
 _kmalloc_node_noprof include/linux/slab.h:1200 [inline]
 __rb_allocate_pages+0x308/0xfc0 kernel/trace/ring_buffer.c:2483
 ring_buffer_resize+0x71c/0x1ed0 kernel/trace/ring_buffer.c:3357
 __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:4740
 __tracing_resize_ring_buffer kernel/trace/trace.c:4734 [inline]
 tracing_update_buffers+0xd4/0xf0 kernel/trace/trace.c:4979
 ftrace_event_write+0x14a/0x2c0 kernel/trace/trace_events.c:1562
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10552:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6801
 free_buffer_page kernel/trace/ring_buffer.c:418 [inline]
 rb_remove_pages kernel/trace/ring_buffer.c:3169 [inline]
 rb_update_pages+0x675/0xd60 kernel/trace/ring_buffer.c:3268
 update_pages_handler kernel/trace/ring_buffer.c:3279 [inline]
 ring_buffer_resize+0x14af/0x1ed0 kernel/trace/ring_buffer.c:3389
 __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:4740
 __tracing_resize_ring_buffer kernel/trace/trace.c:4734 [inline]
 tracing_resize_ring_buffer+0x10b/0x160 kernel/trace/trace.c:4795
 tracing_entries_write+0x15d/0x220 kernel/trace/trace.c:5741
 do_loop_readv_writev fs/read_write.c:851 [inline]
 do_loop_readv_writev fs/read_write.c:836 [inline]
 vfs_writev+0x5ed/0xdd0 fs/read_write.c:1060
 do_writev+0x13e/0x340 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888033712280
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 freed 64-byte region [ffff888033712280, ffff8880337122c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x33712
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801c0348c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 12447819587
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x67c/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 handler_new_ref+0x1ab/0xc60 drivers/media/v4l2-core/v4l2-ctrls-core.c:1959
 v4l2_ctrl_add_handler drivers/media/v4l2-core/v4l2-ctrls-core.c:2520 [inline]
 v4l2_ctrl_add_handler+0x223/0x300 drivers/media/v4l2-core/v4l2-ctrls-core.c:2494
 vivid_create_controls+0x33bd/0x3e80 drivers/media/test-drivers/vivid/vivid-ctrls.c:2071
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1933 [inline]
 vivid_probe.cold+0x4f1e/0x921e drivers/media/test-drivers/vivid/vivid-core.c:2095
 platform_probe+0x106/0x1d0 drivers/base/platform.c:1507
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __driver_attach+0x21f/0x5b0 drivers/base/dd.c:1292
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888033712180: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888033712200: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888033712280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff888033712300: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff888033712380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	f3 0f 1e fa          	endbr64
   7:	65 48 8b 05 6c 80 80 	mov    %gs:0x1280806c(%rip),%rax        # 0x1280807b
   e:	12
   f:	48 8b 34 24          	mov    (%rsp),%rsi
  13:	65 48 8b 15 50 80 80 	mov    %gs:0x12808050(%rip),%rdx        # 0x1280806b
  1a:	12
  1b:	48 63 c8             	movslq %eax,%rcx
  1e:	a9 00 01 00 ff       	test   $0xff000100,%eax
  23:	74 1e                	je     0x43
  25:	f6 c4 01             	test   $0x1,%ah
  28:	74 44                	je     0x6e
* 2a:	a9 00 00 00 0f       	test   $0xf000000,%eax <-- trapping instruction
  2f:	75 3d                	jne    0x6e
  31:	f7 c1 00 00 00 f0    	test   $0xf0000000,%ecx
  37:	75 35                	jne    0x6e
  39:	8b 82 3c 17 00 00    	mov    0x173c(%rdx),%eax
  3f:	85                   	.byte 0x85


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
