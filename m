Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3683451CD;
	Sat, 10 Oct 2026 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791607450; cv=none; b=mZ43oK2hGWILljkBozG1ZQm6aB8jLh+ZynNDZreeKhLCSOWxJkyfQflLAS0/xieoJV/n/FqGw8B6PaA35eXLbcmeiRzNRjIFfx0clYgt9LbdigOj8ng/4G/wEr8oh++kP4AXXkI+GuMEcrBPf3THvpp8SaSYKN5Ao/IZ2gTHBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791607450; c=relaxed/simple;
	bh=60Xg+Znf6szgugJ7bG5+TAZ+Cw98UOVmF0nnykgJW/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pdur9IxfqIAyTbeGqeuK4OgjTXSdrdsccrmzVrV2s73wqCl6K3F6aP7WjHBrioNksXdJKr+D8EtPc8qyvaQ695l43gRGe5ccYPcjp8nKlSy+5k6RmCrtBD4NlJml6rLzxuJRxbT5wmRMQgYxH33A4GHhgGF8VGbDXsJ7Sl5LCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBxLWkiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBxLWkiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864141F000FF;
	Sat, 10 Oct 2026 04:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791607447;
	bh=xT7/Mi0qaqXIyk87RL5CcE2mpYwJiPSzCU7XHgZqedQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBxLWkiGrCVAEX3PNuWknOyibUZZGtpRgl5RTrsUWy5pXm2zUdT5OpkBcc9sguxwM
	 txaXiLDGK7tFYh8LFWrBG6QyTkQ3YP+SfzXOn+9xZjef1UiqJIcqmK++OWh52YRCSB
	 NyFwe/BhdmllXqgC5IVVtpu4h/V8YG0XB6oIkd7ciXpKb9ScRpCz18kB3ZwEcz2vs8
	 +tIj3Y440fp20HJGfT6azX3ejaqLm95t2TaCx3V2wbZK/1UW+2j12bLPkYnkn7Fpet
	 zrrH9fKYdyQvpQ0fncq8RJSnflOmIJvrTsxXbWZpx5V6TV/wioZfDNRdH2E2GvB3pA
	 g6/If0HdL/k5A==
Date: Sat, 10 Oct 2026 12:24:04 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
Message-ID: <asm95GdbmMpc81p3@xhacker>
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com>
 <ar_Rathmoj2aP-H7@xhacker>
 <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>

On Sat, Oct 03, 2026 at 10:54:44AM +0200, Roman Storozhenko wrote:
> On Fri, Oct 2, 2026 at 6:04 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Sun, Aug 30, 2026 at 04:36:37PM +0200, Roman 'Hedin' Storozhenko wrote:
> > > Make RISC-V TLB flush path selection observable. Record whether Linux
> > > handles an invalidation locally, delegates it to SBI RFENCE, or executes
> > > it through a cross-CPU call, so MM activity can be correlated with the
> > > RISC-V, firmware, or Linux cross-CPU path carrying the request.
> >
> > I didn't see too much usefullness of the trace here. why not use kprobe
> > instead? can you plz show a real usage example of the trace? Which
> > bug/performance problem can be solved conveniently with this trace only?
> >
> > From another side, except x86, other architectures don't have the trace
> > in the TLB path.
> >
> 
> Hi Jisheng,
> 
> Thanks for the review. I agree that the current commit message describes
> the intended use rather abstractly.
> 
> A kprobe can certainly be used to investigate this. My motivation
> for a tracepoint is not that dynamic tracing cannot obtain the
> information, but that doing so requires knowledge of the current
> implementation and reconstruction of a semantic decision made inside
> __flush_tlb_range() / flush_tlb_all().

I prefer aligning with other architectures(except x86), I.E not
add this kind of trace. However, I would leave the decision to riscv
maintainers.

FYI, you may notice that the riscv trace overhead is not trivial per 
https://lore.kernel.org/linux-riscv/20250619190315.2603194-4-rkrcmar@ventanamicro.com/

