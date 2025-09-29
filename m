Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54E625;
	Mon, 29 Sep 2025 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135733; cv=none; b=gHYF1axNCq368xUHkH81V2Ab23MVaibS/76oItwGClIevgwiG7mk+MgswczmsA3wh9kPsv5nT4/gyX6Y7SoBN7yh2I/y+dpBMd84i4CMyp+eWCs+tY8o5q5XrdAwdZ9dpf7hfQ4Ce+p3SHiF0NBnQatsHCUThvMcYZ7dvQ/6PS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135733; c=relaxed/simple;
	bh=8x0ibQTZJ9QKKv+YgjcWlu1iHcOP7/tyFB4QNKtMHZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eL4Nl5jPsSQPY0EUZlyozxnNCK+me9Kf4O9eqtGKRJQBt7GGbjx+rd1btDgFURmwIu445EC9C/L4lRe5R/8mbqi3fFs5BEBwCSVVcraXptY1WMHkvIOIeTNrOgqusODpF0nEeguDxXLpjm8d4QRYYitwayQiEkEViblN7vSiPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id D033CB807E;
	Mon, 29 Sep 2025 08:48:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id B8CED2002A;
	Mon, 29 Sep 2025 08:48:39 +0000 (UTC)
Date: Mon, 29 Sep 2025 04:48:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: chenyuan_fl@163.com
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Yuan Chen
 <chenyuan@kylinos.cn>, Peter Zijlstra <peterz@infradead.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, John Ogness
 <john.ogness@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20250929044836.7169d5be@batman.local.home>
In-Reply-To: <20250929065731.1351028-1-chenyuan_fl@163.com>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
	<20250929065731.1351028-1-chenyuan_fl@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 7f9fim3fwbg76zhwr641rj9iwjyabyxx
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B8CED2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hw1aPlFkPzcHehqG6jrOD9SOvFeMR8r8=
X-HE-Tag: 1759135719-26635
X-HE-Meta: U2FsdGVkX19oH1Di8K/L16xO5ZhPAf0AzQqp/57zqqFjIj1u5ZrapVC+zZoF1O6wtPi13ton6ksfKTeX40a9sUKrOEJBQ4InU5dPVspzBaSeDFJo8Jdmr30BdfvpUNJyFG3De755O0ILufWyci5MLN4vYfIK2Xj+iNbb+kqv3SpfR3FhcCWnauo9CHy16mVZ3U/XQK5SMjKxlg6nvrBTU8ZzWKNbmkdlEsG+vqpRRrh3k+NGb7V+Kwqwdgi21rgMHbEYqNloJbuuwtdFmpOjry6/HonnT2I/R7x28CzJ6zdtP9m3Tmc4T85LBr/zf10PYA7qa/nXWDPIYvlV+xkdOinbxYuTIPrDCDEDWZnqzqjMFWigGWiOPvsPHDaBpb3S

On Mon, 29 Sep 2025 07:57:31 +0100
chenyuan_fl@163.com wrote:

> From: Yuan Chen <chenyuan@kylinos.cn>
>=20
> There is a critical race condition in kprobe initialization that can lead=
 to
