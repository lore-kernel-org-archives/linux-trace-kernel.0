Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DB432BD3
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722605; cv=pass; b=F6HJPVIG4S0w+1rChscsHOZZG24qGO9THLoRv+ktkTyVRUPq2ivb1KqFidiimgMMPNcBK3YSp9oMckIaGfry3AW9Cm6AdrYWE+AluX3sv+yoZqIvBNbXEBgYYKNsKVUktVLcE1jumy1LFYyq/x6GoMjjrO3TUI8fFgtWmyDDYjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722605; c=relaxed/simple;
	bh=fh7ORHnq/PCB6dTIrCztH+X6U6x7CbI2ZK70afJ12ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnFUHK/Eavgs2nngakKsB/Kqh9s+LJ6nNCyGXiJ/+BoKUF2Kls+F0C44yzLe1E82sD7+eQOVLMJrzpQBEg4eiQmFTYz6VJ3dkyovkFT3d3AQBpKrkr4s3VH6QLSlfI/Nx58f57tcbQ8xY36JBwLAgSCnUIBfTWzgAdajY7M13es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF/D31ps; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF/D31ps"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ae9bc9a2fcso24844027b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 05:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791722596; cv=none;
        d=google.com; s=arc-20260327;
        b=AlXUXOL3wOLlLkuCQ0Tbr86i6j90izb0+bdsq81UuwL5yc6DX/mhRyd30/d6ztmgY8
         wIxDWh9Y/MSfbfvUxV+UP2YVcC24VVv4dZF23EmZyVNYTS2z5IJJJwOMsYud0MZVLiap
         ToVYLsTq+ZfqWQWeAcKwbITnB4CCE0rMwtAJ6mQ4yabIPGOBUjvQcqSt32utObh8KzWS
         kSspWGkm05aOpsFXCHWae2DzhQIocTtF8VIm+cySUWw+lEnrOv5nNft+xoC0ZYu6BDbu
         oa+nbgPcfiqlw4vCxpWSLiikYdoAE0dpH58HotNkY8lR/TO1MlPHuAI+GhoQI/AlLgcw
         bXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fJuzpROs2sggysIu6z6IpyrFuoIYliS96K5NXSp8GJE=;
        fh=cK1zVPFenlD3pDaL+NbTNAu2frQsilbLOUbzmMyLuVg=;
        b=Giun2i9CWHPY+iuh0DurBZ30Y1266wmqK7OiJ0Ky3/OKYHS/m3yXdgo79tdhd70tAV
         iDwylHVpw5ny3yIqCoONbTn4xSzW6vWQX1Ha5CBty/Rha1q2aC+kdwEqPuR1h21agbNv
         KV0qiekuPy2jI4wWYdi8vSDVFJno4UUKvZu24pl9y34KJRKTkIhUfWX/WcvXpOR/wNEk
         mxWh/V6uJFWXG8WqS5ieW6PUGbK5E7IkpHc+Y5dFEEZaVmY3yz4a/gO8sARzDgAfoCKg
         jIUVI/RplFXQZQmN+/bJN1qB2grdALDI8/rWbqr1L/1buz8BJn96eM0n/S13GfOACnb8
         goIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791722596; x=1792327396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJuzpROs2sggysIu6z6IpyrFuoIYliS96K5NXSp8GJE=;
        b=gF/D31psepzFBdXkA9mN9AuD/TgefB9pIbWs6fhyQeuwaXN2KX0XDqaLBeO2mkPPgm
         3cdsXSe8fGdRRxyzkTV8EguVaUUh4J1M3/byrwzoSFOFmhnMiaSBhKK8N3byYMH9AOht
         gVpebp2GJSgoDry57o5q3MM8hf1VK7hmyHXbsY3Tx7sqMqJG3joSeLedih8adBZkj7ME
         q4UfhUivYWHMjgEBpJtji9rqFU4SEDBg3U9NagmYSKZGAmYesuEGjnwEFl8e5Xq9Az7e
         59yiVRDxcP/7zZPzkHW2/O3iyu/mnyoKW2n+6cdet0IkYdULUoIowrPe7BZuOqcqRNNp
         LOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791722596; x=1792327396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJuzpROs2sggysIu6z6IpyrFuoIYliS96K5NXSp8GJE=;
        b=WtZnHZpMxxQe27+Th8KIa2o7T344ILtaR8OMlMJ0xsgRe/wqdl5bsS9wS1OJHnNgCn
         fUdDsR8eDq3oDxFo9EwCDavplKmOx596HVZJiVTzz79pQURdMS7VSVokZTKWk7LXD0WC
         YbpTOcW619A0duxkk256nkFekw060/QAcI1Rbfhwu0Nazp0R8Ztpfaa3k29GBJyOtz63
         gFwHcYn1OnmwLibvhnceW5aK8PevLRct7kU8ndgSCJ+Hri65AM1D77RgMSI7wXD14M1X
         IyRfGdjrplSDIKt3lS9I6THskno0Jmy4Ci+d2OCsILiVu2WFBTnyDhoQoT6lzpN0Dy4e
         WteQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW1UPpq1Kk42bwm7ASwMzQQ296cn2O7RHimbddmnC3VAwnI1po0cypc+DUq2RRGXNua7W0hjwGBxnBLC0K9kh3Fcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl5tFFcdcqlXSXhnFI0XAQZkzc52VwsnGU+Sv4FeAk8l4flqLH
	CTpR87e081wW8xk4vML+4gfGejPHHK4Dko+j5XwqJbAhexKp3xppXuvCy1FMMhR7n3/733UvJcl
	dUt5nWCGbMRMWnm+q3a3/M7SHi/xtNeE=
