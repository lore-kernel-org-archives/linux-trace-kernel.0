Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD18357736
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056643; cv=none; b=OmjjgWtdpRs8XKwi3EPkTKdsEqRB2YiBjjxBgJ+rnkrHQj8eQHck+RQYL65PR/9bIVRxi3WfSiVZiOudgeJfEzBXoKUNuH0vZvrY+SSeSzPeGaK8zDl9hUwiLRP33n4FU3R1pyBd/qQkZMLsh8/szBA4bxuUsv0T8OTJ5CEw5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056643; c=relaxed/simple;
	bh=kvDK0kyHBLsRLqo/xqfgjRnH1mILL5tzYr3RBtYpY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPG9zZWnfD7ksFAqVg9GJ9Y61Cb6xtRKU8VxWGKucXpl7Jvt9xdj+ktLC6HkODCjce4Jd4dLJwY4kJa7dfwAHaa+N0amEWMkBLII6Ok+6qX9SQAJTLJcovncXonVfMOYZH7BpoHJVveqxi0asMkJmUqnkermrlkGTbrH8BaqAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqqB+O3a; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqqB+O3a"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so6728595e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056640; x=1763661440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI6SwLVxaeWge12jpv+g65IL6HLVUJJ6dHq74rzDBFI=;
        b=gqqB+O3as26Es4StwpMjNr7sXODvZxhjRDPhnWWK6BV8QBa600NpcoqYwpw+UtCN5W
         e8jNkZZPVeTriwboCCSG8z1qN4nc4qJWzUeSGoFp2AOtLJq825w0moZoqc0dSXogewr7
         k19CDwiDZ3BJP+mNW58NMVJ1iUBqJdq/GOspUIx+LHR37YCkZgK8H9Mwg2M7szLfIccd
         TiUqa8tYahcq0xl+8UCgE/UViZN9SA9nff5IaAJiQ+ie5KWU/wqVVfFCafn08Vj5B0Pe
         1arYXm9FWx/4FTS3V+Bg6/EJZ6p5aAQrr48Vdx+XztJf2Uopyb2/23laN6kkRgCHygyx
         cWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056640; x=1763661440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YI6SwLVxaeWge12jpv+g65IL6HLVUJJ6dHq74rzDBFI=;
        b=IebswCi5OzBUTt/tMkV2+aAsxXZ/DFF7MpB3bcmABcZX0NjqMyTZHV3tSm3zK/9jjV
         zOCJG0THqEuBB7HxJ1D6946FQEuODy1XaXG1JHrXRQES6sdDvj9U1PUiHldZ+nnOyN+P
         8KeG7tdELuVjfNGD/UHzOW5vQAUuw36zVF/t9R0dHHkwKyI5L9E4owdcigVPXbueZoj1
         XPdkJJm9/SdDgXQoj15SUv+et/AMnGPhGMe84gKTl6o8dkCCnPgHKQW2mD+51OPTrCpB
         azdtykyPZghbyhmVl3omum6bH1TsNXbIaWAESq9OUNuR1uVQFXbHQy6Ycm8qFCGqtsYC
         nfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSjiWKMJ+xHLqC6OgWOW3nwZjzPTj8gZHeHSJpqU4DgnO7zHrmkLHlhpjUzTUoEvne3k4ICQeXFJUTWgQBPVk7USw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTXcLldq6+uIE/YiAEiQeT6yScSycKGmgxhavdLN1m0zBOsn7
	DQJbIP3eyPacKt8Bk7TWJkkiNXggIH8J7KKv8pqwbV6SU17GMam8ALh8w+bhycxAD72tlKjp+Fc
	/spaf8fjNmVYjuIPHVq83h96T6oYFZQc=
X-Gm-Gg: ASbGncvkrh0rqGluQzLnOi+9YHYjHLojBUDBmoGhtNC6j2UoghqkJpolBqgMv6X+MRV
	lGriaM3bOpNXAGBpJHF/G6UUNkwpgQTV/bUZSZtgtUFaj4CmWCRP8vcFNasPE6Sb5ifLLHXc/6X
	jegdXHGZuZ4HkgxFZAUk0xfnoYE89Errj2iOGOqzikbWFOYT7CsS4bABQF0vKr/nKUznM2oF/AZ
	M+oip0w2GgDKFXLAGkoO6Y+3qBeGUjm0L6Gmpq7k8ZprGv/9YLMTlQ8ta6Ez8DMgaPgj0ginL1E
	vfiaCuNHbUA=
