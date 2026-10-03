Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018A3AB272
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Oct 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017699; cv=pass; b=kMgFLpjmHzl3sBkN06M5OfwY5uqMbrZeStDnXIcdufNY7udcF8yviPH5Sl5Qzc3Uq5xSWzmZ8YK4U2IBvQL/daYXeFwbKsWmiwdoXixeP+yGSALlzf59MpCY4QQOH0zaS4TeCpRfOtIjGW58xEj5hQLpzoUHX1HLWAX0o8ybCuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017699; c=relaxed/simple;
	bh=ZStmYwK2517SZukWL0OBGTySyFb/30xKB+Vyvyid+M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsACjmB4poCXSsGgifE1U9SKGkaibB2dQbkXQ0R/rFe3skc1FF+s8l2AoGQCuNNGNqaaocvHT5RexkCQyeQFBQbNjuVOShAmd8BFtzVtEYeGxFegYLZLzHb9FLkrjgth1dqGQs7n1dovFeXExDGScZCQrEPxhQ/UUCaSPl/JaKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC9F5Fjk; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC9F5Fjk"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8925e417565so1985747b3.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Oct 2026 01:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791017696; cv=none;
        d=google.com; s=arc-20260327;
        b=LP1pivZIGH7hhGWqs5GUhGr2ebuWYIoogm6Cwxs0vHLS80rMF/lQBZTDt8BiaUHj80
         4LeglHq2iXCI6Gs15tQq+YZLYrUCbgtOWwCkKdCyFyZogcGeT7BidH8DkOabjb7tmX3x
         nOP2frh9KUJvb3RgWg3+OX776hKSEAlsi8qPfRPGIKDBmYrthkkkMxPf3NaiPrNmTo5G
         EWa9nzS6nCGiNC4FNCpSk5QRaDihiBqfMiIsge064R76cBNsCdkpaiBdOy3m0oZiyoMd
         tqY2/LGp+sJcUVy7a/WSwacLm/qa3sjs2HlrX+55rD4rZpb3MiLCCWRO5nMICRGOC4iO
         zu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XF1Rfe6tT9rWhz53Zwt6lcrDcxOktMryg4NS9sKRHVU=;
        fh=r/B7XG1QX9EEWumtNfQmduwFUq34tRo6FAVxkPOj4zE=;
        b=kwx3gpEs9NPOuO6xT+bKc5bt0RCihPbfMpsATMSDNijkAJnV/yaM0KPZK700Bu+dJ7
         AHVLhJy5+qudeJP+cxFMU30oAHv8XEPR5IUtDbP/WZ6sC8uAxlqEJTSNFx0rINPM0McQ
         8cSxHtXaPG2AB7y+A4UbrNp8C/Cc3BQsPs/ZaQm2w1UmqS8hgyUGuRAV+7/Q3bMKrj08
         3n+ouJ59x4TpjvVcVLzdmM19Yq/VbUTLzhZvbxWEfYiZlx4g+nEykzwdNEqtS/KwZjhN
         QMBWO13B6CvdOJuNcAjGT1uJeITjMVva4zvIy3U7G/6kTMZsQ3/9myAcYbbaXEc7ErVS
         V8zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791017696; x=1791622496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XF1Rfe6tT9rWhz53Zwt6lcrDcxOktMryg4NS9sKRHVU=;
        b=SC9F5FjkbpV1AH10GlNOdnz5lVkoiYgH/1WGxB88/F+BFy2R/+JwSydSja5cEFbdRf
         UMjeCRP6USHgFPZYGG1zHzwMaoo6f7w9yqADl6GUfAB8CbrH8rUxvko5v1+o9uiegFwf
         wsBj+9S2ltzPBef8hNg5bNZnUctVIVvYkhEWZzGxzlMfAxlfI8KZJBPJAWnH9haAx7s3
         SFSnTBLNPDfxGUlZBwn6RZV4KdHQcBr0MI72uNzmCWNeExKMaNQNhA5sAqbpxCrJvuuq
         s2McAqyJ5FOLLPM+5CxHOQUSGHf4GjDbydl1ZRk7ImoBktARzeLZtT++lwfYCt4szSY6
         fZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791017696; x=1791622496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XF1Rfe6tT9rWhz53Zwt6lcrDcxOktMryg4NS9sKRHVU=;
        b=mryqrvxuiUw354DBOXA4aYJbDKXPuyakMeHcjmnH/y1YECtDMdXjoZLX8VADAU9H7f
         NZWhYhLHEA7K4gcFB6ZZ7/MZXu3ec/RFKJZ8T1sA8yxnMRxFAcQ/eZUxdny9dkqg+aVN
         QZQjboIcNHZPzJV+UYRQnlqFFY2FVyW1tO+sRBTsv7c5XssW6TtR99oACiDDxcBG7xhq
         N+IXFKwSzIbiwULUI/FkiqOOVlCDVMS8diH7PFfJx3KW84b/O7r2SShvjlhJe3saPGsi
         Y/mJOQSpqyJOUuJsfTmybnRVLgV0Dap/KmNg9+nYMsjx5j4lJen0blC+frUB0GhdIpW0
         8UKg==