X-Gm-Gg: AYBFou36PI2lIM+SWhu0pnz2Nq+/HPkiGmXIaz2sFx0CRS3ZXQU1jI7WWTdNG7a6ku4
	/1hqgxu2LtRJk/6vsXJvojHdCIuidSRaKGjRO1iRnSJGwkJxTYcEeJbgERPfJTG+5ngwY+6ISt2
	ICxSSalhK1H54ZOSObn24mR2UMbGXwX3YoyZx9it+w66uY1kH4/fxiIN4uLP2LPqDhVZhQJtKVw
	yjAmwUUpvm3BWE82g6uXQwNkHtO9wD6otoDg6qs8qP7GhFNM7fKzo/g/rV4BKS2KUQIaOBTM9DB
	T7wYy3AEJ+dj/ZHdfXYwrlojHjZvivyUz45Ps7GYkC78OGLHr6tHGFU=
X-Received: by 2002:a05:690e:dc2:b0:675:5b6b:64f2 with SMTP id
 956f58d0204a3-6793693562cmr2164147d50.31.1791722595964; Sun, 11 Oct 2026
 05:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com>
 <ar_Rathmoj2aP-H7@xhacker> <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>
 <asm95GdbmMpc81p3@xhacker>
In-Reply-To: <asm95GdbmMpc81p3@xhacker>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 11 Oct 2026 14:43:05 +0200
X-Gm-Features: AclHuK84dr65gv6i21DYLtKWou6o_QGXxpltpVKdie7_DQM7AcZKpQUsLMIzLV8
Message-ID: <CALsPMBPMHc7q-YZvqLLYDSr5RfLmDRwBSq-TFeB8Fc8bPBjQGg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 6:44=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Sat, Oct 03, 2026 at 10:54:44AM +0200, Roman Storozhenko wrote:
> > On Fri, Oct 2, 2026 at 6:04=E2=80=AFPM Jisheng Zhang <jszhang@kernel.or=
g> wrote:
> > >
> > > On Sun, Aug 30, 2026 at 04:36:37PM +0200, Roman 'Hedin' Storozhenko w=
rote:
> > > > Make RISC-V TLB flush path selection observable. Record whether Lin=
ux
> > > > handles an invalidation locally, delegates it to SBI RFENCE, or exe=
cutes
> > > > it through a cross-CPU call, so MM activity can be correlated with =
the
> > > > RISC-V, firmware, or Linux cross-CPU path carrying the request.
> > >
> > > I didn't see too much usefullness of the trace here. why not use kpro=
be
> > > instead? can you plz show a real usage example of the trace? Which
> > > bug/performance problem can be solved conveniently with this trace on=
ly?
> > >
> > > From another side, except x86, other architectures don't have the tra=
ce
> > > in the TLB path.
> > >
> >
> > Hi Jisheng,
> >
> > Thanks for the review. I agree that the current commit message describe=
s
> > the intended use rather abstractly.
> >
> > A kprobe can certainly be used to investigate this. My motivation
> > for a tracepoint is not that dynamic tracing cannot obtain the
> > information, but that doing so requires knowledge of the current
> > implementation and reconstruction of a semantic decision made inside
> > __flush_tlb_range() / flush_tlb_all().
>
> I prefer aligning with other architectures(except x86), I.E not
> add this kind of trace. However, I would leave the decision to riscv
> maintainers.
>
> FYI, you may notice that the riscv trace overhead is not trivial per
> https://lore.kernel.org/linux-riscv/20250619190315.2603194-4-rkrcmar@vent=
anamicro.com/

