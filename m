Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC053C5536
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452673; cv=pass; b=oOk09KIw4f+NdBoUeACAmKGQwFakE3tGz/VTfqGiTwy9Yaod5ynv7cH0W7ZAyuvEsCslFX/0zi5gu4JRpBdJ0aaUDWkIV6muaJT+83O8MIqHEQm1GP9zsVD7cggNISyjkeLHI+IgzzzOO/e1MjCvxioQAVOE/jfFNaRjZ2kd/Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452673; c=relaxed/simple;
	bh=LgMCkxlnlEjf31QSKYSyLVy690adKEPdMobqywq7vJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6PaUdNvC/qftsJKsOLcsQvgPCg/8huifvfe95k6jQn6VwlXAr4Jp3n6PzEVqQPcSqUNyqWRGVGKldoVE8suHHtKKDhoo0qG5lno/iddYz4ytTNjdKvGQrn9mU2j5H5uDNx00rtYYbIE/UFyJbEIslDHp9Fj+jwk7ugeTC+5lzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coi7/387; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coi7/387"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8deb37737dso194126a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 22:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782452671; cv=none;
        d=google.com; s=arc-20260327;
        b=LSXIc/ae84cpx9JPvKoWpqtoNMwqD1CrjYYeSRSXt17CrWprKigiQneBr7dO2+2rkz
         NmuR3pZueTN3f7UIdikbHVUIIqJwTCPydB71bJZYAdZsPRcSOEQ6WPQmIYQPXjpOJCcW
         TaYzAT7FU778xdxeGgaifZgQxPOoHuqU2eMqvq/DNnt+mcro42B2Rbf17mona8ZNH4vZ
         rGFyXiSZPfS6UlRM2iWnMDvNS4Bh+oj9CviHAYyLvluq0zDFQtdEVTn8borp3OK3S/gn
         Gl/j7vCh0PbstostLvAGFcYEsunnlRX89DbftjR6tsFucr7uP5NXmqATEhkERNGvQrY5
         /w/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhTrT9L75Q7te0mn0gkYVv6yY0/Erfss1oWJLr7g+Sk=;
        fh=oh1it+K1XnXKwCd4r1FVeJ9yUuQ4qdc06pgfvmgmFL4=;
        b=Sg6skIVvqUAdBN6o2hpjHg/a+G/4sTEjmjYepDjamvUNakqG6jiKgOS9hKFfMb3kGn
         5RGnmkkIHQKu3AgUabPjB8zP68MrVNbcwVsDNf5F688cfBtnVziW5H47phnOpHjGaep5
         jqkAA5pChSi+5cfLVvlw6RbPs77CO8eiM0bRrVjAVY/yP+VZRGg6kS1jy4/QoMjW6VOy
         39FeZICJugxPFdUVhUh1i6v994O48C94b1sxam+/KuO7EzbQCetaqTPbskZURJkOK7IX
         FcLaSueZF3aQfTaG9aFc5J1rnDXn/n8XkFeraJkKBdQK5qsR9YBOWVHkbaXCTT2Mvkay
         sB+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782452671; x=1783057471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhTrT9L75Q7te0mn0gkYVv6yY0/Erfss1oWJLr7g+Sk=;
        b=coi7/387mmH5Cfj52b57vvri0DeOf77YkaVc4k5yh8jzHAhfNdxn9xbsh2BSm3jHk7
         IMdOhNn37OE0asvijXPLr4ElkLk8r9tsajd7vlCsNpmrtwTlqZp7L5/rG+bmKkm6jiYm
         +vfT9/P8YEYH7N28KIewJ+1C2VkLd9Yi+xI3cz6WKakNeyVJt9+/HsJCgLcwgk1Hp5aI
         FXg/Dcqnwyu76AH+TbrGhVKjjh2W9cwOrh3Gg96hoP+v9Rsh5+12l68LmSmK8a9Oo6tO
         Mjdo0v2Jl3xOnyS/5m9h/TzPmVyYL2y/5X5ZLogwqazjTdWuoI5PW06lK4vnaaPcNIO6
         U+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782452671; x=1783057471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhTrT9L75Q7te0mn0gkYVv6yY0/Erfss1oWJLr7g+Sk=;
        b=lwn0C2zzzGFYE3b3gmVqEtYQbgX2kEedAG6XLy02f4ao7FANh4lvxzQREIl02VRbzF
         3rlJrtJAl1UYnC3p6UxMEs38Yq1/L3wNs7zo4/lPta0EfTvTCd8HW8PwNwa1mYcFIqg8
         ZhL130N9vaFfyynjRL7BTHW7fJj/DKoUIKPjcn+De3ToLkXPESEZAaLEQI1Hbv7ESqhv
         uJJZPJZWtIp9+5rCcmzPLF6S6Uxzsoic1KMD/lOXLGAUXd/Wd9+P/aZd339QBXGDxzTP
         pmHSwaSy7YMwyA8oQBmQSKbBl45xWe3122fiqyRzc5ZS7DF3gvAakYHwXBdWWxCHsNlH
         KmRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RgKJNYcLilqkmdQSXQ4xBuUQP6VN6CyzOL9fcLx3Fn2dOP8lQ9FGV2JjBn6IAZkCe8vrUu+YLH89PtKJHBZhs9Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFZVpxkqBvTb38HNUCFoP/iHn4jtEhmgza0vz7bPoavLMDoGh
	3N53T2SkwD0NEJdv7E+4JzEHP1A3RizlY0gKiOiKe3l4oI+1WG4dTcE/ggGemiOVaDe4gZ3vB3H
	D1hTDEaOsvACo1L6czeeHLGdyUkegVWA=
