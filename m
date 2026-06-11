Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0773BED74
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178974; cv=none; b=LlQDq4DONDAphR9RilgCULCAwPg+I2rjIkwyhH5+w3x9VfgeTONTiIwF3saLXczUVTPGtxgeMO3lTnRu5PFvbA8cHyreXDP9iI97DSq5TBBDD6XkOXJ7Q0+ny6+xOk7fN1RJFmL8acDN5FndcbGC0vjR1rSNxkDWIyGT/dVp/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178974; c=relaxed/simple;
	bh=L2z+PirgjC5x6WF9mnaVm9hou1fpSzfaxuGULVWA+qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO02+ZnEKPMp7NXyDGxHY2xlTkln0Us4izC2Sd77odwbbTLU5Ik/kC3YAQQ59QYVqso5eS911pddtCvoJuPmzHKQgpRQ2pj5MxTziRMC+H75njluYuDVF5WXLych2LY5xxTOKx5x+I1I69t+W4EBbzcCQw9hFBEsMU7N2Z/tk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAwZPCii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAwZPCii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781178972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Er75cDt/X24VOa/k+u3WXUGAH/NOcpP/S3KwaEedSOY=;
	b=PAwZPCii1kYU1RA/ZHdZVvIo9vXFCm+4TIVqnpVlAO5OWgc9fCSMxo7oIyldEQbgEOTyZo
	XDNLOWtkYofvx1tb8BrBEAxTloV+ak8jjDoDB5c9JCSXpzUwJIc4sr3e+xRczo3AHiSJV/
	ugrPml0O3hrRcHf+8lctQ27GgTTRwTM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-X-tTTBiCM2mLmSvn9YdkyQ-1; Thu, 11 Jun 2026 07:56:11 -0400
X-MC-Unique: X-tTTBiCM2mLmSvn9YdkyQ-1
X-Mimecast-MFC-AGG-ID: X-tTTBiCM2mLmSvn9YdkyQ_1781178970
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-68bc68bc910so922888a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 04:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178970; x=1781783770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Er75cDt/X24VOa/k+u3WXUGAH/NOcpP/S3KwaEedSOY=;
        b=GVx5YoMegXnOHoaVkfPz2MAnTw9mGoRUz57Sz+ItU+1vhcsOuaV9XWCRpfRem5TZLb
         R5XBz3pVpTK1gmF2K5D5BtRpi31BJqS5x9ITf8IGSaQZKblfMzViGTQqVKbIjvoaQHCW
         kH30txKX5qqgdmlWA4UL3wjwFjGKNUMGvq1OuAHr98bgwddhpNN7ZDKkkyU5lQfs1VOM
         jeo2bOE+ZRrF8430FY9E/1mLbEGz49FhxldxTfrLVhq+Yx6Lk6q2WBfJ8Mm0ehQrByVv
         C7XBgLCui4iZb4ITVr/ACvn2tFdwNgZZxSGQou0PgjLNK84MtcRH5D6SHMziwzN+Q5Sx
         tj/g==
X-Forwarded-Encrypted: i=1; AFNElJ8cTMkelnrAjLrl4ygBjfCHd5kCg9M1hkAvM2fDZuiPapQqdBbX0YCX4lrrXeKznh/60zCbGRrtncc6XGh1OVGuQcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sPhOqQwJtb7PXDKCbBGa/Sd/9rrMMJTTntcOxbGv+37LpGzI
	WY6Zp9WnWMdirCbDr1re/QXvVg8Akd4Bt/yzztLzGin0h17RDQgndna0zDyavkgDO+evh9L35SJ
	cw/Pecy2VAhKeNIR2J0WesX++BAtn27azpt77ojfQcRDW4VT7ieJ1SlYuzFKBzjhY1y7PfGFCXX
	Mep2GhHKXNwWTc3NBq3H2O94Kp56AKppkaWv6CLisqndYfpbW5
X-Gm-Gg: Acq92OF7p7GoUjSXbkp53FNRxY6i+6V/a9GXFZH9FWVqIZ1oI+9V/NJw2yp40NT6pDl
	PcM1BUGKjdgKgXyxj4K5Xz+33oljGWlwfPLggGoRK0mQeDRsVlq/qSOvyMeBLr8Eq91PJq0fXPI
	CdP317/dagC9IPk+ozXkYQ5jCmK201eNFfj22YfWAloOqVsD2SB+pG8+M6FD8kaRSAgE5WLyh7G
	gV4+rCROmy5o3eW
