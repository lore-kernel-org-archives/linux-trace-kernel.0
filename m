Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793290985;
	b=O318QfxBkCqvj5/3ZzXTuHMvk4F4YTWciUqV+tXLHNQtnGVQYVqHZSFYQi+aQhDXd0FK
	 tq4qcTMEXwcfypvxdVPhNaZZVjmhDoU96AZkJ5BWu0DAbT9lsAPTkfi17i15h0fW1/psz
	 3bK08NMZiyeAFHdYoP5hbjxGCrbAgn4xFjt8xL3Y7RkZCXjeOiov3z5mDX6U0yncj015l
	 xIAHb7tMuMiiINZeievG07tdYoy9ndU8kVe19gZ3ZUZuQKbW/XGPQ+0N+Cpw4o8s2OdLJ
	 90VMp9ZgEpDhWC5pDrFAJYkJczXeB1el2J/LGcuOJUntlr3GrhjKp4uLKGAYySCGimA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
	b=XS1UFsQ2GmUMcpq8kyM/uEIUNoP/O+RBIXEHJP2Hm3l/UQnPoMk/d5pSDuo0eg/ncgh3
	 AtLWFtN8VviFA0E+3ImAn/9DIE2Ix2wS519pBBXib+NEwtSP4UN9Ok1EOzlbleROdEJTO
	 zHf2Chm63wPfuBABePoig8a+cV5ZUfWr3AUolhG19z5OOehvRUrIOCpOFr/aBKprMrC2S
	 bs/QY6qle6Ed1sqwyHYwhepgguSNYNR3NhCDV/Mn3RcsZ80OfyDEQ0RO/ALCpJXLcHJ1r
	 kJS64msaKU5yCvAUfLZWKOcGdkNXPncjcY0V2Zc9NJHdoqrChuDpdCBteHVSxlAnm4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl6h3FxT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57E60A2621
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA57E60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl6h3FxT
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4682977f9aso298141866b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 09:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793290983; cv=none;
        d=google.com; s=arc-20260327;
        b=sa2sHcwZu9leLuc1YQRjb7BnYMQyJguMR88visXg+CpTlzfaoRmTDMQbyA2O5i4Jpr
         YUJYRRADBcmeyoJVXRkzJ9gHfWrKm4nLUmSSm2z5BQCbEGV+cD5O0sB0m6XK8xQfknx6
         8M6g78l22Ti6l+fdKD/1LWTpbQsMUxavbNk1+HnmZoThXNM8pfqJ+bPxKY3E2gsr+34M
         13aQ0Yp9EzJZhEnMxYeVvOJBimpbydEhUXCdxupMW79cQmvEGLSugqVkShyLKFsjgScU
         2CmiFEU/P8no9ZALJl+F9ts5e5SrxC4pLggS42kBortMBDB6EKI4rbjke7GR5Yt3Igw8
         Lhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        fh=LDo0FJKz6J5ZhDOIcRKe57WgooAodgZrbkvqNmwyPj0=;
        b=X+Z+IjDZfXJ4s9XcrOfITChYMczWEhuNoDnj7OitRjLCVqiAdadC61Ya5NNSXsEKYx
         MHy2rakzhb/nBgqb+kOw0WBScamny9WvQq+iwegq6hVknUz//186cu8E/aDAAfy3Ynga
         5zfSXbkrq4v+ITEPZLPlDEjUQ7lJBxVug45UInf24BoT0Lfo49XvJAO1CfAfeXNMr2W+
         fni95jrl/dWF8ghdPom4KX4cAJnBnhGJP82D7kkH3PpFMuS4NxJ/RtG5q4xaC8hFujtx
         gqG69Wf2HZczJsqQOkArcY/r2gQTdsl08dVghFEoEJUBJI1uIQJHO9DQU1rvhv7pbpLv
         DNIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290983; x=1793895783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        b=vl6h3FxTysc9yet6D3Q0d2GO8gweert+j49hx6iOwi7wFPNTUWfuBL7fsyyfVvnyvZ
         +Z1/kzcfRHuriJXExOiQjIZH32FZIEYk36Du+K2Qp+xNd/zW+Vw7+cZ+3sHCdKppJ5o8
         eatU0GNm4EFgoeUQ+hg+aufwcL0fsR0bxtDwsqwYPSmTHeXFmK4DaWOmC6SqnWgBoZ3w
         PCxuGBUd4CKVgczgjA3vYepQkhpbhYZnVWmJ7nhg0H7W7tE5tOgms8p4YL8rZwXyG2iI
         Zc2yNh+LlvzPXc6XiXnDpdY/AAXfxq39EqGeUq5qFxEMHK/EKYejffUV2/LJ4wO5JK9I
         JZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290983; x=1793895783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVlt7H45FB16jm/ALidosmXiC35Hp/64GX3dy/IZRoo=;
        b=v+XaBsjSII0eN+u+X9iNO3HDnY3I6aep/BVdA1CTxtKxN/dA9WbRZesHFVskvxu7uI
         E4j/SvgdYp4OuX9rS+tAGnwF82m5jV8Nrfn6Fd1+FVv2VHXnKhu63ywVy2wthG3MPWu5
         DD66iBkDCycBGhbta3e/z2o/J1dyHi5KB/2C29WGoelgvbyL/pBOlfjYRNl7mz1pGCcD
         HJhdHMKnqp9dh6CHAauO/UQsLyXvXKzV772KK9aYRs/Huy+hOpaMwewu2x24xXRpT6Gz
         nWTGXl3FDdxiJo37Y387F0bawze9hDG48C5ssi47KeqnRfgREtn7jGprlqC7HzwGaW1e
         WeeA==
