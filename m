Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80861F7557
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337401; cv=none; b=PyJpHNT0H5wT7ME1UiG0HUJsRaRhWMH82Ta/Qu13h5P3GjlrGG//YHinaprqLFZ1KkMZ69ptSdE28jnQg/OAp2P+ddWWoPRysmD8/MM2Dxyr+2jJ1DGoMCcOQHcH+mACnO7GR5MWiTGE1mgjrO6viB1lnugudO6bWbEUeBFegzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337401; c=relaxed/simple;
	bh=jKiW+UOMWLeb/TUU+KqI4B6DZr4mTAbb1o98VT+3zX0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yuwfi7l91pMCO8gYbyPh8w3nPLshS8uMUc6OFf+Ojprlm2AqkYj6hYoPHQNzXBExGxFn3w7KVsktelDK5NPHMtqLYATHoL4LD4xUMfC3rrhiMNDl9KZ0blZePjwHZoUJMUQcX4RzFCCafJdVFdx8DiQ3vRV/b/i2Ck+X30ku8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844e7f9d37dso548119539f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337399; x=1734942199;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuydoaHvkvnVie0LcscPBCMXOfhpcyOljjUXkzRnxxc=;
        b=Q2GRkKqOLtkch5Qp39NYFhkJ/imrBCg6acTVj4xGyIAHn5Xlaxz7BiJQIzeq/sYb71
         Z29pwSIePcA+jMOEQuZjOLHEENGhujzFAnMXkYiIjbPbphGKOCY4GYqrgIOhCW7rTyDB
         4EBzuh2Ej8CZDareHdU1TtHetKXfIHYjAXOYCWc6vl8uDlk62q/dFpRuu9CXi9vpPWf3
         FC1HdTuHwgrSpC5sIz63qQ5Ks1bvASgL8dcrufgRkE52h1K17OMvb0zyS15X0c1xLiEA
         QvYReYp/Fjt85XmoFdSRokB9FZ+Oc9RICCMFST/Oi8Qa+06DbbFS9jgnj91SzziMpyNU
         ajwA==
X-Forwarded-Encrypted: i=1; AJvYcCVLI6Jh9geBiEKiqc59zy7Ik1wKRzwsPxljGWKe+yqoIPHMyTS8SfaaRpEdiofOVoVbsmaGu2Dzmlad9VyW9GyUgtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHtMa9AwNXZSCTUF3AU+bvdMEa4mNmdK12O+AEfzWN9Qwh5wU
	XVVJiMQCFWuNqptkc2rp3TD3r2Qrtj9NShU6Nln+cqrd0Ob2DvdC1EpptoCMaYYIIVTEFLvuvQv
	Q4Wb6QAcK/cfcBhuIsDDwY3+1s3OsE0Cev6LebS4XkJNb6PVtG69wR3M=
X-Google-Smtp-Source: AGHT+IHmixxuPrHHfGxv7VScT2VUXogKBETMuLJAEZZ1qK1qRuiGdcdJxu963kFjbDdkG5YV8sfFwOVs3schOPcdDVCQf/xSMMr7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a7:8cc2:9a84 with SMTP id
 e9e14a558f8ab-3aff4619ab5mr122275795ab.5.1734337399014; Mon, 16 Dec 2024
 00:23:19 -0800 (PST)
Date: Mon, 16 Dec 2024 00:23:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fe376.050a0220.37aaf.011e.GAE@google.com>
Subject: [syzbot] [trace?] KASAN: use-after-free Read in ring_buffer_map
From: syzbot <syzbot+345e4443a21200874b18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f932fb9b4074 Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109b2d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ca24f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14514730580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0d0c95f5364/disk-f932fb9b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/201cf3c7a7b5/vmlinux-f932fb9b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fcb972084579/bzImage-f932fb9b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
Read of size 8 at addr ffff8880767dd2b8 by task syz-executor187/5836

CPU: 0 UID: 0 PID: 5836 Comm: syz-executor187 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
 ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
 tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1786/0x2670 mm/vma.c:2456
 mmap_region+0x127/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a0489e9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1dfacbc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a0489e9f9
RDX: 0000000000000040 RSI: 0000000000000009 RDI: 0000000000000000
RBP: 00007f3a049115f0 R08: 0000000000000003 R09: 0000000000008000
R10: 0000000000000013 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5836:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kmalloc_array_noprof include/linux/slab.h:946 [inline]
 ring_buffer_map+0x1e1/0x9b0 kernel/trace/ring_buffer.c:7120
 tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x1786/0x2670 mm/vma.c:2456
 mmap_region+0x127/0x320 mm/mmap.c:1348
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880767dd280
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 32 bytes to the right of
 allocated 24-byte region [ffff8880767dd280, ffff8880767dd298)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x767dd
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080400040 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5833, tgid 5833 (sshd), ts 84990303308, free_ts 79508073557
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab mm/slub.c:2574 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2627
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3815
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0xf6/0x420 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 slab_free_hook mm/slub.c:2290 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x2ef/0x4c0 mm/slub.c:4700
 file_free fs/file_table.c:76 [inline]
 fput+0x3ad/0x440 fs/file_table.c:505
 path_openat+0xec1/0x2d60 fs/namei.c:3996
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5832 tgid 5832 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 __folio_put+0x32a/0x450 mm/swap.c:112
 folio_put include/linux/mm.h:1488 [inline]
 put_page+0x21e/0x280 include/linux/mm.h:1560
 anon_pipe_buf_release+0x11a/0x240 fs/pipe.c:128
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x641/0x13f0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0xa4c/0xbe0 fs/read_write.c:565
 ksys_read+0x207/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880767dd180: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880767dd200: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff8880767dd280: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
                                        ^
 ffff8880767dd300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880767dd380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
