Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF539184B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287381; cv=none; b=krTzgsbNmq5Xe1AjOZ5ogMkJNHw4ZBk3mExPm3acX3DTpHndImQag4bRGmggYGbWPL06KiajEFVzCvTady4LB4xUt2/HhnIhFn3MedrL1JHbBJ+3Lvlh7i6pAuSOqS+722QbFMLAcR6QlDXuCFAyAdad6jzCyz1smXFlugnG0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287381; c=relaxed/simple;
	bh=02QaKCuiM61VkYL+ffNjxxe+3cxugQipvDfj1mzylAc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOyk52XTnSG13EFqp3kjO8CvBknOjHj9zDYMSIn+eGI7G7DZaoYhBnhu19SeNCZPJiLJbCNTqSHU+WkflsyikuHgDCShifSRdKbP8jFggSounswXXAlyHIbydz8Y6dVwvSAiqJTqWZ3PzCtrXPF2FBRlEDFRfCO+LIof2Y0dUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYqM9zvw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYqM9zvw"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46cacc39191so34009f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782287378; x=1782892178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7j9BR45HPMxm5qmIlOEiQ7QyT/8TgDIa76ilzwJimWE=;
        b=fYqM9zvwjjez46147FwfCak+jFTAULAXUjXRlfscXICxJ4X6kLqCR5buZkXAOZWlo0
         NejRboaSgV9kNMVdrnpP0gwtGIMcv49gWVfRxaU8XuLUVvhPfCg/lc5eS4UxYDZSZux4
         GPjZO3qLQPgL1YAOtdHwj1tndxSzxSwEV8atWXpFxW/TFfITviigkez6C5H+bM2Pwb3X
         zU6x2I7fO/sb1nfcrBFJ7f1UC0dKsOjxjfABUAk+Tu5esOpoPWv80LRBx7P1TgBHaqG+
         fKd1ch24dwg9dcfPdEorV+4z65aTV3O1Yj0/5C34ztBEaZJIx6X45ayBqcEZ/8SX4w6U
         w5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287378; x=1782892178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j9BR45HPMxm5qmIlOEiQ7QyT/8TgDIa76ilzwJimWE=;
        b=fdFnXE/praiDoyFVZyY6Os7zNQb6vsiQjOZfLwk3jMhdQUuKWmH+TmhMcV9fiLS5EH
         t3L2uKCa36kRej1W8hwwjeU1b3jy7Pk6ahlX2CRE/eQP6Bs43YxvL/ynwXbterSg1zQ7
         LLZD5M64bOztwH6XG3iON+LFlVnzhRnfmXCvFkYoozW8MLSocC13GbMYEjNOiFyB76ab
         VYs3zs2NABEvtV8rOj2AuFdDk1Pj4o+GOP4d/xaJmvRsTKWANIOQzvUTHbef1RA7VCsN
         ngVXmQYVSpqx9123od6eEwvsopvfq0shrpNFgVB4TSR1gJjyYGC+mlURKzyXM/ZkIG6z
         p/Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqWAzDyKh3y3i9TZwd+54rR14wfxEXf4rxWLSUIdPIIzPNYy+pXKk++wbD+s5a93nu/ODA4m3W3RdXnNBWPib5ON1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJ8x+/2z9IrbqXJZCmTV0Sr2DCvnIuKPfSNsNN3n5uEGY4Ew/
	fEXzXk/T3WVy49TkI8L6vDtCRyUHv0G7E+TVn3XbyTkvnMEahWZ3i0Ja
X-Gm-Gg: AfdE7ckHUaKZfK8yGD3prF1BUf9IgomSXACCHmgh4fBGGxwXNWiF9buLibmBP3ElrtN
	7Hpme79+6Zu1it1B5I+iwst7ccin2Rr/c0D649xxVbc5i5+CG0fz621HIeSN3N/+EZMrFfzyEpp
	iJmghfWp69REt/qd7tqRDQ+g/gStkAz6s5TIRxoJlj2H/OvcI7UrId8ZYX/HtLqcCFFX0e1iJn7
	BawHrV5b2LJ9KMIOdX7bJE73vovCBxzWFvzZHm/9mCOqUFRi+6+q5Lc1HoS4+ra2yojRxPtlf0O
	WfOshUezD2CV/YM1KfGBNAheLXAICRgzM3yyBBorp/udkSQxsg/z7C5NktXc+C0TrOKwj9XMBN4
	y2ie0WS1Cg/HyfvO2+rvE6pGJLfnTpdr+mO98CkuTbMQLTGQS6bdQMnW0CCmEgvhQtnfFLAb7bY
	7m