X-Forwarded-Encrypted: i=1; AKwUvByPZRjusUEDe4cHFoFVMUeyiyJl4vV+DtqZt3kR5FiQr2qM+s2aoWiL3pTKMydcL2r930p0DmWjOkVqZlj4caMvQ5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3MZLRCByTvEa/p0qW+VM95abEy9rR4zVzkS/iBiiDGQ1w5Ni0
	GRqjgdQRHmTZWYnaPDU81ZX0KQ2WxECWjZeDG5elsvygPj8peHvE+tW+PAzdhd/5yK0bf5Nbk5R
	LHI5VayJlWTfOorvX6bY0OSNVUzaeiyY=
X-Gm-Gg: AYBFou2T8xMF+c7D+nlCqgsh0qftUJGHLoFp7s0OeTmbljPTQdPEg1beSkrqlbk0sE7
	XU3jodI1Yxe1gVSG7rzDqT1CbDbrKn0VVYpCZsfg6TsRhTGCZFCmC3Qd0glkuSKqDix+hVH0CKQ
	wRq/wm3+V7dkJs8ivUMJcLaBXY/SLHa9/o5Jn77WdyyhaCL5+LR56Pjkyx95gBiPMLjUjv5iX+E
	H8S7v8hfzpIWzHtBwk7lgELAUNfgNILm6ujf7P3csmahsnrShGIrMoHQbTPVGAOKTESNvXKA5Mx
	MOxcGMYnAMeBFEzkHsqG5c6p4fopgt3NruNadnmAtlj+huXd1IidpCKyu3EYAETOcP0jqAOkNIy
	EiLRmqb5BEyyQZT+2LM9yD+plV6cAyop++JvlamN5mzz6wBCgoPicQaGIfa4f7ho/dnFRvmNUE8
	e9uQYmhkOCCktf0kQ5FsRFId27AiTKRcbJDjZR31DJb/GmQ0Dfkn2LVeo=
X-Received: by 2002:a17:907:2d10:b0:c31:91f9:60b7 with SMTP id
 a640c23a62f3a-c49bdf43869mr561025466b.34.1793290982774; Thu, 29 Oct 2026
 09:23:02 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026154948.99408-1-leon.hwang@linux.dev> <20261026154948.99408-6-leon.hwang@linux.dev>
