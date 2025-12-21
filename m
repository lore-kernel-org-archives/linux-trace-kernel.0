Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FC188713
	for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Dec 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341047; cv=none; b=fFTVs6iOcgepapLpgSvf7p3N+reZGaZqhSqNhmEpN+a2l9dc2jYhUazBDguMX+CMUq2bNqDp5AqHdwtNIdFhi8x2wLY5ugP4weVS4cfRujy+j5I9EFoVnJteFK6XbuemfNfcjPL74znzm294TKT4n7qUiE+0wZPjBu+fi6MnwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341047; c=relaxed/simple;
	bh=uHRfbitN7sQkFHaxmgdiNxAyrck3DPOn6qnRCpV3KOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjId94s22s927i9AoIIHqejtUVflo6qtFctJFK4utmReO3t5dOPF5CLPqnuL1qQ+NxvEDf1aDo8xUuaHm0qe7AagytOk7z9ek9ykDHqCqRjWYsiXN7ti9FZQ/u9qgN7FoUhguoUH4909wGtSt1E6MKW9TpUKy6z/isybgiLjxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3oFNKHp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3oFNKHp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775895d69cso13635585e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Dec 2025 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766341044; x=1766945844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wybj2InSTMZw+DWETHA9CYe6yiXqA72n4l3D7u5Rn4U=;
        b=j3oFNKHpUkbGyV7oKm9fCOK9MLEioYunW/DQgIVhfEbiNdYFQeAcxgt61khw0GX4pT
         5VO+z3Ro1hyaDRGemXqOKHyndZ2+UFaDREEoAI+bcg0ZGxZHETqBCKd2hWEvyaPpO4DC
         ShE/9FKGDUzDa8hpEJRtxWVXp8gwlrkg6hKRH/l4QgWA7uuqXvsbZzrZoRpgOqvfq7HX
         QHBGdQQix0rOCS+gYBDyuIyFVH6kX2J0teDH9h8CyBalO738zT/hFNq7Q3XLYKvZh02g
         LVmlgmHt6e8klH1alj0aV26/qy7xLyT3LTkBJVsnMuR/hQ8YciH6gG6p1HH2T1jugHqU
         XTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766341044; x=1766945844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wybj2InSTMZw+DWETHA9CYe6yiXqA72n4l3D7u5Rn4U=;
        b=vNHq0x4s+8P8NgqadBu8P9WmRkh3+k8ZQkObf0Gq93IWpLg7omuevVl4Zj7AI+2gJn
         2iaqxyesadzUtF+RUkxY8llWmnMPxV/NF4FSt1FROt9zdf5ONHl4HtzIGCbEAeTiYjhH
         2D5dcVJaE0xRYp9tv4GjaHzyc8xxN0aw5KakQLjqxptFZHj43TBEoEcE7ZbVCGThY3FZ
         zSoKtA2GCvHJUZEBwZLee4F/+7mzWywXDjHK7ZeUzjTeAxi7q3NJ3YZFFa1bwvfj4iDh
         nFDeRlmLgtdYoRfQxOjUT75UlTSke/v/rBeXQ4iJvpt0rUVZNAcz8mg+ViVS8XogiM1s
         dMsw==
X-Forwarded-Encrypted: i=1; AJvYcCU2I9zkRB2ctLBeYJ3wMYgNZwPMsFVQ+GFNAkIks4xPUELR5LnxyFlFoblL3KVreFB0AALEyrkVKpl178Dq7hQexRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNLcgBRM9tYad+lh943G3/KRZpFBMiqfMPM4QzEESpn5NVo71
	ygE4vjfWxBOQZJrC0qhBS4txWYlA+33iPSplkvvAT2Bb0R61T93HN6DGmJg6B3YOX4Q2Gm7tFpn
	nXWY4XKGn+H2Eb/BjcSKjvZnEKiM0qu4=
X-Gm-Gg: AY/fxX67p+OLIs3MeqniFnbJl9k/KRMvwvzN4+0x+G4fq3/keoZHGQaGA8SSZpzljmc
	QXSzQ/z3GUgysyWFaz9p7uQxHRT5BFe8wq688Rsxn0maJ1ZkxA8ouaQSR0p9KuKCkYP+vRZumnz
	nRhs5PLkJUfpYSDmnNof0YHXzt9apXpw0ofzyXxUbxe57qcImcKuGQHaitiwnocQ939rV3bMRdC
	f+N67ekNNg8/ehCA6Gb6rR9Q4gdg78HG67vX9xl/OYIryqCCHv7U3MmV8DOL+8kezOoJC+8sffb
	eW00Y0Y=
X-Google-Smtp-Source: AGHT+IEWxYtN8bhMen+3R1R+PcYh/0HpDpBpZsXdNVj0Qpz5ExzAeNU0BU+cwPXz7lZEg0lgbogSfei2Gp8m9xD1JRM=
X-Received: by 2002:a05:6000:24c9:b0:430:fc63:8d3 with SMTP id
 ffacd0b85a97d-4324e4fe005mr8657076f8f.30.1766341043663; Sun, 21 Dec 2025
 10:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220181838.63242-1-mhi@mailbox.org> <20251220181838.63242-3-mhi@mailbox.org>
In-Reply-To: <20251220181838.63242-3-mhi@mailbox.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 10:17:12 -0800
X-Gm-Features: AQt7F2p21hbACZO-a8vTUQw8teBVXAYtcRJmUxymX_zCYAqeTsyxwEAd5nA6uwA
Message-ID: <CAADnVQK6D94P9Gz6SMYTijGea2dLdBQ1AinU6N5-VWoEGEDUvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kallsyms: Always initialize modbuildid on bpf address
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	georges.aureau@hpe.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 8:19=E2=80=AFAM Maurice Hieronymus <mhi@mailbox.org=
> wrote:
>
> modbuildid is never set when kallsyms_lookup_buildid is returning via
> successful bpf_address_lookup.
>
> This leads to an uninitialized pointer dereference on x86 when
> CONFIG_STACKTRACE_BUILD_ID=3Dy inside __sprint_symbol.
>
> Prevent this by always initializing modbuildid.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220717
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>  include/linux/filter.h | 6 ++++--
>  kernel/kallsyms.c      | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fd54fed8f95f..eb1d1c876503 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1384,12 +1384,14 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long=
 addr);
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname, const unsigned cha=
r **modbuildid, char *sym)
>  {
>         int ret =3D __bpf_address_lookup(addr, size, off, sym);
>
>         if (ret && modname)
>                 *modname =3D NULL;
> +       if (ret && modbuildid)
> +               *modbuildid =3D NULL;
>         return ret;
>  }
>
> @@ -1455,7 +1457,7 @@ static inline struct bpf_prog *bpf_prog_ksym_find(u=
nsigned long addr)
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname, const unsigned cha=
r **modbuildid, char *sym)

No.
Please search the earlier threads where this was discussed.
The patches to fix this were posted and I think they landed
in some tree already.

pw-bot: cr
