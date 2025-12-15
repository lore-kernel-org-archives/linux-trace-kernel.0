Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E18223323
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822410; cv=none; b=oG+7nZhL42bRnJxYDXFtHmIEtMVsARO1dUTWA2/yOZzr4n9qfzxb3op98LfK+rAUs2r3bj0yoY8s9H6adUr4Aj1WVDqG8OlsYuTHUu2JYYEWp+cC4xR0DyUSls6HhNwjQidilepaDEeMKtQFmgTHVnvo29AFL1otnu5zYxj0LZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822410; c=relaxed/simple;
	bh=s7+OFwV3jbHKovFymU0KuG763zUVR3PfMxfBrCeMLQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjUrc1OH7S4UVNFfm0RWtb4EV/1lMnqFAmOQ26Jg6VMZdRIJ1UPNFbhdr7WHp1peH+rv5Ff8pIBoYdtjF0OUxruwZFDd5w0XfduhMohXB1LS5q3KMXhuHlC2oohRXmWG9ECoab5VqjkE+/klgrqoLimmKSyENT0EI5VZ5wEV7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/dvwSh7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/dvwSh7"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so687318f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 10:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765822407; x=1766427207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NevN2ikDWBwPdWF+gS1xx7iDgLXGEtZldCi2ViNTTI=;
        b=Y/dvwSh7ZR1HlfTbnWIkNlbFZ195kNW3kQJ5GoEdbtu/eAQnhTzlSL97SwcQFamB5P
         RIIslD2baBEmajaDJoKD/VGTlVLnxrGDDJyWCGgQfse/9YPwgWdV2hS7IeYWt7hvmiwP
         Liczg6js6XyXvoBgc3rJhpmtpDT1DJxwsjWWHKbrrN0rFpCB0iU/VMeNbR22jfTfpeYj
         gJ4chATHcNuh9sfHHBZyNrM79X2KvJjEMMO6Z51YO6Lfn/axr12ErKvsKrES/OvI7ZJW
         ru4AyxM4WUYrozZG5tGuGA0XAreAEntYgZlPiv8OQadkf62Mfy8aNVRcyE7HBMzqkDWg
         uXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765822407; x=1766427207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1NevN2ikDWBwPdWF+gS1xx7iDgLXGEtZldCi2ViNTTI=;
        b=IPeLd68XHFAeO+P0S8F6bls8+X7jJ+0vAC0Tj0kyU/9Qfiws+CjU0t1X2sj7Eo5Z+z
         1yxZJBoImFcgLlgqBicDk69P6186OfICe6MZlLRwCxzibES1tfVlw8IaTOVh6N0XL62a
         s/eGpZoOOaiGefB9oLF6846jpUWltJhSYVhUkk5K7Uv31QFr50SsuNAnEbdnYIrUo+Ay
         Raa3R1s1NTRGrnMA32ywINVjPSM9N7KVV/7nG9lQ9OIeRRS/tbhUW+cguiOFerEJAdj5
         A5t4rZcwmhyk89xEL8bn/gXfqXpht2D0QMAX+q1BxTzdrCAiw0ZSEklmtOpE71+NPKoI
         a0UA==
X-Forwarded-Encrypted: i=1; AJvYcCW5bvBtBms1zZz9Ppe9ksnaNV4tendVlC9T+VlLs+AXveqBQ9npd8oWMZw2np6SzcGYXvDS4Ose7aQ9Fnv3+gw1jg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJGd+f/ufBCAL79KyqVAw76tKB8cSzhN7Rnu0LdE6HyGfX2ogv
	VGZrLa/VdgqDRRijZjxRwY/WtaEBsC+UwfqJ9uKQoXi3YSKY/x+wfQlaOSQdTr3PQIoBGBC06BW
	kpLb5Dm/p6o0a9oEV6EVPHMlsgz2wThM=
