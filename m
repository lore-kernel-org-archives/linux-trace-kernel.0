Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4C3C8705
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173298; cv=none; b=VPdT2FAklbupd8moHmpomWdHjWxgXAcmgD99gVulN9PH6oNqYwok/MJVIq6b41lX9/w+YcT9NqgzDR37S5cf1zGuV13tA/nhQ3zBgCMWgefwSUJhEcyzXcWtlCoLoOLDCI7GCjFeugLZjSoHilLtly1ewOaMpcK6Cg0bpXPqik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173298; c=relaxed/simple;
	bh=KxujICApJct0ddBnV8QYo0692bUdsnXtmZmanpZU8u8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F6vcZ2J7vWEwJyhA9HZfyUkbQ+b+iDnYBFSLlJuivLT6cpYp8pNCyqD2PIJU5WK/OT53iaRP0gHeLQ9wyWtNm5zTVv99F2sxu+m0IDKup71/4bui8I7eOGeDJRV2PaZBsQ8ewrbrK7MHuHYmHecIxz3kIvbui3HczSnXd/yh9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZjTR0bN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZjTR0bN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781173295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Be6DaheHjENBxcZUlCpyDT73aU4MAUcxC97l0DHHuuw=;
	b=cZjTR0bNnBMoH45IYEXAz7q7awt6UBmvRCfuUO53ijvGGKA9oX2Wxpr9oKBxOhB5CzJdLL
	IElBd+ybqFOZNg6kLcQk5xb/ZBH80EKWQ7Jp4ZEIwmflPv09VcMi+sHrYMoi8X87Ke+TO9
	q4k0ZNk4RYAZT+iY0LFwG+bglVF4n0U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-SCMfdTZVNQGUPFee6BYTxg-1; Thu, 11 Jun 2026 06:21:34 -0400
X-MC-Unique: SCMfdTZVNQGUPFee6BYTxg-1
X-Mimecast-MFC-AGG-ID: SCMfdTZVNQGUPFee6BYTxg_1781173293
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae016853so14426355e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 03:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173293; x=1781778093;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be6DaheHjENBxcZUlCpyDT73aU4MAUcxC97l0DHHuuw=;
        b=QQ6pUCv+FrHkb3aax1gzwdPvZWQ/B/EwP5dY/2CgDa2lDbtjYFdNN0bVyrVZuOQp2a
         X9PNHOTfq/WAkiB/prCbGEoHbU0v9JAfu6UuFswuhMzJOykmI0QDJCIudGA9XrZxpEtA
         oMUSZyW/EoKiBP2qYkkH14b2cbRtq8kYl+HZ7XQ4d1Fyn/ZigoX9zHr84X2+Jso6xEp3
         7UweNFtc56D1iv4Np8XPBKheTqvUPnEGaEeRFWccXIy6kucYI4I0IDQa6TBXCWIAoBkB
         bRRxEyHjyZR1JAxmYGKOtaQW90KanT7QWFrTRIY0u99hVIritIXSkALhlRkjisJubQyr
         OfNA==
X-Forwarded-Encrypted: i=1; AFNElJ9pAMjKKsMZ8tadkXAwYYoRwQmqUNVkt6QvGlGNdZAxfe7Dwm7xz6GfNCAQFfiCsuqLoy4kq60FJ94Ytd+6x2mVSJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGNKh5o1fpIYaBeIjd4Gb4wViHMSn+kY97C4YRBUooMw6pvkX
	gBvpxWJAn7Vx+YJIkX6SBMrih+dA+NEC6nylqi9zsKGoFQVIMqrlEEXwxZ1XJIetTOHndrigYCM
	K+GDqMOwm5/TP9DeKo5PBfOtIKEHzqmzmxZFFISv954DVKjNL0SPHnZiJswenCLLkaalObErpWQ
	==
