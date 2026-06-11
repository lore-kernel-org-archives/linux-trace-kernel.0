Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178B21CC58
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168359; cv=none; b=BB9tD+rTWr2eb9UuSkLCW4sm2msHikLE0Dy5tdAiRO6tw9uuQ9IQDULMTGrm906IPz+aMZ8NST78QViGo6w6sevEAMkNwN4vrnd8f4f28blJCzhxXSk2ThquZHsS2qbDWQkoDR3OYj5Nqkf0JSqwwHJeaWGy7ldnxxiiPSOo18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168359; c=relaxed/simple;
	bh=hoW2qoXXWUdw64xdOYUFtunSI0T/Bujcb1mKGjCcqys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSyIpKGaKdjWdgpLS+uGSdmzuogOyPRXxA09IrY+F/eEXFGr+3zXY1s5QWSKgVELA+0oArIayiEYQvZaUxQwt5QTOINhV0dNhlQi5aU0LvHG3efYv+eR75dEUsJ4m/d4sCb7N32Q1h/bhH+zfBA8U6ZoV2/Xf9JVOqQ6/0A2lyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbgIU083; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbgIU083"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781168356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgjtbDYbp+QKPickoNL6vc/x0GpsTUnlr50ME1BIXxA=;
	b=AbgIU083qDVaKQrpg7Cri5Df3K5OtsECGOwdIzkQgQPVkwO5Umx8siUP1tf77zCIdt6Fhs
	mgNu6NZkOe5Ww0G8BnbFH+eoxgwgh2V51lKFQ/XzyuQFYK/aibwhd4iarP1qnvt2X3Q4IE
	tA17VvtGzEj6zBTK5iV8wqzi0MllDE0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-ZgZloBTtMg6-WMiATAt85w-1; Thu, 11 Jun 2026 04:59:15 -0400
X-MC-Unique: ZgZloBTtMg6-WMiATAt85w-1
X-Mimecast-MFC-AGG-ID: ZgZloBTtMg6-WMiATAt85w_1781168354
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bf381078ac8so239873166b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 01:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168354; x=1781773154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgjtbDYbp+QKPickoNL6vc/x0GpsTUnlr50ME1BIXxA=;
        b=VMCbfrGOQ8I4breCEGpL05IuMpjEBtunLYatWA6JngdCLESjTjCHwxoWDo86qpzyvN
         J88sf0J737nkfFU3X4Zyg2hIP3KiDFM1OpdtWeWVZcubb7JkzPOf1s0P2w38O+EH7z1c
         mDVRR+V6OLTSrLYdqlUF5MZUyK5DzZaUmokeLvzhLMPI12hU4cRtyAnn11ADbblMyoPQ
         KJkInrpZv06UKb6iPl6pPiPDTOZZ8GAOfeQNmrwmrExFQFo9ZskJSzHtga3iE/09G+BF
         joDtfhh5Spb3GLkuKLEz1YDWkLVHm0Y7k+Jj0R4Ql2sBWB3wOS6Hve1lE5U1cUMNrlaI
         bC8w==
X-Forwarded-Encrypted: i=1; AFNElJ+4bw5r6CxVqf+L7PKZ+MSY2hzXhR/TOypQXby4iEegQ2wW+/zx/8A6aXFkQbEn0qpMhsmXPqRL7YiGUCZKuj4fa1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxteQKEZjTjM3gdgylG+2sSAoz5A5M0/PF3S0JUVqVz+1ncTYCq
	8PAcViiVkrhI6mhyyg2rySl5CAxiG6T3/zwBwm7SLUw21oMT8c+u765GD/nrZOcJ7iog6fS+QjK
	OOXQna6Ev7ykmukfa08oD7CrnMs74RUv7WOlhiM4SD+C6JVHBFlNRlHZrv+zLe2yhimAJbP4PNB
	/ra4UPf2yimvC3Gf4ZPDUHfLvCY1cpEdxx2cRgN97MsjakFQJH
X-Gm-Gg: Acq92OG02BxDKG1ZK1UZmgW9EzcOoVSyC15cStm9C3cZDjlhZYbqeOM8N5Qsclk+IbR
	1ESUP9+F/W2WBIAA3waep4s13y/zAkh+SmBf1H64RjUuO97GpiiFd2RlqUHcDCPGUz+X1T7v07T
	F0ayJ6dlw5quLNnJCJOYYTGI9uPn+YWXKvZKzLMXZ11/qJ3FNpJBQ/rk7rR8RZ7VK1iw4R94i5Q
	WuNUFuapNn7QuRq
