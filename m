Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AB2D9EFB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144615; cv=none; b=LVha4Kl79ka19TAX/gpxdVQwPGoVirU1PJZDEAHr/Hmndh+3SqejhL80H6T+nXoZocyNLL8RJ1ZV3SdM9mOZr3Aaj1K0bMR+uGM6qgxgfWljJQwAlgyYS83uYcsx5FovP3OkOm4emH8jSfNU46zU9QxtgyBdwZM1XDKMNCN1cUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144615; c=relaxed/simple;
	bh=DIZzU1eE++/7PwkaZuzWc2ZUYaJDG/bezcInk7fQNjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+vPOTH6j/ureWRsK4o7eGB5GdEtGPP4sc7foqR0ol0WYobnTKx4pFJVmxNXkWrtUNdXwT4WKxfHVXTId8U0FX4zrbDV81zLsBjbiCzb2EbhFxDtXEyhogYm4zpwPWnBK+nfy/cpJa+HqiA3ZhwtqcFrsJ9Oe1vATXPp9Etz9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka82YbmJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka82YbmJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47796a837c7so396145e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144613; x=1763749413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUY9Kr5oG1f+82DKYPpC4rF1anZeeoD4PDGJxv92Gao=;
        b=ka82YbmJFzMnDt/17RgDeAZc7VJjHKKVn0JSBGcobWbB4uBfXbIpKbYBkkNMFZPnJq
         UllIm3j4SDpfe+FsOUXTrIecboEFUgJlI6qvRQKqxilGsDC/Q3oduJAB74Id7aBRSM+Z
         84zHv7cmbZ/rdJTdtk7OTfA7Sl5wA0sE7Viu02SF0kpokHawA6gOi0Om1TLQrjGPbAqz
         PRlkdl5PkbMqz6kQ1f0FCvsa6UmtINQ+qvHhUwu+7whbc0JjKbBzHWbvyTRZmO3f5mfy
         BuTX18E71gc2kWttOuGJlj1nFz09fmvirM798V/gZ6qX6NFBAgO+q/OHi9IpVeMM05FY
         cKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144613; x=1763749413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUY9Kr5oG1f+82DKYPpC4rF1anZeeoD4PDGJxv92Gao=;
        b=m6aISk4tYj1dU7L/20fLctFyP1wbbGtuZQNOlpTZv79aPpOC7WHtjqTzSOOpLqz9zE
         cwhv4rzqAvsXL60GjiMKvmfMUGBsPOoHSXp6vDgFbfdqeRLNC7ydCoGZjUhbLf6qyZoS
         Adno768e1LdnEyqxaJRROhLBwWr85wD8q/jTZgXzLAX4xJnKSpkEyvgIdjKWxflrM2as
         fxoEeIrhV4cNoCMb6DUUx6ez/TpzwWTpdQYvH92ahIZOt0lDq/QW9QkQ6dTDAGpL1S3M
         bNhMwuedEmv7SGsAM8ZCjbW6FsWOmU7tno3D8Z2ZsyaPuxDagwEVq269Occg6YSKc4tH
         0ZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVfjPm3BWLii7HsG3q9TyTrOnyDvRSUWqZI1sSj9w7fKTYhpH3NPAVvGaKLHKAD4j8PxYXouP/f/oOOznoLr2r7nvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+ynSjazQXzzt/WxcBdwCoh9IgmlTeAxh4YtUjfX7vOjRRJ2/
	QvOdBiz9W8j4ju3rF7um65zXbYa5zWnRZMN7dGMjEHQYjekLOko6wye4PrgDv4l56QuLXtZK9D/
	StXdXLy8URJUeirzXYPiLiibFaL0WL3w=
X-Gm-Gg: ASbGncsX5b8p8TSlMpJBwvmIAM3OfjO5DkL2ZXoUyuk82avgDAZqCgbuJn/izGJ2L3Y
	8XYNOESxrlmYiYq0CB+COmDRhje3rai6yb6/4+f18CVTgum6DEemQLih9h8kBCs99fgX+rtLEFO
	mj6rrjRncGGKU9Bmr1z82wpkur+5xV1G4m/Yw/2FGyUXhmTc1LnO0FXgBjClbSAlLynRG+CLqUk
	goH6RT5M6IFSmtF0aBI1dxFCR0gvrbf+NJ6drPYrRrJeEIx+6YAZzoqannFDhMg6pbE0bUM6v+R
	gSI49vbZiJQ/ufY4gledCWmDI18+
X-Google-Smtp-Source: AGHT+IGA5v7xTT5cxBDg3WAJeoMoGbD8RnJobS2PVJO9EoIz/7R/fUKzeMX8ZPKN0rXdHDCxHpeQkTybLa1Qi/A15xg=
X-Received: by 2002:a05:600c:3b12:b0:477:67ca:cdbb with SMTP id
 5b1f17b1804b1-4778febd327mr34647415e9.36.1763144612559; Fri, 14 Nov 2025
 10:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-4-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-4-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:23:21 -0800
X-Gm-Features: AWmQ_blqnXnx7ZZA0_SChClQi1okSMY9gWERi2Y8RHoDySOIVasBUOEu9EtBa9U
Message-ID: <CAADnVQL9cOcQpPkE05p9m8oeZcKSVqMwvF8DnrzNrqT5HozV=g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/7] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Some places calculate the origin_call by checking if
> BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
> BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 2 +-
>  arch/x86/net/bpf_jit_comp.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 45cbc7c6fe49..21c70ae3296b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1131,7 +1131,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>         store_args(nr_arg_slots, args_off, ctx);
>
>         /* skip to actual body of traced function */
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +       if (flags & BPF_TRAMP_F_ORIG_STACK)
>                 orig_call +=3D RV_FENTRY_NINSNS * 4;
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de5083cb1d37..2d300ab37cdd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3272,7 +3272,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>
>         arg_stack_off =3D stack_size;
>
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> +       if (flags & BPF_TRAMP_F_CALL_ORIG) {

Good catch. Ack. Pls carry it in respin, so I don't
forget that I looked at it.
