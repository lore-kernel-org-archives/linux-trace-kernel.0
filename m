Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91D202C5D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336994; cv=none; b=CUq5fqIsaNqi8NCpFSALrdUxc7HViENXXMPKX3rUBhpKJbW/ETbQQQqL03AXoersQzQlsWSL08jwC0uTmtRwMNFoL/h4aF28LvWEC/4DXitATzmZG9uGTKJCL5+BppPjlwnOfxfRdbBKadgW7ltqtxYxq84lnCn3pPj8lwwzGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336994; c=relaxed/simple;
	bh=SABrXAfD/yGBv4BOgjgu3huM+0XurmfkG7O4hOZ1p5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZhsPWYYIZef+HG55pVZ1Yv3TnRM6z+sCb2BkiSlwtSdTi9OLxQI9eeLLNqPRqazav0pvnXJCEH9EVImd/C+3jd0kk9FDjhaHQrGelKadrv4xECt97cBP7qdAgd0OG89HgyQwz1Tsf94eNtkIYo+IdQLPo2qQrA5whiYjdJ68z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myu2MLxj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myu2MLxj"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1870621f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758336991; x=1758941791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+JSfjQG3dPuPVsnceUeFZXrh8/X6Psk2dyqFGUkfL0=;
        b=Myu2MLxjcSzKdG1GiIkbYLRZidy4/J7LYDYag/LWnxuos+0nMnEFdgPo2RnzSSspft
         LmXzyixFRoPIYSgtrPOeGwYIYasE9MJvKO9lJRIJXJ2JIb2vYH5BTGktLgzOvd2N4NBF
         GD/a13vnhh66UfJp1onuDSp0euLd2yvAr0XVMj/gy88OwoIZxNiobujLiXFSju9ieEbY
         LO2zQWkgKfXP8gLaHqcryVe1/0xPr63pFai6zuzJrR4JtP+vvWITNt2L0XlqpVZZO7eI
         ULGvv491ffJq0PJUz2fIVYuELvufogbb0x8b3nCOeQRs/ghzLlKtOAJRnti1Jo0Xw3Vu
         fpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758336991; x=1758941791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+JSfjQG3dPuPVsnceUeFZXrh8/X6Psk2dyqFGUkfL0=;
        b=TA5dq3LGGsemQQ0Y/xnQDDJ6npGVORnksX2z87ZzF8FQuoHIAoX/gbZRy9WBe8gom7
         hDyAp3dJkvFX5rnWWROgVBM+rkHzwzQQBzqC/6LL6Xi6OGFzuLGjWLL2gj5D5WospvSq
         LtqDkVmB5ztOzJ3jxvAmyEeavnBR0FUGGXDR/SQCHKTCTIbUYgl51I3WnTntUC+I6eW8
         XziwRUNGzYQRjTLLvMlcfRAnlUgYAuhfVe+7qRDWIz3BSiqCcWaU8groZEt6yrRyIFah
         jASAVUFthGeVW4C6PL+rob39JHNEw29OBAYPsvMKtMma8yv9cH4fg+sZmiLPC43WmJZS
         HS0A==
X-Forwarded-Encrypted: i=1; AJvYcCVG2RvU/9cYpgT4y8vDtHGo3sGTbxF/4U8aPOv9NFVlc/Vxnx/g8v46V0lrItrvoXNaiBmDZzRnoq/pRIIxUprz3AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBI0rvgUsc2eTIkEferfesibT8SeiBRThbNGv8E0JBWpZqidc9
	FFuzLyoIFwVuUwS6vERbuskctqdDxoRZUF8+hOPWOBpGKlmAKntpBthjdwMqt8brM6X6pVCqKu4
	sWkeg8CeseFA/epKUFjF4FxdJj37tlsE=
X-Gm-Gg: ASbGncvZKUKMoZTb2yI8FPhZw4yAU1YPPWhRj/+WKA0qbq64vZ53+xg2IQ9Mxr+n1Fl
	LGd1efgo4UPr5Rs+rnI1AWxQD6v11cccZ74b5BzVFB5uze/5JEbVeyy5zSoyvsYglmfksf3TirR
	HxTvMVmSNZs378uvO7dJpsVuQL62zLEWewty0pOPHn2oG7YPgDvAEWIqaqcEbD3gC8eiU7QhKAB
	PxA4rhYtfveyZYIPjq+yflFLWC/G9ZyENRf
X-Google-Smtp-Source: AGHT+IERAcHZfTN6VLJmmNbMRxg87FE7AYDMD8mBCCmzVyFm3fyh8f+KisZCrkCo2ZtgOPFOA9so43qHA5KIJr1Z9YY=
X-Received: by 2002:a05:6000:2c06:b0:3ec:e276:5f43 with SMTP id
 ffacd0b85a97d-3ee7e1069c3mr3959667f8f.18.1758336991216; Fri, 19 Sep 2025
 19:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919071902.554223-1-yangfeng59949@163.com>
In-Reply-To: <20250919071902.554223-1-yangfeng59949@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 19:56:20 -0700
X-Gm-Features: AS18NWC_zRwQ0ew3oT6b8x8FGxU5FvpZ1QgwjLnU8fS_VUvLw3WzNDgL7YILOro
Message-ID: <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64 architecture
To: Feng Yang <yangfeng59949@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:19=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program th=
at contains the bpf_get_stackid function on the arm64 architecture,
> I find that the stack trace cannot be obtained. The trace->nr in __bpf_ge=
t_stackid is 0, and the function returns -EFAULT.
>
> For example:
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/tes=
ting/selftests/bpf/progs/kprobe_multi.c
> index 9e1ca8e34913..844fa88cdc4c 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result =3D 0;
>  __u64 kretprobe_test7_result =3D 0;
>  __u64 kretprobe_test8_result =3D 0;
>
> +typedef __u64 stack_trace_t[2];
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> +       __uint(max_entries, 1024);
> +       __type(key, __u32);
> +       __type(value, stack_trace_t);
> +} stacks SEC(".maps");
> +
>  static void kprobe_multi_check(void *ctx, bool is_return)
>  {
>         if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
>  SEC("kprobe.multi")
>  int test_kprobe_manual(struct pt_regs *ctx)
>  {
> +       int id =3D bpf_get_stackid(ctx, &stacks, 0);

ftrace_partial_regs() supposed to work on x86 and arm64,
but since multi-kprobe is the only user...
I suspect the arm64 implementation wasn't really tested.
Or maybe there is some other issue.

Masami, Jiri,
thoughts?
