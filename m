Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5B3816E8;
	Sun,  8 Feb 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770590962; cv=none; b=GmrvTWhW/CVxvotH+nDpZUxThxZ8Wift3JPjq5TO7jGwAlxRF4HZViDaaFD4dybxfCGtn0hDECjG9np93SlyfBaBfgexHtJo1aCYJNaF5qDn16osX9VXvGqC70y6rlZIN8FeDkzpKr5w0Ym+AVrWr6WwljLeOb06+a99/ZxYWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770590962; c=relaxed/simple;
	bh=SCltQOQZT05GDstGroDs2sC/CI4Xa0Jt5amY/1lkcf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lw9VCnDBpsHNwnQ+Vb9tBVCgP0PR825s+VYjZ9CFf8/hK15+41ESRcj2JFF0NpM+nmogOIuOs1mw0BKJMIW9gR0pioKZMQnZF59COBV837kRzk3lD/CShzcCn/qSOGjOABsyuRsho79NWh4NgOPUfb/aUhkVIL7fSqeD1JctShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoPb+1/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoPb+1/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D268C4CEF7;
	Sun,  8 Feb 2026 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770590962;
	bh=SCltQOQZT05GDstGroDs2sC/CI4Xa0Jt5amY/1lkcf8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XoPb+1/TkfOYtL8LzwQa4jE+/WFwJ1kHKwjtGGicIV3V3Yo+LO05wMW6zZqaI9kmr
	 7ivWmIgBJDMsQJxW8e2QAZP+UpSorFg+kT5zkeCxalbRFsmqviJqXAfq3vS6MAmYIL
	 QRUEE0dD1Tk47QrbTXopU26EGLzJDQtflXm25moaedw/4TNUnKk3oGWl1tu6uR84ho
	 0YS6uWai75saox5eSWjETglpl8vF5QZgAbSc9iAFDtdnEx1svmHYLR0tVXvB3AT9Vq
	 HqinrDHVa4fRuyQa0cEXtlqJiX2MiyJG0Wxxm7Mdp9q/fGKId6cfuMjPv/EuKArYBR
	 u07XOPErwISvQ==
Message-ID: <8c8a7f4a29a837813ded64c93cf689b9e5b5a56d.camel@kernel.org>
Subject: Re: [PATCH] tracing: Have all triggers expect a file parameter
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Sun, 08 Feb 2026 16:49:21 -0600
In-Reply-To: <20260206101351.609d8906@gandalf.local.home>
References: <20260206101351.609d8906@gandalf.local.home>
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

On Fri, 2026-02-06 at 10:13 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When the triggers were first created, they may not have had a file
> parameter passed to them and things needed to be done generically.
>=20
> But today, all triggers have a file parameter passed to them. Remove the
> generic code and add a "if (WARN_ON_ONCE(!file))" to each trigger.
>=20

Makes sense.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> =C2=A0kernel/trace/trace_events_trigger.c | 62 +++++++++++---------------=
---
> =C2=A01 file changed, 24 insertions(+), 38 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_eve=
nts_trigger.c
> index 06b75bcfc7b8..7fa26327c9c7 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1347,18 +1347,13 @@ traceon_trigger(struct event_trigger_data *data,
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> -	if (file) {
> -		if (tracer_tracing_is_on(file->tr))
> -			return;
> -
> -		tracer_tracing_on(file->tr);
> +	if (WARN_ON_ONCE(!file))
> =C2=A0		return;
> -	}
> =C2=A0
> -	if (tracing_is_on())
> +	if (tracer_tracing_is_on(file->tr))
> =C2=A0		return;
> =C2=A0
> -	tracing_on();
> +	tracer_tracing_on(file->tr);
> =C2=A0}
> =C2=A0
> =C2=A0static bool
> @@ -1368,13 +1363,11 @@ traceon_count_func(struct event_trigger_data *dat=
a,
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> -	if (file) {
> -		if (tracer_tracing_is_on(file->tr))
> -			return false;
> -	} else {
> -		if (tracing_is_on())
> -			return false;
> -	}
> +	if (WARN_ON_ONCE(!file))
> +		return false;
> +
> +	if (tracer_tracing_is_on(file->tr))
> +		return false;
> =C2=A0
> =C2=A0	if (!data->count)
> =C2=A0		return false;
> @@ -1392,18 +1385,13 @@ traceoff_trigger(struct event_trigger_data *data,
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> -	if (file) {
> -		if (!tracer_tracing_is_on(file->tr))
> -			return;
> -
> -		tracer_tracing_off(file->tr);
> +	if (WARN_ON_ONCE(!file))
> =C2=A0		return;
> -	}
> =C2=A0
> -	if (!tracing_is_on())
> +	if (!tracer_tracing_is_on(file->tr))
> =C2=A0		return;
> =C2=A0
> -	tracing_off();
> +	tracer_tracing_off(file->tr);
> =C2=A0}
> =C2=A0
> =C2=A0static bool
> @@ -1413,13 +1401,11 @@ traceoff_count_func(struct event_trigger_data *da=
ta,
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> -	if (file) {
> -		if (!tracer_tracing_is_on(file->tr))
> -			return false;
> -	} else {
> -		if (!tracing_is_on())
> -			return false;
> -	}
> +	if (WARN_ON_ONCE(!file))
> +		return false;
> +
> +	if (!tracer_tracing_is_on(file->tr))
> +		return false;
> =C2=A0
> =C2=A0	if (!data->count)
> =C2=A0		return false;
> @@ -1481,10 +1467,10 @@ snapshot_trigger(struct event_trigger_data *data,
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> -	if (file)
> -		tracing_snapshot_instance(file->tr);
> -	else
> -		tracing_snapshot();
> +	if (WARN_ON_ONCE(!file))
> +		return;
> +
> +	tracing_snapshot_instance(file->tr);
> =C2=A0}
> =C2=A0
> =C2=A0static int
> @@ -1570,10 +1556,10 @@ stacktrace_trigger(struct event_trigger_data *dat=
a,
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> -	if (file)
> -		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
> -	else
> -		trace_dump_stack(STACK_SKIP);
> +	if (WARN_ON_ONCE(!file))
> +		return;
> +
> +	__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
> =C2=A0}
> =C2=A0
> =C2=A0static int

