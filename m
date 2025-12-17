Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269624A064
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997919; cv=pass; b=X++dTpjDNMUyKR4fp25gy0ZCqtAWvHf8lP5B2U2GNacYg3bHkcIAEoY/n22Plas4lquojq295HpkD3GqVTnfwDyzrKwgWUDx8UsfjtmM+61+D0kU2F8K8DQVH05Zqrmqfddsq3NOnnjY2kQCRleoTdJV4Y7OeUCozeFRjHJ6rZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997919; c=relaxed/simple;
	bh=x0HG1RLpaHzUIdPrqFkyQKQhOhB8umXpzSD5Q0haZRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S494ZktcJJ38P0MMV5t/pyhvxCFaiISEkMKI4Xfmi2jEMhnY07OboTbrk/COtQZDVzC7wehNaDqCvrMMxyvLNMlwuD1X2yTrSRBx2bpBzC4OeE9pL7Ea4tDWmMsgDiRq/ksK7shL59ENZK6TVY6tRQr9U7sCEblB30uvQzcrjbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJ6+cNnE; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJ6+cNnE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29e0753e5d8so17805ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 10:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765997918; cv=none;
        d=google.com; s=arc-20240605;
        b=CbgFutzRljrUPHlCwPYyPuKHDCnzD+tXEtamX2oJJh9YEFBVziRIXhvIZyh4Az3PnD
         PVdn58yurglLfrBEaryn6TaUeWySjXuEBLvovjGEnWx2eWrPJPSrxD7HUauCqARjWZnc
         /XSyS8qXJKHyNJ4elbOcYr9LbsF04FMeZwLTJPD4yyFVFvBurzBwlRAAyj8OPmTjDAmJ
         +00BP/6iUxVxZNqrLuh+MPuTKrX5uJ1lQnDYjeDzCFrBNdJ8lQYavXZBLZ2PxlZmsCzP
         +oQ0AAS+5Y1LwaF/LHOhwrNvqRbs599flSlnNkREDR+R2cCpJzsfyckwA86XUMNVTzJU
         /pEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3AgQG66lFW3ai9uoz7yIj0PCplFRblmrJqzNyD7YoU0=;
        fh=vXza8S03ccAmVPKb5IiHcLe+DUgx2qluzqDvh3cTbJ4=;
        b=CHvjgc25FkfmSTet+bsU5eK2sRNXPyEkIXQQz9CUym5vFUuIZKljyCp+UkEk7PweFI
         AcMcQgDRN+FxCSkU/mjt9qOwdCsZWDDvLB+S91pzD81Q3vIg30fKDm2TQaAHJw5ODv/T
         jnpsdm5eaf45ulx8+mZ1ne3gWKtXNr2ToFqUDnRMIQRhwitaS3sZ755/FdOI8cU6lUhP
         6Dc61vmwxEMNaWLhTO/eR80SeLSf5Xl70NLYsRyTSAStblbsLPLQqO7jx3Yupmm4TskG
         QKzYSnUGn4ZPBetN4JAltf66V2OyIaw2YqNJ+tjkZaebR+EO21x/dwoJ/RJzzjeETVZF
         jbbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765997918; x=1766602718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AgQG66lFW3ai9uoz7yIj0PCplFRblmrJqzNyD7YoU0=;
        b=pJ6+cNnEFJg0JEURMI+npjKL0UFPK7uFjNZna5BvHABV0Ga0I0lO8dot7ybN9cQd2d
         meSpGPrqMWT4dzMm4mFj/oqgthGkF7pXxEK7Q2Rr5ih4+uQM+Mg9DBaIBUI65Q/eKBes
         IKwtS8EWF6vmEYrpgKY0HEZFCHm3T0zqcITvcrFATMKkh4gzjqPPICpVAkEA+tjrF28M
         FPg0xZ6aZFyUXDg5GGAVMj5G/wKz13cd8tSLSmAnUEpFe3rOyNjqs5PTmxzYriyvXXyt
         OsJ07ram6EaHHyJe6IXN/+U5WwRO9EDMRxpK96KF6eAxkGmDQvuOoDTrK2McKwhs9fsh
         DP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765997918; x=1766602718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AgQG66lFW3ai9uoz7yIj0PCplFRblmrJqzNyD7YoU0=;
        b=HPUMuLQ6t2J56Ip6A+V1tryX8r+DBj5ALxTuLU6i+HOOLttX8C1LW5gcnXd6flsLkd
         WhAqPeGZrRv+Q7IJbbumIwPfHjQoGOkFb6wozSb9/YdwZKAvhY1uN+WNhJ/I3laj6ytu
         BwpID/mgw+BeC3/1LO5aPOFX0gY768Xtss1Pg3WwOgV3jXnKc0l4Ika3WntoNUHrUzvv
         4ysSWbeeOFmxe9B2GpSTI0Vfl3IFZrzAjEJ1ryXR1GTeeLxoI5boXqxe6B4Ot2PUxpI9
         R98pkhq95Cg+4QGXdTRtqStU9qpawABJBzemrazpXifsXFaKRucYHOmIdFbElEClXo28
         74wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj11MLMuSOdWAQ8zjjHYx8h3i2CsKty5+el5XndWvylaAj7rpaEOtU9XJO4usOLuvLJB97yLPI2BVllJ0bMlT80VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzndjsrp6r4rniJmYP+wWF1Yid9ihBulSZK6jfn2F69YZFhh+yl
	z+b09lvycUSaUIi9UHITeys1eY3VgTIHFtARDVEcBwY4n5zf+HZXOEBWtdG+A4tTweCYZpXHErk
	33+dRW7YOBpa/uKU4pWdH1WyJEaCPn70QGz9e7DvE
