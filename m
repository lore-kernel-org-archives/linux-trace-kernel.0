Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998D3D75A0;
	Sun, 20 Sep 2026 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789935423; cv=none; b=kfBKOgJVNagS0zOMitGJdABeAudV5cpcNIxB9j3TLQIQnKjbg25wKjunpH1W7V1U61gNgCXehNxwM6VHnYFHKrXOospWKNqEqKho8LzaszbwCtnnKJyQHGpyyYln6oOX3IC7x9OVT6w3zQHZVhlEEs2craaHYIhGp7/DKItCPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789935423; c=relaxed/simple;
	bh=w++8gTMzRxI9s5QCFej8oplWsydlu9QrlItR7hCkKPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DM96Jx37uRugn4m4WDIp4riBNg0/Vyysw5XMh4YnkO4+XmqUGQdS5MvwOhBQ0woDSeGY49uexq7Qv+EGhvjHL+IgZkiTJN4GP+9Au5ginar35mNV0Gz13upYVyIt/z+P96W0ul5steaIH+6nuD+3vE4IRUEwLg/PyTTg/alDQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=vz95jlaq; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="vz95jlaq"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 93ED1A60F5;
	Sun, 20 Sep 2026 20:16:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 394956000D;
	Sun, 20 Sep 2026 20:16:51 +0000 (UTC)
Date: Sun, 20 Sep 2026 16:16:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in check_buffer
Message-ID: <20260920161648.7d9fda60@fedora>
In-Reply-To: <6aafebec.a6af0033.177e91.000d.GAE@google.com>
References: <6aafebec.a6af0033.177e91.000d.GAE@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 394956000D
X-Stat-Signature: 98cmxed7js1dkdj8ayfwof81sdbddr8j
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX193pxsmSY7Xg+3RzUxzkE473CRNXBD3uNs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=nMAD7azh90+YnIIvBYrly5kz7oKOV8FjGqfCJWc1m4E=; b=vz95jlaqX3cUWGa85xJYynYI5yDlm2SWNFWZW94zbIs/nazCcpTuCDgwoDjy5GePID13UUo/ZWEE7+qq0qKKW4RwLm//eAcIZJM5dN18te80USPpmUQoio+GG3t42s+QsXvfZjzfwNvNlqo/wXAmFTA9Rv3S5k+VVXyvJ8Hxs8Q=
X-HE-Tag: 1789935411-210911
X-HE-Meta: U2FsdGVkX1/ZKk2gjELb5uzYq3REofw5uBgN1CZl1OoHQNyqlBYAClkpn1gn7ZmGNp3CYvGQO1IOthB4f8icHur9J1u2lscSvjwOWfsGhUkyMbyNmGZvz7xm6Njek3Ys3lsy1ORKHRe9266KqzCnEtoMnJl6aeKoMI3aFwMvNq0X5eG6WA0kDivlm/4swdAT2JQtV5xxbnBU9EWxGBx54PeAXAxB9Myl7PgIwSrW1Y1QOCgqX9Sm2aGcnxxVYOcb6Y0YV4iFe4DE5X7fPJXr01Jk95f+as6F21R3A0ULDOP8YguqUHuYXgYA9/SooO5Mw7uWuwlG/OwS6APaIyJ6N8DKpGd9IJgvp6niYLLrJdrJgjtUR6dWotvo5PokLIgMaTvHM1qYf0vunrnDdx4w8BrIjR5TaRhqYT1jGm4CeoX/zQ6N3TcYq4bnA22Qt1aqZgxvv305PD6Xt8akv4Vl3a/Nqj+9YjhfRffN/PVqI0i0+BO2ag4iF2KE+HsRLOka2CrMvToGXX4qr09yAssgz3zACd6JgCL31DjcH0rOEFuK2rdRr+FXqAap83NIu/BzvOIRKLBk+tSLgOodk3HvGNqCdaZnC8VZ2C7hWeXwZIgBk1ys2rBfH9cdxgeSygRQtkpbmg73Vy3xuc5HNos1DCukfEOiUh7+uTZVZkY0AL/VFOdw71yxK72jJytDlSSNrXDLFGbj3ytqqbZvdL0Yl8TrHt28o1i8XqCId8LOaFYmDekJWOBc4ZIPxMvyQ5KWvZ2eTWlbka+INCiK0JPMJqu9sYGNYk/t

On Sun, 20 Sep 2026 07:21:32 -0700
syzbot <syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com> wrote:

> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    40288c9206c1 Merge tag 'drm-fixes-2026-09-19' of https://=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12daa525580000

=46rom the output you have:

