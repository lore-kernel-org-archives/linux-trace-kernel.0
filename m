Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25A3B83FB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890763; cv=none; b=Shy2L/1rx7uibv2/vREmK6rzGh8gpCppPEJ7v9drvd5qZRAlpFOF/+R4577e0Q3e4HtmdhZdwGmYZSFEYP8KQWjB4iZrvbiODwpYOTOECui1jagL0SucSz4imeU45b0EXoZSMZ3RCqXG3NDubLFK8BqXpwRVTU+xcEgSQHu3K58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890763; c=relaxed/simple;
	bh=fh9cVKHSPq4zHtIi72Vg5I9J/McLdcnJbUN/Exmbo2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1FUMWgY1oZqVAVMEVy9yIxF5hI+jpNh7bttYx44+AelPWPLc902kklx0XICZSy7lJW6m+XDYhMfwF+dsG1k5Qj14lyabizOjsmYoq5Lw884dTsL/kC4ZPauvRBYj3+GJryA5cCh4Ol1i1jiUqi2OrtguR7gQmLJAHV2IrxuMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDXeYLkj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDXeYLkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782890761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+F87vgJy7DBZttulQHhqfGaMmavVnClUfiQw/28wgo=;
	b=PDXeYLkjbtQxawrBLXHyeu5ZEhBfsSPizBb5VTcAjMZQpGe9sd1uaG8qT1hR73G3q4JHZ4
	J9IF4c0hAGrM39r9KE61tLds+cxPOzAKqJJ6WcNYPR0EVX5nS1nIYSYF6893iRnx74LlZ2
	0eeeVhGjDbT0cJIgmUTL10gjZt2EDcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-i8D5B-cgOJOyWxKCo6VAgA-1; Wed, 01 Jul 2026 03:25:58 -0400
X-MC-Unique: i8D5B-cgOJOyWxKCo6VAgA-1
X-Mimecast-MFC-AGG-ID: i8D5B-cgOJOyWxKCo6VAgA_1782890757
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso2804825e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 00:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782890757; x=1783495557;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TYs40YWx82AKNvneShCKwgmMlMyJXKWY7H77xkrO5kk=;
        b=NA1AsByLTutFoPszuqONVh16lUDWTvY+TDsKaoFwSYfLFkjmVoNbrZf0bDiVPn6OO6
         7R9hB0rwZpwIfhJhOHs7Ww3vyEtoPfpApRutXPYy/CXeO48+YAIw7vr7UTpH4loywyzc
         UupaVE1jMDU7/68fXCnTw78p6OTugIOA5z0my209a1Mcq3m7f3AwwzP3VNMdCCTV0FaM
         20x/JSDBAjqyM7cD3S8DN9wkyEUuyaQFIYJO74d5bR1RHEb9vClvp4V4kVpidWeCIR+l
         8eTIktN2vhgfB5psK6PsLlhaThdpy5xkWYu/y+tvFW677bjg0K7Al1wnsQMKITFspUGL
         ULfA==
X-Forwarded-Encrypted: i=1; AFNElJ+A6GPsmslXhQ9/oFk8WDllnrHKQqKkQKDTFcePx7xwnWVBy0FG2XtdMNhcrVVuvkQ075lOV9KVsjXYrYZrWo1IImI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6YqV5nN5ExM8mYPI6Uwtc5sIe9lKln3Q6+RTkdjYeUNLRlcJ
	OhwmlRQxOKhrEGo2Utk5L5iQQQCv64pC1Ayv2qLM31bOTqb1wmLPXl7aSdxpVJ8dVAr/37FQ7QD
	dxTzhiD7DXe9fCJsSU7ubZgu0oKwxU6yqXV/mk6x/Dnw35jGsaZBmIDrbtJK0aTtoGgTe0u22Vg
	==
