Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAF21CC59
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407934; cv=none; b=EUBIbXsfQ3jnNaAz30rxTyxryPb+lvnDtoHgLZa3wCLRL6Ll2OvOpIzKyHuCEZc8TwipY8nx5S0bvQxA6NNoH+SOg6mWLz4c0esOZNtRa+LM2zE6P+tfn/sXC0zDszQKfa6cdK4KFgF+DG1ZTEFSEQN+LkH9AkmNjOLKa3l3Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407934; c=relaxed/simple;
	bh=vZaXN8H1N2/sw2ug3GbJvs1tNtHoFJZkoM0UEGZrXgI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pNZTaULLuaCXlgQV0U6a6fq4wL7LEjrU25Xvjg1/jVg7i0rqx3qjTqPDbZ3ih3oTaPwlJqnuVfygT3DzdNbfIcfoZP8j3Ocg0McAEo9SNUVpu0h2CjSAbJq+AyWidy/Qj27V66fnLhe8/ejzBuKSXfBR8UhmR2Z/w12ny9JZpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69d733e7995so10296815eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 06:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407932; x=1781012732;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARZIzQVUE0jpo8acx2akMryfj/SiIhuVDPZ0tiTjjOE=;
        b=oDZqtACwFYufML5cm1JoBbOVGAohyNGvRmvopf4fDR6xtBv37Cx0XUB/wq75m1ij80
         AT4sljez/KaYOhep2Msr9RlQoD8YCLa2cvoRpZH2IvCIfAGbhELKC9f3K7UjBuIAFpCn
         bUCMHwXTLlffNF7IvYmy+PQnNzEHYukdOk/2YrPkrYMqswOv03bovtu7bi49k3XMe3xw
         A9yQ3vAIIW0l2wQwmadAwEXi7G4Pjp2K8XDkhzuXpvMIh9fQvB1OswYkIkojsRYlxGec
         kRsRfeEAQvFgbwhDyjq6zBreVoaSZpUoBDVdBsQUEET7Ps84L7hJjTzaLWUB9QK8Nz72
         lN6w==
X-Forwarded-Encrypted: i=1; AFNElJ8nbaOK29JwmDrHy3pEtQrsSNBQUM6mZI/Xg8gUQ79z/iJdqpYbIxH0cSlkTiOu3ZWqc7AIfp7rjs2HQS5aeJt/irw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3iMHSDa2i7+uUYioo1VrBWYoJvjIIQLo54AaTd8MOxDm3w2s
	dJUchEARp+WVGM1XelqmKJ/lznBu+Y/OQ8AvXG7ze7oZjsAXbChbKptbeieaPGO2smayamp1h9v
	2OrRJce7OLKkdIW+pR1Gs+RkUbqIUUrr3Zx6GQ1aUDql6M6dU9kfFZHL9+wU=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4ccb:b0:69d:8f47:f66e with SMTP id
 006d021491bc7-69e10382514mr8168659eaf.35.1780407931682; Tue, 02 Jun 2026
 06:45:31 -0700 (PDT)
Date: Tue, 02 Jun 2026 06:45:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1ede7b.b4221f80.1326c5.0003.GAE@google.com>
Subject: [syzbot] [trace?] KASAN: use-after-free Write in ring_buffer_read_page
From: syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7ae89a0c97c Linux 7.1-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f06e2e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58acee1ac5406016
dashboard link: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9b0c5b4e3645/disk-e7ae89a0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed163d3ad68b/vmlinux-e7ae89a0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2408b333334/bzImage-e7ae89a0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ring_buffer_read_page+0xd51/0x15a0 kernel/trace/ring_buffer.c:7059
Write of size 16308 at addr ffff88805ceb404c by task syz.3.1872/14532

CPU: 0 UID: 0 PID: 14532 Comm: syz.3.1872 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 ring_buffer_read_page+0xd51/0x15a0 kernel/trace/ring_buffer.c:7059
 tracing_buffers_read+0x2bf/0xaf0 kernel/trace/trace.c:7129
 vfs_read+0x1e4/0xb30 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x830 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb1aad9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb1abca5028 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fb1ab015fa0 RCX: 00007fb1aad9ce59
RDX: 0000000000001000 RSI: 00002000000002c0 RDI: 0000000000000008
RBP: 00007fb1aae32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb1ab016038 R14: 00007fb1ab015fa0 R15: 00007ffec139a1b8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5ceb4
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x44dc0(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 5959, tgid 5958 (syz.1.37), ts 95924498456, free_ts 95918916027
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x11a6/0x33b0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5226
 __alloc_pages_noprof+0xb/0x110 mm/page_alloc.c:5260
 __alloc_pages_node_noprof include/linux/gfp.h:289 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:316 [inline]
 alloc_cpu_data+0x60/0x130 kernel/trace/ring_buffer.c:406
 ring_buffer_alloc_read_page+0x430/0x560 kernel/trace/ring_buffer.c:6801
 tracing_buffers_read+0x603/0xaf0 kernel/trace/trace.c:7110
 vfs_read+0x1e4/0xb30 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x830 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5946 tgid 5945 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0x747/0x1040 mm/page_alloc.c:2943
 tlb_batch_list_free mm/mmu_gather.c:161 [inline]
 tlb_finish_mmu+0x27d/0x810 mm/mmu_gather.c:552
 exit_mmap+0x454/0xa10 mm/mmap.c:1313
 __mmput+0x12a/0x410 kernel/fork.c:1178
 mmput+0x67/0x80 kernel/fork.c:1201
 exit_mm kernel/exit.c:582 [inline]
 do_exit+0x8b2/0x2af0 kernel/exit.c:964
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1119
 get_signal+0x20ff/0x2210 kernel/signal.c:3037
 arch_do_signal_or_restart+0x91/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x8b/0x4f0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x6f2/0x830 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805ceb4f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88805ceb4f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88805ceb5000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88805ceb5080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88805ceb5100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
