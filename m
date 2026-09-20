Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1E346798
	for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Sep 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914094; cv=none; b=UnUxPzHzSAFpgze63lgv4IGgep57GGkGblepl8T3JHCxxqW22ZGviTRB8sA/VFGVv4dGzA1YGaV2O/LaMYRWyxS3lskZjbHqqo18g7hdCawDeNwAw/XcMmPGMshfiT6lpoUxWGjfqlBimAo8YxYXdzvhm0oDfHPqbtHJj3RAy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914094; c=relaxed/simple;
	bh=Qs/AXDOMNVTVn/TaIRq5aMfQWNud2BuOIl1r8c5ZrJk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GBDrUDviecv1SQ55YBKkxDQ0c5wDSmDtO1cJzZM1PQBoLycqI4lN5YtF+1equNmNsu3yzbiRaq2/fwce/kMcVmBe7YZ+xRzLPmYPV1oNshhg06l9a+atSSRuXGS8MUIc0f3hxD9hUP2WwcmQic/UTGCe0+iTXtoXZGRwnTUYueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6aafac56856so1049858eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Sep 2026 07:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789914092; x=1790518892;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDF2KQTDPjG+jnet065vgzr3F9yXwCMJD8HQVg75NCQ=;
        b=coPbquDn4MLLqkbukOZSw/ISMUpedqOVteQP8XlfqfSxs9cEeWsU2QO6Sc3vRWfSTI
         htzztw5v7Xf0wd7sAP+FqCI69Qldy7379omdxxVPYTI7iAmeyUJDS+Y/mbxXfvvGoqAa
         6ZVbF5pDtqQtNUpQI4iPwB5Gx+z+3lcUYUJZ+9c5cgf+3vOkcgHBd94saa3j3ubmbXbC
         1E2lozHYJINJW77kCq/duRSzEjXRhHJDbuCY7amLwn6igTkafVEFRmEOyN5KkmwvJYkC
         fSdr67hnusAEb00x8sWVYrR/aMnkUCJauE+6Noh9lQRw4cB/CQDj2y7bMjgyXGphxfvD
         ZOSw==
X-Forwarded-Encrypted: i=1; AKwUvBy9PXRgwi5caUn+7JrBeryR+RcKzn26Mvn6MW0iRsw5ud1BX33BgYitoXHI4c+/nBNVIclewAw6ewPB2oHZ/WNhYFo=@vger.kernel.org
X-Gm-Message-State: AFuF++lazMBszpuV8htuhSyRhuH94PT5qbdxcgbGA9jFiLIZJ9CbQzNS
	ejwDPtBOS59ig4oq9yCLouCt1EzHgEdIkPB9tROwwu8gpjBaYTXTj/IHf3iobqGYxtLNR2lJjE4
	jbOJXNTsjHurDviLPfSrzBYxNNo+Tw8Xfi4EAqOCsFKRiixuw4DBy14aIJMI=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1f03:b0:6b1:ba66:6998 with SMTP id
 006d021491bc7-6ca9a1343a0mr7442248eaf.14.1789914092082; Sun, 20 Sep 2026
 07:21:32 -0700 (PDT)
Date: Sun, 20 Sep 2026 07:21:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aafebec.a6af0033.177e91.000d.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in check_buffer
From: syzbot <syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40288c9206c1 Merge tag 'drm-fixes-2026-09-19' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12daa525580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=eb74dca0d1eb3ec227a7
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/96e6db480769/disk-40288c92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8cb5ded77e9/vmlinux-40288c92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c127cac2df37/bzImage-40288c92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com

 0xe74:  [135187] delta:1 PADDING
 0xe98:  [135188] delta:1 hd
