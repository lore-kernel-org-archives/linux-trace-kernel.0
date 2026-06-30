Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FD33F5A1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827993; cv=none; b=CgBFtCGW56rmmek5e3Q2+e1uFXVBgLOvMB63A8z2apliYLJurGV+/Z+1dj8KJcKbr3gAuPcsOrxt64PXZxRgZYxh/1lCa+hPreux1KgwRU6Bofrov0ZQCbkHCgmsPxnQyV1IlLGpyrXj5EbCmd9HrErDhcNrFv/XsJ0DgbD+KBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827993; c=relaxed/simple;
	bh=KBj7n0jg/cOvt1k05+E5P4zUNGq3vVE/4CZ4f8xXppw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lvMH2HVXWCQm4cE/zBzyCEjvvnC/iTtqxoKLSWm4oBegWthtua044Wn2pjbU6S0WVvSY4qxXikPiJaNZKNctfWkzObY0FUsrW9vSeqRlZC+ZR2MWS/hreUkt8teZZTfmzBWaRFAJ4LEqOZ3iMNW0Fa6RX3JBj0oi+bTAM6GK5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSnBlCGs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSnBlCGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782827991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueKJ1EobC/gGuiN1Tyib59pwiSZXC8CCC83Cv8r8RZU=;
	b=eSnBlCGszuOqDoVEpzILEcjHbErYs2UTl1NzmH5YJiWy9bvWprhmTNLRwbACk/GWts3TAU
	NfgGxP/KI2Kjwzgm1gatVKH34gGc/jK/1XoU+kHHIZI+0616epXpgYFId2hmnJzHVM0s1C
	ih9iPhDhGQRD5i7186gVavOoyhION8k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-s6KIgMDPO5iYWDdxN3Pg2A-1; Tue, 30 Jun 2026 09:59:49 -0400
X-MC-Unique: s6KIgMDPO5iYWDdxN3Pg2A-1
X-Mimecast-MFC-AGG-ID: s6KIgMDPO5iYWDdxN3Pg2A_1782827988
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so1301486f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827988; x=1783432788;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ueKJ1EobC/gGuiN1Tyib59pwiSZXC8CCC83Cv8r8RZU=;
        b=q/BI7F6KraqKgJBy4R9BBNloyRUfK9GoO067dCNBhfHFEebKV+HOoOethfmAwFnmNq
         /3KY/qiMM29WHRdQe2JKHhfqQA9KLlFREQ/f5hOQMdyYLKYjHpg9/T5bkGGCZScxZYuf
         f4glnrBLHFIHEgxHKewL4JUkHiBhdTS8AIVfPldSSPOTqdIoayR5d7nvB6sN05ZDJnfS
         KN1jOfxi0NxaibIe7MST4pwVcosKIcXj6dbXiKTsFMtZ5REDFKoEScZ2QkwVojVkKnuL
         e4vAhKgbuCvzrJWHWgyJodCtKB0LNdSKWD7FoyLrBUBTbEztsVSDfFZwk+bMkWM+j0Ir
         N/zA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5nosmpowYCQE3+N9XY6yr1VNFG5vyrm7LJ5xZpmVYyyg/Wd5xv6NqJJXjRGdwW+A4gOw6qpic7B/LfmuccH5uBjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+5VW2IdcJAs7cC7J1YWv2irUh3NXf0qd7wEvA/bEsatWGG0x
	rY2efGO0BrW4slQSih5F5USp1QEfe/JGA1mvDaJoP/a2pQApAv1OgjJy4MThtF/u/x+k3cqHyGO
	U9rFrIMBUGx2W3oWVwJ1CIY1y2G9KPTP7YgFPf19WtPSAdhiLFeRBSU+dHblUsj2RLnR2SRLnRA
	==
