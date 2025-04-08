Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0F23C8B2;
	Tue,  8 Apr 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127733; cv=none; b=cqmPZqWB8I1OVdFqZuHqJof/UWcL9RJ2GovV6j76G2jPoZh6FFpOM/XOckjGv6s4WmmWfYa3oGEX376uQ3OAVz9zt0TjjCsvon0wYutAEuhag7HcROC9SIyyNeJUJ5VA9bTYM5JMnlo/scqs5Y6Qyj3sy0rK12iLYidigKv/x/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127733; c=relaxed/simple;
	bh=Grp1Pw0/iwvWKb8SP7ouGiFqbuZhmL2YaxkwVJ6Lsjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVbYnml4nNqXCg8rCu4ex4jzSnBhVUIsydQRZHZX0DxkeL+v7Re8wf3cOE763D1Ks00kvfNgEJZ9VmugaESIn1VUijZ4ZcCZbe6xuzgyTiKVjcGmCCwIgEHM2wpt3GJpfCZRLlOs4wcHxB7s8j94tpLVg5dgT9R/RBzUbAzAZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9ZYQSdN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9ZYQSdN"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ad5236e6fd6so5246229a12.0;
        Tue, 08 Apr 2025 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127731; x=1744732531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r8d4CoqNWfbO+vOmunolZhghnfaufTr/d12tmCx3c8=;
        b=C9ZYQSdNYqqGDo0aSZafrUwgKH9HDhrWCyhJ3VQH+8nmh7j4eQjDSmT0SOL+Lzi61p
         b00tHSc5nugAmLaxMKo597W/DyMqsuiJcS4bSTk7ATR8yfNljvTo6tQU2prJQaKPeLjU
         mt3j1dJ9vdAciCJ/Zv4ZJPznrXiOysNH3WQtTgA1sdZz0fpYFknGSohG3FwoR9bqS/Ib
         Wp7CLyx9Bpx+IKsBbKsnKvM9XjxsYBeR0LC6gW3DWEyKfdNqUpGf2YC7SFGrzwuZAjqe
         nviGePYRyVMeWkHKWRjeLppZ3o2mSQTOG5M/lIpT54GT5ZUY+MvaiJhBb8CfUO3iyGxl
         AUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127731; x=1744732531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r8d4CoqNWfbO+vOmunolZhghnfaufTr/d12tmCx3c8=;
        b=TymIhgzcribH+vJUbdrkpBJ3RI9fbssZ0MgCwOHOQ0haTpCsq2I5s66YJDAMju2t+g
         D++SK37w/2e8cdaybeQBtle+mHAth3NUqRkvVUY+i3pKnoJpK0C4w0M8DGKSFKF+hGju
         eenwA9/V1sT1vGfOKvVjJgcoGDx7A+a+TMU+eVnddgYqfn1kNDgizEXlW9JIHPgfg5Gc
         3G7D6UqNSfr/0ONn3TKggABowOqIWCgzZmcJNsoeQNf8mbrwWyMJu4mFIn57TLJQpzjd
         M8XhFUkqfA+zhlkZVK6CoST+eoWCHvoVV+BuQuAxzyJGR74QmQyDz/7Dxns8nsjMtXF3
         A6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCX7PXX6cNZtgB/HKzxVff1i5h/WANSUtuI/NCq2WT6vu5DhSuVLOP/cuBAireZpA4nnp8HK+oIFsyNDy/CN3HhzQqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dN2L3EUICX6sEkC6gt5A8zguCEfR/3LT86PLDOQOD2EJDhd2
	knQfLgqiG5/WpgYvuEt/bRs0GwyM71MA8D4Dy65j2JXTfKgowABDb/mz2kZCQqpB9eaMt0YxHg0
	235P+9p1I3WufSsmZQCDDy4oZr1X6bxl5
