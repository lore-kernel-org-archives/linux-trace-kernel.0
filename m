Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C61ACED9;
	Mon, 14 Apr 2025 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665271; cv=none; b=B8D+BqsSCJ2uhSrCxluJhwoKKFVSa63vkDQWejrtB1W7NFksDWvoI1FvJgYTwk89plKJhL+cGdwf2A2sU5dsmJ2fMK6OL8cKkN3650GttDEmJtYqkvKaJDrz9BKKBx8XMnZLFzHMGMwE5f+IKJj47N2tT8N10VkNwdoPM/4S1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665271; c=relaxed/simple;
	bh=TK7O27dB9YbS2OPIUfKb5HH7MQuzdTL+l3kxDxcm/P0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDhewcP4OMeMAwUqcgKlEJyZZg83EDRhyqRi50qDt/l1Rx/xsjH2sSjQpBWZYOUXKf/ioNgaU+cKFYirLG0N5JUU/gl+PsPo6N1EYbaoqY9NIdKeKagLFn4cmKvXiVRxDbp0A8W8t226+7FDWsR8Bq02VVsdf8c/YdkK+iHBmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNBtHWfz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNBtHWfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3807C4CEE2;
	Mon, 14 Apr 2025 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665271;
	bh=TK7O27dB9YbS2OPIUfKb5HH7MQuzdTL+l3kxDxcm/P0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RNBtHWfzRhjoVswQGgodCgFxMyecfv/gCPIgrkSV4tjpIjF/Zb6DKw/XyQFRQy50B
	 ewf/MPP6LXBiMhscUUR2fHGKwysq4/BXQoDzThE3/BQxnbezdfGiHzTlGbZgTW9elk
	 9LWmxF71+tsJJvZ4UohLXqvC4jF/GiXVX5uQU37tL29FpU3p4wXWkewQ1fTbeSUwKC
	 JfHF+T9DFIHM9s5ZfGZ9ZBu50USG3oyYKE02OUKo9gObIQeB9gVA4vVs0Avsx6bc/L
	 iU+Z5hJcSzr84Oy3nVc6nrVbDXP+VoxbqqvYSvF7mrBXZ94ihALjGUL/RvQO+Rj+P+
	 6CQSnHiU9S9Dw==
