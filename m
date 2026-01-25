Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6602F3624;
	Sun, 25 Jan 2026 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368880; cv=none; b=tvbyzQqO4VfNKN9bfxI0CaJqc+H6bHYP0o5l72mFWzrPygA4vQev52F/lkbIrZnXRL9WGt9qSWY/UGOyc7pGfD8j91mtPHTpqM6/L/rto+G50jzxHI8MjKr/2NzvNoLafpjNEA8JTSsC0Lwie9I7p/SB5BkSd5Z3wZWxrkHbadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368880; c=relaxed/simple;
	bh=e5QS3E5OwIC2D9ouJNvZy0U89jorWq/YIqa9qv83anE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3j7KBzl2bl40t9s7EI1rdDZOBhqkag00X3RfPHSu2Sjgjbrw5LzkmPD+mGCeKolCCHFOfG6umiTSJQ1K6lZHkfs+FOgprRbouoipBkUPfwgEjkdZ2blwLxKDnwFBhaVvqDUGcnZDBOJ1H5fQ0C1GRFgY7tWs7AMjm/hJIabdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXAsGwjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXAsGwjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A02BC4CEF1;
	Sun, 25 Jan 2026 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769368880;
	bh=e5QS3E5OwIC2D9ouJNvZy0U89jorWq/YIqa9qv83anE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CXAsGwjDfqTi0T0sDnL8eTcdMiXSz19EKCrSu+FxHy+Pnw836+S7A2kFzgI0HSLcE
	 2QqGcL2qVEJz+Mmn7xl/olhjGBq6ChQogKGjqp/qNxrUkK4zNCf6Bwl9GwByOu/27/
	 qEaj8UkWSkeVZUE7ExDHZLkSETpAjQMmw6qRVBW/egxqbCbQhwR5Wkj//IzCN6KY4I
	 5b1pIqRxQ+Yotr2MBnIXVyggTSblQhMHeb8Om9XCIYhK7Ute+Hr/RG56QWrZDCa6yn
	 1OGWXTFbRUMpJk+19f4D/y5+TZaAR7m28bEjx17O84kvD2Qi48lJ7Dj4NzTWJIkOai
	 94e/zWS95GbzA==
Message-ID: <b6239d2550f028216b7cfe5e0ced0f0fc324c3a1.camel@kernel.org>
Subject: Re: [PATCH] tracing: Have hist_debug show what function a field uses
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Sun, 25 Jan 2026 13:21:19 -0600
In-Reply-To: <20260122203822.58df4d80@gandalf.local.home>
References: <20260122203822.58df4d80@gandalf.local.home>
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

On Thu, 2026-01-22 at 20:38 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When CONFIG_HIST_TRIGGERS_DEBUG is enabled, each trace event has a
> "hist_debug" file that explains the histogram internal data. This is very
> useful for debugging histograms.
>=20
> One bit of data that was missing from this file was what function a
> histogram field uses to process its data. The hist_field structure now ha=
s
> a fn_num that is used by a switch statement in hist_fn_call() to call a
> function directly (to avoid spectre mitigations).
>=20
> Instead of displaying that number, create a string array that maps to the
> histogram function enums so that the function for a field may be
> displayed:
>=20
> =C2=A0~# cat /sys/kernel/tracing/events/sched/sched_switch/hist_debug
> [..]
> hist_data: 0000000043d62762
>=20
> =C2=A0 n_vals: 2
> =C2=A0 n_keys: 1
> =C2=A0 n_fields: 3
>=20
> =C2=A0 val fields:
>=20
> =C2=A0=C2=A0=C2=A0 hist_data->fields[0]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VAL: HIST_FIELD_FL_HITCOUNT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: u64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size: 8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_signed: 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 function: hist_field_counter()
>=20
> =C2=A0=C2=A0=C2=A0 hist_data->fields[1]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HIST_FIELD_FL_VAR
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var.name: __arg_3921_2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var.idx (into tracing_map_elt.vars[]): 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unsigned long[]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size: 128
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_signed: 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 function: hist_field_nop()
>=20
> =C2=A0 key fields:
>=20
> =C2=A0=C2=A0=C2=A0 hist_data->fields[2]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HIST_FIELD_FL_KEY
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ftrace_event_field name: prev_pid
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: pid_t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size: 8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_signed: 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 function: hist_field_s32()
>=20
> The "function:" field above is added.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Nice and useful addition, thanks!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>

Tom

