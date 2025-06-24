Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB8566A;
	Tue, 24 Jun 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790696; cv=none; b=KFyJyV26mXUMdL5g5r0NW2e98I/Vy2t6Ilq15Hr5MrwB0YTghn2FISnUa/MZ8m32UpntNPWWfk5T/sr9KcI35p5ZYYMsByOEi0DVUNaHwtxKu66d5rLGqFTh+xaY2Yo8IhrIu6kMu1vy+8R0YzGT3CU7YuKLu7yxANA/K6EfaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790696; c=relaxed/simple;
	bh=qi4o2cAIfPsl+s/J8UqYgMbTVKha99sx6NL/BEgXfxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJcL/01ZYjIEGpR2XFDnwgwznLgGdVSECBDAHHCQzatIdE1Tkk0Tw1GcXW3mgTqzHdkepAT27Q8ZBpBbXNYo9AxgTob84a5UnG1kHsDSBxuyjYgJ/yklvPIao2QErmpw0Qvh4yI3nVcnl6IMdZBgPN0XrxqANJ4yxxtjUbnOvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7B76B5DAD9;
	Tue, 24 Jun 2025 18:44:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 92F2A6000F;
	Tue, 24 Jun 2025 18:44:48 +0000 (UTC)
Date: Tue, 24 Jun 2025 14:44:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KASAN: slab-use-after-free Read in
 __free_filter
Message-ID: <20250624144447.5c7fbb32@batman.local.home>
In-Reply-To: <6859ea24.a00a0220.2e5631.0044.GAE@google.com>
References: <6859ea24.a00a0220.2e5631.0044.GAE@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zt5iaudbmo7d6uain6955hggy7onk66r
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 92F2A6000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9TzMKdsNfl6CwM5SojxpH0hvQDwAQjKo=
X-HE-Tag: 1750790688-508095
X-HE-Meta: U2FsdGVkX1/MAyW1D+CSiEXCRcJ/RylqunwKipmOkdl6QY0RmpIH7JthzMIC7ZZXwKfdDZsDrDNsk6ztDXRej9MnPDG2RXMJJ0ed9nW2SdnUj8rAG1UbtWX1/rAtiysYRffp0bDbrHYLG8M5o9UQOmrQKeugT8OUieXGjq1VTQTn6MhrMg+x9HpXCSXxOZcwQ7KbNho9vXRvl4yuoeLE0OMs5oqinMF5oUxMa3CONIJnN+YQHH8r/SgsgtcFeZiJX+V5pkR86wrsgZ8z7COC8a4qQfVGNFGCuGr/M6EDRTa6IF0Uws1Cbdc5CHcV3eY7YrxGI3mQLKSnSVt80lQ3/SzQCe/KdzEq/uo9mPO+XyV+6W47fDaeAFdb9iQp5O9cVv1XuX/5EsuYjFtP2Gv7j+4yLGkdDqz83k/NsT41wvbFmnuLFPywfNKmaZuYvrFhjGI9KZiCjQK7peWIkzoEOrteCJzSi6x3qR7Gz/Dh5rOoJVYs2ISYYyzrVU7gaRVxriOhK0vN/WcFsl9O1wbnGwuf05L5JUuy4uhQ61DTTnmihcnthViz7fCI0+GMJeVOWEttcYprKnPizwROmBl/qKNBMhDQM3c+WPsYCQx4X7yQIVHzXz3mphRxh+VY0m08FQOmdWz5Jm4gqycTDC8JxFZZqkq2KyOb3WBC4bTQNVqBa5niMcoUeFA2CcYcsBCl1IuRCNnxHnxWPRxyrQs6vDgalaU+0TaE0svlv1xszaZ8VoYkcklYp8w58iesowcRnSZBwyNQVAFHdOc503km4aozTcf6W3yl

On Mon, 23 Jun 2025 16:58:28 -0700
syzbot <syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    86731a2a651e Linux 6.16-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1611eb0c580000

