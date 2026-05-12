Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100583D5C10
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604463; cv=none; b=ipYUDtKD42ld9Czb6ul+FGzEhjmxTHUQOAcZ+JDCN9E+71wTNnH6osSE0c24gokpndh7/J9GxzRGOl8uxpQDvzCWkHcKJC0iZOGwPZTa5x0KC7rr3C6+PugDp8vxch+iM3hVQCsMZM0wTBnL+WBDLBuH9cfHmnrCDXeykS9rMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604463; c=relaxed/simple;
	bh=hpPcxmKVbYHtMuW3mYGdPhpIZxaynFkqPC+wUjp709I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2Y3c5pqyS1siCZ4PMG/nKMGMECR/LEHeB/rqRwIl1U59LhKq0s9mkVX4xh4P8lC3LsA98vRTEwL35U+/eyXhs17WbHiD5Ys9fvxS6kkxIzp7fkuNyMm4i0q9dJPgGBUNzNv9J63fgZejJ62KlUED+ifzVivtZZ2VkH7/tByxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+IQnbor; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+IQnbor"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so52163325e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604457; x=1779209257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1AZmh+CrIvhk7wbc4SmPDyyGEzwvfm2GvyovSRlyJ6E=;
        b=r+IQnbor8N8r8XfPigm6dfxrjtWIq3f79EKE5mYUIsAevgTy5F3Hvug1a6fCihCqdE
         6kOCnMWqznA7EANlyAbrN24DHWb7+8XjkdW+ywymcKSe1S7Imj7D/yKT3di69QcOt1eL
         XHw5aClM7rkGTHAHhKc++YCdAe8YHjBIZPzHWPF6/siQ2ZHs3IVzTxWTkHqaMocBfgJt
         3543lEcnkIn7RM+lRYI7hHwiFRbEyUSgBIaRaeBcDwpvDXZ+Ft3VGoO5okMuIu7qV/Uo
         EUFdwjWPKVtVyWrTyXG/ULh3b93PBDR9Ti+wbWJjpHNIpBgQ9XrpX1+RiPXbxCNAvLdK
         XY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604457; x=1779209257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AZmh+CrIvhk7wbc4SmPDyyGEzwvfm2GvyovSRlyJ6E=;
        b=rNXyd4d1SketTaD2NtxBDE4olHezcqUQfOqJgqhLFhewPDkWffpTU1+hy8jf56f1+l
         d4v/cjXjdAI1x7KkkQ7i4Qa+QN+GTv9uKx1jh1/vKxUePUoTGn+IPCjeLGkN0zxpqEjB
         1bbBcKTYtIOTcGgUhFwwALuJNgdAvQnKxEVvTIh8LsN3lkk2cx5D/B7PcXfP4tk+Ej9z
         fGfSgNA3yLiv9ESGPNEyES274aZuGeIhPKaEoyj2DZi7G4aeXN73vnAERwkI8ubN2DMX
         UEVJNxO/MsfYCCeHvtv1BUXuA2VagZHIWl6e3X71o5kxEd5p4SegNWFBY7pDZdhLZ8A5
         kT1A==
X-Forwarded-Encrypted: i=1; AFNElJ+DNlHtGWltZysPcZwWnFdtSwno6PsJMAaIObP+k2q0oCf00sAoxLR6PQxxsaWaxEOMyltjN31JgR+Ri9zcUeSQoKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkb22CpkcWVDxskqo/fEBzm7ZJh8ZzRuVxgQd9MKHIYd7QB6DS
	ESUKw+XXC6wHJN4VmQV6RebIbPA1gnewHcnINbdha2tXskkEBVULRhzF
