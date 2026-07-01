Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D5F377551
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888364; cv=none; b=edftWQs+Mr1UF4cNJE89VrxtLZvKRnrUB1kfC51OoGs/Nwu6YppoV8eKIeRzT75dnYOWzGrp9xebT8bLjdsCCVB9qNJ0KT0+FaGhwPxnFd4t4983ggfsieXWHQ9QzBHATraosYqIMIuF3JueqCc64Xf7ZRnGT6GzLZk8UnSzIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888364; c=relaxed/simple;
	bh=P6h7/GJ4nRFB935sw/Q/SrqcZXQl1/aLKw+/Zd7Xw48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8wBWtAhknhQTQS4tOTHQi1jOvd6ZtHX7iH1YE4nb9dx5tCY8Fa/n8VFMQWexiBn9hV+cxnn4vBhNXr5xIWxdHaiGaSko8OCPr5SZVIZk4Jg8Lt+/I03gDcnDCnKTIir98b9OTIS6ezYCvU/gTAGC7ALdMf9tIDc5NHPyyQVTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMd189et; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMd189et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782888362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yajVz5eGSdxmFXFovVfMHhACk5O+HGFB9rZykXvrdI=;
	b=BMd189etFs95rC2JQz0xLLAPbC/sQ0ZgxjISJMJ9rA7vNyxYMOcjThDdZuA3P9qiLdSrVD
	Bugoc8GN3eKT3DLEDzaTpm4z2BI6IpiHBFYcAlDdPkEw5Bkjg+A8jj/GdylrifA6e7kapy
	x3mvYs4qwD2f8moyRT+/qGyhVBQYEls=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-bhm5dPvPNF2pNXp-FMNplw-1; Wed, 01 Jul 2026 02:45:53 -0400
X-MC-Unique: bhm5dPvPNF2pNXp-FMNplw-1
X-Mimecast-MFC-AGG-ID: bhm5dPvPNF2pNXp-FMNplw_1782888352
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c126f7ef83cso32525766b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 23:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888352; x=1783493152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yajVz5eGSdxmFXFovVfMHhACk5O+HGFB9rZykXvrdI=;
        b=mvcppbvZX8MMeme///1R8IxmoFIRm4Wiaov5dOMFtblf2s8oZ80VtumR2QOdHhk3/q
         8aYriPnlanUOJ5CpaiBqN558nBntPIFSKxiXhzAwIqqWvgnjNPAxqIZx0VKqCu5w0bAm
         ADr78npIFUbrHj+pi7/YX7veGpeGf1RpmmFl6VpjRxMA6Fy+kF/FryqNc9iCosZIvlao
         6Wr7moICsmgyp7xTo7smx71JsytrhVPn23/VhQ2zx86YZsBi3lfADy5enRL5dV8MIsXs
         BhPa3+pazDyBQAnAa9401XEbUUL/VgzGwQL5ImCrQwviD2dd4OuksFZ0YIT8H7nykRo/
         QrLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rot0zJBSjT2KAMtArnAt8zDF3lXX57ni/dIg/zNdY8tSgyJIsMc/fipyiJsY1Anwv6OiljAXe97jCP2fNbz4sb4Tpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1Zsn8l9LCdrsYxcehybPdwDWu6LRyYEmT+yroSfAAAvVNrvb
	4nvk2rJySPf1DUHNn/7z2rXMradDAhd/ZFXzE59jS2ioNDEvMvI3hH/406g16IQcsb6WeEcbtnW
	Fp4WHEoEVuGMe+43HiV3swepZtjUb1+tDzEBigdMysWJ9URh+VI3i6x+beHMLzoL4KrpTYSb1Lg
	zIVESGAOuwKdm62KrwDcm4uryrjp73YVK2iZcj++Xvr19XbV9X
X-Gm-Gg: AfdE7cmsgy8fXkw5mfQloHwlIOypIaiZUiWftTJfy3aVdjuM+VCfM6By3wECGMbEKDf
	46rjOKjav2kT5bDorys/EL1Vtd4y5o137PuvyPHMyN0VW9KAIXE1fUjMtXPAhuTJofX/dHDoPZO
	h8FwRTTvZVYBSp1xpWOXRU3w9Rlk5/uf0n1+XAvatEvMKZWklE6gwLnabId4C5WjH0jA8=
X-Received: by 2002:a17:907:3cc8:b0:c12:a425:cbca with SMTP id a640c23a62f3a-c12aa17e6c1mr9818766b.54.1782888352226;
        Tue, 30 Jun 2026 23:45:52 -0700 (PDT)
X-Received: by 2002:a17:907:3cc8:b0:c12:a425:cbca with SMTP id
 a640c23a62f3a-c12aa17e6c1mr9817266b.54.1782888351649; Tue, 30 Jun 2026
 23:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617131803.2988989-1-vschneid@redhat.com> <20260617131803.2988989-5-vschneid@redhat.com>
 <CAP4=nvQ_x+LyDBoQWOBB4ERy8OwEp9LQzyLJJMHzYdrZzK4zyw@mail.gmail.com> <xhsmhmrwcw2ll.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhmrwcw2ll.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 1 Jul 2026 08:45:40 +0200
