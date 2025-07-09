Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188A2E3B1E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070372; cv=none; b=SmwIOrcnNkETYmVPolGiJ6L9s/LMKSK5XxrKiBAfei8NTVF+evLyE9lZ1KL6zGrLs842LA4yxBPHuzUh6BBFHYgo22s4V2ml7fV6r79Kyeq3DTxXmT5Bx8yOBbYvvvvI7KS0HThX0eXf3dhb6KT80MLwB8Pqe+5kOYQCTy7au2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070372; c=relaxed/simple;
	bh=llGGVVKA1oT1cZN3rlDyVVLXljRITRYkWgThTYOXwb4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=aPUjbTsU/OK8UhZ8J2s6iu6JKgMHjiQq+dGBz4aqKhZjMIdyhaN6FRgUsfQR4trw18DGfWYdbFd/xkG7r31thbf05nQw1XgaxGET8/2rd33WN5DF9KXvmPB7LbpjDI5DM0rTTnNFMdLjvUCL0JMXF/DGnXV6LGF6pfL0kF10x98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=En6twdF/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="En6twdF/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236377f00easo71544465ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752070368; x=1752675168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sh1G9uIyIrM8UVHoGgJ08SC2aKmJgvWNLWkVXNGTe4=;
        b=En6twdF/D/TmItdKfNtLqD3lhNsvH+OhDxfaXu6GTZj9FFVTX2FcTHllh9FR+QorD8
         tBDfW5fy/r9yk7JN3GFh4yf5ht1Sq2bEOVnxGxp4iNen3Xx25wmTq8sQbJkRY4fYr188
         Ci/EcgcEpqHLcj9m75qvLcgQHvlGCxQsB7H/BL5P1EgErsZOmiejSrn9akCyJcmAo01E
         veq/X9a8ADlBWXU4vtdf7XPFFvHyoH1lA2fdH1DsoB667y7/kiuzCE51ZqleGOBs3l0t
         Phetdqj8IRjy7gWgOalAMy6VOhsK3vOsbukXmeEkCNA9zDq/82BdB8wp4udo8huTNy/z
         epzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070368; x=1752675168;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sh1G9uIyIrM8UVHoGgJ08SC2aKmJgvWNLWkVXNGTe4=;
        b=WFmtYX91SH+hDtoM9ho6YNrOpEH9UfO5T+CrLGttdZmCoP6dwrK/bwqKD+Z+BOlfaL
         WFLQr/4B9WtXvo6miZB6yYNPsfPFTlB9INBPYMj5sX6heRQNTF/ZMs9g9rA8/GVqhRwX
         6wwOy77QQ+PMUBssUPy9ryeQmm8BoUqB0RS1WqjMwp8LrTr43I/F52UgtdRwXgvQj4G/
         xtcLcO6s6Ixqb6HfCCFaQdA+857YmJD+gK9PNpVh+GpPqVGHIK63F3mz9U77OCCAP2ox
         YD85az9vLFt+8sM5JFweoShrYjT4FwmES5w4wOYpzbyWNUOlGmTtneYxuwkw1+h25oPj
         azgA==
X-Forwarded-Encrypted: i=1; AJvYcCUq9x8NZuGwyh1TV/FuCmr9Qieum3X2iwSadVtUkoZ8NuJVYS6aXPOOJeNgswxPriI1vPpXpzgPdBGZLG782vpah/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGFMOzNSI8b4wkWYFNn/jjnXN23Z/ZUBHwIDn9ULmVtdkUNTW
	YvC9s2yYPObDXxvPcTakQpagdLpkiQ/iozzzQcc00NE9ygXcung0pAGTdBfMM9VI9go=
X-Gm-Gg: ASbGncukvbQ5eO6PV0zlm0USORcpOvfQQ/965qTYGUrpiTbdVpK+6PgPIdD5YRCMTph
	waHHCiSJ+IgcTb7qOPMYtxsXlzzo94cXJAGXaQSP1nRf8sMMBL07F7LLYp2hUG0E/qMYbdbRxVX
	tc0qC8CMZfuocNjkHGnVgtvmIzeEkK4yI7toHV4BDQPhKwnb9sZVgbTWAV/cxFa/5X1uISZa5qK
	cuZVOjHsoV2IUqZZNcLJVoAPdEp5U8M/WZCIsYpvjhR9oGkMiYmbfKZNUkRcP5zJWzUutbJxu8b
	wgKn/pzOqBPcXjNTSfub6Bs6yxppJLWESTOa8WAwVrXpHGLxDspBt9TAs8pg
X-Google-Smtp-Source: AGHT+IHi6+p1+2PoHOilD16rPwmlo4mLHV2Z957WubESw5P4eL10+2uXRGzrnzQf+fdNsRPxpzdLkA==
X-Received: by 2002:a17:902:d2d0:b0:237:7802:da30 with SMTP id d9443c01a7336-23de24d48e2mr986145ad.31.1752070368282;
        Wed, 09 Jul 2025 07:12:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::7:a219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431e1b0sm140531525ad.44.2025.07.09.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
Date: Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Jul 2025 07:12:45 PDT (-0700)
Subject:     Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race condition
In-Reply-To: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
  linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  rabenda.cn@gmail.com, wangruikang@iscas.ac.cn, ziyao@disroot.org, alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-6AFAE150-B97C-493D-9699-545AABAC78FD@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 01:33:48 PDT (-0700), alexghiti@rivosinc.com wrote:
> As reported by lockdep, some patching was done without acquiring
> text_mutex, so there could be a race when mapping the page to patch
> since we use the same fixmap entry.
>
> Reported-by: Han Gao <rabenda.cn@gmail.com>
> Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reported-by: Yao Zi <ziyao@disroot.org>
> Closes: https://lore.kernel.org/linux-riscv/aGODMpq7TGINddzM@pie.lan/
> Tested-by: Yao Zi <ziyao@disroot.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/ftrace.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..22e7bdf8de2b6ca950cf2c8b734bc82ea46ba8bf 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -14,6 +14,16 @@
>  #include <asm/text-patching.h>
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +void ftrace_arch_code_modify_prepare(void)
> +{
> +	mutex_lock(&text_mutex);
> +}
> +
> +void ftrace_arch_code_modify_post_process(void)
> +{
> +	mutex_unlock(&text_mutex);
> +}

IIRC there's a reason we don't do it this way, we had (or had tried to) 
have it before.  It's been a while, though, and I'm just having some a 
coffee so may I'm just wrong...

>  unsigned long ftrace_call_adjust(unsigned long addr)
>  {
>  	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>
>  void arch_ftrace_update_code(int command)
>  {
> -	mutex_lock(&text_mutex);
>  	command |= FTRACE_MAY_SLEEP;
>  	ftrace_modify_all_code(command);
> -	mutex_unlock(&text_mutex);
>  	flush_icache_all();
>  }
>
> @@ -149,6 +157,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	unsigned int nops[2], offset;
>  	int ret;
>
> +	guard(mutex)(&text_mutex);
> +
>  	ret = ftrace_rec_set_nop_ops(rec);
>  	if (ret)
>  		return ret;
> @@ -157,9 +167,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	nops[0] = to_auipc_t0(offset);
>  	nops[1] = RISCV_INSN_NOP4;
>
> -	mutex_lock(&text_mutex);
>  	ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> -	mutex_unlock(&text_mutex);
>
>  	return ret;
>  }
>
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250708-alex-fixes-1e719b9899f3
>
> Best regards,
