Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3831F99B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009240; cv=pass; b=Anv3uSIVa5GTCJ3mvEWihBckOHgdxiJs+wqj36jYIkuiEtBRZfa+sCckYLdLwdIaWf7n2DCrpcSiOK2AI614Pi0wY60lK1Thjlj4iFpMR0RV7k1Kl1OdCEz5C/fVOBSDc9wyQs3oKZQd8p6fK824S+9pNXS29o8Pe5nO6Ib4h/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009240; c=relaxed/simple;
	bh=AbxhAA4SLquf6Zum5gkBUik/6+9F6bRTK9QJ65RTA8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHnAkczvgklrD/Xh1k4jjrkPcD7tt8/S7QBV9UHu0wUF8lsi40xt5rOuKgHIFJ37Q6vr/VtfNQ0KizmNb1rLbrBoIxXt+teXsbXEEsbhdyxg7eIKJUC833ugBk3uU7LAPtqJobQpvKejSF4HRr17XWH42PKdPPE+uC/4oc56AqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHB+xLYt; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHB+xLYt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37d82f3a244so1737046a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 09:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783009239; cv=none;
        d=google.com; s=arc-20260327;
        b=fBmIm2xBhLI5mkqjoLnm5inxZ70Ybpln+wXFdOvCGZ5cFLfjdAlHmNan3E6x254JdE
         O2z2fMHyiYGpQXMbyhynZuPeWUbDkn9ZrVnvdE3L7h0H8BqM23dzB7q/KKBhVqd8kmSu
         YA3F9AaoeZi0EDFMukZEe5/vUqXYo25Aq30NWOxJ9YT7j0Ue5njw+8vTh/Yog2QVpwQm
         Zp+b8jSgzZipoKT9F9ONhI+hQ/UrlDSj+zu1irDUWHa5DdRJlf/9eJRDw+GlirAsp+D1
         efi9EZO/3i42YKuyqrqygdqRmogf6xO/ICcFnSjOwOifexMLj31Ed6Ov25Y7F1LuA49K
         mVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAJnHDBbX/83CEIHOc+h8RqgK2NST+BsSxsSaf65zLI=;
        fh=kq9Pen0yWKZbahb9boN1lpFBJhFb+XiGvmLLU6jXu84=;
        b=gRiY36ucxM1Ct7BpHI6pG+6Vk4qRgSkkktGOMZRZcba0rPRbICMSjIQpjrm5Qgqy68
         SJF3l6ba3JPPabTDxZAN852pufHIPY1gumWbmB3MjKMd2af1edHLMgtmrCjLkiXzGPla
         WRM6uTMFMhdrNLvUWtmUnTmE5GgKTs9TcTOaoFKW+iolVV769WwchHX4Tgy9oGW9L/IS
         sE9jOao2KPLWWPqlRXwhHWcHWKq/Iw+DfhCORTg1zT6yNhS6xuLi71KJKc8Xekcgwo/c
         cbQUSe1hHuMoBet5ebw1WtLo/quGfsE1yvsAcLQPGuapQb0BXnwrXl3exi2s9NdAUT8+
         SeEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783009239; x=1783614039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAJnHDBbX/83CEIHOc+h8RqgK2NST+BsSxsSaf65zLI=;
        b=hHB+xLYttMvWpXFs1CBCNwbfwhZnPeIJSqaV4pN3TtXbBmEk6oFvhIzElF2Ny8qPnP
         HPAfxH/n06AssnCExjYgRhbwH7HruFfLERTGQglOUbJEtstbY3t8NiLokSuTLtUQkDVD
         uNhvpbLjMJhqqWFnQi90Jr9O2k2woU0LHuAJ40B2GoIwzwlaulug7AAFMo6/l/xqMP2P
         pvts47upA2iGHkJyKwZA6+Rvv5+RdLFinKjxkoiNPvbMbAtuI/r+ZaIaC4A3jRQqTZ7b
         smjnog9bhOGtibPHwyTRNH26A6ykIyCHaJd+oGlnVAO5hT3hXo928Xz1xK5RnSAn083l
         otNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783009239; x=1783614039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAJnHDBbX/83CEIHOc+h8RqgK2NST+BsSxsSaf65zLI=;
        b=N4bK797Kw3zkHsiVYrzswolLCJPYMRKn9+qG4THgRpvuXDnyQGFuIIMfDXtdUeAixv
         mwJbbHq6RMtS+YeHuK1QAyW19/PLwcfgJP7moXNpyJHuMcTYHV5O4bFD6MSk5fEdvuW7
         injikD+Z3nyID3QLIIpsutV7BXiDrXP7ADZo9xmzfpZDJ9EeFfR8G8mT9gys+21WUCK0
         AhDs48tO7A3coba88/1smaXezfSHPFcul11zBrk+4owOxnKZrj/M1DM24sJOi/HNDQvA
         lpfLoC25THC/8c4wcZ4eRebBO4hhDgNS3ybHlDWapS2PGXDzVOgjed6vhZNckocbFlYz
         1NXw==
