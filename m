Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848431A76BF;
	Tue, 30 Jul 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360435; cv=none; b=QR/vd6wekj2b5GJ9bqc0qjIV5259hAwtYWwAuiC02VyYNHZ+ggst9MXqKKB6yjzc4c1227nI/7Tq61DGtpEwPwmc2egrq78SnWc9WWpmw4dqPfiiHhDExfE2DPr8babAXKsJVqJZt0fPhLHlMjOeXTk3VKJT4yx1ki8/MsB/JdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360435; c=relaxed/simple;
	bh=6p98u6SIWlhiVPjvsPXIichyblzQjYvfVT+RJ4u9t1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tch57oXDXRxkDBtf4tMpx/FeZv3WwyjCIFkbeTVh3m9by0kP1Eo9lnxF+dPvjk9rsrRcIn2bl0atzg2PgsZYQR6k8WOenwE7BS9TOfw1Y6QuY1IfZReGhVvrAPcrNGlcY4/OK8C9M+kW1PhKj7Q2Bl51gsApPhtOYhf0by7yxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFaH+AD3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFaH+AD3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb585375f6so3522840a91.3;
        Tue, 30 Jul 2024 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722360434; x=1722965234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuhSbZfPq+Y1KO4HN8+egIKvw/xvt2Rrevesh1kZBJ4=;
        b=cFaH+AD3moFnrl3dRz4LcvjdA9zecQPtgInw9UBCSPfupLNmvt043mjkmfENCsydGL
         oCPZjwDuiGPY+ePaPzd92eFfqmKt1h1r4WidFQa1TaFZ3Z4PIMTURjJ+uSTezHzgtnYX
         O6Q9Q6YuFSe3LIm2Lm0jmgh06gfT6ILZsrU0AxSivof+kvQojQ/XJ75CsY0yx1z7+qBO
         uEUy94fVY1JOrbdt6/6+yYoS+BnFk/9ZSlF9hXR0thNqz33cY6JiJgzAT0XC7z6AsoFH
         MxMo7mRfUzOyxFouILoYZ3Z202evLDC+SaFOWIWlUVzEeNEH/3G7x9FSF1yzagbsGjsr
         2FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360434; x=1722965234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuhSbZfPq+Y1KO4HN8+egIKvw/xvt2Rrevesh1kZBJ4=;
        b=A1w4dDnvscTZG5Sb8jam1uK5hgLwf2WTU/znlDRFUrFIsJ0Dae+2QcUWoKqcide8Gv
         X5hZHjWxvLbI4n4AAgcDTrhMvGAMZOyb33smO+WPQ2RV1GY+4dFqXPeNALMIC7rfYEdV
         KlDv+j3G635+qvLIkkKMQ6KGGqmyagc29Un0PObnZACVl9spES3G5hEMA2gXchflBxc1
         bpwkcZahyWdxrzF6YYgJVm2iV15J1OGX9rR9iNFbKBlwHJ1tvifB8WiQQIAJk0VEn8In
         6CnM05AK3MWn1jqK6MuT6L1YuWfBBYGjJFlivfKq0jriWMuOUhZZFsOwOx0QqG1h5XK0
         W0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXS9nrqgsuyj8RYpZ3lZnR8EjbQuo1Tx1MssneWOQqjc6xv/J5pCux8uXMoRjLgWK8kkLD9uTO0V0RENhEKcFnmBUlobYS0hz8YDyJ14gc7gqtlrHJbdD/6feB1/kFS0SecotnMTh5RR8VL3e7klmpu
X-Gm-Message-State: AOJu0Yww9jS/MVuXZSmsWfwSzq5QsB9tQ0CzhKlIkGyWqaI0Ae6ps1j3
	jlchXJE3i3p1XXiNI0/noe9pkxAB/ujFayN2YQQvpgQ92HO5roGU7uQBzhIYDmlpbI/xemsrokj
	qooZMlmgt0OCR5XTXzJ3ADhasMgJCxg==
