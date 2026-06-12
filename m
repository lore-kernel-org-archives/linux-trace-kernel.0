Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26E331230
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254446; cv=none; b=Npdpa5voF5O076UnNBYjE78R9Yku+IpVOcQml45HgrJr0F5jO8Zy//CTSJq73tdCNe4++eX/N5fVk3o9pxF8Yx8QBePwaVn9i6f6l1GKq7o4rwdzIphani5a9U11u6GACP48GJUArdaBhpO596G/0r1N+g4PQ8s6F2r2cbagU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254446; c=relaxed/simple;
	bh=E3yy8cnJC59xavzVgyOgR/fYd6zP2+wnrE2emvTx6kE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HSHz/mY1KyBGmNkfCvg7y9dvKqi5n+z6kXegIz1dkayLkyy2GcK8vWOudu9KAwzJlCMNO4DVSahjVZ5cf7uFsZbRCKScYPdHJsfASID42ddIYtoXQftwvYPLfYcVy1eyvcj/R9D0EjY+4jnca9kzzMDC+5gym4GkRrstC9tZReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOOaS6FD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOOaS6FD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781254444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6l0W7oSoQQsUySqqQFhvGaI1Ae4Pz0PRvQcuSyUgeQ=;
	b=bOOaS6FDsKXT50ej7ENbZV9zCMZ+YBXKucfj5NAhAdqYa354ryaEHeyY771x8VVSiaaVz3
	UsH9PMML6O/OBxI5fYI5+vKi5ZigQmvLFQSBqJf1dNbcnn/ZGa45oQvhbGRW4OYuSq6/VT
	HonOP4xJA7reguNL9X2yQZvED4JmmmA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-SeNA337lNFqu6P5vaAbUDw-1; Fri, 12 Jun 2026 04:54:03 -0400
X-MC-Unique: SeNA337lNFqu6P5vaAbUDw-1
X-Mimecast-MFC-AGG-ID: SeNA337lNFqu6P5vaAbUDw_1781254442
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460163035e3so430382f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 01:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254442; x=1781859242;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3h3Z17YlU+JUM0dzmHKckOTf08CDPs3EE5yZwLDugEw=;
        b=GTG4tHkYgauZLI0yrNz8OKMLIvQ3i+dfvTMQ+qVXlY7VHxiB6hPiteZrPad66F4LmN
         XsoEBnoG2esPEYCEp+qpVqBSWW0gaDknW9nO6y6UcwQctVUjjGwxLZE12nyHGmJsQqQR
         RhPzJBXcrQRs95wLBWtfmtSyWpWr+KvvjDkpEmWfpOZPzZhJAPfQf/Ds2FI/CUL1hAhP
         OA/WQGUty715d+TmKQ1W6xWlKNQbID9pdLz1JfQtsvQ9A1epDK7ERloMHmxpne68fwbz
         At7uMj7wH7PdhfKmlcgkHFpZzRnk8Dja3qPfyhk/bhx6Br9Qtx6+WCZ3T+P6hQr3weAG
         4TMg==
X-Forwarded-Encrypted: i=1; AFNElJ8laywzd42YNlefv76NmjbvHXAE3VUEiJUq2kjdyVUTkrXhCpKMu/VQM6BuQLI+b+2XwBy0oXgr0lQYzzg6WS9I8RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6LrH9Pvlx0nh8dcA0wLCIOXYF+rNKqR+Nx0aRCA7O+ch08St
	ElP6cLzukKAyMbZ8RTYcAs0+69BdLPw8ohrJWOJmZsnRwi2TEqYaOpQdikK1HWgUqP4ZzV0VuPK
	qhSii/M4sTLQDhYE9iS18T8d0bm96xSK6jVI/bT6tRsSSeLXO/zx9af480eDR3jLylmm0sWjOoQ
	==
