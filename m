Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DB3CFF5A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173863; cv=none; b=b1efXsiYPcfSC9+u7l7xeaUCElbJOU1scicuyilwkWlGhsBta+3eCBLVtspAe2NBn/oegBFMMtT2h/id/2UXDWNOyRAQa3NIudAHv8MJp4b7V+0Wyv88OvlO+U+01/ONlDJ1eA/k05araTCbMR5q9PBF4xCvAJybcfFNBSOgNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173863; c=relaxed/simple;
	bh=UbVW6ggehIpgX/GchyYfvdiFEIE6BSAdT89W6ZiFe7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6/mrBPA8sxbIHWKhk2yzjt+LJL2Ra4aSmW9cm6hul70t8AMrSRUByu+NDDZBDL5bj5pLPXjUgWAs+MDYgZjctksswMCE16wJuwevbZOinkVdxNhvVj9vh06ZfdAcBO4a3oxYBR0nL3zeWPyvMmNFXeTs5/w5Gx/qvOACYHHmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAYhI5eI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAYhI5eI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781173860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nu5DulhRD5GvjFL2dL285B18ikNF4YHRoNMOTNczkjw=;
	b=PAYhI5eIBPDA83efo2GfkLNrBkFypBJkRWfbSkHbBfCoGifZqc0B7Ime5ZsRFryC5D4QPI
	xRO9DB1cijNRF1NIHSkVLxiti28HfX1/5guBNTdjnEp7RfIciKo6eT8xLJsvlKDkOuhHL2
	Jae4ta2vOz48vecS8uQqDnjKB45XT0Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-gmObJjUoOkuzZT90W9estQ-1; Thu, 11 Jun 2026 06:30:59 -0400
X-MC-Unique: gmObJjUoOkuzZT90W9estQ-1
X-Mimecast-MFC-AGG-ID: gmObJjUoOkuzZT90W9estQ_1781173858
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490c840efe6so6609475e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 03:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173858; x=1781778658;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V8uctc9+aAOAb1j01brzPJHvMVOuj0goYp0HtlmUdJ0=;
        b=q2OudM073dwezdeZFn8oKMhRH7OVKKS/jB5liYSPVxbB53jPA0tLmbtWsDK6lDoNJq
         HIginV4/l/xx2lvceWEOga45KamAxRS5KKuVdZEgkkvCr+tyXznw2wmh1pObK86Hz545
         6OsGOZ2kkip+5Pm9iNGYFS+CRO4wONS7lpzJd+IwrcOb8T9JG/AfIjBrS9IWRDgD0qDi
         CEe0Pplgf242ePuo+9A7OCN3JG7Il4r2TeJhC/uZQwYpoEktNRSsziT++7soLOMhUzj9
         LpBra7lRGKlZB2TxiuJler0XAF2+EcyY8Nc8G9PAAKpjgksTJAy8kJ+y1waSJt/9LQw4
         qJJg==
X-Forwarded-Encrypted: i=1; AFNElJ/4S3bjN1dQA3WWGw/ZFtMrFPKHwMZChFMJHclwxN6cAyEvl6Q4jow/HMM8fmuPdHRP9HZIDvA8Foy5Ho5pmBbjJhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5nA8TmISxF1S52cCqA4N9oTwMCW49Gj7CRth4v3hCmn1+peY
	6PfW4QdeESpabPA638aDnd6WeDzBJj7Zg2QS+jlF8lBAFd0UTYvTicgsJCGKSsgjUPRECTPcapI
	GEHf/+QObpLFFAYmEm6zwu2zc1qY5pQQV2wnG87JEJaUTf/MR+O6ymWKOseQmxjzkd+22v8eP4g
	==
X-Gm-Gg: Acq92OECYMDQYScH9TjMhs3mvKtvlzp4QeCJCkp/p6lW/JjD5vBUbFsfkA0G50ufTCo
	Iy2SHzZL/Y7b6TU9D0ZSXBvd3VbpN8/XoWiu0V6ji1CPPREn8fS9jAARNROZAEyFRM4pc7laL07
	LhQ/pSHF9EYYRV1k+sZHJLJDN0YNNgA9P6kcHcg1n+K+DEFkgbM5emTr7cpMHN1bF0do/TIxSP0
	/dDCAmlObhlK69q8PmDmksimC/cRBRGfHK5HC2OAV10OiW+ea0O6qewfrib6CKBbK0hAtt/u7Vk
	0ASWWBnLmezt6twdq9ItXMFKxY1ZlG49nhTuFFcD1/JLjJIZWbPt+5X5PVhwPHrUiSRQPbDgjkg
	EM7fA6TfxYiRoidMbiWneDJ7eMiBCbFG+09yIiWQbYIwRWyjcPqmQYXBpJAGV1Z72MNTWoSEEHn
	PUsnB0D1dXjL7IsYP0YQ==
