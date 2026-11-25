Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795621598;
	b=CQWrcJft986whRh3t9wTjxba7/7r+0sP1aXGhWs1DIYjQ2W0/BOrhD1fYRR0Hkav1E2N
	 oeoMNfklH6N1E+/1jRPREfRbRr0na73GHialZI/3vdRDCrszbrXfhoXQhFXCUBK4XuGLk
	 I/kAxRt7wW7uqGsXyn5mnFr/gJzsEnfDj4n+8fgqpp25SB6OKbO8C6zvTS5tmhRkw0Y7k
	 6xuL80Pg73TSsvlgbg6eAMv+E2XEsnufu6ZgzOoSbYSyZwVx4IOsmf26BJHUTXLFdY5vZ
	 TCFAbrJUQGjs4kbxabhqVccczoyuReQfX9QkyCNJchTg7UlpYJiIVj+4ARsEkC1zjNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BZunvmy1fHC4h3Ab8vKNRv552JTpc0JR4cx6FztQhsM=;
	b=kF9TuxYeDASrnlO4w9yc7bn+ihIZek/M/8GJ4KruNIAGcuiMDyS3NsIqFwEqqbeb828N
	 ih1lApC/eWu+uAjWs058X9VcRgH7Sfvz2P03jnie3s5wDtuJ/dJCT9DAIqR00sLP9gqXy
	 rd70MH/DG7qMFiK6E9slyPgytnXhtCq1+8ZGklhdeZz3GcTWuXFFQ+zDU3Uw6hYLQaddX
	 xUCMb0aF7/j911pdrE3WQdXgRhJeqCCmAHV0VJb7I3OLKvhD66+XI2XmXAHSczzoKPsXc
	 gYd17BgurHhL3HhOnQntWK5qpAeinZcVB4S8YqNjfaoEIux51oNenWdKH9Rv6hM7wHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeFe8tML;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802A606A682
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 15:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9802A606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeFe8tML
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67db35e7953so6116526d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 07:46:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795621596; cv=none;
        d=google.com; s=arc-20260327;
        b=Tb+pLml9wblBT3Juo/iZUxSifGRVL2PGCJw2O7G6XN0sz9fJBENzY/PGp1PLkM0bF/
         feWDBsqiUFFrXdLkkmdfhyLweUXSv9zciRHVLEegDKFI9A+vzPv0R4fNCQA3cJ/PiERB
         aenJnlTA5gDKmq/z0o8lTiWwssVb3mDQ9L1nbpeU8Xm0+fCUKgnoNWCTYAkBaoTfJ3/R
         YmHzT5O8sftTG2Eoav3hHiYoQVBPqLYVUPSeqSdy2zhW9vIdli4qOcInBw+xYq4175G9
         iJxFeiSbD6Db69nxd+oy5cwYH8plg1ZdRp1V4z4Uc8CI3L9Dv4S5NYUU019BgKfs8ABJ
         N7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BZunvmy1fHC4h3Ab8vKNRv552JTpc0JR4cx6FztQhsM=;
        fh=TaGlOahlPM5LR1rEwqeMPg78I1j02edVwMym0z/FKtI=;
        b=YWHEeEmdUyKDEuCNzDhKt5keNrkDh4SwTtVaoudTtirVLg4Wy9XlIuw3AEDrwPvqIB
         4l683pfdnQ/vvTGRDpFtKYsSZzNB1wcIe54jNuHMFUOsRl6frXXT+uO/6gBD27NeVHTx
         OrLVZsxfr3fuMwbW8lrMMlf2nRKKfMEq9BaXWm6Ly2pIi/Bw+6QiEPl5ghDQYlNvqJZN
         srsdpOT/FiPJ1tay2BO6/QfyFR7zkes8P3lQDVI5xgkAmWso8aSz+6Vq3WQgXQUGs+Jc
         x58yg5TwuZLeJLW98ewqB4ZjBzFEODEwfQJYfcJA5r568Mqu16Yh9eQZNbCe01Sq6Qxv
         jXMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795621596; x=1796226396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BZunvmy1fHC4h3Ab8vKNRv552JTpc0JR4cx6FztQhsM=;
        b=CeFe8tMLsbx5K2LClgIXsOvEjcn8waaRx06A/m97xF66z+yAznPLnZ1PehYQdMvw/u
         Mx6EnzGpfBRbVIHff3VcjcSAJNmYGLU+5UxZQ+WABwXD1Evj8oy67PgV870GRQYvK1qt
         CR80ZIX2HpCLeqDZFoM5Q8zx4t5JG58bZkcsFmUEuXBeQYnXal2X1dqnu56F4j82vvhb
         BNQmOIexP9h8Zyj83s2IOxg4DcZuZHuzMFOb5jNk+JG5KFW7gKUP+ekHd6I0Hcb29nNp
         /UAiNGgkdrClbPKY6iTksXJlXuDBj9BcNDPkZnfDUftXZcvNRegOuG/PXynfFiJhgBJa
         X+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795621596; x=1796226396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZunvmy1fHC4h3Ab8vKNRv552JTpc0JR4cx6FztQhsM=;
        b=1/Bm6EwLJ84pQXKhvyMlqutnr42zdu9GrS2MAeby1klIasV0BtG1lSck0ePRHv33Iv
         ieVT7AfGuifOezwing6ZFC+qwWwzxfqcilbpH3CWFYaOF6BMgCsoyY4cp37JrpPzmkXN
         Y7N4nM5lUgC4yoUXSyLq5FDRmd75WjqXY/MfOFR0GinsvD+W2SO4EYHM8SzvMMZjH2u+
         jwxlwi6X2PV3Yz3rbuvVnIhBQfIX0Iyid6/BImLI8bSylT9DZQEh76H7eFPPMRPsVMc9
         nyz3f7nIXKJpb6069Gm7h69y8uzuZ+CDtahVsSP8MeC/o1JFboFkSXRCbU4eZ1Ha8Xvb
         wlgQ==
