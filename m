Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5726FDA4;
	Fri, 18 Apr 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970278; cv=none; b=P+hO9/pPuV2lb14e7R3X36uiiOsQSbgIKYtltdEDrspuPXc9+QXrWcneUci/RIUEjvqU+fd+NG49vzieUNf9PDmd9DMgmBaO3IFnZTCN4iI41/tcTtDCHXrVE3VbDKKg8oHBEogUFJu5X4Rf6tRBUU6457G5l9zs0M0DBfmoE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970278; c=relaxed/simple;
	bh=QdGPYEWnf1mJjlpPJrENrbvJsClpPNG75kMnxBynrX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcwAf4+ViRFrWyU3grslSZe4DEgBFJcbn9FI/CBZbA5+orPVIAg/ktvR+PXAIA3KVas9aqimefhqWuix0YKVB1p+ar9KBunKDMawuV2yZK5K787wugSNKqgew4Ht+Ohha3LopfHqeBdpAdAruidZN4vyZU+XALyXGYVbnNSoC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtMsQkMP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtMsQkMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9FCC4CEEA;
	Fri, 18 Apr 2025 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744970277;
	bh=QdGPYEWnf1mJjlpPJrENrbvJsClpPNG75kMnxBynrX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FtMsQkMPkvLtYQhbn2vHpmYSK90nEQV2IvIZq2jgEn4a+IO3mfmoQ9lXOfUQLJfAP
	 ukvPWhJLSdO6qMFDWsgavDw7uvW4OgYtq01teix4ZEolE/p8tzxcGMAwzAJHF+5MUA
	 GDCRUlXQ1UqOb+0QiieHVdrVOQmKyEIIb3IWYob+TuJGmbuwzQtV1x66EEW0Z0wEos
	 oDblkVSnhq50osth3pw6efqbGrEUielkfSV7vXkOSl+f/pBjAoB+80uMDaMRiYtZVD
	 8MAJMAPYBluyLQ/NQoJSyWx8Gtc2+A9DG2uRhr/UM4hzlX/DRjMZvrtgGV5mvytJHz
	 tmMm6Ir/MsJdQ==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso14004265e9.3;
        Fri, 18 Apr 2025 02:57:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLur9hdk0ZtfAQo5AverfQIIfEujapCQdugr+GAaUc4kjos4netMffBf7Gye9x9LH38o8XdvsGHumzauqCILykobAC@vger.kernel.org, AJvYcCVuf9nkkPsuXYSb0AFpwrpqPa+15+E2oR0SqLnu+IsbxZvfPGo3JGYkk7MaIVDQu0Nlqcbat2sp9RSl/f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmwEz4SPE60zeDc6OgQPmUtkY6ixcDiJtCvrdfQ4xLYsqqKXb
	Tig1fz/2gJtpCfGplfkBX5vCXYY+X/2xhyZ8j1ndo3XM2u28eEBQcjmW/WFR5ybF82+NM2d5HgV
	xoKybPBKyEInnWbId316o7IiRu2M=
X-Google-Smtp-Source: AGHT+IFh7dJFhOh/tUHYTQtTLbQ09SGHWRr+mcEFY9snalid5pSMr6ky3gCW7K4kMDga2CAL14oYoFoDAQIREnqsGao=
X-Received: by 2002:a05:600c:3c91:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-4406ac0fc21mr16955775e9.29.1744970276347; Fri, 18 Apr 2025
 02:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417074952.1315641-1-bjorn@kernel.org>
In-Reply-To: <20250417074952.1315641-1-bjorn@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 18 Apr 2025 17:57:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTRv4a-sEgjAvMm8VatFpnYoTVNM1+3XVsmnh=i8TuPPw@mail.gmail.com>
X-Gm-Features: ATxdqUEP6OCbknqd91sT14FYjke3t4k3lbqWbMYYe-uTyoMA8JsVf2DWM3yq3Lk
Message-ID: <CAJF2gTTRv4a-sEgjAvMm8VatFpnYoTVNM1+3XVsmnh=i8TuPPw@mail.gmail.com>
Subject: Re: [PATCH fixes] riscv: uprobes: Add missing fence.i after building
 the XOL buffer
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:50=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The XOL (execute out-of-line) buffer is used to single-step the
> replaced instruction(s) for uprobes. The RISC-V port was missing a
> proper fence.i (i$ flushing) after constructing the XOL buffer, which
> can result in incorrect execution of stale/broken instructions.
>
> This was found running the BPF selftests "test_progs:
> uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
> uprobes tests randomly blew up.
Good catch, Thx!

Reviewed-by: Guo Ren <guoren@kernel.org>


>
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index 4b3dc8beaf77..4faef92dd771 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -176,13 +176,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsign=
ed long vaddr,
>                 *(uprobe_opcode_t *)dst =3D __BUG_INSN_32;
>         }
>
> +       flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
>         kunmap_atomic(kaddr);
> -
> -       /*
> -        * We probably need flush_icache_user_page() but it needs vma.
> -        * This should work on most of architectures by default. If
> -        * architecture needs to do something different it can define
> -        * its own version of the function.
> -        */
> -       flush_dcache_page(page);
>  }
>
> base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
> --
> 2.45.2
>


--=20
Best Regards
 Guo Ren
