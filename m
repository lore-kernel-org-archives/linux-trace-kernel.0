Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613063;
	b=cibfPfKYVsnxV5XoJo5ONwYWxcK6N9DAgCeHCH63++EcB+jHKK0QSViLmR6GY+Gc82MS
	 ZCb+Eo+8FvjdLICzvvjFQMVtjb86weB5RfOlYXW9CRdni0JXT5idSwQxZj7AKDzJ9hA1P
	 bOl0KLR4dh76cOQ8VdzplZXCTbI8kFgB4sOD6DwWeR/umZJxGxOBVoy9lr3Hz9dUhNIJ/
	 pYRb7wKNMNfxGWMLkEyh5YCYIToV3zU0gzZqLcCRUyiZHUWQ03L+2cLFBLVblhoA7i92+
	 brbZ6OUbrlMK+zzhlJNl/RzUNigq2JolV4LKul5tZkrrd5S0N0FmSBaq8vI7btTkTXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613063;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YLE1Bl5J5RjYqAMTMVsCbfJY9agCq5jvI6bufzbFxSU=;
	b=bhQaWSC2+Jnc4ZoSSyUgHhlcsaeBopxOAGHg610A+haBtf+uWfCAE+TdJe2QlMBWRJZX
	 UI2Mx/65M4/F/v0GrQQ4P+Opf8b8yxNIvxHopQVCLHtBI82dTU+fApzD5WSgJqed2P0h9
	 AeUUUpE2WhHBW5yq0DlpDxRslA0RsfocDI1K4s6PYPgyUsny9vwtJ4EyfpfEeOtRK8b66
	 k8Nj8Z3KJtCwrMYnFNOQlvPPjR0fy7aNiZF56k3VesS/zpKf1/qw9xPTjiD986t8eFTYR
	 gvIb4JBL5c8d1wL02fc8Q61m1kwtc0R9MVGXOUNRHGNPD8g0FMzwcEOi045P22zp9Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9bW1DWp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD764606A686;
	Wed, 25 Nov 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9bW1DWp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A781F000EC;
	Wed, 25 Nov 2026 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613062;
	bh=YLE1Bl5J5RjYqAMTMVsCbfJY9agCq5jvI6bufzbFxSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T9bW1DWpO3+XLqY1yM0WpoAyuaRW7+L6jXCvoC+6B6/rmrJ3Ct5iTXGl0fWQaRsRJ
	 8qBXg2r+qcP99Lv3ZNjwfAMoiAyMRYsRcmfwnJQhK7iWnYOdh2fWjnlmsPd/zsD/yX
	 jSNBzNWOGMAbrNAZKCTHI5kFDWjfW12TqHwzf6ZVPf8NoTzp/bbPmtn+Ib4K7X6do2
	 FC8THwQ8onIfDosJp1Pa364Htcb4usQRuDnxyGAlI/tT1Ib8k2myZeqKlVlsG+uo3A
	 7SEn6n/uHI1UlT68rHwFWBJvT/ZVU76xVUzl4Pn/QvAvpz69k+q0nL1H/az14o9XyP
	 1EluBbL0Eu0lw==
Date: Wed, 25 Nov 2026 21:04:00 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8] riscv: mm: Trace TLB flush requests
Message-ID: <awbcwAG4OeZbZKV5@xhacker>
References: <20261125-tlb_tracepoint-v8-1-18abde32ef0a@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125-tlb_tracepoint-v8-1-18abde32ef0a@gmail.com>

On Wed, Nov 25, 2026 at 11:41:52AM +0100, Roman 'Hedin' Storozhenko wrote:
> Make RISC-V TLB flush requests observable together with the
> architecture-specific context available when the request reaches
> the RISC-V implementation.
> 
> The generic tlb:tlb_flush event provides reason and page-count
> information. At the RISC-V implementation level, additional
> context is available, including the invalidation range and stride,
> ASID, target CPU mask, and invalidation scope.

These info can be got w/o tracepoint. So I still object adding this
trace point due to non-trivial tracepoint overhead on riscv with up
to at least gcc15

