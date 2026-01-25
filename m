Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF128F4A;
	Sun, 25 Jan 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368821; cv=none; b=N/ibUDsiRubI4BKgC7C/78TIXzeR56bzt/e2FI8j1YGOj28eblNCoHf8/oADENxRNg94EEqLsAsXTz/HXU2tTB7QvkFSpPID10p9odd5bqYkO9jRBOdRS3jqVdOCbhrSmkqVaHIdPZcYSiIchR8DN4cPzYf31R8qqgALVxyGVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368821; c=relaxed/simple;
	bh=V6qgX6zrmKWt0Cd5LuNfzMKGigLDNvnIyIIwiYO6vf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DszWEU2lYWauHdtezZO07UpkYBOuUYOf47VJxC1T/EVDjivNsaegwubwFKIxj114tQC/wezHm7PmSbZIlNCoya7NCOCCLHws/KlZj90DIk1r8BGTc+LbGNA5GbVvYEBpGIpmnhiOkpChbc9Gsp0WhAP1PzyEaX3kCRQsYKOVVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVPtKu1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVPtKu1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A42CC4CEF1;
	Sun, 25 Jan 2026 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769368821;
	bh=V6qgX6zrmKWt0Cd5LuNfzMKGigLDNvnIyIIwiYO6vf4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bVPtKu1Qu5D9FpGmvBDESLkIm1qrt/igdnzqJskKxb3/MMSb3QM6zZzZAIMVIH7EF
	 W+dyikVWCi9NC1t+088BN+rfbDuVVNOMRYIafalQPR0ta1/fMKPdwMFA2RayHlrdJ4
	 GRcML1DEG3G9HmISWZk9CbMEwexscSrQXFFPg7TJsriU0ArdquFn8TwhYZBLf0buFm
	 XbaLkMeDCciIsQvOvylf85E1PiDuZFOLQcgmoWDQC2/AzjzeYOcnfTnYLlBh0D1M64
	 SOPFMLoDr271exjUkIVk2rzKGmqvUtqEGC/PBtYPbFWxX3IgCFCSTRb8/6Cdptd1MO
	 kgxofiF4RY9Zg==
