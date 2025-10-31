Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C825782E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874950; cv=none; b=urvTZ4lXBTGj7/DRiTJQMH50fqPH0HxZhJONUjdmvSoKdfcYtKTkba3rxGQSxwg8Ir2zou2jjRPvvm+otR9lTXa2tVvUTzrr8hr6L7bJHsoIJZM6vTrHac27xjiNKF6m0D/x24jHPKy4NEr8vStB3KZj4Us776FUFiUVHQVqbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874950; c=relaxed/simple;
	bh=2ATUNGgbaZSw6y4sW6ppozk2GJl7GnxzpyFCiq20UPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGK8D9b7Xi3ayHn6GzBe+XxjoPqu+FkwWgzMsg6Ty8Uii4lRM/dY/8tSTNxPLWaP20YHnBaPtEEFc8yT6JBnArZbDEja4YA42qCpYVgqgWuiybtYnp5Ctk2dCG34dW3KknNcNu0Rs34iGZoDR4XWaXw9uRer9MyDURhOyseeA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNJN6Q7x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNJN6Q7x"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710683a644so15724555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761874947; x=1762479747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcA2fuPv0nibJjY5gaLuKw0u8MBZgVhL7lh4erE+P+w=;
        b=KNJN6Q7x+09HFG1z3MRfzLk5FkOv6YDPSRQArFOZ442yfP95jQFd7XArxq4CLY5qfM
         QI0S/3GFJ8deigXQw6yTyKw0zoojJhB0LYW6n1U9oUr2vJFgPdClFn2MC0JjeBQ6sUOz
         GRGSfQ/agjxJqFY3d/rlNmt6eafl6z49Bh+jsiCDFj5gHmIm3IihV8VqJRgCtFkUKzHh
         yxp09M+j4DgO9UNwb5V3rnhsJgPnXCJkoTHB0yPC408aPpG9ILjgf1Lg5kPIwTlnwdFA
         jqRqnocLf9DcOMbA3ahzm92CfbmSqZENsOq7LsBwmFWkOzL4iWC3VbZmQvoyAHbtN6LO
         L0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761874947; x=1762479747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcA2fuPv0nibJjY5gaLuKw0u8MBZgVhL7lh4erE+P+w=;
        b=DX4mehmj8I1JU17c17h88TZjLAQHWlQK5QIqADaUJyRg8eV4TTcjc7I9EBgk9LNbi3
         /cTn/ITz7wPAaafzjv4yvARz1HMIgRHIkEcmYH3rHagQDhFBpSVJNWTllbCU9WFKYwoF
         aWEZtpb81S4fyEDbx0KCMmHM8LDecHvkw+prAimKC7CyXIktschte39gQIa+SvC0+i07
         s37K33Wr7A+YxC3RSQYLQGyhTOEHlJLsj2txHJ4gnrDSNy3dHQrCAMC3Z9o5PjXgnMfG
         CK1p5Kt0ll4nQet+SIdQL4gvFyfN2jdxnxBjE5UcFXc1GWH2nsilkoqPVr9fV+imsyF4
         kCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHovqrnfQHWwBqiIItuLhemwshp5Z86rB/NrECMV4MSbqGqcHhNfQteM7IBuI0uVSWSLKaIO8vbaD3W8Ld5urULHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oi4vIC8oPpK4jfr6LHiKxnZ8emKOZhBFSAAzNbuF1d+4XQ1+
	8IM+QUXxRPxxUwpDaWLjRm9rmDpNF6XRJsRwcGSZrHaplLJ/pcsnXBhS409Ix8C71kUEHOyO081
	G+7qjB1BHelT0nYLsFvYcTdcd7lrBRqo=
X-Gm-Gg: ASbGncvX35//kbMq9EDPuPgwZEQiHctt9szW1b2kdLWyezyxn414e0gGjVHUiHMKI4J
	SHLb1MUw1g3DlYF1ZUXtQrs5jqtYK7MjVzH1l0Yy0MuKregROKCCv+HIOMeoAz88hrW5ipLq54U
	4o2vpARydtX+5fkTgSRrBPg7EYM6FO0oJUTMF7iOERwqCYkKo29yXx6QNT9dOb21C321RWPZpJc
	iY8dqbyua6AZL2+FH8gKxdvFZ6IPMF6L/VYp871YcCxZreJwFT/NLZ3aKj9XTrFNol+VQpseU68
	4Dj5oJCRQ2BLVTmiVQ==
X-Google-Smtp-Source: AGHT+IHjgEAGnr4nfdh0LhSmnH+sRjuCT8RoVd5GbtltDrO5Kk8/oATSx8VT/19HA2xAKXMbh+mARs050dlD33ztYz0=
X-Received: by 2002:a05:600c:8a8:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-47729701baamr22601315e9.0.1761874946389; Thu, 30 Oct 2025
 18:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn> <20251026030143.23807-5-dongml2@chinatelecom.cn>
In-Reply-To: <20251026030143.23807-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 18:42:15 -0700
X-Gm-Features: AWmQ_bkU5AnX8Bwj31yvGuqNgMmOr74c9fvilG5ffkhrLd1xgPSqCBlrOWUn840
Message-ID: <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry and
> invoke_bpf_session_exit is introduced for this purpose.
>
> In invoke_bpf_session_entry(), we will check if the return value of the
> fentry is 0, and set the corresponding session flag if not. And in
> invoke_bpf_session_exit(), we will check if the corresponding flag is
> set. If set, the fexit will be skipped.
>
> As designed, the session flags and session cookie address is stored after
> the return value, and the stack look like this:
>
>   cookie ptr    -> 8 bytes
>   session flags -> 8 bytes
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ...
>   cookieN       -> 8 bytes
>   cookie1       -> 8 bytes
>
> In the entry of the session, we will clear the return value, so the fentr=
y
> will always get 0 with ctx[nr_args] or bpf_get_func_ret().
>
> Before the execution of the BPF prog, the "cookie ptr" will be filled wit=
h
> the corresponding cookie address, which is done in
> invoke_bpf_session_entry() and invoke_bpf_session_exit().

...

> +       if (session->nr_links) {
> +               for (i =3D 0; i < session->nr_links; i++) {
> +                       if (session->links[i]->link.prog->call_session_co=
okie)
> +                               stack_size +=3D 8;
> +               }
> +       }
> +       cookies_off =3D stack_size;

This is not great. It's all root and such,
but if somebody attaches 64 progs that use session cookies
then the trampoline will consume 64*8 of stack space just for
these cookies. Plus more for args, cookie, ptr, session_flag, etc.
Sigh.
I understand that cookie from one session shouldn't interfere
with another, but it's all getting quite complex
especially when everything is in assembly.
And this is just x86 JIT. Other JITs would need to copy
this complex logic :(
At this point I'm not sure that "symmetry with kprobe_multi_session"
is justified as a reason to add all that.
We don't have a kprobe_session for individual kprobes after all.

I think we better spend the energy designing a mechanism to
connect existing fentry prog with fexit prog without hacking
it through a stack in the bpf trampoline.

Sorry.

pw-bot: cr