> 
> For example, probing __flush_tlb_range() gives the request context, but
> not directly the path subsequently selected. To determine whether the
> request was handled locally, delegated through SBI RFENCE, or executed
> through Linux cross-CPU coordination, a tracing tool needs to
> probe/correlate implementation-specific call sites, or reproduce the
> selection logic itself.
> 
> The intent of the proposed event is to expose that semantic decision
> directly, together with the target CPU mask and request context, rather
> than make users depend on the current helper names and call graph.
> 
> One concrete RISC-V example is commit ae9e9f3d67dc:
> 
>   "RISC-V: clear hot-unplugged cores from all task mm_cpumasks
>    to avoid rfence errors"
> 
> In that case an offline CPU could remain in mm_cpumask(), which was then
> used as the target of an SBI RFENCE request. OpenSBI checks the requested
> hart mask against online harts, so such a request could fail.
> 
> With this event, such a situation could expose, for example:
> 
>   target_cpus=0,3 target_mask_weight=2 scope=range path=sbi-rfence
> 
> while CPU3 is already offline.
> 
> That shows that Linux constructed an unexpected target mask before the
> request was handed to firmware, so the investigation can first focus on
> Linux's mm CPU tracking rather than starting inside the SBI
> implementation.
> 
> There is also a performance-debugging use case. Real-world latency
> investigations have found TLB shootdowns responsible for significant
> latency spikes; for example:
> 
>   https://www.jabperf.com/how-to-deter-or-disarm-tlb-shootdowns/
> 
> That particular case eventually identified automatic NUMA balancing as
> the source of excessive shootdowns. I am not claiming that this proposed
> event alone would identify that root cause. On RISC-V, once TLB
> shootdowns have been identified as relevant, the event provides the
> architecture-specific next step: which CPUs Linux targeted, and whether
> Linux selected local handling, SBI RFENCE, or Linux cross-CPU
> coordination.
> 
> This distinction also helps separate where to investigate next. For an
> otherwise similar MM request:
> 
>   path=sbi-rfence
> 
> points toward firmware/platform handling after Linux delegates the
> request, while:
> 
>   path=cross-cpu-call
> 
> points toward Linux cross-CPU/IPI handling and target-CPU activity.
> 
> An unexpectedly broad target_cpus mask can similarly indicate that the
> cost comes from Linux targeting more CPUs than expected rather than from
> the execution time of the selected mechanism itself.
> 
> I also put the workloads used to exercise the event here:
> 
>   https://github.com/Romeus/tlb_workloads
> 
> They provide reproducible examples using the same 64-page mprotect()
> request with different CPU footprints/configurations. I used them to
> exercise local, SBI RFENCE, and cross-CPU-call paths.
> 
> I am not claiming that a tracepoint by itself solves these bugs, or that
> the same information is impossible to obtain with kprobes. The intended
> value is to expose the RISC-V TLB path-selection decision and its target
> context in one semantic record, without requiring each tracing tool to
> reconstruct that decision from implementation-specific probes.
> 
> I also take your point that, apart from x86, architectures generally do
> not currently have permanent tracing in the TLB path. If the use case is
> considered sufficient for a tracepoint, I will rework the commit message
> to make the concrete motivation and the distinction from dynamic
> probing clearer.
> 
> For context, I also posted an unchanged v2 RESEND on Sep 24; this reply
> is on the original v2 thread where your review landed.
> https://lore.kernel.org/lkml/20260924-tlb_tracepoint-v2-1-4e3e78ef5cdb@gmail.com/
> 
> Thanks,
> Roman
> 
> > >
> > > The generic tlb:tlb_flush event describes TLB flush activity using
> > > architecture-independent reason and page-count information. The RISC-V
> > > implementation subsequently selects between local invalidation, SBI
> > > RFENCE, and Linux cross-CPU coordination, with additional
> > > architecture-specific request context available at that point.
> > >
> > > Making this selection observable is useful when debugging RISC-V TLB
> > > shootdowns. When a remote invalidation is observed to be slow, the
> > > selected path determines whether to investigate SBI firmware and
> > > platform handling or Linux cross-CPU and IPI handling. An unexpectedly
> > > broad target mask can reveal an unintended address-space CPU footprint,
> > > while the range and stride distinguish invalidation requests with
> >
> > > different mapping granularities.
> > >
> > > Place the event in the RISC-V implementation because the local, SBI
> > > RFENCE, or cross-CPU choice is made there, and SBI RFENCE and the
> > > invalidation stride are RISC-V-specific semantics rather than properties
> > > of the generic MM flush request.
> > >
> > > Add riscv_tlb:riscv_tlb_flush_path in flush_tlb_all() and
> > > __flush_tlb_range(). Record start, size, stride, the hardware-visible
> > > ASID, whether a specific mm is associated with the request, the target
> > > CPU mask and its weight, the requested scope, and the selected path.
> >
> >
> > >
> > > Record the complete target mask in addition to its weight because CPU
> > > identity cannot be reconstructed from a count and is needed to correlate
> > > the request with per-CPU scheduler, IPI, and firmware activity.
> > >
> > > The event records the invalidation request and the path selected by Linux
> > > before the operation is dispatched. In particular, selecting the SBI
> > > RFENCE path means that Linux delegated the request to firmware; the event
> > > does not describe the implementation or outcome of that delegated
> > > operation.
> > >
> > > Tested on QEMU virt with OpenSBI using local and shared-mm
> > > mprotect()/munmap() workloads. Local requests reported path=local,
> > > while remote requests reported path=sbi-rfence and were followed by the
> > > existing riscv:sbi_call RFENCE event.
> > >
> > > The cross-CPU-call path was tested with QEMU virt using APLIC+IMSIC.
> > > A MADV_PAGEOUT reclaim workload was used to exercise mm-independent
> > > global flushes. All reported path values (local, sbi-rfence and
> > > cross-cpu-call) and scope values (single, range, address-space and all)
> > > were observed.
> > >
> > > Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> > > ---
> > > Add a RISC-V tracepoint for observing the path selected by Linux for TLB
> > > invalidation requests: local invalidation, SBI RFENCE, or Linux
> > > cross-CPU coordination.
> > >
> > > The tracepoint is intended to make RISC-V TLB shootdown behavior easier
> > > to correlate with MM activity, CPU targeting, SBI calls, and IPI
> > > handling. The patch records the invalidation request context and the
> > > Linux path-selection decision before the operation is dispatched.
> > >
> > > The patch was tested on QEMU virt with both the SBI RFENCE path and an
> > > APLIC+IMSIC configuration. Local, SBI RFENCE, and cross-CPU-call paths
> > > were exercised. All reported scope values -- single, range,
> > > address-space, and all -- were also observed.
> > > ---
> > > Changes in v2:
> > > - Use trace_call__riscv_tlb_flush_path() after the explicit
> > >   trace_riscv_tlb_flush_path_enabled() check to avoid a second
> > >   tracepoint static-key test, as suggested by Steven Rostedt.
> > > - Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com
> > > ---
> > >  arch/riscv/mm/tlbflush.c         |  60 +++++++++++++++++++--
> > >  include/trace/events/riscv_tlb.h | 113 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 169 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > index 962db300a166..cefce9364bd2 100644
> > > --- a/arch/riscv/mm/tlbflush.c
> > > +++ b/arch/riscv/mm/tlbflush.c
> > > @@ -9,6 +9,9 @@
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/cpufeature.h>
> > >
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/riscv_tlb.h>
> > > +
> > >  #define has_svinval()        riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
> > >
> > >  /*
> > > @@ -63,6 +66,33 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > >       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> > >  }
> > >
> > > +static enum riscv_tlb_flush_scope
> > > +riscv_tlb_get_flush_scope(unsigned long size, unsigned long stride, bool has_mm)
> > > +{
> > > +     if (size == FLUSH_TLB_MAX_SIZE)
> > > +             return has_mm ? RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE :
> > > +                     RISCV_TLB_FLUSH_SCOPE_ALL;
> > > +
> > > +     return size <= stride ? RISCV_TLB_FLUSH_SCOPE_SINGLE :
> > > +             RISCV_TLB_FLUSH_SCOPE_RANGE;
> > > +}
> > > +
> > > +static __always_inline void
> > > +riscv_tlb_trace_flush_path(const struct cpumask *cmask, unsigned long start,
> > > +                        unsigned long size, unsigned long stride,
> > > +                        unsigned long asid, bool has_mm,
> > > +                        enum riscv_tlb_flush_path path)
> > > +{
> > > +     enum riscv_tlb_flush_scope scope;
> > > +
> > > +     if (!trace_riscv_tlb_flush_path_enabled())
> > > +             return;
> > > +
> > > +     scope = riscv_tlb_get_flush_scope(size, stride, has_mm);
> > > +     trace_call__riscv_tlb_flush_path(start, size, stride, asid, has_mm,
> > > +                      cmask, scope, path);
> > > +}
> > > +
> > >  static void __ipi_flush_tlb_all(void *info)
> > >  {
> > >       local_flush_tlb_all();
> > > @@ -70,12 +100,26 @@ static void __ipi_flush_tlb_all(void *info)
> > >
> > >  void flush_tlb_all(void)
> > >  {
> > > -     if (num_online_cpus() < 2)
> > > +     if (num_online_cpus() < 2) {
> > > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > > +                                        FLUSH_TLB_NO_ASID, false,
> > > +                                        RISCV_TLB_FLUSH_PATH_LOCAL);
> > >               local_flush_tlb_all();
> > > -     else if (riscv_use_sbi_for_rfence())
> > > -             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
> > > -     else
> > > +     } else if (riscv_use_sbi_for_rfence()) {
> > > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > > +                                        FLUSH_TLB_NO_ASID, false,
> > > +                                        RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
> > > +             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE,
> > > +                                        FLUSH_TLB_NO_ASID);
> > > +     } else {
> > > +             riscv_tlb_trace_flush_path(cpu_online_mask, 0,
> > > +                                        FLUSH_TLB_MAX_SIZE, 0,
> > > +                                        FLUSH_TLB_NO_ASID, false,
> > > +                                        RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
> > >               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> > > +     }
> > >  }
> > >
> > >  struct flush_tlb_range_data {
> > > @@ -107,12 +151,20 @@ static void __flush_tlb_range(struct mm_struct *mm,
> > >
> > >       /* Check if the TLB flush needs to be sent to other CPUs. */
> > >       if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
> > > +             riscv_tlb_trace_flush_path(cmask, start, size, stride, asid,
> > > +                                        !!mm, RISCV_TLB_FLUSH_PATH_LOCAL);
> > >               local_flush_tlb_range_asid(start, size, stride, asid);
> > >       } else if (riscv_use_sbi_for_rfence()) {
> > > +             riscv_tlb_trace_flush_path(cmask, start, size, stride, asid,
> > > +                                        !!mm, RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
> > >               sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> > >       } else {
> > >               struct flush_tlb_range_data ftd;
> > >
> > > +             riscv_tlb_trace_flush_path(cmask, start, size, stride, asid,
> > > +                                        !!mm,
> > > +                                        RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
> > > +
> > >               ftd.asid = asid;
> > >               ftd.start = start;
> > >               ftd.size = size;
> > > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/riscv_tlb.h
> > > new file mode 100644
> > > index 000000000000..3eff171ec54f
> > > --- /dev/null
> > > +++ b/include/trace/events/riscv_tlb.h
> > > @@ -0,0 +1,113 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM riscv_tlb
> > > +
> > > +#if !defined(_TRACE_RISCV_TLB_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_RISCV_TLB_H
> > > +
> > > +#include <linux/cpumask.h>
> > > +#include <linux/tracepoint.h>
> > > +
> > > +#ifndef _TRACE_RISCV_TLB_ENUMS
> > > +#define _TRACE_RISCV_TLB_ENUMS
> > > +
> > > +enum riscv_tlb_flush_scope {
> > > +     RISCV_TLB_FLUSH_SCOPE_SINGLE,
> > > +     RISCV_TLB_FLUSH_SCOPE_RANGE,
> > > +     RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
> > > +     RISCV_TLB_FLUSH_SCOPE_ALL,
> > > +};
> > > +
> > > +enum riscv_tlb_flush_path {
> > > +     RISCV_TLB_FLUSH_PATH_LOCAL,
> > > +     RISCV_TLB_FLUSH_PATH_SBI_RFENCE,
> > > +     RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL,
> > > +};
> > > +
> > > +#endif /* _TRACE_RISCV_TLB_ENUMS */
> > > +
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> > > +
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_LOCAL);
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
> > > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
> > > +
> > > +#define show_riscv_tlb_flush_scope(scope) \
> > > +     __print_symbolic(scope, \
> > > +             { RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> > > +             { RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> > > +             { RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" }, \
> > > +             { RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> > > +
> > > +#define show_riscv_tlb_flush_path(path) \
> > > +     __print_symbolic(path, \
> > > +             { RISCV_TLB_FLUSH_PATH_LOCAL,          "local" }, \
> > > +             { RISCV_TLB_FLUSH_PATH_SBI_RFENCE,     "sbi-rfence" }, \
> > > +             { RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL, "cross-cpu-call" })
> > > +
> > > +/*
> > > + * Record the invalidation request received by the RISC-V architecture code
> > > + * and the path selected by Linux.
> > > + *
> > > + * The target CPU mask represents the CPUs Linux intends to cover for the
> > > + * request. It can be correlated with per-CPU activity, but does not describe
> > > + * which harts ultimately performed an invalidation.
> > > + *
> > > + * The ASID is hardware-visible and may be reused. It must not be treated as a
> > > + * persistent identifier for an mm.
> > > + *
> > > + * The stride describes the invalidation granularity supplied to the RISC-V
> > > + * implementation. SBI RFENCE receives start, size and ASID, but not stride.
> > > + *
> > > + * The event is emitted at path selection time. For SBI RFENCE, it records
> > > + * delegation of the request to firmware; firmware processing after that
> > > + * point is outside the event's scope.
> > > + */
> > > +TRACE_EVENT(riscv_tlb_flush_path,
> > > +     TP_PROTO(unsigned long start, unsigned long size,
> > > +              unsigned long stride, unsigned long asid, bool has_mm,
> > > +              const struct cpumask *cmask,
> > > +              enum riscv_tlb_flush_scope scope,
> > > +              enum riscv_tlb_flush_path path),
> > > +
> > > +     TP_ARGS(start, size, stride, asid, has_mm, cmask, scope, path),
> > > +
> > > +     TP_STRUCT__entry(
> > > +             __field(unsigned long, start)
> > > +             __field(unsigned long, size)
> > > +             __field(unsigned long, stride)
> > > +             __field(unsigned long, asid)
> > > +             __field(bool, has_mm)
> > > +             __field(unsigned int, target_mask_weight)
> > > +             __cpumask(target_cpus)
> > > +             __field(u8, scope)
> > > +             __field(u8, path)
> > > +     ),
> > > +
> > > +     TP_fast_assign(
> > > +             __entry->start = start;
> > > +             __entry->size = size;
> > > +             __entry->stride = stride;
> > > +             __entry->asid = asid;
> > > +             __entry->has_mm = has_mm;
> > > +             __entry->target_mask_weight = cpumask_weight(cmask);
> > > +             __assign_cpumask(target_cpus, cpumask_bits(cmask));
> > > +             __entry->scope = scope;
> > > +             __entry->path = path;
> > > +     ),
> > > +
> > > +     TP_printk("start=%#lx size=%#lx stride=%#lx asid=%#lx has_mm=%d target_mask_weight=%u target_cpus=%s scope=%s path=%s",
> > > +               __entry->start, __entry->size, __entry->stride,
> > > +               __entry->asid, __entry->has_mm,
> > > +               __entry->target_mask_weight, __get_cpumask(target_cpus),
> > > +               show_riscv_tlb_flush_scope(__entry->scope),
> > > +               show_riscv_tlb_flush_path(__entry->path))
> > > +);
> > > +
> > > +#endif /* _TRACE_RISCV_TLB_H */
> > > +
> > > +/* This part must be outside protection. */
> > > +#include <trace/define_trace.h>
> > >
> > > ---
> > > base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
> > > change-id: 20260829-tlb_tracepoint-844105ab5092
> > >
> > > Best regards,
> > > --
> > > Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> -- 
> Kind regards,
> Roman 'Hedin' Storozhenko