X-Gm-Gg: Acq92OHh1Pvmxn/wvn33uALpQmS8urleeUDbyxPnLQso+14IPa16041eWwsGV9izkx9
	u/66MFUtIruFnIzo4g9Nhok204OM8F1h7C+l2M8ztRtiP7XKENb5+C9WBL9AcXY/bu5pgZcNLKN
	E9oUCW+02VpR3GMxThny1PoNtU0DMiDa0d9VVVuqWElviT88n7hcJhNtUgj1n9/ZqvK9LpIjOm9
	/P0ML+5OgCIgEaA+vu6J7BAg69Zl3Va4AxQ3Jc2hyQMNjepor+Kk51PzlDSL1Swh1xBAG/RNMwB
	6lIFnvGSAT+YbGwBXnH2jJSohaxrUMsfvBBwO+4ILZineMinl+WNOsITXLOZPgvNBGoWRHMlVtN
	x73PsWVMjFaU8j58pL7rMwThbnZCf89ol1ZKaJAr6qO2AY5/1UxqzJmMfp79aog==
X-Received: by 2002:a5d:5d0e:0:b0:460:3210:434a with SMTP id ffacd0b85a97d-4606dbc6b71mr2814017f8f.43.1781254441916;
        Fri, 12 Jun 2026 01:54:01 -0700 (PDT)
X-Received: by 2002:a5d:5d0e:0:b0:460:3210:434a with SMTP id ffacd0b85a97d-4606dbc6b71mr2813966f8f.43.1781254441401;
        Fri, 12 Jun 2026 01:54:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a01:cb16:2069:d022:ee80:c854:b3a4:c6d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm3737386f8f.25.2026.06.12.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:54:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
In-Reply-To: <CAP4=nvTOV9jSermE_E_eUh29ks7B9Nv1Nkq1DfvA5nLRv=5hxg@mail.gmail.com>
References: <20260610130457.1304245-1-vschneid@redhat.com>
 <20260610130457.1304245-2-vschneid@redhat.com>
 <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
 <CAP4=nvT6GEdwZAm-2h+Z-mj9DOmJ-swyApujFun6m1Qaxxr7hQ@mail.gmail.com>
 <xhsmh33yt2wtc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAP4=nvTOV9jSermE_E_eUh29ks7B9Nv1Nkq1DfvA5nLRv=5hxg@mail.gmail.com>
Date: Fri, 12 Jun 2026 10:53:58 +0200
Message-ID: <xhsmhzf1016mx.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jE4swtiYUSRPf7UQuBFiGYP4QNMP65RQ0qCxaUu_VHw_1781254442
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/26 13:55, Tomas Glozar wrote:
> =C4=8Dt 11. 6. 2026 v 12:31 odes=C3=ADlatel Valentin Schneider
> <vschneid@redhat.com> napsal:
>> >
>> > Isn't that precisely what the ipi tracepoints used by this
>> > implementation (ipi:ipi_send_cpu) are for?
>> >
>>
>> Well, these catch the emission of the IPI, which is great for investigat=
ion
>> - slap a stacktrace trigger and you (most of the time) get the source of
>> your interference.
>>
>> However Crystal's point is that on x86 (and I assume other archs) receiv=
ing
>> & handling these IPIs is "special" and doesn't go through the generic ir=
q
>> subsystem and thus has to be tracked separately, which is why osnoise ha=
s
>> this fairly lengthy osnoise_arch_register() thing.
>>
>
> Ah, right. This is not IPI specific, though, IIUC - Intel also has
> other IRQs that have to be traced using Intel-specific trace points,
> like irq_vectors:local_timer, which is also handled in
> osnoise_arch_register(). On ARM from what I recall, most (all?) IRQs
> are traced with irq:* tracepoints.
>
> So there are two parts to this:
>
> - Detecting interference from IPIs firing as osnoise:irq_noise (to be
> analyzed by timerlat auto analysis, and also will appear by default in
> trace output if enabled, regardless of the tool, as all osnoise:*
> tracepoints are enabled there). This is done locally using the already
> existing path (no race hazard), but requires arch-specific detection.
>
> - Counting IPIs when they are being sent. This is the new feature, and
> the count is being recorded in osnoise_sample.
>
> I guess that means that if there were a generic IPI interface, it
> would be easier to use that for IPI counting, as the event would be
> CPU-local? As you say, for tracing of the IPI source, the sending
> tracepoints are better, and that you can already dump the stack trace
> of with --event/--trigger. timerlat auto-analysis could be extended to
> connect the specific IPI to the IRQ noise and display its stack trace
> automatically, instead of manually analyzing the trace output.
>

Right, at least for the smp_call stuff (which includes irq_work) we can
leverage:

  csd_queue_cpu (on the sending CPU)
  csd_func_start (on the receiving CPU)

