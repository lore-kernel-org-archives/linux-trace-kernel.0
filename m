Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D872287242;
	Mon, 29 Sep 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138333; cv=none; b=XnDPuLvl1eDRMPS/DJUTIZvkcQSLQfK0pIGL87QrhhPU+zra5HJ5DMX6MdqDuLagpsM3JlJmBc9JoJ9i8t+Ugjm4pgT+Cz3YOiFMKCDl2LvBOpNJg0F6qUPXCl7D7oUXMTbacbthaUW6diSyMivR6xjlCW8oyVxo8hHPZDx6sDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138333; c=relaxed/simple;
	bh=2q5RKKAdJ4SlqecBbNXLH+5eTvTAeMiEXIykHCwMExw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=laVzQIxML7hlJC4CkArHW5CESzwrP42AsNoVRYJ2ozwtDkWb+eiu2IIW4a0Kd5Dnkk001+dlg9l9n13g/sVZ4FltQ5ZKkrldkevFkPNkfolOF2p1X8A1ZLD4U7z3TmrvN7uwLGNNcRoAC1q7SYXC3jHf0ZeukOwY9w58Vp6r9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aof+a00w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjt0rjky; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aof+a00w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjt0rjky"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MboBZN26VAAZ4HSRsz4z8gwubj9nPqnmYABiymI1l7Y=;
	b=Aof+a00wv9jjKaWB6SFIS9Mlu2Ox6PiMHPdoHdsVc5a/wU9Pny+AuEUIrYsFnMgiajpgib
	8Xo7WBeNJ1Qr2crvW0k5k3CCaKbtX5uc17XTpmo7FfhWsvDvmcdbvJsJdjDlRpqmeqFg6E
	lkqcd5Y8eSXeK8MU89riu2kYbU8bJi6dr5krmZoN0eiEBr7ABMpBVxmjI/I7p5lRMOcu5c
	PXdl3dmsZvCOckaxCo/714yF5dbUcgndYGmfDjuvbHG9vhBNeSpUUhKh+PCy1kr6ROrjXH
	hRrvK1VBTtMe+3tRfbs5GSddLruEABEaGed80YKewD8HNsZD210xYNJukYnrgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MboBZN26VAAZ4HSRsz4z8gwubj9nPqnmYABiymI1l7Y=;
	b=wjt0rjkytgm4sjzjR+JDLg6Nm8RzT3Dtu9NuBdQC2RcYkNl6ZjuiTgekrd7BQxJJpisrQb
	PmfB1inMrtb4QrBw==
To: Steven Rostedt <rostedt@goodmis.org>, chenyuan_fl@163.com
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Yuan
 Chen <chenyuan@kylinos.cn>, Peter Zijlstra <peterz@infradead.org>,
 Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
In-Reply-To: <20250929044836.7169d5be@batman.local.home>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
 <20250929065731.1351028-1-chenyuan_fl@163.com>
 <20250929044836.7169d5be@batman.local.home>