X-Google-Smtp-Source: AGHT+IGyFsC7HtS+vcCAFkEG6c3/pZQY9ndO8lwrAr/jOWY1HEkXVfMbtT4EPMLKGJ6cXR84zz3jk9btVaOgA1mGI44=
X-Received: by 2002:a17:90a:9e6:b0:2c9:8b23:15ba with SMTP id
 98e67ed59e1d1-2cf7e71fcb4mr12928584a91.42.1722360433715; Tue, 30 Jul 2024
 10:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730123421.GA9085@redhat.com> <20240730123457.GA9108@redhat.com>
 <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com> <20240730171733.GA10822@redhat.com>
In-Reply-To: <20240730171733.GA10822@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 10:27:01 -0700
Message-ID: <CAEf4BzYiBgqJwmh=rJiL+5gfwbZprEp81wnmq219w5j5WEGAFg@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to uprobe_unregister()
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:17=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> Thanks for looking at this!
>
> On 07/30, Andrii Nakryiko wrote:
> >
> > BTW, do you have anything against me changing refcounting so that
> > uprobes_tree itself doesn't hold a refcount, and all the refcounting
> > is done based on consumers holding implicit refcount and whatever
> > temporary get/put uprobe is necessary for runtime uprobe/uretprobe
> > functioning.
>
> No, I have nothing against.
>
> To be honest, I don't really understand the value of this change, but
> a) this is probably because I didn't see a separate patch(es) which
> does this and b) assuming that it doesn't complicate the code too much
> I won't argue in any case ;)
>
> And in fact I had your proposed change in mind when I did these cleanups.
> I think that they can even simplify this change, at least I hope they can
> not complicate it.

I just find this logic to drop refcount if the consumer list is empty
super confusing and hard to intuitively reason about. It's just very
unconventional and seems problematic every time I think about this.

Either way, we can discuss once you see the code, it's not really
complicated if I stick to refcount_t instead of my fancy atomic-based
refcounting.

>
> > BTW, do you plan
> > any more clean ups like this? It's a bit of a moving target because of
> > your refactoring, so I'd appreciate some stability to build upon :)
>
> Well yes... may be this week.
>
> I'd like to (try to) optimize/de-uglify register_for_each_vma() for
> the multiple-consumers case. And, more importantly, the case when perf
> does uprobe_register() + uprobe_apply().
>
> But. All these changes will only touch the register_for_each_vma() paths,
> so this is completely orthogonal to this series and your and/or Peter's
> changes.
>

Ok, sounds good, it would be nice to keep the other part more or less
intact for the time being. Thanks!

> > Also, can you please push this and your previous patch set into some
> > branch somewhere I can pull from, preferably based on the latest
> > linux-trace's probes/for-next? Thanks!
>
> Cough ;)
>
> No, sorry, I can't. I lost my kernel.org account years ago (and this is
> the second time this has happened!), but since I am a lazy dog I didn't
> even bother to try to restore it.

It doesn't have to be kernel.org repo :-P Github would work just fine,
but ok, if it's too much trouble I'll just go download emails one by
one and apply them locally.

>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks!
>
> > > @@ -1102,10 +1100,16 @@ void uprobe_unregister(struct uprobe *uprobe,=
 struct uprobe_consumer *uc)
> > >                 err =3D register_for_each_vma(uprobe, NULL);
> > >
> > >         /* TODO : cant unregister? schedule a worker thread */
> > > -       if (!err && !uprobe->consumers)
> > > -               delete_uprobe(uprobe);
> > > +       if (!err) {
> > > +               if (!uprobe->consumers)
> > > +                       delete_uprobe(uprobe);
> > > +               else
> > > +                       err =3D -EBUSY;
> >
> > This bit is weird because really it's not an error... but this makes
> > this change simpler and moves put_uprobe outside of rwsem.
>
> Agreed, uprobe->consumers !=3D NULL is not an error. But we don't return
> this error code, just we need to ensure that "err =3D=3D 0" means that
> "delete_uprobe() was actually called".
>

yep

> > With my
> > proposed change to refcounting schema this would be unnecessary,
>
> Yes.
>
> Oleg.
>