X-Gm-Gg: AfdE7cmlMTpHVUtbDkBUJV145+Q6mTI+NGxJQ/RU40p7j+JZz+zZ/BspECPE/8K3z1k
	297gE2JlatBiIUM9UMM1iPrJYgTKAqmQywqzMv9qfAeWxSXMeeBxWhc4gDjuT7h3i63WArACgTz
	9/KXlsxnUq9vwJWpqUlqErH8ZWSTY7CEMnLjybGvSgpcdy4Um1bPS/3z/t29XYsUSpymEDAxwpv
	eYMWwQKWJWkxGtZ+git8I4zA9/XgyhoWglz7bP0OvhsIzUGSvHKFH5jWUIRblmTbCJfIY7I0iQH
	mE3vr6unq20wQcupaEliuHrH3m9eFvjn6j8i00S/d3h6RQq5Z/PaVxRei4TSVwlgeVDHL7r4V/k
	nxDkj+0ErRRTEcZqXGMD3Ic4nFDn9OfnzaLBbneqZZD20TFCbKF9atty4KsWyMBKXk9PBXiP0
X-Received: by 2002:a7b:cb06:0:b0:493:a5f9:d33d with SMTP id 5b1f17b1804b1-493c2b84c1fmr4344985e9.18.1782890756674;
        Wed, 01 Jul 2026 00:25:56 -0700 (PDT)
X-Received: by 2002:a7b:cb06:0:b0:493:a5f9:d33d with SMTP id 5b1f17b1804b1-493c2b84c1fmr4344625e9.18.1782890756199;
        Wed, 01 Jul 2026 00:25:56 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be81df2asm97709125e9.12.2026.07.01.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:25:55 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 4/4] rtla/osnoise: Leverage IPI event filters
 when tracing a subset of CPUs
In-Reply-To: <CAP4=nvT5H73ptaBaZ2fWQ+SjJ-c3eEGZbrSefMV6fxqL-va2XA@mail.gmail.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
 <20260617131803.2988989-5-vschneid@redhat.com>
 <CAP4=nvQ_x+LyDBoQWOBB4ERy8OwEp9LQzyLJJMHzYdrZzK4zyw@mail.gmail.com>
 <xhsmhmrwcw2ll.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAP4=nvT5H73ptaBaZ2fWQ+SjJ-c3eEGZbrSefMV6fxqL-va2XA@mail.gmail.com>