X-Forwarded-Encrypted: i=1; AKwUvBxsPwgbe3UVOsqWKF+U5BNI6hXUhusg9i7BmWum8FRYqp6TREAWb6xxaxqLT0OAKET7ok9p3wkONCg7QRsr8W/SYfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLk3KvgdcBK2Tc/YdwlvbgIWXsS/wmfZseCW+QLUsO/HVKfM2KT
	2krg+k1pC5XqMbOpSir5NG+N2YqGE4icIaVLSpG7rHVRhqZidrAosXgErp9xAdg1mppenE+jg8r
	xClhidFkcHwBHkbwQ5RQx0nOSPKrqIic=
X-Gm-Gg: AYBFou17l7ZwGYwhHSY1BBoeLwIL/QPTw6UJHP1RFB36gnp/yx4RsBzCbK4YagHNlZz
	qqScXBhEZ4k+rTRhf3YBtBKtZIm41enZw6/QqHlf2g0Bu4FItsQemG+o7x1UccUPewKYU7wrr+h
	NeTlJo1pgjhdnHs0kBK5m08tRy+xXi9Z/Yfl7/rJ+xZBsRPcDBWnuim5gexu59i/dKZ3ZpFg0Ef
	CI3onSnz3XeRJ1uombVhJDS8g6djBb2UGw4WpihJjbvxk3dvvZydk2N9Pc/Kyoa4wffsuyx0sku
	SXh6X5dnqPv+FWxc7Yc7KwCP8Z8eN2Yh/KubF/cyO/BKxoN3AY6MpUM=
X-Received: by 2002:a05:690c:5806:b0:8a3:81cd:d44b with SMTP id
 00721157ae682-8ae957dc0f1mr6697157b3.101.1791017695981; Sat, 03 Oct 2026
 01:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com> <ar_Rathmoj2aP-H7@xhacker>
In-Reply-To: <ar_Rathmoj2aP-H7@xhacker>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sat, 3 Oct 2026 10:54:44 +0200
X-Gm-Features: AclHuK9m1M4Lrz4Ru5FcuKLbDUhiUabKkeX8NFZe_o4dWUeThLGkjCTU9xIeOag
Message-ID: <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 6:04=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> On Sun, Aug 30, 2026 at 04:36:37PM +0200, Roman 'Hedin' Storozhenko wrote=
:
> > Make RISC-V TLB flush path selection observable. Record whether Linux
> > handles an invalidation locally, delegates it to SBI RFENCE, or execute=
s
> > it through a cross-CPU call, so MM activity can be correlated with the
> > RISC-V, firmware, or Linux cross-CPU path carrying the request.
>
> I didn't see too much usefullness of the trace here. why not use kprobe
> instead? can you plz show a real usage example of the trace? Which
> bug/performance problem can be solved conveniently with this trace only?
>
> From another side, except x86, other architectures don't have the trace
> in the TLB path.
>

Hi Jisheng,

Thanks for the review. I agree that the current commit message describes
the intended use rather abstractly.