According to the above, this came right after a fault injection. I
looked at all the kmalloc around the area and I have no idea which one
could have caused this by failing.

[   94.712399][ T5826] FAULT_INJECTION: forcing a failure.
[   94.712399][ T5826] name failslab, interval 1, probability 0, space 0, times 1
[   94.725211][ T5826] CPU: 0 UID: 0 PID: 5826 Comm: syz-executor377 Not tainted 6.16.0-rc3-syzkaller #0 PREEMPT(full) 
[   94.725241][ T5826] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
[   94.725257][ T5826] Call Trace:
[   94.725265][ T5826]  <TASK>
[   94.725277][ T5826]  dump_stack_lvl+0x16c/0x1f0
[   94.725334][ T5826]  should_fail_ex+0x512/0x640
[   94.725370][ T5826]  ? __kmalloc_cache_noprof+0x57/0x3e0
[   94.725404][ T5826]  should_failslab+0xc2/0x120
[   94.725426][ T5826]  __kmalloc_cache_noprof+0x6a/0x3e0
[   94.725457][ T5826]  ? apply_subsystem_event_filter+0xcd2/0x17a0
[   94.725493][ T5826]  apply_subsystem_event_filter+0xcd2/0x17a0
[   94.725530][ T5826]  ? __might_fault+0x13b/0x190
[   94.725565][ T5826]  ? __pfx_apply_subsystem_event_filter+0x10/0x10
[   94.725601][ T5826]  ? _copy_from_user+0x59/0xd0
[   94.725640][ T5826]  subsystem_filter_write+0x95/0x120
[   94.725672][ T5826]  ? __pfx_subsystem_filter_write+0x10/0x10
[   94.725700][ T5826]  vfs_write+0x2a0/0x1150
[   94.725739][ T5826]  ? __pfx_vfs_write+0x10/0x10
[   94.725772][ T5826]  ? do_sys_openat2+0x157/0x1d0
[   94.725797][ T5826]  ? __pfx_do_sys_openat2+0x10/0x10
[   94.725821][ T5826]  ? find_held_lock+0x2b/0x80
[   94.725844][ T5826]  ? handle_mm_fault+0x2ab/0xd10
[   94.725884][ T5826]  ksys_write+0x12a/0x250
[   94.725916][ T5826]  ? __pfx_ksys_write+0x10/0x10
[   94.725958][ T5826]  do_syscall_64+0xcd/0x490
[   94.725996][ T5826]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   94.726019][ T5826] RIP: 0033:0x7f0e994323a9

So I thought I found a place that could have caused a UAF bug, but I
was mistaken :-p

-- Steve


> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ad206eb0100c6a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=daba72c4af9915e9c894
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b16dd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c7bb0c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a4314982a0cf/disk-86731a2a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8acf9467ceed/vmlinux-86731a2a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dddd9a796b01/bzImage-86731a2a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com
> 
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f0e9949d618
> R13: 00007ffeb32f2178 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> ==================================================================
> BUG: KASAN: slab-use-after-free in free_prog kernel/trace/trace_events_filter.c:1288 [inline]
> BUG: KASAN: slab-use-after-free in __free_filter.part.0+0x153/0x160 kernel/trace/trace_events_filter.c:1312
> Read of size 8 at addr ffff88801d78a9a0 by task syz-executor377/5826
> 
> CPU: 0 UID: 0 PID: 5826 Comm: syz-executor377 Not tainted 6.16.0-rc3-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xcd/0x680 mm/kasan/report.c:521
>  kasan_report+0xe0/0x110 mm/kasan/report.c:634
>  free_prog kernel/trace/trace_events_filter.c:1288 [inline]
>  __free_filter.part.0+0x153/0x160 kernel/trace/trace_events_filter.c:1312
>  __free_filter kernel/trace/trace_events_filter.c:1309 [inline]
>  filter_free_subsystem_filters kernel/trace/trace_events_filter.c:1470 [inline]
>  apply_subsystem_event_filter+0x1487/0x17a0 kernel/trace/trace_events_filter.c:2512
>  subsystem_filter_write+0x95/0x120 kernel/trace/trace_events.c:2304
>  vfs_write+0x2a0/0x1150 fs/read_write.c:684
>  ksys_write+0x12a/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0e994323a9
> Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeb32f1f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffeb32f1fa0 RCX: 00007f0e994323a9
> RDX: 0000000000000009 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 0000000000000001 R08: 00007ffeb32f1d37 R09: 00007f0e994a0037
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007f0e9949d618
> R13: 00007ffeb32f2178 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> Allocated by task 13:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  create_new_subsystem kernel/trace/trace_events.c:2742 [inline]
>  event_subsystem_dir kernel/trace/trace_events.c:2815 [inline]
>  event_create_dir+0x906/0xd40 kernel/trace/trace_events.c:3037
>  __trace_early_add_event_dirs+0xae/0x210 kernel/trace/trace_events.c:4199
>  early_event_add_tracer kernel/trace/trace_events.c:4386 [inline]
>  event_trace_init+0x144/0x1f0 kernel/trace/trace_events.c:4540
>  tracer_init_tracefs_work_func+0x12/0x3d0 kernel/trace/trace.c:10480
>  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3321 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>  kthread+0x3c5/0x780 kernel/kthread.c:464
>  ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> Freed by task 5826:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2381 [inline]
>  slab_free mm/slub.c:4643 [inline]
>  kfree+0x2b4/0x4d0 mm/slub.c:4842
>  __free_filter kernel/trace/trace_events_filter.c:1309 [inline]
>  free_filter_list+0xa5/0x240 kernel/trace/trace_events_filter.c:1357
>  filter_free_subsystem_filters kernel/trace/trace_events_filter.c:1463 [inline]
>  apply_subsystem_event_filter+0x12be/0x17a0 kernel/trace/trace_events_filter.c:2512
>  subsystem_filter_write+0x95/0x120 kernel/trace/trace_events.c:2304
>  vfs_write+0x2a0/0x1150 fs/read_write.c:684
>  ksys_write+0x12a/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88801d78a9a0
>  which belongs to the cache kmalloc-16 of size 16
> The buggy address is located 0 bytes inside of
>  freed 16-byte region [ffff88801d78a9a0, ffff88801d78a9b0)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d78a
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88801b841640 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 4520983069, free_ts 0
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
>  prep_new_page mm/page_alloc.c:1712 [inline]
>  get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
>  __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
>  alloc_slab_page mm/slub.c:2451 [inline]
>  allocate_slab mm/slub.c:2619 [inline]
>  new_slab+0x23b/0x330 mm/slub.c:2673
>  ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
>  __slab_alloc_node mm/slub.c:4024 [inline]
>  slab_alloc_node mm/slub.c:4185 [inline]
>  __do_kmalloc_node mm/slub.c:4327 [inline]
>  __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4347
>  kvasprintf+0xbc/0x160 lib/kasprintf.c:25
>  kvasprintf_const+0x66/0x1a0 lib/kasprintf.c:49
>  kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
>  dev_set_name+0xc7/0x100 drivers/base/core.c:3495
>  device_add+0xe59/0x1a70 drivers/base/core.c:3607
>  tick_init_sysfs kernel/time/clockevents.c:758 [inline]
>  clockevents_init_sysfs+0x157/0x2d0 kernel/time/clockevents.c:774
>  do_one_initcall+0x120/0x6e0 init/main.c:1274
>  do_initcall_level init/main.c:1336 [inline]
>  do_initcalls init/main.c:1352 [inline]
>  do_basic_setup init/main.c:1371 [inline]
>  kernel_init_freeable+0x5c2/0x900 init/main.c:1584
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>  ffff88801d78a880: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
>  ffff88801d78a900: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
> >ffff88801d78a980: 00 00 fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc  
>                                ^
>  ffff88801d78aa00: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
>  ffff88801d78aa80: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