X-Gm-Gg: AY/fxX4clMWDRLQmYSJmMN+q87IjfgJMnEfPDsoBpQvuYAtub88ZOYAuvYRKup9cTtw
	fTrUzo4Q7PX6tFCNKkWsexwN9/Jzb+7o+eqsyhIytyMZaJouLwzjDGWP1dixKAjHu+2ZhiR/neQ
	2EPTNQtqDrffFn1ZimWQtOkuQ7ZwZEKUMiqPP5LWXKz4nhPQFJEyMCaSd8SjyJjZNMsOVfCF6xa
	fv9lrsRScy5QwCFKODmUofPVL4fV3xMYv0luQXT7F7FdUZUvHink/1+TDmYl5TqpY8ENqAe
X-Google-Smtp-Source: AGHT+IE1Q59PbQh32uPJPS8vkvGnAoXu1Avo7FDRaPAeQ5OyOMhcyr7bWRungLLLzROipZ1ZDpk3HHn5EIdXiBND7gY=
X-Received: by 2002:a17:903:ac5:b0:295:1351:f63e with SMTP id
 d9443c01a7336-2a2d0667076mr161035ad.10.1765997917156; Wed, 17 Dec 2025
 10:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217113920.50b56246@gandalf.local.home>
In-Reply-To: <20251217113920.50b56246@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Dec 2025 10:58:25 -0800
X-Gm-Features: AQt7F2oOtOBtlggSGIpFGULyw7myUxxHJ1mtmHxLQetW_E2pL6fYGwKJkXjuRJ8
Message-ID: <CAP-5=fUFZaDTEDytOVW_R-v+fys11ojuoCbs9c2UQqvxDYUxGg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Allow perf to read synthetic events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:37=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Currently, perf can not enable synthetic events. When it does, it either
> causes a warning in the kernel or errors with "no such device".
>
> Add the necessary code to allow perf to also attach to synthetic events.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This is great! Any chance of an example of using it? I'd like to add a test=
.

Thanks,
Ian

