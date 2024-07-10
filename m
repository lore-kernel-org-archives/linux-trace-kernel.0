Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E215E88;
	Wed, 10 Jul 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720640952; cv=none; b=aGvBPDugCIBd0l81jhQxRYrFwaIQfbQwcIkdtV5xpZpWnctpRf+WMWGh1gpnX4HujYY35p+y0IVrzcQZuJU3wo6JhE9jK1qFkUCOMWiaaQPCeXbsWqbYqiVslrjYN/vjtxterNdqRbTopQtmHW1TeFzRbjn5HMk9dVpPjeOcBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720640952; c=relaxed/simple;
	bh=41DGqMw1GDdETmiSQT1h9OdQDhmJvURfwVSdH/utu0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Faxbytvi8VxMQycGYY22GdQIciRASvKwMDEx0FBuiwPqiFSKLZ1SX3pFgfj7bfzyJoen3cZlAlamLnh5WJa3z5vypN4SPIY9YuRO3kPEXheZ72OnUBepq/RQbgrL/gIyWRiorOcsXTEVL0cupgQY6kHvJJU+9gSVLaBOD5hGx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXW78RfY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXW78RfY"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c9df3eb0edso137607a91.3;
        Wed, 10 Jul 2024 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720640951; x=1721245751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQkQezLi6TntpjP51t6t8ABeJbOZSStjb0u/VOLMsg8=;
        b=QXW78RfYs8J6XkYOjuQa3x2eWxoNdUYwY3ufkzWSCi20EJK/ygBnIqZ6pK/BtRmsT+
         rnK3aPrylCdfGqE4OYojpcxdIicXb8gIKwaqhr9vLNLtyTOJCgysvix1bL/hsOX9hdIM
         lDeOYpJjFZWDaPJE7VNBYoy7+2d+WY9u+OquBFffmPzBaR1ZLK7Aei5tfz6s0cUoklL3
         4cqR0uYP5ALdLaRqP5MVICB/U/xwce/4bRva9gJ6HHVHQ5hFlynEMgh/OaxahfKmRoSp
         v1FplWdcdBEI2NrjRwuQyCN2vfeOASFytZr9uNTvX1vDGQMVzDnEkAq4GBA/dlyp7t0l
         OTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720640951; x=1721245751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQkQezLi6TntpjP51t6t8ABeJbOZSStjb0u/VOLMsg8=;
        b=KN6UsqvOzefIZOy/a/4ZD9lU9kKeJFyiG87jHKy7VJvpa7SMyCGMekgBGQjLqcqs7l
         YwajFWokApuxmtnTFBtdkHTw06nyF9113lLfMwn7eAOkkGxhrm0YX7QWYYjU2RP0Z85K
         5MW6VknH2mm/C8pxFXvdJE/9BvlF8i7aGiXKDPlg9O7Yj/bty0jtDl1bPi+VCqyCdRel
         CQ+UId9pCSCKrobDCbsBhpHnHY6DpGyg9tA3dgPz2xKoMH+4GTvJKsO25+hfIV3IPtUI
         sA2jMBS4igCE6gwAP/dylJthsR9Y+y6rt5iZ4fz91Tx+RTAL8hRRv6i1yR8dJM8X8rjG
         aGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwuBu2XswzSClwMZoUNZPkIblISD4JGBI1gXns8yD/FnGzOmHJeMENjPerMeL81zTmSKV/hlzkL/vOYL7r/aRlKaiitmE24wR27r5y748Xqo1erhmip4uVmZ0M87kYriZbmFNH6PMapPybIEcu1k9
X-Gm-Message-State: AOJu0YwGSrXFf7jEhvQotJFQGuIdy7MpWdAhVTEVg8aGVAFmaE+LR+DT
	EldozQ4zegUoREl0tn87AVoOOATf/R1ts+LzhqAPx8JX+RBC5lhceyy5pi3NdIpkdx/CtM4BAD2
	fkw2I/Wtnb9eVIW6+5yWD4g+4/6M=