X-Gm-Gg: AfdE7ckPguTD9IMtXGIKbfnaOe15/ZUxekaR6J4RhQbzOxeeb/oWhpyT11+CfXoY8Uw
	bKlBuJOkfrZAUpR5UVUzK+n/5ASx+ihJHoxCXsfuVJrPLCBOCtIkPDfHJ3EHd80UUrHq9bMBDcI
	dRDIiKJ+baYCdGesRrxTIDGPQbgnvhNeuUKsODh0dU0aWQQ663SKe9LzZdqXNBQQPuS2OoDiQck
	ixWHM14uapWjFl9YemqkDoM1Es8zy0Xyj7Xrs1+k7FNp75EDDtQj6d+YswKwLDJ2rFzZKXb3PO+
	QKr2O0/7p8Hqu/QC4k8EuF7F+0fHSQtMXp5un8hM5sU0iqc341qZ8CKXjA7KYVohYQWTZWjPtFl
	99EMjLHqh5emHvwbHGFwrOwi9MJ2GuCE4CP5NCJcY3kTau0DhCsiWFTTQHQCjQyIeCNVa62eG
X-Received: by 2002:a5d:5690:0:b0:475:3a97:8e3c with SMTP id ffacd0b85a97d-47658ba33ffmr789182f8f.18.1782827988153;
        Tue, 30 Jun 2026 06:59:48 -0700 (PDT)
X-Received: by 2002:a5d:5690:0:b0:475:3a97:8e3c with SMTP id ffacd0b85a97d-47658ba33ffmr789150f8f.18.1782827987665;
        Tue, 30 Jun 2026 06:59:47 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm8539912f8f.8.2026.06.30.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:59:46 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 2/4] rtla/osnoise: Record IPI count in osnoise top
In-Reply-To: <CAP4=nvRtF=Hq3rVS5jCwA-m_vJWEeROy=60T2PW4DYank-6L-w@mail.gmail.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
 <20260617131803.2988989-3-vschneid@redhat.com>
 <CAP4=nvRtF=Hq3rVS5jCwA-m_vJWEeROy=60T2PW4DYank-6L-w@mail.gmail.com>
Date: Tue, 30 Jun 2026 15:59:45 +0200
Message-ID: <xhsmho6gsw2lq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6WQYRfRb37iVTCV4awJ_GkLGTOAeVip9DqtnDbYx-dI_1782827988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/06/26 14:56, Tomas Glozar wrote:
> st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
> <vschneid@redhat.com> napsal:
>> +/*
>> + * osnoise_ipi_cpu_handler - this is the handler for single CPU IPI eve=
nts.
>> + */
>> +static int
>> +osnoise_ipi_cpu_handler(struct trace_seq *s, struct tep_record *record,
>> +                    struct tep_event *event, void *context)
>> +{
>> +       struct osnoise_tool *tool;
>> +       struct osnoise_params *params;
>> +       unsigned long long src_cpu, dst_cpu;
>> +       struct trace_instance *trace =3D context;
>> +
>> +       tool =3D container_of(trace, struct osnoise_tool, trace);
>> +       params =3D to_osnoise_params(tool->params);
>> +
>> +       src_cpu =3D record->cpu;
>> +       tep_get_field_val(s, event, "cpu", record, &dst_cpu, 1);
>> +
>> +       if (CPU_ISSET(dst_cpu, &params->common.monitored_cpus))
>> +               account_ipi(tool, src_cpu, dst_cpu);
>
> Do we need to retrieve and pass the src_cpu here? I get it if you plan
> on using it in the future, but as far as I understand, you are
> specifically tracking the destination CPU, not the source CPU. Same
> note applies to osnoise_ipi_cpumask_handler() below.
>

You're right, I fished out the src_cpu to have it available but it's not
being used ATM.

>> +
>> +       return 0;
>> +}
>> +
>> +static cpu_set_t cpumask_tmp_cpus;
>> +
>> +/*
>> + * osnoise_ipi_cpumask_handler - this is the handler for broadcasted IP=
I events.
>> + */
>> +static int
>> +osnoise_ipi_cpumask_handler(struct trace_seq *s, struct tep_record *rec=
ord,
>> +                        struct tep_event *event, void *context)
>> +{
>> +       struct trace_instance *trace =3D context;
>> +       struct osnoise_tool *tool;
>> +       struct osnoise_params *params;
>> +       struct tep_format_field *field;
>> +       unsigned long long src_cpu;
>> +       cpu_set_t *event_cpus;
>> +       int len;
>> +
>> +       tool =3D container_of(trace, struct osnoise_tool, trace);
>> +       params =3D to_osnoise_params(tool->params);
>> +
>> +       src_cpu =3D record->cpu;
>> +
>> +       field =3D tep_find_field(event, "cpumask");
>> +       if (!field)
>> +               return 0;
>> +
>> +       event_cpus =3D tep_get_field_raw(s, event, "cpumask", record, &l=
en, 1);
>> +       if (!event_cpus) {
>> +               err_msg("Failed to get cpumask field\n");
>> +               return 0;
>> +       }
>> +
>> +       CPU_AND(&cpumask_tmp_cpus, event_cpus, &params->common.monitored=
_cpus);
>> +
>> +       /*
>> +        * Computing the mask weight is overkill but there is no leaner =
option
>> +        * provided by glibc, e.g cpumask_first() or somesuch.
>> +        */
>> +       if (CPU_COUNT(&cpumask_tmp_cpus)) {
>> +               for (int cpu =3D 0; cpu < nr_cpus; cpu++) {
>> +                       if (CPU_ISSET(cpu, &cpumask_tmp_cpus))
>> +                               account_ipi(tool, src_cpu, cpu);
>> +               }
>> +       }
>
> Technically, the existing code already relies on the glibc cpumask
> implementation (cpu_set_t) matching the kernel "cpumask_t" type, as
> the "cpumask" field is the latter (per
> /sys/kernel/tracing/events/ipi/ipi_send_cpumask/format), not the
> former. So I wouldn't worry about the opaqueness of cpu_set_t much.
>

Right, AFAICT that's the "canonical" type for passing cpumasks around
between userspace and kernelspace. e.g. for sched_getaffinity():

manpage:

    int sched_getaffinity(pid_t pid, size_t cpusetsize,
                          cpu_set_t *mask);

kernelside:

    SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
                    unsigned long __user *, user_mask_ptr)
    {
            cpumask_var_t mask;
            sched_getaffinity(pid, mask);
            copy_to_user(user_mask_ptr, cpumask_bits(mask), ...)
    }