> NULL pointer dereference and kernel crash.
>=20
> [1135630.084782] Unable to handle kernel paging request at virtual addres=
s 0000710a04630000
> ...
> [1135630.260314] pstate: 404003c9 (nZcv DAIF +PAN -UAO)
> [1135630.269239] pc : kprobe_perf_func+0x30/0x260
> [1135630.277643] lr : kprobe_dispatcher+0x44/0x60
> [1135630.286041] sp : ffffaeff4977fa40
> [1135630.293441] x29: ffffaeff4977fa40 x28: ffffaf015340e400
> [1135630.302837] x27: 0000000000000000 x26: 0000000000000000
> [1135630.312257] x25: ffffaf029ed108a8 x24: ffffaf015340e528
> [1135630.321705] x23: ffffaeff4977fc50 x22: ffffaeff4977fc50
> [1135630.331154] x21: 0000000000000000 x20: ffffaeff4977fc50
> [1135630.340586] x19: ffffaf015340e400 x18: 0000000000000000
> [1135630.349985] x17: 0000000000000000 x16: 0000000000000000
> [1135630.359285] x15: 0000000000000000 x14: 0000000000000000
> [1135630.368445] x13: 0000000000000000 x12: 0000000000000000
> [1135630.377473] x11: 0000000000000000 x10: 0000000000000000
> [1135630.386411] x9 : 0000000000000000 x8 : 0000000000000000
> [1135630.395252] x7 : 0000000000000000 x6 : 0000000000000000
> [1135630.403963] x5 : 0000000000000000 x4 : 0000000000000000
> [1135630.412545] x3 : 0000710a04630000 x2 : 0000000000000006
> [1135630.421021] x1 : ffffaeff4977fc50 x0 : 0000710a04630000
> [1135630.429410] Call trace:
> [1135630.434828]  kprobe_perf_func+0x30/0x260
> [1135630.441661]  kprobe_dispatcher+0x44/0x60
> [1135630.448396]  aggr_pre_handler+0x70/0xc8
> [1135630.454959]  kprobe_breakpoint_handler+0x140/0x1e0
> [1135630.462435]  brk_handler+0xbc/0xd8
> [1135630.468437]  do_debug_exception+0x84/0x138
> [1135630.475074]  el1_dbg+0x18/0x8c
> [1135630.480582]  security_file_permission+0x0/0xd0
> [1135630.487426]  vfs_write+0x70/0x1c0
> [1135630.493059]  ksys_write+0x5c/0xc8
> [1135630.498638]  __arm64_sys_write+0x24/0x30
> [1135630.504821]  el0_svc_common+0x78/0x130
> [1135630.510838]  el0_svc_handler+0x38/0x78
> [1135630.516834]  el0_svc+0x8/0x1b0
>=20
> kernel/trace/trace_kprobe.c: 1308
> 0xffff3df8995039ec <kprobe_perf_func+0x2c>:     ldr     x21, [x24,#120]
> include/linux/compiler.h: 294
> 0xffff3df8995039f0 <kprobe_perf_func+0x30>:     ldr     x1, [x21,x0]
>=20
> kernel/trace/trace_kprobe.c
> 1308: head =3D this_cpu_ptr(call->perf_events);
> 1309:   if (hlist_empty(head))
> 1310:           return 0;
>=20
> crash> struct trace_event_call -o =20
> struct trace_event_call {
>   ...
>   [120] struct hlist_head *perf_events;  //(call->perf_event)
>   ...
> }
>=20
> crash> struct trace_event_call ffffaf015340e528 =20
> struct trace_event_call {
>   ...
>   perf_events =3D 0xffff0ad5fa89f088, //this value is correct, but x21 =
=3D 0
>   ...
> }
>=20
> Race Condition Analysis:
>=20
> The race occurs between kprobe activation and perf_events initialization:
>=20
>   CPU0                                    CPU1
>   =3D=3D=3D=3D                                    =3D=3D=3D=3D
>   perf_kprobe_init
>     perf_trace_event_init
>       tp_event->perf_events =3D list;(1)
>       tp_event->class->reg (2)=E2=86=90 KPROBE ACTIVE
>                                           Debug exception triggers
>                                           ...
>                                           kprobe_dispatcher
>                                             kprobe_perf_func (tk->tp.flag=
s & TP_FLAG_PROFILE)
>                                               head =3D this_cpu_ptr(call-=
>perf_events)(3)
>                                               (perf_events is still NULL)
>=20
> Problem:
> 1. CPU0 executes (1) assigning tp_event->perf_events =3D list
> 2. CPU0 executes (2) enabling kprobe functionality via class->reg()
> 3. CPU1 triggers and reaches kprobe_dispatcher
> 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
> 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
>    call->perf_events is still NULL
>=20
> The issue: Assignment in step 1 may not be visible to CPU1 due to
> missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.
>=20
> Add smp_mb() barrier between perf_events assignment and enabling
> profile functionality to ensure visibility ordering across CPUs.
>=20
> v1->v2: Fix race analysis (per Masami) - kprobe arms in class->reg().
>=20
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/trace/trace_event_perf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_p=
erf.c
> index a6bb7577e8c5..6eff8c9d6bae 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -113,6 +113,11 @@ static int perf_trace_event_reg(struct trace_event_c=
all *tp_event,
> =20
>  	tp_event->perf_events =3D list;
> =20
> +	/* Ensure perf_events assignment is visible to all CPUs before enabling
> +	 * profile functionality
> +	 */
> +	smp_mb();

So from other discussions I had with John and Sebastian (both Cc'd),
memory barriers are not for "making memory visible", but instead are
for interactions between memory and two different CPUs, where both CPUs
have memory barriers.

John or Sebastian, thoughts?

-- Steve


> +
>  	if (!total_ref_count) {
>  		char __percpu *buf;
>  		int i;

=09
