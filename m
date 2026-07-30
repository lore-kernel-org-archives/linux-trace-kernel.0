Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342B40B11F;
	Thu, 30 Jul 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409871; cv=none; b=HnF38uwWFxqpymORL2PH73ysXa/0jQB7ZOx4X1q2Ip5YsdRRMQQNyi8LbAmrCu8UKWQ2sLcH3cQlxbxObe9EdetivMg4GbptfAZd4u1PT1HGhA51FrfNwAuF42qBlQjgNjZBaztTe+lfa/DLRCsGSwGcCeJOZudV2TygdpPKTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409871; c=relaxed/simple;
	bh=qw23O9P/fM8tRo8XKzEM2uChbjKHl2YLkWpRltXo/e8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q00O7nltV9mj7nPe9IerExLBf9amEvfHIB8fi79eThobZeNeQYYfk4bG11e22lHNqR1LhE8oWmSQoqCUJZ87fmrj6B1oWhjXCOubhUHvkU95sct3Tau4NvpGaOjuXyvzdtc0gLa5KlT6I88zNaS6ixWdLjo08GLRPDtOm0/wMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B388D120949;
	Thu, 30 Jul 2026 11:10:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1EFEA80012;
	Thu, 30 Jul 2026 11:10:55 +0000 (UTC)
Date: Thu, 30 Jul 2026 07:11:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/snapshot: Avoid CPU buffer swap during
 reserve/commit
Message-ID: <20260730071132.623c425c@gandalf.local.home>
In-Reply-To: <4812557d-3718-4bf5-8be1-c12d6da614ad@huaweicloud.com>
References: <20260730011912.2325121-1-wutengda@huaweicloud.com>
	<20260729220448.13d19821@robin>
	<4812557d-3718-4bf5-8be1-c12d6da614ad@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6jyfd9xe9tan46zmricdwr5t6bc7m9kr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1EFEA80012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+AdlnwWgQ2c5HMxGqwMaDOHH0I3tbzPRI=
X-HE-Tag: 1785409855-649412
X-HE-Meta: U2FsdGVkX19d5GwgV9Wa2PcpPPC8+83YknK1lUblaVJgyNeGTicx6NiJgq8/7+NstmEG8/eqcJiq92xpBPsYpCoirxoaDDrWhr3uZuBdTG/s3BOkxP00F3KZNQllb5vsQaodoJxldfGUyhGlkZ6F9T3nDv+hWMrKktSWnYk1HbFsU+1f9Did1YhfFjm0GeFYPbTbt0S6MarwHnIteFB/OfWbZNPSNMghdnbdZmdM5CgE2cN3IfYG0uzs4UzvkMmmheJIlxSgGjUoeWFuXwA8b70wIv0+f6Q02oL9aM4RDNfMt1FZhSJdTqRtiDHF6Ew7JUk1G3AOhH5Cr7ot9e4Eoh6vCa1VfScfJ80SAOq0UwsdeElO3skN5QNqBZfYiy5wiC1LGZp2TJA2ab2k22JssmNd7eHDxFkh72DmYIWO5zs=

