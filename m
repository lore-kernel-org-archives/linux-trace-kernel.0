Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53E394781
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951752; cv=pass; b=kC3DKb6FVKB6N9ypjfiVDq0ARgwv3sb9vlFEU6r6LS64aylv0karvpIg+wMLbaBzycaWGdzjy1esiiT/ICQp9b5z8Ms/B8vIGdVS9Q6RGIiXI32ZiPuYx8fn9I8Atk7jxvmVlO714YiZRDepRmOoRO1fNZGqsqbgsZn7oWl7GDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951752; c=relaxed/simple;
	bh=mqw2OrB4l7ryqRoi0JsPC1biAGfzHf38qCJAbRmuB+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt0ciZD7J9hC+juOcbFzn67K6Z7SMDxWWfHvVsdx/U72/lJOJLgUH2pGT2Ggd1uYmiphIa0urmZqz0ypA5/q0xv1c8EOcv3nP/yg5jxihNYquvoEcqaljgTDCt7OrvGbdpf9jH2S0SzDxvKVyZbZYQxyF+D+8GKIaLfUJttTn8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiXPxBsO; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiXPxBsO"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d8b644473so4770603a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 13:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780951750; cv=none;
        d=google.com; s=arc-20240605;
        b=SuKDbCC/+g+5vu/0qD4vgrTnfzJElh4QBsXDSs7CCDujnm3HLY0xQHynQo5J1coVLu
         9mZ3HzTg1Naiaddw66FKOphojnbkBXLoK1mpsHOnJ+bR1Xgtr3RMw7Dv8xT/JsKosKSJ
         //g6QaX373nOD9b6Sdc+FkI0/PFHh2lgKHMAkksbx4NohIqJyKV9m+GQMHwQ03PqGDjL
         78G2XHQuk+FzsiztWvsa7DgjrY9sixfaqfQgYsQgI+4JlMeG+DSc93KmPqbFF+uuyYc+
         Il8ScnR2KTLF82WQFHkMX029UIJ2cGILdZHD3ZtqD+6aS/UsvZ4+3SCOYynEj4jkLTm8
         Ln8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szcQRKKYkYYaFVP42s66uUUsYAUfyJsuIUeX1ksEXwA=;
        fh=f9WRdQjSVex0SGfQPmgkWG/B65UuZq/2Txgw58ft3yc=;
        b=TTrEI3QdvpvGcq/YvFH/gVGV20PQ+cccLAehnpl2m0QlX8pkG+iHYjjIpu761WU2ZL
         d4xiEZlR9DXUjEhz0bw6Yf77UNTqxQhPaAScobFMzmMtKZ1XC24/mjRPQCMzJu4TbBX6
         NXitBgPssJpGZpE5htssh2N/RIPHItU72XHyxazy+o6HLJAmkmr+fne8lAHht6Pb4cYQ
         IR/Nwqs1r/wdx8/T/jd9pKQiSJmL6D0wkwoX/vws/Iv1B356E3ShoLgUUTbKKu5Y3vbp
         bqqMmJy+cXeAcG0+dAOTdPEv9rPhb4zbj5UB6ZzL3MtwVxLs1ySnvWsYXHn5c9DbXtBQ
         hBVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951750; x=1781556550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szcQRKKYkYYaFVP42s66uUUsYAUfyJsuIUeX1ksEXwA=;
        b=WiXPxBsOpuWgrCjCeMlGEsIooX1nPU0qOSQDX1pQX6jUvEMrbCypazfzir7e8hAinI
         UBka2LtWotYfpdw/V1+NFwyJ2EDKPq9qeMixW5SkYRAhR4+mKEddQPvFK+UgzU+iD8bo
         nzbNFWPM9A6fl4s2BvKEG1e7AZtuYpPzKCpnqvpuW60Kq1Bd1EB0LMS0+XxFzFIzedC4
         M46UptFlA1ocUvob6xEOSExONzPxXUroO3dyIE49wwgaNAa2BtvrJECWGI+CgzBFFyXO
         1Wy0ZmnlBZIFVdTrahZ2IoLPM3so7kJHe9QXa6epI51//9XBtdUSupdNQdy1WbBUGvYX
         gBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951750; x=1781556550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szcQRKKYkYYaFVP42s66uUUsYAUfyJsuIUeX1ksEXwA=;
        b=NgQvPdynNhU+TXwJyiRppkfRNOHZfoJwDD3G3MSSHRtu+tfxYWroO8Cu8+fvlyjoOa
         2ZSVkDNRvyM/v0Hk7xkZ/tAk3EUI39GJ0Lb7krq3+4SkyMN4jRnL2MrCubBpUNbINfDd
         Jid01EXtIaYHEUG0b4xbuge+tKh4olY6DzXNfblMRlmi+HK1oZgy5WuXEFHuZh3fYZZj
         R+iS80HEOcvBiAY3iulb+fW6A/582ulYVMYu+EKuUJaTSoa9nF7FyaMr8wdr0cPLduEr
         ERWiMsCkUHwT13IQAbKmOhUcfjcSN4v2i9V5T0kG2wF7Fzo/QQII1jc/aE9ct75FQj3R
         iL9A==