> ---
>  kernel/trace/trace_events_synth.c | 121 +++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_event=
s_synth.c
> index 4554c458b78c..026e06f28958 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -493,28 +493,19 @@ static unsigned int trace_stack(struct synth_trace_=
event *entry,
>         return len;
>  }
>
> -static notrace void trace_event_raw_event_synth(void *__data,
> -                                               u64 *var_ref_vals,
> -                                               unsigned int *var_ref_idx=
)
> +static __always_inline int get_field_size(struct synth_event *event,
> +                                         u64 *var_ref_vals,
> +                                         unsigned int *var_ref_idx)
>  {
> -       unsigned int i, n_u64, val_idx, len, data_size =3D 0;
> -       struct trace_event_file *trace_file =3D __data;
> -       struct synth_trace_event *entry;
> -       struct trace_event_buffer fbuffer;
> -       struct trace_buffer *buffer;
> -       struct synth_event *event;
> -       int fields_size =3D 0;
> -
> -       event =3D trace_file->event_call->data;
> -
> -       if (trace_trigger_soft_disabled(trace_file))
> -               return;
> +       int fields_size;
>
>         fields_size =3D event->n_u64 * sizeof(u64);
>
> -       for (i =3D 0; i < event->n_dynamic_fields; i++) {
> +       for (int i =3D 0; i < event->n_dynamic_fields; i++) {
>                 unsigned int field_pos =3D event->dynamic_fields[i]->fiel=
d_pos;
>                 char *str_val;
> +               int val_idx;
> +               int len;
>
>                 val_idx =3D var_ref_idx[field_pos];
>                 str_val =3D (char *)(long)var_ref_vals[val_idx];
> @@ -529,18 +520,18 @@ static notrace void trace_event_raw_event_synth(voi=
d *__data,
>
>                 fields_size +=3D len;
>         }
> +       return fields_size;
> +}
>
> -       /*
> -        * Avoid ring buffer recursion detection, as this event
> -        * is being performed within another event.
> -        */
> -       buffer =3D trace_file->tr->array_buffer.buffer;
> -       guard(ring_buffer_nest)(buffer);
> -
> -       entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
> -                                          sizeof(*entry) + fields_size);
> -       if (!entry)
> -               return;
> +static __always_inline void write_synth_entry(struct synth_event *event,
> +                                             struct synth_trace_event *e=
ntry,
> +                                             u64 *var_ref_vals,
> +                                             unsigned int *var_ref_idx)
> +{
> +       int data_size =3D 0;
> +       int i, n_u64;
> +       int val_idx;
> +       int len;
>
>         for (i =3D 0, n_u64 =3D 0; i < event->n_fields; i++) {
>                 val_idx =3D var_ref_idx[i];
> @@ -581,10 +572,83 @@ static notrace void trace_event_raw_event_synth(voi=
d *__data,
>                         n_u64++;
>                 }
>         }
> +}
> +
> +static notrace void trace_event_raw_event_synth(void *__data,
> +                                               u64 *var_ref_vals,
> +                                               unsigned int *var_ref_idx=
)
> +{
> +       struct trace_event_file *trace_file =3D __data;
> +       struct synth_trace_event *entry;
> +       struct trace_event_buffer fbuffer;
> +       struct trace_buffer *buffer;
> +       struct synth_event *event;
> +       int fields_size;
> +
> +       event =3D trace_file->event_call->data;
> +
> +       if (trace_trigger_soft_disabled(trace_file))
> +               return;
> +
> +       fields_size =3D get_field_size(event, var_ref_vals, var_ref_idx);
> +
> +       /*
> +        * Avoid ring buffer recursion detection, as this event
> +        * is being performed within another event.
> +        */
> +       buffer =3D trace_file->tr->array_buffer.buffer;
> +       guard(ring_buffer_nest)(buffer);
> +
> +       entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
> +                                          sizeof(*entry) + fields_size);
> +       if (!entry)
> +               return;
> +
> +       write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
>
>         trace_event_buffer_commit(&fbuffer);
>  }
>
> +#ifdef CONFIG_PERF_EVENTS
> +static notrace void perf_event_raw_event_synth(void *__data,
> +                                              u64 *var_ref_vals,
> +                                              unsigned int *var_ref_idx)
> +{
> +       struct trace_event_call *call =3D __data;
> +       struct synth_trace_event *entry;
> +       struct hlist_head *perf_head;
> +       struct synth_event *event;
> +       struct pt_regs *regs;
> +       int fields_size;
> +       size_t size;
> +       int context;
> +
> +       event =3D call->data;
> +
> +       perf_head =3D this_cpu_ptr(call->perf_events);
> +
> +       if (!perf_head || hlist_empty(perf_head))
> +               return;
> +
> +       fields_size =3D get_field_size(event, var_ref_vals, var_ref_idx);
> +
> +       size =3D ALIGN(sizeof(*entry) + fields_size, 8);
> +
> +       entry =3D perf_trace_buf_alloc(size, &regs, &context);
> +
> +       if (unlikely(!entry))
> +               return;
> +
> +       write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
> +
> +       perf_fetch_caller_regs(regs);
> +
> +       perf_trace_buf_submit(entry, size, context,
> +                             call->event.type, 1, regs,
> +                             perf_head, NULL);
> +}
> +#endif
> +
>  static void free_synth_event_print_fmt(struct trace_event_call *call)
>  {
>         if (call) {
> @@ -911,6 +975,9 @@ static int register_synth_event(struct synth_event *e=
vent)
>         call->flags =3D TRACE_EVENT_FL_TRACEPOINT;
>         call->class->reg =3D synth_event_reg;
>         call->class->probe =3D trace_event_raw_event_synth;
> +#ifdef CONFIG_PERF_EVENTS
> +       call->class->perf_probe =3D perf_event_raw_event_synth;
> +#endif
>         call->data =3D event;
>         call->tp =3D event->tp;
>
> --
> 2.51.0
>
