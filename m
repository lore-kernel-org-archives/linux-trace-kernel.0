Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337132C21C4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094552; cv=none; b=rkbpF2fpLs8AmAPoO4Tl58Oy+o1Suj2Q60Sj/i/+DlLd4iiDBCVmddPRtEif3FtakIxvMt8vWHHd/Nt5fv7nhg74m8sWPWys7UZPxbbX9K4Wc2MOqUOAtv/1eLXDrsssoxaTUhu9PJXwo+iTrPe9ZZEEp8F3I1FOzCdk0emdRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094552; c=relaxed/simple;
	bh=qrGFhg5WT3DOPxngEx+/kFuqD/NLTeCoizzn5aPU/EE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bvG7IYRQWG1YzdLq483WjTAq9DWtJ1uH5VuCdYR3VePDQcMmdQSxE0r9wftx7M4wYfzIyqB7rUbyH/8j2hBHpq9Ja/VeH9yVemus48U0yWVww95Q4jCIxBgRmF9nYmEf7W8/jNAAo7E0Cr3kWvpw4hvAlhrgwTyVoeNGQHQCEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.215.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-c9667280edeso1018080a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 09:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783094550; x=1783699350;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+XlT/udmksp1MqsyyiHaPibPUNp5uUe160MurL5lAw=;
        b=ar4nBLFwuwIpytXimKC2hA+RztAg3S4OM9N7J/DAu/z+7sOgm0yrarD5YHgMVz+niD
         ss4uXb3QBv4H1Jqtmem7oHWaGzBaMEZVvmRXyI5B79A2yYLv2fHUB+Z43c0y/y7TpKJb
         IXtZgx9KvooqPBktQURnhwur8McmFqy8SgCye2un6TaVW2HNSnzQV296rMiXtDXq31Q0
         3s/yuznS4jo5Dwg8yQ5kgMrLXjYVvy7JzV3VDNmR9asX3hWlAmWdBDRrVwT1KusWuz75
         5+EfL5q63lYUQ4lOuoqbjj/zif38eGts0aDiri4FWHMKortPvNzhiw2iIt0VpQR5gYsa
         uH8A==
X-Forwarded-Encrypted: i=1; AFNElJ8EAHDZaf5c4M974B/rF031/pYSR6qVTi6XuSXJBhIbyPBaAnp2Yl0hhhMyoIp5Buf8LNM85XGWg+LlRdFSsDJVhG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5UssfFSAOqnZkzxCN8DsIzZBuzzfORwCYASKGmu31Gj1ID1L
	YbUXh+zbS8+w8y8DVaNsypd1Np+IG3+7riIVk62oEB9diVw3cUkxki3xMBmFT++4fXRokSVNQKx
	xkbuH4EIoLD2CH/vsR9axTmDusUjG5dANr+Vl1UZy86N9NuhlQKXyJeZawwY=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a21:7a9c:b0:3bf:b931:b3ec with SMTP id
 adf61e73a8af0-3c03e5138f7mr17823637.57.1783094550469; Fri, 03 Jul 2026
 09:02:30 -0700 (PDT)
Date: Fri, 03 Jul 2026 09:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a47dd16.6912059f.e0473.000e.GAE@google.com>
Subject: [syzbot] [trace?] [usb?] general protection fault in mas_start (2)
From: syzbot <syzbot+0255c92c72505dcacba6@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com, 
	oleg@redhat.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12610e1c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a