X-Gm-Gg: AfdE7cmebpiFgl1K8Z+ulpByZjRPa1srOgq6mk+3V2PiPP6UG99LsrWfpd/ehlo1oFq
	7aBF7rPLmr3A6GKa5X6VdacYRJPhaENw2tRCnGbWo0BwA6+tXSK34QJ/rybv/GkrP2pMpMZ5JK+
	PwTbvxhdxAaOz14SVp91XhkCD86jU86nC5+bXgsmT1aBnBZXJ0KzJ0s2tpx56MI0XamHn5sfXbD
	PJ0sN1C60w2BDyqyqkVwlaJHKSF+8XqV2ASAZ0H2AHVThKyCEgl2FwyG91NZpDO4BVL9MOMwr4f
	bdwdmQ6P7/QmqvLMOjX0AmNyY0yvMfIxmMuXud2z9l5xQISmGUtRZA==
X-Received: by 2002:a05:6a21:6e97:b0:3b4:65ad:b417 with SMTP id
 adf61e73a8af0-3bd4af208b7mr6221165637.45.1782452670819; Thu, 25 Jun 2026
 22:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <aiEiP54zktDqAZpG@krava>
 <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jun 2026 22:44:18 -0700
X-Gm-Features: AVVi8CfO6esbsI6YTqzAiYGe6LSSJIEgjFKY99NhG40a9_xC6lXQfgkkPy17DAA
Message-ID: <CAEf4BzYmgj55UnBX2fRoKwtc-97vc7Sf1opWcAXzSKKLr_Ei6A@mail.gmail.com>
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
To: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 3, 2026 at 11:59=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> > > hi,
> > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > redzone area with call instruction storing return address on stack
> > > where user code may keep temporary data without adjusting rsp.
> > >
> > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > instruction, so we can squeeze another instruction to escape the
> > > redzone area before doing the call.
> > >
> > > Note we need upstream update first for patch 3 (github.com/libbpf/usd=
t),
> > > if we decide to take this change.
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.o=
rg/
> > > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.=
org/
> > > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.o=
rg/
> > >
> > > v4 changes:
> > > - do not use 2nd int3 (ont +5 offset) because the call instruction
> > >   is allways the same for the given nop10 address [Andrii/Peter]
> > > - unmap unused trampoline vma after unsuccesfull optimization [sashik=
o]
> > > - small change to patch#2 moved user_64bit_mode earlier in the path
> > >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> > >   instead of gettting current->mm
> > >   Andrii, keeping your ack, please shout otherwise
> >
> > hi,
> > I think bots did not find anything substantial, I have just small
> > selftests changes queued for v5
> >
> > any other feedback/review would be great
> >
>
> one small nit on only, otherwise LGTM.
>
> Peter, Masami, Ingo, should this go through tip tree or should we
> route this through bpf-next tree? I think we are fine either way, but
> might be more convenient to route through bpf-next given libbpf and
> BPF selftest changes.
>

I'll assume that no one has any objections to route this through
bpf-next. We got reviews from Oleg, so that's great. Jiri, seems like
you will do small adjustments and send v5, please do, and then unless
meanwhile no one raises any issues, this will go through bpf-next.
Thanks!

> If so, I'd appreciate another look at first 5 patches by Peter, if
> that's ok. Thanks!
>
>
>
> > thanks,
> > jirka
> >
> >
> > >
> > > v3 changes:
> > > - use nop10 update suggested by Peter in [2]
> > > - remove struct uprobe_trampoline object, use vma objects directly in=
stead
> > > - selftests fixes [sashiko]
> > > - ack from Andrii
> > >
> > > v2 changes:
> > > - several selftest fixes [sashiko]
> > > - consolidate is_lea_insn and is_call_insn insto single check [Jakub =
Sitnicki]
> > > - use proper mm_struct object in __in_uprobe_trampoline check [sashik=
o]
> > > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andri=
i]
> > > - added fork/clone tests
> > > - I kept the selftest changes and nop5->nop10 changes in separate
> > >   commits for easier review, we can squash them later if we want to k=
eep
> > >   bisect working properly
> > >
> > >
> > > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> > > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.progra=
mming.kicks-ass.net/#t
> > > ---
> > > Andrii Nakryiko (1):
> > >       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
> > >
> > > Jiri Olsa (12):
> > >       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
> > >       uprobes/x86: Remove struct uprobe_trampoline object
> > >       uprobes/x86: Allow to copy uprobe trampolines on fork
> > >       uprobes/x86: Unmap trampoline vma object in case it's unused
> > >       uprobes/x86: Move optimized uprobe from nop5 to nop10
> > >       libbpf: Change has_nop_combo to work on top of nop10
> > >       libbpf: Detect uprobe syscall with new error
> > >       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arc=
h
> > >       selftests/bpf: Change uprobe syscall tests to use nop10
> > >       selftests/bpf: Change uprobe/usdt trigger bench code to use nop=
10
> > >       selftests/bpf: Add reattach tests for uprobe syscall
> > >       selftests/bpf: Add tests for forked/cloned optimized uprobes
> > >
> > >  arch/x86/kernel/uprobes.c                               | 379 ++++++=
+++++++++++++++++++++++++++++++++++++-----------------------------
> > >  include/linux/uprobes.h                                 |   5 -
> > >  kernel/events/uprobes.c                                 |  10 --
> > >  kernel/fork.c                                           |   1 -
> > >  tools/lib/bpf/features.c                                |   4 +-
> > >  tools/lib/bpf/usdt.c                                    |  16 +--
> > >  tools/testing/selftests/bpf/bench.c                     |  20 ++--
> > >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++--=
--
> > >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++=
++++++--
> > >  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
> > >  tools/testing/selftests/bpf/usdt.h                      |   2 +-
> > >  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
> > >  14 files changed, 653 insertions(+), 245 deletions(-)
