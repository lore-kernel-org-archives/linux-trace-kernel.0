Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117C3EB10F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814497; cv=none; b=uXTfdfjG9CZ7B7omSpfkaOZiiV9ks09tqVGISGEe18Ua+3WD88bb7Gq6+xlM3a7UCmMfvbvU7PBTziDtyEQWbYPi328nxzQ4aCNgHZ0e8cMaLhPgWUpjDYIdlDwmywu3b13sqzqQF0wbNqjX++VaPOhmDje03LTogTpsnRwCKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814497; c=relaxed/simple;
	bh=CPD2cZcP8ELgG1d/dRepi4aWPdeNOB8Nlw/R9JrErcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbZEh7PZCaVtqOPSF424r4HB2rs0UMdcQjn2G1WWjCJiy4oJyDJNru7u00xV68AsH1m7MHyfuBbXQD0z9aBQGWp2LnXhL4Rmpo/eJ7a+i6Iacw9aT4v8A44HTs4R6WcgaIj30IRk7yAtY1rmwg2jH5SfK8d3CPxSXjzQ1jbAbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL0qIEa+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL0qIEa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782814494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAsrVZvQquixtBabCzpS64y50o+xH9oROZmfJ7/f9J0=;
	b=BL0qIEa+CW1KtG74NnQ7neBKhw+VSpLIl10kfYWrxkGts2RAOv+9l+UgT0DizBXM82BNn8
	pAF4kk6aHf+DnUATzJ2W5T1ennwRDwYL+VJAVEzViBAsZK1AqAXZveG4tOqlZZPC3Wic7N
	LddqWQLthjCT1kWtDXfNjzIhAKnGtmI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-JvjpdDc0O--1GJ3Ep8H_yA-1; Tue, 30 Jun 2026 06:14:53 -0400
X-MC-Unique: JvjpdDc0O--1GJ3Ep8H_yA-1
X-Mimecast-MFC-AGG-ID: JvjpdDc0O--1GJ3Ep8H_yA_1782814492
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c128c8c345eso87692866b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 03:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814492; x=1783419292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAsrVZvQquixtBabCzpS64y50o+xH9oROZmfJ7/f9J0=;
        b=dWXoKiPFP2Ked79AL0Q2CmS8M/PSDm7YY7FRCfx2arm7cExh8g5X/QizTxQPHIh+rC
         tWg1B/6fFmPpAf63yt5yOoufp/E26yOuz2OMZ7lnG2s6jH+GjlhBT7IgX3kGW+RanuuL
         Mm/hAPsfzPHKtGjwqNUiS9wm/OZIiwQ1hLUXx4j8Qivn/ZJFzoijloqLTKCOa9AxUzY4
         aVRIFAAarWRJHF6AuvczoUSbHEqYXM7/xmJ/7Vv2GIT95fR6696O1yC3EhAYaeI0ACwC
         wcdQpON4h/dnBqv0elfC4OyJ3JwL8P6fJ+Rq+EDDtBlxqp/LL12T9Ll/pvtXN2RRGM9G
         AKxg==
X-Forwarded-Encrypted: i=1; AHgh+Rpt1/EeJ6qwjVjW3Q6EzmxfgH5fRyzEWd7sa/l/bxQCm13UvtszEEmpl5X/+FyaywMAJ0cVO5wNikvm9OWuv0j6mOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHPylked3XRIIbq9FUNGgA4PMC0EmYODtLAVb+LVt8NSlnhHE
	+HtYJJuGN+T5fi+boJgYycR3D65+zJItZX3ErjVWvVNC/eXx0CCFpKTJkRuatA2YZyqkl12AOMY
	bLXy/LYjm7i1z0Zhr48qqOmotuLufD+PsmrqDbzxakUXtYx5yZYH3d1RGmo6wOrqc76tNxbtbh0
	8v4WaMKWqo+0dEq6JncBi/RXeXATgK4hFqtPZ6Xh23zyQbLcRe
X-Gm-Gg: AfdE7cn35pZ4AEGnQcidKQiZLUwAKo0YkP35MXwkuaxNAXo4hQK+2RNbgwfZKUolyMA
	geg+Sw9dMX+kVlTMBrT2yjplTM6ICnh70GnP6yHPg6AXnxLe0MyMV95yb5VvtJx68Fe5l6vlhs8
	q8ZZ6mhuV8CBEdhVEm+Q3zEWvBykrg4bCsf7IEob1bQbtcYYNMjQsLqqj0/6iyl9zrnRw=
X-Received: by 2002:a17:907:c0d:b0:bd2:15b5:bf60 with SMTP id a640c23a62f3a-c12903c0601mr74318166b.3.1782814492079;
        Tue, 30 Jun 2026 03:14:52 -0700 (PDT)
X-Received: by 2002:a17:907:c0d:b0:bd2:15b5:bf60 with SMTP id
 a640c23a62f3a-c12903c0601mr74315366b.3.1782814491533; Tue, 30 Jun 2026
 03:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617131803.2988989-1-vschneid@redhat.com> <20260617131803.2988989-5-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-5-vschneid@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 30 Jun 2026 12:14:39 +0200
