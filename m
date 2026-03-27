Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA54331ED80;
	Fri, 27 Mar 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644423; cv=none; b=IPRuPowfwTUF/Xog7WEofMtDRFggDr87knYGXTTNOUHoyvTWYruA1vo3coD0ELoQmUR6fP0RWbYGTRyx1+FjQY1M+j864DztFVUWVd5sEpI4pwhfjQCvfRjaClRHT5m9MPy/5JqjxT0xUIlkN1S1rLHksbd/FlxOFHlUBbTkH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644423; c=relaxed/simple;
	bh=o0Wv4fhMuEu4YXD4beuFdbFlO259PZnTSgbOpsHiL6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOXDTj2OymowZJ6Im4auSH1JEmWsDbCUj4rbd0oSQxMtngPAz1VYveJCCsDS2jkuxXNPOcfwwa13Kbt+ZQVzBAk6146ViXmRJ8E51etzaH6OAF/EJkusDLgfXAYXSnL6qtSynmCOslMKt/MESk4A6jeu2z0kjExumzxpWDFXu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A31CC1B99E7;
	Fri, 27 Mar 2026 20:47:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id E3EBF60009;
	Fri, 27 Mar 2026 20:46:58 +0000 (UTC)
Date: Fri, 27 Mar 2026 16:47:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v13 4/4] ring-buffer: Add persistent ring buffer
 selftest
Message-ID: <20260327164748.67b6453d@gandalf.local.home>
In-Reply-To: <20260327162508.6cac690c@gandalf.local.home>
References: <177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com>
	<177440552560.1529621.1405976992959650354.stgit@mhiramat.tok.corp.google.com>
	<20260327162508.6cac690c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E3EBF60009
X-Stat-Signature: edakuf6mazkf6scgcgokcq8k6r6fpnoi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cWRtqWLMqTRIXfP1Wlm7As4aJvOtt5xg=
X-HE-Tag: 1774644418-255010
X-HE-Meta: U2FsdGVkX19Cfx1v/FYeeKD7f+IhFDpnOKO8SmCRmsCEGGZ/ms3y5ou+dMt471PsnVfqgLwy1Gf9NDbPyITg1Jdsap9ZBBulG3bT2L4qWesHQvrbhoH+hiuEr+AK+Is0a8CXQp15QThRKb8qTp4M/mnSgp+fFZ1GN9cMMjYB9rgzCrwD0aKXEz6jGiwf/edfPhYlqUXsM0ErH9sTqxbfbqQoW1Rg74uK/ehqG69vnYpTnXPHCGR60JbLtl4OrhFfzjSELU0Zcrx5Q9B3DS1xGAbUmvvUhYRVBBknK8k4smhptT0u7XCbQDpWdpbuEEvClazGhKSBFfDW/3LjHfyq+0+I0nMh8R5x5Ej3nRiB9X1TxE3Lq2gvxMfpzPVSaLUG9yJzSyXnp/T34MaKUTVDfXwDuSZQ/UyE

On Fri, 27 Mar 2026 16:25:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Also, I noticed that there's nothing that reads the RB_MISSING as I thought
> it might. I'll have to look into how to pass that info to the trace output.

And when I cat /sys/kernel/tracing/instances/ptracingtest/per_cpu/cpuX/trace_pipe

   (where X is the failed buffer)

It triggered an infinite loop of:

[  206.549217] ------------[ cut here ]------------
[  206.550907] WARNING: kernel/trace/ring_buffer.c:5751 at __rb_get_reader_page+0xa6b/0x1040, CPU#2: cat/1197
[  206.554111] Modules linked in:
[  206.555331] CPU: 2 UID: 0 PID: 1197 Comm: cat Tainted: G        W           7.0.0-rc4-test-00028-g7b37f48b2c57-dirty #276 PREEMPT(full) 
[  206.559048] Tainted: [W]=WARN
[  206.560244] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  206.563212] RIP: 0010:__rb_get_reader_page+0xa6b/0x1040
[  206.564964] Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 4a 05 00 00 48 8b 43 10 be 04 00 00 00 4c 8d 60 08 4c 89 e7 e8 9a 2d 63 00 f0 41 ff 04 24 <0f> 0b e9 36 fb ff ff e8 29 39 05 00 fb 0f 1f 44 00 00 4d 85 f6 0f
[  206.572295] RSP: 0018:ffff888112a77938 EFLAGS: 00010006
[  206.574095] RAX: 0000000000000001 RBX: ffff888100d6e000 RCX: 0000000000000001
[  206.576458] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff88810027b808
[  206.578749] RBP: 1ffff1102254ef34 R08: ffffffff909a1556 R09: ffffed102004f701
[  206.581020] R10: ffffed102004f702 R11: ffff88823443a000 R12: ffff88810027b808
[  206.583312] R13: ffff888100f65f00 R14: ffff888100f65f00 R15: dffffc0000000000
[  206.585647] FS:  00007f98e4d80780(0000) GS:ffff88829e3c2000(0000) knlGS:0000000000000000
[  206.588246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  206.590179] CR2: 00007f98e4d3e000 CR3: 000000012272e006 CR4: 0000000000172ef0
[  206.592444] Call Trace:
[  206.593518]  <TASK>
[  206.594436]  ? __pfx___rb_get_reader_page+0x10/0x10
[  206.596148]  ? lock_acquire+0x1b2/0x340
[  206.597599]  rb_buffer_peek+0x37e/0x520
[  206.598954]  ring_buffer_peek+0xe9/0x310
[  206.601956]  peek_next_entry+0x15a/0x280
[  206.603420]  __find_next_entry+0x39f/0x530
[  206.604918]  ? __pfx___mutex_lock+0x10/0x10
[  206.606474]  ? rcu_is_watching+0x15/0xb0
[  206.616049]  ? __pfx___find_next_entry+0x10/0x10
[  206.617741]  ? preempt_count_sub+0x10c/0x1c0
[  206.619242]  ? __pfx_down_read+0x10/0x10
[  206.620687]  trace_find_next_entry_inc+0x2f/0x240
[  206.622351]  tracing_read_pipe+0x4e7/0xc60
[  206.623852]  ? rw_verify_area+0x353/0x5f0
[  206.625325]  vfs_read+0x171/0xb20
[  206.626592]  ? __lock_acquire+0x487/0x2220
[  206.628135]  ? __pfx___handle_mm_fault+0x10/0x10
[  206.629784]  ? __pfx_vfs_read+0x10/0x10
[  206.632696]  ? __pfx_css_rstat_updated+0x10/0x10
[  206.634351]  ? rcu_is_watching+0x15/0xb0
[  206.635835]  ? trace_preempt_on+0x126/0x160
[  206.637362]  ? preempt_count_sub+0x10c/0x1c0
[  206.638880]  ? count_memcg_events+0x10a/0x4b0
[  206.640455]  ? find_held_lock+0x2b/0x80
[  206.641908]  ? rcu_read_unlock+0x17/0x60
[  206.643340]  ? lock_release+0x1ab/0x320
[  206.644812]  ksys_read+0xff/0x200
[  206.646127]  ? __pfx_ksys_read+0x10/0x10
[  206.647651]  do_syscall_64+0x117/0x16c0
[  206.649035]  ? irqentry_exit+0xd9/0x690
[  206.650548]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  206.652331] RIP: 0033:0x7f98e4e14eb2
[  206.653743] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
[  206.659364] RSP: 002b:00007ffdc0a8d930 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[  206.663251] RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f98e4e14eb2
[  206.665614] RDX: 0000000000040000 RSI: 00007f98e4d3f000 RDI: 0000000000000003
[  206.668022] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[  206.670306] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f98e4d3f000
[  206.672624] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000040000
[  206.674941]  </TASK>
[  206.675927] irq event stamp: 7898
[  206.677154] hardirqs last  enabled at (7897): [<ffffffff90991f6f>] ring_buffer_empty_cpu+0x19f/0x2f0
[  206.680088] hardirqs last disabled at (7898): [<ffffffff909a277d>] ring_buffer_peek+0x17d/0x310
[  206.682881] softirqs last  enabled at (7888): [<ffffffff9056cffc>] handle_softirqs+0x5bc/0x7c0
[  206.685710] softirqs last disabled at (7879): [<ffffffff9056d322>] __irq_exit_rcu+0x112/0x230
[  206.688483] ---[ end trace 0000000000000000 ]---

OK, that RB_MISSED_EVENTS is causing an issue. Something else we need to
look into. The warning is that __rb_get_reader_page() is trying more than 3
times. Thus I think it's constantly swapping the head page and the reader
page. Something to investigate.

So, I'm holding off pulling in these patches. I may take the first one
though.

-- Steve
