Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EC363C61
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590467; cv=pass; b=Lq9ByKMfaE1rbNF/GZJ2qeerLJaaHEv3BjmVsqSCR4e5QNPFMPEVu7bIlrPE+NvgxRogbiXi+oTSRD4fKKWx+tZbYzQfRtym3WvCM4b/2EcxHEFtHUDWNtIDo7quMCACBvPs8CnuKsNtyEaW2mBhlmI21N4Ij9xjbE42gYAqUZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590467; c=relaxed/simple;
	bh=Dduh/r7rL0wwQLDHT7Dq47LMSVf+sUsG6SXK+otwyz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnHwTIf25HiHiGqkez5f0ZFBFjS8qNPQPzU0qdChP/rcvVqdOEJ3Mo9hyGWvcrC/2hG29Figg8ItsgGghHlC/g2E7HuQ/a+/nsF91xQ0j4A1pet7Hby0MGbQ6ZdfeOq3VNY83SEMMdW46QawjTzB184YR2UbQxxB6FapGmSVz9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juHXYhu5; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juHXYhu5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43ccda008cdso103307f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 12:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775590464; cv=none;
        d=google.com; s=arc-20240605;
        b=kLavSG5oqf5zqkbeNip20hMo1Glg2Hl1zVx1VdCYdGaoajLPwZu1u8k6aeoxt9ZQS+
         VD5lVV7WqCRRBHcjagqcq7WtjjqkMGAE6uqU+wN9poGb1PArO5bytHzFOEJ48kwnTLIy
         mvdsZT/6sjB+0D7ZHyUvh8RLvoKWM6CAUtPR24IjWcuh1imdjZ2JyaGIPaE5aP/SsNTP
         nnJhkXQXBaIDHseepFW22RyhRhnlTv9wN1iyi1X9bdFxPTl3rudjxAG0xiOm4w/ZjuHz
         QRfvKXzdqRvXwjOddVmslNm+mcToFXm8UVCh5lpzpE9zdiUo0LzQwHd2uzCkoZNqLcA3
         X4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Pzp5p0ah2XzFVNCxifp5xJHsqGQxMq74whZrMr4olQ=;
        fh=Jq/YPrIJhmzmr4JBWgqGjzwhqFih2vJiFBpeG2GDONg=;
        b=cxhU8W6AxCK1kMvW0wV2yt49t/oH6hvJ4Ep0z/ZHnbJyaoTFPz2U3z22Zy8Z0hndel
         JDJaKjkfAHxmjQVDalK9lZ9CK+n2uOd/wmiBhznjqmiks/XXLTFnfVnG3VNvlOudePpj
         VGDuJU25N+lXhU0Wus9hrKCwokcO2lVJFuwsUtVgkjwqMPXbDvi/2Uku/uUXXzS0W6Bn
         9P5u9pv3LdgKB6YNfCZU4VNURPzua86Om2enp5WYM5lfb6QCAYqw0gSQbgQ7/GDDYx3B
         MQ6gNScIPh1mNOkF5/o5hLN8rRJyFbN3HvWUjo/M+IKJQmFws864Cwr5EFER1OPkDsGE
         vl2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775590464; x=1776195264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pzp5p0ah2XzFVNCxifp5xJHsqGQxMq74whZrMr4olQ=;
        b=juHXYhu5F2REPTR4Eq2IZaY93he1HAE7/KsIhF2svyb4DkLKIHL/w5q8pd7KWGX7SF
         T9ruP7JGLR66/QnQWw4cLgmZsI7QCiosNRhJrvqgtNa7hWVexgzO7bTyvinzyQ0fjafo
         pbb6NIJy9xeMkw1Tc6E/hfa9fj3IWdEgH+rS4Q6m3wT2vIAx/ruHkwfC4Ogs5TMJgWR4
         TKZhAcgH/Z7cCQdHgn5S57zMIx1BZ/nEf/CEZ4YmMq6ChIrxfsfWKI747nkPiA+pzwYt
         eiXpkwf7PaMuF7wWlcCvfgxNDL+9A4FZreFxfKd3D+X1a7Tb9Lg8pjdX4dwjlmSCg9no
         Z3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775590464; x=1776195264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Pzp5p0ah2XzFVNCxifp5xJHsqGQxMq74whZrMr4olQ=;
        b=EaISGpBZSyzqZOVbb3+TMr1nzK7+FS1Pdbxcz/6hD4rmfZ6jWewR3YkdgHD92wnfc6
         GHh/ENJjFVOGDIsIc7ScleY2whG7AZaA7mXiAhBqpFRT7P4fqQLg9CXikQrjretV9NyD
         2nxI7hGVtUtNVvOoOHGUgzAmSqgd4se8mTUN009dRMQtJ6ZKjzln3NuWC5GH/+ldfeCX
         MmYM7/J0/6nPCTcCp4p996rhPEFVsQlzIJXJ21VsowDKfODrCZ93F22clLva6AgyyGm5
         lm2+G7q/ZH2A/IXevOT9QZlHQQ/daLTdzGqXMXa38QTHMoaioEK2kUdZDZCYJUxIVpXZ
         RniQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL9kiCLwyzBHqS6BsK019x+qBSHgWlx1VA99xOtq/IK9YYNo3DI00/R8sVGO3mnyKbdDwpocpVrYqLPhNfJZfQM78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKTtxn8lB8c1CsstUTzTj6Kekfd3L9g/CuLOZ+AdNokWnNV3i
	YAc3VQUEzfz5yemYG/3oSLMQUj51zrZ+3puzxO1l0+wW2C/POS3vjZKcypMLs32R2c9nYiMBEC6
	eNdxz7BBp7l692RzPl0P0HQTVuTcz/6Q=
