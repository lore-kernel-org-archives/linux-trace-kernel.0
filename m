Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F1477E48
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517681; cv=pass; b=qs5E6nElAPmLwgS+92DLdYi5H24fqUgETXuHfh3hE6QlozhtardTd7NFSKUmEIV+70BryBNJzQJ0KUG2kixRevl6exAdzMvJmn7j8ez9AyW1fMcBsPhPv/uzqSDfMn+Tvq5Eu1Ak2uJP27E8IhDeBnibOkmrBED7lREdK4Ol8+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517681; c=relaxed/simple;
	bh=ychIqoH2N9RkBSK1oqMvOJTasQOsN2jS3M8Rh7cNElY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGTMlf+aTe6CLGbdCDxZcEVSmNWhILYyJVug7j8yuOLkt8X35dU3XAqXUuFpqsE82Doxr73+jTQLEOO8r6KUxlmWAgNQwiGfM9JyGPmZ5ighSA+fd8FPP+Q1PZ8Ii4uuYtbflmAtTbUddjEkGwwHzma18b3LVMJgPmma7ktJoaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFYMd16o; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFYMd16o"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so1560584a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517678; cv=none;
        d=google.com; s=arc-20240605;
        b=YKBpQgJ4e6fX4qu2Pe1z1uKzIsm/hrXGeJRzTeKJ8wFNN+9Ysb8oji4KsAIhCq2Qd5
         jg5nZIo/anLr2d318A+0+85Gda0fsnBJW0E3wRN2QqN0pSEYBC4bYWScny+B86iRww0x
         0fCIkcBM9VOmrYfLsLEzJ0vl3VB2xsowsHTdWj7ulR2LqwU2yM2J5sxb+EO9Cft+wleY
         rKEJFVA9pHBmBQTJzk0ckoZjvVZldHjVnVQwd54k7i5r4u8LjN3jyZz8yHjQGlE+JgUx
         XOFyGy0HBMslzgqDBh7J3rqWiwoyXhgugqfLS4K3ZWVmJUVID73lowtGxidelbPun9lY
         +skA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twgMFzrPk4l1LS+jrmzU69hpjXt2Fx2pEmRL5onfYHo=;
        fh=9IOZs520vsR7bJ900xlDRw4HKUf6N0eQIjwe3n+bYfU=;
        b=fCkE7/6Aq7BjUxzqLktj5oZCbtNkzq0hoEigcXKxXTYCT+Xy3WJfqGPVedz5VebAjH
         3eOh+xfD9zEiPCTRKGScHOy7qDW/TucU9Hr1BcNwu/P3GfAZPOsrcyxa0GK8YRJR0TBn
         cscRpmOjLzoCuI4JRR1FWLpNLsNpgJ/3JxWuIK+nCuNSUj6xZaKQ4xlEBsycRbwq36xn
         ysusA7iv5nEURwgHo+k1qCVx82vG1L5zgaJfSaheurph5MsQTvsLp2CLbaj74WNMKMYs
         7n4+Oi8SLWZ8QD3eJvfzsfEuGgKJUod5jbXCeaShjBGQiqqX0nykf7lhbiyzlvgmXdF0
         r54w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517678; x=1779122478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twgMFzrPk4l1LS+jrmzU69hpjXt2Fx2pEmRL5onfYHo=;
        b=BFYMd16o3t3UbuUDq1QN2iHooHaROgnFEufAvwoMn/4CB3QFmtvZWhfNGzMxL/qvlp
         bLIWuyq3qTX9pDCMkF8vXQq83mb4CReEXiBIgjWKrZhS3FqPMJQgh8CiTK4of0zszkPY
         Zb4UAhOq7cnEGUVjQloRK41A8CK3Z/0Slp91cy2WfNHIdHMwZXUkkJa1N70SbbiZUDyM
         JY6NG6Ux7B0x3Y0pevLkpK+ErvQBMaYP48KjXMXZbAwqBzoOU0VDFz91qo6sUPjYDW0/
         WNwR9DF8H99wasMxTu8iGocC03fL9QtPLFHJ9WY8Gs4DvaJsNYVgYysEpt2c8M4zkl4S
         KyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517678; x=1779122478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twgMFzrPk4l1LS+jrmzU69hpjXt2Fx2pEmRL5onfYHo=;
        b=LiCdZOfY/Cvn/LkTuxgMayQTfhQvzXLEMDFUw4c/8JD5giVHHZLQ0EY7OTbwAeB6ZO
         XY34dIECa7G0YcmvYt8zoqLzcqBmjJfzoolgpI1Afus+umIv4NtyDl5SkWBmQebMWw4E
         hQpJ7UjPwJzDY/PW3tbBcs/sQ1iyVMPw3ZiX69u5cLTEvwt4kLqXqISayC46cM5hp5j6
         pf4afig4duq/QobPyjN3fWJSKKU95N8NyTK7WIy44clgIfZ4zznIc88MDxh6/3TpeyLY
         t5YMITSdT//eE59JDU8iohne+olkVHgo01tgFYrznq0RdWqxeYgMQZ44Lgx64wh1Tq5J
         NLTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aGshceq8ejlz+t/aYoLiUCJEyY26IltjiNQkzTQX5wxUJ5CyOLOKyQV4vamxF3JB6GM9iJjZ6YDxL/QRJwYL/KTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQYfAZ96OpWVHS/1Y1gvdXNlpFYWBWQz7lTwFnkmKQ57lX7Ra
	C79l74VOpeO8Hxqs6nk6vFar0nf3ypk6z2fYFwVUgf68Lg55ltBE8wNeBV5vGr2piyBY2gvOHMH
	i0vXScwxce1Gt/T6voYG8mXAitdUyjdg=