Hi Jisheng,

Thanks for the feedback.

Regarding the comparison with other architectures, thanks to Michael
Ellerman for pointing me to the PowerPC TLB tracing when we happened
to discuss this at LPC 2026.

PowerPC defines the powerpc:tlbie and powerpc:tlbia trace events in
arch/powerpc/include/asm/trace.h, and the corresponding trace calls
are used in the PowerPC TLB invalidation paths.

These events are not identical to the proposed RISC-V event: the
PowerPC events primarily describe architecture invalidation
operations, whereas this patch records the path selected by Linux
before dispatch. However, I think they provide useful precedent for
architecture-specific TLB observability beyond x86.

Regarding kprobes, I agree that dynamic tracing can be used to investigate =
this.

My concern is that obtaining the same information requires knowledge
of the current implementation and reconstruction of the decision made
inside __flush_tlb_range() / flush_tlb_all().

For example, probing __flush_tlb_range() gives us the incoming
request, but does not directly tell us whether Linux selected the
local flush, SBI RFENCE, or cross-CPU-call path. A tracing tool has to
probe and correlate implementation-specific downstream functions, or
reproduce the selection logic itself.

The proposed event records this semantic decision directly at the
point where Linux makes it. Users therefore do not need to depend on
the current helper names, call graph, or exact implementation of the
selection logic.

Regarding the tracepoint overhead issue, I agree that disabled-path
overhead is important, especially in the TLB flush path.

However, I see the referenced SBI tracepoint case primarily as a
RISC-V compiler/code-generation issue rather than as an argument
against providing this kind of observability.

The referenced discussion itself shows that the generated code depends
significantly on compiler behavior, and that this is an area being
improved. The undesirable overhead is not an inherent semantic
requirement of the tracepoint.

Even if the same code-generation problem currently affects this
tracepoint, I don't think a temporary compiler limitation should by
itself determine whether the tracepoint is useful or whether this
observability belongs in the kernel.

If the compiler currently generates unacceptable disabled-path
overhead, that is certainly something that should be improved or
mitigated in the implementation. But I would separate that issue from
the question of whether exposing the RISC-V TLB path-selection
decision is useful.

In other words, I see the code-generation issue as an implementation
concern, while the tracepoint itself provides information that
otherwise has to be reconstructed from implementation details using
dynamic tracing.

Thanks,
Roman

