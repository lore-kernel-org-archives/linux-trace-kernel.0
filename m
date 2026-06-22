Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869C3B0AE7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133473; cv=none; b=qQz4MqFtRJ75bN//iPoYY+S1JOjUqMdM+JpSvxQCsYx4ON+klvEotPdFCjgL42VlDKeKbXoHye+vv9hjKD67Q7TATw9LYq/2G4yU5GIccALEG/3QMkHVayBM43XuXkLHd8enq/6ZepG5otTE3TIlA9tUpvb0GFtLpkTHdOC/Wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133473; c=relaxed/simple;
	bh=oZv+pp/Oal4BLNj5iKlvdswcFkCjoPMDy9fRrzLbZuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m1NMYUskMLckL0+/qEhHH3qimHADqLWxctm5VWoqhhQjz1i7Q89wUNKlIp0D0YbS3oKS0lEk8Is518EZAGDsZ0SbwqxvZZ2blrIYCom+Q5akR0RIzvKivQNy7WczjwT9uyETFHIJD88r/MHf9J2GTacqx5YgA7BHQhZiTNSvjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtvyWmHz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtvyWmHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782133469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHRcAdgmO3yxC3eNJUqTmBhO9L8DI2BmsXigahU3JQE=;
	b=DtvyWmHzHA3CEqhWgZ2nBn9WY/3zRwCnqjd5i/R9gE5T9ChbZGplxOFINS7y9XKiR3EzD2
	PY67UeKCwHSveX6TEqZIWwLScv69JlneliE1JdPd8H/jJ3gBTzi3PltI5H7S/b0B79K6M6
	dVVaxgCj6kh11x03iUDiyffUSrt1BZg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-oealJNnhN725m6fkl8KBgg-1; Mon,
 22 Jun 2026 09:04:26 -0400
X-MC-Unique: oealJNnhN725m6fkl8KBgg-1
X-Mimecast-MFC-AGG-ID: oealJNnhN725m6fkl8KBgg_1782133464
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51A001955E9E;
	Mon, 22 Jun 2026 13:04:23 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EF7C3195608F;
	Mon, 22 Jun 2026 13:04:17 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Jun 2026 15:04:22 +0200 (CEST)
Date: Mon, 22 Jun 2026 15:04:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [syzbot] [trace?] general protection fault in mtree_load
Message-ID: <ajky0IbEvV_UDj2a@redhat.com>
References: <6a38dd47.713c5d62.148f7.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a38dd47.713c5d62.148f7.000c.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: mgv9743pCkOExisur9p5-gfCwbM7rey3ubbsoB1pwiY_1782133464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/21, syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6b5a2b7d9bc1 Merge tag 'trace-tools-v7.2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d56986580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea6584355d75e0cd
> dashboard link: https://syzkaller.appspot.com/bug?extid=61ce80689253f42e6d80
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6b5a2b7d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b3cb0499fbe9/vmlinux-6b5a2b7d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/47cfbe57f6ea/bzImage-6b5a2b7d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
> CPU: 3 UID: 0 PID: 24402 Comm: syz.4.5217 Tainted: G             L      syzkaller #0 PREEMPT(full)
> Tainted: [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
> RIP: 0010:mas_start lib/maple_tree.c:1179 [inline]
> RIP: 0010:mtree_load+0x16d/0xa90 lib/maple_tree.c:5657
> Code: 00 00 00 00 48 c7 44 24 78 ff ff ff ff e8 6b bd 84 f6 48 8b 5c 24 50 c6 84 24 9c 00 00 00 00 48 8d 7b 48 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 d6 08 00 00 48 8b 5b 48 e8 6f 1a 08 00 31 ff
> RSP: 0018:ffffc900039c76d8 EFLAGS: 00010206
> RAX: 0000000000000011 RBX: 0000000000000040 RCX: ffffffff8b848746
> RDX: ffff888041b6a540 RSI: ffffffff8b848775 RDI: 0000000000000088
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
> R10: 0000000000000001 R11: 000000000000751b R12: dffffc0000000000
> R13: ffff88802693adc0 R14: 00001fff904365a7 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880d665f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f44aa04f156 CR3: 00000000364d5000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  vma_lookup include/linux/mm.h:4204 [inline]
>  __in_uprobe_trampoline arch/x86/kernel/uprobes.c:766 [inline]
>  __is_optimized arch/x86/kernel/uprobes.c:1056 [inline]
>  is_optimized arch/x86/kernel/uprobes.c:1067 [inline]
>  set_orig_insn+0x1ec/0x2a0 arch/x86/kernel/uprobes.c:1098
>  remove_breakpoint kernel/events/uprobes.c:1185 [inline]
>  register_for_each_vma+0xbb7/0xdb0 kernel/events/uprobes.c:1318
>  uprobe_unregister_nosync+0x12a/0x1c0 kernel/events/uprobes.c:1343
>  bpf_uprobe_unregister kernel/trace/bpf_trace.c:2936 [inline]
>  bpf_uprobe_multi_link_release+0xb3/0x1c0 kernel/trace/bpf_trace.c:2947
>  bpf_link_free+0xec/0x4a0 kernel/bpf/syscall.c:3273
>  bpf_link_put_direct kernel/bpf/syscall.c:3326 [inline]
>  bpf_link_release+0x5d/0x80 kernel/bpf/syscall.c:3333
>  __fput+0x3ff/0xb50 fs/file_table.c:512
>  task_work_run+0x150/0x240 kernel/task_work.c:233
>  exit_task_work include/linux/task_work.h:40 [inline]

current->mm is already NULL, the exiting task has already passed exit_mm().

Hopefully

	[PATCHv4 01/13] uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
	https://lore.kernel.org/all/20260526205840.173790-2-jolsa@kernel.org/

should help...

Oleg.