X-Gm-Gg: AeBDietBhhH90qSVDcC+594VYH00yAgR6bo8ABQmWuUsdN1NwXrIGJCu+PqGuA+WsPp
	Ooz396wfCx0qY6MoYrOkwX7TZLpuMNdyHK2/gG1W52054FrwU4Yh2xJImGljUBcigu4aLeT8c9J
	AFBv4QLnJbSDF9tNTr8KwE2/eNbYXjnnMEQOPwz1pZk2ZwIAtwsCaotXtTEi80qEpny4acyeYjd
	xKy7LN7p60RwRuhnGmAHJMp4MEyCGU+bgLtw0NZCXx0kTekK3QzGlaaL8VF1CAQDxDKut+TqPd7
	DYT3gUho4WcHs0L0qz1Qz0eOuOggYSCziY0jZ8xciVbIiLBLSzjxTtizDd8RhrNVbHj3gtZ+5k2
	Kje26Hd8YqqaSOKL9SSWddLjfNA==
X-Received: by 2002:a05:6000:430e:b0:43c:f650:cc97 with SMTP id
 ffacd0b85a97d-43d28fa819emr26513417f8f.9.1775590463872; Tue, 07 Apr 2026
 12:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com> <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 12:34:12 -0700
X-Gm-Features: AQROBzB8jC7AXTIBKmRgp7Dw-NfnpoOqtWSEbar1A6pTO4tuGY_3T07kEdK6a4k
Message-ID: <CAADnVQ+1pDz05Mngq+Kv9ns2yaxXhJOuu0JawZYKuLEhBa5F-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] tracing: Prefer vmlinux symbols over
 module symbols for unqualified kprobes
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:52=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> When an unqualified kprobe target exists in both vmlinux and a loaded
> module, number_of_same_symbols() returns a count greater than 1,
> causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
> vmlinux symbol is unambiguous.
>
> When no module qualifier is given and the symbol is found in vmlinux,
> return the vmlinux-only count without scanning loaded modules. This
> preserves the existing behavior for all other cases:
> - Symbol only in a module: vmlinux count is 0, falls through to module
>   scan as before.
> - Symbol qualified with MOD:SYM: mod !=3D NULL, unchanged path.
> - Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.
>
> Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looki=
ng at modules as well")
> Fixes: 9d8616034f16 ("tracing/kprobes: Add symbol counting check when mod=
ule loads")
> Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/trace/trace_kprobe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a5dbb72528e0..99c41ea8b6d7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -765,6 +765,13 @@ static unsigned int number_of_same_symbols(const cha=
r *mod, const char *func_nam
>         if (!mod)
>                 kallsyms_on_each_match_symbol(count_symbols, func_name, &=
ctx.count);
>
> +       /* If the symbol is found in vmlinux, use vmlinux resolution only=
.
> +        * This prevents module symbols from shadowing vmlinux symbols
> +        * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
> +        */

Please do not use networking style comments in the new code.
Same applies to selftests.

pw-bot: cr