On Thu, 30 Jul 2026 12:10:18 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> On 2026/7/30 10:04, Steven Rostedt wrote:
> > On Thu, 30 Jul 2026 01:19:12 +0000
> > Tengda Wu <wutengda@huaweicloud.com> wrote:
> >   
> >> Commit 3163f635b20e ("tracing: Fix race issue between cpu buffer write
> >> and swap") fixed most of the race conditions between snapshot's
> >> ring_buffer_swap_cpu and ring_buffer_lock_{reserve, commit}. It achieved
> >> this by replacing the asynchronous swap with smp_call_function_single to
> >> trigger an interrupt on the target CPU to handle the swap.  
> > 
> > I'm curious. How did you discover this race?
> >   
> 
> Just run the POC provided in commit 3163f635b20e [1] day after day, and
> the issue occurs. The call trace points out that the problem happens when
> tracing the function:
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3163f635b20e9e1fb4659e74f47918c9dddfe64e
> 
> [   55.864661] ------------[ cut here ]------------
> [   55.865536] WARNING: CPU: 0 PID: 1451 at kernel/trace/ring_buffer.c:3096 rb_commit.constprop.0+0x367/0x820
> [   55.866993] Modules linked in: binfmt_misc rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace sunrpc
> [   55.869583] CPU: 0 PID: 1451 Comm: DTS202602110403 Not tainted 5.10.0+ #1
> [   55.871729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   55.874671] RIP: 0010:rb_commit.constprop.0+0x367/0x820
> [   55.871729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/0
> 1/2014
> [   55.874671] RIP: 0010:rb_commit.constprop.0+0x367/0x820
> [   55.875637] Code: 8d 7f 10 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 af 03 00 00 49 8b 5f 10 be 04 00 00 00 48 8d 7b 08 e8 dd a0 41 00 f0 ff 43 08 <0f> 0b 48 83 c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f e9 54 58 2e 02 be
> [   55.878367] RSP: 0018:ffffc90000b57a30 EFLAGS: 00010202
> [   55.879227] RAX: 0000000000000001 RBX: ffff88800105ec00 RCX: ffffffff9e11db33
> [   55.880366] RDX: ffffed100020bd82 RSI: 0000000000000004 RDI: ffff88800105ec08
> [   55.881470] RBP: ffff88800105ec00 R08: 0000000000000001 R09: ffff88800105ec0b
> [   55.882563] R10: ffffed100020bd81 R11: 0000000000000001 R12: ffff8880010520a0
> [   55.883681] R13: ffff88800105ec40 R14: 0000000000000000 R15: ffff888001052000
> [   55.884761] FS:  00007f6be3c5d740(0000) GS:ffff888065200000(0000) knlGS:0000000000000000
> [   55.885980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.886876] CR2: 000055d8257879e0 CR3: 0000000005c78003 CR4: 0000000000770ef0
> [   55.887994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   55.889113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   55.890232] PKRU: 55555554
> [   55.890740] Call Trace:
> [   55.891221]  ? s_show+0x2f0/0x2f0
> [   55.891815]  ? kallsyms_lookup_size_offset+0x130/0x130
> [   55.892684]  ring_buffer_unlock_commit+0x68/0x510
> [   55.893490]  ? kallsyms_lookup_size_offset+0x130/0x130
> [   55.894341]  ? seq_print_sym+0x13d/0x1a0
> [   55.895024]  function_trace_call+0x266/0x370
> [   55.895754]  ? ring_buffer_iter_advance+0x2f/0x80
> [   55.896584]  0xffffffffc037406a
> [   55.897180]  ? ring_buffer_iter_advance+0x2f/0x80
> [   55.897966]  ? kallsyms_lookup+0x5/0x260
> [   55.898640]  ? _raw_write_unlock_irqrestore+0x60/0x60
> [   55.899481]  kallsyms_lookup+0x5/0x260
> 
> The vmcore indicates that the buffer in CPU 0 was swapped:
> 
> * array_buffer->buffers:
> 
>   cpu 0, ffff888001052000, committing = 0, entries = 10010687, commits = 10010686
>   cpu 1, ffff888001fa4400, committing = 0, entries = 18780536, commits = 18780536
>   cpu 2, ffff888100110400, committing = 0, entries = 20905896, commits = 20905896
>   cpu 3, ffff888100111c00, committing = 0, entries = 20825484, commits = 20825484
> 
> * max_buffer->buffers:
> 
>   cpu 0, ffff888001052400, committing = 1, entries = 9768877, commits = 9768878
>   cpu 1, ffff888001fa6400, committing = 0, entries = 0, commits = 0
>   cpu 2, ffff888100112400, committing = 0, entries = 0, commits = 0
>   cpu 3, ffff888100112800, committing = 0, entries = 0, commits = 0
> 
> We first checked if the problem could occur before rb_start_commit, but we
> just couldn't get past the 'READ_ONCE(cpu_buffer->buffer) != buffer' check.
> So we turned our attention to what happens after rb_start_commit, to see
> if the committing counter might drop to 0 and then get incremented again.
> In the end, we found that only rb_move_tail could cause this.
> 
> Honestly, it was a pretty tough journey.

I bet. Thanks for doing that work.

> The work_on_cpu approach does not fix the issue inside the ring buffer
> itself. However, as far as the current codebase is concerned, the
> snapshot operation is the only path that triggers a CPU buffer swap.
> This fix has minimal impact and does not expose users to the internal
> intermediate state of the ring buffer when they echo to snapshot, thus
> avoiding the confusion of hitting an -EBUSY error.

I admit it is a way to avoid the -EBUSY, which is a separate issue and one
that always existed. Your patch can be added to solve that for this
specific use case. But then it would not be a fix, just an enhancement.

> 
> If we were to fix this from within the ring buffer, we might need to
> introduce a new flag (e.g., a local_t variable similar to committing)
> to detect such race windows. Based on the current analysis, this race
> only occurs during a very brief window in rb_move_tail. Adding a new
> flag for this seems unnecessary.
> 
> Alternatively, we could simply remove both rb_end_commit(cpu_buffer)
> and local_inc(&cpu_buffer->committing) inside rb_move_tail, thereby
> eliminating the 1-0-1 transition of committing and preventing such a
> race window from existing in the first place. In principle, committing
> should remain non-zero from the moment rb_start_commit is called until
> the commit is finished.

Actually there already exists something that can be used:

  cpu_buffer->current_context

It is set to prevent recursion in the ring buffer when the commit starts,
and is cleared after the commit is finished. If it is anything other than
0, it means a commit is in progress and the swap should return -EBUSY.

This is not affected by the move to next page.

Something like this should fix it:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 804ccae694d2..ce195bc4136a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6850,7 +6850,7 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 {
 	struct ring_buffer_per_cpu *cpu_buffer_a;
 	struct ring_buffer_per_cpu *cpu_buffer_b;
-	int ret = -EINVAL;
+	int ret = -EBUSY;
 
 	if (!cpumask_test_cpu(cpu, buffer_a->cpumask) ||
 	    !cpumask_test_cpu(cpu, buffer_b->cpumask))
@@ -6891,10 +6891,10 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	atomic_inc(&cpu_buffer_a->record_disabled);
 	atomic_inc(&cpu_buffer_b->record_disabled);
 
-	ret = -EBUSY;
-	if (local_read(&cpu_buffer_a->committing))
+	/* Do not swap if either buffer is in the process of writing */
+	if (cpu_buffer_a->current_context)
 		goto out_dec;
-	if (local_read(&cpu_buffer_b->committing))
+	if (cpu_buffer_b->current_context)
 		goto out_dec;
 
 	/*

Care to send both patches? One with the above to fix the problem, and this
current patch to make the swap not return -EBUSY. The first would go to
stable, the latter would go in the next merge window.

-- Steve
