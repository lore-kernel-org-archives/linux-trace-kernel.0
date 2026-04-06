Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469939B950
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506348; cv=pass; b=Izjy9Y9V2AP6aVIgOCbk+pXA9pAUlsfhMBMnrBlMD0q5vJy/zpYmG+bLJokalOgQaInC4cjROjpCtFfYRNglytVYbFi9OkTOLz7emSLGHMMeKuzLhM0hI1P8aBpVDZKWhTas0lzp+sDXVo10Du4550ULZcAnR6K8PLYraVHU+Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506348; c=relaxed/simple;
	bh=s6aJdA58IGADa1+v1zsb7cJg0N/wgNuxNFFyBe9eVf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHQt34uV/X1XmKaOjKMEHEyiB0iiZT+tqS9C8n9D3ygQqUtqIf7NqAlSchb/cHt0eOMrEuXSFTEVfIwbah588TIMfMrOHg1cN6ocvIFtmQXBFYRjtMk+aq+TBK+yuBi9HRdp1rLPWAOqFgTSQqUsZlRxMofg+BPB2mu8AFk6IS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3Er1+Fo; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3Er1+Fo"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488ad135063so12427135e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 13:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775506345; cv=none;
        d=google.com; s=arc-20240605;
        b=l0Ecz8iljphQxPsruXZCbfwNh9sVUa8mMsKmlMbRC7m4J4ZPAqWjuz6mIiWw7kZ9F5
         QLoip8iPFWGkhXcV9IBbLfFXuwJEPYGeInz1ceegWv4p/O6oO8mzklYwc7Jdf9GCLhz3
         u5qRlwwoycESn8uTNJrhkTpf2+O6e1Tk2P49/reyYcqAsZTrpfWTW+02EeGfgafi8a+n
         kEfsLfKk/OcWNkHM9R9lGGNL7TxMe3u5day5aFXhU17qt0GgskzIw9rKphrkLZtHEtxs
         8DadGIgqg3r4g0WNogenI7Amh2VVLu0ZfT8DkNXz3M3TNTENaLPleTEZiWUA/tvMwmGQ
         rhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ECHSIeYJG/ss0cpgInnFbjh0Pdm7oo3N61eH/qs+HT4=;
        fh=SVwArIvnRNXyaiQzFnqcfMco1TWIuKrtZb5pd7KYqVk=;
        b=WijctY9l5dgVBGOhnZW4XJXtY8azqTLMllH1R6taZE4EIKUGBbtlxZG8IBU+7qdPE7
         W3YvxRxaF4KQAUgKpeVXObquvn+grU7z/wExI3qCjdnJk1y+pPFdq4aSLKB9mgz5BfAW
         r/q8tAWqzMPxOYjI8JMSYCjUDK/Nr14BO125E7vG3TFp8Cj5dBYDJDZRytVzVdh/BqPN
         g4LKriiXVngOAEFy86uXZD9PiezsStfyAzUvjc6FDhnF3tze5Ha+o63q+BFJEiq26Klw
         pw5ctcp8aYjEmfsDhYOfdkI6LBegHY1Ra36Y8+aVZktq7EGDuetVlmoiEk7M/KgMJejQ
         0ZBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506345; x=1776111145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECHSIeYJG/ss0cpgInnFbjh0Pdm7oo3N61eH/qs+HT4=;
        b=Q3Er1+Foj2JI++IytQF+1vu2hw0uEAYNR6gyM1YtgJ+qMUcsBRPCtUDmEc9HCS9Bnw
         lzIzjVUxyyIKn2Zv4bpXyXCJ55gCE2mFg00JvxisKQ1H3JJNS57YKA9L3HVgrK7SvioU
         tjVaS8jX73mVBQu64uFhWaatYGVRXXFfNs+famwofGp3ZVq4CnjZdl9o7LHwIRM7U97N
         d6axOoFkiwe+77RaL424r4vv7m3xadw5EBSiHPq9q1A9aMh5yRgTnGPs9rDlwY3v+qTu
         1pjqHdQ7eOVSYp27GTV7Ei47m+Jc6oVe4Tru6VW6LhUJcrk7FMtdonevgEscoJRi36J5
         5ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506345; x=1776111145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECHSIeYJG/ss0cpgInnFbjh0Pdm7oo3N61eH/qs+HT4=;
        b=ExmSfR07JfbL/mF3eB0ELwECSfoyWrMh0wofl2OomXmNaFyi2duIJHVuVVZ3z1+fhs
         8DV6BRFlxcObgqFYj8PiiTZ2QIwkwOMPVr00KbK8O4oejPF1+qnRZP6avqTIZsktmY6S
         RLLt5JO7YBCEmyjLLlU+myza+hv28pu4rCGxZLofD0Tgwgylar6N5E27zJp6/s8PxTbN
         yv5T30dB0EEfnL3w3CRARXlIB3XFySljH0tX/P6zVcREiVx8QdnAS90MG8sF/Pib76fY
         sqdQDAOeCy3m+sYZ6cqvT6o4hzFkLApThaqleYOn4kfnBXCgT8UaAG2S6pTb9qIkdztq
         J42g==
