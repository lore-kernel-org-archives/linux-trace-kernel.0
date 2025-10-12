Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FBD1D86FF;
	Sun, 12 Oct 2025 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760239613; cv=none; b=Gc3L3HKb87GrhrQqI20nuwJ0c0ytCyb3vzXC+nC4ZJX4bLJqfYPf1XjETxItNNR4ZcmKlhdKEiTROId5Ror+uKp65CLs2UOTq64rW9S+Nhg0kUA7xEwhuaDPB859yGyJSFn7aupMKUcLamh8x4QoWnCN8TAtZ6bTCmPpG9HQiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760239613; c=relaxed/simple;
	bh=hmpKvvJnF/u4D2UEAsYNRteDpX+9tDZCPdRWNpkWycM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fax2KvkUpvlj1YJGSdgSXLG99BIX85Tdq5m056xhsdRRmgtbppl0MuK4tNMg0kylp0pUtdJfWvBgc2VTzXSIbdEpNkprsJyGp1rdKuJzwSavs1fwwMsssdJ1v02E7mKUYtJzR5ThMcf4q9xZUSbthsI4cilOe/Zw2B3UF+kClhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov2euuR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov2euuR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857A9C4CEE7;
	Sun, 12 Oct 2025 03:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760239613;
	bh=hmpKvvJnF/u4D2UEAsYNRteDpX+9tDZCPdRWNpkWycM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ov2euuR5vcyePyIcKmrkeL+xiWlvOf7D+01p1JSK6QEBs2WeHXGfpYIYscmSrMnX7
	 2V4Xh8yRRZ87h3WVNirgO0yjPAh4Udus31ZPQWRpdMh4EKzC+2IsgfGHYuIEQ41/0I
	 4m+84lq5NeViQCeAlgZmwRKWg3wiWQvRhT4PU/LEg6GbiaTxA45hMdSVWhhlT5w9Zh
	 kkKSAZuzvBaWszxHhcIPwpTNHXvYwGGLD4mXqxKNz4xKeXQR8DdRgd8mYTkj61gCbs
	 DJCPxvSwBXjE8Ba7ouNEttLeGL///4icaZ+N0I5KRyHinyo/mAIMklQp1BySnSPGGM
	 +PO1gzGiaBJdg==
Date: Sun, 12 Oct 2025 12:26:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: syzbot <syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in write_raw_marker_to_buffer
Message-Id: <20251012122648.d6ca8923c4ef5bc9fc483e9f@kernel.org>
In-Reply-To: <68e973f5.050a0220.1186a4.0010.GAE@google.com>
References: <68e973f5.050a0220.1186a4.0010.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,


This happens because we replaced (non field size check)
copy_from_user_nofault() to memcpy. So I think we need a cast
to void * there.

On Fri, 10 Oct 2025 14:00:37 -0700
syzbot <syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5472d60c129f Merge tag 'trace-v6.18-2' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1239b458580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e7dba95d4cdd903c
> dashboard link: https://syzkaller.appspot.com/bug?extid=9a2ede1643175f350105
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eec52f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e9892580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fbf444614257/disk-5472d60c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f129612e3b8b/vmlinux-5472d60c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8095ae997ffa/bzImage-5472d60c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> memcpy: detected field-spanning write (size 2655) of single field "&entry->id" at kernel/trace/trace.c:7458 (size 4)
> WARNING: CPU: 0 PID: 6004 at kernel/trace/trace.c:7458 write_raw_marker_to_buffer.isra.0+0x2d4/0x330 kernel/trace/trace.c:7458
> Modules linked in:
> CPU: 0 UID: 0 PID: 6004 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:write_raw_marker_to_buffer.isra.0+0x2d4/0x330 kernel/trace/trace.c:7458
> Code: ff e8 30 74 fa ff c6 05 b4 7e aa 0e 01 90 b9 04 00 00 00 48 c7 c2 e0 1e 93 8b 4c 89 e6 48 c7 c7 40 1f 93 8b e8 6d fc b8 ff 90 <0f> 0b 90 90 e9 d7 fe ff ff e8 6e 04 62 00 e9 da fd ff ff e8 64 04
> RSP: 0018:ffffc90003837c40 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff88813ff34018 RCX: ffffffff817a5e58
> RDX: ffff888031d73c80 RSI: ffffffff817a5e65 RDI: 0000000000000001
> RBP: ffff88813ff34010 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000a5f
> R13: ffff88813ff18c00 R14: 0000000000000000 R15: 0000200000000040
> FS:  000055558e5ff500(0000) GS:ffff8881249e6000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30263fff CR3: 0000000034638000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  tracing_mark_raw_write+0x2da/0x4a0 kernel/trace/trace.c:7500
>  vfs_write+0x2a0/0x11d0 fs/read_write.c:684
>  ksys_write+0x1f8/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f18a0b8eec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff2b2d2c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f18a0de5fa0 RCX: 00007f18a0b8eec9
> RDX: 0000000000000a5f RSI: 0000200000000040 RDI: 0000000000000003
> RBP: 00007f18a0c11f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f18a0de5fa0 R14: 00007f18a0de5fa0 R15: 0000000000000003
>  </TASK>
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