[ 1223.033612][    C0] [CPU: 0]TIME DOES NOT MATCH expected:135187 actual:1=
35189 delta:1 before:135188 after:135188 context:h
[ 1223.033612][    C0] trace clock:trace_clock_counter+0x0/0x40
[ 1223.033659][    C0]   [134957] PAGE TIME STAMP
[ 1223.033667][    C0]  0x0:  [134957] delta:0 hd
[ 1223.033677][    C0]  0x10:  [134958] delta:1 hd
[ 1223.033688][    C0]  0x20:  [134959] delta:1 hd
[ 1223.033699][    C0]  0x30:  [134960] delta:1 hd
[ 1223.033709][    C0]  0x40:  [134961] delta:1 hd
[ 1223.033720][    C0]  0x50:  [134962] delta:1 hd

This is a known issue and really a false positive in the check.

The check that tests for the clock being off can fail in certain cases
when the clock is "counter". Which is what you are currently testing.

I have updated my internal tests to not enable the counter clock when
the "verify clock" code is enabled.

Can you update your tests to not use the trace_clock "counter" when the
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is enabled. Otherwise you will
be triggering this false positive too (like you just did).

Is fact, the reason I print the clock that is used when the test
triggers is because I know the counter clock is an issue.

I have a TODO to just disable this check when the counter clock is in
use, but it's way low priority.

-- Steve


> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84649d3ff8d55=
0cb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Deb74dca0d1eb3ec=
227a7
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for D=
ebian) 2.44
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/96e6db480769/dis=
k-40288c92.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d8cb5ded77e9/vmlinu=
x-40288c92.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c127cac2df37/b=
zImage-40288c92.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
>=20
>  0xe74:  [135187] delta:1 PADDING
>  0xe98:  [135188] delta:1 hd
> expected end:0xea8 last event actually ended at:0xea8
> ------------[ cut here ]------------
> system_state !=3D SYSTEM_BOOTING
> WARNING: kernel/trace/ring_buffer.c:4783 at check_buffer.cold+0x1a2/0x1ef=
 kernel/trace/ring_buffer.c:4783, CPU#0: syz.6.3124/18331
> Modules linked in:
> CPU: 0 UID: 0 PID: 18331 Comm: syz.6.3124 Tainted: G             L      s=
yzkaller #0 PREEMPT(full)=20
> Tainted: [L]=3DSOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/05/2026
> RIP: 0010:check_buffer.cold+0x1a2/0x1ef kernel/trace/ring_buffer.c:4783
> Code: 03 0f b6 14 11 38 d0 7c 04 84 d2 75 5c 8b 2d 1c ce 21 10 31 ff 89 e=
e e8 af f2 e8 00 85 ed 0f 84 c8 8d eb 00 e8 32 f8 e8 00 90 <0f> 0b 90 e9 73=
 8b eb 00 49 c7 c7 c0 5e f6 8b e9 51 fe ff ff e8 88
