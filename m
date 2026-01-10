Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F2125B2
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Jan 2026 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005409; cv=none; b=Jh/Yx0rrRUTMFFD07ecRl/EMi0gzMV26lJuYE90Ro9atEkvPJ7v/DofzkojoxbMyi62tMNYECrm415tzzrFeBJJ9O7+NcQI/JHJ9G3YlkunulSspLIerAo1HjFDN/b7hnbNaQf69V8QyGoEVFjlvPD8O1xKJXNFzwJNJuVZ2+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005409; c=relaxed/simple;
	bh=1t8DvjGFetfoU7h6Ld/GQvVam8q9XAieIKTtI6rzuDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exhBw35pUeFFOXzF+WtVbOWmSlu9csZ2djTL+Tj4EZLFeB74H66sQ5c87nCJtfGfqqmIxPUeA8RW6YNIhnczNHDqNewsKQiTLgnqCUTFEBWeQesu7QV3sr7Lnef4tUNfbhQwwwZbHeUclSbtsxuD+cHM9jFpjzP/dPmTXMuHy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWynJcuz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWynJcuz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d67f1877so38758435ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 16:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005407; x=1768610207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/Sig1MBWGXUoKxfbOCjXxu2jOEYhW1igfHgGui3UHs=;
        b=dWynJcuziVoEuXraGdyQueA4ySefy5O1/bGWXvCtzodFWWmLjre/VZNQMiFxZuMFG/
         jCdSxhGmR9AIX/RnMnROH4SSmA/MdNwBaHB9WdY+sYVF67PAmf8+fOEXSY4+/AKEB9Qn
         DN23tH+xB+kF0dmyvPJeGx1Kt3yvzs7Gj17w9UFEuD/OHbzmYs5FNdbkFayaNHw/MsjG
         LRM8Pt+aCVxSYlVlFQntZTWchvVDsWD41bWupPNuKJiXB3A9hWpX1ppnIR0xqhNrKBO0
         Kaakn/soh/Gnb58cJr5CNjxnWCnaPtxiJyR3AISya/qbueFI19Pai1iOzhpbcvJCTlO3
         Gpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005407; x=1768610207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/Sig1MBWGXUoKxfbOCjXxu2jOEYhW1igfHgGui3UHs=;
        b=QPo5HGPg7g3/rIBft4eywYhul0+LDmYQMvFMRPaPsFtQApWnW0j24+1QvgUG9i2MeG
         +yM+hldwGdJAUSoh39KQ65Q748dPKPnpkzy7U0GbHYv1dTh296Wgkgr+ldWYdDVZ+TPh
         EYNa2H/QHuwo0iN4qXSVOX6kZcyriAJugVGbZElKuMvDXwVGIO4tnKZ0pH86vul/ATcp
         sul58+kiZgU8Y0qojvVL8yNNb2fuGDhOrnr2nBHC7d6cJC4/7phlMaLohgiBKi93X64F
         /43Hkmv4G1TtnolzE9Do6iwbGh6EIagtXLUIPDCuupGkq0RWIP5E1lYRDgtn1FQX7Q7R
         +MQg==
X-Forwarded-Encrypted: i=1; AJvYcCV9n+KulU08mpUG4JnMBjxeZGf5RnwCYC9/LBlGbLOBqSTnqGjD2jVnYVcJ8yAF6Bpe7bQ7jiHB6nGcETYZjuy26tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ilIGtThOQ/OsNsXJPGrQ4L/1io/A4bjBR9/2sQ0LMwZoIbQ3
	kgXS991gKrnEchMTzj/6cnWVQtj1yaecsR3T9bVs+y3o8jn0pYOsH+4m3/VjZyKJbl+u1eMfRj+
	oqZiI3eCw/wbfYAn1c3GsJDynnnxr0vA=
X-Gm-Gg: AY/fxX6cp6Oeu9dr6WrrJUq3QiU5pZvS63cLQBfn0CrRQZIb5reeX6xph7oZPO503cG
	RDgF2cI8g/w/FsohfeE7Zl1GnSLP+JYQb3vCuJfDu0dlyYHQHUvNIX5pSDDPpXVyPeER2a/jVt2
	Cndhh+JlYHyYf3PJmEGwLZ3EjTwj+1U/9CoUBclPI+VZSX2bTJ/CPV20s2c9yfN1ffDSibLX3Si
	RgJ8Wg4mvFipvAFfcDHB6iJpxIDg3dbI58RWWUOzebDKeG+L7nNMrLgDxM2S+FhihCxkiHlEJfr
	2u8HrPLo
X-Google-Smtp-Source: AGHT+IGW3LMlWa2LmuUzjL0YHhtRZgvX3i/6GcmeqaYqFFGz/azPPBWHL55nnnOgoHySU2SkfToBfgTRNf9D9hzsw5Q=
X-Received: by 2002:a17:903:196b:b0:297:f09a:51cd with SMTP id
 d9443c01a7336-2a3ee442293mr104729985ad.14.1768005406895; Fri, 09 Jan 2026
 16:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org> <20251230145010.103439-2-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 16:36:34 -0800
X-Gm-Features: AQt7F2qRw6Vu7cN5U47qL95oQ7_OEFPKSuwkEVWj2hjYGj3mzII7GsGmQwymQFg
Message-ID: <CAEf4BzY6vVCk_XohdYVmjma4k=QvGb+h+rzOe7hmRLoUL7ZXOg@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP
 ftrace_ops flag
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:50=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> At the moment the we allow the jmp attach only for ftrace_ops that
> has FTRACE_OPS_FL_JMP set. This conflicts with following changes
> where we use single ftrace_ops object for all direct call sites,
> so all could be be attached via just call or jmp.
>
> We already limit the jmp attach support with config option and bit
> (LSB) set on the trampoline address. It turns out that's actually
> enough to limit the jmp attach for architecture and only for chosen
> addresses (with LSB bit set).
>
> Each user of register_ftrace_direct or modify_ftrace_direct can set
> the trampoline bit (LSB) to indicate it has to be attached by jmp.
>
> The bpf trampoline generation code uses trampoline flags to generate
> jmp-attach specific code and ftrace inner code uses the trampoline
> bit (LSB) to handle return from jmp attachment, so there's no harm
> to remove the FTRACE_OPS_FL_JMP bit.
>
> The fexit/fmodret performance stays the same (did not drop),
> current code:
>
>   fentry         :   77.904 =C2=B1 0.546M/s
>   fexit          :   62.430 =C2=B1 0.554M/s
>   fmodret        :   66.503 =C2=B1 0.902M/s
>
> with this change:
>
>   fentry         :   80.472 =C2=B1 0.061M/s
>   fexit          :   63.995 =C2=B1 0.127M/s
>   fmodret        :   67.362 =C2=B1 0.175M/s
>
> Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h  |  1 -
>  kernel/bpf/trampoline.c | 32 ++++++++++++++------------------
>  kernel/trace/ftrace.c   | 14 --------------
>  3 files changed, 14 insertions(+), 33 deletions(-)
>

I don't see anything wrong with this from BPF side

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