X-Gm-Features: AVVi8Cfv5zggH5cBY60GJD-xLGqDK2qmvaVcwhO1nQafpkqSczbluBW1LGAsqVk
Message-ID: <CAP4=nvT5H73ptaBaZ2fWQ+SjJ-c3eEGZbrSefMV6fxqL-va2XA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] rtla/osnoise: Leverage IPI event filters when
 tracing a subset of CPUs
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3zfxgCPYI1zR87JFAjLjbsXa_QUMedFqdUX-5bv-b7o_1782888352
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 30. 6. 2026 v 16:00 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> On 30/06/26 12:14, Tomas Glozar wrote:
> > st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
> > <vschneid@redhat.com> napsal:
> >> @@ -406,6 +408,33 @@ struct osnoise_tool *osnoise_init_top(struct comm=
on_params *params)
> >>                 goto out_err;
> >>         }
> >>
> >> +       /*
> >> +        * If tracing on a subset of possible CPUs, leverage the kerne=
l filtering
> >> +        * infrastructure to only generate events on traced CPUs.
> >> +        */
> >> +       if (params->cpus) {
> >> +               char filter[MAX_PATH];
> >> +
> >> +               snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\n=
", params->cpus);
> >> +               retval =3D tracefs_event_file_write(tool->trace.inst,
> >> +                                                 "ipi", "ipi_send_cpu=
", "filter",
> >> +                                                 filter);
> >> +               if (retval) {
> >
> > retval is the number of bytes written here, so this should be "retval
> > < 0" like in trace_event_enable_filter() in trace.c. Same below.
> >
>
> According to the docstring:
>
>  * Return 0 on success, and -1 on error.
>
> but regardless yes that should be a '< 0' check to match existing code.
>

I double-checked that and you are correct that the docstring says so,
but it's an error in the docstring. According to the manpage, it
returns the number of bytes written (i.e. positive on success, not
zero) [1]:

"RETURN VALUE
...
tracefs_event_file_write() and tracefs_event_file_append() returns
*the number of bytes written to the system/event file* or negative on
error."

The code agrees as well: in tracefs_event_file_write() there's the
wrong docstring (likely copied from another function) [2]:

/*
 * tracefs_event_file_write - write to an event file
 * ...
 * Return 0 on success, and -1 on error.
 */
int tracefs_event_file_write(struct tracefs_instance *instance,
    const char *system, const char *event,
    const char *file, const char *str)
{
        ....
        ret =3D tracefs_instance_file_write(instance, path, str);
        free(path);
        return ret;
}

but the source of the return value is tracefs_instance_file_write(),
where the docstring is correct [3]:

/**
 * tracefs_instance_file_write - Write in trace file of specific instance.
 * ...
 * Returns the number of written bytes, or -1 in case of an error
 */
int tracefs_instance_file_write(struct tracefs_instance *instance,
const char *file, const char *str)
{
        return instance_file_write(instance, file, str, O_WRONLY | O_TRUNC)=
;
}

instance_file_write() gets the return value from write_file() [4]
which returns the return value of write() [5].

[1] https://man7.org/linux/man-pages/man3/tracefs_event_get_file.3.html
[2] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tr=
acefs-events.c#n686
[3] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tr=
acefs-instance.c#n532
[4] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tr=
acefs-instance.c#n514
[5] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tr=
acefs-instance.c#n496

So the "< 0" is required, the CPU filter doesn't work without it:

[tglozar@fedora rtla]$ uname -a
Linux fedora 7.0.12-101.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jun 11
01:32:26 UTC 2026 x86_64 GNU/Linux
[tglozar@fedora rtla]$ sudo ./rtla osnoise top -q -c 0 --ipi
Could not set ipi_send_cpu CPU filter, return value: 14
Could not init osnoise tool
[tglozar@fedora rtla]$ sudo ./rtla osnoise top -q -d 5s --ipi
                                         Operating System Noise
...
[tglozar@fedora rtla]$

(output with additional debug print)

> >> +                       err_msg("Could not set ipi_send_cpu CPU filter=
\n");
> >> +                       goto out_err;
> >
> > It would be useful to have --ipi work even on older kernels that don't
> > yet have your cpumask trace event filter patchset [1], for example, by
> > printing a debug message that filtering is disabled and setting a flag
> > instead of erroring out here. Then the code in
> > osnoise_ipi_cpu_handler() can preserve the CPU_ISSET check if the flag
> > is set.
> >
> > As --ipi is optional, we can choose to only support it on newer
> > kernels, but it would be nice to have it working without the filter,
> > too.
> >
> > [1] https://lore.kernel.org/linux-trace-kernel/20230707172155.70873-1-v=
schneid@redhat.com/T/#u
> >
>
> Makes sense, will do.
>

Thanks!

> [truncated]
> >
> > I was thinking that it might make sense to enable the filters also for
> > the trace output instance. On the other hand, it would make it
> > difficult to enable the event without the filter then, as specifying
> > "-e ipi" or similar only re-enables the event but does not remove the
> > filter. Maybe the better idea is to implement an option to filter any
> > event enabled through -e/--event only to the measurement CPU, as a
> > separate feature.
> >
>
> I had actually forgotten about applying the filters for the output
> instance... I'll look into it.
>

Thanks. I gave it some more thought and realized enabling the event
without the filter should not be complicated at all. We can just
remove existing filters in trace_events_enable(), as
trace_events_enable() is called after osnoise_init_trace_tool() in
run_tool(). So that will make an explicit "-e ipi" drop the filter
from "--ipi" on the trace instance and show all IPI events. So you can
disregard my note about filtering -e options, it's not relevant here.

Tomas

