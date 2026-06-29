Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8537401A3C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737801; cv=none; b=Zx7an9bjfUD4/MGWCHq8T4M5uxYNmOo6wD4JIqPNcM0wKyUqSSSw1JRq2sVfNwP3GY7cVGCS5U5M3CDgSDoYvPGJlTfgvnbIqwGpaGzQSdpE2BF542h59B4meD/r34APt2mCAyYrG37176R3cLeevMY+//RMVMqFPeDT+G0hDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737801; c=relaxed/simple;
	bh=zAWj/TM5e7h+thDrLj1MEqN2AcI1HHUtKP4lddDsVIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0G3rknl5dH15rDl2QuMQk/fPNSyUStslbLI1Ip3parnA5P2hPv/6x+7sSzDYWqF9tbfbHuOnowYjojPK72A2YjecrcHWIeAv3ZMG5gKwVyiHbDH1iXLyzyOf59D44szlR229xr8nimQm5Mw9weqjZ5BLcbfhCHCMtM5b8eJiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd/MO4ak; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd/MO4ak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782737798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSr1JETcuRGYYdZKolk3JtUkQ8ducZ/gLObEH71sZrI=;
	b=Cd/MO4akLE39QrDpHR98hH/e0hIl/35rHJgofvvdziNLHC94cbJmJtj2INqhLejh9TZxPP
	NNmYTLKF5q1BW5hzxuB97ngjaH0H6AV/mvFc1FrjsTcH0d1Jmdk5dR6MpsTyL3wStltdTq
	EPgV5tMYtpewAMgwrO0+AtZ+kYFUwHg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-52f6IJkRP7agROi06mwu2Q-1; Mon, 29 Jun 2026 08:56:37 -0400
X-MC-Unique: 52f6IJkRP7agROi06mwu2Q-1
X-Mimecast-MFC-AGG-ID: 52f6IJkRP7agROi06mwu2Q_1782737796
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1279120710so49297666b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737796; x=1783342596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wSr1JETcuRGYYdZKolk3JtUkQ8ducZ/gLObEH71sZrI=;
        b=JUpiaBDmz6QapMacq5F1dhbBEUcxos3hTNoTxcCIEZnZRILq9TAv0/Kbds7XQo/R9I
         bDYV6YSBdlBFg+vSOhRHrXWCCAqvE4qvjF/NWiBN+Fg6D8k81uIbPwAHmgLDX9hx6HCr
         0A+kWkQea5k98HL5lDyaQc2/ZTaM7Rh/NnY20gX/F8NRD8VHoAZQi/tXOVj98OCTpJZj
         4SDdB/W9MZxwIwoUp4+yqB1haAdLNFUSS6gllEeFWJj1gRQqGjVUqG+pq3tveyuaykkH
         QLiSjZHVrLCdT90dE+9IW9dHtAmtxzq+A24w7V+/7ESe2E5VKXDsOBrmdavKXLlpjSM5
         40xw==
X-Forwarded-Encrypted: i=1; AHgh+RoJKAKKmkgQXLsSIlUcg359nin+fx7QT4TwMMT5+fRmYwOjtocMV0d4zuSCtEekykExMQlztrVnV2RF/iZyWwlQBFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNriBulM638SG332z8nrbuR514gs0n9XA8Y/w6w1usBaZp5fvE
	YhVBXOV/G0YsbfXpSW3NFoMU/cKC7zHL5THX+dlkM1gbnypGYzNcEHyRNE8gprzmPsiaF6dUCcp
	ol19A7CBN3Im6wnjcRUoU/natdxHLDiaZfF3pF5T2vVa4xnnYJAmlumqYd1ELGv1RwXYIfcaRmB
	5wNOUTt9BVH4H7crls1oIVT/QtB1z3gDf+OlMBK3BabP2C4P7U