Message-ID: <035586a635168597a25a8df595ad7c1a8249bdda.camel@kernel.org>
Subject: Re: [PATCH] tracing: Add common_comm to histograms
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Mon, 14 Apr 2025 16:14:29 -0500
In-Reply-To: <20250407154912.3c6c6246@gandalf.local.home>
References: <20250407154912.3c6c6246@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Mon, 2025-04-07 at 15:49 -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> If one wants to trace the name of the task that wakes up a process and
> pass that to the synthetic events, there's nothing currently that lets th=
e
> synthetic events do that. Add a "common_comm" to the histogram logic that
> allows histograms save the current->comm as a variable that can be passed
> through and added to a synthetic event:
>=20
> =C2=A0# cd /sys/kernel/tracing
> =C2=A0# echo 's:wake_lat char[] waker; char[] wakee; u64 delta;' >> dynam=
ic_events
> =C2=A0# echo 'hist:keys=3Dpid:comm=3Dcommon_comm:ts=3Dcommon_timestamp.us=
ecs if !(common_flags & 0x18)' > events/sched/sched_waking/trigger
> =C2=A0# echo 'hist:keys=3Dnext_pid:wake_comm=3D$comm:delta=3Dcommon_times=
tamp.usecs-$ts:onmatch(sched.sched_waking).trace(wake_lat,$wake_comm,next_c=
omm,$delta)' > events/sched/sched_switch/trigger
>=20
> The above will create a synthetic trace event that will save both the nam=
e
> of the waker and the wakee but only if the wakeup did not happen in a har=
d
> or soft interrupt context.
>=20
> The "common_comm" is used to save the task->comm at the time of the
> initial event and is passed via the "comm" variable to the second event,
> and that is saved as the "waker" field in the "wake_lat" synthetic event.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Very nice, looks good to me.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> ---
> =C2=A0kernel/trace/trace_events_hist.c | 51 ++++++++++++++++++++++++++---=
---
> =C2=A01 file changed, 42 insertions(+), 9 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index e85bc59c0421..58c9535f61df 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -114,6 +114,7 @@ enum hist_field_fn {
> =C2=A0	HIST_FIELD_FN_BUCKET,
> =C2=A0	HIST_FIELD_FN_TIMESTAMP,
> =C2=A0	HIST_FIELD_FN_CPU,
> +	HIST_FIELD_FN_COMM,
> =C2=A0	HIST_FIELD_FN_STRING,
> =C2=A0	HIST_FIELD_FN_DYNSTRING,
> =C2=A0	HIST_FIELD_FN_RELDYNSTRING,
> @@ -506,6 +507,7 @@ enum hist_field_flags {
> =C2=A0	HIST_FIELD_FL_CONST		=3D 1 << 18,
> =C2=A0	HIST_FIELD_FL_PERCENT		=3D 1 << 19,
> =C2=A0	HIST_FIELD_FL_GRAPH		=3D 1 << 20,
> +	HIST_FIELD_FL_COMM		=3D 1 << 21,
> =C2=A0};
> =C2=A0
> =C2=A0struct var_defs {
> @@ -885,6 +887,15 @@ static u64 hist_field_cpu(struct hist_field *hist_fi=
eld,
> =C2=A0	return cpu;
> =C2=A0}
> =C2=A0
> +static u64 hist_field_comm(struct hist_field *hist_field,
> +			=C2=A0 struct tracing_map_elt *elt,
> +			=C2=A0 struct trace_buffer *buffer,
> +			=C2=A0 struct ring_buffer_event *rbe,
> +			=C2=A0 void *event)
> +{
> +	return (u64)(unsigned long)current->comm;
> +}
> +
> =C2=A0/**
> =C2=A0 * check_field_for_var_ref - Check if a VAR_REF field references a =
variable
> =C2=A0 * @hist_field: The VAR_REF field to check
> @@ -1338,6 +1349,8 @@ static const char *hist_field_name(struct hist_fiel=
d *field,
> =C2=A0		field_name =3D hist_field_name(field->operands[0], ++level);
> =C2=A0	else if (field->flags & HIST_FIELD_FL_CPU)
> =C2=A0		field_name =3D "common_cpu";
> +	else if (field->flags & HIST_FIELD_FL_COMM)
> +		field_name =3D "common_comm";
> =C2=A0	else if (field->flags & HIST_FIELD_FL_EXPR ||
> =C2=A0		 field->flags & HIST_FIELD_FL_VAR_REF) {
> =C2=A0		if (field->system) {
> @@ -2015,6 +2028,13 @@ static struct hist_field *create_hist_field(struct=
 hist_trigger_data *hist_data,
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (flags & HIST_FIELD_FL_COMM) {
> +		hist_field->fn_num =3D HIST_FIELD_FN_COMM;
> +		hist_field->size =3D MAX_FILTER_STR_VAL;
> +		hist_field->type =3D "char[]";
> +		goto out;
> +	}
> +
> =C2=A0	if (WARN_ON_ONCE(!field))
> =C2=A0		goto out;
> =C2=A0
> @@ -2359,9 +2379,11 @@ parse_field(struct hist_trigger_data *hist_data, s=
truct trace_event_file *file,
> =C2=A0			hist_data->attrs->ts_in_usecs =3D true;
> =C2=A0	} else if (strcmp(field_name, "common_stacktrace") =3D=3D 0) {
> =C2=A0		*flags |=3D HIST_FIELD_FL_STACKTRACE;
> -	} else if (strcmp(field_name, "common_cpu") =3D=3D 0)
> +	} else if (strcmp(field_name, "common_cpu") =3D=3D 0) {
> =C2=A0		*flags |=3D HIST_FIELD_FL_CPU;
> -	else if (strcmp(field_name, "hitcount") =3D=3D 0)
> +	} else if (strcmp(field_name, "common_comm") =3D=3D 0) {
> +		*flags |=3D HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
> +	} else if (strcmp(field_name, "hitcount") =3D=3D 0)
> =C2=A0		*flags |=3D HIST_FIELD_FL_HITCOUNT;
> =C2=A0	else {
> =C2=A0		field =3D trace_find_event_field(file->event_call, field_name);
> @@ -2377,6 +2399,8 @@ parse_field(struct hist_trigger_data *hist_data, st=
ruct trace_event_file *file,
> =C2=A0				*flags |=3D HIST_FIELD_FL_CPU;
> =C2=A0			} else if (field && field->filter_type =3D=3D FILTER_STACKTRACE)=
 {
> =C2=A0				*flags |=3D HIST_FIELD_FL_STACKTRACE;
> +			} else if (field && field->filter_type =3D=3D FILTER_COMM) {
> +				*flags |=3D HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
> =C2=A0			} else {
> =C2=A0				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
> =C2=A0					 errpos(field_name));
> @@ -4327,6 +4351,8 @@ static u64 hist_fn_call(struct hist_field *hist_fie=
ld,
> =C2=A0		return hist_field_timestamp(hist_field, elt, buffer, rbe, event);
> =C2=A0	case HIST_FIELD_FN_CPU:
> =C2=A0		return hist_field_cpu(hist_field, elt, buffer, rbe, event);
> +	case HIST_FIELD_FN_COMM:
> +		return hist_field_comm(hist_field, elt, buffer, rbe, event);
> =C2=A0	case HIST_FIELD_FN_STRING:
> =C2=A0		return hist_field_string(hist_field, elt, buffer, rbe, event);
> =C2=A0	case HIST_FIELD_FN_DYNSTRING:
> @@ -5212,14 +5238,19 @@ static inline void add_to_key(char *compound_key,=
 void *key,
> =C2=A0	size_t size =3D key_field->size;
> =C2=A0
> =C2=A0	if (key_field->flags & HIST_FIELD_FL_STRING) {
> -		struct ftrace_event_field *field;
> =C2=A0
> -		field =3D key_field->field;
> -		if (field->filter_type =3D=3D FILTER_DYN_STRING ||
> -		=C2=A0=C2=A0=C2=A0 field->filter_type =3D=3D FILTER_RDYN_STRING)
> -			size =3D *(u32 *)(rec + field->offset) >> 16;
> -		else if (field->filter_type =3D=3D FILTER_STATIC_STRING)
> -			size =3D field->size;
> +		if (key_field->flags & HIST_FIELD_FL_COMM) {
> +			size =3D strlen((char *)key);
> +		} else {
> +			struct ftrace_event_field *field;
> +
> +			field =3D key_field->field;
> +			if (field->filter_type =3D=3D FILTER_DYN_STRING ||
> +			=C2=A0=C2=A0=C2=A0 field->filter_type =3D=3D FILTER_RDYN_STRING)
> +				size =3D *(u32 *)(rec + field->offset) >> 16;
> +			else if (field->filter_type =3D=3D FILTER_STATIC_STRING)
> +				size =3D field->size;
> +		}
> =C2=A0
> =C2=A0		/* ensure NULL-termination */
> =C2=A0		if (size > key_field->size - 1)
> @@ -6097,6 +6128,8 @@ static void hist_field_print(struct seq_file *m, st=
ruct hist_field *hist_field)
> =C2=A0
> =C2=A0	if (hist_field->flags & HIST_FIELD_FL_CPU)
> =C2=A0		seq_puts(m, "common_cpu");
> +	if (hist_field->flags & HIST_FIELD_FL_COMM)
> +		seq_puts(m, "common_comm");
> =C2=A0	else if (hist_field->flags & HIST_FIELD_FL_CONST)
> =C2=A0		seq_printf(m, "%llu", hist_field->constant);
> =C2=A0	else if (field_name) {