A kprobe can certainly be used to investigate this. My motivation
for a tracepoint is not that dynamic tracing cannot obtain the
information, but that doing so requires knowledge of the current
implementation and reconstruction of a semantic decision made inside
__flush_tlb_range() / flush_tlb_all().

For example, probing __flush_tlb_range() gives the request context, but
not directly the path subsequently selected. To determine whether the
request was handled locally, delegated through SBI RFENCE, or executed
through Linux cross-CPU coordination, a tracing tool needs to
probe/correlate implementation-specific call sites, or reproduce the
selection logic itself.

The intent of the proposed event is to expose that semantic decision
directly, together with the target CPU mask and request context, rather
than make users depend on the current helper names and call graph.

One concrete RISC-V example is commit ae9e9f3d67dc:

  "RISC-V: clear hot-unplugged cores from all task mm_cpumasks
   to avoid rfence errors"

In that case an offline CPU could remain in mm_cpumask(), which was then
used as the target of an SBI RFENCE request. OpenSBI checks the requested
hart mask against online harts, so such a request could fail.

With this event, such a situation could expose, for example:

  target_cpus=3D0,3 target_mask_weight=3D2 scope=3Drange path=3Dsbi-rfence

while CPU3 is already offline.

That shows that Linux constructed an unexpected target mask before the
request was handed to firmware, so the investigation can first focus on
Linux's mm CPU tracking rather than starting inside the SBI
implementation.

There is also a performance-debugging use case. Real-world latency
investigations have found TLB shootdowns responsible for significant
latency spikes; for example:

  https://www.jabperf.com/how-to-deter-or-disarm-tlb-shootdowns/

That particular case eventually identified automatic NUMA balancing as
the source of excessive shootdowns. I am not claiming that this proposed
event alone would identify that root cause. On RISC-V, once TLB
shootdowns have been identified as relevant, the event provides the
architecture-specific next step: which CPUs Linux targeted, and whether
Linux selected local handling, SBI RFENCE, or Linux cross-CPU
coordination.

This distinction also helps separate where to investigate next. For an
otherwise similar MM request:

  path=3Dsbi-rfence

points toward firmware/platform handling after Linux delegates the
request, while:

  path=3Dcross-cpu-call

points toward Linux cross-CPU/IPI handling and target-CPU activity.

An unexpectedly broad target_cpus mask can similarly indicate that the
cost comes from Linux targeting more CPUs than expected rather than from
the execution time of the selected mechanism itself.

I also put the workloads used to exercise the event here:

  https://github.com/Romeus/tlb_workloads

They provide reproducible examples using the same 64-page mprotect()
request with different CPU footprints/configurations. I used them to
exercise local, SBI RFENCE, and cross-CPU-call paths.

I am not claiming that a tracepoint by itself solves these bugs, or that
the same information is impossible to obtain with kprobes. The intended
value is to expose the RISC-V TLB path-selection decision and its target
context in one semantic record, without requiring each tracing tool to
reconstruct that decision from implementation-specific probes.

I also take your point that, apart from x86, architectures generally do
not currently have permanent tracing in the TLB path. If the use case is
considered sufficient for a tracepoint, I will rework the commit message
to make the concrete motivation and the distinction from dynamic
probing clearer.

For context, I also posted an unchanged v2 RESEND on Sep 24; this reply
is on the original v2 thread where your review landed.
https://lore.kernel.org/lkml/20260924-tlb_tracepoint-v2-1-4e3e78ef5cdb@gmai=
l.com/

Thanks,
Roman

