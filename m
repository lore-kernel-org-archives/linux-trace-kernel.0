Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB927EFF3;
	Fri, 11 Jul 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228069; cv=none; b=d52xRRMwtXTUYZQtzCByzlYmhPe7vmPcM7qqtvQZZCgOtps9Tf1OQ+NUSPHN9ZUsrXEmQkM0xbUx4GNnfE1OKEqz6JU48PW03H8RgIXiWmUZaLeIvq/4lCkw7yGLloBXehv5bQuvMvXROr8Y920U7mrmOiM/MTnTEZLmAcNdgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228069; c=relaxed/simple;
	bh=fs/hNw52Iu18eHX+iNxl+8vQ1/AHLA8ULlhk6CfciPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQh9S7Y45qx2rEjHwD17cruTlc68X9uKne3prRYwMiKf2DW1/1LxaTRVbUEHbJrIFWFV3DkRWtIvukfxfd3r1Wp3121Q5FO7zHDaY9G62Xho0nkJwndbUBrTostt2Xytg661JHEoonbqMY/0eI/FO8R3gQw6z/GYV0dm1F5wHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxl0zZQS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxl0zZQS"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3089557a12.2;
        Fri, 11 Jul 2025 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752228065; x=1752832865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omyblvVpTb38AizFlaRpVve2Yn1R+eSTb0zPNz8hz+w=;
        b=Vxl0zZQSRsTaHuq6DRMEShSt0CrQJOBNLgMjTnYxzH5NZcgi0DhRCRfs4FIlHYoZ9s
         QmDMGJWEeOXVQmaeUOqa0WECe+Os8JJ1UULkYm9m5+9nijVjt5f3HVTtXBdHrCjlbm7i
         e8gt8PEnSYZBM1vC8lRYeseTXunU5inXK4gUNTd0B3HIJPNvjuP/pgHhYdjKksY0TCjV
         /70H4z0YyU+gKjxAN5bg0q9kHfJmv/A8pFJTFTuArgwgmVQoVsFRpLxfPtSVcsSwDIYT
         D70a3XvMhBCScIN5BMp8CKg41mmvXgv0ffPAZKJhebeBEKY4yvBQ5dOe0e2/ENMJQ1Kc
         kv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228065; x=1752832865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omyblvVpTb38AizFlaRpVve2Yn1R+eSTb0zPNz8hz+w=;
        b=w6IGP8WOCfJIOlliafBJ86QiF9kHDjOKhH3Kmjsxl56RqwgE4CJpoJXybXslZDTrlc
         c0n3LpQQ5ghrT4qwphixZ9VCd1bUdtaV5ydNI9YPHH8UGkuAv30bqNwhrMB4rB04pTz+
         ZMElpW/ojqnqIxKQFvIDCNLeN/vRpN0gQMFRuZc4HRe+ftddNQR9Y1uKtUaYjM503o/T
         PjvTKBXkgSQ6ISOH5Hne6n4CEjOtEhmfJQuheUHMRqFyxyKCA4V0lVB6Vx9kuuhivmQT
         +WMrnJL1nydujFldIC7bUO1Lh4bm5qEqA9R6rse6LIF8VsP71tI9OuJyU3awG8aorTnP
         gxjw==
X-Forwarded-Encrypted: i=1; AJvYcCViYHCDfb/axYufgYzyWw9LPHXSAbKENs8aunH9xSdKHzVE3YHHNtygdvOB4+5uesvb3N1BK/WMPd3P94ljVHO25uhE@vger.kernel.org, AJvYcCWoVBclKW45tJYbi4/eWt5+gmvurK3mLUiiowvF5nB0QdoX56XKq+v8F8W9rrp14Kh7kBSNAKKzlJyGyDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHv8CZ6yJuGKo6hTt/pPKI+msne/BpP4DxkFt3oWKZCexwY1lQ
	1+WuQWEcuAk3Yt2nRppuk8H6B8mBk6K+16aKYWpMSi+W3/cOL7fj5lSlriiq3GBWjdAnd/SdMBk
	rtTsmjoYLXU1/REI4GQ98oITiXoKxXJI=
X-Gm-Gg: ASbGncsIco2/IKd7IeXpLp9UZwN3772R5d2U3xJsJTVd7G/mtRxgK1htfdK+EDHVbJY
	h0mYXrg8L3MK7HMBKSAkwp9Rxc1ta/E6oW7yKSTReq+f6hqc4eOYk2WeV3kDmYT/nNU0VJ5V+DN
	0qH2WwxjcY28TCiAKKzxVeiWQv05jRJwZL9yfsLFp1mubOe6VKzJl0f2BWCDB1tZz/rMnU8/1Ie
	/FZAw==
X-Google-Smtp-Source: AGHT+IH6/qM6p9/RL4gGjutDzuH70Bym/Rj8wG0AwwKyB95laFU6RGGzgMZDomgQ58EICecTg0oNC3IN9s9bePDyCLM=
X-Received: by 2002:a05:6402:34d5:b0:607:26b4:6959 with SMTP id
 4fb4d7f45d1cf-611e760a9c0mr2223799a12.7.1752228064976; Fri, 11 Jul 2025
 03:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
In-Reply-To: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Fri, 11 Jul 2025 18:00:52 +0800
X-Gm-Features: Ac12FXyaJKrR-9Ah14lDbFtYFAfCE9b58o7FuUmW9mz6wqCA0xjHLslJFwJa4LU
Message-ID: <CAFTtA3OMVwC14t4R65oSWotv0Nx5q0Rpbb_9xHNEkBgN9AoYoQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race condition
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:47=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
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

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/kernel/ftrace.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..22e7bdf8de2b6ca950cf2c8b7=
34bc82ea46ba8bf 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -14,6 +14,16 @@
>  #include <asm/text-patching.h>
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +void ftrace_arch_code_modify_prepare(void)
> +{
> +       mutex_lock(&text_mutex);
> +}
> +
> +void ftrace_arch_code_modify_post_process(void)
> +{
> +       mutex_unlock(&text_mutex);
> +}
> +
>  unsigned long ftrace_call_adjust(unsigned long addr)
>  {
>         if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fe=
ntry_ip)
>
>  void arch_ftrace_update_code(int command)
>  {
> -       mutex_lock(&text_mutex);
>         command |=3D FTRACE_MAY_SLEEP;
>         ftrace_modify_all_code(command);
> -       mutex_unlock(&text_mutex);
>         flush_icache_all();
>  }
>
> @@ -149,6 +157,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ft=
race *rec)
>         unsigned int nops[2], offset;
>         int ret;
>
> +       guard(mutex)(&text_mutex);
> +
>         ret =3D ftrace_rec_set_nop_ops(rec);
>         if (ret)
>                 return ret;
> @@ -157,9 +167,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ft=
race *rec)
>         nops[0] =3D to_auipc_t0(offset);
>         nops[1] =3D RISCV_INSN_NOP4;
>
> -       mutex_lock(&text_mutex);
>         ret =3D patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> -       mutex_unlock(&text_mutex);
>
>         return ret;
>  }
>
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250708-alex-fixes-1e719b9899f3
>
> Best regards,
> --
> Alexandre Ghiti <alexghiti@rivosinc.com>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