X-Received: by 2002:a05:600d:8444:20b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490e52dfc5emr16161685e9.8.1781173857861;
        Thu, 11 Jun 2026 03:30:57 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490e52dfc5emr16161405e9.8.1781173857304;
        Thu, 11 Jun 2026 03:30:57 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c0d360sm63347395e9.0.2026.06.11.03.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:30:56 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
In-Reply-To: <CAP4=nvT6GEdwZAm-2h+Z-mj9DOmJ-swyApujFun6m1Qaxxr7hQ@mail.gmail.com>
References: <20260610130457.1304245-1-vschneid@redhat.com>
 <20260610130457.1304245-2-vschneid@redhat.com>
 <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
 <CAP4=nvT6GEdwZAm-2h+Z-mj9DOmJ-swyApujFun6m1Qaxxr7hQ@mail.gmail.com>
Date: Thu, 11 Jun 2026 12:30:55 +0200
Message-ID: <xhsmh33yt2wtc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WsLuLh_cctlVgpPgOniyRKwNr7vmVQ6RY-x3NTfqaLY_1781173858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/26 10:59, Tomas Glozar wrote:
> [just replying to comments, will do a full review later]
>
> st 10. 6. 2026 v 21:51 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> n=
apsal:
>>
>> On Wed, 2026-06-10 at 15:04 +0200, Valentin Schneider wrote:
>> > Osnoise already implictly accounts IPIs via its IRQ tracking,
>>
>> Does it?  It seems that IPIs bypass the kernel/irq subsystem on some
>> arches (including x86, but not ARM).
>>
>> It would be nice to solve this properly by adding generic ipi
>> entry/exit tracing (similar to what ARM already has).
>>
>
> Isn't that precisely what the ipi tracepoints used by this
> implementation (ipi:ipi_send_cpu) are for?
>

Well, these catch the emission of the IPI, which is great for investigation
- slap a stacktrace trigger and you (most of the time) get the source of
your interference.

However Crystal's point is that on x86 (and I assume other archs) receiving
& handling these IPIs is "special" and doesn't go through the generic irq
subsystem and thus has to be tracked separately, which is why osnoise has
this fairly lengthy osnoise_arch_register() thing.

>> > however it
>> > can be interesting to distiguish between the two: undesired IPIs usual=
ly
>> > imply a software configuration issue (e.g. wrong/incomplete CPU isolat=
ion)
>> > whereas undesired (non-IPI) IRQs usually imply a hardware configuratio=
n
>> > issue.
>> >
>> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> > ---
>> > Note that this is modifying the osnoise:osnoise_entry Ftrace entry; I =
know
>> > trace events are sort of supposed to be stable, but I'm not sure about
>> > ftrace entries.
>>
>> I think old rtla will be OK with this since it looks up fields by name
>> rather than assuming a fixed layout.
>>
>
> Yeah, the fields are either looked up with tep_get_field_val() [2], or
> with name-based BPF CO-RE relocations against the tracepoint structure
> [3]. So this shouldn't be an issue, as long as the old counts stay the
> same.
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/tools/tracing/rtla/src/timerlat_hist.c#n191
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/t=
ree/tools/tracing/rtla/src/timerlat.bpf.c#n12
>
>> > Alternatively I can have this be purely supported in userspace osnoise=
 by
>> > hooking into the IPI events and counting IPIs separately from the osno=
ise
>> > events.
>>
>> One benefit I could see of doing this in kernel osnoise would be if you
>> could atomically correlate the count with the particular noise
>> interval, but this patch doesn't do that.
>>
>
> The count is already reported by cycle on the kernel side in the
> patchset, right? It's only missing in the current RTLA (userspace)
> part, as there is no statistic using the information. But it can still
> be collected through custom histogram triggers.
>
>> > ...
>> >
>> > +static void trace_ipi_send_cpumask_callback(void *data, const struct =
cpumask *cpumask,
>> > +                                         unsigned long callsite, void=
 *callback)
>> > +{
>> > +     struct osnoise_variables *osn_var;
>> > +     int cpu;
>> > +
>> > +     for_each_cpu_and(cpu, cpumask, &osnoise_cpumask) {
>> > +             osn_var =3D per_cpu_ptr(&per_cpu_osnoise_var, cpu);
>> > +             ipi_emission(osn_var, cpu);
>> > +     }
>> > +}
>>
>> Isn't this racy to do from a different CPU?  Both in terms of the
>> counter, and the timing of the increment relative to when the IPI is
>> actually received.  Not necessarily a huge deal if you only care about
>> zero versus bignum, but still.  At least worth a comment, if we go with
>> this approach.
>>
>
> I also think it's a bit confusing, especially as the other accesses to
> osn_var are cpu-local, but here, "cpu" is the *target* CPU, not the
> current CPU. Not sure how expensive it would be to do atomic_add for
> that, at least it's something to consider.
>

I suppose that could be an argument for doing that stat aggregation in
userspace osnoise - event handlers are run after the fact via
tracefs_iterate_raw_events(), it's all inherently slower since it's just
increments of one (one per handled event) but it's also all done in
userspace on a control thread and doesn't bog down the kernelspace.

> Tomas