>
> >
> > For example, probing __flush_tlb_range() gives the request context, but
> > not directly the path subsequently selected. To determine whether the
> > request was handled locally, delegated through SBI RFENCE, or executed
> > through Linux cross-CPU coordination, a tracing tool needs to
> > probe/correlate implementation-specific call sites, or reproduce the
> > selection logic itself.
> >
> > The intent of the proposed event is to expose that semantic decision
> > directly, together with the target CPU mask and request context, rather
> > than make users depend on the current helper names and call graph.
> >
> > One concrete RISC-V example is commit ae9e9f3d67dc:
> >
> >   "RISC-V: clear hot-unplugged cores from all task mm_cpumasks
> >    to avoid rfence errors"
> >
> > In that case an offline CPU could remain in mm_cpumask(), which was the=
n
> > used as the target of an SBI RFENCE request. OpenSBI checks the request=
ed
> > hart mask against online harts, so such a request could fail.
> >
> > With this event, such a situation could expose, for example:
> >
> >   target_cpus=3D0,3 target_mask_weight=3D2 scope=3Drange path=3Dsbi-rfe=
nce
> >
> > while CPU3 is already offline.
> >
> > That shows that Linux constructed an unexpected target mask before the
> > request was handed to firmware, so the investigation can first focus on
> > Linux's mm CPU tracking rather than starting inside the SBI
> > implementation.
> >
> > There is also a performance-debugging use case. Real-world latency
> > investigations have found TLB shootdowns responsible for significant
> > latency spikes; for example:
> >
> >   https://www.jabperf.com/how-to-deter-or-disarm-tlb-shootdowns/
> >
> > That particular case eventually identified automatic NUMA balancing as
> > the source of excessive shootdowns. I am not claiming that this propose=
d
> > event alone would identify that root cause. On RISC-V, once TLB
> > shootdowns have been identified as relevant, the event provides the
> > architecture-specific next step: which CPUs Linux targeted, and whether
> > Linux selected local handling, SBI RFENCE, or Linux cross-CPU
> > coordination.
> >
> > This distinction also helps separate where to investigate next. For an
> > otherwise similar MM request:
> >
> >   path=3Dsbi-rfence
> >
> > points toward firmware/platform handling after Linux delegates the
> > request, while:
> >
> >   path=3Dcross-cpu-call
> >
> > points toward Linux cross-CPU/IPI handling and target-CPU activity.
> >
> > An unexpectedly broad target_cpus mask can similarly indicate that the
> > cost comes from Linux targeting more CPUs than expected rather than fro=
m
> > the execution time of the selected mechanism itself.
> >
> > I also put the workloads used to exercise the event here:
> >
> >   https://github.com/Romeus/tlb_workloads
> >
> > They provide reproducible examples using the same 64-page mprotect()
> > request with different CPU footprints/configurations. I used them to
> > exercise local, SBI RFENCE, and cross-CPU-call paths.
> >
> > I am not claiming that a tracepoint by itself solves these bugs, or tha=
t
> > the same information is impossible to obtain with kprobes. The intended
> > value is to expose the RISC-V TLB path-selection decision and its targe=
t
> > context in one semantic record, without requiring each tracing tool to
> > reconstruct that decision from implementation-specific probes.
> >
> > I also take your point that, apart from x86, architectures generally do
> > not currently have permanent tracing in the TLB path. If the use case i=
s
> > considered sufficient for a tracepoint, I will rework the commit messag=
e
> > to make the concrete motivation and the distinction from dynamic
> > probing clearer.
> >
> > For context, I also posted an unchanged v2 RESEND on Sep 24; this reply
> > is on the original v2 thread where your review landed.
> > https://lore.kernel.org/lkml/20260924-tlb_tracepoint-v2-1-4e3e78ef5cdb@=
gmail.com/
> >
> > Thanks,
> > Roman
> >
> > > >
> > > > The generic tlb:tlb_flush event describes TLB flush activity using
> > > > architecture-independent reason and page-count information. The RIS=
C-V
> > > > implementation subsequently selects between local invalidation, SBI
> > > > RFENCE, and Linux cross-CPU coordination, with additional
> > > > architecture-specific request context available at that point.
> > > >
> > > > Making this selection observable is useful when debugging RISC-V TL=
B
> > > > shootdowns. When a remote invalidation is observed to be slow, the
> > > > selected path determines whether to investigate SBI firmware and
> > > > platform handling or Linux cross-CPU and IPI handling. An unexpecte=
dly
> > > > broad target mask can reveal an unintended address-space CPU footpr=
int,
> > > > while the range and stride distinguish invalidation requests with
> > >
> > > > different mapping granularities.
> > > >
> > > > Place the event in the RISC-V implementation because the local, SBI
> > > > RFENCE, or cross-CPU choice is made there, and SBI RFENCE and the
> > > > invalidation stride are RISC-V-specific semantics rather than prope=
rties
> > > > of the generic MM flush request.
> > > >
> > > > Add riscv_tlb:riscv_tlb_flush_path in flush_tlb_all() and
> > > > __flush_tlb_range(). Record start, size, stride, the hardware-visib=
le
> > > > ASID, whether a specific mm is associated with the request, the tar=
get
> > > > CPU mask and its weight, the requested scope, and the selected path=
.
> > >
> > >
> > > >
> > > > Record the complete target mask in addition to its weight because C=
PU
> > > > identity cannot be reconstructed from a count and is needed to corr=
elate
> > > > the request with per-CPU scheduler, IPI, and firmware activity.
> > > >
> > > > The event records the invalidation request and the path selected by=
 Linux
> > > > before the operation is dispatched. In particular, selecting the SB=
I
> > > > RFENCE path means that Linux delegated the request to firmware; the=
 event