X-Gm-Gg: AY/fxX6IVvx5v4//Pmdj7zxLzUuYXGdOr1+iL1Me4J5IqowarwltgmhpW/FP7SFESFV
	Ki95y+hhUVIL1kqwdtCaW3q6QjqkYcRz1b7OMSVInLLnBQhCrXculCpAgGCXW0J0dT2v/B1bSaN
	TMdENmUj2OoIPezEG8dZNnwx4n+pXye966/rmnRjuEI+zcjPwnpxuW22tS0fkQ//p/1KPLZlvxe
	LCfywS237nmkMb2RDM2XnhWnJlcrbZ8wm5gk14VudjVMrOG9HZP7CKG6tdnWcW50RV/sO//5t0T
	i+2xHtKzrfjrc+3EiDMytDIHQBET
X-Google-Smtp-Source: AGHT+IHfwIi6E4efhdT5RfqN1IEbWSp/4m9g9MtSPEuDWRQmcteysKkOV+4DeKiQV+99hzzWBQfWabvyi7JOnvxCjpE=
X-Received: by 2002:a05:6000:208a:b0:42b:2db2:159f with SMTP id
 ffacd0b85a97d-42fab242bdamr18769184f8f.12.1765822406406; Mon, 15 Dec 2025
 10:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com> <CAEf4BzZQ_OJehh=5jJgVBUjJBNAkWh2o8Yd9UTa9nFrRO4oAFg@mail.gmail.com>
In-Reply-To: <CAEf4BzZQ_OJehh=5jJgVBUjJBNAkWh2o8Yd9UTa9nFrRO4oAFg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 10:13:14 -0800
X-Gm-Features: AQt7F2oHH343RkyFktO2Sm-awyC8AFnyTTF3-dpFmuKzwWaNAGRvdHJKxeJFbzk
Message-ID: <CAADnVQKtvRhbAVunHrwj_pCsmazddADRvRo5zp5O+k5kc-Eoog@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 9:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 10, 2025 at 5:12=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The printing functions in BPF code are using printf() type of format,
> > and compiler is not happy about them as is:
> >
> > kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snprintf=
=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attr=
ibute [-Werror=3Dsuggest-attribute=3Dformat]
> >  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_args);
> >       |         ^~~
> >
> > kernel/bpf/stream.c:241:9: error: function =E2=80=98bpf_stream_vprintk_=
impl=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format =
attribute [-Werror=3Dsuggest-attribute=3Dformat]
> >   241 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str=
, data.bin_args);
> >       |         ^~~
> >
> > kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_trace_=
printk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 forma=
t attribute [-Werror=3Dsuggest-attribute=3Dformat]
> >   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, dat=
a.bin_args);
> >       |         ^~~
> >
> > kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_trace_=
vprintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 form=
at attribute [-Werror=3Dsuggest-attribute=3Dformat]
> >   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, dat=
a.bin_args);
> >       |         ^~~
> >
> > kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_seq_pr=
intf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format =
attribute [-Werror=3Dsuggest-attribute=3Dformat]
> >   475 |         seq_bprintf(m, fmt, data.bin_args);
> >       |         ^~~~~~~~~~~
> >
>
> I just want to point out that the compiler suggestion is wrong here
> and these functions do not follow printf semantics. Yes, they have
> printf format string argument, but arguments themselves are passed
> using a special convention that the compiler won't know how to verify
> properly. So now, these are not candidates for gnu_printf, and it
> would be nice to have some way to shut up GCC for individual function
> instead of blanket -Wno-suggest-attribute for the entire file.
>
> Similarly, I see you marked bstr_printf() with __printf() earlier.
> That also seems wrong, so you might want to fix that mistake as well,
> while at it.
>
> Maybe the pragma push/pop approach would be a bit better and more
> explicit in the code?

I suggested using makefile and file level disable to avoid polluting
the code. Even when attr-print applies it doesn't help definitions.
The attribute is only useful in declaration and in our case it's not
going to be in vmlinux.h or in bpf_helpers.h
So having it right or wrong in .c is misleading.
