Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EB36728D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779476241; cv=pass; b=A7m/BC6ihGMCfU/FKzBuAYVzrfJe+788Bp+dETXOmhpl4ICW5KCz1crYDeGugGXTEegI1xLAHvcsRTFINkJOvmBqTSjjuuWfrYaNNd3h4idTuHFrSIKG5WogeUNV7jSgDW86xUivSOmfs+uKTNx+a4hLyq2AWkIOmcXkXSl6ZPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779476241; c=relaxed/simple;
	bh=KvnXkyyBCcToMR6RAkZ81a4j99YJk0Qbk/aUVQOKq6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXK0aWMhBgu2KYpkmZb737rxW83xKx2cgoAzpcu6j0n1/hS5rB6oShDnK7VshXghMVnuujMfqWqZya8WIAQpA1ScNwBtmtK76/GXGHEW09vuVy4aoUVQLtwcsxECe+Y0VZAjjYKERIhEofTFn8Fgccm/6f5FSTbaGE2kmZbi4Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8Kls30j; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Kls30j"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-369002b26f4so4379880a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 11:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779476239; cv=none;
        d=google.com; s=arc-20240605;
        b=gBJqjAa0SKFxMjEALMgulfBC4NZpxvGrU7V5BNUGaBLYZe6pqKwkvzTXkLwcKFq6f+
         i2TryqRM1JISYPVWeheFUOZx5SJFe/3uten5EwdHlPNPhwmIxnfVB7xyelur4YJEqemI
         zly86zi+FBXVGfAJl9f+hvclx2Gfl/2qvVXAqBn4NwH87a5NPgMpS/TwV2e5pqNFb+dq
         EzmOzpz2pQY+I80uSDqy0gOcz0EOxMq/C5VeRszbEATdvdaUZ0p2gk7iMrL8t35HEbZu
         PyiPoi33kHd5o+FWtx0468rgKP4dKoo5CcssWHPTQBy8Z5ATeIP/usTsZslWT4jXH7Uh
         D3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XO+dDzVXtvu6vrmWqh59X/IvoZfOr95EfYx7Z0jp+Uo=;
        fh=Og+eYktWk4GqFuvh1IFSdsiGeWTC29ioqR/UxOlvYUw=;
        b=iGfNQi56PizU6eGiUJHU2hsnHXlPGCi4C44WMjQybx0Ap8FqjBG3tXimt04Ha3DtrW
         gFK4nGhkh/FltPKrrDX4GE9x9nDcWm1anvX3D8s1iVsdY1e1ifUuL//SX2u0Z75BJ/ro
         1CFrDFctxXEXDitgiGpSdJtmveWHixbY/RX7a5XOeQYPOww0EnWhNzK+9ulXgPukINtW
         pp3ligPVXx58BogPOU+Du8FKjlTw5raVMbc5s4li5eYB6GB9XVwVkYi4sNasENL4pZKD
         EWCCCdCKdgUMakuYqjVNWzb+NAHSNHqdZSTo6ECxGjqgToz2orgdktInn1LAQfO7pbNx
         QGWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779476239; x=1780081039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO+dDzVXtvu6vrmWqh59X/IvoZfOr95EfYx7Z0jp+Uo=;
        b=H8Kls30jVAr2evcdTOhs6zs5/C5qW87tlzKfqfb5AZSH77YVHynGm1igHGlXjomiEX
         7UOXTEDsG1GS79L5k4w96RMP74wG7Uh5HSfi4nid5XNuM81I73qcvKNsmANtBZ5NKMHt
         mNR9+BCrlTtA3ZM42ht4Yk/zwJWPzHAoDj0CbZp7lndgpgcGFM5I7z+c6Qe6OwcLVzlY
         G05GGPD9hKRNxTGpC4sP1b3zX6Oo9HrAJgOF5WhIuZBhb0oM90TUTjD2g/7+ZuSWNb5L
         QjAMNaqieYC7oI5i6vlXkv6F7BFAbwrDp83RahqBLNSWQWsobX9YeEy+WMkWcsV3rUVh
         dLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476239; x=1780081039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XO+dDzVXtvu6vrmWqh59X/IvoZfOr95EfYx7Z0jp+Uo=;
        b=GUF8NXEtNNFohFdcbDLYLFJmwFYQzw6LmUQib1gbRmXHD62jQiSeaZeckvPVjysfuT
         OeJKjzz3Qy1s7cs41kywcM71m4uW3FEOQuZTsNWczWmCkTwmsSSuxPCXwYZ8yq0pcwfi
         NDSP1eJbuqnJmP74U2mORSfF+BjCAE3dL/TvMGsKJELAuFcqHApbLGKh+JrKVzDVGYnQ
         0u/zVolrr9re7+rSiUToV/MWgbrfj3up5+cl/FDilP+tjcUcfbCgUTSZleoy6lHlXJki
         994Ye8wZxNUFkY4QKjHZba1p5cyLFg4w1Ig9Qvq28MGI7Rk0r1/I7H8RXiIDd9eG1gGQ
         vvRA==