X-Forwarded-Encrypted: i=1; AJvYcCWF+lEjHL4AGCtiYl/5+2MulKWtsnxKzVHJuKzOLcP4+EmXpbBZBVkRSEb9QtSp1Z7TlsFG9n8Bnk++AUqyu+FFeys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUkDZPWppn8mBFqQyhXWf/dx/lpSmn3nSRV195i1BJ40VNztL
	+EASy5i13O0zk8R42DzFd+rrJpAErZzMFSngbvVCtqmkt0auwat7/D6l0P53z00OJZjzLbidgWh
	OZjzf797SXMSwO2gyhbh6nmyicwwQeuA=
X-Gm-Gg: AeBDievd/HDUqIMm2U6AkoKffKRzIqLfUxoh5SPafl+Zzu9ftCo1EMnUA/v1O9m9Xlj
	97E/XDXh0mxLEcsPGCbgLtH/D1cCaUzTIFKnK+9HT6QjQHx2uowHs69UpqbwKhhq/Hyn/JDANcz
	4crc8hf2XSWkah1VUUZ5NiQYHl3iknBs+jncXbnIJdVlMEBcKOXXq7mxaBJgkGxqo5CxmZwLnm8
	9FpDh1JwwKGWXTTi2Fq5mOxBu0KNY7/AYFipwGOZpMi1Dlt+Jl0RC/eagRvtnu2ZjVK2560W3eO
	ag5+gJJ2HnI83/mffwVlKYeG2PSC3RsB54oe7P2DNWrh0y+CzeCGCTq4/fTE/unxD49ljmV8
X-Received: by 2002:a5d:5d0f:0:b0:43c:fd92:f432 with SMTP id
 ffacd0b85a97d-43d2926a133mr20381542f8f.2.1775506344767; Mon, 06 Apr 2026
 13:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191126.440683-1-varunrmallya@gmail.com>
 <20260401191126.440683-2-varunrmallya@gmail.com> <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>
 <ac47BIEUBBkTch31@krava>
In-Reply-To: <ac47BIEUBBkTch31@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 6 Apr 2026 22:11:48 +0200
X-Gm-Features: AQROBzAzS2x1pnm8GQsphNrgAlMcDdJKIJ2GsYVUVKDUIlO7GIewSXGeCtDX7ec
Message-ID: <CAP01T75W-idA_7y6HYaaUW17oQ=o08+2gM5dnLBdH+2D0aRdBw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi
 is not sleepable
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Varun R Mallya <varunrmallya@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 11:46, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Apr 02, 2026 at 12:50:10AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
> > >
> > > Add a selftest to ensure that kprobe_multi programs cannot be attached
> > > using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> > > rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
> > >
> > > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > > ---
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
> > >  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
> > >  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
> > >  2 files changed, 54 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > index 78c974d4ea33..f02fec2b6fda 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > @@ -10,6 +10,7 @@
> > >  #include "kprobe_multi_session_cookie.skel.h"
> > >  #include "kprobe_multi_verifier.skel.h"
> > >  #include "kprobe_write_ctx.skel.h"
> > > +#include "kprobe_multi_sleepable.skel.h"
> > >  #include "bpf/libbpf_internal.h"
> > >  #include "bpf/hashmap.h"
> > >
> > > @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
> > >  }
> > >  #endif
> > >
> > > +static void test_attach_multi_sleepable(void)
> > > +{
> > > +       struct kprobe_multi_sleepable *skel;
> > > +       int err;
> > > +
> > > +       skel = kprobe_multi_sleepable__open();
> > > +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> > > +               return;
> > > +
> > > +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> > > +                                    BPF_F_SLEEPABLE);
> > > +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> > > +               goto cleanup;
> > > +
> > > +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> > > +       err = kprobe_multi_sleepable__load(skel);
> > > +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> > > +               goto cleanup;
> > > +
> > > +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> > > +        * Also chosen a stable symbol to send into opts
> > > +        */
> > > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > > +       const char *sym = "vfs_read";
> > > +
> > > +       opts.syms = &sym;
> > > +       opts.cnt = 1;
> > > +
> > > +       skel->links.handle_kprobe_multi_sleepable =
> > > +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> > > +                                                     NULL, &opts);
> > > +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> > > +                      "bpf_program__attach_kprobe_multi_opts");
> >
> > Nit: While vfs_read will likely remain stable, the check could
> > probably be stronger to distinguish an attach error from -EINVAL?
> > I added a typo to vfs_read and it still passed, because it failed to
> > attach instead of getting rejected on unfixed kernel.
> > May not be a big deal since vfs_read is unlikely to break.
> > I verified it works by adding bpf_copy_from_user to the program and
> > attaching to SYS_PREFIX sys_getpid and invoking the splat though, so
> > LGTM otherwise.
>
> why not use bpf_fentry_test2 ? you could also put it in pattern argument
> and bypass opts completely (up to you)
>
> also there's test_attach_api_fails test, please move it over there
>

Varun, the selftest is still not applied, only the fix. Please follow
up and target bpf-next tree this time.
Thanks.