X-Gm-Gg: Acq92OH7wQOlQf7UEdRO7qyvOIOlHVynYs2TWOjSjtxWaQSAaa7lB3vtEwjjyN6wLQW
	fdJTFD8geRYgITRRhc8IEv1/dPORlaFwHtZlt64GhNlvTqHoF0PGCsRUPGRoBfoQLVfm0Hf9Mew
	NwCeKalPN8IZS5sd2KhsJ+QGkw3uLOnueMIBvYIDJNFqjczSqmz6wzBwedxacc6rBSF3kdy85vE
	hrdAdyRgyYC6uTNazwaH8SqLsYToLkGGBrq9+yTmZMDbERluGLQ8LPefGDtHernpfVZjXljcYi8
	nG14tcTc8Kxb35J80xY//j8GSbv6//xr3rcDiRe8vkUeu2lKh/mW1Hmxs2P7deTs2u6Va7W0f3+
	f3KyxaRBa8hCqyRQETHiHR/LBDi42bTMd/3unOw/vEKtatefQS/D5COb9/Kyy0ffJrXXJ87f5zu
	M53/xpMd3kkuPkU2vGiA==
X-Received: by 2002:a05:600c:c8a:b0:490:b072:1be6 with SMTP id 5b1f17b1804b1-490e5639bffmr27420765e9.25.1781173293196;
        Thu, 11 Jun 2026 03:21:33 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:490:b072:1be6 with SMTP id 5b1f17b1804b1-490e5639bffmr27420275e9.25.1781173292813;
        Thu, 11 Jun 2026 03:21:32 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ea21sm54190235e9.1.2026.06.11.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:21:31 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Crystal Wood <crwood@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
In-Reply-To: <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
References: <20260610130457.1304245-1-vschneid@redhat.com>
 <20260610130457.1304245-2-vschneid@redhat.com>
 <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
Date: Thu, 11 Jun 2026 12:21:30 +0200
Message-ID: <xhsmh5x3p2x91.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: slwxSKF_WcUl8sCy_Yfteevw9OGY18WQ_LL4I3zXGlg_1781173293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 10/06/26 14:51, Crystal Wood wrote:
> On Wed, 2026-06-10 at 15:04 +0200, Valentin Schneider wrote:
>> Osnoise already implictly accounts IPIs via its IRQ tracking,
>
> Does it?  It seems that IPIs bypass the kernel/irq subsystem on some
> arches (including x86, but not ARM).
>

Right...

> It would be nice to solve this properly by adding generic ipi
> entry/exit tracing (similar to what ARM already has).
>

I think for x86 the CSD tracepoints catch a few of these strays - I think
the smp_call ones for instance.

>> however it
>> can be interesting to distiguish between the two: undesired IPIs usually
>> imply a software configuration issue (e.g. wrong/incomplete CPU isolation)
>> whereas undesired (non-IPI) IRQs usually imply a hardware configuration
>> issue.
>> 
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>> Note that this is modifying the osnoise:osnoise_entry Ftrace entry; I know
>> trace events are sort of supposed to be stable, but I'm not sure about
>> ftrace entries.
>
> I think old rtla will be OK with this since it looks up fields by name
> rather than assuming a fixed layout.
>
>> Alternatively I can have this be purely supported in userspace osnoise by
>> hooking into the IPI events and counting IPIs separately from the osnoise
>> events.
>
> One benefit I could see of doing this in kernel osnoise would be if you
> could atomically correlate the count with the particular noise
> interval, but this patch doesn't do that.
>
>> +static void ipi_emission(struct osnoise_variables *osn_var, unsigned int dst_cpu)
>> +{
>> +	if (!osn_var->sampling)
>> +		return;
>> +
>> +	osn_var->ipi.count++;
>> +}
>> +
>> +static void trace_ipi_send_cpu_callback(void *data, unsigned int cpu,
>> +					unsigned long callsite, void *callback)
>> +{
>> +	struct osnoise_variables *osn_var;
>> +
>> +	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
>> +	ipi_emission(osn_var, cpu);
>> +}
>> +
>> +static void trace_ipi_send_cpumask_callback(void *data, const struct cpumask *cpumask,
>> +					    unsigned long callsite, void *callback)
>> +{
>> +	struct osnoise_variables *osn_var;
>> +	int cpu;
>> +
>> +	for_each_cpu_and(cpu, cpumask, &osnoise_cpumask) {
>> +		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
>> +		ipi_emission(osn_var, cpu);
>> +	}
>> +}
>
> Isn't this racy to do from a different CPU?  Both in terms of the
> counter, and the timing of the increment relative to when the IPI is
> actually received.  Not necessarily a huge deal if you only care about
> zero versus bignum, but still.  At least worth a comment, if we go with
> this approach.
>

Yes on both points :-) Let me see what Tomas has to say on that...

> -Crystal