> RSP: 0018:ffffc900000078d0 EFLAGS: 00010046
> RAX: 8000000001000003 RBX: 1ffff92000000f20 RCX: 0000000001000003
> RDX: ffff88802d9c4b00 RSI: ffffffff8123277e RDI: ffff88802d9c4b00
> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000021015
> R13: ffff88801c095000 R14: ffff88805713c000 R15: ffffffff8bf65a60
> FS:  00007ff5dabbc6c0(0000) GS:ffff888123b56000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b32508ff8 CR3: 0000000084816000 CR4: 00000000003526f0
> Call Trace:
>  <IRQ>
>  __rb_reserve_next.constprop.0+0x486/0x1640 kernel/trace/ring_buffer.c:48=
73
>  rb_reserve_next_event kernel/trace/ring_buffer.c:5010 [inline]
>  ring_buffer_lock_reserve+0x49a/0x1220 kernel/trace/ring_buffer.c:5069
>  __trace_buffer_lock_reserve kernel/trace/trace.h:1677 [inline]
>  trace_event_buffer_lock_reserve+0x123/0x6f0 kernel/trace/trace.c:1924
>  trace_event_buffer_reserve+0x1f9/0x350 kernel/trace/trace_events.c:715
>  __eprobe_trace_func kernel/trace/trace_eprobe.c:443 [inline]
>  eprobe_trigger_func+0x558/0x1450 kernel/trace/trace_eprobe.c:487
>  data_ops_trigger kernel/trace/trace_events_trigger.c:154 [inline]
>  event_triggers_call+0x29e/0x4d0 kernel/trace/trace_events_trigger.c:209
>  __event_trigger_test_discard kernel/trace/trace.h:1738 [inline]
>  trace_event_buffer_commit+0x66b/0xa80 kernel/trace/trace.c:2014
>  do_trace_event_raw_event_msr_trace_class arch/x86/include/asm/msr-trace.=
h:21 [inline]
>  trace_event_raw_event_msr_trace_class+0x17d/0x270 arch/x86/include/asm/m=
sr-trace.h:21
>  __do_trace_read_msr arch/x86/include/asm/msr-trace.h:40 [inline]
>  trace_read_msr+0x160/0x1f0 arch/x86/include/asm/msr-trace.h:40
>  native_read_msr_safe arch/x86/include/asm/msr.h:127 [inline]
>  rdmsrq_safe arch/x86/include/asm/msr.h:220 [inline]
>  __rdmsr_safe_on_cpu+0xc8/0xf0 arch/x86/lib/msr-smp.c:124
>  csd_do_func kernel/smp.c:143 [inline]
>  __flush_smp_call_function_queue+0x43a/0x8c0 kernel/smp.c:632
>  __sysvec_call_function_single+0x81/0x420 arch/x86/kernel/smp.c:272
>  instr_sysvec_call_function_single arch/x86/kernel/smp.c:267 [inline]
>  sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:267
>  </IRQ>
>  <TASK>
>  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:681
> RIP: 0010:__vmcs_writel arch/x86/kvm/vmx/vmx_ops.h:224 [inline]
> RIP: 0010:vmcs_write32 arch/x86/kvm/vmx/vmx_ops.h:242 [inline]
> RIP: 0010:vmx_set_constant_host_state+0x1d4/0x740 arch/x86/kvm/vmx/vmx.c:=
4498
> Code: e8 71 ed 6b 00 b9 74 01 00 00 0f 32 48 c1 e2 20 48 89 d3 48 09 c3 e=
9 ba 01 00 00 e8 56 ed 6b 00 89 db b8 00 4c 00 00 0f 79 c3 <0f> 86 f5 01 00=
 00 e8 41 ed 6b 00 b9 76 01 00 00 0f 32 48 c1 e2 20
> RSP: 0018:ffffc90003d97828 EFLAGS: 00000202
> RAX: 0000000000004c00 RBX: 0000000000000010 RCX: ffffc9000ebc9000
> RDX: 0000000000080000 RSI: ffffffff81a0325a RDI: ffff88802d9c4b00
> RBP: 00000000003526f0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807e391f78
> R13: ffff88807e391ed8 R14: ffff888051ff8000 R15: ffff88807e391f78
>  init_vmcs arch/x86/kvm/vmx/vmx.c:4946 [inline]
>  __vmx_vcpu_reset arch/x86/kvm/vmx/vmx.c:5014 [inline]
>  vmx_vcpu_reset+0x117b/0x3160 arch/x86/kvm/vmx/vmx.c:5047
>  kvm_vcpu_reset+0x9d1/0x1ae0 arch/x86/kvm/x86.c:9615
>  kvm_arch_vcpu_create+0x70c/0xab0 arch/x86/kvm/x86.c:9415
>  kvm_vm_ioctl_create_vcpu virt/kvm/kvm_main.c:4213 [inline]
>  kvm_vm_ioctl+0x7e3/0x42d0 virt/kvm/kvm_main.c:5178
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff5d9d9e159
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff5dabbc028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ff5da026090 RCX: 00007ff5d9d9e159
> RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000005
> RBP: 00007ff5d9e3506b R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ff5da026128 R14: 00007ff5da026090 R15: 00007fff730b6718
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	e8 71 ed 6b 00       	call   0x6bed76
>    5:	b9 74 01 00 00       	mov    $0x174,%ecx
>    a:	0f 32                	rdmsr
>    c:	48 c1 e2 20          	shl    $0x20,%rdx
>   10:	48 89 d3             	mov    %rdx,%rbx
>   13:	48 09 c3             	or     %rax,%rbx
>   16:	e9 ba 01 00 00       	jmp    0x1d5
>   1b:	e8 56 ed 6b 00       	call   0x6bed76
>   20:	89 db                	mov    %ebx,%ebx
>   22:	b8 00 4c 00 00       	mov    $0x4c00,%eax
>   27:	0f 79 c3             	vmwrite %rbx,%rax
> * 2a:	0f 86 f5 01 00 00    	jbe    0x225 <-- trapping instruction
>   30:	e8 41 ed 6b 00       	call   0x6bed76
>   35:	b9 76 01 00 00       	mov    $0x176,%ecx
>   3a:	0f 32                	rdmsr
>   3c:	48 c1 e2 20          	shl    $0x20,%rdx
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