X-Gm-Gg: Acq92OFx/mJ1Wvu3a4DMmVxosUt8GInEJn1TXDWR9/fE9YHmxiJZbn4W0OH/wk9HrEt
	0I/u7X4vjysy26myvUCNjTuiQzAfmWNeQYV5NvIUwJij6dWQ1l4q15gjDXNjGKWQqvqZBI7OGat
	aZUhFYe+I8iGzn8CNNnYpyoC+5fYezv2o+S1Zl+R37Le3AsQuOS521cp9tRVOPtRbqWa3iqhr4h
	d8WN7+nrhcRD+tDndP2bYmg5OOo+GyVYnWlP68sbDNNErVgjHX29ke8gud2dSyQLZOBFcoc/9Pj
	k9AHQknZYp5OcCPl0OXat7X17CuGUEN9VSmRF6ixTiNS0LhwiV3+exWgoDnF0IDWQdsZ0NAalDr
	sT9dc/qEpVPlbZwjCNFHNW3dNs1yNyqSu4r9ZSsQ/ybqlvGKTg8AgkJCo0zSr/W5gkgCTbeOfzS
	y023KHDtmsJpE=
X-Received: by 2002:a05:600c:8012:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-48e5fb8fac9mr380715705e9.24.1778604457228;
        Tue, 12 May 2026 09:47:37 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d19974sm8608625e9.2.2026.05.12.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:47:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 May 2026 18:47:35 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-ID: <agNZp62qZLMM9hsa@krava>
References: <20260509003146.976844-1-andrii@kernel.org>
 <agD3xq2MUyskd7X-@krava>
 <CAEf4Bza9PjbaVjFxYDmWPXXGV+Z-_Hn2Kz_KB2TOa5s-_UJ1xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza9PjbaVjFxYDmWPXXGV+Z-_Hn2Kz_KB2TOa5s-_UJ1xA@mail.gmail.com>

On Mon, May 11, 2026 at 06:41:06PM +0200, Andrii Nakryiko wrote:
> On Sun, May 10, 2026 at 2:25 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, May 08, 2026 at 05:30:56PM -0700, Andrii Nakryiko wrote:
> > > The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
> > > probe site with a CALL into a uprobe trampoline. CALL pushes a return
> > > address to [rsp-8]. On x86-64 this is inside the 128-byte red zone, where
> > > user code may keep temporary data without adjusting rsp.
> > >
> > > Use a 5-byte JMP instead. JMP does not write to the user stack, but it
> > > also does not provide a return address. Replace the single trampoline
> > > entry with a page of 16-byte slots. Each optimized probe jumps to its
> > > assigned slot, the slot moves rsp below the red zone, saves the registers
> > > clobbered by syscall, and invokes the uprobe syscall:
> > >
> > >   Probe site:   jmp slot_N              (5B, replaces nop5)
> > >
> > >   Slot N:       lea  -128(%rsp), %rsp   (5B)  skip red zone
> > >                 push %rcx               (1B)  save (syscall clobbers)
> > >                 push %r11               (2B)  save (syscall clobbers)
> > >                 push %rax               (1B)  save (syscall uses for nr)
> > >                 mov  $336, %eax         (5B)  uprobe syscall number
> > >                 syscall                 (2B)
> > >
> > > All slots contain identical code at different offsets, so the trampoline
> > > page is generated once at boot and mapped read-execute into each process.
> > > The syscall handler identifies the slot from regs->ip, which points just
> > > after the syscall instruction, and uses a per-mm slot table to recover the
> > > original probe address.
> > >
> > > The uprobe syscall does not return to the trampoline slot. The handler
> > > restores the probe-site register state, runs the uprobe consumers, sets
> > > pt_regs to continue at probe_addr + 5 unless a consumer redirected
> > > execution, and returns directly through the IRET path. This preserves
> > > general purpose registers, including rcx and r11, without requiring any
> > > post-syscall cleanup code in the trampoline and avoids call/ret, RSB, and
> > > shadow stack concerns.
> > >
> > > Protect the per-mm trampoline list with RCU and free trampoline metadata
> > > with kfree_rcu(). This lets the syscall path resolve trampoline slots
> > > without taking mmap_lock. The optimized-instruction detection path also
> > > walks the trampoline list under an RCU read-side lock. Since that path
> > > starts from the JMP target, it translates the slot start to the post-syscall
> > > IP expected by the shared resolver before checking the trampoline mapping.
> > >
> > > Each trampoline page provides 256 slots. Slots stay permanently assigned
> > > to their first probe address and are reused only when the same address is
> > > probed again. Reassigning detached slots is deliberately avoided because a
> > > thread can remain in a trampoline for an unbounded time due to ptrace,
> > > interrupts, or scheduling delays. If a reachable trampoline page runs out
> > > of slots, probes that cannot allocate a slot fall back to the slower INT3
> > > path.
> > >
> > > Require the entire trampoline page to be reachable by a rel32 JMP before
> > > reusing it for a probe. This keeps every slot in the page within the range
> > > that can be encoded at the probe site.
> > >
> > > Change the error code returned when the uprobe syscall is invoked outside
> > > a kernel-generated trampoline from -ENXIO to -EPROTO. This lets libbpf and
> > > similar libraries distinguish fixed kernels from kernels with the
> > > red-zone-clobbering implementation and enable nop5 optimization only on
> > > fixed kernels.
> > >
> > > Performance (usdt single-thread, M/s):
> > >
> > >                   usdt-nop  usdt-nop5-base  usdt-nop5-fix  nop5-change  iret%
> > >   Skylake          3.149        6.422          4.865         -24.3%     39.1%
> > >   Milan            2.910        3.443          3.820         +11.0%     24.3%
> > >   Sapphire Rapids  1.896        4.023          3.693          -8.2%     24.9%
> > >   Bergamo          3.393        3.895          3.849          -1.2%     24.5%
> > >
> > > The fixed nop5 path remains faster than the non-optimized INT3 path on all
> > > measured systems. The regression relative to the old CALL-based trampoline
> > > comes from IRET being more expensive than SYSRET, most noticeably on older
> > > Intel Skylake. Newer Intel CPUs and tested AMD CPUs have lower IRET cost,
> > > and AMD Milan improves because removing mmap_lock from the hot path more
> > > than offsets the IRET cost.
> > >
> > > Multi-threaded throughput scales nearly linearly with the number of CPUs, like
> > > it used to, thanks to lockless RCU-protected uprobe trampoline lookup.
> >
> > hi,
> > thanks a lot for the fix
> >
> > FWIW we discussed also an option to have 10-bytes nop and do:
> >   [rsp+0x80, call trampoline]
> >
> > we would not need the slots re-use logic, but not sure what other
> > surprises there are with 10-bytes nop
> >
> > I tried that change [1], it seems to work, but it has other
> > difficulties, like I think the unoptimized path needs to do:
> >   [rsp+0x80, call trampoline] -> [jmp end of 10-bytes nop]
> > instead of patching back the 10-byte nop, because some thread
> > could be inside the nop area already.
> >
> 
> Yeah, nop10 and this jump-over-nop10 approach is an alternative. I
> don't have strong feelings apart from the ridiculousness of a 10-byte
> nop :)
> 
> did you get a chance to benchmark your nop10 approach, curious how do
> the number look like