X-Forwarded-Encrypted: i=1; AL+hErG7mFS3rXyKs9/PXHUWWd6NHtbCY66V+2GbwfrJB9d5pBQdBqe44dPeSLZrzP9P5XwxKZVv5LW+EqdNlAbLOf8q8H4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/21gKBzuysI8YZbpHKeYExqdnKwTDdxpaHPcNQVoAwFjUBQujj
	C3Ck+QL7WTqqTmKtYn8Jac7RUnbDAqAxWcaoBq6bwfMjXleYz1yY5/6JKKP4CQkHw3c0VlhOGmW
	y3n6TPGQnKqTZDpKA956rlAIP5G//RKk=
X-Gm-Gg: AZFdTZdszAknfVApXon1vFA7Vd8ZQkErWlKdMDp9MXXzdPO6gf9vOpL4HBzqGe8YfnK
	D3E7sVtCld3kTpKQLI0tNAUdNuxaQIhlugXqcfkFevfMNUeeEMBBWL4ycI3X1px1QS9MUFjH006
	qrMOW6XODuP96TwGfkPEZ9LuOFzKTGsivBTKFAYhhj+Ox1iAjRqMpLG6pKtx+o7y55yRXm8kz8O
	eQBVDGpwVwlh7Aw2S9e2ZJbbhQxwj0LS329C3LA7EhRa8e2Bv98hgR1VIJ4+j22QIV0xfCrAVei
	ZFjEqxn/nnx1Fc2dX7IYPRzH8k8ICycLLBDWSqmlWke7ENn5HX4M96z8b68b8UDwOhnheJP+J4m
	ocsmYFfY7D0tEEyObiR1os5Ryxpv79ADzJouK
