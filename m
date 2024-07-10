Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B3194099;
	Wed, 10 Jul 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634647; cv=none; b=JyxLmUZB8O1ZTLSu4aNXW7uxdc7LSoccuqaCivbO7qNA5r/ptFEU3tFRfIrAWPYr31JjSRrJDxxZDaqUziGeqalIWOZQbjFVwfmUDKl3OAYARiqQuyFdZiJkCSlzZ4bhvpH1r9Xv7BsleQ8DUM2T00qFME7QGLKamJbfiGeF8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634647; c=relaxed/simple;
	bh=03kxh5pdd60/OEQNjoXPbqHOMmMMfsErItVT3Snd2X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bp+uNy2S3L6aG8NuSVl+QyJ3XxLRU9Keih+9XOVYCma05muJbXkFl3UKQX8iwSix23Ju9mBfDQtkKdZs0k39VbDHIumfV7ICKoV+L1u/ai7sV4uAEVIThwOEKO3RP6qQ/2vWRd+Vxl2Fvh/ZkVIx0oE7FKkH9EI0yvmffk2qmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht5AEvMe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht5AEvMe"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso81885b3a.1;
        Wed, 10 Jul 2024 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720634645; x=1721239445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mf0qpFnrgMm7ZyO6IPiv9h5/mvXdyNwfvX9vXzksXE=;
        b=Ht5AEvMedCneS1j4SkdYo8P040s7PkVrqrdgkdLeIqdLNL2X56B8qQ6o2S6xm+fTej
         3EADYeZXyTCHa2OX1iSCA/xRmFYfP87z9UlKUYGHIO8vZuu5hQH1vTFulNPHtXWMO1VH
         5OSQKNg9X06/vW0sgfAwwrBdToy39Og8j8pbSCXNDqM9TF0VTrRnEvtOuZeS54LfyUQP
         tRkKzKBssdA4B5tpAIFfnsR30etyq4TwUqL+iQxCwI5pso8y/70fQxkbPS4DQ3d5Lf2/
         fKNLhtiVPYMONUok0c/vYUYMLZpGx+7f8wMQEsYyCnWqxTScnNnJ1yM1g0EWeTX0Bp0D
         XN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634645; x=1721239445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Mf0qpFnrgMm7ZyO6IPiv9h5/mvXdyNwfvX9vXzksXE=;
        b=usa4Y+nq+VbyhaU8jZ6wWKV0u6o23fEqlfelyOTXE9sdOhXN0PMSYIjOj8xd1+MmRG
         QDGbhu9q6dktICQaJSsrQa/Vecf7L1GNHYLRRWmFE3ucBoLTHVzh7563jBAUHI+EpJvt
         jHfaBJEJzVftWTEdVP8WGzDdVHiKHvZn/HVknzE8u6Pdu3/BDeMm3oyTW7o1g8yWeUqm
         RYZw3OUH4zlZvWkZ7CiYvkjFHH8GQLZs5SE9lzPN0L/iITlSEp5ytzWNYF873qLyJ6CV
         AaY/2f36EU7SNifjhNC2/rLJsYizGTmbHf211fcMt601slR/WrPLTcbw6z9Eo431B5CK
         IikA==
X-Forwarded-Encrypted: i=1; AJvYcCV6AXjbZJkgiDDJDkZ4V743j0XX6rjmYg+Ip2p7DEOsNeH7LfJc4G8Y1vf+sfw0kRc7/69+fYRS/Rm4JD1SFX/F4B9vhbbYltcJ2N4CKYU88eExuYngPIW8Xf+7npVgma+EVytP7qtI7TVrqXPvFEoA
X-Gm-Message-State: AOJu0YwG9c5E+HSuOJVWGvgQFOlenrHFE76sEpQNuNQQQr7N6kDLTLWZ
	e7bbk3DZQ8kJ1Bzvgx1loZvUJDQWG13gZgnYwV6/KS0+2XJsi0LZ42G5MYim/t4hzW8Oqv+R17R
	PHp9K3CZBhsKtbeCjvTgtHG0Rx6w=
X-Google-Smtp-Source: AGHT+IGKJkC1mkn/dxcVBP1W/9U2WGlsIEcdENR8wOLqnWRuUG5gT4XLsXVVz/NFk9EzBy6diqy3D+5uCT6D1snWnQU=
X-Received: by 2002:a05:6a20:244e:b0:1c2:89a3:4e19 with SMTP id
 adf61e73a8af0-1c29824370cmr6896548637.27.1720634645531; Wed, 10 Jul 2024
 11:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710163022.GA13298@redhat.com>
 <20240710163047.GB13298@redhat.com>
In-Reply-To: <20240710163047.GB13298@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 11:03:53 -0700
Message-ID: <CAEf4BzZScUsh94P67-1rKOj=26ycj87nmT0fBrP9BvvmxAi8kQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: kill uprobe_register_refctr()
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, clm@meta.com, 
	jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:32=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> It doesn't make any sense to have 2 versions of _register(). Note that
> trace_uprobe_enable(), the only user of uprobe_register(), doesn't need
> to check tu->ref_ctr_offset to decide which one should be used, it could
> safely pass ref_ctr_offset =3D=3D 0 to uprobe_register_refctr().
>
> Add this argument to uprobe_register(), update the callers, and kill
> uprobe_register_refctr().
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/uprobes.h     |  9 ++-------
>  kernel/events/uprobes.c     | 23 +++++------------------
>  kernel/trace/bpf_trace.c    |  2 +-
>  kernel/trace/trace_uprobe.c |  8 ++------
>  4 files changed, 10 insertions(+), 32 deletions(-)
>

LGTM with few nits below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  /*
>   * uprobe_apply - unregister an already registered probe.
>   * @inode: the file in which the probe has to be removed.
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d1daeab1bbc1..467f358c8ce7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3477,7 +3477,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>                       &bpf_uprobe_multi_link_lops, prog);
>
>         for (i =3D 0; i < cnt; i++) {
> -               err =3D uprobe_register_refctr(d_real_inode(link->path.de=
ntry),
> +               err =3D uprobe_register(d_real_inode(link->path.dentry),
>                                              uprobes[i].offset,
>                                              uprobes[i].ref_ctr_offset,
>                                              &uprobes[i].consumer);

please adjust indentation here

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..78a5c40e885a 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1089,12 +1089,8 @@ static int trace_uprobe_enable(struct trace_uprobe=
 *tu, filter_func_t filter)
>         tu->consumer.filter =3D filter;
>         tu->inode =3D d_real_inode(tu->path.dentry);
>
> -       if (tu->ref_ctr_offset)
> -               ret =3D uprobe_register_refctr(tu->inode, tu->offset,
> -                               tu->ref_ctr_offset, &tu->consumer);
> -       else
> -               ret =3D uprobe_register(tu->inode, tu->offset, &tu->consu=
mer);
> -
> +       ret =3D uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset=
,
> +                             &tu->consumer);

doesn't fit under 100 characters? If it does, please keep as a single line.

>         if (ret)
>                 tu->inode =3D NULL;
>
> --
> 2.25.1.362.g51ebf55
>
>