Date: Wed, 01 Jul 2026 09:25:54 +0200
Message-ID: <xhsmhjyrfw4ql.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AjVkqWEOpIDVEoW9HAbBAK2LwFoseCOe8XUOT1hOaJs_1782890757
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/07/26 08:45, Tomas Glozar wrote:
> =C3=BAt 30. 6. 2026 v 16:00 odes=C3=ADlatel Valentin Schneider
> <vschneid@redhat.com> napsal:
>>
>> On 30/06/26 12:14, Tomas Glozar wrote:
>> > st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
>> > <vschneid@redhat.com> napsal:
>> >> @@ -406,6 +408,33 @@ struct osnoise_tool *osnoise_init_top(struct com=
mon_params *params)
>> >>                 goto out_err;
>> >>         }
>> >>
>> >> +       /*
>> >> +        * If tracing on a subset of possible CPUs, leverage the kern=
el filtering
>> >> +        * infrastructure to only generate events on traced CPUs.
>> >> +        */
>> >> +       if (params->cpus) {
>> >> +               char filter[MAX_PATH];
>> >> +
>> >> +               snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\=
n", params->cpus);
>> >> +               retval =3D tracefs_event_file_write(tool->trace.inst,
>> >> +                                                 "ipi", "ipi_send_cp=
u", "filter",
>> >> +                                                 filter);
>> >> +               if (retval) {
>> >
>> > retval is the number of bytes written here, so this should be "retval
>> > < 0" like in trace_event_enable_filter() in trace.c. Same below.
>> >
>>
>> According to the docstring:
>>
>>  * Return 0 on success, and -1 on error.
>>
>> but regardless yes that should be a '< 0' check to match existing code.
>>
>
> I double-checked that and you are correct that the docstring says so,
> but it's an error in the docstring. According to the manpage, it
> returns the number of bytes written (i.e. positive on success, not
> zero) [1]:
>
> "RETURN VALUE
> ...
> tracefs_event_file_write() and tracefs_event_file_append() returns
> *the number of bytes written to the system/event file* or negative on
> error."
>
> The code agrees as well: in tracefs_event_file_write() there's the
> wrong docstring (likely copied from another function) [2]:
>
> /*
>  * tracefs_event_file_write - write to an event file
>  * ...
>  * Return 0 on success, and -1 on error.
>  */
> int tracefs_event_file_write(struct tracefs_instance *instance,
>     const char *system, const char *event,
>     const char *file, const char *str)
> {
>         ....
>         ret =3D tracefs_instance_file_write(instance, path, str);
>         free(path);
>         return ret;
> }
>
> but the source of the return value is tracefs_instance_file_write(),
> where the docstring is correct [3]:
>
> /**
>  * tracefs_instance_file_write - Write in trace file of specific instance=
.
>  * ...
>  * Returns the number of written bytes, or -1 in case of an error
>  */
> int tracefs_instance_file_write(struct tracefs_instance *instance,
> const char *file, const char *str)
> {
>         return instance_file_write(instance, file, str, O_WRONLY | O_TRUN=
C);
> }
>
> instance_file_write() gets the return value from write_file() [4]
> which returns the return value of write() [5].
>
> [1] https://man7.org/linux/man-pages/man3/tracefs_event_get_file.3.html
> [2] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/=
tracefs-events.c#n686
> [3] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/=
tracefs-instance.c#n532
> [4] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/=
tracefs-instance.c#n514
> [5] https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/=
tracefs-instance.c#n496
>
> So the "< 0" is required, the CPU filter doesn't work without it:
>
> [tglozar@fedora rtla]$ uname -a
> Linux fedora 7.0.12-101.fc43.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jun 11
> 01:32:26 UTC 2026 x86_64 GNU/Linux
> [tglozar@fedora rtla]$ sudo ./rtla osnoise top -q -c 0 --ipi
> Could not set ipi_send_cpu CPU filter, return value: 14
> Could not init osnoise tool
> [tglozar@fedora rtla]$ sudo ./rtla osnoise top -q -d 5s --ipi
>                                          Operating System Noise
> ...
> [tglozar@fedora rtla]$
>
> (output with additional debug print)
>

Darnit, you're right! I'm surprised I didn't catch this while
testing. Thanks!

>> >> +                       err_msg("Could not set ipi_send_cpu CPU filte=
r\n");
>> >> +                       goto out_err;
>> >
>> > It would be useful to have --ipi work even on older kernels that don't
>> > yet have your cpumask trace event filter patchset [1], for example, by
>> > printing a debug message that filtering is disabled and setting a flag
>> > instead of erroring out here. Then the code in
>> > osnoise_ipi_cpu_handler() can preserve the CPU_ISSET check if the flag
>> > is set.
>> >
>> > As --ipi is optional, we can choose to only support it on newer
>> > kernels, but it would be nice to have it working without the filter,
>> > too.
>> >
>> > [1] https://lore.kernel.org/linux-trace-kernel/20230707172155.70873-1-=
vschneid@redhat.com/T/#u
>> >
>>
>> Makes sense, will do.
>>
>
> Thanks!
>
>> [truncated]
>> >
>> > I was thinking that it might make sense to enable the filters also for
>> > the trace output instance. On the other hand, it would make it
>> > difficult to enable the event without the filter then, as specifying
>> > "-e ipi" or similar only re-enables the event but does not remove the
>> > filter. Maybe the better idea is to implement an option to filter any
>> > event enabled through -e/--event only to the measurement CPU, as a
>> > separate feature.
>> >
>>
>> I had actually forgotten about applying the filters for the output
>> instance... I'll look into it.
>>
>
> Thanks. I gave it some more thought and realized enabling the event
> without the filter should not be complicated at all. We can just
> remove existing filters in trace_events_enable(), as
> trace_events_enable() is called after osnoise_init_trace_tool() in
> run_tool(). So that will make an explicit "-e ipi" drop the filter
> from "--ipi" on the trace instance and show all IPI events. So you can
> disregard my note about filtering -e options, it's not relevant here.
>

That makes sense, that's the most intuitive option.

> Tomas

