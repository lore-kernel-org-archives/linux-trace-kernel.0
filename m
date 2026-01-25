Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C32EFD9E;
	Sun, 25 Jan 2026 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369067; cv=none; b=JpO/VnnYKTK0zmrk73jrsFTsWLPTgTSEkcV45/G/hC96FhEgPPX1dmdDGa9GXEKmm+JAj7G3QLeoeRg5op0PBMDjInaLLbY9i8AvGyOjN3v3TTJiuoJg3uUIQ/gWmbvjhc3DA/nDraHT6A+Pbd96IB5mkmCdyXLvRJ7qp6DeaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369067; c=relaxed/simple;
	bh=iz+nxEKGMeBJ0zBVyNpBnZ9SXyhaGmjrcuQ/IfxBFCY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlKQ6KWxxDpIeowuP67WhQgKoiqhp3ydQfb3bfqQEaEXSBz/JaISij3YESpDtmixRUuS16Ebb/bZa+EyLhtnN65QjDQVh1MSiDHLm6oe/6OzJ8wkrl7zwGcBhsyYrNnqArJMsOy8RwMCstlOIkmtdSATVSbJFzQQ3gaXoIpdGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhp4p8mZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhp4p8mZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817B8C4CEF1;
	Sun, 25 Jan 2026 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369067;
	bh=iz+nxEKGMeBJ0zBVyNpBnZ9SXyhaGmjrcuQ/IfxBFCY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Yhp4p8mZKE8r38TVc/Dij8YGRlh8Py8m7ydE/6yo2m/R08FOVoFanokRYGCFO7SIA
	 +bn2K2CC91t2vBdH3ttLRElK/J8uCB6HLcFCadtoqCrWolC+beMkCvQK6E9mv4j6qj
	 CVv2XwBxFnQ3xsBCJbL17DW+91tzTfQ2cTfRl1t29CuS7moPB9ql4wYaUJkwgv5kQI
	 HzTI+VbEYYT571uNKLjRfY1x+2XSthoylInBMQwzqAx+dGpMErnS083ARPsJ0Xj7Qd
	 VwDIHqYc0KGCTwMIEw/NLz5EwanAEmcgA8DzWezy4TSzkWHgD/pV15j2eAr7MgYDBB
	 owoKXNPPXlFPg==
Message-ID: <8d8d91b883a8f0ed002bfec51f31f82ccbc8cd6a.camel@kernel.org>
Subject: Re: [PATCH] tracing: Remove notrace from
 trace_event_raw_event_synth()
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Sun, 25 Jan 2026 13:24:25 -0600
In-Reply-To: <20260122204526.068a98c9@gandalf.local.home>
References: <20260122204526.068a98c9@gandalf.local.home>
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

On Thu, 2026-01-22 at 20:45 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When debugging the synthetic events, being able to function trace its
> functions is very useful (now that CONFIG_FUNCTION_SELF_TRACING is
> available). For some reason trace_event_raw_event_synth() was marked as
> "notrace", which was totally unnecessary as all of the tracing directory
> had function tracing disabled until the recent FUNCTION_SELF_TRACING was
> added.
>=20
> Remove the notrace annotation from trace_event_raw_event_synth() as
> there's no reason to not trace it when tracing synthetic event functions.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> ---
> =C2=A0kernel/trace/trace_events_synth.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_event=
s_synth.c
> index 4554c458b78c..79a506fc2856 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -493,9 +493,9 @@ static unsigned int trace_stack(struct synth_trace_ev=
ent *entry,
> =C2=A0	return len;
> =C2=A0}
> =C2=A0
> -static notrace void trace_event_raw_event_synth(void *__data,
> -						u64 *var_ref_vals,
> -						unsigned int *var_ref_idx)
> +static void trace_event_raw_event_synth(void *__data,
> +					u64 *var_ref_vals,
> +					unsigned int *var_ref_idx)
> =C2=A0{
> =C2=A0	unsigned int i, n_u64, val_idx, len, data_size =3D 0;
> =C2=A0	struct trace_event_file *trace_file =3D __data;