> > > > does not describe the implementation or outcome of that delegated
> > > > operation.
> > > >
> > > > Tested on QEMU virt with OpenSBI using local and shared-mm
> > > > mprotect()/munmap() workloads. Local requests reported path=3Dlocal=
,
> > > > while remote requests reported path=3Dsbi-rfence and were followed =
by the
> > > > existing riscv:sbi_call RFENCE event.
> > > >
> > > > The cross-CPU-call path was tested with QEMU virt using APLIC+IMSIC=
.
> > > > A MADV_PAGEOUT reclaim workload was used to exercise mm-independent
> > > > global flushes. All reported path values (local, sbi-rfence and
> > > > cross-cpu-call) and scope values (single, range, address-space and =
all)
> > > > were observed.
> > > >
> > > > Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> > > > ---
> > > > Add a RISC-V tracepoint for observing the path selected by Linux fo=
r TLB
> > > > invalidation requests: local invalidation, SBI RFENCE, or Linux
> > > > cross-CPU coordination.
> > > >
> > > > The tracepoint is intended to make RISC-V TLB shootdown behavior ea=
sier
> > > > to correlate with MM activity, CPU targeting, SBI calls, and IPI
> > > > handling. The patch records the invalidation request context and th=
e
> > > > Linux path-selection decision before the operation is dispatched.
> > > >
> > > > The patch was tested on QEMU virt with both the SBI RFENCE path and=
 an