X-Gm-Gg: ASbGncsXX5xmNy1tiK0tKISdwv2B9N927jNfg1TXzyuCJkz9zbQsnGpBnEOY0CHvfwo
	S/0eBSFtAxfbwhigIk8hpRTYWWxeKtJ+DpmrbKG7uSVj00Awm/53rrXsH9BQBHS7LVUAYrYJmsY
	dsh51lqosRBCpcvgkh96eomWrsCfCV
X-Google-Smtp-Source: AGHT+IEdAdNI/m0mDZDBYf6Uybrhu+VFgs+XsaRN6/KpawOjlF83g1h1SFl0iYxOHt2R9GHMGaZXsz4fEgl+jAnloHw=
X-Received: by 2002:a17:90a:c890:b0:2ff:53a4:74f0 with SMTP id
 98e67ed59e1d1-306a48acec4mr23379143a91.29.1744127730882; Tue, 08 Apr 2025
 08:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407180745.42848-1-andybnac@gmail.com> <20250407160924.7c28fffd@gandalf.local.home>
In-Reply-To: <20250407160924.7c28fffd@gandalf.local.home>
From: Andy Chiu <andybnac@gmail.com>
Date: Tue, 8 Apr 2025 23:55:19 +0800
X-Gm-Features: ATxdqUH2NmCkB2Z6aSwDjJk1d3UhdbibANS3Y8DMTs7j6Xq0075pr7HoeVndza4
Message-ID: <CAFTtA3N=fB9Yr3EiTUpGzF2imtwgnVEextyL3+V1wiTJ_jp+WA@mail.gmail.com>
Subject: Re: [PATCH] ftrace: properly merge notrace hash
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bjorn@rivosinc.com, puranjay12@gmail.com, alexghiti@rivosinc.com, 
	paul.walmsley@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com, 
	nylon.chen@sifive.com, eric.lin@sifive.com, zong.li@sifive.com, 
	yongxuan.wang@sifive.com, samuel.holland@sifive.com, olivia.chu@sifive.com, 
	c2232430@gmail.com, vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> =E6=96=BC 2025=E5=B9=B44=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue,  8 Apr 2025 02:07:44 +0800
> Andy Chiu <andybnac@gmail.com> wrote:
>
> > The global notrace hash should be jointly decided by the intersection o=
f
> > each subops's notrace hash, but not the filter hash.
> >
> > Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to mana=
ge many")
> > Signed-off-by: Andy Chiu <andybnac@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 1a48aedb5255..ee662f380b61 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3526,18 +3526,17 @@ int ftrace_startup_subops(struct ftrace_ops *op=
s, struct ftrace_ops *subops, int
> >           ftrace_hash_empty(subops->func_hash->notrace_hash)) {
> >               notrace_hash =3D EMPTY_HASH;
> >       } else {
> > -             size_bits =3D max(ops->func_hash->filter_hash->size_bits,
> > -                             subops->func_hash->filter_hash->size_bits=
);
> > +             size_bits =3D max(ops->func_hash->notrace_hash->size_bits=
,
> > +                             subops->func_hash->notrace_hash->size_bit=
s);
> >               notrace_hash =3D alloc_ftrace_hash(size_bits);
> >               if (!notrace_hash) {
> > -                     free_ftrace_hash(filter_hash);
> > +                     free_ftrace_hash(notrace_hash);
> >                       return -ENOMEM;
> >               }
> >
> > -             ret =3D intersect_hash(&notrace_hash, ops->func_hash->fil=
ter_hash,
> > -                                  subops->func_hash->filter_hash);
> > +             ret =3D intersect_hash(&notrace_hash, ops->func_hash->not=
race_hash,
> > +                                  subops->func_hash->notrace_hash);
>
> Thanks for catching this.
>
>
> >               if (ret < 0) {
> > -                     free_ftrace_hash(filter_hash);
>
> The filter_hash still needs to be freed, as it could have been allocated =
in
> the previous if statement and never used (both the filter_hash and
> notrace_hash get used at the end of the function via ftrace_update_ops().
>
> Care to send a v2?

Yes, thanks for reminding! Let me send a v2 with filter_hash freed on
this condition.

Regards,
Andy