X-Forwarded-Encrypted: i=1; AHgh+RrheRBDxENcUh9df6T3fJySU5rKRNkg+3c7c/p0psdXTaUa1HnhYZIPqYZvIPUFdsWngYZIz2v4P/DkPS/5i3ycsZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq76ODZgj+AcOfeSmzCdkYO1uM+GEM1lQw9CSByeVe/c9Dp0a
	uTqao1O8BiO9Qhb7S5Gh1oEAQAMFULv2sP9p+ti/i7EP8rH7GcErGU7xWKsnqiss86K+Ou1hhox
	W9OsinISXG7pMUQ8daIKdxVVtnJ5YpYw=
X-Gm-Gg: AfdE7ckBc9fdU1Okep+r7JEdL0bGAtDpJxjX3ArYGPhYGBtw7JskZGvJiuxPrmhLyJg
	NkW7Hfc7gZzBICJUj1vCyDozV2ZwaacCKMLX/bzyliUYhkSpyOf4IMezhOB13cHiggKi0NGsWDc
	lh7fX7S0YYLexpK1qV2q4O1ykcR65URgg2bVhb/55KPERk+ROHwgUScUqCzwNyhKCVBSo/WUOI8
	2T7aVB+rMJZQEeEQq2LZ3UwAoualYOTz+ECsawCb7ri0LU+LAFJ9rMhTFe0ghI06jgMJs0NrOb5
	TiNyEr2jzv2U63watoEmW903hnJIIRRIhCQ+IHKmxJAnpYFlNy9b04V5yhbwxKtL9zfyPA==
X-Received: by 2002:a17:90b:534e:b0:380:9d0d:7ade with SMTP id
 98e67ed59e1d1-380a9e39c77mr6962041a91.0.1783009238577; Thu, 02 Jul 2026
 09:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701111337.53943-1-jolsa@kernel.org> <CAEf4BzYiPeLTbgeVEDKqU45oHBFJgU6ULgK=3i1J7dbzKS2+yg@mail.gmail.com>
 <akZJZth3-fVUhADl@krava>
In-Reply-To: <akZJZth3-fVUhADl@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Jul 2026 09:20:25 -0700
X-Gm-Features: AVVi8Cdd0hjaOMgJY4gkX8pZsaH8cMTgoYASFLQFE8XssD5U-NZbt0K3FsfHuRc
Message-ID: <CAEf4BzaDwwW1ebPO+4r5rhmdyXk+XddWTDBzN4iOaCU8qEPZRw@mail.gmail.com>
Subject: Re: [PATCHv5 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 4:20=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Jul 01, 2026 at 04:13:26PM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 1, 2026 at 4:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
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
> > > v4: https://lore.kernel.org/bpf/20260526205840.173790-1-jolsa@kernel.=
org/
> > >
> > > v5 changes:
> > > - several selftests changes and reviewed-by tags [Jakub]
> > > - add more comments in int3_update_unoptimize [Andrii]
> > > - several other minor changes and acks [Oleg]
> > > - move insn_decode out of uprobe_init_insn to simplify the code
> > > - align uprobe_red_zone_test to 64 to make sure nop10 is not on page =
boundary
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
> >
> > ASAN-enabled test_progs runs are not happy in CI, can you please check?
>
> I failed to release link in test_uprobe_fork_optimized, fix is below
> I can send new version or separate fix

yeah, please fix the test, adjust comments as pointed out by AI and
send v6. Seems like Peter wants to pick it up through tip, I don't
mind.

>
>
> also there's 2 things to solve/discuss once kernel changes are acked:
> - selftest changes depend on:
>   selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
>   that is taken from libbpf/usdt, I pushed the PR in here [1]
>

merged that one, we are good

> - as bots complained the patchset breaks bisection, because kernel
>   changes break selftests.. not sure what's prefered solution, as for
>   me I'd keep it that way rather than mixing kernel/user space changes

I think it's fine to keep them separate

>
> thanks,
> jirka
>
>
> [1] https://github.com/libbpf/usdt/pull/16
> ---
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index eb067f029a9f..e193206fc5d2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -988,7 +988,6 @@ static noreturn int child_func(void *arg)
>  static void test_uprobe_fork_optimized(bool clone_vm)
>  {
>         struct uprobe_syscall_executed *skel =3D NULL;
> -       struct bpf_link *link =3D NULL;
>         unsigned long offset;
>         int pid, status, err;
>         char stack[65535];
> @@ -1001,9 +1000,9 @@ static void test_uprobe_fork_optimized(bool clone_v=
m)
>         if (!ASSERT_OK_PTR(skel, "open_and_load"))
>                 goto cleanup;
>
> -       link =3D bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> -                               -1, "/proc/self/exe", offset, NULL);
> -       if (!ASSERT_OK_PTR(link, "attach_uprobe"))
> +       skel->links.test_uprobe =3D bpf_program__attach_uprobe_opts(skel-=
>progs.test_uprobe,
> +                                       -1, "/proc/self/exe", offset, NUL=
L);
> +       if (!ASSERT_OK_PTR(skel->links.test_uprobe, "attach_uprobe"))
>                 goto cleanup;
>
>         skel->bss->pid =3D getpid();
