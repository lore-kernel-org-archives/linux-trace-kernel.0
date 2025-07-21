Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6E1DA10B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108688; cv=none; b=HFSSdYUHzdvpQfBx/LCAUDlVj20e3Qq9QEWaUDxE+14cOhazuPIE/l2iqsoX8h8QtxD0D5gsiuGIjXCmcJSQNXTHZc87G+vjKDxOAUOLoz72I6KWMeqsJyzus0Y9D6S2gaxBHyyFGW+cjDtdcHjhJ5fAvmgRxSsCpBtgkxFMsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108688; c=relaxed/simple;
	bh=xsn36DzIqRNkENrwMmZy+qP/+UZiHwz0SK+p5taFEfg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iAQQVlmuJTiA3DoGsbomodJa8roRpkFMXyv5GdhRAWJwxuA5q9M1OLSHqATslbEVJjLcLUxwR+UCHVY4eI2dFoFl7VV+X66AOE3VIAMRzI4KSCV1S22ZCeDHfhbPeOyirVQEmyqoMgwxnsYXKSHEtWod2msDdTs2DubJ6QLtUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c30329a56so285623839f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108686; x=1753713486;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwYYLiPvqaix5yHtuwZHRVuG84XTu7gs29fzwdxPmGw=;
        b=q/vH9W5YYH1GEFeii8il8imG84YPFrsgU3UzR1vZS5Tm45PYue9EnAZzaL2EiGXdC8
         rguA7psUVzX8GumtCdyVNntxbOHfSjb84LiDIo/nTaxwL3j+ohsUnM4i2mCuabNPYmCB
         uINfL/CCpsE2SUItOBy049yL2U7ew+qMHODW4+pYY75GEk/+lZxhs/F52rMNTMgWqPBm
         sJiZIyrp/E1S+P0uK1KxLv36ouxr8PWeaoZtjnfCHgyxHX9TFBjBlD+YmR2VZOSC3p4Y
         krK2m9mdw5WhaQuLMgJH5R/JTH0bKAankSMhr1QrAqq2uZZ72a+IakpcDotf8mcxl+l8
         9toA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3Pyge8VemicWpHS4hVhy2GNk3NCYQ/udhoDRFqfxJ/RmDW6M4TEEstobluQpqMeRbnVxD5Bk1PhYVEE9k06vOws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42tptciQ1KRUt0ggOvDN/XqnXOgikm0R+k3u033QKgJKhloeP
	uRa3bdrf0Ii9Iw125bJ7wIEIiSlPY/VcL9Q02CMkvNAbWs7sToOi1ncM0I3QQSJRFKub/W+H+fE
	Gw0dUCy+xbSGWQ5YnIW+Zq5YzJxWEOetvyZAeWMihdn9NJ7bMZi3wap9DX6E=
X-Google-Smtp-Source: AGHT+IERNLU5RuHG5R/mnS5vt9XSd6zuQ4bwzG/jYrOr7dkzbDyfgXserzojSo3c6L+kruqlrR0mr0+ZziugDD+8iVtSsD4Gk40X
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:485:b0:879:c608:d1d5 with SMTP id
 ca18e2360f4ac-879c608d725mr2661096939f.14.1753108682751; Mon, 21 Jul 2025
 07:38:02 -0700 (PDT)
Date: Mon, 21 Jul 2025 07:38:02 -0700
In-Reply-To: <4118023.1753106607@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e50ca.a70a0220.693ce.00ed.GAE@google.com>
Subject: Re: [syzbot] [afs?] WARNING: ODEBUG bug in delete_node (3)
From: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in delete_node

