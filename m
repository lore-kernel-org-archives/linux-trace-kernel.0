Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A51F948;
	Thu, 10 Jul 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128487; cv=none; b=mc77uowgtMU5YMZhDUhGpIrYr8brCeReEO8Go2rXLkPnGUGicojnfDzkuap3niI8JkQ6TATnAn604vbJUzWV/GURToeJirbwVjePzLlGS7SUd+QN7lo7VAvTfQZOnBKDh81qm1EwwJp1zSiSNEM6nig9dNzXDcfj+sBZ4mhf8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128487; c=relaxed/simple;
	bh=3VK0g5yX+5MXamCiciw8gTT2Y0ypYsIyeBfFgXcL4+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3vJtREl0oa9cQA+QEdEKy9N9enq/+2ELfh39ORG/kIt98movshNaRopFWDKMvTGoTAM87qzqEWa+pfNQqQBP2k5/5lHT8jf29vhXbcuSquY+zzPDqQswOQtTyb+yQkxYgs2D1j9s1/PaU8nEmNMNUoWQm0mgtIpGwayHGYJz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBVgd9jn; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBVgd9jn"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53159d11cecso538732e0c.2;
        Wed, 09 Jul 2025 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752128484; x=1752733284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG4giksOjxTPwU+J2iWDHmet2nmN8VvPq1vMXwURQq4=;
        b=dBVgd9jnxIsr2vfB7yzynSkEEl+5P9/gP1WPdwXEcWwbIBrrr+XdHW7/rp4xoRwhCR
         CcwkvjAcNGLgMgC3lO7/8GgN8FolTkxLCJ79rp83FXMjw1cQUvs5xDvs5D49ITxuU0yJ
         YE59xKmgugTkLRLAQUkDQAFHRyqK067RnPENkRAVsQXNgrNQ/ccCIZn5Fa+4vpsy/yF2
         kMKFozomfOVXU9SOLQrHKAKyrGyUNNT3CP9YscolDjlOXiSOzA0Ylo9oiMYa62AzFmzV
         RfWilxrkQCuYy6btRqDAFkdpTw9DREGUwx/BtJJE91EKWiqjMEucGYBh6PHEPJXZ8a4n
         mAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752128484; x=1752733284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG4giksOjxTPwU+J2iWDHmet2nmN8VvPq1vMXwURQq4=;
        b=huAzDBJ8eKQAAHBsma+GsOyzqnKjLOEP1KTarMUkbLic/rIOWWDJUMFyV/3Luwgyff
         rGYnqHv/IIYY1ivMzWxV8PFrubV8S9NfXG/1AAkUSoa/XKlT1B8OAPZ1+dvCLwQro+17
         p1tAzITYzaO6jh61/beaUkzKVIIaCwcGd3T+HtBMyIBMk7tT6U+JhSUqwP++X3xqevXR
         6QBTI8bW5J/+NwXW7iwfNZzBKheZ4RAIzKP/JSjhXYyRNwQJHb6XxU6riOStr3FYKKsh
         JR9Gngw7TQ3wg+8FiLNI5GNfdnHrpNSLIG9RTSgXCUFrR+xPjOT/6W/uOtpnPFzqZXmB
         gw3w==
X-Forwarded-Encrypted: i=1; AJvYcCVrOCHa+ItIOGxNbnQPiCjzhxMQksoOsOlGj1SFZOYBrRtuTKtUo3wRlQ6g8GVmZT5daIQSlGot9DGJyFw=@vger.kernel.org, AJvYcCXYBfbM5CoRe6VHFJZatIoyTXDs6iNr8V+5BH7IhWdfe1UzBhqn454GBThTEmUrDmTq7ATUSBQot6trmg2Tw6+YgC0C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00ZBFqK6/FlUa+UOKOSNfTff62oeaqHIsc2qWaGdE8V6a3/Jk
	Vw5a3c44CQ4PwM+hlpNa+hrFNBiAIhuB02IG0UT1+w7rXhxuDJpnQnYIdeSHH2nN7iNcyfi/6fA
	VIBSmxNEIe5IHL3X7PAcMZS0A/W7caKc=
X-Gm-Gg: ASbGncugGcC7nL3WGObEY1KBP3/nZ2dp17Gk3a6Cck6jtqfsnuvSykNYj/4YNBW8gUX
	JnDzNWNNUYiuhTHXl45x0ty3c7LRhPAOVPTnfRg6iNqzDLj9yToQNum1iLIEtQd8SGEi9SgZs0h
	dNyGddCLxIb/Cfid3XeRHgk60uIhWwVXV0FLJIfgU=
X-Google-Smtp-Source: AGHT+IEgfvNN9FUwR3ZzrltKi9tZrr8t/tLqZDsrlrxTUcs2wTebLZttNZHuq1wo9nJSxTMEW3FjE5Desh6wAFxUVFQ=
X-Received: by 2002:a05:6122:1ad0:b0:531:2906:752d with SMTP id
 71dfb90a1353d-535d73ce217mr4038139e0c.11.1752128483540; Wed, 09 Jul 2025
 23:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
In-Reply-To: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
From: Han Gao <rabenda.cn@gmail.com>
Date: Thu, 10 Jul 2025 14:21:11 +0800
X-Gm-Features: Ac12FXztJeD7IrDDbYBNj91A-BzmMZeUwgymejmbAOGChNwao1zJg6R95vGMKZc
Message-ID: <CAAT7Ki-+xk-NDixFhSKNQ_zcfzkQMHfBODVuw_Q52ocJQAHaSQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race condition
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:34=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
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
Tested-by: Han Gao <rabenda.cn@gmail.com>
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
