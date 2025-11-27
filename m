Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5882D8362
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Nov 2025 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764217104; cv=none; b=Uqx40yGsvQmNlkZopMg03lKk0BmekEv+EmSzP+F06zlV88D0BKM4YSbazDqsPEtzYIpcvTJjiAERfct2ZdzXrGXixsjEkqLq1zkq0qSLhFK2eFLXRrCfQkTlQc+GmbvN/pgtll8hNqhhIR8nRxfshtWxSCmkKdufiEY4CZFzxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764217104; c=relaxed/simple;
	bh=14X/qYdGhkvQFhcEl9dA+QKl0yp6i0bpvNzerSwdnMw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s022OMl7HJh72ly+BUvGlJdiFzSsQtNje/TvFxmVgRhrUiCtqOoXNOvfOAXQWNW7QT+MnTx3taAocRYOfPsBGlAaAPCc0JR+oDcZGu+Qqz439FanJ+LlU1TADYmejuwFwQ7EOLjxpUpFjvYX/OK6ujz+bmmlG1m3k0i/trIFOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZNan2H9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZNan2H9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DDBC4CEF8;
	Thu, 27 Nov 2025 04:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764217103;
	bh=14X/qYdGhkvQFhcEl9dA+QKl0yp6i0bpvNzerSwdnMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZNan2H9y4J8KBY3Yfe4DF+oKxybGLE5fy+z3iFBQ9rxFJUEJ8J2139kOEXNlH8dA
	 xITYXPm7uYGJGynwV3bDdyK3QKyL+vuiddnr54C35Kqe7DvGcXxyw/V/JLCGsIS5HR
	 Y3XDRsKwdnQEAAJbHZQWNK4tuE4eu+VHEOFwL/DrzsbmZFfco/Nacv2NjruUiF+BFj
	 X2LpY9g8YDf/F2G9h/mUvFO2VxerNnZ2J48F6EAQ2hLO1AdXMNsSOm5B6QQIfvKWQO
	 aORuNWsUJsd5EcMUfwr926VC1bV17LRNCfPRy5OC6N+be4O9xxrNtoyFz/GF0FjrtQ
	 c1zdIbsNlokSg==
Date: Thu, 27 Nov 2025 13:18:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Ye Bin <yebin@huaweicloud.com>, naveen@kernel.org, davem@davemloft.net,
 linux-trace-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH] kprobes: avoid crash when rmmod/insmod modules after
 ftrace_disabled
Message-Id: <20251127131820.152fd7651ece26139778cc25@kernel.org>
In-Reply-To: <20251127125248.a1367d15c0bbc7faad3b0e87@kernel.org>
References: <20251125020536.2484381-1-yebin@huaweicloud.com>
	<20251127125248.a1367d15c0bbc7faad3b0e87@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 12:52:48 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> Thanks for reporting!
> 
> 
> On Tue, 25 Nov 2025 10:05:36 +0800
> Ye Bin <yebin@huaweicloud.com> wrote:
> 
> > From: Ye Bin <yebin10@huawei.com>
> > 
> > There's a issue as follows when rmmod modules after ftrace disabled:
> 
> You may see something like;
> 
> Failed to unregister kprobe-ftrace (error -19)
> 
> or
> 
> Failed to disarm kprobe-ftrace at <function name> (error -19)
> 
> right before this BUG, don't you?
> If you reported with that line, it's more easier to understand.
> 
> 
> > BUG: unable to handle page fault for address: fffffbfff805000d
> > PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
> > Oops: Oops: 0000 [#1] SMP KASAN PTI
> > CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
> > Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > RIP: 0010:kprobes_module_callback+0x89/0x790
> > RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
> > RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
> > RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
> > RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
> > R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
> > R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
> > FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
> > Call Trace:
> >  <TASK>
> >  notifier_call_chain+0xc6/0x280
> >  blocking_notifier_call_chain+0x60/0x90
> >  __do_sys_delete_module.constprop.0+0x32a/0x4e0
> >  do_syscall_64+0x5d/0xfa0
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > The above issue occurs because the kprobe was not removed from the hash
> > list after ftrace_disable.
> > To prevent the system from restarting unexpectedly after ftrace_disable,
> > in such cases, unregister_kprobe() ensures that the probe is removed from
> > the hash list, preventing subsequent access to already freed memory.
> > 
> > Fixes: 6f0f1dd71953 ("kprobes: Cleanup disabling and unregistering path")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  kernel/kprobes.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index ab8f9fc1f0d1..d735a608b810 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1731,8 +1731,30 @@ static int __unregister_kprobe_top(struct kprobe *p)
> >  
> >  	/* Disable kprobe. This will disarm it if needed. */
> >  	ap = __disable_kprobe(p);
> > -	if (IS_ERR(ap))
> > -		return PTR_ERR(ap);
> > +	if (IS_ERR(ap)) {
> > +		int ret = PTR_ERR(ap);
> > +
> > +		/*
> > +		 * If ftrace disabled we need to delete kprobe node from
> > +		 * hlist or aggregation list. If nodes are not removed when
> > +		 * modules are removed, the already released nodes will
> > +		 * remain in the linked list. Subsequent access to the
> > +		 * linked list may then trigger exceptions.
> > +		 */
> > +		if (ret != -ENODEV)
> > +			return ret;
> > +
> > +		ap = __get_valid_kprobe(p);
> > +		if (!ap)
> > +			return ret;
> > +
> > +		if (ap == p)
> > +			hlist_del_rcu(&ap->hlist);
> > +		else
> > +			list_del_rcu(&p->list);
> 
> Instead of repeating this process, we should ignore
> -ENODEV error from ftrace directly. BTW, ftrace_disabled is set
> when ftrace_kill() is called, that means ftrace is no more usable.
> So I think we can just ignore ftrace operation in
> __disarm_kprobe_ftrace().

So, what we need is;

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d1..17d451553389 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1104,6 +1104,10 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	int ret;
 
 	lockdep_assert_held(&kprobe_mutex);
+	if (unlikely(kprobe_ftrace_disabled)) {
+		/* Now ftrace is disabled forever, disarm is already done. */
+		return 0;
+	}
 
 	if (*cnt == 1) {
 		ret = unregister_ftrace_function(ops);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