expected end:0xea8 last event actually ended at:0xea8
------------[ cut here ]------------
system_state != SYSTEM_BOOTING
WARNING: kernel/trace/ring_buffer.c:4783 at check_buffer.cold+0x1a2/0x1ef kernel/trace/ring_buffer.c:4783, CPU#0: syz.6.3124/18331
Modules linked in:
CPU: 0 UID: 0 PID: 18331 Comm: syz.6.3124 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
RIP: 0010:check_buffer.cold+0x1a2/0x1ef kernel/trace/ring_buffer.c:4783
Code: 03 0f b6 14 11 38 d0 7c 04 84 d2 75 5c 8b 2d 1c ce 21 10 31 ff 89 ee e8 af f2 e8 00 85 ed 0f 84 c8 8d eb 00 e8 32 f8 e8 00 90 <0f> 0b 90 e9 73 8b eb 00 49 c7 c7 c0 5e f6 8b e9 51 fe ff ff e8 88
RSP: 0018:ffffc900000078d0 EFLAGS: 00010046
RAX: 8000000001000003 RBX: 1ffff92000000f20 RCX: 0000000001000003
RDX: ffff88802d9c4b00 RSI: ffffffff8123277e RDI: ffff88802d9c4b00
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000021015
R13: ffff88801c095000 R14: ffff88805713c000 R15: ffffffff8bf65a60
FS:  00007ff5dabbc6c0(0000) GS:ffff888123b56000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32508ff8 CR3: 0000000084816000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __rb_reserve_next.constprop.0+0x486/0x1640 kernel/trace/ring_buffer.c:4873
 rb_reserve_next_event kernel/trace/ring_buffer.c:5010 [inline]
 ring_buffer_lock_reserve+0x49a/0x1220 kernel/trace/ring_buffer.c:5069
 __trace_buffer_lock_reserve kernel/trace/trace.h:1677 [inline]
 trace_event_buffer_lock_reserve+0x123/0x6f0 kernel/trace/trace.c:1924
 trace_event_buffer_reserve+0x1f9/0x350 kernel/trace/trace_events.c:715
 __eprobe_trace_func kernel/trace/trace_eprobe.c:443 [inline]
 eprobe_trigger_func+0x558/0x1450 kernel/trace/trace_eprobe.c:487
 data_ops_trigger kernel/trace/trace_events_trigger.c:154 [inline]
 event_triggers_call+0x29e/0x4d0 kernel/trace/trace_events_trigger.c:209
 __event_trigger_test_discard kernel/trace/trace.h:1738 [inline]
 trace_event_buffer_commit+0x66b/0xa80 kernel/trace/trace.c:2014
 do_trace_event_raw_event_msr_trace_class arch/x86/include/asm/msr-trace.h:21 [inline]
 trace_event_raw_event_msr_trace_class+0x17d/0x270 arch/x86/include/asm/msr-trace.h:21
 __do_trace_read_msr arch/x86/include/asm/msr-trace.h:40 [inline]
 trace_read_msr+0x160/0x1f0 arch/x86/include/asm/msr-trace.h:40
 native_read_msr_safe arch/x86/include/asm/msr.h:127 [inline]
 rdmsrq_safe arch/x86/include/asm/msr.h:220 [inline]
 __rdmsr_safe_on_cpu+0xc8/0xf0 arch/x86/lib/msr-smp.c:124
 csd_do_func kernel/smp.c:143 [inline]
 __flush_smp_call_function_queue+0x43a/0x8c0 kernel/smp.c:632
 __sysvec_call_function_single+0x81/0x420 arch/x86/kernel/smp.c:272
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:267 [inline]
 sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:267
 </IRQ>
 <TASK>
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:681
RIP: 0010:__vmcs_writel arch/x86/kvm/vmx/vmx_ops.h:224 [inline]
RIP: 0010:vmcs_write32 arch/x86/kvm/vmx/vmx_ops.h:242 [inline]
RIP: 0010:vmx_set_constant_host_state+0x1d4/0x740 arch/x86/kvm/vmx/vmx.c:4498
Code: e8 71 ed 6b 00 b9 74 01 00 00 0f 32 48 c1 e2 20 48 89 d3 48 09 c3 e9 ba 01 00 00 e8 56 ed 6b 00 89 db b8 00 4c 00 00 0f 79 c3 <0f> 86 f5 01 00 00 e8 41 ed 6b 00 b9 76 01 00 00 0f 32 48 c1 e2 20
RSP: 0018:ffffc90003d97828 EFLAGS: 00000202
RAX: 0000000000004c00 RBX: 0000000000000010 RCX: ffffc9000ebc9000
RDX: 0000000000080000 RSI: ffffffff81a0325a RDI: ffff88802d9c4b00
RBP: 00000000003526f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807e391f78
R13: ffff88807e391ed8 R14: ffff888051ff8000 R15: ffff88807e391f78
 init_vmcs arch/x86/kvm/vmx/vmx.c:4946 [inline]
 __vmx_vcpu_reset arch/x86/kvm/vmx/vmx.c:5014 [inline]
 vmx_vcpu_reset+0x117b/0x3160 arch/x86/kvm/vmx/vmx.c:5047
 kvm_vcpu_reset+0x9d1/0x1ae0 arch/x86/kvm/x86.c:9615
 kvm_arch_vcpu_create+0x70c/0xab0 arch/x86/kvm/x86.c:9415
 kvm_vm_ioctl_create_vcpu virt/kvm/kvm_main.c:4213 [inline]
 kvm_vm_ioctl+0x7e3/0x42d0 virt/kvm/kvm_main.c:5178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5d9d9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff5dabbc028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff5da026090 RCX: 00007ff5d9d9e159
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000005
RBP: 00007ff5d9e3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff5da026128 R14: 00007ff5da026090 R15: 00007fff730b6718
 </TASK>
----------------
Code disassembly (best guess):
   0:	e8 71 ed 6b 00       	call   0x6bed76
   5:	b9 74 01 00 00       	mov    $0x174,%ecx
   a:	0f 32                	rdmsr
   c:	48 c1 e2 20          	shl    $0x20,%rdx
  10:	48 89 d3             	mov    %rdx,%rbx
  13:	48 09 c3             	or     %rax,%rbx
  16:	e9 ba 01 00 00       	jmp    0x1d5
  1b:	e8 56 ed 6b 00       	call   0x6bed76
  20:	89 db                	mov    %ebx,%ebx
  22:	b8 00 4c 00 00       	mov    $0x4c00,%eax
  27:	0f 79 c3             	vmwrite %rbx,%rax
* 2a:	0f 86 f5 01 00 00    	jbe    0x225 <-- trapping instruction
  30:	e8 41 ed 6b 00       	call   0x6bed76
  35:	b9 76 01 00 00       	mov    $0x176,%ecx
  3a:	0f 32                	rdmsr
  3c:	48 c1 e2 20          	shl    $0x20,%rdx


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