dashboard link: https://syzkaller.appspot.com/bug?extid=0255c92c72505dcacba6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f8261580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dc59e4fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ee1f0ea24f2/vmlinux-dc59e4fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/729e963a1370/bzImage-dc59e4fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0255c92c72505dcacba6@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 UID: 0 PID: 5746 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
RIP: 0010:mas_start+0xfe/0x550 lib/maple_tree.c:1179
Code: 4c 02 00 00 c6 43 4c 00 48 8b 44 24 28 42 80 3c 30 00 74 08 48 89 df e8 70 61 87 f6 4c 8b 23 49 83 c4 48 4c 89 e0 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 e7 e8 53 61 87 f6 4d 8b 24 24 e8 aa 9b
RSP: 0000:ffffc900034ff898 EFLAGS: 00010206
RAX: 0000000000000011 RBX: ffffc900034ff960 RCX: 1ffff9200069ff35
RDX: 1ffff9200069ff2c RSI: 0000000000000001 RDI: ffffc900034ff988
RBP: 0000000000000001 R08: ffffffff8baf8bfa R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8e959c20 R12: 0000000000000088
R13: ffffc900034ff960 R14: dffffc0000000000 R15: 1ffff9200069ff35
FS:  0000000000000000(0000) GS:ffff88808c815000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f53e2bc58d2 CR3: 000000000e746000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mtree_load+0x1f5/0x780 lib/maple_tree.c:5657
 vma_lookup include/linux/mm.h:4238 [inline]
 __in_uprobe_trampoline arch/x86/kernel/uprobes.c:766 [inline]
 __is_optimized arch/x86/kernel/uprobes.c:1056 [inline]
 is_optimized arch/x86/kernel/uprobes.c:1067 [inline]
 set_orig_insn+0x226/0x310 arch/x86/kernel/uprobes.c:1098
 register_for_each_vma+0xa0e/0xb80 kernel/events/uprobes.c:1318
 uprobe_unregister_nosync+0x118/0x1b0 kernel/events/uprobes.c:1343
 bpf_uprobe_unregister kernel/trace/bpf_trace.c:2982 [inline]
 bpf_uprobe_multi_link_release+0x99/0x1a0 kernel/trace/bpf_trace.c:2993
 bpf_link_free+0xdd/0x3e0 kernel/bpf/syscall.c:3395
 bpf_link_put_direct kernel/bpf/syscall.c:3448 [inline]
 bpf_link_release+0x6b/0x80 kernel/bpf/syscall.c:3455
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1004
 __do_sys_exit kernel/exit.c:1114 [inline]
 __se_sys_exit kernel/exit.c:1112 [inline]
 __x64_sys_exit+0x40/0x40 kernel/exit.c:1112
 x64_sys_call+0x2231/0x2240 arch/x86/include/generated/asm/syscalls_64.h:61
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd88699ce59
Code: Unable to access opcode bytes at 0x7fd88699ce2f.
RSP: 002b:00007fffde6e40f8 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
RAX: ffffffffffffffda RBX: 00007fd886c15fa0 RCX: 00007fd88699ce59
RDX: 0000555576db0808 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fd886a32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd886c15fac R14: 00007fd886c15fa0 R15: 00007fd886c15fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
RIP: 0010:mas_start+0xfe/0x550 lib/maple_tree.c:1179
Code: 4c 02 00 00 c6 43 4c 00 48 8b 44 24 28 42 80 3c 30 00 74 08 48 89 df e8 70 61 87 f6 4c 8b 23 49 83 c4 48 4c 89 e0 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 e7 e8 53 61 87 f6 4d 8b 24 24 e8 aa 9b
RSP: 0000:ffffc900034ff898 EFLAGS: 00010206
RAX: 0000000000000011 RBX: ffffc900034ff960 RCX: 1ffff9200069ff35
RDX: 1ffff9200069ff2c RSI: 0000000000000001 RDI: ffffc900034ff988
RBP: 0000000000000001 R08: ffffffff8baf8bfa R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8e959c20 R12: 0000000000000088
R13: ffffc900034ff960 R14: dffffc0000000000 R15: 1ffff9200069ff35
FS:  0000000000000000(0000) GS:ffff88808c815000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa41db45000 CR3: 0000000012fed000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	4c 02 00             	rex.WR add (%rax),%r8b
   3:	00 c6                	add    %al,%dh
   5:	43                   	rex.XB
   6:	4c 00 48 8b          	rex.WR add %r9b,-0x75(%rax)
   a:	44 24 28             	rex.R and $0x28,%al
   d:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 70 61 87 f6       	call   0xf687618c
  1c:	4c 8b 23             	mov    (%rbx),%r12
  1f:	49 83 c4 48          	add    $0x48,%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 e7             	mov    %r12,%rdi
  34:	e8 53 61 87 f6       	call   0xf687618c
  39:	4d 8b 24 24          	mov    (%r12),%r12
  3d:	e8                   	.byte 0xe8
  3e:	aa                   	stos   %al,%es:(%rdi)
  3f:	9b                   	fwait


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
