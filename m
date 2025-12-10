Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A672D3A94
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Dec 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350575; cv=none; b=g8FulY9+FtZspmk6w8PHJZjhZGkgi2dXGfQhOAvo6OkIOVEnI1rP0lndyIQ8Q8/DYAW+bSO0ykDlRHKGVgwYqOA2RzOnAB2vWj0WaHpyW2kCiuVgVRqTS3ezws81pzLFxcsVH1U1bx5aMyQDBCzyFOdmI8FV7l6njC2GMT85G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350575; c=relaxed/simple;
	bh=26nolpmNblwBmBuzKzPK0yRZPS0nM9skp+7aC9R4q08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzqkYsF7Ze5fBkf3NFUeWD6Qw1Hi013JwdRyPZoKu+jITVnsi1st3NhKS4n7Pv1aLCLiW3dGv7VKcX4Q2R/iSbxA6smHIy9SwtPXKlQe50G1NaX6QKTrRPGS9eghyvkIigED+GERjhEYwPyt95imjnY9RfD+i/tOMDJU/dL598I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/HfJ3cQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/HfJ3cQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e2eccd2so4169361f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 23:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765350571; x=1765955371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EU0VUVqRUtS7aPeBl9evWsKNjXkOCCMm8DbmHiqXpg=;
        b=S/HfJ3cQFto1RAgo+rrACcfN9dwfuFwnAAu+mZhRx8FwpLZRQ/+3c56zpp1fjV+L2+
         CJ2xqr7XMSPB2tFCQ8/sWENL4ildDVkfL1oovPP42uiSOgcH1FbWqbzXzSFjTzZZ2NDa
         SJfoVHTjywYIiqFgfN8m2AwKVDi7cgBYtCjQxp3zHxeu0ECkbUY9bD+r6i/DZTdh63Q0
         2Tf61ibMbg0bKGclUQqdHMO+xO5bLgIypvh90u1Rwd8NTxhVRzapKCFg2aJLNcCrTkLQ
         21uHT/kSG5pNDKvqg4VbVYCOgPWlCYdketP2OntYLTtDuHTDtRBspwc3PMlKP2oCyV2T
         s7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765350571; x=1765955371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EU0VUVqRUtS7aPeBl9evWsKNjXkOCCMm8DbmHiqXpg=;
        b=ICHNU0doBiXiRTntBw5qknDaM7ciG5re4x9eik2s+qg5QnTjcI+npBhDORpnfCO9kz
         WpAJbmPSYBgH656E6E/dzkLsRIELeomycYMFPig9yCHHFFB+fZSWC9lBUmggeFbsKXSs
         gtS4tBHi98b+8Cu0J1qDU6ZH0nGBkBkAVEqfj+KJXe0sPYvIxHjM/ZVjsq7DU3eVqRqx
         R2RZEbCYY/qROYZkiC18xHh+VSLoOJRLl1bxrNbUwfUs6uvP6PXCwAukOhgkvvbn9URD
         R35I/X25xZNC1LZa1CCK9t99jJMhDBPsFdLR5o7XjRqveV9CwDR05kA03BobIVU+kk1r
         lbhg==
X-Forwarded-Encrypted: i=1; AJvYcCUN9b+NqfkyV/IoFsRVC1Ijslselg/s6Pv6SQ720PKvHe657PMdxsqOJv5F2NQbeCsknW09cFCI/PnyROlMAXGpVzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxkf17eLpTkk2JEcDo8OP6Tp+AMTXqyq2ihSMiXi1pfr5gS1Zw
	XyNL9rp1I0tGJDX32FiSHS/UEToWsGHCmZS3C+N16ip/J7ih8zWzBMMwhMBrMGmz+0g7DYDPxO9
	NUXrFgPkzTLNwMfsZ1zcKhc2+ESGBNlI=
X-Gm-Gg: AY/fxX7ZkxEIM7NYmdtQOd+1oF44jMvujtDGrX3YWQWNkj5fMxKtAj99W1qWR6QLHxn
	2ujC3mXdp1yhVwJxCrQeynohDlRuJoJTEtwDWHevCXg3swo7aM5gCSU1w69wZsx4y6qDsda+c5Z
	LaTduk7BWuuuopfLqvtUI6ncS0EEKGuW6dxGDnfYRAqWXGFXVT7A/2OAiKb0BM4GD3QJGf2zHsV
	U953PGsL1dqOGWfiTERdrQtzHrFwCE9AdOz5kO50L2aPscWfG5VuI8YBFGL+3KnfCMizORQ
X-Google-Smtp-Source: AGHT+IEUWuCBd+VxvtSqBsdHlpGUtEOyUH5Vet9IDXTK4PfHO9H/osN5TOD7YP2bhiK0aFE0r7edKlgEeScX0rmLktg=
X-Received: by 2002:a05:6000:3108:b0:42b:43b4:2870 with SMTP id
 ffacd0b85a97d-42fa39d4d3bmr1377860f8f.26.1765350571083; Tue, 09 Dec 2025
 23:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
 <CAADnVQ+SXe-CsPHnYkB4SOKct6iMN=PkexaKRd-MJFhC3i8M0A@mail.gmail.com> <aTgl_bjO1O9Ddpmv@smile.fi.intel.com>
In-Reply-To: <aTgl_bjO1O9Ddpmv@smile.fi.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Dec 2025 16:09:19 +0900
X-Gm-Features: AQt7F2ogOQ169Rf8brIHTTEO9I_yuqVyNgBKCB2apVGPY610GEpbdkn_RiqZMwM
Message-ID: <CAADnVQLkSoOL8+kELdmX5nzNcXm-s4VbA5+Q-MPcNySsSiu+RQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Mark BPF printing functions with __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alan Maguire <alan.maguire@oracle.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Dec 09, 2025 at 06:12:46PM +0900, Alexei Starovoitov wrote:
> > On Tue, Dec 9, 2025 at 1:21=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The printing functions in BPF code are using printf() type of format,
> > > and compiler is not happy about them as is:
> > >
> > > kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snprint=
f=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format att=
ribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_args=
);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_trac=
e_printk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 for=
mat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_trac=
e_vprintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 fo=
rmat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
> > >       |         ^~~
> > >
> > > kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_seq_=
printf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 forma=
t attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > >   475 |         seq_bprintf(m, fmt, data.bin_args);
> > >       |         ^~~~~~~~~~~
> > >
> > > Fix the compilation errors by adding __printf() attribute. For that
> > > we need to pass it down to the BPF_CALL_x() and wrap into PRINTF_BPF_=
CALL_*()
> > > to make code neater.
>
> > This is pointless churn to shut up a warning.
>
> In some cases, like mine, it's an error.
>
> > Teach syzbot to stop this spam instead.
>
> It prevents to perform `make W=3D1` builds with the default CONFIG_WERROR=
,
> which is 'y'.
>
> > At the end this patch doesn't make any visible difference,
> > since user declarations of these helpers are auto generated
> > from uapi/bpf.h file and __printf attribute is not there.
>
> I see, thanks for the review.
> Any recommendations on how to fix this properly?

Add -Wno-suggest-attribute=3Dformat
to corresponding files in Makefile.

I think it's cleaner than __diag_ignore() in the .c