> >
> > The generic tlb:tlb_flush event describes TLB flush activity using
> > architecture-independent reason and page-count information. The RISC-V
> > implementation subsequently selects between local invalidation, SBI
> > RFENCE, and Linux cross-CPU coordination, with additional
> > architecture-specific request context available at that point.
> >
> > Making this selection observable is useful when debugging RISC-V TLB
> > shootdowns. When a remote invalidation is observed to be slow, the
> > selected path determines whether to investigate SBI firmware and
> > platform handling or Linux cross-CPU and IPI handling. An unexpectedly
> > broad target mask can reveal an unintended address-space CPU footprint,
> > while the range and stride distinguish invalidation requests with
>
> > different mapping granularities.
> >
> > Place the event in the RISC-V implementation because the local, SBI
> > RFENCE, or cross-CPU choice is made there, and SBI RFENCE and the
> > invalidation stride are RISC-V-specific semantics rather than propertie=
s
> > of the generic MM flush request.
> >
> > Add riscv_tlb:riscv_tlb_flush_path in flush_tlb_all() and
> > __flush_tlb_range(). Record start, size, stride, the hardware-visible
> > ASID, whether a specific mm is associated with the request, the target
> > CPU mask and its weight, the requested scope, and the selected path.
>
>
> >
> > Record the complete target mask in addition to its weight because CPU
> > identity cannot be reconstructed from a count and is needed to correlat=
e
> > the request with per-CPU scheduler, IPI, and firmware activity.
> >
> > The event records the invalidation request and the path selected by Lin=
ux
> > before the operation is dispatched. In particular, selecting the SBI
> > RFENCE path means that Linux delegated the request to firmware; the eve=
nt
> > does not describe the implementation or outcome of that delegated
> > operation.
> >
> > Tested on QEMU virt with OpenSBI using local and shared-mm
> > mprotect()/munmap() workloads. Local requests reported path=3Dlocal,
> > while remote requests reported path=3Dsbi-rfence and were followed by t=
he
> > existing riscv:sbi_call RFENCE event.
> >
> > The cross-CPU-call path was tested with QEMU virt using APLIC+IMSIC.
> > A MADV_PAGEOUT reclaim workload was used to exercise mm-independent
> > global flushes. All reported path values (local, sbi-rfence and
> > cross-cpu-call) and scope values (single, range, address-space and all)
> > were observed.
> >
> > Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> > ---
> > Add a RISC-V tracepoint for observing the path selected by Linux for TL=
B
> > invalidation requests: local invalidation, SBI RFENCE, or Linux
> > cross-CPU coordination.
> >
> > The tracepoint is intended to make RISC-V TLB shootdown behavior easier
> > to correlate with MM activity, CPU targeting, SBI calls, and IPI
> > handling. The patch records the invalidation request context and the
> > Linux path-selection decision before the operation is dispatched.
> >
> > The patch was tested on QEMU virt with both the SBI RFENCE path and an
> > APLIC+IMSIC configuration. Local, SBI RFENCE, and cross-CPU-call paths
> > were exercised. All reported scope values -- single, range,
> > address-space, and all -- were also observed.
> > ---
> > Changes in v2:
> > - Use trace_call__riscv_tlb_flush_path() after the explicit
> >   trace_riscv_tlb_flush_path_enabled() check to avoid a second
> >   tracepoint static-key test, as suggested by Steven Rostedt.
> > - Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-1-df=
daede7e741@gmail.com
> > ---
> >  arch/riscv/mm/tlbflush.c         |  60 +++++++++++++++++++--
> >  include/trace/events/riscv_tlb.h | 113 +++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 169 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 962db300a166..cefce9364bd2 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -9,6 +9,9 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/cpufeature.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/riscv_tlb.h>
> > +
> >  #define has_svinval()        riscv_has_extension_unlikely(RISCV_ISA_EX=
T_SVINVAL)
> >
> >  /*
> > @@ -63,6 +66,33 @@ void local_flush_tlb_kernel_range(unsigned long star=
t, unsigned long end)
> >       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_T=
LB_NO_ASID);
> >  }
> >
> > +static enum riscv_tlb_flush_scope
> > +riscv_tlb_get_flush_scope(unsigned long size, unsigned long stride, bo=
ol has_mm)
> > +{
> > +     if (size =3D=3D FLUSH_TLB_MAX_SIZE)
> > +             return has_mm ? RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE :
> > +                     RISCV_TLB_FLUSH_SCOPE_ALL;
> > +
> > +     return size <=3D stride ? RISCV_TLB_FLUSH_SCOPE_SINGLE :
> > +             RISCV_TLB_FLUSH_SCOPE_RANGE;
> > +}
> > +
> > +static __always_inline void
> > +riscv_tlb_trace_flush_path(const struct cpumask *cmask, unsigned long =
start,
> > +                        unsigned long size, unsigned long stride,
> > +                        unsigned long asid, bool has_mm,
> > +                        enum riscv_tlb_flush_path path)
> > +{
> > +     enum riscv_tlb_flush_scope scope;
> > +
> > +     if (!trace_riscv_tlb_flush_path_enabled())
> > +             return;
> > +
> > +     scope =3D riscv_tlb_get_flush_scope(size, stride, has_mm);
> > +     trace_call__riscv_tlb_flush_path(start, size, stride, asid, has_m=
m,
> > +                      cmask, scope, path);
> > +}
> > +
> >  static void __ipi_flush_tlb_all(void *info)
> >  {
> >       local_flush_tlb_all();
> > @@ -70,12 +100,26 @@ static void __ipi_flush_tlb_all(void *info)
> >
> >  void flush_tlb_all(void)
> >  {
> > -     if (num_online_cpus() < 2)
> > +     if (num_online_cpus() < 2) {
> > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > +                                        FLUSH_TLB_NO_ASID, false,
> > +                                        RISCV_TLB_FLUSH_PATH_LOCAL);
> >               local_flush_tlb_all();
> > -     else if (riscv_use_sbi_for_rfence())
> > -             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
> > -     else
> > +     } else if (riscv_use_sbi_for_rfence()) {
> > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > +                                        FLUSH_TLB_NO_ASID, false,
> > +                                        RISCV_TLB_FLUSH_PATH_SBI_RFENC=
E);
> > +             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE,
> > +                                        FLUSH_TLB_NO_ASID);
> > +     } else {
> > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > +                                        FLUSH_TLB_NO_ASID, false,
> > +                                        RISCV_TLB_FLUSH_PATH_CROSS_CPU=
_CALL);
> >               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> > +     }
> >  }
> >
> >  struct flush_tlb_range_data {
> > @@ -107,12 +151,20 @@ static void __flush_tlb_range(struct mm_struct *m=
m,
> >
> >       /* Check if the TLB flush needs to be sent to other CPUs. */
> >       if (cpumask_any_but(cmask, cpu) >=3D nr_cpu_ids) {
> > +             riscv_tlb_trace_flush_path(cmask, start, size, stride, as=
id,
> > +                                        !!mm, RISCV_TLB_FLUSH_PATH_LOC=
AL);
> >               local_flush_tlb_range_asid(start, size, stride, asid);
> >       } else if (riscv_use_sbi_for_rfence()) {
> > +             riscv_tlb_trace_flush_path(cmask, start, size, stride, as=
id,
> > +                                        !!mm, RISCV_TLB_FLUSH_PATH_SBI=
_RFENCE);
> >               sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> >       } else {
> >               struct flush_tlb_range_data ftd;
> >
> > +             riscv_tlb_trace_flush_path(cmask, start, size, stride, as=
id,
> > +                                        !!mm,
> > +                                        RISCV_TLB_FLUSH_PATH_CROSS_CPU=
_CALL);
> > +
> >               ftd.asid =3D asid;
> >               ftd.start =3D start;
> >               ftd.size =3D size;
> > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/ri=
scv_tlb.h
> > new file mode 100644
> > index 000000000000..3eff171ec54f
> > --- /dev/null
> > +++ b/include/trace/events/riscv_tlb.h
> > @@ -0,0 +1,113 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM riscv_tlb
> > +
> > +#if !defined(_TRACE_RISCV_TLB_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_RISCV_TLB_H
> > +
> > +#include <linux/cpumask.h>
> > +#include <linux/tracepoint.h>
> > +
> > +#ifndef _TRACE_RISCV_TLB_ENUMS
> > +#define _TRACE_RISCV_TLB_ENUMS
> > +
> > +enum riscv_tlb_flush_scope {
> > +     RISCV_TLB_FLUSH_SCOPE_SINGLE,
> > +     RISCV_TLB_FLUSH_SCOPE_RANGE,
> > +     RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
> > +     RISCV_TLB_FLUSH_SCOPE_ALL,
> > +};
> > +
> > +enum riscv_tlb_flush_path {
> > +     RISCV_TLB_FLUSH_PATH_LOCAL,
> > +     RISCV_TLB_FLUSH_PATH_SBI_RFENCE,
> > +     RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL,
> > +};
> > +
> > +#endif /* _TRACE_RISCV_TLB_ENUMS */
> > +
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> > +
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_LOCAL);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
> > +
> > +#define show_riscv_tlb_flush_scope(scope) \
> > +     __print_symbolic(scope, \
> > +             { RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> > +             { RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> > +             { RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" },=
 \
> > +             { RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> > +
> > +#define show_riscv_tlb_flush_path(path) \
> > +     __print_symbolic(path, \
> > +             { RISCV_TLB_FLUSH_PATH_LOCAL,          "local" }, \
> > +             { RISCV_TLB_FLUSH_PATH_SBI_RFENCE,     "sbi-rfence" }, \
> > +             { RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL, "cross-cpu-call" }=
)
> > +
> > +/*
> > + * Record the invalidation request received by the RISC-V architecture=
 code
> > + * and the path selected by Linux.
> > + *
> > + * The target CPU mask represents the CPUs Linux intends to cover for =
the
> > + * request. It can be correlated with per-CPU activity, but does not d=
escribe
> > + * which harts ultimately performed an invalidation.
> > + *
> > + * The ASID is hardware-visible and may be reused. It must not be trea=
ted as a
> > + * persistent identifier for an mm.
> > + *
> > + * The stride describes the invalidation granularity supplied to the R=
ISC-V
> > + * implementation. SBI RFENCE receives start, size and ASID, but not s=
tride.
> > + *
> > + * The event is emitted at path selection time. For SBI RFENCE, it rec=
ords
> > + * delegation of the request to firmware; firmware processing after th=
at
> > + * point is outside the event's scope.
> > + */
> > +TRACE_EVENT(riscv_tlb_flush_path,
> > +     TP_PROTO(unsigned long start, unsigned long size,
> > +              unsigned long stride, unsigned long asid, bool has_mm,
> > +              const struct cpumask *cmask,
> > +              enum riscv_tlb_flush_scope scope,
> > +              enum riscv_tlb_flush_path path),
> > +
> > +     TP_ARGS(start, size, stride, asid, has_mm, cmask, scope, path),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(unsigned long, start)
> > +             __field(unsigned long, size)
> > +             __field(unsigned long, stride)
> > +             __field(unsigned long, asid)
> > +             __field(bool, has_mm)
> > +             __field(unsigned int, target_mask_weight)
> > +             __cpumask(target_cpus)
> > +             __field(u8, scope)
> > +             __field(u8, path)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->start =3D start;
> > +             __entry->size =3D size;
> > +             __entry->stride =3D stride;
> > +             __entry->asid =3D asid;
> > +             __entry->has_mm =3D has_mm;
> > +             __entry->target_mask_weight =3D cpumask_weight(cmask);
> > +             __assign_cpumask(target_cpus, cpumask_bits(cmask));
> > +             __entry->scope =3D scope;
> > +             __entry->path =3D path;
> > +     ),
> > +
> > +     TP_printk("start=3D%#lx size=3D%#lx stride=3D%#lx asid=3D%#lx has=
_mm=3D%d target_mask_weight=3D%u target_cpus=3D%s scope=3D%s path=3D%s",
> > +               __entry->start, __entry->size, __entry->stride,
> > +               __entry->asid, __entry->has_mm,
> > +               __entry->target_mask_weight, __get_cpumask(target_cpus)=
,
> > +               show_riscv_tlb_flush_scope(__entry->scope),
> > +               show_riscv_tlb_flush_path(__entry->path))
> > +);
> > +
> > +#endif /* _TRACE_RISCV_TLB_H */
> > +
> > +/* This part must be outside protection. */
> > +#include <trace/define_trace.h>
> >
> > ---
> > base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
> > change-id: 20260829-tlb_tracepoint-844105ab5092
> >
> > Best regards,
> > --
> > Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Kind regards,
Roman 'Hedin' Storozhenko
