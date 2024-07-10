Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877D22066;
	Wed, 10 Jul 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635804; cv=none; b=QK7jl0Ccz/EbM8AaK85YCOievUVdzvnuXJSNEWodA46Efr4tVvTLPirF5dCXN3UsiJnBRCCRHRW1Azt9g4Pe/pBAqo1kcg8kgddArDQKR0h30l5TYfWxCkMZFAhLLHSSq7Sz4A2OfppkkWTOVM5fRkJnwbfVgnGNphPxMIErC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635804; c=relaxed/simple;
	bh=CFA2jMuSto+XRjM35M+GiHj245fQAov6XBpnIba7XIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVeh3Cigs2z6SxqiV3LgP40fiOxKCAkL+um0uw0FBZiNEJWTkzDXPHb9a8lRM/X/xBFhVLRxTQJ3ra0z5i2alAC1OQCbRX94LoC5iEzRNyocEYXxtkgTQwWiEd2SkDnLVUEqkIqZY5q9TwyBIhI2JIEZ73YWfoAfzCwymi9ohnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzWXohlG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzWXohlG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7276c331f78so819180a12.0;
        Wed, 10 Jul 2024 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720635802; x=1721240602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPhGk9BYC5VUyujuDGFyNI2Bj44xBT9g1IUMZKZvGJE=;
        b=XzWXohlGW3rTIOEw/JahvCWZLGySRRu0nJvkrJ//bNeKCdPjPE1MLHvUSssFrNUGH+
         GW9ItILgB4QyRtMFqD7lS02EPItd1PCmZgQbgBE8F/+LoHv0U4XvmC2I6rrexXZuaAqI
         euWeJTtj15UwphGz4hh8qnhb+O4A12vYFj0NhHcoJS0fuZjIgg8WiqGAymTGp2JQWllg
         4iWhFxBMWXO4MOQaSuhEs6YMjhtESN/ttZ+SmvSUtrMVGunNLnUI198GdzkYxvud+qJg
         FSX3059NGUsVbwrrTnKg20sSxfsMWs/+Dfyk6LTEKv6gN80cF8GpAiPlfCSFHwPKDVyI
         Mhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635802; x=1721240602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPhGk9BYC5VUyujuDGFyNI2Bj44xBT9g1IUMZKZvGJE=;
        b=ZuJpPAHlMaMrngPxCnQwicUnV2ixRLPB/fMfC8l1PDp4eHu8cifFtz1HFqfGJz52+H
         gcM0G+f9eDxjjvbuhwjj7jYhkXdKk7KBR4AGVZMWV8rdBpSSAn1ljuOUGTncQJRP6laE
         78DQrmciLIXQ9KRKDgrCX0PWpqGJkN5h7vXv9hRR4IbzQ0DYgbCPYzGLRyKqqAZ3EwQf
         KhnTV9/I0afTHGlHvHGndNdKVMClvxF9hBSfo2U6QzqYQI9zX7aD6FyioUm9zph6v0VO
         v59HL3Ja4xnPJgilCxeIRJ4ktM6tRoiJsSYTVMcHXyOsGHDa/iJS5Wp2z8/cswoAB8Qj
         9Ijg==
X-Forwarded-Encrypted: i=1; AJvYcCVHSZeiG4o7BZJvzpD+/Os4H9iGNoy/JkX89+024uIgso2J7lPjw9RonjULU0JMam/Inn2rkK+nIvf1QZVWNnuN7COC3zSI2Wghqijvi1qRE2KT0VBknz1Zz90rRkqManX3fxVaBSOeBnkCLnVJ98tX
X-Gm-Message-State: AOJu0Yy30B7ohLXLeZ3ZPtmCPjae72EGnmGhJgF6m8rgBDNZdp3hqPJL
	RpVaUGx/ap69yYhWGl26pXlOBOhHXy+XxosTi4JlSJlHKt89UuTHeQas5WRJuD3m+1jvr+AeFyf
	mcQBJHEBoKGfoH1/jJxaXjzyra34=
X-Google-Smtp-Source: AGHT+IEqSP9eVq+r9tM/8ihUchp6euyNzjMpdS8xsQjF1z0vLF3bwqDVX2ZrHgKjtxEtAdGIlKXN+h3YFzXKRgEG8eA=
X-Received: by 2002:a17:90a:a8f:b0:2c9:6188:f3e with SMTP id
 98e67ed59e1d1-2ca9e20bf9amr589181a91.16.1720635801948; Wed, 10 Jul 2024
 11:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com> <Zo67c9nvbRD0h4-b@krava>
In-Reply-To: <Zo67c9nvbRD0h4-b@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 11:23:10 -0700
Message-ID: <CAEf4BzaSDUWiSywUNrDtd-yW6p53vFYkZkr5mb461jmUgWV_2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe *
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	peterz@infradead.org, clm@meta.com, mingo@kernel.org, paulmck@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:49=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Jul 10, 2024 at 06:31:33PM +0200, Oleg Nesterov wrote:
>
> SNIP
>
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 467f358c8ce7..7571811127a2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3157,6 +3157,7 @@ struct bpf_uprobe {
> >       loff_t offset;
> >       unsigned long ref_ctr_offset;
> >       u64 cookie;
> > +     struct uprobe *uprobe;
> >       struct uprobe_consumer consumer;
> >  };
> >
> > @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *p=
ath, struct bpf_uprobe *uprobes,
> >  {
> >       u32 i;
> >
> > -     for (i =3D 0; i < cnt; i++) {
> > -             uprobe_unregister(d_real_inode(path->dentry), uprobes[i].=
offset,
> > -                               &uprobes[i].consumer);
> > -     }
>
> nice, we could also drop path argument now

see my comments to Oleg, I think we can/should get rid of link->path
altogether if uprobe itself keeps inode alive.

BTW, Jiri, do we have any test for multi-uprobe that simulates partial
attachment success/failure (whichever way you want to look at it). It
would be super useful to have to check at least some error handling
code in the uprobe code base. If we don't, do you mind adding
something simple to BPF selftests?

>
> jirka
>
> > +     for (i =3D 0; i < cnt; i++)
> > +             uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer=
);
> >  }
> >
> >  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> > @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union bp=
f_attr *attr, struct bpf_prog *pr
> >                     &bpf_uprobe_multi_link_lops, prog);
> >
> >       for (i =3D 0; i < cnt; i++) {
> > -             err =3D uprobe_register(d_real_inode(link->path.dentry),
> > +             uprobes[i].uprobe =3D uprobe_register(d_real_inode(link->=
path.dentry),
> >                                            uprobes[i].offset,
> >                                            uprobes[i].ref_ctr_offset,
> >                                            &uprobes[i].consumer);
> > -             if (err) {
> > +             if (IS_ERR(uprobes[i].uprobe)) {
> > +                     err =3D PTR_ERR(uprobes[i].uprobe);
> >                       bpf_uprobe_unregister(&path, uprobes, i);
> >                       goto error_free;
> >               }