X-Forwarded-Encrypted: i=1; AFNElJ9FEkkVZdmTN5lq3UW5eN3kdZv2wR0uscPiXloS2HZhLzBHN33FlrbtzsZ8LWqeX+153GehY2UEBTpW/PXrNvDgPbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67CLrc4OTJj5x1vgs4gICK0DdorL6xUhv4PoiAumpJvrAOkfC
	ss7zJgonFmRJhdHFp+NSRiT5CyZIBmXSCI/MnX1gQUpUq12ntKl69kdJ5/YzqID3f5v7pkhcJQ+
	SaucV3zQTvrrxvIA2lRZzOY6T08PzkfA=
X-Gm-Gg: Acq92OHLIdQ3SHuQe7pKw7LzyR1G17XRZ2dV2awb9pWuulx9Xr48a7U/Xzlz1pqP1NV
	FxNEki0YuQqimQaSLf5A/O5SA9wuKGvo+JWHuXnPBKp5zAH1LBRoYbb1XrUpw0Sm2GGE/agllaB
	DoBBh+VNtOEqr7Te/2e3iLfyx5I3Nt8Z4tXelhZFYXZWv2aEkLNnGgD6lz1KMXE3Fq+SZ96W95y
	NNmuTKFwLbM94bRsW5KOMW4qAaxUjAaRDq5StH+FhDjt78DJgiBx0Tc1FIAM6xyXVilGjsR5+lH
	PzWjnffXf8/2fqBOhjeGyGc=
X-Received: by 2002:a17:90b:33c1:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-36a677303ccmr4500182a91.11.1779476239508; Fri, 22 May 2026
 11:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-9-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:57:04 -0700
X-Gm-Features: AVHnY4K6VCnW74mH-qu0lu-YDdA-o94r4C-kRqw70HIPj74Zva_JJdNwjmZtqSY
Message-ID: <CAEf4BzZn0NvNwuPdh10z+MAdw-9K6CgZ0XnAL0J4XRpQHhFv2w@mail.gmail.com>
Subject: Re: [PATCHv3 08/12] selftests/bpf: Change uprobe syscall tests to use nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:45=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Optimized uprobes are now on top of 10-bytes nop instructions,
> reflect that in existing tests.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/benchs/bench_trigger.c      |  2 +-
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 28 ++++++++++---------
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 25 ++++++++++-------
>  tools/testing/selftests/bpf/usdt_2.c          |  2 +-
>  4 files changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 2f22ec61667b..a60b8173cdc4 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
>  #ifdef __x86_64__
>  __nocf_check __weak void uprobe_target_nop5(void)

heh, nop5 -> nop_a_lot ;)


>  {
> -       asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
> +       asm volatile (".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x=
00, 0x00, 0x00");
>  }
>

[...]

> @@ -420,7 +421,8 @@ static void *check_attach(struct uprobe_syscall_execu=
ted *skel, trigger_t trigge
>         ASSERT_EQ(skel->bss->executed, executed, "executed");
>
>         /* .. and check the trampoline is as expected. */
> -       call =3D (struct __arch_relative_insn *) addr;
> +       ASSERT_OK(memcmp(addr, lea_rsp, 5), "lea_rsp");
> +       call =3D (struct __arch_relative_insn *)(addr + 5);
>         tramp =3D (void *) (call + 1) + call->raddr;
>         ASSERT_EQ(call->op, 0xe8, "call");
>         ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> @@ -432,7 +434,7 @@ static void check_detach(void *addr, void *tramp)
>  {
>         /* [uprobes_trampoline] stays after detach */
>         ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -       ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> +       ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");

yeah, not jump anymore?

>  }
>
>  static void check(struct uprobe_syscall_executed *skel, struct bpf_link =
*link,

[...]
