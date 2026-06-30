Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684440B397
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827997; cv=none; b=Qmk04MUFIBcwhRClDOnnoPNkyFg9PTsdx3f8JDnmVuLzcrGQ8TJHqXYQWhk+0TJJwXUwqWlsBzyzlXOm3QVDVWEeJzK96WDDEMGfj70kmswVy2wBzCorLkU3Ulbkv9cofsH74CoJpcTif/LxL+0eKpCBsKENVG3vDT/pHGdfh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827997; c=relaxed/simple;
	bh=0tc3n1T+iP6UtVH2Bcubud4h5kSvkSwkUuQb0E6M6qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XiuifWw0FzDXT4Hq4CRQhQMe4TZI6uB+/ZQFOvDH8L9TQ9aqUkesUwaC7Hjdm0H9UoYAgkqzojvVONl835ItHSPd8BaTWKEmcidtBWiZYQBidvWYGGZ5Ed0nRaqLIOtTq8Qzh7sCoRCChBQMhq76Xi4hu5EfBc8zrD7KlCkpIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bInivByo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bInivByo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782827995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXNz1TXGf+nGNIC0QUsV7H5j6lVbiMDLBDuaqoAEfSs=;
	b=bInivByobPbow8p/IBQh2WCXPKcDv7DLLA2o8ZwyUoTC1DrYwR/mcTGUnkGjMcoCxk3Jk0
	ug82NKyFOTf4dVJeNcjXRarM1UQIvQKMtDA2YIUkMxO0UHFYWjtyV1j0lO3jqzl+kqN0+b
	fvYSAXUJWsGgDN2LdAVXrRxCtLfHYj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-aVrwbsqlPIWSk8X9FTUN8A-1; Tue, 30 Jun 2026 09:59:53 -0400
X-MC-Unique: aVrwbsqlPIWSk8X9FTUN8A-1
X-Mimecast-MFC-AGG-ID: aVrwbsqlPIWSk8X9FTUN8A_1782827992
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4629f312a67so3989414f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827992; x=1783432792;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CXNz1TXGf+nGNIC0QUsV7H5j6lVbiMDLBDuaqoAEfSs=;
        b=CndwO9NdorDKRJWlpfhE4twgc9/I/4fzcLZpt4Uwf6eowSZBC2HcqxJokaA9ccza8T
         vNy2fO8GIQzo7mHAPhgabkEYzkGT0GG6/tdO0qikfKYaqy50DUjuzDqYuYTkFHYs8T1L
         MzmkdyFaubHBFQz8e86I0nzaMF2J9I35tuQdYLpBcyi56vQTjMg79Iz605dqt55PGInc
         36gpR3ofWTCPw7WJZxb20RLsF4tFfwLAYTEblM2gQK44ExE1e9Y8KV+UTDXX5s2+Ire+
         hEO8N7GfesDcCR9VnNtZf0Ll67MLCCJEEQHs9MVzxlqhB3U66RjyMH2z1VzQMMYPTpW8
         9nMw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1+X0jPBJ9Yvp589ZgBhqaLwPZTQ1AiQMB8kQ/L/mWZx4xAng8gBaDb1xSoMz9Kp/ZC3Ssttiov2RPY7s5EnlocS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNwGdgTpH8i32KHh61u/z4STrR1PGzxZgENhi9VDZZpjoHlFj
	Ogtq4wTPLzHrH1ZLCnXnwoSFzDPlMFZha4xFrga7Q+0tFMCYYLVnN4oRFqfOVIPkhIarruU+srO
	2BNVB4yD7AezmFtH9lRFPvZUSTT25alA3h3RNnWwvEhPG60Ht3C2knRChGZ/FglRPEQvKDcVKm4
	C6Nj8uHg==
X-Gm-Gg: AfdE7cmhKSvFfLc0MNlFQrZbC1AvnVrDZqCVNBxA+GgU1NtEwWuaRNYi9Glel9BFJKz
	3uAqVzaoGY2KbsTPEdldv/qo8VfFG5KmsaAYfCHS82L/VHD2GTxsMzKVo/Ds7EqearNYuW97tjU
	v14N15HqTXjP6HmXnNZ4YZLQYqAQpZKxXRITVf1qqcMPTmKKUkg16af0XTQ2zuOqBWWs17/YVMG
	XLqGSuTO+yDxoAiuhUl8pvIbnYpkYX1QZzTWGG0BaeUhEYXmp33zK1dEZ6QZiIGB+wKWuiobblY
	m2mgdiuD9FqsutkOeMbif/vZxYoiHDqzFEXV3foRzd+h+b9h2KJH2qlJ29wY4gj/dfUbxY2zaqX
	8sfj0aGrq1EFZD1di6bvW1Sb8tqqlyhPI9w/qBsx8FCmVIR+A7NSGojX8+ayLCArVdr5vM5xZ
