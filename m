Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F6198E6E;
	Wed, 10 Jul 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644409; cv=none; b=gVtMOZNwamZq7U6x80QAa7K8H79rmN5ffo3ws4jliymmCY0EsgRJCMT/SUrawCIbG0wM3+sqQFnUtW6HOt/+GJe6wZaeo64Zxaow/b225KkPivH0WNDsnTBweK7CPbLj3Z07LDbi0aGy0DpHKw8qCaejPcMzHo6GY7GRj05+1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644409; c=relaxed/simple;
	bh=pENnPF6Kzz5Y3pavfPC9emSBb++6nrbm8B8eU3jm9TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5ARvm4j7jOSfajNDKNeLV51N3E4+N74810lMIuBnT+zv2Bdj/Z9ZnB5cB2+8FOkGGTHVAmzbo+fL2zRn/OPKt3LSPZmfKcohswnZsGYvjrqTUnv3xLkvKN2Sg/kdQcfO3dIRwXUvsm8iOT1DTEc8WfH56ozXX8cEJqEJA76tHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1Lcbqvb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Lcbqvb"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c98a97d1ccso948795a91.0;
        Wed, 10 Jul 2024 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720644407; x=1721249207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcMxJnp44TmbovGYRrSPkTmmfQU5JA0tqyT4xfX5zkk=;
        b=O1LcbqvbhNGsnIAtVmSqz87AVw6/fhge/aIZiqNzsWt38RZ7gkguTklntXOSEg3fSF
         nTbZOKSC5GXXI6bCAlY2TeZLrclNC+O2jtvQ98NKQzcRFTkziroLevv9toHDYo/8mzfr
         vz9PI+8TzUNc2NAw1g46wmIw0SlAxhqZKCPxkqHapKiGgSUCX5msTYpKwM1ikC58FCb+
         avWXhHsURQvhut8G+kjgBc/PpaoFwk3GQ6w/t80TtVgcE8qxNWEo24rg3zFY3myN1a6q
         c0Z9o09ztWKVRG3eiG1af/wYD4Y8d8mp/l1IwncmmrboX3c/XJJ3exx1K1xlK5sd0ls8
         nsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644407; x=1721249207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcMxJnp44TmbovGYRrSPkTmmfQU5JA0tqyT4xfX5zkk=;
        b=wfCy/qUZE3QbWNYJDYAFo7X8hj6XLsNKrtidImJd4uBBA8HOLCbZ58O9SNUTabDOCJ
         cxRyuwyEWKt/bBmB1bZ5Z/p7p/UiHe8C6lHMeEimystvK0EE5POcCWzKc/iYgPL8Zq88
         WyQzCZoTcve2cuPEZa7sr3GZ9SfAoEQYxVJlPhaa5ASIe/KfGjIHL7HTLa1mvYchicS/
         3fCPkjFXOFCnbTn/MvrCIJzH2KR9HV5fYK57QbuaK/KJtCV+cELtvktH59E4xYQru/uA
         znjVXp7LtUZ31TM/Aab1Ak1a2sbQvixKZ5fznt/ecv3M4cZ5MX8Hi4ZTEoHGtThBnRnd
         AGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTGQDiAXYjCtVZHuVfcFHa5uzt/y3o6g7Z7UXHEACX5Z4+YQ0kfrru6J778lhC9vTVSeFCGrEnquLPPVyWbzlJQodNZkzlLgLA/v112FULCwEGnNGssREQITFGW77rP75w1Kr8TDA0A3A4z3U2hLy+
X-Gm-Message-State: AOJu0YwAWegV6W9vmSXn+8jT6nQSAWZ9WhjgFSISiZ9NiKhqeA6iZ+LZ
	E9r3GP5mmGrKX6yCaiT+5vwFo6JfT86keITYDuIAF6lePKV2J1F6NOaHjIMYz/piMoAvasEgdQ6
	08sepR3QDoJQT7eJf4k966gclUoZ8o8Wx
X-Google-Smtp-Source: AGHT+IG5Z4xp56J/PEe/k+HOJOtS48rG+AvNOhUolhF8kd0teihAoI63uxCkN8+7rKaBKHK7NhkudBSjldQ8uOgbJdI=
X-Received: by 2002:a17:90a:b781:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2ca9d993cb2mr1037141a91.10.1720644406693; Wed, 10 Jul 2024
 13:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com> <CAEf4BzZa0Ye83QfTbw6Sw3ERg2PJ7ioN_pEFHYui6JGEHhOg4Q@mail.gmail.com>
 <20240710201651.GG9228@redhat.com>
In-Reply-To: <20240710201651.GG9228@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 13:46:34 -0700
Message-ID: <CAEf4BzYHcKs5P2FruYaGZg_Nj3r12amyjd9-Fh_DbMB0=gFcZA@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe *
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, clm@meta.com, 
	jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:18=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/10, Andrii Nakryiko wrote:
