Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CA2264A0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397618; cv=none; b=dOJqlx1mEbG2cZXAkAEZf1GD0/58gixdIX1KyJuc9h+3KX8A3KYMcVu7JUzuO0vFw+kWMoGCe8EYX6XUgNIY7PwC1a8DBXCObiD5GGprwFNIwAaWIoRIvcNUTq6Uw08byQD8eAIzINZcraxMNxNE4YQibJ7z0VWv8gDCL5qspv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397618; c=relaxed/simple;
	bh=qmfm4nTYXj4d67e/ZFdu+FoHVdOEgEHWQ62Qb0rfoMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI6LkCTyZ8n2vmvLeWpNuJYpshcRHdWRgV/GAI1yun2Szgrqfz/FlfGY8jDtYdjbP8KrEqR3UPmpGd8AzH3eTVlWSI6gnH9yNJye34kex/01T7rpXO809E7WL1re3XbPLsgZzeNm8jZHTYFTqepPwuiDXmVjpx+NjbdhCfCBnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llymclVl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llymclVl"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so343982f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762397615; x=1763002415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQMsNO0O8rvC7OlsNCiFi+ASZdXsyJZBbfNsI/gMNY=;
        b=llymclVl7fm/bsXzFmbKyOsGMBeHkOZJpK10Os23fNjfC7kLtvFM9tWARrgkeKb3GG
         4yu581xERMKR8xG61CvdBkK4jam/0CVFFrNXi/lkk0HSG+ttOugnDFEPTm/quU2T2RS5
         CAqpIAjTYFNSXeEmQi4i4Nh5y436lKmNPelwCvW5iPh8q7h4eQWPFJKl0Xozzyx6K6ts
         9f8CNiot6umhp2+q8g9HASs0wlH0AFdZKYQUbSuJnt63t2e15ruhFwvOPRtlWrO3HnJL
         ExL3xT3ovg/jH+poCfgbaLAewhpktYOMPwv1fKBcetcXDPQQeXlgI1dwUrQrJmd6KWrv
         qdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397615; x=1763002415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQMsNO0O8rvC7OlsNCiFi+ASZdXsyJZBbfNsI/gMNY=;
        b=B8mHZYxGZo+Q6jjlYqXap7si13m5ZpCK+MlENnJ3HaBcrk53FGeCHmaKEAtq1m0X0Q
         tb37F8KmTc15tnpk7JTQzAuR8CDQovZmg/I7cV/7Rwty96gOyWJrKNFL9sUTNK4bM/UA
         2pz6GEtqkM10BHTlYYDngFofokgL/SNAnOo6fPzlfld9okE7p7agfipV0+7Dn8X+Npgc
         nWydaZYHOhRbQ0qXb2hHDYdUbKwUcFZZf3/aVEf4JULkw5LS4zISYk/t0RcGFAcOn0nk
         TMNuzab9kyXJhfQOWKwg02QJeTuavSAcINz+opUVzWULUwEUVqV28aRdqtiaEa/YOzS4
         VFhw==
X-Forwarded-Encrypted: i=1; AJvYcCWi7SW67gieSdeGO3+XT17JP/dY2OWAKNZwL5N822dc417gLhk/hXiOCEDUT/j8dzc7/S+QE2a/Ci/ymOGA27FKoOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+OVV2WcV2dv8c1Q3oulsvyTqNrTsFwCpxn5R+gWqE8wKY+XS
	nwlGT4xYji5zJQVc5qBmp66F9R7Imww258QlJvmIrXIgUZAGwTdYnF4qmeMcxiKU5p1HMvTOzqV
	WA4CYzbdyhVYrtMByKkwuHsS1zg+pAvI=
X-Gm-Gg: ASbGncuXFvJMvUrqMMsq30niBlM09sXIxTlrl45DRgXb/B90uBwClPDHviaffToia0e
	Tksq7IRttaf1J3AIRZO+vsguNOGPnRPDxo8vyA9WpwydV/Qn3gC1vmp5TVcQm4vqLX0VoIX79MV
	npVz1iOAflsJLYvMwDXrXouB0qU5jBsKxq6x+C0SNQcbYcX1TWtyvTyf3UGdYqKZWN4nHZW3NJY
	kl+WWgtfBVHO09CAITWg9EDvaX3KYjm0tTy1+qxppaquykNEGP5lbwIsSUDYAfsWroc6s7LBjJc
	dESwH2GsrZ9fd6sExqMDvn4OMmD6
X-Google-Smtp-Source: AGHT+IFgHo9WZJKTS4D4CZPHMvUuqKgcTvl9SJ9/dfT8HptvgBagea4p9NuA+sU2B75qOpkO7ninSQ0FH88nOttOqyg=
X-Received: by 2002:a05:6000:2287:b0:429:d6dc:ae3e with SMTP id
 ffacd0b85a97d-429e3313344mr4775045f8f.49.1762397614770; Wed, 05 Nov 2025
 18:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105142319.1139183-1-pmladek@suse.com> <20251105142319.1139183-4-pmladek@suse.com>
In-Reply-To: <20251105142319.1139183-4-pmladek@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:53:23 -0800
X-Gm-Features: AWmQ_bmqzU40z-SC7k7ETvJcX5sVEBdPvjsWiXW7M4e2QXc-RoIMyuEO7uyuVL0
Message-ID: <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:24=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Make bpf_address_lookup() compatible with module_address_lookup()
> and clear the pointer to @modbuildid together with @modname.
>
> It is not strictly needed because __sprint_symbol() reads @modbuildid
> only when @modname is set. But better be on the safe side and make
> the API more safe.
>
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID t=
o stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/filter.h | 15 +++++++++++----
>  kernel/kallsyms.c      |  4 ++--
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5c859b8131a..b7b95840250a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long=
 addr);
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname,
> +                  const unsigned char **modbuildid, char *sym)
>  {
>         int ret =3D __bpf_address_lookup(addr, size, off, sym);
>
> -       if (ret && modname)
> -               *modname =3D NULL;
> +       if (ret) {
> +               if (modname)
> +                       *modname =3D NULL;
> +               if (modbuildid)
> +                       *modbuildid =3D NULL;
> +       }
> +
>         return ret;
>  }
>
> @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(u=
nsigned long addr)
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname,
> +                  const unsigned char **modbuildid, char *sym)
>  {
>         return 0;
>  }
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 9455e3bb07fc..efb12b077220 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr=
,
>         ret =3D module_address_lookup(addr, symbolsize, offset,
>                                     modname, modbuildid, namebuf);
>         if (!ret)
> -               ret =3D bpf_address_lookup(addr, symbolsize,
> -                                        offset, modname, namebuf);
> +               ret =3D bpf_address_lookup(addr, symbolsize, offset,
> +                                        modname, modbuildid, namebuf);

The initial bpf_address_lookup() 8 years ago was trying
to copy paste args and style of kallsyms_lookup().
It was odd back then. This change is doubling down on the wrong thing.
It's really odd to pass a pointer into bpf_address_lookup()
so it zero initializes it.
bpf ksyms are in the core kernel. They're never in modules.
Just call __bpf_address_lookup() here and remove the wrapper.