X-Received: by 2002:adf:e009:0:10b0:474:b9d1:3203 with SMTP id ffacd0b85a97d-47657d2db45mr841013f8f.7.1782827992415;
        Tue, 30 Jun 2026 06:59:52 -0700 (PDT)
X-Received: by 2002:adf:e009:0:10b0:474:b9d1:3203 with SMTP id ffacd0b85a97d-47657d2db45mr840981f8f.7.1782827991959;
        Tue, 30 Jun 2026 06:59:51 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756778fac3sm7443270f8f.32.2026.06.30.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:59:51 -0700 (PDT)
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
In-Reply-To: <CAP4=nvQ_x+LyDBoQWOBB4ERy8OwEp9LQzyLJJMHzYdrZzK4zyw@mail.gmail.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
 <20260617131803.2988989-5-vschneid@redhat.com>
 <CAP4=nvQ_x+LyDBoQWOBB4ERy8OwEp9LQzyLJJMHzYdrZzK4zyw@mail.gmail.com>
Date: Tue, 30 Jun 2026 15:59:50 +0200
Message-ID: <xhsmhmrwcw2ll.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OTF_8iuyQRmV2JLDsDBf-RnUEudp6F9A49c49592Q80_1782827992
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30/06/26 12:14, Tomas Glozar wrote:
> st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
> <vschneid@redhat.com> napsal:
>> @@ -406,6 +408,33 @@ struct osnoise_tool *osnoise_init_top(struct common=
_params *params)
>>                 goto out_err;
>>         }
>>
>> +       /*
>> +        * If tracing on a subset of possible CPUs, leverage the kernel =
filtering
>> +        * infrastructure to only generate events on traced CPUs.
>> +        */
>> +       if (params->cpus) {
>> +               char filter[MAX_PATH];
>> +
>> +               snprintf(filter, ARRAY_SIZE(filter), "cpu & CPUS{%s}\n",=
 params->cpus);
>> +               retval =3D tracefs_event_file_write(tool->trace.inst,
>> +                                                 "ipi", "ipi_send_cpu",=
 "filter",
>> +                                                 filter);
>> +               if (retval) {
>
> retval is the number of bytes written here, so this should be "retval
> < 0" like in trace_event_enable_filter() in trace.c. Same below.
>

According to the docstring:

 * Return 0 on success, and -1 on error.

but regardless yes that should be a '< 0' check to match existing code.

>> +                       err_msg("Could not set ipi_send_cpu CPU filter\n=
");
>> +                       goto out_err;
>
> It would be useful to have --ipi work even on older kernels that don't
> yet have your cpumask trace event filter patchset [1], for example, by
> printing a debug message that filtering is disabled and setting a flag
> instead of erroring out here. Then the code in
> osnoise_ipi_cpu_handler() can preserve the CPU_ISSET check if the flag
> is set.
>
> As --ipi is optional, we can choose to only support it on newer
> kernels, but it would be nice to have it working without the filter,
> too.
>
> [1] https://lore.kernel.org/linux-trace-kernel/20230707172155.70873-1-vsc=
hneid@redhat.com/T/#u
>

Makes sense, will do.

>> +               }
>> +
>> +
>> +               snprintf(filter, ARRAY_SIZE(filter), "cpumask & CPUS{%s}=
\n", params->cpus);
>> +               retval =3D tracefs_event_file_write(tool->trace.inst,
>> +                                                 "ipi", "ipi_send_cpuma=
sk", "filter",
>> +                                                 filter);
>> +               if (retval) {
>> +                       err_msg("Could not set ipi_send_cpumask CPU filt=
er\n");
>> +                       goto out_err;
>> +               }
>
> Same two comments above apply here.
>
>> +       }
>> +
>>         tep_register_event_handler(tool->trace.tep, -1, "ipi", "ipi_send=
_cpu",
>>                                    osnoise_ipi_cpu_handler, NULL);
>>
>> --
>> 2.54.0
>>
>
> I was thinking that it might make sense to enable the filters also for
> the trace output instance. On the other hand, it would make it
> difficult to enable the event without the filter then, as specifying
> "-e ipi" or similar only re-enables the event but does not remove the
> filter. Maybe the better idea is to implement an option to filter any
> event enabled through -e/--event only to the measurement CPU, as a
> separate feature.
>

I had actually forgotten about applying the filters for the output
instance... I'll look into it.

> Tomas