X-Google-Smtp-Source: AGHT+IG5NaOOtI0Wr2Xcdog1d21kSwwNc3K3gyRs7sdWa0Pe4Yw3XWWCNbzO8sOhuiN1Y+hVhx7M1NH069u2PeK9j7U=
X-Received: by 2002:a17:90b:1645:b0:2c9:cbdd:ac8 with SMTP id
 98e67ed59e1d1-2ca35d3b196mr5221212a91.37.1720640950677; Wed, 10 Jul 2024
 12:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com> <Zo67c9nvbRD0h4-b@krava>
 <CAEf4BzaSDUWiSywUNrDtd-yW6p53vFYkZkr5mb461jmUgWV_2g@mail.gmail.com> <Zo7jQOWyUGp6YTbz@krava>
In-Reply-To: <Zo7jQOWyUGp6YTbz@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 12:48:58 -0700
Message-ID: <CAEf4BzaZuFZX8g+cEB9XUoQf0Q1Gvq-PqJwCXqfL7-AyAJVxaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe *
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	peterz@infradead.org, clm@meta.com, mingo@kernel.org, paulmck@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:38=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Wed, Jul 10, 2024 at 11:23:10AM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 10, 2024 at 9:49=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Jul 10, 2024 at 06:31:33PM +0200, Oleg Nesterov wrote:
> > >
> > > SNIP
> > >
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index 467f358c8ce7..7571811127a2 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -3157,6 +3157,7 @@ struct bpf_uprobe {
> > > >       loff_t offset;
> > > >       unsigned long ref_ctr_offset;
> > > >       u64 cookie;
> > > > +     struct uprobe *uprobe;
> > > >       struct uprobe_consumer consumer;
> > > >  };
> > > >
> > > > @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct pat=
h *path, struct bpf_uprobe *uprobes,
> > > >  {
> > > >       u32 i;
> > > >
> > > > -     for (i =3D 0; i < cnt; i++) {
> > > > -             uprobe_unregister(d_real_inode(path->dentry), uprobes=
[i].offset,
> > > > -                               &uprobes[i].consumer);
> > > > -     }
> > >
> > > nice, we could also drop path argument now
> >
> > see my comments to Oleg, I think we can/should get rid of link->path
> > altogether if uprobe itself keeps inode alive.
>
> yea, I was thinking of that, but then it's kind of useful to have it in
> bpf_uprobe_multi_link_fill_link_info, otherwise we have to take it from
> first uprobe in the link, but ok, still probably worth to remove it ;-)

if we need it for link_info, probably cleaner to just keep it, no big deal =
then

>
> anyway as you wrote it's ok for follow up cleanup, I'll check on that
>
> >
> > BTW, Jiri, do we have any test for multi-uprobe that simulates partial
> > attachment success/failure (whichever way you want to look at it). It
> > would be super useful to have to check at least some error handling
> > code in the uprobe code base. If we don't, do you mind adding
> > something simple to BPF selftests?
>
> there's test_attach_api_fails, but I think all checked fails are before
> actually calling uprobe_register function
>
> I think there are few ways to fail the uprobe_register, like install it
> on top of int3.. will check add some test for that
>

great, thank you!

> jirka
>
> >
> > >
> > > jirka
> > >
> > > > +     for (i =3D 0; i < cnt; i++)
> > > > +             uprobe_unregister(uprobes[i].uprobe, &uprobes[i].cons=
umer);
> > > >  }
> > > >
> > > >  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> > > > @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const unio=
n bpf_attr *attr, struct bpf_prog *pr
> > > >                     &bpf_uprobe_multi_link_lops, prog);
> > > >
> > > >       for (i =3D 0; i < cnt; i++) {
> > > > -             err =3D uprobe_register(d_real_inode(link->path.dentr=
y),
> > > > +             uprobes[i].uprobe =3D uprobe_register(d_real_inode(li=
nk->path.dentry),
> > > >                                            uprobes[i].offset,
> > > >                                            uprobes[i].ref_ctr_offse=
t,
> > > >                                            &uprobes[i].consumer);
> > > > -             if (err) {
> > > > +             if (IS_ERR(uprobes[i].uprobe)) {
> > > > +                     err =3D PTR_ERR(uprobes[i].uprobe);
> > > >                       bpf_uprobe_unregister(&path, uprobes, i);
> > > >                       goto error_free;
> > > >               }