by indexing on the @csd address; once upon a time [1] I had this:

  $ echo 'hist:keys=3Dcpu,csd.hex:ts=3Dcommon_timestamp.usecs:src=3Dcommon_=
cpu' >\
       /sys/kernel/tracing/events/csd/csd_queue_cpu/trigger
  $ echo 'csd_latency unsigned int src_cpu; '\
       'unsigned int dst_cpu; '\
       'unsigned long csd; u64 time' >\
       /sys/kernel/tracing/synthetic_events

  $ echo 'hist:keys=3Dcommon_cpu,csd.hex:
  time=3Dcommon_timestamp.usecs-$ts:
  onmatch(csd.csd_queue_cpu).trace(csd_latency,$src,common_cpu,csd,$time)' =
>\
       /sys/kernel/tracing/events/csd/csd_function_entry/trigger

  $ trace-cmd record -e 'synthetic:csd_latency' hackbench
  $ trace-cmd report
  <idle>-0     [001]   115.236810: csd_latency:          src_cpu=3D7, dst_c=
pu=3D1, csd=3D18446612682588476192, time=3D134
  <idle>-0     [000]   115.240676: csd_latency:          src_cpu=3D7, dst_c=
pu=3D0, csd=3D18446612682588214048, time=3D103
  <idle>-0     [009]   115.241320: csd_latency:          src_cpu=3D7, dst_c=
pu=3D9, csd=3D18446612682143963384, time=3D83
  <idle>-0     [007]   115.242817: csd_latency:          src_cpu=3D8, dst_c=
pu=3D7, csd=3D18446612682150759032, time=3D93
  <idle>-0     [005]   115.247802: csd_latency:          src_cpu=3D7, dst_c=
pu=3D5, csd=3D18446612682144441144, time=3D114
  <idle>-0     [005]   115.271775: csd_latency:          src_cpu=3D7, dst_c=
pu=3D5, csd=3D18446612682144441144, time=3D151
  <idle>-0     [000]   115.279620: csd_latency:          src_cpu=3D7, dst_c=
pu=3D0, csd=3D18446612682588214048, time=3D87
  <idle>-0     [000]   115.281727: csd_latency:          src_cpu=3D7, dst_c=
pu=3D0, csd=3D18446612682588214048, time=3D101

[1]: https://lore.kernel.org/lkml/xhsmh4jn8y8vt.mognet@vschneid.remote.csb/

I believe you're right that leveraging this would be useful for
timerlat-aa; I'll add it to my todolist :-)

>> >> Isn't this racy to do from a different CPU?  Both in terms of the
>> >> counter, and the timing of the increment relative to when the IPI is
>> >> actually received.  Not necessarily a huge deal if you only care abou=
t
>> >> zero versus bignum, but still.  At least worth a comment, if we go wi=
th
>> >> this approach.
>> >>
>> >
>> > I also think it's a bit confusing, especially as the other accesses to
>> > osn_var are cpu-local, but here, "cpu" is the *target* CPU, not the
>> > current CPU. Not sure how expensive it would be to do atomic_add for
>> > that, at least it's something to consider.
>> >
>>
>> I suppose that could be an argument for doing that stat aggregation in
>> userspace osnoise - event handlers are run after the fact via
>> tracefs_iterate_raw_events(), it's all inherently slower since it's just
>> increments of one (one per handled event) but it's also all done in
>> userspace on a control thread and doesn't bog down the kernelspace.
>>
>
> You can also do per-cpu counters in-kernel and sum them in the end,
> but that would take cpus^2 space (indexed by [current_cpu,
> target_cpu]). The question is whether there could be enough samples to
> overload sample collection (like it happens for timerlat, which
> collects data in-kernel using BPF instead).
>
> In-kernel counting can be tested with " --event ipi:ipi_send_cpu
> --trigger hist:key=3Dcpu" - IIRC, tracefs histograms use atomic
> operations (via tracing_map) to protect the entries from races in
> multi thread access. Of course, that is inferior to what the patchset
> implements, as it doesn't record which osnoise cycle the IPI was sent
> in, nor can record cpumask IPIs.
>

I suppose I'll need to go do some benchmarking, but I'm starting to lean
towards the side of atomic incs for IPI counts being okay considering the
sort of latencies we track.

>
> Tomas

