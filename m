Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76D35E53C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142324; cv=pass; b=XWRNnwz2kEVGSkM9u1myg+V0TllFqORb8QV/fLPmN+147AzL0nl/zxZ7jBVEnAUib3sD7rzKJaoN4+ELj4hK56IGASaJ9mvo4KvibBFgKLV947JTONbaDiYrtryLtiSwTfac52ezgFNNqq1cAqOwoSiFUKIpKNR6wWxlvZbUchs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142324; c=relaxed/simple;
	bh=NpuDJmf9DozXZ6B5ju12xAyZBBYveiccZy0i1uvwqA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw5DbvTgGKhQYj4mgdP9iYPs3rIGy7/CnQn/ZnlartjVYZSnlWb0qNEznhk229ELUdPyHUS8E8beKwgBmnPN8R06ZMRTwEGD1W455q2fS9JQGTfjbebx+lPI9U77/oJdXD84E9KobcFzX+O/xw/N0o8uXswmw0VCkVllwayTmbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbParNXk; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbParNXk"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435903c4040so3997213f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 10:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142321; cv=none;
        d=google.com; s=arc-20240605;
        b=P1qfAKzGS1MdZvdBOn+8vAKLXKK42ytdigfA2C91CHIVM7495MZk5JhTEHlDBfSptE
         RDcdZ+jB1IeL5pij3/Wc3TacykAQm3FNSHe7PM3gVaidaODuvAr3uAW22cNqBO8pljh4
         +9op/IpWg9xcJX7Dj6+Fe2JROXHUlUqL0HQ+FJCHZsIyt4LUqzsi2ET/cwx4P2xitR4Y
         yC1Dv+nDUOZMYvWz8bY6BiaHOX+a6nD7UV1iVS1Mfqw7p5tiKjPS7h/Awp/zb0EC9G3I
         mvjStGBGuqu3wSKrU9oA32/Dy84/hvD4+rqrhkOvEKC21dmSK2HUoyGtEdIkwxR4KcFR
         0uHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VX7w+kwRBRr6oO7XnjzeKtSVTEgDapRmL9gbLdKDZKg=;
        fh=dGFL7dV7eEPDf6pvl50126L8Eu/MdBiyDn9KXQYoj4I=;
        b=P4JvAUl0R+LC3JKyGxuJEBr9AMrYnRQWAaF9bAWpd+xz8jnVLwbfY1M45VzySH7JLn
         JyO9uEWL5mM3Tf/nbzW7/KCiPj4CIIj8pdmBsSTvehCXWQiLgzNZ9fLMjpjbE9C91XtS
         yEhVOuonacO02yaIY3ouartj5W5h+fVXDfZIHbYcr/1BjjqwuFXwc/xewjL9vEc44bAa
         /+Da4LJfqNAxExe7WBsoHN4jwh2iNyESganoflCyrdJ+clEPOSSo1iaX1FGOus+PDtXx
         eWyXYf2SMHqnClKDFt0/itqN74/Ie1ZxrmNZnZTthw1ViH80fT+CFy7cmwGuBdR1N95B
         6wmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142321; x=1770747121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX7w+kwRBRr6oO7XnjzeKtSVTEgDapRmL9gbLdKDZKg=;
        b=AbParNXkxhXotPSCDV40Z7s8dTDEOlxRgRgB4x8QLXnNkSxLqgeYdKFvJbrRx5kIxX
         3AKKlAXYD3mljFsW+Gb5UeM6wIf7Cr+MX/YLpwm/an/p/aemXwUku3udmxa10vcuQnAV
         n6dQdZSMuaXQoz6wB38110FGBkOeyDp0IgrNwESciWT2ncr8Lpcg+0x5f+DzMA/FN5cq
         2MGEcU0XMSY0NqSZHNZ8YNgKBo6K85I8n099ZITc5nLPSqdV53jYm9TmJZj7j39ck3k4
         MKjx7iSz/tkLSKR9wpnvu1yejbf0v8+QR87EibHaxqbivjeauLdKzQtIhXf1/5y9uvfV
         PgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142321; x=1770747121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VX7w+kwRBRr6oO7XnjzeKtSVTEgDapRmL9gbLdKDZKg=;
        b=GRdTbGAhoVUGjw91MmsGTI52ASLxHPMmug2EQjNZ6ggUgYsvMmWeEtxZiw53BJXP24
         xuuMLvXLN/u0qhBuKkIK4NnEEhMKsOLJ2E6hTfIN84UmtnDPgYndXP0tvFjiRNWdp2yf
         nHBkJ/vvdujIQy4ryrtRUmPdMcF0kOzxH/AdpjenYsjhouRDOHnnU+KV4G5XRb5TPPYY
         ZnK/tbAwuVc19/DERUkORQGv7CqKX1KOoNing2IzDqafSd9eaQGtonG+nwYMTnrDMBCu
         IiS8mO2kZbpCzJINAwPqquINFtkpntOSQtEjdzdN1yLm5yaFFgmeXihdMaXJZtuYtB0K
         CWyA==