X-Forwarded-Encrypted: i=1; AFNElJ/IcbsqZw2jPkp0qTWJ1Yd8Cv/5uV+iIbjpqiBDl6ukKRNNBnCwqMTXTP0FZ3M/cG83vIX0P6FqMCHyS7OiZNEjDMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9LtmmG19LXwxSFi+OFhNk+RK9l9zkTXF9XGzHsH4lU12p1zq
	fZNcX1SWY9DEVQE+avvn1quxX75HPpNlhuXscgZfRmnK+h8lDIMeo3zcn5+PKAyAPFkVfMu9HCh
	ZIL1lfTCKNgBhLsGlXiNphFYIJUc43io=
X-Gm-Gg: Acq92OHe1Kw1+MfSG7GWSMi0JS2vva6jFvH97qvkaTtJR1pjxkUVemdtC+93RbcB85V
	LIzJePakVELV1VL41v39ZPWsKa2gnmapw2yjM7nzWGp5+y6mqcU5TGMAQzdnvUderqwqWD2ePyi
	blgf5W646J4ploDWN743d4W/zu2YUYF8KyjqR1vRAHOtR+G12NkCQBDeP9CLzeNmHFr5YzM87Ah
	w4UFPpNcx2vskXlv6BpeJL8nT9rHvEpevObOOYMxcbaxczhYvH9a9uKMdDR9p1GARPL3N73BxMR
	oAL5YKFUvAisfV2u2T7HhZLfcPn3pOiAjdc3EceGb0n/sunkfTdbBDOlZXMHV1YzBwNMBx0w86W
	+8/fua7n3Q3ZCYc3k6k8+FAIzjQ==
X-Received: by 2002:a17:90b:3bcb:b0:367:cb53:7435 with SMTP id
 98e67ed59e1d1-370f1525ed1mr16914932a91.24.1780951750236; Mon, 08 Jun 2026
 13:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <aiEiP54zktDqAZpG@krava>
In-Reply-To: <aiEiP54zktDqAZpG@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 13:48:54 -0700
X-Gm-Features: AVVi8CcxWz4v5RpKgGDZlxpIi02CKmV66vQtWBFlpZJuRHPawXW7c-U_nKUu48I
Message-ID: <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
To: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:59=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> > hi,
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> >
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call.
> >
> > Note we need upstream update first for patch 3 (github.com/libbpf/usdt)=
,
> > if we decide to take this change.
> >
> > thanks,
> > jirka
> >
> >
> > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org=
/
> > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.or=
g/
> > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org=
/
> >
> > v4 changes:
> > - do not use 2nd int3 (ont +5 offset) because the call instruction
> >   is allways the same for the given nop10 address [Andrii/Peter]
> > - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> > - small change to patch#2 moved user_64bit_mode earlier in the path
> >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> >   instead of gettting current->mm
> >   Andrii, keeping your ack, please shout otherwise
>
> hi,
> I think bots did not find anything substantial, I have just small
> selftests changes queued for v5
>
> any other feedback/review would be great
>

one small nit on only, otherwise LGTM.

Peter, Masami, Ingo, should this go through tip tree or should we
route this through bpf-next tree? I think we are fine either way, but
might be more convenient to route through bpf-next given libbpf and
BPF selftest changes.

If so, I'd appreciate another look at first 5 patches by Peter, if
that's ok. Thanks!



> thanks,
> jirka
>
>
> >
> > v3 changes:
> > - use nop10 update suggested by Peter in [2]
> > - remove struct uprobe_trampoline object, use vma objects directly inst=
ead
> > - selftests fixes [sashiko]
> > - ack from Andrii
> >
> > v2 changes:
> > - several selftest fixes [sashiko]
> > - consolidate is_lea_insn and is_call_insn insto single check [Jakub Si=
tnicki]
> > - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> > - added fork/clone tests
> > - I kept the selftest changes and nop5->nop10 changes in separate
> >   commits for easier review, we can squash them later if we want to kee=
p
> >   bisect working properly
> >
> >
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.o=
rg/
> > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programm=
ing.kicks-ass.net/#t
> > ---
> > Andrii Nakryiko (1):
> >       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
> >
> > Jiri Olsa (12):
> >       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
> >       uprobes/x86: Remove struct uprobe_trampoline object
> >       uprobes/x86: Allow to copy uprobe trampolines on fork
> >       uprobes/x86: Unmap trampoline vma object in case it's unused
> >       uprobes/x86: Move optimized uprobe from nop5 to nop10
> >       libbpf: Change has_nop_combo to work on top of nop10
> >       libbpf: Detect uprobe syscall with new error
> >       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
> >       selftests/bpf: Change uprobe syscall tests to use nop10
> >       selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
> >       selftests/bpf: Add reattach tests for uprobe syscall
> >       selftests/bpf: Add tests for forked/cloned optimized uprobes
> >
> >  arch/x86/kernel/uprobes.c                               | 379 ++++++++=
+++++++++++++++++++++++++++++++++++-----------------------------
> >  include/linux/uprobes.h                                 |   5 -
> >  kernel/events/uprobes.c                                 |  10 --
> >  kernel/fork.c                                           |   1 -
> >  tools/lib/bpf/features.c                                |   4 +-
> >  tools/lib/bpf/usdt.c                                    |  16 +--
> >  tools/testing/selftests/bpf/bench.c                     |  20 ++--
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++----
> >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++-----
> >  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++=
++++--
> >  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
> >  tools/testing/selftests/bpf/usdt.h                      |   2 +-
> >  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
> >  14 files changed, 653 insertions(+), 245 deletions(-)
