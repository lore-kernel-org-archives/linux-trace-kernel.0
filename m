Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BA19D062
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560595; cv=none; b=Z4t+Ymn+apdPUvjTCIQOzzO3ZOQDig/WBWQF+7pas2U99easMYZcPplEI2vZMdCe82mykHCf2qd+KcA/9AxsOcY4UxLcQWomgFxpO0SdJOt7u015lmeXCjphON5D+Gi+JVEu6+xp5s/hHVeMNB6Ln0lKXtYdZ9N56JVtQUrw3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560595; c=relaxed/simple;
	bh=+Le9C120Tk219uYuvFcT1GluAfSF7BzOjYHEuRFLqvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clshhnreXt/lEqNg9ampHYfbCNwq2UhMNIuCQQsy5HYrK+H3r7Tg3DSiFHwi6p0Y0YFU3q8nKPIqXRwcQuMINNb7dlpwd6oZPPE6YthdL3P/iZ6IpE+XnVDL3LB0b4cEfJZbYXjx6DZSavMlFp5OeCIbWjIHqzo3rZ9hb4PeBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8pd0/50; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8pd0/50"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-690404fd27eso52931077b3.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723560592; x=1724165392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMAmvfMfLGxG04VOncSiEgH42uCMXnhNVQeyFe+gN58=;
        b=e8pd0/5091BKRhrN5oVtz3hBOgy9Hrz3wb5qS5pd3a+biTxTZuNKAhLzdAxjaYCEUw
         EJskcsZZSxjCptTM//8OqXYAaA9hTecIwCeRucfAjgj2lmXL0bB+ooSBJLSE/nmlo0lo
         7EIlJ0J+1vwt5JdYXMs4LHgTIfa2KKEYbUJ6pXWgmjmGOSylhYmqNmXSHcjQ2Zp8ZT/R
         95/w4W7okPvAG/CrRzU5qbZ01infs+2cVW+gn2aRIyHpdpNSUvATgimrysMkFKsdmLim
         wnbrjoY1ODgWnlyVvLb14h4S1HknDwoO+N2pR32hOJIaR53nzzznlO86MDoVFKb5yj0q
         bbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560592; x=1724165392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMAmvfMfLGxG04VOncSiEgH42uCMXnhNVQeyFe+gN58=;
        b=ZaKQ+8X/aPTxlSt31aYHpt+5rdg3PqThKcUxc8KztoQ8pBqMOeh/W9o/S0Wi/2XJyP
         LBrvvr5jOvYqpgxmahVLUAAfyxXqhKnMUaJ166Vz48uKGrsoanMsZbYql35MEeRNdBjf
         shF8COoLkuFLlgz8KyiUyYUEh3BJulwyMzjN0KBJGNtoeHkYrDrj4/JGIT21OsC+S9RF
         /IJekTMo2MVocB1Pnl2a9YPpZBha2HBarZv1B3ZrjsiBfRZwkaxZj9zJ26stkcnNM8qZ
         qw2tbaRn7wX695abs4khWw/CVi54T9RuJW5pi06rKhXw8iK/p7GsTgmYfy9XMaHx3nL7
         zC2g==
X-Forwarded-Encrypted: i=1; AJvYcCXoB3rZI8xmTtTcVw6RstSd8uQljmrFc7Bs+QnAZdsTl2eZMIu/1J5i6aSDg7g7fy7fxa7mXhFsBwTJIRXYA5HRZ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQO0IIBlGY+OzfUlE0aSyaepEfpFctkOMieSuDof6HjP/kAjrY
	RJlOLFplgy/Za90F2uHJYh0qpZfPaeXOSPs4q2NAmfFGFpnqKERkP+CVKxnEs2GfpJP5yZcTEnW
	tEON9u9KfyaeXb5wFl6Qo6WtNadwEes73eNUt
X-Google-Smtp-Source: AGHT+IGmEzAwIAwEGRhqLpZdPYAARLGHX4pBz6ekvJpqu2lSPX/60rvAtPYhRmXeAktfNJ1DwLGeQLbuisy90b+WpIM=
X-Received: by 2002:a05:690c:60c5:b0:62c:e6c0:e887 with SMTP id
 00721157ae682-6a97151cc29mr57357187b3.9.1723560592146; Tue, 13 Aug 2024
 07:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-13-andrii@kernel.org>
 <jdsuyu4ny4bzpzncyhuc54vqmnxb6wsshvnvd6eat4cknoxvqd@g4mrvwiokb2d>
In-Reply-To: <jdsuyu4ny4bzpzncyhuc54vqmnxb6wsshvnvd6eat4cknoxvqd@g4mrvwiokb2d>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Aug 2024 07:49:39 -0700
Message-ID: <CAJuCfpFrP-UpMih2j=Nxx=QSQm2k3QtJScLKniM9aXjbo5jCDw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 12/13] mm: add SLAB_TYPESAFE_BY_RCU to files_cache
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:07=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Mon, Aug 12, 2024 at 09:29:16PM -0700, Andrii Nakryiko wrote:
> > Add RCU protection for file struct's backing memory by adding
> > SLAB_TYPESAFE_BY_RCU flag to files_cachep. This will allow to locklessl=
y
> > access struct file's fields under RCU lock protection without having to
> > take much more expensive and contended locks.
> >
> > This is going to be used for lockless uprobe look up in the next patch.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/fork.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 76ebafb956a6..91ecc32a491c 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -3157,8 +3157,8 @@ void __init proc_caches_init(void)
> >                       NULL);
> >       files_cachep =3D kmem_cache_create("files_cache",
> >                       sizeof(struct files_struct), 0,
> > -                     SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> > -                     NULL);
> > +                     SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RC=
U|
> > +                     SLAB_ACCOUNT, NULL);
> >       fs_cachep =3D kmem_cache_create("fs_cache",
> >                       sizeof(struct fs_struct), 0,
> >                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>
> Did you mean to add it to the cache backing 'struct file' allocations?
>
> That cache is created in fs/file_table.c and already has the flag:
>         filp_cachep =3D kmem_cache_create("filp", sizeof(struct file), 0,
>                                 SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN=
 |
>                                 SLAB_PANIC | SLAB_ACCOUNT, NULL);

Oh, I completely missed the SLAB_TYPESAFE_BY_RCU for this cache, and
here I was telling Andrii that it's RCU unsafe to access
vma->vm_file... Mea culpa.

>
> The cache you are modifying in this patch contains the fd array et al
> and is of no consequence to "uprobes: add speculative lockless VMA to
> inode resolution".
>
> iow this patch needs to be dropped

I believe you are correct.
