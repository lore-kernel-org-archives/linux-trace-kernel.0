Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004E33C871D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738501; cv=pass; b=V+tcLS78UkfGyr5hyfQTD9zqJWSm8jGPCfdcqUOTd5o8fhuYqo+EX6L/1mwQoU4D0TazOHquQ19qbT8mm3TimbxHlnhjeSveXEfH8l6412Hp9ZQ+5iX+0GncdyxvXm96B3MhKgl3PvnpCziQodNrk+W/nTwu8yqsMRV7R9sfO/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738501; c=relaxed/simple;
	bh=KFPTccJmCntImLdbOr24nMiiPaYbTmRyYO5D7YOkLUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRpgS8yZ/oiBdJcFuTzi5LHUgkHwKQGNZ2YClYc76Wwd359oCaqa9/VPWyzCbHApw44Qc1pPrKVxq7+Vc3SiJr446ZvyCVC4oaQXJNpL/HnzcSpf6rQgZbwfKy4Fl6e0ltdI5LSvfoL7eRFnXsHiX7TroYNp4xzi9V/1aNAbc5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmoV65V6; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmoV65V6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1382800b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786738499; cv=none;
        d=google.com; s=arc-20260327;
        b=GjUizZ/igAxkm9v9zsO+0elM6w5dkGXIZsKFmX46FIttCbLsEkKGTo7nk5jXHei+QI
         PtrU2x5URmb0rF0U3ZyafODK7/Hd+q0RkNmv5sX/XFFRsc147RiXAEoCfel8XlWIcQGA
         4mqxUqoYOAOW24c160ImpurKE0hf4QT+OX1EKlOZuNItpJPQ0L2UBIxuf8oV7OTv1Z0C
         dAk6cLyDYe0+LUFO6awJXne/ryG29P9jRFCnyKUjHtM4ZYiWOZO6QfjnreYuUTVV+79/
         Tiyn6ebOljN3RhQTWKa+4FHDzSciM8PMykc/S6E7qkyV3bt4EDU1wjZz5NpIKocVp8dD
         CBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/t15TRNaADzO4hHI4fJDqg8v1F/rUP1SbSZ2rz1A+vI=;
        fh=ZGItSqfOJ+UDkX1U7jkcsGWHPfi7MDvMjtZ1/L2LTzE=;
        b=BDI8g+JPMHFIm4bWmXXownzc1f6zrREVB1II2WKyZGptIIzlNVZlMssUnSEFrAgNNC
         ifBrCsaAaq9iPOqIDpMlmgWb6AWcxwih4kDW6q+Eo3yIdR9y3HjvVD8kY/yy3El0Id3q
         kiQToYSOldAUSxWJFZQGO1acFDD0Kh4SsJmv9Mu6SNGv2DyXM6Q7wLECfiP6fQ4Gupps
         1TORU1JFBungk/Ia7IzH2SE4+2SCAf77AUuPeNjT7z9la42eDEIVL4WsAtOTGsvm4RiF
         0jwv3pIhRi02YLhCGrVRYjn9nTKDncEKKi5I7HU6f9GPzXDmh3xTAq0aBfekm13jxSUY
         2l3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786738499; x=1787343299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/t15TRNaADzO4hHI4fJDqg8v1F/rUP1SbSZ2rz1A+vI=;
        b=TmoV65V6PeGz++QcnHa3TCwifo9vI+/ZN6nH50jYzSo2fzP1yovv2r+OMs/5whPihb
         u00uWPGCNwuNVP/WprbJn2LTeveRdS/1uohOwtLUsfBCiR/vAqyiheTOdhL2Ro8/elLf
         0wnXmf6tNwbLckj2paYssv9GMQuJ1Mrh7BN2a3bJgDpnM6HdO0BeLJyvfGhrBf//AU/G
         LX5U3AAHCPIoMIaUsHZ9G0WIki9O0WLqNlhACM7ZXRQv7HeSufFFxzAXW631m9vnWFEm
         kHm3k1GfdWA1+wTlti9Lfb1PHz5POfj7Rm5SYTCD2BFiixcpZkcErgGYTenAlQu2q8ci
         7nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786738499; x=1787343299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/t15TRNaADzO4hHI4fJDqg8v1F/rUP1SbSZ2rz1A+vI=;
        b=iHmT5ZEt04Z1rmh42SGxqd2dNGQOm2/W7mekHNg5Lzyyp6BpvgL5kZWhAiptZLJoAo
         n1THqGtVCzhn1+0Zb8EgeCKiDGOF2Rhl19WRBzjC2PgdRxyE0yiuRO5ncqNm+NH9fe2Z
         7SXQUUxzvgmNjnMaQOrMdiWEG/UmzKkJ5bw+Ttr06a4bXzhYqDvb5uN3Hzuw0zchfRml
         dYa/GXL25wTEl4O8jHXJxHjd7Ts9gQyFonB10rLh3wMm1mnVPjoqZnZTXWmQ+EPSBm7L
         0sbjij+t+xGDI2j9Hl5iBejH3OBaT/N305Dw8wFX3Jd6mxrFi9wnjFl+NIS1TtwP+nSC
         6L+w==