> Not sure how this is handled in other tracing tools that need to use
> cpumask, I'd have to look around a bit. It might even make sense to
> have a "tools" version of the cpumask functions like cpumask_first(),
> I guess, like we already do for e.g. lists and container_of.
>

I couldn't find anything in tools/testing/* other than the CPU_*() helpers.

>> +
>> +       return 0;
>> +}
>> +
>>  /*
>>   * osnoise_top_handler - this is the handler for osnoise tracer events
>>   */
>
> Nit: As this is extra functionality, it'd be more readable to have the
> IPI handling after the main top handler, so that someone not familiar
> with the source code will see the core logic first. That would also
> match IPI being displayed to the right of the other numbers in the top
> output.
>

Ack.

>> @@ -164,6 +251,8 @@ static void osnoise_top_header(struct osnoise_tool *=
top)
>>                 goto eol;
>>
>>         trace_seq_printf(s, "          IRQ      Softirq       Thread");
>> +       if (params->common.ipi)
>> +               trace_seq_printf(s, "          IPI");
>>
>>  eol:
>>         if (pretty)
>> @@ -218,7 +307,13 @@ static void osnoise_top_print(struct osnoise_tool *=
tool, int cpu)
>>
>>         trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
>>         trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
>> -       trace_seq_printf(s, "%12llu\n", cpu_data->thread_count);
>> +       trace_seq_printf(s, "%12llu", cpu_data->thread_count);
>> +       if (!params->common.ipi) {
>> +               trace_seq_printf(s, "\n");
>> +               return;
>> +       }
>> +
>> +       trace_seq_printf(s, " %12llu\n", cpu_data->ipi_count);
>
> Maybe at this point it is worth it to print the "\n" in a separate
> statement, readability-wise:
>
>         trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
>         trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
>         trace_seq_printf(s, "%12llu", cpu_data->thread_count);
>         if (params->common.ipi)
>                 trace_seq_printf(s, " %12llu", cpu_data->ipi_count);
>         trace_seq_printf(s, "\n");
>
> It would also make diffs nicer when adding new options.
>

Indeed, will do.

>> [truncated]
>
>
> Tomas

