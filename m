Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F3158DA3;
	Fri, 22 Nov 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304224; cv=none; b=oaudYRteW9lC26hwk0pRUow834Jd0j4cZtnpc/JKbophs+l3yxn2xwuzInBMDei+cNXHBFIuUtmO7kgLMK5pZ7/0sIp689OP5jSXPkKhTuxq6tuz9qYrdddE3VkcMgBZezxfuqTuAm3E23nk8bWOeCpYvffNCSkWoAqGN/Px5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304224; c=relaxed/simple;
	bh=2aZdsr64gCgbmX8G1clSDXM0XanXQOIOxyXY62g7TE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gr5amddzzxpVcM3RQ0Eo8kyGv6HSNorQsWxep4aZnjImPZgGH/LK0nZ/CHzmQey48QVvTbCMtLc30GGVXCI69BfG+cVB1c5eie2lxj7k1qxqMRVB+2l9CgTZZjCJaIb5fSKWDMUdmAG38/tRPopWq6EUQGVfLNeq4B01SbV30vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E34C4CECE;
	Fri, 22 Nov 2024 19:37:02 +0000 (UTC)
Date: Fri, 22 Nov 2024 14:37:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241122143742.038c77fa@gandalf.local.home>
In-Reply-To: <20241122173201.tsqK0eeD@linutronix.de>
References: <20241122173201.tsqK0eeD@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 18:32:01 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
> part of trace flags and expose it in the need_resched field.
>=20
> Record and expose NEED_RESCHED_LAZY.
>=20
> [bigeasy: Commit description, documentation bits.]
>=20
> Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2=E2=80=A6v3:
>   - Use 0x02 for TRACE_FLAG_NEED_RESCHED_LAZY which is the freshly
>     created gap.
>=20
>  Documentation/trace/ftrace.rst |  4 ++++
>  include/linux/trace_events.h   |  1 +
>  kernel/trace/trace.c           |  2 ++
>  kernel/trace/trace_output.c    | 14 +++++++++++++-
>  4 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.=
rst
> index 74d5bd801b1a8..16892b844108c 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1033,9 +1033,13 @@ explains which is which.
>    irqs-off: 'd' interrupts are disabled. '.' otherwise.
> =20
>    need-resched:
> +	- 'B' all, TIF_NEED_RESCHED, PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY =
is set,
>  	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
>  	- 'n' only TIF_NEED_RESCHED is set,
>  	- 'p' only PREEMPT_NEED_RESCHED is set,

> +	- 'L' borg PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
> +	- 'b' borg TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set,

   Is resistance futile?

I can switch it over to "both" if that's what you meant.

-- Steve

> +	- 'l' only TIF_RESCHED_LAZY is set
>  	- '.' otherwise.
> =20
>    hardirq/softirq:
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 016b29a56c875..2a5df5b62cfc7 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -184,6 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int ir=
qs_status);
> =20
>  enum trace_flag_type {
>  	TRACE_FLAG_IRQS_OFF		=3D 0x01,
> +	TRACE_FLAG_NEED_RESCHED_LAZY	=3D 0x02,
>  	TRACE_FLAG_NEED_RESCHED		=3D 0x04,
>  	TRACE_FLAG_HARDIRQ		=3D 0x08,
>  	TRACE_FLAG_SOFTIRQ		=3D 0x10,
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 3ef047ed97055..be62f0ea1814d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2552,6 +2552,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int =
irqs_status)
>  		trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
>  	if (test_preempt_need_resched())
>  		trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_R=
ESCHED_LAZY))
> +		trace_flags |=3D TRACE_FLAG_NEED_RESCHED_LAZY;
>  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
>  		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
>  }
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index e08aee34ef63d..da748b7cbc4d5 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -462,17 +462,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct=
 trace_entry *entry)
>  		bh_off ? 'b' :
>  		'.';
> =20
> -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
> +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCH=
ED_LAZY |
>  				TRACE_FLAG_PREEMPT_RESCHED)) {
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLA=
G_PREEMPT_RESCHED:
> +		need_resched =3D 'B';
> +		break;
>  	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
>  		need_resched =3D 'N';
>  		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched =3D 'L';
> +		break;
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched =3D 'b';
> +		break;
>  	case TRACE_FLAG_NEED_RESCHED:
>  		need_resched =3D 'n';
>  		break;
>  	case TRACE_FLAG_PREEMPT_RESCHED:
>  		need_resched =3D 'p';
>  		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched =3D 'l';
> +		break;
>  	default:
>  		need_resched =3D '.';
>  		break;