> > > > APLIC+IMSIC configuration. Local, SBI RFENCE, and cross-CPU-call pa=
ths
> > > > were exercised. All reported scope values -- single, range,
> > > > address-space, and all -- were also observed.
> > > > ---
> > > > Changes in v2:
> > > > - Use trace_call__riscv_tlb_flush_path() after the explicit
> > > >   trace_riscv_tlb_flush_path_enabled() check to avoid a second
> > > >   tracepoint static-key test, as suggested by Steven Rostedt.
> > > > - Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-=
1-dfdaede7e741@gmail.com
> > > > ---
> > > >  arch/riscv/mm/tlbflush.c         |  60 +++++++++++++++++++--
> > > >  include/trace/events/riscv_tlb.h | 113 +++++++++++++++++++++++++++=
++++++++++++
> > > >  2 files changed, 169 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > > index 962db300a166..cefce9364bd2 100644
> > > > --- a/arch/riscv/mm/tlbflush.c
> > > > +++ b/arch/riscv/mm/tlbflush.c
> > > > @@ -9,6 +9,9 @@
> > > >  #include <asm/mmu_context.h>
> > > >  #include <asm/cpufeature.h>
> > > >
> > > > +#define CREATE_TRACE_POINTS
> > > > +#include <trace/events/riscv_tlb.h>
> > > > +
> > > >  #define has_svinval()        riscv_has_extension_unlikely(RISCV_IS=
A_EXT_SVINVAL)
> > > >
> > > >  /*
> > > > @@ -63,6 +66,33 @@ void local_flush_tlb_kernel_range(unsigned long =
start, unsigned long end)
> > > >       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLU=
SH_TLB_NO_ASID);
> > > >  }
> > > >
> > > > +static enum riscv_tlb_flush_scope
> > > > +riscv_tlb_get_flush_scope(unsigned long size, unsigned long stride=
, bool has_mm)
> > > > +{
> > > > +     if (size =3D=3D FLUSH_TLB_MAX_SIZE)
> > > > +             return has_mm ? RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE :
> > > > +                     RISCV_TLB_FLUSH_SCOPE_ALL;
> > > > +
> > > > +     return size <=3D stride ? RISCV_TLB_FLUSH_SCOPE_SINGLE :
> > > > +             RISCV_TLB_FLUSH_SCOPE_RANGE;
> > > > +}
> > > > +
> > > > +static __always_inline void
> > > > +riscv_tlb_trace_flush_path(const struct cpumask *cmask, unsigned l=
ong start,
> > > > +                        unsigned long size, unsigned long stride,
> > > > +                        unsigned long asid, bool has_mm,
> > > > +                        enum riscv_tlb_flush_path path)
> > > > +{
> > > > +     enum riscv_tlb_flush_scope scope;
> > > > +
> > > > +     if (!trace_riscv_tlb_flush_path_enabled())
> > > > +             return;
> > > > +
> > > > +     scope =3D riscv_tlb_get_flush_scope(size, stride, has_mm);
> > > > +     trace_call__riscv_tlb_flush_path(start, size, stride, asid, h=
as_mm,
> > > > +                      cmask, scope, path);
> > > > +}
> > > > +
> > > >  static void __ipi_flush_tlb_all(void *info)
> > > >  {
> > > >       local_flush_tlb_all();
> > > > @@ -70,12 +100,26 @@ static void __ipi_flush_tlb_all(void *info)
> > > >
> > > >  void flush_tlb_all(void)
> > > >  {
> > > > -     if (num_online_cpus() < 2)
> > > > +     if (num_online_cpus() < 2) {
> > > > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > > > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > > > +                                        FLUSH_TLB_NO_ASID, false,
> > > > +                                        RISCV_TLB_FLUSH_PATH_LOCAL=
);
> > > >               local_flush_tlb_all();
> > > > -     else if (riscv_use_sbi_for_rfence())
> > > > -             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZ=
E, FLUSH_TLB_NO_ASID);
> > > > -     else
> > > > +     } else if (riscv_use_sbi_for_rfence()) {
> > > > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > > > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > > > +                                        FLUSH_TLB_NO_ASID, false,
> > > > +                                        RISCV_TLB_FLUSH_PATH_SBI_R=
FENCE);
> > > > +             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZ=
E,
> > > > +                                        FLUSH_TLB_NO_ASID);
> > > > +     } else {
> > > > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > > > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > > > +                                        FLUSH_TLB_NO_ASID, false,
> > > > +                                        RISCV_TLB_FLUSH_PATH_CROSS=
_CPU_CALL);
> > > >               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> > > > +     }
> > > >  }
> > > >
> > > >  struct flush_tlb_range_data {
> > > > @@ -107,12 +151,20 @@ static void __flush_tlb_range(struct mm_struc=
t *mm,
> > > >
> > > >       /* Check if the TLB flush needs to be sent to other CPUs. */
> > > >       if (cpumask_any_but(cmask, cpu) >=3D nr_cpu_ids) {
> > > > +             riscv_tlb_trace_flush_path(cmask, start, size, stride=
, asid,
> > > > +                                        !!mm, RISCV_TLB_FLUSH_PATH=
_LOCAL);
> > > >               local_flush_tlb_range_asid(start, size, stride, asid)=
;
> > > >       } else if (riscv_use_sbi_for_rfence()) {
> > > > +             riscv_tlb_trace_flush_path(cmask, start, size, stride=
, asid,
> > > > +                                        !!mm, RISCV_TLB_FLUSH_PATH=
_SBI_RFENCE);
> > > >               sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> > > >       } else {
> > > >               struct flush_tlb_range_data ftd;
> > > >
> > > > +             riscv_tlb_trace_flush_path(cmask, start, size, stride=
, asid,
> > > > +                                        !!mm,
> > > > +                                        RISCV_TLB_FLUSH_PATH_CROSS=
_CPU_CALL);
> > > > +
> > > >               ftd.asid =3D asid;
> > > >               ftd.start =3D start;
> > > >               ftd.size =3D size;
> > > > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/event=
s/riscv_tlb.h
> > > > new file mode 100644
> > > > index 000000000000..3eff171ec54f
> > > > --- /dev/null
> > > > +++ b/include/trace/events/riscv_tlb.h
> > > > @@ -0,0 +1,113 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#undef TRACE_SYSTEM
> > > > +#define TRACE_SYSTEM riscv_tlb
> > > > +
> > > > +#if !defined(_TRACE_RISCV_TLB_H) || defined(TRACE_HEADER_MULTI_REA=
D)
> > > > +#define _TRACE_RISCV_TLB_H
> > > > +
> > > > +#include <linux/cpumask.h>
> > > > +#include <linux/tracepoint.h>
> > > > +
> > > > +#ifndef _TRACE_RISCV_TLB_ENUMS
> > > > +#define _TRACE_RISCV_TLB_ENUMS
> > > > +
> > > > +enum riscv_tlb_flush_scope {
> > > > +     RISCV_TLB_FLUSH_SCOPE_SINGLE,
> > > > +     RISCV_TLB_FLUSH_SCOPE_RANGE,
> > > > +     RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
> > > > +     RISCV_TLB_FLUSH_SCOPE_ALL,
> > > > +};
> > > > +
> > > > +enum riscv_tlb_flush_path {
> > > > +     RISCV_TLB_FLUSH_PATH_LOCAL,
> > > > +     RISCV_TLB_FLUSH_PATH_SBI_RFENCE,
> > > > +     RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL,
> > > > +};
> > > > +
> > > > +#endif /* _TRACE_RISCV_TLB_ENUMS */
> > > > +
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> > > > +
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_LOCAL);
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
> > > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
> > > > +
> > > > +#define show_riscv_tlb_flush_scope(scope) \
> > > > +     __print_symbolic(scope, \
> > > > +             { RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> > > > +             { RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> > > > +             { RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space=
" }, \
> > > > +             { RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> > > > +
> > > > +#define show_riscv_tlb_flush_path(path) \
> > > > +     __print_symbolic(path, \
> > > > +             { RISCV_TLB_FLUSH_PATH_LOCAL,          "local" }, \
> > > > +             { RISCV_TLB_FLUSH_PATH_SBI_RFENCE,     "sbi-rfence" }=
, \
> > > > +             { RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL, "cross-cpu-cal=
l" })
> > > > +
> > > > +/*
> > > > + * Record the invalidation request received by the RISC-V architec=
ture code
> > > > + * and the path selected by Linux.
> > > > + *
> > > > + * The target CPU mask represents the CPUs Linux intends to cover =
for the
> > > > + * request. It can be correlated with per-CPU activity, but does n=
ot describe
> > > > + * which harts ultimately performed an invalidation.
> > > > + *
> > > > + * The ASID is hardware-visible and may be reused. It must not be =
treated as a
> > > > + * persistent identifier for an mm.
> > > > + *
> > > > + * The stride describes the invalidation granularity supplied to t=
he RISC-V
> > > > + * implementation. SBI RFENCE receives start, size and ASID, but n=
ot stride.
> > > > + *
> > > > + * The event is emitted at path selection time. For SBI RFENCE, it=
 records
> > > > + * delegation of the request to firmware; firmware processing afte=
r that
> > > > + * point is outside the event's scope.
> > > > + */
> > > > +TRACE_EVENT(riscv_tlb_flush_path,
> > > > +     TP_PROTO(unsigned long start, unsigned long size,
> > > > +              unsigned long stride, unsigned long asid, bool has_m=
m,
> > > > +              const struct cpumask *cmask,
> > > > +              enum riscv_tlb_flush_scope scope,
> > > > +              enum riscv_tlb_flush_path path),
> > > > +
> > > > +     TP_ARGS(start, size, stride, asid, has_mm, cmask, scope, path=
),
> > > > +
> > > > +     TP_STRUCT__entry(
> > > > +             __field(unsigned long, start)
> > > > +             __field(unsigned long, size)
> > > > +             __field(unsigned long, stride)
> > > > +             __field(unsigned long, asid)
> > > > +             __field(bool, has_mm)
> > > > +             __field(unsigned int, target_mask_weight)
> > > > +             __cpumask(target_cpus)
> > > > +             __field(u8, scope)
> > > > +             __field(u8, path)
> > > > +     ),
> > > > +
> > > > +     TP_fast_assign(
> > > > +             __entry->start =3D start;
> > > > +             __entry->size =3D size;
> > > > +             __entry->stride =3D stride;
> > > > +             __entry->asid =3D asid;
> > > > +             __entry->has_mm =3D has_mm;
> > > > +             __entry->target_mask_weight =3D cpumask_weight(cmask)=
;
> > > > +             __assign_cpumask(target_cpus, cpumask_bits(cmask));
> > > > +             __entry->scope =3D scope;
> > > > +             __entry->path =3D path;
> > > > +     ),
> > > > +
> > > > +     TP_printk("start=3D%#lx size=3D%#lx stride=3D%#lx asid=3D%#lx=
 has_mm=3D%d target_mask_weight=3D%u target_cpus=3D%s scope=3D%s path=3D%s"=
,
> > > > +               __entry->start, __entry->size, __entry->stride,
> > > > +               __entry->asid, __entry->has_mm,
> > > > +               __entry->target_mask_weight, __get_cpumask(target_c=
pus),
> > > > +               show_riscv_tlb_flush_scope(__entry->scope),
> > > > +               show_riscv_tlb_flush_path(__entry->path))
> > > > +);
> > > > +
> > > > +#endif /* _TRACE_RISCV_TLB_H */
> > > > +
> > > > +/* This part must be outside protection. */
> > > > +#include <trace/define_trace.h>
> > > >
> > > > ---
> > > > base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
> > > > change-id: 20260829-tlb_tracepoint-844105ab5092
> > > >
> > > > Best regards,
> > > > --
> > > > Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Kind regards,
> > Roman 'Hedin' Storozhenko



--=20
Kind regards,
Roman 'Hedin' Storozhenko