X-Gm-Gg: AfdE7ckMyjoyMqT4VZxdnojxl+J3cJEe6GMk/9P2J7RHzN2iu67pk8QZQpQ9gDpPjRH
	ZMfChHGtbMwNtQDg9X4sQ4yuk4VZPim6ZGzFDzIKB4wPVg8NzPs/qISkbLuItzyOg8AkKyqZfjz
	P50tUk9xdzNADkHqA/CeYirCBgpffCFoQ1u84zrTAnKF3SsUi2x+ebISuDrDZlsmXzcIs=
X-Received: by 2002:a17:906:9fc4:b0:c12:45fc:c5c with SMTP id a640c23a62f3a-c1245fc3091mr290479166b.64.1782737796297;
        Mon, 29 Jun 2026 05:56:36 -0700 (PDT)
X-Received: by 2002:a17:906:9fc4:b0:c12:45fc:c5c with SMTP id
 a640c23a62f3a-c1245fc3091mr290477366b.64.1782737795783; Mon, 29 Jun 2026
 05:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617131803.2988989-1-vschneid@redhat.com> <20260617131803.2988989-3-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-3-vschneid@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 29 Jun 2026 14:56:24 +0200
X-Gm-Features: AVVi8CdvJdgIeH3VsyxOkz9Elhzqqd6Z9AENxqiNKKObavOdoGbdQhxj5DMUO14
Message-ID: <CAP4=nvRtF=Hq3rVS5jCwA-m_vJWEeROy=60T2PW4DYank-6L-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] rtla/osnoise: Record IPI count in osnoise top
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TdfL3DdZQp9ejW-7uXUk-wj46IamEyGmAujsKYVZe2s_1782737796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> Leverage the ipi_send_cpu and ipi_send_cpumask trace events to record the
> count of IPIs sent to monitored CPUs. These interferences are already
> accounted by the IRQ count, but this split gives a better overall picture=
.
>
> This uses the newly added -i cmdline option.
>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 124 ++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 1 deletion(-)
>

Overall, looks good to me (see small comments below). The reported
numbers make sense:

[tglozar@cs9 rtla]$ sudo ./rtla osnoise top -q -c 0,1 -d 5s --ipi
                                         Operating System Noise
duration:   0 00:00:05 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max
Single          HW          NMI          IRQ      Softirq       Thread
         IPI
 0 #4           4000000        28481    99.28797        8977
248        6756            0         4002           18            1
       42
 1 #5           5000000        38025    99.23950        8120
185        8403            0         5260          153          141
       49