yes, it's the same as with the nop5

  base:
          usermode-count :  152.509 ± 0.044M/s
          syscall-count  :   15.177 ± 0.021M/s
          uprobe-nop     :    3.215 ± 0.002M/s
          uprobe-push    :    3.054 ± 0.003M/s
          uprobe-ret     :    1.100 ± 0.002M/s
          uprobe-nop5    :    7.251 ± 0.034M/s
          uretprobe-nop  :    2.149 ± 0.012M/s
          uretprobe-push :    2.088 ± 0.001M/s
          uretprobe-ret  :    0.960 ± 0.001M/s
          uretprobe-nop5 :    3.402 ± 0.001M/s
          usdt-nop       :    3.185 ± 0.024M/s
          usdt-nop5      :    7.378 ± 0.016M/s

  nop10:
          usermode-count :  152.503 ± 0.024M/s
          syscall-count  :   15.977 ± 0.047M/s
          uprobe-nop     :    3.174 ± 0.011M/s
          uprobe-push    :    3.030 ± 0.006M/s
          uprobe-ret     :    1.124 ± 0.004M/s
          uprobe-nop5    :    7.201 ± 0.012M/s
          uretprobe-nop  :    2.141 ± 0.005M/s
          uretprobe-push :    2.078 ± 0.007M/s
          uretprobe-ret  :    0.947 ± 0.003M/s
          uretprobe-nop5 :    3.384 ± 0.014M/s
          usdt-nop       :    3.247 ± 0.002M/s
          usdt-nop5      :    7.374 ± 0.027M/s

jirka
