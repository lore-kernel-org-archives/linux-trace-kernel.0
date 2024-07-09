Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50EE15216A;
	Tue,  9 Jul 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512809; cv=none; b=N0BlcU0E5lCdCNK8Jbvz62IhfYVVGpMODO5xfE+OaaXPcRUeQJOF9tGbDOK9MVXq0BEzXGIp1lYkno6ZYkxViBr1uUt4FyL6JA8uy5DtAhXTYQT9CNxnKNB35E7PGCeA7kd3UjmkXxbq4ZbU0+NWw/YMQk2bKCJCU92VLWnpQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512809; c=relaxed/simple;
	bh=u+SFtLK8/aH+/6ShuSEacerQaiuddZJ11+oAKxLMbsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5qErwpJcWm1cgL0CxeAZ2Cr3QQeNt718uXbH9CcGoQNYn/CdjyA5by1pgyPq6qewV1xYaokCiXb/OjhiTIqO7K+znzvG6ETV3P/b2oGLmuxoFwwn+Gnh5OLYBUw3c/QvKreDwimr7CGvl1TNMVvKN/DjYBalB8d+sxvkXwFc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6504101cfd6so43667757b3.3;
        Tue, 09 Jul 2024 01:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720512805; x=1721117605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWy5fM+Bn3PboFhjLeCT4KQSpv1r3KOtQtodjbe9XhQ=;
        b=geR7/+YSRoDgJN+7xIGlABiF8UqvV0IzmLIckAf9rFK5cfMIzd9W6sZ6ZS7ZDH4ZEp
         OEAg2lwwOPjdCzzv4VrbRxUt1npqCDjEH6ap0yak71Tk/ofZ2tormxt0IgVBoC9bsL1Q
         q4MdHBlNdjjdepOOzt66NLhZ+JQvKFcutptnQsIyqcZRYD27DYgwyVuf/cs0xXNAxX1q
         zYojWOGf7Uuyux3ynE39hnD0X9jo5QJsBNmmSiYbSqczIAkOOLUfqhsmgP/uNgXGZTzG
         HpgikSybeKL5FJ6Ru2eAtwBZLDe7I+kfv1JDZXsFieznMfrxSzT8IY0waWVveU/FjOst
         cEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxJdCgcd9BU0LnBUqSJiZxbcpx3XNcRvWdVpEY/T3oJSB1pf3QDehbtl8ZKSJ//WzCK6uCKpFLh6s0+497fr3thFAQkPjHmFig/JmRbpLnsc08GtNTZncGLpmaxw8vieZvPB5SV2f8ALXy7hjeZxQp
X-Gm-Message-State: AOJu0YyIPX42qa5dajmAbuMejAAkmujGullRGxGeZeYiH/flPrzoTkoW
	rVHgEwHdXgfhFQw2PGoDFtIyB9DcV2bk/IixNxmNdc85vKNiUuhYO3+iRBQw4mE=
X-Google-Smtp-Source: AGHT+IG2yXKEob6PAfUzJTw+lx3KCc3tYFOGMFaahhzaZ+tB6ulPEmpBAQLjSvE/jJlyswCuocq9Rg==
X-Received: by 2002:a81:834a:0:b0:631:6970:eac with SMTP id 00721157ae682-658eed5df81mr20493917b3.13.1720512804524;
        Tue, 09 Jul 2024 01:13:24 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4d2ab4bsm2764687b3.33.2024.07.09.01.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 01:13:24 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-654cf0a069eso31509907b3.1;
        Tue, 09 Jul 2024 01:13:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCwGcMAJWlFyA/vwh5+8XyjnRtCn8GAT24XdD6cscbkVkBPQfdWgaJcBuQIfPlwPK+DslGz1UOZbI3hgO72qTzupO6jDi4WhAQrN5cXui2qtCcRCC23sxh5XkhfY/RuiNsCRZNcwRsTdkLBtvnl9Un
X-Received: by 2002:a81:7cd6:0:b0:61a:ccb0:7cdd with SMTP id
 00721157ae682-658f07d7740mr22170947b3.46.1720512803761; Tue, 09 Jul 2024
 01:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082141.153871-1-alexghiti@rivosinc.com>
In-Reply-To: <20240624082141.153871-1-alexghiti@rivosinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jul 2024 10:13:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com>
Message-ID: <CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after
 patching to avoid illegal insns
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Mon, Jun 24, 2024 at 10:23=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> We cannot delay the icache flush after patching some functions as we may
> have patched a function that will get called before the icache flush.
>
> The only way to completely avoid such scenario is by flushing the icache
> as soon as we patch a function. This will probably be costly as we don't
> batch the icache maintenance anymore.
>
> Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-061=
192a9489a@wendy/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for your patch, which is now commit edf2d546bfd6f5c4 ("riscv:
patch: Flush the icache right after patching to avoid illegal
insns") in v6.10-rc6.

> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t le=
n)
>
>         ret =3D patch_insn_set(tp, c, len);
>
> -       if (!ret)
> -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> -
>         return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_set_nosync);

patch_text_set_nosync() is now identical to (static) patch_insn_set(),
and the latter has no other callers.

> @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns, =
size_t len)
>
>         ret =3D patch_insn_write(tp, insns, len);
>
> -       if (!ret)
> -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> -
>         return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_nosync);

patch_text_nosync() is now identical to patch_insn_write(), and both
functions are called from outside this file.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