X-Received: by 2002:a17:907:c20e:b0:bf8:6dc9:b319 with SMTP id a640c23a62f3a-bfc814fa321mr114885466b.24.1781178970104;
        Thu, 11 Jun 2026 04:56:10 -0700 (PDT)
X-Received: by 2002:a17:907:c20e:b0:bf8:6dc9:b319 with SMTP id
 a640c23a62f3a-bfc814fa321mr114884166b.24.1781178969635; Thu, 11 Jun 2026
 04:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610130457.1304245-1-vschneid@redhat.com> <20260610130457.1304245-2-vschneid@redhat.com>
 <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
 <CAP4=nvT6GEdwZAm-2h+Z-mj9DOmJ-swyApujFun6m1Qaxxr7hQ@mail.gmail.com> <xhsmh33yt2wtc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh33yt2wtc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 11 Jun 2026 13:55:56 +0200
X-Gm-Features: AVVi8CeVuw43PWQcIEO1eqmTM7vRPSxZSW-0y0nr9jRa9B3CpanHKch6hrIjViQ
Message-ID: <CAP4=nvTOV9jSermE_E_eUh29ks7B9Nv1Nkq1DfvA5nLRv=5hxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
To: Valentin Schneider <vschneid@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fI44KWe4jbaSUMbrhxiMVwPBomj9q_ecyUv-6vPqnkQ_1781178970
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 11. 6. 2026 v 12:31 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
> >
> > Isn't that precisely what the ipi tracepoints used by this
> > implementation (ipi:ipi_send_cpu) are for?
> >
>
> Well, these catch the emission of the IPI, which is great for investigati=
on
> - slap a stacktrace trigger and you (most of the time) get the source of
> your interference.
>
> However Crystal's point is that on x86 (and I assume other archs) receivi=
ng
> & handling these IPIs is "special" and doesn't go through the generic irq
> subsystem and thus has to be tracked separately, which is why osnoise has
> this fairly lengthy osnoise_arch_register() thing.
>

Ah, right. This is not IPI specific, though, IIUC - Intel also has
other IRQs that have to be traced using Intel-specific trace points,
like irq_vectors:local_timer, which is also handled in
osnoise_arch_register(). On ARM from what I recall, most (all?) IRQs
are traced with irq:* tracepoints.

So there are two parts to this:

- Detecting interference from IPIs firing as osnoise:irq_noise (to be
analyzed by timerlat auto analysis, and also will appear by default in
trace output if enabled, regardless of the tool, as all osnoise:*
tracepoints are enabled there). This is done locally using the already
existing path (no race hazard), but requires arch-specific detection.

- Counting IPIs when they are being sent. This is the new feature, and
the count is being recorded in osnoise_sample.

I guess that means that if there were a generic IPI interface, it
would be easier to use that for IPI counting, as the event would be
CPU-local? As you say, for tracing of the IPI source, the sending
tracepoints are better, and that you can already dump the stack trace
of with --event/--trigger. timerlat auto-analysis could be extended to
connect the specific IPI to the IRQ noise and display its stack trace
automatically, instead of manually analyzing the trace output.

> >> Isn't this racy to do from a different CPU?  Both in terms of the
> >> counter, and the timing of the increment relative to when the IPI is
> >> actually received.  Not necessarily a huge deal if you only care about
> >> zero versus bignum, but still.  At least worth a comment, if we go wit=
h
> >> this approach.
> >>
> >
> > I also think it's a bit confusing, especially as the other accesses to
> > osn_var are cpu-local, but here, "cpu" is the *target* CPU, not the
> > current CPU. Not sure how expensive it would be to do atomic_add for
> > that, at least it's something to consider.
> >
>
> I suppose that could be an argument for doing that stat aggregation in
> userspace osnoise - event handlers are run after the fact via
> tracefs_iterate_raw_events(), it's all inherently slower since it's just
> increments of one (one per handled event) but it's also all done in
> userspace on a control thread and doesn't bog down the kernelspace.
>

You can also do per-cpu counters in-kernel and sum them in the end,
but that would take cpus^2 space (indexed by [current_cpu,
target_cpu]). The question is whether there could be enough samples to
overload sample collection (like it happens for timerlat, which
collects data in-kernel using BPF instead).

In-kernel counting can be tested with " --event ipi:ipi_send_cpu
--trigger hist:key=3Dcpu" - IIRC, tracefs histograms use atomic
operations (via tracing_map) to protect the entries from races in
multi thread access. Of course, that is inferior to what the patchset
implements, as it doesn't record which osnoise cycle the IPI was sent
in, nor can record cpumask IPIs.


Tomas

