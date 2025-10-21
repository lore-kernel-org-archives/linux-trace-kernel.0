Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1A257821
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070631; cv=none; b=sLiqSFKpDrck0zLZOtRF41IQUDtKkNnDPajNM5ygdTCLRLBVczYq/eQFIhYzm4EBlyObxcWxkujDeDYrQ8yvYkuxz0pROF5OJOicvbhoTjfj3wi3DvmT93wVzpNZ9ro1lDAgVJS4H7MAZX40U8boDzbIG7XHSsM+tjyKUD729Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070631; c=relaxed/simple;
	bh=uHaCegWf7G1lsvdrseJq4v473UN4vezxPgOeKsQYQfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/7GUWimExinmFFXAEvXpsaGYsmkaGJaEjhnZIzqBj/Ye720gcBByfjRdUE6GlArG/RUhkc+rtBbQv9DViZskV1BLk8rXehTzxi3n0xyL9gy5dqr7gbgfPywyEwpNd6cJ7Qr3u9lWxwsJrBd81EgKUty0Z9QHrPxuEo7xS9idoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2+NDogU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2+NDogU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710683a644so1602235e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761070628; x=1761675428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGD+FcEsW2FFxX+kG8Fzb0HeFi6smqsLpBgWiT17QWM=;
        b=Y2+NDogUB0iETGhC4CXgQ31LdQqAqcvVAm4cv4Pw/8PDCNWVifZnlYrzqoKW4e4vTo
         Srctj0xnbCDCBHoUhNqg2P4kyKOKh2qVA9cJnhfprMQbMt+Zt9c7/3Qm3KOPPXtHaVZo
         khk/CooUbfKTw+aRkP2QK6w3GPWSBVAdLeOygn6dgnx6lc/VFOePQ1ZfDCJk54Jm5DY6
         N7ukILX6OSpXOtC6JI+eu5dSfMkut8CnDEHnQiwgnMKlJ0hJ/6YzcXOV9i97w84Za4YI
         WU/GyPc84CpJksd52Y9dZYI53JJVbe1AUczn1pE+vIOUcWcVJABPV6IIDSNuPlkjr0R7
         yF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070628; x=1761675428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGD+FcEsW2FFxX+kG8Fzb0HeFi6smqsLpBgWiT17QWM=;
        b=ks0t+XXuWYBcCrqimtS1oHZAs6cwjOdiz6DMT4QkXUL7JotZPK9A5YhmLWfYvF9019
         Pz//1uHgx71Xf0w/j2MDMe3upztEAJjMIqxb13gWHJK8znNGlgMsDQKVdGpY1dAE/4HY
         n9NXQCXQfPjeL7qSP1YTjhDXyZXVYSrGf+rlJFTHlQ5QvFfqcg7HB8rn3V4OznyKBwtX
         Heiefb+VFQaNvpyAMyL/EdbDRziiEnBypn68hb9rZHPoMums6T1MKYYdsfjTZBqCZc3g
         gSx3X2yIQUyEJmm9/K3DmiULTVjfbnfSxbH/RxqWQZ9SJkJiQD7IpjPmDTDa/TFX3Svx
         OAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjNBr/P2lrluleRAZ5nSY/lqDcpBBlZcZxtZ0eiUSPs2UityxgEzyx7c/vwHBH/025vf6f7y8eji1MXl7keUz3c3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgP3ImX+h49XSM/v5N5TN1tv265+7ZhUMvjFnIf7wQBhPa6dY
	mOrDlmVrjHkptDGl74t0FfOYbT/zlPeR9MCJv8lyTYsVOB5DJ2kLWj/XLSzBM9EguBtcFz85cCj
	wo40wuoAK2ydvPz36QbriPytYYDroXV8=
X-Gm-Gg: ASbGnctSc0j9WZJz0xUmmTcQgl3+sSBV5L4x6nlyGI6/4vFb+5pErXnWy4BO66d71+j
	In7hU2NBZfLvMt9rzbDHLdxrxdg+vJ6Ox+9ia0zH7K/AVXxEQPNAkd4I3L/Cn++FPnEeS7iQHqu
	Th+TfOZnld2m+zVlG98OxjPnmoAW0rT2uBWSF1xEliXI2pTvUsdIowYrQMIMAZUjQDDykBP5H0P
	38mc+S9wcRKhNg1QLSp1GxjHe8jP+AYfbDKJdUYQ/n9HkQOxBSHXgP5SB1drKg8qhStAsVgZPTb
X-Google-Smtp-Source: AGHT+IHAL3TwL3lSrbbeuTOnvc5N+BYP3uS+YNImwOULyrDGTO3KCuxddBINXlS3GnAhet25AeUZNxliKcrwhe5LULc=
X-Received: by 2002:a05:600c:5251:b0:471:846:80ac with SMTP id
 5b1f17b1804b1-475c400151emr4658295e9.18.1761070627745; Tue, 21 Oct 2025
 11:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018142124.783206-1-dongml2@chinatelecom.cn> <20251018142124.783206-4-dongml2@chinatelecom.cn>
In-Reply-To: <20251018142124.783206-4-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 11:16:53 -0700
X-Gm-Features: AS18NWC-vk9wYK7_8tX_FVlBKQAbSU9jzlpKybVeQNDtOy8tuK9-TkGozXjUbPI
Message-ID: <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 7:21=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
>         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>                                          void *func_addr)
>  {
>         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off;
> +       int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> +           arg_stack_off, rbx_off;
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> +       struct bpf_tramp_links *session =3D &tlinks[BPF_TRAMP_SESSION];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
>         void *orig_call =3D func_addr;
> @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>          *
>          * RBP - nregs_off [ regs count      ]  always
>          *
> +        * RBP - session_off [ session flags ] tracing session
> +        *
>          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>          *
>          * RBP - rbx_off   [ rbx value       ]  always
> @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>         /* regs count  */
>         stack_size +=3D 8;
>         nregs_off =3D stack_size;
> +       stack_size +=3D 8;
> +       session_off =3D stack_size;

Unconditional stack increase? :(
