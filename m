Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEC1F3FE3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879108; cv=none; b=c1/A3JoaNimH08PtJRbxfVOeE8OEOlueHP7A3WO0YkQcxUQ7eKbaBFNVETpDastn5DEHcP6T5vItOxwGlr3jhiZa6T4RhVTBv8LCMLrsomJH9qsR8aVoryM0uGVcFsCPUy15IjTKmJBHVx91LrwKBt41r0QBTw3RYlcnogw3d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879108; c=relaxed/simple;
	bh=Jl5p97JvPpMNZZjBLdrKm3tf2nl8KAnKjiywqyDPw+A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f/AZ2C9KQv8Qw+wOMZd/51eG2WE5fywne5kIr8ngHzNrEShFeI1osdH54KSdZXKNfn0S7WWsAwOyd3kHHRDTBJFJ4kBQLhfVp+ju4s4l8+eJVX3XsTGrCWQqYiiXBDj+xD5NwHb6cYlmLgXyRjgG7WZAeDPNXjwDiiiDeHFUDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d5b3819ff9so5221145ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 01:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744879105; x=1745483905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iH3dpMhc2OuwjjSn4Sybu2yIZvU0GI3H4i2RSnK3ygE=;
        b=iE1/+g5x9HtOgEEMr873sfx28RcWkXklUm25Qu+29+U1adIPRMSgyyu0CI7CpXlR8S
         4Brd8ebXtStw7lRe3AZtjTimfb7q7BedePi1GlXVgIa8ZsIrXssW+VhqNTGVHhgmLh+X
         ktwPHEM0eNbmQlgmj4iSCQkDfvdVwrsLHdYvhC/BO+pwPGoXXNNwjWH1riuNAH/yMHl2
         w3thSOo3Fh9MQsravMrf6p5N4DPDLe97APg9L+v7Ep7FFR0uTcDO4VxvcbwqGv946Oft
         5VzN9pbRxaq+uf0laShtAdzLEOn2cjJ4kE8aEB8gk+ybMKqDNp4O3tYzTHvYuKqajoM3
         BcJA==
X-Forwarded-Encrypted: i=1; AJvYcCW3CcGDhKanAQPof8RdUh3X/rfO61qsELqizmLNy/Tarq47kmXryn/RoXuJWUoQuo5zzWXLcmaEWjq6pouJVF+Xsvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTavQSXcUfLX4vX8BfE+WV2CWoKV1WTul7N1yYVEWhq+fbYo1
	AVDig332VvjrtQURlGE+mnE4b6LvBtZL6/j1n0emAVmdUJQBC4b5pgyYSkw359+IaFKAV6coFyb
	SGqyR1aXKRgMZptRh60+7mAHg8O9W6naFUnWBztLQJaDgOpQ0FJ7ORgU=
X-Google-Smtp-Source: AGHT+IE8cR2SOT5xQKZZ7FDy0oHNspZw/dhWylqFY1H6OT0UEAd6ZzfN99DWJbsEMrvCA2zkodkmSPA/FHwKraiJksNqQCvZbIMy
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:3d8:1231:5ddf with SMTP id
 e9e14a558f8ab-3d815b6d7f1mr54268575ab.22.1744879105701; Thu, 17 Apr 2025
 01:38:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 01:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6800be01.050a0220.243d89.000e.GAE@google.com>
Subject: [syzbot] [trace?] KASAN: slab-out-of-bounds Write in tracing_splice_read_pipe
From: syzbot <syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3bde70a2c827 Merge tag 'v6.15-rc1-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1724ca3f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a4e108575159039
dashboard link: https://syzkaller.appspot.com/bug?extid=c8cd2d2c412b868263fb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/385544917b90/disk-3bde70a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e29d15e8394/vmlinux-3bde70a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2dbcc4712371/bzImage-3bde70a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in trace_seq_to_buffer kernel/trace/trace.c:1830 [inline]
BUG: KASAN: slab-out-of-bounds in tracing_splice_read_pipe+0x6be/0xdd0 kernel/trace/trace.c:6822
Write of size 4507 at addr ffff888032b6b000 by task syz.2.320/7260

CPU: 1 UID: 0 PID: 7260 Comm: syz.2.320 Not tainted 6.15.0-rc1-syzkaller-00301-g3bde70a2c827 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
 trace_seq_to_buffer kernel/trace/trace.c:1830 [inline]
 tracing_splice_read_pipe+0x6be/0xdd0 kernel/trace/trace.c:6822
 do_splice_read fs/splice.c:979 [inline]
 do_splice_read+0x282/0x370 fs/splice.c:953
 splice_file_to_pipe+0x109/0x120 fs/splice.c:1289
 do_sendfile+0x400/0xe50 fs/read_write.c:1374
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64 fs/read_write.c:1415 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f85c958d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f85ca40d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f85c97a5fa0 RCX: 00007f85c958d169
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
RBP: 00007f85c960e990 R08: 0000000000000000 R09: 0000000000000000
R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f85c97a5fa0 R15: 00007ffc310a92e8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888032b6b1e0 pfn:0x32b6b
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888032b6b1e0 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 7260, tgid 7258 (syz.2.320), ts 218621238352, free_ts 218426213422
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1717
 prep_new_page mm/page_alloc.c:1725 [inline]
 get_page_from_freelist+0x1193/0x39b0 mm/page_alloc.c:3652
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4934
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
 alloc_pages_noprof+0x131/0x390 mm/mempolicy.c:2392
 tracing_splice_read_pipe+0x38b/0xdd0 kernel/trace/trace.c:6815
 do_splice_read fs/splice.c:979 [inline]
 do_splice_read+0x282/0x370 fs/splice.c:953
 splice_file_to_pipe+0x109/0x120 fs/splice.c:1289
 do_sendfile+0x400/0xe50 fs/read_write.c:1374
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64 fs/read_write.c:1415 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5857 tgid 5857 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2680
 discard_slab mm/slub.c:2720 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3189
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4151 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4207
 getname_flags.part.0+0x48/0x540 fs/namei.c:146
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 getname include/linux/fs.h:2852 [inline]
 do_sys_openat2+0xb8/0x1d0 fs/open.c:1423
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888032b6bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888032b6bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888032b6c000: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc 00 00
                                                 ^
 ffff888032b6c080: 00 00 00 00 00 00 00 00 fc fc fc fc 00 00 00 00
 ffff888032b6c100: 00 00 00 00 00 00 fc fc fc fc 00 00 00 00 00 00
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