X-Google-Smtp-Source: AGHT+IHbO+ZGBFXO5ge0ijkSwdvqQcv57wZTtQs6YNPPselRxjdniZ7ynd75vfty+uOIzSWSgkGQqLyBXVlxsfcb078=
X-Received: by 2002:a05:600c:3b84:b0:476:a25f:6a4d with SMTP id
 5b1f17b1804b1-4778fe4f3d1mr4281155e9.1.1763056639666; Thu, 13 Nov 2025
 09:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113123750.2507435-6-jolsa@kernel.org> <c3260fe9e3d8ad79c75a6e8281f9fae5580beb3fcdd08e2015f417e11ec0a1b2@mail.kernel.org>
 <aRYAhDqGsOHZzTL-@krava>
In-Reply-To: <aRYAhDqGsOHZzTL-@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 09:57:05 -0800
X-Gm-Features: AWmQ_bljz9ERUrLpgXYFmwgFdNYuQjEZ9EECbJhv0IrVw392banlmrLNtGinfI0
Message-ID: <CAADnVQKnnZkODUUDDJQNJ7tVnoGreggw5NuvaP81=rpUYXwd7g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod function
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, rostedt@kernel.org, 
	Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:00=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Nov 13, 2025 at 01:02:17PM +0000, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 433c36c3a..bacb6d9ab 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -544,6 +544,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops=
 *ops, unsigned long addr);
> > >
> > >  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_h=
ash *hash);
> > >  int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_h=
ash *hash);
> > > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_h=
ash *hash, bool do_direct_lock);
> > >
> > >  void ftrace_stub_direct_tramp(void);
> > >
> > > @@ -581,6 +582,11 @@ int update_ftrace_direct_del(struct ftrace_ops *=
ops, struct ftrace_hash *hash)
> > >     return -ENODEV;
> > >  }
> > >
> > > +int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_=
hash *hash, bool do_direct_lock)
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > The stub function name doesn't match the declaration. Should this be
> > update_ftrace_direct_mod() instead of modify_ftrace_direct_hash()?
>
> it should, my bad
>
> >
> > > +{
> > > +   return -ENODEV;
> > > +}
> > > +
> >
> > [ ... ]
> >
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 345f3fdd2..627d05b57 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -6445,6 +6445,74 @@ int update_ftrace_direct_del(struct ftrace_ops=
 *ops, struct ftrace_hash *hash)
> > >     return err;
> > >  }
> > >
> > > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_h=
ash *hash, bool do_direct_lock)
> > > +{
> > > +   struct ftrace_hash *orig_hash =3D ops->func_hash->filter_hash;
> > > +   struct ftrace_func_entry *entry, *tmp;
> > > +   static struct ftrace_ops tmp_ops =3D {
> > > +           .func           =3D ftrace_stub,
> > > +           .flags          =3D FTRACE_OPS_FL_STUB,
> > > +   };
> > > +   unsigned long size, i;
> > > +   int err;
> > > +
> > > +   if (!hash_count(hash))
> > > +           return 0;
> > > +   if (check_direct_multi(ops))
> > > +           return -EINVAL;
> > > +   if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > > +           return -EINVAL;
> > > +   if (direct_functions =3D=3D EMPTY_HASH)
> > > +           return -EINVAL;
> > > +
> > > +   if (do_direct_lock)
> > > +           mutex_lock(&direct_mutex);
> > > +
> > > +   /* Enable the tmp_ops to have the same functions as the direct op=
s */
> > > +   ftrace_ops_init(&tmp_ops);
> > > +   tmp_ops.func_hash =3D ops->func_hash;
> > > +
> > > +   err =3D register_ftrace_function_nolock(&tmp_ops);
> > > +   if (err)
> > > +           goto unlock;
> > > +
> > > +   /*
> > > +    * Call __ftrace_hash_update_ipmodify() here, so that we can call
> > > +    * ops->ops_func for the ops. This is needed because the above
> > > +    * register_ftrace_function_nolock() worked on tmp_ops.
> > > +    */
> > > +   err =3D __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, =
true);
> >                                                                        =
 ^^^^
> > Does __ftrace_hash_update_ipmodify() accept a fourth argument? The
> > function signature shows it only takes three parameters (ops, old_hash,
> > new_hash). This looks like a compilation error.
>
> the whole patchset is based on bpf-next/master plus Song's livepatch
> fixes which change modify_ftrace_direct_hash function, it's mentioned
> in the cover letter

Ohh. Will send bpf PR to Linus today and merge into bpf-next afterwards.
