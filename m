Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF72DCF5B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146239; cv=none; b=U81TXIsknYou9V2bwKqenJuhWiO2jDXf6INqh+H+A8hqyaUXMNV8dKliTwTzXkEtr6KJh75sLNxLgyPUieC3rfFy0Wx+wENsORyEOi48oWCUaI3D4gMP74NGBebWFWeBIQDqpMoB9YRr3qntKVTgM8XaEkMv+fk0fGkIow58A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146239; c=relaxed/simple;
	bh=o0nLiDeidi8bShLqc7QiSgoWOOat4ecSduM/jrvRCEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwuaIOwZFriez2++iCldZjXqQnGF4DP6LvhEcGlp1IMscigdOfnI/Qa7xFa+kMVyhY/dYGKwTtVnd17S+A3xFcHW5/wQ+uQHeT8i128IV0GfwdZAxD9DdKsrWm3qIFHTkOoBzQVnuEva2Qb1k44GkEzQlL+CLMZ5cVbZYhYM6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8Mrt357; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Mrt357"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3b29153fso1357675f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763146236; x=1763751036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBpBjbDRIyJkrgomva9hexctIJ4oacfAhoOAaqcQACM=;
        b=S8Mrt357vHGkl+2r9/RbrV1xKEX+Jxk+2rXFHdX7dX7zzliVtmm97RhEMxyp1xRMWi
         KaxTno5m5ltdnC2QLEdBfiR2JtQ2ny52Dyq5euNTCig6xzs4jg8BFOwc+IKzRkwc4lV4
         Y9K6US/LNouo2GU513IZRnEDLU7AOyCWWoMzV8hKB7PuE2IrqA4uD2Mwc6DvMwqTtOWv
         4s7LO5mck+fgsFKL7/uV9ZxXBathjBicDr70asdSVcRZ+VpbI/Mdyr6hKsfv67O3Tnpu
         m9bv2zy8qbhLtTnJ93bdk4MA9nQNFQEIludEpW+LxoSFq8W/eRX5rIYPfY2VkqY0sJ1o
         HJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146236; x=1763751036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBpBjbDRIyJkrgomva9hexctIJ4oacfAhoOAaqcQACM=;
        b=UyGyV466pQ4PB5KWhvQ99AUjaA33UnBvXBk4Itl8KL4vvQEyO5dOcfbzIyo6foG8U3
         LI+eAIxUMs7pzn851leOjLoTO/4MNrcy0wgxoU3naRWeKV8ZkbTuP4HgjJEkFJzuxNgt
         AJYKehhyNtKwEL8ucYqGwsFIU4E9eC/5rD6zOmrRGeupwS77ZM5erzu+7Q+2UG9mskqv
         Drf/VYY6vll7IuN2r3lOcnyS9o6yL3VcJUS6tt5PyDmItdGmRdhtwX+a6Ce2GFRXboxR
         6zfqI2Vtsut66j7dubhmbg4IWulH+u9qRQX4CqEejh8Nmq/7tGzYuCxkICqkL2qbTchY
         vB3A==
X-Forwarded-Encrypted: i=1; AJvYcCWtjTxNAQiuCyIHfAVo2DBkFHucupuVsP0VYZeF3UDO/z/N/9CEPnv8ozs8rdQN3Zdz9claXeRdDuAFmPt0KDSfj1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzsE+uqwubD9fDH5AmYW/VUe70GAYbgNBymoIsdjH424jUYB9
	hdyFc+Eh+lixz0IYTkN4mbYlXGggMM7LnW78gWHeY9bvue6JOAOlbvWrtj+F28z63DMNdMpP8UP
	azY2E0RpE1b0xMkk+XAu2iyoPoTGPVu0=
X-Gm-Gg: ASbGncuxY3Qs5ElXJ5zZ4g+qUWPXzXDoFhMHFEM57eg1y4p5UaK7WZRoI01eBSrp2ro
	HVhMlTOKjPij+YELTGzWcUE0L5FaBf7+OTDwj8MjWVaTR6IUFA02f7nIzGVuRxMeaYyIasAoqOm
	6aVjH1W1XybXeeZelDyE7ojslNPAeLEhgL8eF/p9JAlStf8DiDniLjERem4k2F7SxE2hp/My4qZ
	6IKRzGN8XoezX1WYUbXNhVgumLzIEC8S1D5WFMNr8EP4GpljSIqe62fypMmPaprlWzKGkAT+3eZ
	lYLOZoRpAN+OLQU1+MJ3haqjGuje
X-Google-Smtp-Source: AGHT+IGYhqPBpY4BJBIp8RjCMead5TIvpDutH+yTfcNB9BHfNZ+5V7WN+ZKMp2dP7zDyYxsGjavBXh77aTreE8DjD7k=
X-Received: by 2002:a05:6000:1845:b0:42b:3aee:429e with SMTP id
 ffacd0b85a97d-42b5938a9d7mr3914945f8f.56.1763146236195; Fri, 14 Nov 2025
 10:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-8-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-8-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:50:25 -0800
X-Gm-Features: AWmQ_bkpZsCajzZsBWMsfYKPkyzLLgDuVad6krgXnJLzbvVnTeqidHufIZ_sf2E
Message-ID: <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 7/7] bpf: implement "jmp" mode for trampoline
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
> Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
> case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp"
> is needed.
>
> For the bpf poke case, the new flag BPF_TRAMP_F_JMPED is introduced to
> store and check if the trampoline is in the "jmp" mode.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/bpf.h     |  6 +++++
>  kernel/bpf/trampoline.c | 53 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index aec7c65539f5..3598785ac8d1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1201,6 +1201,12 @@ struct btf_func_model {
>   */
>  #define BPF_TRAMP_F_INDIRECT           BIT(8)
>
> +/*
> + * Indicate that the trampoline is using "jmp" instead of "call". This f=
lag
> + * is only used in the !ftrace_managed case.
> + */
> +#define BPF_TRAMP_F_JMPED              BIT(9)
> +
>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is =
~50
>   * bytes on x86.
>   */
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5949095e51c3..02a9f33d8f6c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -175,15 +175,37 @@ static struct bpf_trampoline *bpf_trampoline_lookup=
(u64 key)
>         return tr;
>  }
>
> -static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
> +static int bpf_text_poke(struct bpf_trampoline *tr, void *old_addr,
> +                        void *new_addr)

The bpf_text_poke is a generic name. It really doesn't fit here.
Use bpf_trampoline_update_fentry() or something along those lines.

>  {
> +       enum bpf_text_poke_type new_t =3D BPF_MOD_CALL, old_t =3D BPF_MOD=
_CALL;
>         void *ip =3D tr->func.addr;
>         int ret;
>
> +       if (bpf_trampoline_need_jmp(tr->flags))
> +               new_t =3D BPF_MOD_JUMP;
> +       if (tr->flags & BPF_TRAMP_F_JMPED)
> +               old_t =3D BPF_MOD_JUMP;

Now I see why you picked _need_jmp().. to alternate with F_JMPED ?
_uses_jmp() suggestions isn't quite right.

How about bpf_trampoline_must_jmp() ?
and drop if (!ret) fallback and BPF_TRAMP_F_JMPED bit.
It doesn't look to be necessary.
