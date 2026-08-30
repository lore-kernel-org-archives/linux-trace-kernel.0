Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8BD531
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Aug 2026 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788089076; cv=none; b=IAVUGH57Vsc6cJiF7EcgSKOX2T7ubnVYr3/N87LsP5aVSFoyteLN1FNaVgwxUpzevV9igy2mKtUcoG5RZ4QG78TtvIlKZhMak3NzUGUqNT/M8Lvy1679/gn4FoibRyb45GUhEskrzj9r5LN1GyjkWDfwVrcxZZ8XqrNb1wyqfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788089076; c=relaxed/simple;
	bh=6RWb8XmtZBGpCAgxxEuLhocH1T65SDCJYftREkQ6OFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ge3D8QMCTpAEQNYj3GV99+iD8WKZOVJcp4Z+okbfq59l92BrHowdSFAqwHq0frsKcD2DtdOojvu7TtF4WhqDm+iM+54iV5PGA87EOb03ldavdKP0OOfDeHPjYNJtadMQ+GWFLeITkIVstk8PlM4tWAqCPVexENs/uZmEMYuS4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYWmpN64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYWmpN64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32E71F000E9;
	Sun, 30 Aug 2026 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788089075;
	bh=sYwffjz8o9EZhZe9Vgw4GysirlllPKBhN8kF5V7HcI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYWmpN64Zz81J20/D9uT46vRZtIzlEhZP1Dk3S/xvCbAQEC/oYos7whyOCgJsroin
	 B7rvikYz/Z3SUe49LtdrQJwwI3cmj/pBUxeLI9voqouARTRr1wRynnbYOxqGgUSsD6
	 meLtcwbparjabP7IjhY3FwZVGrkQwLo5H6uSpnJQ/BX0xVGGcugZcidA9T/PNk65pk
	 HlNH+/O1rThjh/xD9xLM/8PKJli00JfNvTfgM+DBLuKqReQxF4YQCXGRtM1jXMgq1A
	 hOS6VR5aeg5i5bmR4qFyWkaPWn8A1b8eLAit3I0NXnB0dBRgoJ+i7kYRl7yMgOqZ/m
	 VL74fz688/H9g==
From: sashiko-bot@kernel.org
Subject: Re: =?utf-8?b?4oCLW1JGQw==?= PATCH 2/4] ftrace: Centralize task
 filter state updates
Reply-To: sashiko-reviews@lists.linux.dev
To: hu.shengming@zte.com.cn
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260830191029780ubpoH6QdASK9mvsfhLTcA@zte.com.cn>
References: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
 <20260830191029780ubpoH6QdASK9mvsfhLTcA@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 11:24:34 +0000
Message-Id: <20260830112434.F32E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but unregister_trace=
_sched_switch does not wait for in-flight probes to complete before ftrace_=
ignore_pid is reset, permanently disabling tracing for a CPU.
--

commit 03992a852b272ad537b862229061fb0d87062720
Author: Shengming Hu <hu.shengming@zte.com.cn>

[RFC PATCH 2/4] ftrace: Centralize task filter state updates

This commit moves probe registration and cache refresh logic into a central=
ized=20
helper ftrace_task_filters_changed() to prepare for task comm filtering. It=
=20
updates shared state when a filter changes and refreshes cached results for=
=20
running tasks when PID filters are cleared.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 825d4474876cc..05775047837d2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> @@ -8677,11 +8687,31 @@ void ftrace_pid_follow_fork(struct trace_array *t=
r, bool enable)
>  	}
>  }
> =20
> +static void ftrace_task_filters_changed(struct trace_array *tr,
> +					bool was_enabled)
> +{
> +	bool enabled =3D ftrace_task_filters_active(tr);
> +	int cpu;
> +
> +	if (!was_enabled && enabled)
> +		register_trace_sched_switch(ftrace_filter_task_sched_switch_probe, tr);
> +	else if (was_enabled && !enabled) {
> +		unregister_trace_sched_switch(ftrace_filter_task_sched_switch_probe, t=
r);
> +		for_each_possible_cpu(cpu)
> +			per_cpu_ptr(tr->array_buffer.data, cpu)->ftrace_ignore_pid =3D
> +				FTRACE_PID_TRACE;
> +		return;
> +	}

[Severity: High]
This is a pre-existing issue, but does unregister_trace_sched_switch wait f=
or=20
in-flight probes to complete before ftrace_ignore_pid is reset in the loop=
=20
here?

If a concurrent sched_switch probe evaluates the old PID list and decides t=
o=20
ignore a task, while another CPU clears the filters, unregisters the probe,=
=20
and resets ftrace_ignore_pid, we might have a race condition. If the in-fli=
ght=20
probe writes FTRACE_PID_IGNORE after this reset loop completes, the state=20
becomes corrupted and could permanently disable tracing for a CPU.

Can we safely reset ftrace_ignore_pid here without an RCU synchronization=20
barrier first?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830190743637Mh=
XoixrAPc1rfm-G8eIcg@zte.com.cn?part=3D2