Date: Mon, 29 Sep 2025 11:38:08 +0206
Message-ID: <84seg5d2p3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-09-29, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 29 Sep 2025 07:57:31 +0100
> chenyuan_fl@163.com wrote:
>
>> From: Yuan Chen <chenyuan@kylinos.cn>
>>=20
>> There is a critical race condition in kprobe initialization that can lea=
d to
>> NULL pointer dereference and kernel crash.
>>=20
>> [1135630.084782] Unable to handle kernel paging request at virtual addre=
ss 0000710a04630000
>> ...
>> [1135630.260314] pstate: 404003c9 (nZcv DAIF +PAN -UAO)
>> [1135630.269239] pc : kprobe_perf_func+0x30/0x260
>> [1135630.277643] lr : kprobe_dispatcher+0x44/0x60
>> [1135630.286041] sp : ffffaeff4977fa40
>> [1135630.293441] x29: ffffaeff4977fa40 x28: ffffaf015340e400
>> [1135630.302837] x27: 0000000000000000 x26: 0000000000000000
>> [1135630.312257] x25: ffffaf029ed108a8 x24: ffffaf015340e528
>> [1135630.321705] x23: ffffaeff4977fc50 x22: ffffaeff4977fc50
>> [1135630.331154] x21: 0000000000000000 x20: ffffaeff4977fc50
>> [1135630.340586] x19: ffffaf015340e400 x18: 0000000000000000
>> [1135630.349985] x17: 0000000000000000 x16: 0000000000000000
>> [1135630.359285] x15: 0000000000000000 x14: 0000000000000000
>> [1135630.368445] x13: 0000000000000000 x12: 0000000000000000
>> [1135630.377473] x11: 0000000000000000 x10: 0000000000000000
>> [1135630.386411] x9 : 0000000000000000 x8 : 0000000000000000
>> [1135630.395252] x7 : 0000000000000000 x6 : 0000000000000000
>> [1135630.403963] x5 : 0000000000000000 x4 : 0000000000000000
>> [1135630.412545] x3 : 0000710a04630000 x2 : 0000000000000006
>> [1135630.421021] x1 : ffffaeff4977fc50 x0 : 0000710a04630000
>> [1135630.429410] Call trace:
>> [1135630.434828]  kprobe_perf_func+0x30/0x260
>> [1135630.441661]  kprobe_dispatcher+0x44/0x60
>> [1135630.448396]  aggr_pre_handler+0x70/0xc8
>> [1135630.454959]  kprobe_breakpoint_handler+0x140/0x1e0
>> [1135630.462435]  brk_handler+0xbc/0xd8
>> [1135630.468437]  do_debug_exception+0x84/0x138
>> [1135630.475074]  el1_dbg+0x18/0x8c
>> [1135630.480582]  security_file_permission+0x0/0xd0
>> [1135630.487426]  vfs_write+0x70/0x1c0
>> [1135630.493059]  ksys_write+0x5c/0xc8
>> [1135630.498638]  __arm64_sys_write+0x24/0x30
>> [1135630.504821]  el0_svc_common+0x78/0x130
>> [1135630.510838]  el0_svc_handler+0x38/0x78
>> [1135630.516834]  el0_svc+0x8/0x1b0
>>=20
>> kernel/trace/trace_kprobe.c: 1308
>> 0xffff3df8995039ec <kprobe_perf_func+0x2c>:     ldr     x21, [x24,#120]
>> include/linux/compiler.h: 294
>> 0xffff3df8995039f0 <kprobe_perf_func+0x30>:     ldr     x1, [x21,x0]
>>=20
>> kernel/trace/trace_kprobe.c
>> 1308: head =3D this_cpu_ptr(call->perf_events);
>> 1309:   if (hlist_empty(head))
>> 1310:           return 0;
>>=20
>> crash> struct trace_event_call -o=20=20
>> struct trace_event_call {
>>   ...
>>   [120] struct hlist_head *perf_events;  //(call->perf_event)
>>   ...
>> }
>>=20
>> crash> struct trace_event_call ffffaf015340e528=20=20
>> struct trace_event_call {
>>   ...
>>   perf_events =3D 0xffff0ad5fa89f088, //this value is correct, but x21 =
=3D 0
>>   ...
>> }
>>=20
>> Race Condition Analysis:
>>=20
>> The race occurs between kprobe activation and perf_events initialization:
>>=20
>>   CPU0                                    CPU1
>>   =3D=3D=3D=3D                                    =3D=3D=3D=3D
>>   perf_kprobe_init
>>     perf_trace_event_init
>>       tp_event->perf_events =3D list;(1)
>>       tp_event->class->reg (2)=E2=86=90 KPROBE ACTIVE
>>                                           Debug exception triggers
>>                                           ...
>>                                           kprobe_dispatcher
>>                                             kprobe_perf_func (tk->tp.fla=
gs & TP_FLAG_PROFILE)
>>                                               head =3D this_cpu_ptr(call=
->perf_events)(3)
>>                                               (perf_events is still NULL)

I do not know anything about the kprobe and perf internals. This email
should hopefully help to act as a guide of where you need to place the
memory barrier _pair_. If I understand the problem description
correctly, you would need:

>> Problem:
>> 1. CPU0 executes (1) assigning tp_event->perf_events =3D list

smp_wmb()

>> 2. CPU0 executes (2) enabling kprobe functionality via class->reg()
>> 3. CPU1 triggers and reaches kprobe_dispatcher
>> 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)

smp_rmb()

>> 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
>>    call->perf_events is still NULL
>>=20
>> The issue: Assignment in step 1 may not be visible to CPU1 due to
>> missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.

A better explanation of the issue would be: CPU1 sees that kprobe
functionality is enabled but does not see that perf_events has been
assigned.

Add pairing read and write memory barriers to guarantee that if CPU1
sees that kprobe functionality is enabled, it must also see that
perf_events has been assigned.

Note that this could also be done more efficiently using a store_release
when setting the flag (in step 2) and a load_acquire when loading the
flag (in step 4).

John Ogness