X-Gm-Features: AVVi8CdV63JL6zypYyN7ya_bbJdiYKtnKuNVcO4pMN3BA4UQwMqsLJ4ki3aRrN0
Message-ID: <CAP4=nvQ_x+LyDBoQWOBB4ERy8OwEp9LQzyLJJMHzYdrZzK4zyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] rtla/osnoise: Leverage IPI event filters when
 tracing a subset of CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sg6utONC455xQ1x7SG6QQLAgbFLCJWip591EPARTRXU_1782814492
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> Instead of post-processing the events in the tracefs_iterate_raw_events()
> callbacks, leverage the kernel event filtering infrastructure to only emi=
t
> IPI events if they target CPUs that are being traced, as specified by the
> -c cmdline option.
>
> Note that some post-processing is still required for the ipi_send_cpumask
> event, as the event being emitted means *some* CPUs targeted by that even=
t
> are monitored, but not all of them - userspace has to recompute that
> intersection.
>

Nit: I'd drop the "Instead of post-processing the events in the
tracefs_iterate_raw_events() callbacks" sentence. I find it a bit
confusing, as "instead of" is quite a strong wording implying
post-processing is removed (at least to my perception), but in the
next paragraph, you contradict it by saying that some post-processing
is still done. Also the commit message is perfectly understandable
without it.

> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 37 +++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index 5b462a3543b97..8040521710884 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -93,18 +93,15 @@ osnoise_ipi_cpu_handler(struct trace_seq *s, struct t=
ep_record *record,
>                      struct tep_event *event, void *context)
>  {
>         struct osnoise_tool *tool;
> -       struct osnoise_params *params;
>         unsigned long long src_cpu, dst_cpu;
>         struct trace_instance *trace =3D context;
>
>         tool =3D container_of(trace, struct osnoise_tool, trace);
> -       params =3D to_osnoise_params(tool->params);
>
>         src_cpu =3D record->cpu;
>         tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
>
> -       if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
> -               account_ipi(tool, src_cpu, dst_cpu);
> +       account_ipi(tool, src_cpu, dst_cpu);
>
>         return 0;
>  }
> @@ -141,6 +138,11 @@ osnoise_ipi_cpumask_handler(struct trace_seq *s, str=
uct tep_record *record,
>                 return 0;
>         }
>
> +       /*
> +        * Despite already filtering for such an intersection, we need to=
 compute
> +        * the intersection here as the @cpumask field may contain non-mo=
nitered

Typo: non-monitered -> non-monitored

> +        * CPUs.
> +        */
>         CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_=
cpus);
>
>         /*
> @@ -406,6 +408,33 @@ struct osnoise_tool *osnoise_init_top(struct common_=
params *params)
>                 goto out_err;
>         }
>
> +       /*
> +        * If tracing on a subset of possible CPUs, leverage the kernel f=
iltering
> +        * infrastructure to only generate events on traced CPUs.
> +        */
> +       if (params->cpus) {
> +               char filter[MAX_PATH];
> +
> +               snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\n", =
params->cpus);
> +               retval =3D tracefs_event_file_write(tool->trace.inst,
> +                                                 "ipi", "ipi_send_cpu", =
"filter",
> +                                                 filter);
> +               if (retval) {

retval is the number of bytes written here, so this should be "retval
< 0" like in trace_event_enable_filter() in trace.c. Same below.

> +                       err_msg("Could not set ipi_send_cpu CPU filter\n"=
);
> +                       goto out_err;

It would be useful to have --ipi work even on older kernels that don't
yet have your cpumask trace event filter patchset [1], for example, by
printing a debug message that filtering is disabled and setting a flag
instead of erroring out here. Then the code in
osnoise_ipi_cpu_handler() can preserve the CPU_ISSET check if the flag
is set.

As --ipi is optional, we can choose to only support it on newer
kernels, but it would be nice to have it working without the filter,
too.

[1] https://lore.kernel.org/linux-trace-kernel/20230707172155.70873-1-vschn=
eid@redhat.com/T/#u

> +               }
> +
> +
> +               snprintf(filter, ARRAY_SIZE(filter), "cpumask & CPUS{%s}\=
n", params->cpus);
> +               retval =3D tracefs_event_file_write(tool->trace.inst,
> +                                                 "ipi", "ipi_send_cpumas=
k", "filter",
> +                                                 filter);
> +               if (retval) {
> +                       err_msg("Could not set ipi_send_cpumask CPU filte=
r\n");
> +                       goto out_err;
> +               }

Same two comments above apply here.

> +       }
> +
>         tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send_=
cpu",
>                                    osnoise_ipi_cpu_handler, NULL);
>
> --
> 2.54.0
>

I was thinking that it might make sense to enable the filters also for
the trace output instance. On the other hand, it would make it
difficult to enable the event without the filter then, as specifying
"-e ipi" or similar only re-enables the event but does not remove the
filter. Maybe the better idea is to implement an option to filter any
event enabled through -e/--event only to the measurement CPU, as a
separate feature.

Tomas