X-Gm-Gg: Acq92OFDDTvcOhdwxkmTA4FM5xhv9Wbostt9Vgx/rhdGpDFvqo75/iwVn5/JbpPbrhn
	ajPgVJQUelc3fV4kHx3F2Db7u+AgRecK9nGIf5wU1qj3JqWpCBYql8DY5IgZ2BPsGZGwUoTMpUv
	h2NdCYVm3didLZqRh+Wu78OOXn/1vZ0Ql0OoxY4mxq6oLdSwKuCcb4sl/hSKHr1AH9nSu+Z0mrz
	+uqHbMraNO7hnqBQAkAY8mfi3Z70iThGHTG5cwD3KcMHr08mijsEyV1NYyGG6c8kt8VuGeMvfre
	Q07D783Ok746QDTRTr6xN78U8HmT/CFdmQ==
X-Received: by 2002:a17:90b:3511:b0:367:f76c:4cbb with SMTP id
 98e67ed59e1d1-367f76c77cfmr8727967a91.18.1778517678296; Mon, 11 May 2026
 09:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agD3xq2MUyskd7X-@krava>
In-Reply-To: <agD3xq2MUyskd7X-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:41:06 +0200
X-Gm-Features: AVHnY4JLB8eR8j4Em_tZM-C00L4Mdz2CpH3NR3klNTKSEbCfuAALzZBjHbb5abA
Message-ID: <CAEf4Bza9PjbaVjFxYDmWPXXGV+Z-_Hn2Kz_KB2TOa5s-_UJ1xA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, oleg@redhat.com, peterz@infradead.org, 
	mingo@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 2:25=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, May 08, 2026 at 05:30:56PM -0700, Andrii Nakryiko wrote:
> > The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> > probe site with a CALL into a uprobe trampoline. CALL pushes a return
> > address to [rsp-8]. On x86-64 this is inside the 128-byte red zone, whe=
re
> > user code may keep temporary data without adjusting rsp.
> >
> > Use a 5-byte JMP instead. JMP does not write to the user stack, but it
> > also does not provide a return address. Replace the single trampoline
> > entry with a page of 16-byte slots. Each optimized probe jumps to its
> > assigned slot, the slot moves rsp below the red zone, saves the registe=
rs
> > clobbered by syscall, and invokes the uprobe syscall:
> >
> >   Probe site:   jmp slot_N              (5B, replaces nop5)
> >
> >   Slot N:       lea  -128(%rsp), %rsp   (5B)  skip red zone
> >                 push %rcx               (1B)  save (syscall clobbers)
> >                 push %r11               (2B)  save (syscall clobbers)
> >                 push %rax               (1B)  save (syscall uses for nr=
)
> >                 mov  $336, %eax         (5B)  uprobe syscall number
> >                 syscall                 (2B)
> >
> > All slots contain identical code at different offsets, so the trampolin=
e
> > page is generated once at boot and mapped read-execute into each proces=
s.
> > The syscall handler identifies the slot from regs->ip, which points jus=
t
> > after the syscall instruction, and uses a per-mm slot table to recover =
the
> > original probe address.
> >
> > The uprobe syscall does not return to the trampoline slot. The handler
> > restores the probe-site register state, runs the uprobe consumers, sets
> > pt_regs to continue at probe_addr + 5 unless a consumer redirected
> > execution, and returns directly through the IRET path. This preserves
> > general purpose registers, including rcx and r11, without requiring any
> > post-syscall cleanup code in the trampoline and avoids call/ret, RSB, a=
nd
> > shadow stack concerns.
> >
> > Protect the per-mm trampoline list with RCU and free trampoline metadat=
a
> > with kfree_rcu(). This lets the syscall path resolve trampoline slots
> > without taking mmap_lock. The optimized-instruction detection path also
> > walks the trampoline list under an RCU read-side lock. Since that path
> > starts from the JMP target, it translates the slot start to the post-sy=
scall
> > IP expected by the shared resolver before checking the trampoline mappi=
ng.
> >
> > Each trampoline page provides 256 slots. Slots stay permanently assigne=
d
> > to their first probe address and are reused only when the same address =
is
> > probed again. Reassigning detached slots is deliberately avoided becaus=
e a
> > thread can remain in a trampoline for an unbounded time due to ptrace,
> > interrupts, or scheduling delays. If a reachable trampoline page runs o=
ut
> > of slots, probes that cannot allocate a slot fall back to the slower IN=
T3
> > path.
> >
> > Require the entire trampoline page to be reachable by a rel32 JMP befor=
e
> > reusing it for a probe. This keeps every slot in the page within the ra=
nge
> > that can be encoded at the probe site.
> >
> > Change the error code returned when the uprobe syscall is invoked outsi=
de
> > a kernel-generated trampoline from -ENXIO to -EPROTO. This lets libbpf =
and
> > similar libraries distinguish fixed kernels from kernels with the
> > red-zone-clobbering implementation and enable nop5 optimization only on
> > fixed kernels.
> >
> > Performance (usdt single-thread, M/s):
> >
> >                   usdt-nop  usdt-nop5-base  usdt-nop5-fix  nop5-change =
 iret%
> >   Skylake          3.149        6.422          4.865         -24.3%    =
 39.1%
> >   Milan            2.910        3.443          3.820         +11.0%    =
 24.3%
> >   Sapphire Rapids  1.896        4.023          3.693          -8.2%    =
 24.9%
> >   Bergamo          3.393        3.895          3.849          -1.2%    =
 24.5%
> >
> > The fixed nop5 path remains faster than the non-optimized INT3 path on =
all
> > measured systems. The regression relative to the old CALL-based trampol=
ine
> > comes from IRET being more expensive than SYSRET, most noticeably on ol=
der
> > Intel Skylake. Newer Intel CPUs and tested AMD CPUs have lower IRET cos=
t,
> > and AMD Milan improves because removing mmap_lock from the hot path mor=
e
> > than offsets the IRET cost.
> >
> > Multi-threaded throughput scales nearly linearly with the number of CPU=
s, like
> > it used to, thanks to lockless RCU-protected uprobe trampoline lookup.
>
> hi,
> thanks a lot for the fix
>
> FWIW we discussed also an option to have 10-bytes nop and do:
>   [rsp+0x80, call trampoline]
>
> we would not need the slots re-use logic, but not sure what other
> surprises there are with 10-bytes nop
>
> I tried that change [1], it seems to work, but it has other
> difficulties, like I think the unoptimized path needs to do:
>   [rsp+0x80, call trampoline] -> [jmp end of 10-bytes nop]
> instead of patching back the 10-byte nop, because some thread
> could be inside the nop area already.
>

Yeah, nop10 and this jump-over-nop10 approach is an alternative. I
don't have strong feelings apart from the ridiculousness of a 10-byte
nop :)

did you get a chance to benchmark your nop10 approach, curious how do
the number look like

> jirka
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit=
/?h=3Dredzone_fix&id=3D74b09240289dba8368c2783b771e678b2cc31574
>
> >
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/include/asm/uprobes.h                |  18 ++
> >  arch/x86/kernel/uprobes.c                     | 262 ++++++++++--------
> >  tools/lib/bpf/features.c                      |   8 +-
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c |   5 +-
> >  tools/testing/selftests/bpf/prog_tests/usdt.c |   2 +-
> >  5 files changed, 181 insertions(+), 114 deletions(-)
> >

[...]