> 
> This context is useful for debugging and workload analysis. The
> target CPU mask shows the address-space CPU footprint involved in
> an invalidation, while range and stride distinguish requests at
> different mapping granularities. The ASID and scope help correlate
> requests with MM, scheduler, IPI, and firmware activity.
> 
> Add riscv_tlb:riscv_tlb_flush_request in flush_tlb_all() and
> __flush_tlb_range(). Record start, size, stride, ASID (or the
> no-ASID sentinel), whether an mm is associated with the request,
> the target CPU mask and its weight, and the derived scope.
> 
> Record the complete target mask because CPU identity cannot be
> reconstructed from a count. Calculate its weight from the recorded
> bitmap so both fields agree even if mm_cpumask() changes during
> recording.
> 
> The event describes an invalidation request before dispatch. It
> does not report whether a remote flush uses SBI RFENCE or Linux
> cross-CPU coordination, since that choice is effectively established
> during initialization rather than made for each request.
> 
> The address field (start) may contain kernel virtual addresses
> for flushes involving kernel mappings. Require perf tracepoint
> permissions even for counting-only events, since perf filters
> could otherwise reveal address information through event counts.
> 
> Tested on QEMU virt with OpenSBI using local and shared-mm
> mprotect()/munmap() workloads, exercising single, range, and
> address-space invalidations. A MADV_PAGEOUT reclaim workload
> exercised global flushes. All four scope values were observed.
> 
> Confirmed that trace-cmd records the event and that perf can count
> it with sufficient privileges. With perf_event_paranoid=0,
> unprivileged attempts to count the event using perf were denied,
> as intended.
> 
> Document the event fields, request semantics, limitations, and
> usage through tracefs and userspace tracing tools.
> 
> Tested local and shared-mm invalidations with
> CONFIG_UBSAN_ALIGNMENT=y on QEMU virt without tracepoint-related
> alignment warnings.
> 
> Built with and without CONFIG_PERF_EVENTS.
> 
> Built and verified the RISC-V HTML documentation.
> 
> Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> ---
> Add a RISC-V tracepoint for observing TLB invalidation requests
> before they are dispatched by the architecture-specific
> implementation.
> 
> The generic tlb:tlb_flush event describes TLB flush activity using
> reason and page-count information. The RISC-V event records
> additional context, including the invalidation range and stride,
> ASID, target CPU mask and its weight, and derived request scope.
> 
> This context helps correlate TLB invalidation activity with MM,
> scheduler, IPI, and firmware activity. The event describes the
> request rather than the execution backend. SBI RFENCE versus Linux
> cross-CPU coordination is effectively determined at initialization
> rather than selected independently for each request.
> 
> The target CPU mask weight is derived from the recorded bitmap to
> keep both fields consistent under concurrent mm_cpumask() updates.
> Since the address field (start) may contain kernel virtual
> addresses, the event requires perf tracepoint permissions even
> for counting-only access.
> 
> Tested on QEMU virt with OpenSBI using local and shared-mm
> mprotect()/munmap() workloads. A MADV_PAGEOUT reclaim workload
> on QEMU virt with APLIC+IMSIC exercised global flushes. All four
> scope values -- single, range, address-space, and all -- were
> observed.
> 
> Confirmed trace-cmd recording and privileged perf counting.
> With perf_event_paranoid=0, unprivileged attempts to count the
> event using perf were denied, as intended. The kernel was built
> with and without CONFIG_PERF_EVENTS.
> 
> Tested local and shared-mm invalidations with
> CONFIG_UBSAN_ALIGNMENT=y on QEMU virt without tracepoint-related
> alignment warnings.
> ---
> Changes in v8:
> - Rebase on the current RISC-V for-next branch (c9b3feb61e61)
> - Add documentation describing the trace event fields, request
>   semantics, limitations, and usage.
> - Link to v7: https://lore.kernel.org/r/20261019-tlb_tracepoint-v7-1-4cc3e99d387a@gmail.com
> 
> Changes in v7:
> - Rename the tracepoint header to asm/tlb_trace.h to make its
>   purpose explicit, as suggested by Steven Rostedt.
> - Link to v6: https://lore.kernel.org/r/20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com
> 
> Changes in v6:
> - Change the scope field from u8 to u32 to ensure the dynamic
>   CPU mask is properly aligned for bitmap operations.
> - Verify local and shared-mm TLB flush tracing with
>   CONFIG_UBSAN_ALIGNMENT=y on QEMU virt.
> - Link to v5: https://lore.kernel.org/r/20261017-tlb_tracepoint-v5-1-256fb5393a7f@gmail.com
> 
> Changes in v5:
> - Move the architecture-specific trace event definition under
>   arch/riscv/, as requested by Steven Rostedt.
> - Calculate target_mask_weight from the recorded CPU mask to
>   keep both fields consistent under concurrent updates.
> - Require perf tracepoint permissions for counting-only access,
>   since the event may expose kernel virtual addresses.
> - Link to v4: https://lore.kernel.org/r/20261015-tlb_tracepoint-v4-1-f238a2bd8f7e@gmail.com
> 
> Changes in v4:
> - Drop unrelated whitespace-only changes in arch/riscv/mm/tlbflush.c.
> - Link to v3: https://lore.kernel.org/all/20261015-tlb_tracepoint-v3-1-eef305a3bb63@gmail.com/
> 
> Changes in v3:
> - Rebase on current RISC-V for-next.
> - Thanks to Jisheng Zhang for pointing out that SBI RFENCE versus Linux
>   cross-CPU coordination is effectively a system-wide choice established
>   during initialization rather than a per-request decision.
> - Drop the local/SBI RFENCE/cross-CPU path field.
> - Rename the event from riscv_tlb_flush_path to
>   riscv_tlb_flush_request and refocus it on the semantic TLB
>   invalidation request.
> - Emit one request event independently of the mechanism subsequently
>   used to perform the invalidation.
> - Address checkpatch.pl --strict alignment issues.
> - Link to v2: https://lore.kernel.org/r/20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com
> 
> Changes in v2:
> - Use trace_call__riscv_tlb_flush_path() after the explicit
>   trace_riscv_tlb_flush_path_enabled() check to avoid a second
>   tracepoint static-key test, as suggested by Steven Rostedt.
> - Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com
> ---
>  Documentation/arch/riscv/index.rst     |   1 +
>  Documentation/arch/riscv/tlb-trace.rst | 137 +++++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/tlb_trace.h     | 103 +++++++++++++++++++++++++
>  arch/riscv/mm/tlbflush.c               |  45 ++++++++++-
>  4 files changed, 282 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
> index ac535c52d509..a5450811e4af 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -9,6 +9,7 @@ RISC-V architecture
>      boot
>      boot-image-header
>      vm-layout
> +    tlb-trace
>      hwprobe
>      patch-acceptance
>      uabi
> diff --git a/Documentation/arch/riscv/tlb-trace.rst b/Documentation/arch/riscv/tlb-trace.rst
> new file mode 100644
> index 000000000000..c664df20d7ef
> --- /dev/null
> +++ b/Documentation/arch/riscv/tlb-trace.rst
> @@ -0,0 +1,137 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +RISC-V TLB Flush Tracing
> +========================
> +
> +Overview
> +========
> +
> +The RISC-V Linux kernel provides the
> +``riscv_tlb:riscv_tlb_flush_request`` trace event to observe TLB
> +invalidation requests at the architecture-specific implementation.
> +The event records the virtual address range, stride, ASID, target CPU
> +mask, and derived request scope.
> +
> +This information can help correlate TLB invalidation requests with
> +memory management, scheduler, IPI, and firmware activity. The event
> +reports the request before dispatch; it does not identify the mechanism
> +used to carry it out or confirm that a particular hart invalidated its
> +TLB. In particular, it does not distinguish SBI RFENCE from Linux
> +cross-CPU coordination.
> +
> +Event fields
> +============
> +
> +``start``
> +    Starting virtual address supplied with the invalidation request.
> +    It is not a meaningful range boundary for a full global flush.
> +    Requests involving kernel mappings may contain kernel virtual
> +    addresses.
> +
> +``size``
> +    Size of the requested range in bytes. ``FLUSH_TLB_MAX_SIZE``
> +    denotes a full-range invalidation.
> +
> +``stride``
> +    Invalidation granularity supplied to the RISC-V implementation.
> +    It may be zero for a full global flush.
> +
> +``asid``
> +    Address-space identifier, or ``FLUSH_TLB_NO_ASID`` when no ASID
> +    is specified. ASIDs can be reused and must not be treated as
> +    persistent identifiers of address spaces.
> +
> +``has_mm``
> +    Whether the request is associated with an ``mm_struct``.
> +
> +``target_cpus``
> +    CPU mask associated with the request. For an mm-associated
> +    request, it reflects the relevant address-space CPU mask;
> +    for a global request, it reflects the online CPU mask supplied
> +    at the tracepoint. It does not prove which CPUs or harts
> +    actually performed an invalidation.
> +
> +``target_mask_weight``
> +    Number of CPUs in the recorded ``target_cpus`` bitmap.
> +
> +``scope``
> +    Derived invalidation scope:
> +
> +    * ``single``: a range no larger than one stride.
> +    * ``range``: a range larger than one stride.
> +    * ``address-space``: a full-range request with an associated
> +      ``mm_struct``.
> +    * ``all``: a full-range request without an associated
> +      ``mm_struct``.
> +
> +Using the event
> +===============
> +
> +The event is available through tracefs when kernel event tracing is
> +configured. The commands below assume tracefs is mounted at
> +``/sys/kernel/tracing`` and are run with sufficient privileges.
> +
> +Inspect the available event fields::
> +
> +    # cat /sys/kernel/tracing/events/riscv_tlb/riscv_tlb_flush_request/format
> +
> +To record requests, clear the current trace buffer and enable the event::
> +
> +    # cd /sys/kernel/tracing
> +    # echo > trace
> +    # echo 1 > events/riscv_tlb/riscv_tlb_flush_request/enable
> +
> +Run a workload that changes memory mappings or permissions, for example
> +one using ``munmap()`` or ``mprotect()``. Then disable the event and
> +read the buffer::
> +
> +    # echo 0 > events/riscv_tlb/riscv_tlb_flush_request/enable
> +    # cat trace
> +
> +``trace_pipe`` can be used instead of ``trace`` to consume events as
> +they occur. Clearing ``trace`` affects the current tracing instance;
> +avoid doing so while another tracing session is using it.
> +
> +Example output
> +==============
> +
> +The following lines were captured in separate QEMU ``virt`` test runs.
> +Addresses, ASIDs, CPU masks, and timestamps depend on the workload and
> +system configuration::
> +
> +    tlb_workload-ri-290 [000] ...5. 748.436198: riscv_tlb_flush_request: start=0xfffffffffff000 size=0x1000 stride=0x1000 asid=0x158 has_mm=1 target_mask_weight=1 target_cpus=00000000,00000001 scope=single
> +    tlb_workload-ri-290 [000] ...1. 748.580051: riscv_tlb_flush_request: start=0x7fff891e2000 size=0x20000 stride=0x1000 asid=0x158 has_mm=1 target_mask_weight=2 target_cpus=00000000,00000003 scope=range
> +    tlb_scope_all-r-309 [000] ...1. 986.214468: riscv_tlb_flush_request: start=0 size=0xffffffffffffffff stride=0x1000 asid=0xffffffffffffffff has_mm=0 target_mask_weight=3 target_cpus=0-2 scope=all
> +
> +The first request covers one 4 KiB stride. The second covers a 128 KiB
> +range and records two target CPUs (mask ``0x3``). The last is an
> +mm-independent full-range request; its target mask includes CPUs 0-2.
> +The different CPU-mask representations reflect tracing output options.
> +
> +Userspace tools
> +---------------
> +
> +The event may also be recorded with the external ``trace-cmd`` tool::
> +
> +    # trace-cmd record -e riscv_tlb:riscv_tlb_flush_request ./workload
> +    # trace-cmd report
> +
> +It is also accessible to perf and other tools supporting kernel trace
> +events, subject to access permissions. For general tracefs usage and
> +event filtering, see ``Documentation/trace/events.rst``.
> +
> +Limitations
> +===========
> +
> +This event describes a Linux TLB invalidation request, not hardware TLB
> +state, the execution path within firmware, or completion of remote
> +invalidation operations.
> +
> +The recorded CPU mask and its weight agree, but copying a concurrently
> +changing mask does not provide an atomic snapshot of all CPU or
> +address-space state.
> +
> +Since the event can contain kernel virtual addresses, access to its
> +trace data must be appropriately restricted. Perf access permissions
> +also apply to counting-only use of this event.
> diff --git a/arch/riscv/include/asm/tlb_trace.h b/arch/riscv/include/asm/tlb_trace.h
> new file mode 100644
> index 000000000000..60b48eb0d355
> --- /dev/null
> +++ b/arch/riscv/include/asm/tlb_trace.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM riscv_tlb
> +
> +#if !defined(_TRACE_RISCV_TLB_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RISCV_TLB_TRACE_H
> +
> +#include <linux/cpumask.h>
> +#include <linux/tracepoint.h>
> +#include <linux/perf_event.h>
> +
> +#ifndef _TRACE_RISCV_TLB_ENUMS
> +#define _TRACE_RISCV_TLB_ENUMS
> +
> +enum riscv_tlb_flush_scope {
> +	RISCV_TLB_FLUSH_SCOPE_SINGLE,
> +	RISCV_TLB_FLUSH_SCOPE_RANGE,
> +	RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
> +	RISCV_TLB_FLUSH_SCOPE_ALL,
> +};
> +
> +#endif /* _TRACE_RISCV_TLB_ENUMS */
> +
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> +
> +#define show_riscv_tlb_flush_scope(scope) \
> +	__print_symbolic(scope, \
> +		{ RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> +		{ RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> +		{ RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" }, \
> +		{ RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> +
> +/*
> + * Record the invalidation request received by the RISC-V architecture code
> + *
> + * The target CPU mask represents the CPUs Linux intends to cover for the
> + * request. It can be correlated with per-CPU activity, but does not describe
> + * which harts ultimately performed an invalidation.
> + *
> + * The ASID is hardware-visible and may be reused. It must not be treated as a
> + * persistent identifier for an mm.
> + *
> + * The stride describes the invalidation granularity supplied to the RISC-V
> + * implementation.
> + *
> + * The event records the invalidation request before it is dispatched. It does
> + * not describe the mechanism used to execute the request.
> + *
> + */
> +TRACE_EVENT(riscv_tlb_flush_request,
> +	    TP_PROTO(unsigned long start, unsigned long size,
> +		     unsigned long stride, unsigned long asid, bool has_mm,
> +		     const struct cpumask *cmask,
> +		     enum riscv_tlb_flush_scope scope),
> +
> +	TP_ARGS(start, size, stride, asid, has_mm, cmask, scope),
> +
> +	TP_STRUCT__entry(__field(unsigned long, start)
> +		__field(unsigned long, size)
> +		__field(unsigned long, stride)
> +		__field(unsigned long, asid)
> +		__field(bool, has_mm)
> +		__field(unsigned int, target_mask_weight)
> +		__cpumask(target_cpus)
> +		__field(u32, scope)
> +	),
> +
> +	TP_fast_assign(__entry->start = start;
> +		__entry->size = size;
> +		__entry->stride = stride;
> +		__entry->asid = asid;
> +		__entry->has_mm = has_mm;
> +		__assign_cpumask(target_cpus, cpumask_bits(cmask));
> +		__entry->target_mask_weight = cpumask_weight((const struct cpumask *)
> +						     __get_cpumask(target_cpus));
> +		__entry->scope = scope;
> +	),
> +
> +	TP_printk("start=%#lx size=%#lx stride=%#lx asid=%#lx has_mm=%d target_mask_weight=%u target_cpus=%s scope=%s",
> +		  __entry->start, __entry->size, __entry->stride,
> +		  __entry->asid, __entry->has_mm,
> +		  __entry->target_mask_weight, __get_cpumask(target_cpus),
> +		  show_riscv_tlb_flush_scope(__entry->scope))
> +);
> +
> +#ifdef CONFIG_PERF_EVENTS
> +TRACE_EVENT_PERF_PERM(riscv_tlb_flush_request,
> +		      perf_allow_tracepoint());
> +#endif
> +
> +#endif /* _TRACE_RISCV_TLB_TRACE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH asm
> +#define TRACE_INCLUDE_FILE tlb_trace
> +
> +/* This part must be outside protection. */
> +#include <trace/define_trace.h>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index a74a7d5258aa..815867c34e18 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -9,6 +9,9 @@
>  #include <asm/mmu_context.h>
>  #include <asm/cpufeature.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <asm/tlb_trace.h>
> +
>  #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
>  
>  /*
> @@ -63,6 +66,32 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>  }
>  
> +static enum riscv_tlb_flush_scope
> +riscv_tlb_get_flush_scope(unsigned long size, unsigned long stride, bool has_mm)
> +{
> +	if (size == FLUSH_TLB_MAX_SIZE)
> +		return has_mm ? RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE :
> +			RISCV_TLB_FLUSH_SCOPE_ALL;
> +
> +	return size <= stride ? RISCV_TLB_FLUSH_SCOPE_SINGLE :
> +		RISCV_TLB_FLUSH_SCOPE_RANGE;
> +}
> +
> +static __always_inline void
> +riscv_tlb_trace_flush_request(const struct cpumask *cmask, unsigned long start,
> +			      unsigned long size, unsigned long stride,
> +			      unsigned long asid, bool has_mm)
> +{
> +	enum riscv_tlb_flush_scope scope;
> +
> +	if (!trace_riscv_tlb_flush_request_enabled())
> +		return;
> +
> +	scope = riscv_tlb_get_flush_scope(size, stride, has_mm);
> +	trace_call__riscv_tlb_flush_request(start, size, stride, asid, has_mm,
> +					    cmask, scope);
> +}
> +
>  static void __ipi_flush_tlb_all(void *info)
>  {
>  	local_flush_tlb_all();
> @@ -70,12 +99,18 @@ static void __ipi_flush_tlb_all(void *info)
>  
>  void flush_tlb_all(void)
>  {
> -	if (num_online_cpus() < 2)
> +	riscv_tlb_trace_flush_request(cpu_online_mask, 0,
> +				      FLUSH_TLB_MAX_SIZE, 0,
> +				      FLUSH_TLB_NO_ASID, false);
> +
> +	if (num_online_cpus() < 2) {
>  		local_flush_tlb_all();
> -	else if (riscv_use_sbi_for_rfence())
> -		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
> -	else
> +	} else if (riscv_use_sbi_for_rfence()) {
> +		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE,
> +					   FLUSH_TLB_NO_ASID);
> +	} else {
>  		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> +	}
>  }
>  
>  struct flush_tlb_range_data {
> @@ -105,6 +140,8 @@ static void __flush_tlb_range(struct mm_struct *mm,
>  
>  	cpu = get_cpu();
>  
> +	riscv_tlb_trace_flush_request(cmask, start, size, stride, asid, !!mm);
> +
>  	/* Check if the TLB flush needs to be sent to other CPUs. */
>  	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
>  		local_flush_tlb_range_asid(start, size, stride, asid);
> 
> ---
> base-commit: c9b3feb61e6134d61656e5ec2516de82ea0d0f27
> change-id: 20260829-tlb_tracepoint-844105ab5092
> 
> Best regards,
> -- 
> Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> 