------------[ cut here ]------------
ODEBUG: activate active (active state 0) object: ffff888148ef4dd8 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 6466 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 6466 Comm: syz-executor Not tainted 6.16.0-rc7-syzkaller-g89be9a83ccf1 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 e7 83 60 fd 4d 8b 0f 48 c7 c7 80 d1 e1 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 3a 0d c3 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 f7 30 de 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90000a088e0 EFLAGS: 00010292
RAX: 3ffe616a0f195300 RBX: dffffc0000000000 RCX: ffff88802d3a1e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: 0000000000000000
R13: ffffffff8be1d300 R14: ffff888148ef4dd8 R15: ffffffff8b8bde80
FS:  000055556b314500(0000) GS:ffff888125da5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f26e42d56c0 CR3: 00000000342c0000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 debug_object_activate+0x26a/0x420 lib/debugobjects.c:842
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 __call_rcu_common kernel/rcu/tree.c:3079 [inline]
 call_rcu+0xaa/0x9c0 kernel/rcu/tree.c:3214
 radix_tree_node_free lib/radix-tree.c:310 [inline]
 delete_node+0x1b6/0xa50 lib/radix-tree.c:573
 radix_tree_delete_item+0x2b6/0x400 lib/radix-tree.c:1430
 afs_cell_destroy+0x16f/0x2c0 fs/afs/cell.c:522
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_preemption_disabled+0x17/0x120 lib/smp_processor_id.c:14
Code: 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41 56 53 48 83 ec 10 65 48 8b 05 ee 4d 3b 07 48 89 44 24 08 <65> 8b 05 f6 4d 3b 07 65 8b 0d eb 4d 3b 07 f7 c1 ff ff ff 7f 74 23
RSP: 0018:ffffc90003def330 EFLAGS: 00000286
RAX: 3ffe616a0f195300 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88802d3a1e00 RSI: ffffffff8be1c7c0 RDI: ffffffff8be1c780
RBP: ffff88801e0ffe10 R08: ffff88801e0ffe0b R09: 1ffff11003c1ffc1
R10: dffffc0000000000 R11: ffffed1003c1ffc2 R12: ffffffff822c91ad
R13: 0000000000000001 R14: 000000000007332c R15: 0000000000000001
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:745
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 page_table_check_set+0x4ad/0x730 mm/page_table_check.c:124
 page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
 set_ptes include/linux/pgtable.h:292 [inline]
 __copy_present_ptes mm/memory.c:973 [inline]
 copy_present_ptes mm/memory.c:1056 [inline]
 copy_pte_range mm/memory.c:1179 [inline]
 copy_pmd_range+0x4262/0x7000 mm/memory.c:1267
 copy_pud_range mm/memory.c:1304 [inline]
 copy_p4d_range mm/memory.c:1328 [inline]
 copy_page_range+0xc46/0x1270 mm/memory.c:1416
 dup_mmap+0xf57/0x1ac0 mm/mmap.c:1838
 dup_mm kernel/fork.c:1477 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1529
 copy_process+0x16d3/0x3b80 kernel/fork.c:2169
 kernel_clone+0x224/0x7f0 kernel/fork.c:2599
 __do_sys_clone kernel/fork.c:2742 [inline]
 __se_sys_clone kernel/fork.c:2726 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2726
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26e35839d3
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007fff070e2f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f26e35839d3
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 000055556b3147d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 0000000000070948 R15: 00007fff070e3120
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	55                   	push   %rbp
  14:	41 57                	push   %r15
  16:	41 56                	push   %r14
  18:	53                   	push   %rbx
  19:	48 83 ec 10          	sub    $0x10,%rsp
  1d:	65 48 8b 05 ee 4d 3b 	mov    %gs:0x73b4dee(%rip),%rax        # 0x73b4e13
  24:	07
  25:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
* 2a:	65 8b 05 f6 4d 3b 07 	mov    %gs:0x73b4df6(%rip),%eax        # 0x73b4e27 <-- trapping instruction
  31:	65 8b 0d eb 4d 3b 07 	mov    %gs:0x73b4deb(%rip),%ecx        # 0x73b4e23
  38:	f7 c1 ff ff ff 7f    	test   $0x7fffffff,%ecx
  3e:	74 23                	je     0x63


Tested on:

commit:         89be9a83 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16517722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ba21f95b63d6db2
dashboard link: https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
