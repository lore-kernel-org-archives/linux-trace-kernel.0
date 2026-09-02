Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD094968FE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356654; cv=none; b=tD1USuoeGSmlvFeR5Zgsj+8NePr/zPhZ0oC7KxFvQDKvKvvNx9c4iii1CqO130gYhoEM7bVoeF4K2JrXPuhVSdqr4TFWPVrg7AOsWJRzO9K/5kFOSnaxnH3m+KrruKUoBoaIKeOt1DuziyUM/G8kAOoBmQNnFd4/CUVBZHDIi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356654; c=relaxed/simple;
	bh=pRUqb97H8vrC9+iaFu2jrLuXdilk+UpwE840//dw1B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bjj0nsM1u6eYnQEFL6XpGsmpmscJNaw5AuSXvYQfAHaixbCCJYzIr/63+WlghDyyyZChha2RUuDp9QhdB6Bci82gMBVV9wUB6rJyEmJbGwfUIe5FAuJS1l71bZv050fANO/9xbFdkRrkbfs1kBNxwDJLliJGnnsyPsDr09kFXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6mPFeJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6mPFeJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943AD1F000E9;
	Wed,  2 Sep 2026 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356652;
	bh=skTqcjuBaPTwrnVdFVDw5dizOIr7NopLp9D0unhy2PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6mPFeJoZ+loI/E+j8WIR/TB79GB9kczZTXj7Z6SA2bHnphee7FwiPPTuABnvjhWH
	 g7UDKb+/+J29bToaNa5eyTED96/nyuOfSB+BZ/50lDFO6wx64nvOR8icjyefEpzZoR
	 1Xj9zNJmddkjyOGUqYd/T/ynixvvqvXlEvlIt1w/c774toFpGXuYNW5KEztxSgayAC
	 KWjifs+qQlXDIMV3b2zjaR5n1rlQnP7s4FxiAQTEjtHimp/BXUAxfrhBGw5WR+P+Hx
	 EAVTATFGCoqTZ2bShyRo7kGEiY7Amv8qOuulodUttvZzBd4c6w3Pl+dAKAz8F1JZBh
	 dCI1YYGoOSNeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] rtla: Unconditionally clean any pre-existing
 filters for user-provided events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Valentin Schneider" <vschneid@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902123942.695822-8-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
 <20260902123942.695822-8-vschneid@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:44:12 +0000
Message-Id: <20260902134412.943AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Logic error in command-line trigger processing causing triggers =
to accumulate instead of overriding.
- [Medium] Unconditionally clearing filters during event processing destroy=
s previously configured specific event filters when a subsystem is enabled.
- [Medium] Out-of-bounds read in osnoise_ipi_cpumask_handler due to using g=
libc CPU_AND on a dynamically sized trace event field.
- [Medium] Missing bounds check on `dst_cpu` parsed from trace record leads=
 to an out-of-bounds array write.
--

commit 5cb00dbb92aa356c89071b1755fbef9a7743360f
Author: Valentin Schneider <vschneid@redhat.com>

rtla: Unconditionally clean any pre-existing filters for user-provided even=
ts

This commit unconditionally cleans up pre-existing filters when enabling an
event provided via the '-e' command line argument to prevent confusion. It
also documents that when the same event is specified multiple times, only
the last specified filter or trigger applies.

> diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/=
tools/rtla/common_options.txt
> index 38da1cf443a48..6bf0f86393333 100644
> --- a/Documentation/tools/rtla/common_options.txt
> +++ b/Documentation/tools/rtla/common_options.txt
> @@ -26,12 +26,19 @@
> =20
>  **--filter** *<filter>*
> =20
> -        Filter the previous **-e** *sys:event* event with *<filter>*. Fo=
r further information about event filtering see https://www.kernel.org/doc/=
html/latest/trace/events.html#event-filtering.
> +        Filter the previous **-e** *sys:event* event with *<filter>*.
> +
> +        If the same event is specified more than once but with different=
 filters, the last specified filter will be the only one applied.
> +
> +	For further information about event filtering see https://www.kernel.or=
g/doc/html/latest/trace/events.html#event-filtering.
> =20
>          This option cannot be unset.
> =20
>  **--trigger** *<trigger>*
>          Enable a trace event trigger to the previous **-e** *sys:event*.
> +
> +        If the same event is specified more than once but with different=
 triggers, the last specified trigger will be the only one applied.
> +

[Severity: Medium]
Does the command-line trigger processing actually implement this override
behavior?

Looking at trace_event_enable_trigger() in tools/tracing/rtla/src/trace.c,
the new trigger is written without clearing prior triggers for the same
event:

	retval =3D tracefs_event_file_write(instance->inst, tevent->system,
					  tevent->event, "trigger", trigger);

Since tracefs 'trigger' files are cumulative by default, could this cause
triggers to accumulate instead of replacing the previous one?

>          If the *hist:* trigger is activated, the output histogram will b=
e automatically saved to a file named *system_event_hist.txt*.
>          For example, the command:
> =20
> diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trac=
e.c
> index 17d148f7d5d6e..06204d339f967 100644
> --- a/tools/tracing/rtla/src/trace.c
> +++ b/tools/tracing/rtla/src/trace.c
> @@ -487,6 +487,10 @@ static int trace_event_enable_filter(struct trace_in=
stance *instance,
>  	char filter[MAX_PATH];
>  	int retval;
> =20
> +	/* Unconditionally clean any pre-existing filters */
> +	tracefs_event_file_write(instance->inst, tevent->system,
> +				 tevent->event, "filter", "0");
> +

[Severity: Medium]
Will this destroy previously configured specific event filters when a broad=
er
subsystem is enabled?

If tevent->event is NULL (e.g., when enabling an entire subsystem like
'-e sched'), unconditionally writing '0' to the subsystem's filter file
might wipe out all specific event filters previously configured within
that subsystem.

>  	if (!tevent->filter)
>  		return 0;
> =20

While reviewing this series, I also noticed a couple of issues introduced
in osnoise_top.c:

[Severity: Medium]
Does osnoise_ipi_cpumask_handler() have an out-of-bounds read when parsing
the cpumask field?

When processing a broadcast IPI trace event, the dynamically sized 'cpumask'
field is extracted into event_cpus:

tools/tracing/rtla/src/osnoise_top.c:osnoise_ipi_cpumask_handler() {
    ...
    event_cpus =3D tep_get_field_raw(s, event, "cpumask", record, &len, 1);
    ...
    CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_cpus);
    ...
}

Since glibc's CPU_AND() unconditionally reads 128 bytes (sizeof(cpu_set_t))
from event_cpus, and the raw buffer size is only 'len' bytes, could this
read past the end of the buffer?


[Severity: Medium]
Is there a missing bounds check on dst_cpu in osnoise_ipi_cpu_handler()
that could lead to an out-of-bounds write?

The 'cpu' field is parsed from the trace record directly into dst_cpu and
used as an array index:

tools/tracing/rtla/src/osnoise_top.c:osnoise_ipi_cpu_handler() {
    ...
    tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
    account_ipi(tool, dst_cpu);
    ...
}

tools/tracing/rtla/src/osnoise_top.c:account_ipi() {
    ...
    cpu_data =3D &data->cpu_data[dst_cpu];
    update_sum(&cpu_data->ipi_count, &inc);
    ...
}

If the trace record contains an unexpectedly high CPU ID (e.g., due to hotp=
lug
or trace buffer corruption), could this write beyond the bounds of the
data->cpu_data array since there's no verification that dst_cpu < nr_cpus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902123942.6958=
22-1-vschneid@redhat.com?part=3D7