X-Forwarded-Encrypted: i=1; AHgh+RqsugFy+inIBMme8RfRAeGIDAUbNgbCzbMSRMr81ojPY70TYg3qOopKgmzAm1M5Ou+H+gBgivnuHVbrW4SpvaHPfwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJW6ztkIaMgYo9ZcH8nq/w4YUTlaAFtbkSN8qFC+2UQ95IrVZ
	txa0VKZs4Y95f4LzaqYg3m6piXcoQ+Rx7CMPJb/za4+qtJ3H0eN/fzUYeXN9LNqndfFU5z+HNiY
	GKZ4oBtzFNZTh7Eh++kb+CFhonqm2gT0=
X-Gm-Gg: AR+sD11iFvsgNIrLDES47MwEy5GOl51qUA8zEeqYmSJqgkI5EyHKF+NKm2bfaRLU8kq
	n0vjnDghjjyCzJoLj6z7C/EPA7firtkE/6crUa+fSFEEXlPeutv6JtyOY2kynRPoVAuL6w76+Tg
	b/ZbXSIO7mFAaGdyNrRlFQf226MbO8a8TXGqCWbljydPjK4uHdUxroLD7Vf6/nBe4Cx1a3YfMW5
	CXqNlyPlO1YiH0LPdJt1MuEA5ih8acr6HeVtg5rlyomGtUG4TurbInxVT9W65oCMVhyRgcqj+uI
	KB4HmQhjUvqwBK68NFlPcKTncXuUDDrGEI53UZl9Wypsrz6k9vyzi8GbvKN15/gfKo+MGNc9pAc
	eUnsTn1izehGFV42tabLtvNsfGQ==
X-Received: by 2002:a05:6a00:a244:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-84fde15f198mr7774332b3a.9.1786738499136; Fri, 14 Aug 2026
 13:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:14:45 -0700
X-Gm-Features: AUfX_mxfEwwxD12VleDI-Q-iMiYeE3BCkz39VXGAlTLeNCm0p2vDpMxtSEx392w
Message-ID: <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Avinash Duduskar <avinash.duduskar@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>, Rong Tao <rongtao@cestc.cn>, 
	Eyal Birger <eyal.birger@gmail.com>, Pu Lehui <pulehui@huawei.com>, 
	Jingguo Tan <tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Similar to the tracing_multi link support for kernel functions [1], add
> support for bpf progs.
>
> When attaching to bpf progs, it must attaches to the target by text poke
> way.
>

Please spend a bit more human effort on justification for the change
and explaining your use case. In what case you'll be attaching to a
large amount of BPF programs such that attachment speed-up (if there
is any) matters.

Please do your homework. Generating code with AI is easy, reviewing
and making decisions about whether it's the right approach (and
ultimately supporting it long term) is still a human process, so let's
weigh that in.

> [1] https://lore.kernel.org/bpf/20260606123955.345967-1-jolsa@kernel.org/
>
> Leon Hwang (13):
>   bpf: Initialize ftrace_managed in bpf_trampoline_get
>   bpf: Factor out update_fentry_multi helper
>   bpf: Drop unnecessary ftrace_location() in update_fentry_multi()
>   bpf: Add tracing_multi link support for bpf progs
>   libbpf: Add tracing_multi link support for bpf progs
>   bpf: Add tracing_multi link fdinfo support for bpf progs
>   bpf: Add tracing_multi link info support for bpf progs
>   selftests/bpf: Add tracing_multi bpf prog attach test
>   selftests/bpf: Add tracing_multi bpf prog attach failure tests
>   selftests/bpf: Add tracing_multi bpf prog cookie test
>   selftests/bpf: Add tracing_multi bpf prog rollback test
>   selftests/bpf: Add tracing_multi bpf prog link info test
>   selftests/bpf: Test tailcall with fentry.multi
>
>  include/linux/bpf.h                           |   3 +
>  include/uapi/linux/bpf.h                      |   6 +-
>  kernel/bpf/trampoline.c                       |  87 +++---
>  kernel/bpf/verifier.c                         |  22 +-
>  kernel/trace/bpf_trace.c                      | 212 ++++++++++++---
>  tools/bpf/bpftool/link.c                      |  59 +++-
>  tools/include/uapi/linux/bpf.h                |   6 +-
>  tools/lib/bpf/bpf.c                           |   1 +
>  tools/lib/bpf/bpf.h                           |   2 +
>  tools/lib/bpf/libbpf.c                        |  39 ++-
>  tools/lib/bpf/libbpf.h                        |   4 +-
>  tools/lib/bpf/libbpf_internal.h               |   1 +
>  .../selftests/bpf/prog_tests/fill_link_info.c | 170 ++++++++++--
>  .../selftests/bpf/prog_tests/tailcalls.c      |  62 +++++
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 254 ++++++++++++++++++
>  .../selftests/bpf/progs/tracing_multi_bpf.c   |  61 +++++
>  16 files changed, 869 insertions(+), 120 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
>
> --
> 2.55.0