Message-ID: <846e6ed2dcdef195d8cc9d65cb0f5025266da283.camel@kernel.org>
Subject: Re: [PATCH] tracing: Fix crash on synthetic stacktrace field usage
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Sun, 25 Jan 2026 13:20:19 -0600
In-Reply-To: <20260122194824.6905a38e@gandalf.local.home>
References: <20260122194824.6905a38e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Thu, 2026-01-22 at 19:48 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When creating a synthetic event based on an existing synthetic event that
> had a stacktrace field and the new synthetic event used that field a
> kernel crash occurred:
>=20
> =C2=A0~# cd /sys/kernel/tracing
> =C2=A0~# echo 's:stack unsigned long stack[];' > dynamic_events
> =C2=A0~# echo 'hist:keys=3Dprev_pid:s0=3Dcommon_stacktrace if prev_state =
& 3' >> events/sched/sched_switch/trigger
> =C2=A0~# echo 'hist:keys=3Dnext_pid:s1=3D$s0:onmatch(sched.sched_switch).=
trace(stack,$s1)' >> events/sched/sched_switch/trigger
>=20
> The above creates a synthetic event that takes a stacktrace when a task
> schedules out in a non-running state and passes that stacktrace to the
> sched_switch event when that task schedules back in. It triggers the
> "stack" synthetic event that has a stacktrace as its field (called "stack=
").
>=20
> =C2=A0~# echo 's:syscall_stack s64 id; unsigned long stack[];' >> dynamic=
_events
> =C2=A0~# echo 'hist:keys=3Dcommon_pid:s2=3Dstack' >> events/synthetic/sta=
ck/trigger
> =C2=A0~# echo 'hist:keys=3Dcommon_pid:s3=3D$s2,i0=3Did:onmatch(synthetic.=
stack).trace(syscall_stack,$i0,$s3)' >> events/raw_syscalls/sys_exit/trigge=
r
>=20
> The above makes another synthetic event called "syscall_stack" that
> attaches the first synthetic event (stack) to the sys_exit trace event an=
d
> records the stacktrace from the stack event with the id of the system cal=
l
> that is exiting.
>=20
> When enabling this event (or using it in a historgram):
>=20
> =C2=A0~# echo 1 > events/synthetic/syscall_stack/enable
>=20
> Produces a kernel crash!
>=20
> =C2=A0BUG: unable to handle page fault for address: 0000000000400010
> =C2=A0#PF: supervisor read access in kernel mode
> =C2=A0#PF: error_code(0x0000) - not-present page
> =C2=A0PGD 0 P4D 0
> =C2=A0Oops: Oops: 0000 [#1] SMP PTI
> =C2=A0CPU: 6 UID: 0 PID: 1257 Comm: bash Not tainted 6.16.3+deb14-amd64 #=
1 PREEMPT(lazy)=C2=A0 Debian 6.16.3-1
> =C2=A0Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-deb=
ian-1.17.0-1 04/01/2014
> =C2=A0RIP: 0010:trace_event_raw_event_synth+0x90/0x380
> =C2=A0Code: c5 00 00 00 00 85 d2 0f 84 e1 00 00 00 31 db eb 34 0f 1f 00 6=
6 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 <49> 8b 04=
 24 48 83 c3 01 8d 0c c5 08 00 00 00 01 cd 41 3b 5d 40 0f
> =C2=A0RSP: 0018:ffffd2670388f958 EFLAGS: 00010202
> =C2=A0RAX: ffff8ba1065cc100 RBX: 0000000000000000 RCX: 0000000000000000
> =C2=A0RDX: 0000000000000001 RSI: fffff266ffda7b90 RDI: ffffd2670388f9b0
> =C2=A0RBP: 0000000000000010 R08: ffff8ba104e76000 R09: ffffd2670388fa50
> =C2=A0R10: ffff8ba102dd42e0 R11: ffffffff9a908970 R12: 0000000000400010
> =C2=A0R13: ffff8ba10a246400 R14: ffff8ba10a710220 R15: fffff266ffda7b90
> =C2=A0FS:=C2=A0 00007fa3bc63f740(0000) GS:ffff8ba2e0f48000(0000) knlGS:00=
00000000000000
> =C2=A0CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =C2=A0CR2: 0000000000400010 CR3: 0000000107f9e003 CR4: 0000000000172ef0
> =C2=A0Call Trace:
> =C2=A0 <TASK>
> =C2=A0 ? __tracing_map_insert+0x208/0x3a0
> =C2=A0 action_trace+0x67/0x70
> =C2=A0 event_hist_trigger+0x633/0x6d0
> =C2=A0 event_triggers_call+0x82/0x130
> =C2=A0 trace_event_buffer_commit+0x19d/0x250
> =C2=A0 trace_event_raw_event_sys_exit+0x62/0xb0
> =C2=A0 syscall_exit_work+0x9d/0x140
> =C2=A0 do_syscall_64+0x20a/0x2f0
> =C2=A0 ? trace_event_raw_event_sched_switch+0x12b/0x170
> =C2=A0 ? save_fpregs_to_fpstate+0x3e/0x90
> =C2=A0 ? _raw_spin_unlock+0xe/0x30
> =C2=A0 ? finish_task_switch.isra.0+0x97/0x2c0
> =C2=A0 ? __rseq_handle_notify_resume+0xad/0x4c0
> =C2=A0 ? __schedule+0x4b8/0xd00
> =C2=A0 ? restore_fpregs_from_fpstate+0x3c/0x90
> =C2=A0 ? switch_fpu_return+0x5b/0xe0
> =C2=A0 ? do_syscall_64+0x1ef/0x2f0
> =C2=A0 ? do_fault+0x2e9/0x540
> =C2=A0 ? __handle_mm_fault+0x7d1/0xf70
> =C2=A0 ? count_memcg_events+0x167/0x1d0
> =C2=A0 ? handle_mm_fault+0x1d7/0x2e0
> =C2=A0 ? do_user_addr_fault+0x2c3/0x7f0
> =C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> The reason is that the stacktrace field is not labeled as such, and is
> treated as a normal field and not as a dynamic event that it is.
>=20
> In trace_event_raw_event_synth() the event is field is still treated as a
> dynamic array, but the retrieval of the data is considered a normal field=
,
> and the reference is just the meta data:
>=20
> // Meta data is retrieved instead of a dynamic array
> =C2=A0 str_val =3D (char *)(long)var_ref_vals[val_idx];
>=20
> // Then when it tries to process it:
> =C2=A0 len =3D *((unsigned long *)str_val) + 1;
>=20
> It triggers a kernel page fault.
>=20
> To fix this, first when defining the fields of the first synthetic event,
> set the filter type to FILTER_STACKTRACE. This is used later by the secon=
d
> synthetic event to know that this field is a stacktrace. When creating
> the field of the new synthetic event, have it use this FILTER_STACKTRACE
> to know to create a stacktrace field to copy the stacktrace into.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stac=
ktraces")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> ---
> =C2=A0kernel/trace/trace_events_hist.c=C2=A0 | 9 +++++++++
> =C2=A0kernel/trace/trace_events_synth.c | 8 +++++++-
> =C2=A02 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 5e6e70540eef..c97bb2fda5c0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2057,6 +2057,15 @@ static struct hist_field *create_hist_field(struct=
 hist_trigger_data *hist_data,
> =C2=A0			hist_field->fn_num =3D HIST_FIELD_FN_RELDYNSTRING;
> =C2=A0		else
> =C2=A0			hist_field->fn_num =3D HIST_FIELD_FN_PSTRING;
> +	} else if (field->filter_type =3D=3D FILTER_STACKTRACE) {
> +		flags |=3D HIST_FIELD_FL_STACKTRACE;
> +
> +		hist_field->size =3D MAX_FILTER_STR_VAL;
> +		hist_field->type =3D kstrdup_const(field->type, GFP_KERNEL);
> +		if (!hist_field->type)
> +			goto free;
> +
> +		hist_field->fn_num =3D HIST_FIELD_FN_STACK;
> =C2=A0	} else {
> =C2=A0		hist_field->size =3D field->size;
> =C2=A0		hist_field->is_signed =3D field->is_signed;
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_event=
s_synth.c
> index 4554c458b78c..45c187e77e21 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -130,7 +130,9 @@ static int synth_event_define_fields(struct trace_eve=
nt_call *call)
> =C2=A0	struct synth_event *event =3D call->data;
> =C2=A0	unsigned int i, size, n_u64;
> =C2=A0	char *name, *type;
> +	int filter_type;
> =C2=A0	bool is_signed;
> +	bool is_stack;
> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	for (i =3D 0, n_u64 =3D 0; i < event->n_fields; i++) {
> @@ -138,8 +140,12 @@ static int synth_event_define_fields(struct trace_ev=
ent_call *call)
> =C2=A0		is_signed =3D event->fields[i]->is_signed;
> =C2=A0		type =3D event->fields[i]->type;
> =C2=A0		name =3D event->fields[i]->name;
> +		is_stack =3D event->fields[i]->is_stack;
> +
> +		filter_type =3D is_stack ? FILTER_STACKTRACE : FILTER_OTHER;
> +
> =C2=A0		ret =3D trace_define_field(call, type, name, offset, size,
> -					 is_signed, FILTER_OTHER);
> +					 is_signed, filter_type);
> =C2=A0		if (ret)
> =C2=A0			break;
> =C2=A0