X-Received: by 2002:a05:690e:4085:b0:67d:bc4d:451c with SMTP id
 956f58d0204a3-67df450c314mr6358450d50.96.1795621596181; Wed, 25 Nov 2026
 07:46:36 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-tlb_tracepoint-v8-1-18abde32ef0a@gmail.com> <awbcwAG4OeZbZKV5@xhacker>
In-Reply-To: <awbcwAG4OeZbZKV5@xhacker>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Wed, 25 Nov 2026 16:46:22 +0100
X-Gm-Features: Aa3M54qtI5DjPFhzGB6nViiuA0Ex5roXTLluTWd_T2OvVW0ieB4jcRFYvYd10Vc
Message-ID: <CALsPMBOqWiU1PKgU40LVe=236itJecq6SZzijuy62PWqobLnUA@mail.gmail.com>
Subject: Re: [PATCH v8] riscv: mm: Trace TLB flush requests
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:24=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Wed, Nov 25, 2026 at 11:41:52AM +0100, Roman 'Hedin' Storozhenko wrote=
:
> > Make RISC-V TLB flush requests observable together with the
> > architecture-specific context available when the request reaches
> > the RISC-V implementation.
> >
> > The generic tlb:tlb_flush event provides reason and page-count
> > information. At the RISC-V implementation level, additional
> > context is available, including the invalidation range and stride,
> > ASID, target CPU mask, and invalidation scope.
>
> These info can be got w/o tracepoint. So I still object adding this
> trace point due to non-trivial tracepoint overhead on riscv with up
> to at least gcc15
>

As discussed in v7, the purpose of this tracepoint is not simply
to expose information that is otherwise inaccessible, but to
communicate the semantics of a TLB invalidation request.

Much of the information provided by existing kernel tracepoints
could also be obtained through dynamic instrumentation. However,
reconstructing event semantics from implementation details requires
knowledge of the underlying code and becomes increasingly difficult
as the implementation evolves.

A dedicated tracepoint provides a consistent semantic representation
of the request that can be directly consumed by tracing tools such
as perf and trace-cmd, without requiring users to reconstruct it
from the current implementation.

Regarding the overhead, I believe we should distinguish the
long-term functional value of a tracepoint from the current
compiler-specific code generation limitations. While the latter
is a valid performance concern, it can be addressed independently
and should not, in my opinion, determine the long-term availability
of useful tracing interfaces.

I would also welcome feedback from other RISC-V developers and
maintainers.