X-Received: by 2002:a05:6000:27c3:b0:46b:70db:2113 with SMTP id ffacd0b85a97d-46b70ea637fmr4202651f8f.0.1782287378428;
        Wed, 24 Jun 2026 00:49:38 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c6csm4748563f8f.14.2026.06.24.00.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:49:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jun 2026 09:49:36 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com>,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [syzbot] [trace?] general protection fault in mtree_load
Message-ID: <ajuMEI3Z3dYj7HDB@krava>
References: <6a38dd47.713c5d62.148f7.000c.GAE@google.com>
 <ajky0IbEvV_UDj2a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajky0IbEvV_UDj2a@redhat.com>

On Mon, Jun 22, 2026 at 03:04:16PM +0200, Oleg Nesterov wrote:
> On 06/21, syzbot wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6b5a2b7d9bc1 Merge tag 'trace-tools-v7.2' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16d56986580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ea6584355d75e0cd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=61ce80689253f42e6d80
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6b5a2b7d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b3cb0499fbe9/vmlinux-6b5a2b7d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/47cfbe57f6ea/bzImage-6b5a2b7d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
> > CPU: 3 UID: 0 PID: 24402 Comm: syz.4.5217 Tainted: G             L      syzkaller #0 PREEMPT(full)
> > Tainted: [L]=SOFTLOCKUP
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
> > RIP: 0010:mas_start lib/maple_tree.c:1179 [inline]
> > RIP: 0010:mtree_load+0x16d/0xa90 lib/maple_tree.c:5657
> > Code: 00 00 00 00 48 c7 44 24 78 ff ff ff ff e8 6b bd 84 f6 48 8b 5c 24 50 c6 84 24 9c 00 00 00 00 48 8d 7b 48 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 d6 08 00 00 48 8b 5b 48 e8 6f 1a 08 00 31 ff
> > RSP: 0018:ffffc900039c76d8 EFLAGS: 00010206
> > RAX: 0000000000000011 RBX: 0000000000000040 RCX: ffffffff8b848746
> > RDX: ffff888041b6a540 RSI: ffffffff8b848775 RDI: 0000000000000088
> > RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
> > R10: 0000000000000001 R11: 000000000000751b R12: dffffc0000000000
> > R13: ffff88802693adc0 R14: 00001fff904365a7 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff8880d665f000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f44aa04f156 CR3: 00000000364d5000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  vma_lookup include/linux/mm.h:4204 [inline]
> >  __in_uprobe_trampoline arch/x86/kernel/uprobes.c:766 [inline]
> >  __is_optimized arch/x86/kernel/uprobes.c:1056 [inline]
> >  is_optimized arch/x86/kernel/uprobes.c:1067 [inline]
> >  set_orig_insn+0x1ec/0x2a0 arch/x86/kernel/uprobes.c:1098
> >  remove_breakpoint kernel/events/uprobes.c:1185 [inline]
> >  register_for_each_vma+0xbb7/0xdb0 kernel/events/uprobes.c:1318
> >  uprobe_unregister_nosync+0x12a/0x1c0 kernel/events/uprobes.c:1343
> >  bpf_uprobe_unregister kernel/trace/bpf_trace.c:2936 [inline]
> >  bpf_uprobe_multi_link_release+0xb3/0x1c0 kernel/trace/bpf_trace.c:2947
> >  bpf_link_free+0xec/0x4a0 kernel/bpf/syscall.c:3273
> >  bpf_link_put_direct kernel/bpf/syscall.c:3326 [inline]
> >  bpf_link_release+0x5d/0x80 kernel/bpf/syscall.c:3333
> >  __fput+0x3ff/0xb50 fs/file_table.c:512
> >  task_work_run+0x150/0x240 kernel/task_work.c:233
> >  exit_task_work include/linux/task_work.h:40 [inline]
> 
> current->mm is already NULL, the exiting task has already passed exit_mm().
> 
> Hopefully
> 
> 	[PATCHv4 01/13] uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
> 	https://lore.kernel.org/all/20260526205840.173790-2-jolsa@kernel.org/
> 
> should help...

yes, that sould fix it

thanks,
jirka