> >
> > On Wed, Jul 10, 2024 at 9:33=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > This way uprobe_unregister() and uprobe_apply() do not need find_upro=
be() +
> > > put_uprobe(). And to me this change simplifies the code a bit.
> > >
> > > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > > ---
> > >  include/linux/uprobes.h     | 14 ++++++------
> > >  kernel/events/uprobes.c     | 45 ++++++++++++-----------------------=
--
> > >  kernel/trace/bpf_trace.c    | 12 +++++-----
> > >  kernel/trace/trace_uprobe.c | 28 +++++++++++------------
> > >  4 files changed, 41 insertions(+), 58 deletions(-)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index aa89a8b67039..399509befcf4 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> >
> > I don't see struct uprobe forward-declared in this header, maybe we
> > should add it?
>
> Probably yes, thanks... Although the current code already uses
> struct uprobes * without forward-declaration at least if CONFIG_UPROBES=
=3Dy.
> Thanks, will add.
>

Yep, I saw that and was wondering as well.

> > >  static inline int
> > > -uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consu=
mer *uc, bool add)
> > > +uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool=
 add)
> > >  {
> > >         return -ENOSYS;
> > >  }
> >
> > complete aside, when I was looking at this code I was wondering why we
> > even need uprobe_apply, it looks like some hacky variant of
> > uprobe_register and uprobe_unregister.
>
> All I can say is that
>
>         - I can hardly recall this logic, I'll try to do this tomorrow
>           and write another email
>
>         - in any case this logic is ugly and needs more cleanups
>
>         - but this patch only tries to simplify this code without any
>           visible changes.

yep, that's why it's an aside, up to you

>
> > > @@ -1133,41 +1126,39 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
> > >   * refcount is released when the last @uc for the @uprobe
> > >   * unregisters. Caller of uprobe_register() is required to keep @ino=
de
> > >   * (and the containing mount) referenced.
> > > - *
> > > - * Return errno if it cannot successully install probes
> > > - * else return 0 (success)
> >
> > mention that it never returns NULL, but rather encodes error code
> > inside the pointer on error? It's an important part of the contract.
>
> OK...
>
> > >  /*
> >
> > this should be /** for doccomment checking (you'd get a warning for
> > missing @uprobe if there was this extra star)
>
> Well, this is what we have before this patch, but OK
>
> > >   * uprobe_apply - unregister an already registered probe.
> > > - * @inode: the file in which the probe has to be removed.
> > > - * @offset: offset from the start of the file.
> >
> > add @uprobe description now?
>
> If only I knew what this @uprobe description can say ;)

I'm pointing this out because I accidentally used /** for comment for
some function, and I got some bot report about missing argument. I
think /** makes sense for documenting "public API" function, so which
is why all the above.

>
> > > @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path =
*path, struct bpf_uprobe *uprobes,
> > >  {
> > >         u32 i;
> > >
> > > -       for (i =3D 0; i < cnt; i++) {
> > > -               uprobe_unregister(d_real_inode(path->dentry), uprobes=
[i].offset,
> > > -                                 &uprobes[i].consumer);
> > > -       }
> > > +       for (i =3D 0; i < cnt; i++)
> >
> > you'll now need !IS_ERR_OR_NULL(uprobes[i].uprobe) check (or just NULL
> > check if you null-out it below)
>
> Hmm... are you sure? I'll re-check... See also the end of my email.

no, you are right, it should be fine

>
> > > @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union =
bpf_attr *attr, struct bpf_prog *pr
> > >                       &bpf_uprobe_multi_link_lops, prog);
> > >
> > >         for (i =3D 0; i < cnt; i++) {
> > > -               err =3D uprobe_register(d_real_inode(link->path.dentr=
y),
> > > +               uprobes[i].uprobe =3D uprobe_register(d_real_inode(li=
nk->path.dentry),
> >
> > will uprobe keep inode alive as long as uprobe is attached?
>
> Why? No, this patch doesn't (shouldn't) change the current behaviour.
>
> The users still need kern_path/path_put to, say, prevent umount.

ok, then link->path has to stay, I was just wondering if we need to
keep it alive

>
> > we can NULL-out uprobe on error for bpf_uprobe_unregister() to handle
> > only NULL vs non-NULL case
>
> Not sure I understand...
>
> > or maybe better yet let's just have local struct uprobe variable and
> > only assign it if registration succeeded
>
> We can, but
>
> > (still need NULL check in
> > bpf_uprobe_unregister above)
>
> Why?
>
> If bpf_uprobe_unregister() is called by bpf_uprobe_multi_link_attach() on
> error, it passes cnt =3D i where is the 1st failed uprobe index. IOW,
> uptobes[i].uprobe can't be IS_ERR_OR_NULL() in the 0..cnt-1 range.
>
> If it is called by bpf_uprobe_multi_link_release() then the whole
> 0..umulti_link->cnt-1 range should be fine?

yes, you are absolutely right, I missed that for this partial failure
case we pass i as count into bpf_uprobe_unregister(), sorry about the
noise!


please feel free to add my ack for the next revision:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Oleg.
>
