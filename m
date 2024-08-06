Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158152AF12;
	Tue,  6 Aug 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931458; cv=none; b=N+sAeB8Dwd0cD7ljwlax9ApFrdF5FLTJBFMH3yvKrpZkIwQwsG4o8SLKr2j/zrEZFgjqnpzkwoMYo8nZAw8XcHcTQxK/m0aLVs+VCvriGTcCqGbTxeDee2cyFPtym0nINA3K4qidrRaPQadYTREUzakTpUHnllkS+Yw6EEQhRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931458; c=relaxed/simple;
	bh=Goxo2+bPM4e12ASRTBhR5Gm6/sGX0OFpo+SiBnqJBcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBtfQVxG3DitUBaA3TgI1PhKcxioSrLo6GmVn9rg3dTW0sKkzy6CKs+hSAWyLWvgD6GVK2f4ZB6la0dAD0tT4eQ/gblmROHEKRbcXXfvTmB+bsRTuPS01kevmWCyBV8qlrQNEyxDSYqCbqxBkMrlvULRD39Vvd0lsw+OgAT+Z+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wf7RlRJG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wf7RlRJG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rG4y5YFeWU9pqt9794mGADXOWbUmzQj1vztLw6l4JcQ=; b=Wf7RlRJGkF/QzYCT5DZw5RpzDU
	brBK/qRXEfvGG6gHMjrkyws3J2/y+zOCUZ+I0l1KxZtqubtN1WeoC93ORYURQzOqyeA9Ujhfsq9d8
	WDJtJ4LgunYHekHnAymjQ7lI1cp1IN/nicO2hg9t7zMJJvcPf+Iyck8eYcIYm2Y8CCcSv9rb+7JgH
	n5bdWCDxBOLAohNbjgoBrTQIgyGXacxauF1TNUTQz7j3dKGyZoAbHUEC6GOd5dC/NzbEUn8i34f95
	r2DPlfhh/3PN7195gnFXYk01gyf7DFqte1ti/x+uQ2MLu1jOqf706j+CNyCBp3gWABS+tKIx1gMhH
	JB523MvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFAz-00000006ONZ-2K0F;
	Tue, 06 Aug 2024 08:04:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35E5030049D; Tue,  6 Aug 2024 10:04:13 +0200 (CEST)
Date: Tue, 6 Aug 2024 10:04:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	mingo <mingo@redhat.com>, acme <acme@kernel.org>,
	namhyung <namhyung@kernel.org>
Subject: Re: WARNING in free_event
Message-ID: <20240806080413.GM37996@noisy.programming.kicks-ass.net>
References: <c6333ada-aa38-4876-9e57-881b3774397b.bugreport@valiantsec.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6333ada-aa38-4876-9e57-881b3774397b.bugreport@valiantsec.com>

On Mon, Aug 05, 2024 at 10:18:00AM +0800, Ubisectech Sirius wrote:
> 
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China
> ValiantSec. Recently, our team has discovered a issue in Linux kernel
> 6.8. Attached to the email were a PoC file of the issue.
> 

I could not readily reproduce on a current kernel. Please double check
against the latest kernel.

> Stack dump:
> 
> ------------[ cut here ]------------
> unexpected event refcount: 2; ptr=ffff888019589820
> WARNING: CPU: 0 PID: 13593 at kernel/events/core.c:5254 free_event+0xa3/0xc0 kernel/events/core.c:5254
> Modules linked in:
> CPU: 0 PID: 13593 Comm: syz.3.346 Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:free_event+0xa3/0xc0 kernel/events/core.c:5254
> Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 25 48 8b b5 38 02 00 00 48 89 ea 48 c7 c7 00 03 d7 8a e8 3e a9 9a ff 90 <0f> 0b 90 90 5d 41 5c 41 5d e9 bf ed d5 ff 4c 89 ef e8 77 b1 2d 00
> RSP: 0018:ffffc90001b379c8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff814f699a
> RDX: ffff88801e7b4980 RSI: ffffffff814f69a7 RDI: 0000000000000001
> RBP: ffff888019589820 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000002
> R13: ffff888019589a58 R14: ffff888019589b00 R15: ffff888019589820
> FS:  0000000000000000(0000) GS:ffff88802c600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f507464c360 CR3: 0000000053fa4000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  perf_event_release_kernel+0x5d4/0x8f0 kernel/events/core.c:5421
>  perf_release+0x37/0x50 kernel/events/core.c:5442
>  __fput+0x282/0xbc0 fs/file_table.c:376
>  task_work_run+0x16a/0x260 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xaf0/0x2a40 kernel/exit.c:871
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
>  get_signal+0x2440/0x2630 kernel/signal.c:2893
>  arch_do_signal_or_restart+0x81/0x7e0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  irqentry_exit_to_user_mode+0x13c/0x280 kernel/entry/common.c:225
>  exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1557
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7fd5ec9958d5
> Code: Unable to access opcode bytes at 0x7fd5ec9958ab.
> RSP: 002b:0000000000000050 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: 00007fd5ecb33f60 RCX: 00007fd5ec9958cd
> RDX: 0000000000000000 RSI: 0000000000000050 RDI: 0000000000000280
> RBP: 00007fd5eca1bb06 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fd5ecb33f60 R15: 00007fd5ed77a000
>  </TASK>
> 
> 
> Thank you for taking the time to read this email and we look forward to working with you further.
> 
> 
> 
> 
> 