X-Received: by 2002:a17:906:d542:b0:bed:6bd7:71ad with SMTP id a640c23a62f3a-bfc8894adecmr80855766b.49.1781168353686;
        Thu, 11 Jun 2026 01:59:13 -0700 (PDT)
X-Received: by 2002:a17:906:d542:b0:bed:6bd7:71ad with SMTP id
 a640c23a62f3a-bfc8894adecmr80854366b.49.1781168353131; Thu, 11 Jun 2026
 01:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610130457.1304245-1-vschneid@redhat.com> <20260610130457.1304245-2-vschneid@redhat.com>
 <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
In-Reply-To: <f40903f8198f8e2f42f1efdf950f995f24cf6e93.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 11 Jun 2026 10:59:01 +0200
X-Gm-Features: AVVi8CeKUSxUvFDLk6LW9QyJCUBWA_3dwRTkpM9_wyFGufl95qGYehlYrefZ59g
Message-ID: <CAP4=nvT6GEdwZAm-2h+Z-mj9DOmJ-swyApujFun6m1Qaxxr7hQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing/osnoise: Sample IPI counts
To: Crystal Wood <crwood@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K8pgudiRrgETjaud0NB7UmRa11QrVQDKIb_gZSZC7bM_1781168354
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[just replying to comments, will do a full review later]

st 10. 6. 2026 v 21:51 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> nap=
sal:
>
> On Wed, 2026-06-10 at 15:04 +0200, Valentin Schneider wrote:
> > Osnoise already implictly accounts IPIs via its IRQ tracking,
>
> Does it?  It seems that IPIs bypass the kernel/irq subsystem on some
> arches (including x86, but not ARM).
>
> It would be nice to solve this properly by adding generic ipi
> entry/exit tracing (similar to what ARM already has).
>

Isn't that precisely what the ipi tracepoints used by this
implementation (ipi:ipi_send_cpu) are for?

> > however it
> > can be interesting to distiguish between the two: undesired IPIs usuall=
y
> > imply a software configuration issue (e.g. wrong/incomplete CPU isolati=
on)
> > whereas undesired (non-IPI) IRQs usually imply a hardware configuration
> > issue.
> >
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > ---
> > Note that this is modifying the osnoise:osnoise_entry Ftrace entry; I k=
now
> > trace events are sort of supposed to be stable, but I'm not sure about
> > ftrace entries.
>
> I think old rtla will be OK with this since it looks up fields by name
> rather than assuming a fixed layout.
>

Yeah, the fields are either looked up with tep_get_field_val() [2], or
with name-based BPF CO-RE relocations against the tracepoint structure
[3]. So this shouldn't be an issue, as long as the old counts stay the
same.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/tools/tracing/rtla/src/timerlat_hist.c#n191
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/tools/tracing/rtla/src/timerlat.bpf.c#n12

> > Alternatively I can have this be purely supported in userspace osnoise =
by
> > hooking into the IPI events and counting IPIs separately from the osnoi=
se
> > events.
>
> One benefit I could see of doing this in kernel osnoise would be if you
> could atomically correlate the count with the particular noise
> interval, but this patch doesn't do that.
>

The count is already reported by cycle on the kernel side in the
patchset, right? It's only missing in the current RTLA (userspace)
part, as there is no statistic using the information. But it can still
be collected through custom histogram triggers.

> > ...
> >
> > +static void trace_ipi_send_cpumask_callback(void *data, const struct c=
pumask *cpumask,
> > +                                         unsigned long callsite, void =
*callback)
> > +{
> > +     struct osnoise_variables *osn_var;
> > +     int cpu;
> > +
> > +     for_each_cpu_and(cpu, cpumask, &osnoise_cpumask) {
> > +             osn_var =3D per_cpu_ptr(&per_cpu_osnoise_var, cpu);
> > +             ipi_emission(osn_var, cpu);
> > +     }
> > +}
>
> Isn't this racy to do from a different CPU?  Both in terms of the
> counter, and the timing of the increment relative to when the IPI is
> actually received.  Not necessarily a huge deal if you only care about
> zero versus bignum, but still.  At least worth a comment, if we go with
> this approach.
>

I also think it's a bit confusing, especially as the other accesses to
osn_var are cpu-local, but here, "cpu" is the *target* CPU, not the
current CPU. Not sure how expensive it would be to do atomic_add for
that, at least it's something to consider.

Tomas