(It looks good in the terminal, I'm sure Gmail will garble it...)

I'll compare with trace output on the next patch.

> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index 512a6299cb018..5b462a3543b97 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
>
> [truncated]
>
> @@ -70,6 +72,91 @@ static struct osnoise_top_data *osnoise_alloc_top(void=
)
>  return NULL;
>  }
> +static void account_ipi(struct osnoise_tool *tool,
> +                       unsigned long long src_cpu, unsigned long long ds=
t_cpu)
> +{
> +       struct osnoise_top_cpu *cpu_data;
> +       struct osnoise_top_data *data;
> +       unsigned long long inc =3D 1;
> +
> +       data =3D tool->data;
> +       cpu_data =3D &data->cpu_data[dst_cpu];
> +
> +       update_sum(&cpu_data->ipi_count, &inc);
> +}
> +
> +/*
> + * osnoise_ipi_cpu_handler - this is the handler for single CPU IPI even=
ts.
> + */
> +static int
> +osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
> +                    struct tep_event *event, void *context)
> +{
> +       struct osnoise_tool *tool;
> +       struct osnoise_params *params;
> +       unsigned long long src_cpu, dst_cpu;
> +       struct trace_instance *trace =3D context;
> +
> +       tool =3D container_of(trace, struct osnoise_tool, trace);
> +       params =3D to_osnoise_params(tool->params);
> +
> +       src_cpu =3D record->cpu;
> +       tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
> +
> +       if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
> +               account_ipi(tool, src_cpu, dst_cpu);

Do we need to retrieve and pass the src_cpu here? I get it if you plan
on using it in the future, but as far as I understand, you are
specifically tracking the destination CPU, not the source CPU. Same
note applies to osnoise_ipi_cpumask_handler() below.

> +
> +       return 0;
> +}
> +
> +static cpu_set_t cpumask_tmp_cpus;
> +
> +/*
> + * osnoise_ipi_cpumask_handler - this is the handler for broadcasted IPI=
 events.
> + */
> +static int
> +osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *reco=
rd,
> +                        struct tep_event *event, void *context)
> +{
> +       struct trace_instance *trace =3D context;
> +       struct osnoise_tool *tool;
> +       struct osnoise_params *params;
> +       struct tep_format_field *field;
> +       unsigned long long src_cpu;
> +       cpu_set_t *event_cpus;
> +       int len;
> +
> +       tool =3D container_of(trace, struct osnoise_tool, trace);
> +       params =3D to_osnoise_params(tool->params);
> +
> +       src_cpu =3D record->cpu;
> +
> +       field =3D tep_find_field(event, "cpumask");
> +       if (!field)
> +               return 0;
> +
> +       event_cpus =3D tep_get_field_raw(s, event, "cpumask", record, &le=
n, 1);
> +       if (!event_cpus) {
> +               err_msg("Failed to get cpumask field\n");
> +               return 0;
> +       }
> +
> +       CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored_=
cpus);
> +
> +       /*
> +        * Computing the mask weight is overkill but there is no leaner o=
ption
> +        * provided by glibc, e.g cpumask_first() or somesuch.
> +        */
> +       if (CPU_COUNT(&cpumask_tmp_cpus)) {
> +               for (int cpu =3D 0; cpu < nr_cpus; cpu++) {
> +                       if (CPU_ISSET(cpu, &cpumask_tmp_cpus))
> +                               account_ipi(tool, src_cpu, cpu);
> +               }
> +       }

Technically, the existing code already relies on the glibc cpumask
implementation (cpu_set_t) matching the kernel "cpumask_t" type, as
the "cpumask" field is the latter (per
/sys/kernel/tracing/events/ipi/ipi_send_cpumask/format), not the
former. So I wouldn't worry about the opaqueness of cpu_set_t much.

Not sure how this is handled in other tracing tools that need to use
cpumask, I'd have to look around a bit. It might even make sense to
have a "tools" version of the cpumask functions like cpumask_first(),
I guess, like we already do for e.g. lists and container_of.

> +
> +       return 0;
> +}
> +
>  /*
>   * osnoise_top_handler - this is the handler for osnoise tracer events
>   */

Nit: As this is extra functionality, it'd be more readable to have the
IPI handling after the main top handler, so that someone not familiar
with the source code will see the core logic first. That would also
match IPI being displayed to the right of the other numbers in the top
output.

> @@ -164,6 +251,8 @@ static void osnoise_top_header(struct osnoise_tool *t=
op)
>                 goto eol;
>
>         trace_seq_printf(s, "          IRQ      Softirq       Thread");
> +       if (params->common.ipi)
> +               trace_seq_printf(s, "          IPI");
>
>  eol:
>         if (pretty)
> @@ -218,7 +307,13 @@ static void osnoise_top_print(struct osnoise_tool *t=
ool, int cpu)
>
>         trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
>         trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
> -       trace_seq_printf(s, "%12llu\n", cpu_data->thread_count);
> +       trace_seq_printf(s, "%12llu", cpu_data->thread_count);
> +       if (!params->common.ipi) {
> +               trace_seq_printf(s, "\n");
> +               return;
> +       }
> +
> +       trace_seq_printf(s, " %12llu\n", cpu_data->ipi_count);

Maybe at this point it is worth it to print the "\n" in a separate
statement, readability-wise:

        trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
        trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
        trace_seq_printf(s, "%12llu", cpu_data->thread_count);
        if (params->common.ipi)
                trace_seq_printf(s, " %12llu", cpu_data->ipi_count);
        trace_seq_printf(s, "\n");

It would also make diffs nicer when adding new options.

> [truncated]


Tomas