> ---
> =C2=A0kernel/trace/trace_events_hist.c | 75 +++++++++++++++++++----------=
---
> =C2=A01 file changed, 44 insertions(+), 31 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 4a7f945e368d..24441b30a1a4 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -105,38 +105,44 @@ enum field_op_id {
> =C2=A0	FIELD_OP_MULT,
> =C2=A0};
> =C2=A0
> +#define FIELD_FUNCS					\
> +	C(NOP,			"nop"),			\
> +	C(VAR_REF,		"var_ref"),		\
> +	C(COUNTER,		"counter"),		\
> +	C(CONST,		"const"),		\
> +	C(LOG2,			"log2"),		\
> +	C(BUCKET,		"bucket"),		\
> +	C(TIMESTAMP,		"timestamp"),		\
> +	C(CPU,			"cpu"),			\
> +	C(COMM,			"comm"),		\
> +	C(STRING,		"string"),		\
> +	C(DYNSTRING,		"dynstring"),		\
> +	C(RELDYNSTRING,		"reldynstring"),	\
> +	C(PSTRING,		"pstring"),		\
> +	C(S64,			"s64"),			\
> +	C(U64,			"u64"),			\
> +	C(S32,			"s32"),			\
> +	C(U32,			"u32"),			\
> +	C(S16,			"s16"),			\
> +	C(U16,			"u16"),			\
> +	C(S8,			"s8"),			\
> +	C(U8,			"u8"),			\
> +	C(UMINUS,		"uminus"),		\
> +	C(MINUS,		"minus"),		\
> +	C(PLUS,			"plus"),		\
> +	C(DIV,			"div"),			\
> +	C(MULT,			"mult"),		\
> +	C(DIV_POWER2,		"div_power2"),		\
> +	C(DIV_NOT_POWER2,	"div_not_power2"),	\
> +	C(DIV_MULT_SHIFT,	"div_mult_shift"),	\
> +	C(EXECNAME,		"execname"),		\
> +	C(STACK,		"stack"),
> +
> +#undef C
> +#define C(a, b)		HIST_FIELD_FN_##a
> +
> =C2=A0enum hist_field_fn {
> -	HIST_FIELD_FN_NOP,
> -	HIST_FIELD_FN_VAR_REF,
> -	HIST_FIELD_FN_COUNTER,
> -	HIST_FIELD_FN_CONST,
> -	HIST_FIELD_FN_LOG2,
> -	HIST_FIELD_FN_BUCKET,
> -	HIST_FIELD_FN_TIMESTAMP,
> -	HIST_FIELD_FN_CPU,
> -	HIST_FIELD_FN_COMM,
> -	HIST_FIELD_FN_STRING,
> -	HIST_FIELD_FN_DYNSTRING,
> -	HIST_FIELD_FN_RELDYNSTRING,
> -	HIST_FIELD_FN_PSTRING,
> -	HIST_FIELD_FN_S64,
> -	HIST_FIELD_FN_U64,
> -	HIST_FIELD_FN_S32,
> -	HIST_FIELD_FN_U32,
> -	HIST_FIELD_FN_S16,
> -	HIST_FIELD_FN_U16,
> -	HIST_FIELD_FN_S8,
> -	HIST_FIELD_FN_U8,
> -	HIST_FIELD_FN_UMINUS,
> -	HIST_FIELD_FN_MINUS,
> -	HIST_FIELD_FN_PLUS,
> -	HIST_FIELD_FN_DIV,
> -	HIST_FIELD_FN_MULT,
> -	HIST_FIELD_FN_DIV_POWER2,
> -	HIST_FIELD_FN_DIV_NOT_POWER2,
> -	HIST_FIELD_FN_DIV_MULT_SHIFT,
> -	HIST_FIELD_FN_EXECNAME,
> -	HIST_FIELD_FN_STACK,
> +	FIELD_FUNCS
> =C2=A0};
> =C2=A0
> =C2=A0/*
> @@ -5845,6 +5851,12 @@ const struct file_operations event_hist_fops =3D {
> =C2=A0};
> =C2=A0
> =C2=A0#ifdef CONFIG_HIST_TRIGGERS_DEBUG
> +
> +#undef C
> +#define C(a, b)		b
> +
> +static const char * const field_funcs[] =3D { FIELD_FUNCS };
> +
> =C2=A0static void hist_field_debug_show_flags(struct seq_file *m,
> =C2=A0					unsigned long flags)
> =C2=A0{
> @@ -5909,6 +5921,7 @@ static int hist_field_debug_show(struct seq_file *m=
,
> =C2=A0	seq_printf(m, "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: %s\n", field->=
type);
> =C2=A0	seq_printf(m, "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size: %u\n", field->=
size);
> =C2=A0	seq_printf(m, "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_signed: %u\n", fi=
eld->is_signed);
> +	seq_printf(m, "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 function: hist_field_%s()=
\n", field_funcs[field->fn_num]);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}