In-Reply-To: <20261026154948.99408-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 09:22:44 -0700
X-Gm-Features: AclHuK8UvOBWlBbj0vfMh3zLVN3mKm1giM1eECBMPqUpu-79pHcpcFNIaDEnC_I
Message-ID: <CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for bpf_link_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Masashi Honma <masashi.honma@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:51=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Since the iter_info and iter_info_len in struct bpf_link_create_opts are
> legacy, reuse the slot of iter_info to place log_opts.
>
> When adding log_opts support for iter link_create in the future, we will
> move the iter_info and iter_info_len to the last union, see below. And,
> keep the backward compatibility meanwhile, that uses iter_info if
> iter_info_len is set.
>
> struct bpf_link_create_opts {
>         /* ... */
>         union {
>                 /* ... */
>                 strut {
>                         struct bpf_iter_link_info *info;
>                         __u32 len;
>                 } iter;
>         };
> };
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 20 +++++++++++++++++---
>  tools/lib/bpf/bpf.h |  5 ++++-
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index aea534764dfe..38dcb31e8c0e 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, link_create)=
;
>         __u32 target_btf_id, iter_info_len, relative_id;
> +       union bpf_iter_link_info *iter_info =3D NULL;
> +       struct bpf_log_opts *log_opts =3D NULL;
>         int fd, err, relative_fd;
>         union bpf_attr attr;
>
> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>         iter_info_len =3D OPTS_GET(opts, iter_info_len, 0);
>         target_btf_id =3D OPTS_GET(opts, target_btf_id, 0);
>
> +       if (iter_info_len && attach_type !=3D BPF_TRACE_ITER)
> +               return libbpf_err(-EINVAL);
> +
> +       if (iter_info_len)
> +               iter_info =3D OPTS_GET(opts, iter_info, (void *)0);
> +       else
> +               log_opts =3D OPTS_GET(opts, log_opts, (void *)0);
> +
>         /* validate we don't have unexpected combinations of non-zero fie=
lds */
>         if (iter_info_len || target_btf_id) {
>                 if (iter_info_len && target_btf_id)
> @@ -824,7 +834,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>
>         switch (attach_type) {
>         case BPF_TRACE_ITER:
> -               attr.link_create.iter_info =3D ptr_to_u64(OPTS_GET(opts, =
iter_info, (void *)0));
> +               attr.link_create.iter_info =3D ptr_to_u64(iter_info);
>                 attr.link_create.iter_info_len =3D iter_info_len;
>                 break;
>         case BPF_PERF_EVENT:
> @@ -960,12 +970,12 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>                 break;
>         default:
> -               if (!OPTS_ZEROED(opts, flags))
> +               if (!OPTS_ZEROED(opts, iter_info_len))

semantically cleaner would be to use log_opts here instead of
iter_info_len, send in a follow up?

>                         return libbpf_err(-EINVAL);
>                 break;
>         }
>  proceed:
> -       fd =3D sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
> +       fd =3D __sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz, log_opts);
>         if (fd >=3D 0)
>                 return fd;
>         /* we'll get EINVAL if LINK_CREATE doesn't support attaching fent=
ry
> @@ -975,6 +985,10 @@ int bpf_link_create(int prog_fd, int target_fd,
>         if (err !=3D -EINVAL)
>                 return libbpf_err(err);
>
> +       /* bpf_raw_tracepoint_open() does not support log_opts */
> +       if (log_opts)
> +               return libbpf_err(err);
> +
>         /* if user used features not supported by
>          * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
>          */
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 826d9cc9ab65..fe3b7fd8512b 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -422,7 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date l=
inux/bpf.h */
>  struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;
> -       union bpf_iter_link_info *iter_info;
> +       union {
> +               union bpf_iter_link_info *iter_info;
> +               struct bpf_log_opts *log_opts;
> +       };
>         __u32 iter_info_len;

in a follow up, let's add comment next to iter_info above and
iter_info_len here that these are deprecated and that iter.info and
iter.info_len should be used instead

applied series to bpf-next, thank you!


>         __u32 target_btf_id;
>         union {
> --
> 2.55.0
>