X-Forwarded-Encrypted: i=1; AJvYcCWtH7QrqTFxdQ8NmxGYGgTwRpkE7ljqiG/9NlOYzQsZjs8fqwAX2yk7UbRPIewh2gTrWKfu97AUWaqfRY1dDfgH2FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFlv+9l3bBDMgNruAIw5itxZBxzwPoQReKxwufoXMNH6ChfCK
	cu07/X50XvnZKCo6HwQy5UMNh+zHDyanQsoB7XuAO4iFe/KqpCZyTyoPnkIp3r6GfZ6RfyHaaIl
	0sZ7eKzVdC8cTxIWTISpSso2mzsCnlh4=
X-Gm-Gg: AZuq6aIbjJrJPTmUkMdoV1K6IffOsPtKAXIxxpeLIXJDKPx5P19HHt3LKZxJwyazPDM
	g1UhduiPzIEK95GV3jiJiK8mz/QyLcaZKBAOo+y4OjoOB/9raw+p6wK+MmUeRjO87VWu0J4Cora
	66pbX0OrwMD/sPtHYv983A+8Hk5cdgfFMyrNr5uFLfhyCk+2BfKCC9LIbs5x49CMAjCwmf4IT56
	tw+X0HSRdvsOYzrbgcWBFT9riHb+5UL+ZlXy33J7bnywrNoVDco08hkjLLU8eqJWA9CcYhL5bGK
	77hQvS2oXsemfoj3nONyR2HkmQYDw6+oJZyW0/8ZQJMZXiLi/TYnCpz6sdffeREcDfVODw==
X-Received: by 2002:a5d:64e6:0:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-43618053b98mr288083f8f.34.1770142320658; Tue, 03 Feb 2026
 10:12:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org> <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com> <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
 <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com>
In-Reply-To: <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 10:11:49 -0800
X-Gm-Features: AZwV_QgEx7To_odlcruGOiZCh_TUFGZ-bIKhZLPkiLhLR8oP1ufpcANIO_qNt0Q
Message-ID: <CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 9:44=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 18:24, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 8:58=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Tue, Feb 3, 2026, at 17:34, Alexei Starovoitov wrote:
> >> > On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
> >> >>
> >> >> From: Arnd Bergmann <arnd@arndb.de>
> >> >>
> >> >> Some internal functions in bpf produce a warning when -Wsuggest-att=
ribute=3Dformat
> >> >> is passed to the compiler, e.g. in 'make W=3D1':
> >> >>
> >> >> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
> >> >> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_prin=
tk' might be a candidate for 'gnu_printf' format attribute [-Werror=3Dsugge=
st-attribute=3Dformat]
> >> >>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt,=
 data.bin_args);
> >> >>       |         ^~~
> >> >>
> >> >> The attribute here is useless since there are no callers from C cod=
e,
> >> >> but it helps to shut up the output anyway so we can eventually turn
> >> >> the warning option on by default.
> >> >>
> >> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > This was discussed and it's incorrect.
> >>
> >> Do you have a reference to why it's incorrect?  It seems harmless
> >> and gives me a clean kernel build in combination with a handful
> >> of other fixes after enabling the option by default, but I assume
> >> I'm missing something,
> >
> > because it's not a printf format. There are no varags here.
> > gnu_printf attribute takes two arguments:
> > format (archetype, string-index, first-to-check)
> > Also
> > "GCC requires a function with the 'format' attribute to be variadic"
>
> My impression was that at least vbin_printf() falls into the
> same category as vprintf(), which is explictly mentioned in the
> gcc documentation:
>
>   For functions where the arguments are not available to be checked
>   (such as 'vprintf'), specify the third parameter as zero.

Not quite. That comment in gcc doc is somewhat misleading.
zero means that it should be va_list.

Examples of correct annotations:

static __attribute__((unused, format(printf, 2, 0)))
int vfprintf(FILE *stream, const char *fmt, va_list args)


static __attribute__((unused, format(printf, 2, 3)))
int fprintf(FILE *stream, const char *fmt, ...)

A comment in gcc sources:
      /* Functions taking a va_list normally pass a non-literal format
         string.  These functions typically are declared with
         first_arg_num =3D=3D 0, ...

Currently gcc doesn't go deep into va_list to validate them,
since they're likely not compile time constants,
but that's the meaning of zero.

> I also see the comment about bstr_printf() mention that it
> uses a vsnprintf() compatible format, which would indicate that
> marking the format argument isn't wrong, though I agree it is
> not actually useful if there are no callers that pass a string
> literal.

In general I don't think it's a good idea to add nop annotations
just to shut up over eager compiler warning.