> >
> > This context is useful for debugging and workload analysis. The
> > target CPU mask shows the address-space CPU footprint involved in
> > an invalidation, while range and stride distinguish requests at
> > different mapping granularities. The ASID and scope help correlate
> > requests with MM, scheduler, IPI, and firmware activity.
> >
> > Add riscv_tlb:riscv_tlb_flush_request in flush_tlb_all() and
> > __flush_tlb_range(). Record start, size, stride, ASID (or the
> > no-ASID sentinel), whether an mm is associated with the request,
> > the target CPU mask and its weight, and the derived scope.
> >
> > Record the complete target mask because CPU identity cannot be
> > reconstructed from a count. Calculate its weight from the recorded
> > bitmap so both fields agree even if mm_cpumask() changes during
> > recording.
> >
> > The event describes an invalidation request before dispatch. It
> > does not report whether a remote flush uses SBI RFENCE or Linux
> > cross-CPU coordination, since that choice is effectively established
> > during initialization rather than made for each request.
> >
> > The address field (start) may contain kernel virtual addresses
> > for flushes involving kernel mappings. Require perf tracepoint
> > permissions even for counting-only events, since perf filters
> > could otherwise reveal address information through event counts.
> >
> > Tested on QEMU virt with OpenSBI using local and shared-mm
> > mprotect()/munmap() workloads, exercising single, range, and
> > address-space invalidations. A MADV_PAGEOUT reclaim workload
> > exercised global flushes. All four scope values were observed.
> >
> > Confirmed that trace-cmd records the event and that perf can count
> > it with sufficient privileges. With perf_event_paranoid=3D0,
> > unprivileged attempts to count the event using perf were denied,
> > as intended.
> >
> > Document the event fields, request semantics, limitations, and
> > usage through tracefs and userspace tracing tools.
> >
> > Tested local and shared-mm invalidations with
> > CONFIG_UBSAN_ALIGNMENT=3Dy on QEMU virt without tracepoint-related
> > alignment warnings.
> >
> > Built with and without CONFIG_PERF_EVENTS.
> >
> > Built and verified the RISC-V HTML documentation.
> >
> > Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> > ---
> > Add a RISC-V tracepoint for observing TLB invalidation requests
> > before they are dispatched by the architecture-specific
> > implementation.
> >
> > The generic tlb:tlb_flush event describes TLB flush activity using
> > reason and page-count information. The RISC-V event records
> > additional context, including the invalidation range and stride,
> > ASID, target CPU mask and its weight, and derived request scope.
> >
> > This context helps correlate TLB invalidation activity with MM,
> > scheduler, IPI, and firmware activity. The event describes the
> > request rather than the execution backend. SBI RFENCE versus Linux
> > cross-CPU coordination is effectively determined at initialization
> > rather than selected independently for each request.
> >
> > The target CPU mask weight is derived from the recorded bitmap to
> > keep both fields consistent under concurrent mm_cpumask() updates.
> > Since the address field (start) may contain kernel virtual
> > addresses, the event requires perf tracepoint permissions even
> > for counting-only access.
> >
> > Tested on QEMU virt with OpenSBI using local and shared-mm
> > mprotect()/munmap() workloads. A MADV_PAGEOUT reclaim workload
> > on QEMU virt with APLIC+IMSIC exercised global flushes. All four
> > scope values -- single, range, address-space, and all -- were
> > observed.
> >
> > Confirmed trace-cmd recording and privileged perf counting.
> > With perf_event_paranoid=3D0, unprivileged attempts to count the
> > event using perf were denied, as intended. The kernel was built
> > with and without CONFIG_PERF_EVENTS.
> >
> > Tested local and shared-mm invalidations with
> > CONFIG_UBSAN_ALIGNMENT=3Dy on QEMU virt without tracepoint-related
> > alignment warnings.
> > ---
> > Changes in v8:
> > - Rebase on the current RISC-V for-next branch (c9b3feb61e61)
> > - Add documentation describing the trace event fields, request
> >   semantics, limitations, and usage.
> > - Link to v7: https://lore.kernel.org/r/20261019-tlb_tracepoint-v7-1-4c=
c3e99d387a@gmail.com
> >
> > Changes in v7:
> > - Rename the tracepoint header to asm/tlb_trace.h to make its
> >   purpose explicit, as suggested by Steven Rostedt.
> > - Link to v6: https://lore.kernel.org/r/20261018-tlb_tracepoint-v6-1-14=
476427870f@gmail.com
> >
> > Changes in v6:
> > - Change the scope field from u8 to u32 to ensure the dynamic
> >   CPU mask is properly aligned for bitmap operations.
> > - Verify local and shared-mm TLB flush tracing with
> >   CONFIG_UBSAN_ALIGNMENT=3Dy on QEMU virt.
> > - Link to v5: https://lore.kernel.org/r/20261017-tlb_tracepoint-v5-1-25=
6fb5393a7f@gmail.com
> >
> > Changes in v5:
> > - Move the architecture-specific trace event definition under
> >   arch/riscv/, as requested by Steven Rostedt.
> > - Calculate target_mask_weight from the recorded CPU mask to
> >   keep both fields consistent under concurrent updates.
> > - Require perf tracepoint permissions for counting-only access,
> >   since the event may expose kernel virtual addresses.
> > - Link to v4: https://lore.kernel.org/r/20261015-tlb_tracepoint-v4-1-f2=
38a2bd8f7e@gmail.com
> >
> > Changes in v4:
> > - Drop unrelated whitespace-only changes in arch/riscv/mm/tlbflush.c.
> > - Link to v3: https://lore.kernel.org/all/20261015-tlb_tracepoint-v3-1-=
eef305a3bb63@gmail.com/
> >
> > Changes in v3:
> > - Rebase on current RISC-V for-next.
> > - Thanks to Jisheng Zhang for pointing out that SBI RFENCE versus Linux
> >   cross-CPU coordination is effectively a system-wide choice establishe=
d
> >   during initialization rather than a per-request decision.
> > - Drop the local/SBI RFENCE/cross-CPU path field.
> > - Rename the event from riscv_tlb_flush_path to
> >   riscv_tlb_flush_request and refocus it on the semantic TLB
> >   invalidation request.
> > - Emit one request event independently of the mechanism subsequently
> >   used to perform the invalidation.
> > - Address checkpatch.pl --strict alignment issues.
> > - Link to v2: https://lore.kernel.org/r/20260830-tlb_tracepoint-v2-1-e3=
c88c24df5b@gmail.com
> >
> > Changes in v2:
> > - Use trace_call__riscv_tlb_flush_path() after the explicit
> >   trace_riscv_tlb_flush_path_enabled() check to avoid a second
> >   tracepoint static-key test, as suggested by Steven Rostedt.
> > - Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-1-df=
daede7e741@gmail.com
> > ---
> >  Documentation/arch/riscv/index.rst     |   1 +
> >  Documentation/arch/riscv/tlb-trace.rst | 137 +++++++++++++++++++++++++=
++++++++
> >  arch/riscv/include/asm/tlb_trace.h     | 103 +++++++++++++++++++++++++
> >  arch/riscv/mm/tlbflush.c               |  45 ++++++++++-
> >  4 files changed, 282 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/ri=
scv/index.rst
> > index ac535c52d509..a5450811e4af 100644
> > --- a/Documentation/arch/riscv/index.rst
> > +++ b/Documentation/arch/riscv/index.rst
> > @@ -9,6 +9,7 @@ RISC-V architecture
> >      boot
> >      boot-image-header
> >      vm-layout
> > +    tlb-trace
> >      hwprobe
> >      patch-acceptance
> >      uabi
> > diff --git a/Documentation/arch/riscv/tlb-trace.rst b/Documentation/arc=
h/riscv/tlb-trace.rst
> > new file mode 100644
> > index 000000000000..c664df20d7ef
> > --- /dev/null
> > +++ b/Documentation/arch/riscv/tlb-trace.rst
> > @@ -0,0 +1,137 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +RISC-V TLB Flush Tracing
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The RISC-V Linux kernel provides the
> > +``riscv_tlb:riscv_tlb_flush_request`` trace event to observe TLB
> > +invalidation requests at the architecture-specific implementation.
> > +The event records the virtual address range, stride, ASID, target CPU
> > +mask, and derived request scope.
> > +
> > +This information can help correlate TLB invalidation requests with
> > +memory management, scheduler, IPI, and firmware activity. The event
> > +reports the request before dispatch; it does not identify the mechanis=
m
> > +used to carry it out or confirm that a particular hart invalidated its
> > +TLB. In particular, it does not distinguish SBI RFENCE from Linux
> > +cross-CPU coordination.
> > +
> > +Event fields
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +``start``
> > +    Starting virtual address supplied with the invalidation request.
> > +    It is not a meaningful range boundary for a full global flush.
> > +    Requests involving kernel mappings may contain kernel virtual
> > +    addresses.
> > +
> > +``size``
> > +    Size of the requested range in bytes. ``FLUSH_TLB_MAX_SIZE``
> > +    denotes a full-range invalidation.
> > +
> > +``stride``
> > +    Invalidation granularity supplied to the RISC-V implementation.
> > +    It may be zero for a full global flush.
> > +
> > +``asid``
> > +    Address-space identifier, or ``FLUSH_TLB_NO_ASID`` when no ASID
> > +    is specified. ASIDs can be reused and must not be treated as
> > +    persistent identifiers of address spaces.
> > +
> > +``has_mm``
> > +    Whether the request is associated with an ``mm_struct``.
> > +
> > +``target_cpus``
> > +    CPU mask associated with the request. For an mm-associated
> > +    request, it reflects the relevant address-space CPU mask;
> > +    for a global request, it reflects the online CPU mask supplied
> > +    at the tracepoint. It does not prove which CPUs or harts
> > +    actually performed an invalidation.
> > +
> > +``target_mask_weight``
> > +    Number of CPUs in the recorded ``target_cpus`` bitmap.
> > +
> > +``scope``
> > +    Derived invalidation scope:
> > +
> > +    * ``single``: a range no larger than one stride.
> > +    * ``range``: a range larger than one stride.
> > +    * ``address-space``: a full-range request with an associated
> > +      ``mm_struct``.
> > +    * ``all``: a full-range request without an associated
> > +      ``mm_struct``.
> > +
> > +Using the event
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The event is available through tracefs when kernel event tracing is
> > +configured. The commands below assume tracefs is mounted at
> > +``/sys/kernel/tracing`` and are run with sufficient privileges.
> > +
> > +Inspect the available event fields::
> > +
> > +    # cat /sys/kernel/tracing/events/riscv_tlb/riscv_tlb_flush_request=
/format
> > +
> > +To record requests, clear the current trace buffer and enable the even=
t::
> > +
> > +    # cd /sys/kernel/tracing
> > +    # echo > trace
> > +    # echo 1 > events/riscv_tlb/riscv_tlb_flush_request/enable
> > +
> > +Run a workload that changes memory mappings or permissions, for exampl=
e
> > +one using ``munmap()`` or ``mprotect()``. Then disable the event and
> > +read the buffer::
> > +
> > +    # echo 0 > events/riscv_tlb/riscv_tlb_flush_request/enable
> > +    # cat trace
> > +
> > +``trace_pipe`` can be used instead of ``trace`` to consume events as
> > +they occur. Clearing ``trace`` affects the current tracing instance;
> > +avoid doing so while another tracing session is using it.
> > +
> > +Example output
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The following lines were captured in separate QEMU ``virt`` test runs.
> > +Addresses, ASIDs, CPU masks, and timestamps depend on the workload and
> > +system configuration::
> > +
> > +    tlb_workload-ri-290 [000] ...5. 748.436198: riscv_tlb_flush_reques=
t: start=3D0xfffffffffff000 size=3D0x1000 stride=3D0x1000 asid=3D0x158 has_=
mm=3D1 target_mask_weight=3D1 target_cpus=3D00000000,00000001 scope=3Dsingl=
e
> > +    tlb_workload-ri-290 [000] ...1. 748.580051: riscv_tlb_flush_reques=
t: start=3D0x7fff891e2000 size=3D0x20000 stride=3D0x1000 asid=3D0x158 has_m=
m=3D1 target_mask_weight=3D2 target_cpus=3D00000000,00000003 scope=3Drange
> > +    tlb_scope_all-r-309 [000] ...1. 986.214468: riscv_tlb_flush_reques=
t: start=3D0 size=3D0xffffffffffffffff stride=3D0x1000 asid=3D0xfffffffffff=
fffff has_mm=3D0 target_mask_weight=3D3 target_cpus=3D0-2 scope=3Dall
> > +
> > +The first request covers one 4 KiB stride. The second covers a 128 KiB
> > +range and records two target CPUs (mask ``0x3``). The last is an
> > +mm-independent full-range request; its target mask includes CPUs 0-2.
> > +The different CPU-mask representations reflect tracing output options.
> > +
> > +Userspace tools
> > +---------------
> > +
> > +The event may also be recorded with the external ``trace-cmd`` tool::
> > +
> > +    # trace-cmd record -e riscv_tlb:riscv_tlb_flush_request ./workload
> > +    # trace-cmd report
> > +
> > +It is also accessible to perf and other tools supporting kernel trace
> > +events, subject to access permissions. For general tracefs usage and
> > +event filtering, see ``Documentation/trace/events.rst``.
> > +
> > +Limitations
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This event describes a Linux TLB invalidation request, not hardware TL=
B
> > +state, the execution path within firmware, or completion of remote
> > +invalidation operations.
> > +
> > +The recorded CPU mask and its weight agree, but copying a concurrently
> > +changing mask does not provide an atomic snapshot of all CPU or
> > +address-space state.
> > +
> > +Since the event can contain kernel virtual addresses, access to its
> > +trace data must be appropriately restricted. Perf access permissions
> > +also apply to counting-only use of this event.
> > diff --git a/arch/riscv/include/asm/tlb_trace.h b/arch/riscv/include/as=
m/tlb_trace.h
> > new file mode 100644
> > index 000000000000..60b48eb0d355
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/tlb_trace.h
> > @@ -0,0 +1,103 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM riscv_tlb
> > +
> > +#if !defined(_TRACE_RISCV_TLB_TRACE_H) || defined(TRACE_HEADER_MULTI_R=
EAD)
> > +#define _TRACE_RISCV_TLB_TRACE_H
> > +
> > +#include <linux/cpumask.h>
> > +#include <linux/tracepoint.h>
> > +#include <linux/perf_event.h>
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
> > +#endif /* _TRACE_RISCV_TLB_ENUMS */
> > +
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
> > +TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
> > +
> > +#define show_riscv_tlb_flush_scope(scope) \
> > +     __print_symbolic(scope, \
> > +             { RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
> > +             { RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
> > +             { RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" },=
 \
> > +             { RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
> > +
> > +/*
> > + * Record the invalidation request received by the RISC-V architecture=
 code
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
> > + * implementation.
> > + *
> > + * The event records the invalidation request before it is dispatched.=
 It does
> > + * not describe the mechanism used to execute the request.
> > + *
> > + */
> > +TRACE_EVENT(riscv_tlb_flush_request,
> > +         TP_PROTO(unsigned long start, unsigned long size,
> > +                  unsigned long stride, unsigned long asid, bool has_m=
m,
> > +                  const struct cpumask *cmask,
> > +                  enum riscv_tlb_flush_scope scope),
> > +
> > +     TP_ARGS(start, size, stride, asid, has_mm, cmask, scope),
> > +
> > +     TP_STRUCT__entry(__field(unsigned long, start)
> > +             __field(unsigned long, size)
> > +             __field(unsigned long, stride)
> > +             __field(unsigned long, asid)
> > +             __field(bool, has_mm)
> > +             __field(unsigned int, target_mask_weight)
> > +             __cpumask(target_cpus)
> > +             __field(u32, scope)
> > +     ),
> > +
> > +     TP_fast_assign(__entry->start =3D start;
> > +             __entry->size =3D size;
> > +             __entry->stride =3D stride;
> > +             __entry->asid =3D asid;
> > +             __entry->has_mm =3D has_mm;
> > +             __assign_cpumask(target_cpus, cpumask_bits(cmask));
> > +             __entry->target_mask_weight =3D cpumask_weight((const str=
uct cpumask *)
> > +                                                  __get_cpumask(target=
_cpus));
> > +             __entry->scope =3D scope;
> > +     ),
> > +
> > +     TP_printk("start=3D%#lx size=3D%#lx stride=3D%#lx asid=3D%#lx has=
_mm=3D%d target_mask_weight=3D%u target_cpus=3D%s scope=3D%s",
> > +               __entry->start, __entry->size, __entry->stride,
> > +               __entry->asid, __entry->has_mm,
> > +               __entry->target_mask_weight, __get_cpumask(target_cpus)=
,
> > +               show_riscv_tlb_flush_scope(__entry->scope))
> > +);
> > +
> > +#ifdef CONFIG_PERF_EVENTS
> > +TRACE_EVENT_PERF_PERM(riscv_tlb_flush_request,
> > +                   perf_allow_tracepoint());
> > +#endif
> > +
> > +#endif /* _TRACE_RISCV_TLB_TRACE_H */
> > +
> > +#undef TRACE_INCLUDE_PATH
> > +#undef TRACE_INCLUDE_FILE
> > +
> > +#define TRACE_INCLUDE_PATH asm
> > +#define TRACE_INCLUDE_FILE tlb_trace
> > +
> > +/* This part must be outside protection. */
> > +#include <trace/define_trace.h>
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index a74a7d5258aa..815867c34e18 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -9,6 +9,9 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/cpufeature.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <asm/tlb_trace.h>
> > +
> >  #define has_svinval()        riscv_has_extension_unlikely(RISCV_ISA_EX=
T_SVINVAL)
> >
> >  /*
> > @@ -63,6 +66,32 @@ void local_flush_tlb_kernel_range(unsigned long star=
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
> > +riscv_tlb_trace_flush_request(const struct cpumask *cmask, unsigned lo=
ng start,
> > +                           unsigned long size, unsigned long stride,
> > +                           unsigned long asid, bool has_mm)
> > +{
> > +     enum riscv_tlb_flush_scope scope;
> > +
> > +     if (!trace_riscv_tlb_flush_request_enabled())
> > +             return;
> > +
> > +     scope =3D riscv_tlb_get_flush_scope(size, stride, has_mm);
> > +     trace_call__riscv_tlb_flush_request(start, size, stride, asid, ha=
s_mm,
> > +                                         cmask, scope);
> > +}
> > +
> >  static void __ipi_flush_tlb_all(void *info)
> >  {
> >       local_flush_tlb_all();
> > @@ -70,12 +99,18 @@ static void __ipi_flush_tlb_all(void *info)
> >
> >  void flush_tlb_all(void)
> >  {
> > -     if (num_online_cpus() < 2)
> > +     riscv_tlb_trace_flush_request(cpu_online_mask, 0,
> > +                                   FLUSH_TLB_MAX_SIZE, 0,
> > +                                   FLUSH_TLB_NO_ASID, false);
> > +
> > +     if (num_online_cpus() < 2) {
> >               local_flush_tlb_all();
> > -     else if (riscv_use_sbi_for_rfence())
> > -             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
> > -     else
> > +     } else if (riscv_use_sbi_for_rfence()) {
> > +             sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE,
> > +                                        FLUSH_TLB_NO_ASID);
> > +     } else {
> >               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> > +     }
> >  }
> >
> >  struct flush_tlb_range_data {
> > @@ -105,6 +140,8 @@ static void __flush_tlb_range(struct mm_struct *mm,
> >
> >       cpu =3D get_cpu();
> >
> > +     riscv_tlb_trace_flush_request(cmask, start, size, stride, asid, !=
!mm);
> > +
> >       /* Check if the TLB flush needs to be sent to other CPUs. */
> >       if (cpumask_any_but(cmask, cpu) >=3D nr_cpu_ids) {
> >               local_flush_tlb_range_asid(start, size, stride, asid);
> >
> > ---
> > base-commit: c9b3feb61e6134d61656e5ec2516de82ea0d0f27
> > change-id: 20260829-tlb_tracepoint-844105ab5092
> >
> > Best regards,
> > --
> > Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
> >



--=20
Kind regards,
Roman 'Hedin' Storozhenko
