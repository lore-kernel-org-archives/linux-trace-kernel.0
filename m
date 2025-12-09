Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4F13B8D67
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765250099; cv=none; b=KgFxqceNn83FgWxz70GeewzCBFL2NngUAKBJ9xL1y7egTyKquzVQkswRWjqTa5FnvY++9CS7cI94NgCTLw5zjACORpP83bCVNzBpAwX8Hl8Pdq60VOHEvSXVxuoJa3u+sOPaXJiSNBzxumAF5GtWCVxb0nDjlvCMHdn1dSkbBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765250099; c=relaxed/simple;
	bh=BQPl5Psqr3Ekhyp3new/iMMcs7hFv3mDUtrCQJ2EJA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnFCNyrJMurP/KqPnmUIWHH+OvrBkBMhveyt04HopJKpG+DEEeTqYZ/k2rLxk3DcI89loIBdy/8q8VpgzlcKwPB9APgjLdEqi1kyK1EMlp2Svs0erGyfQEsHWWXhqkTdQRC1O7yAcsuFpKy8dMMyr/HcfF9nQ3ujiyfFosBQSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ1otKoH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ1otKoH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so8806886a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Dec 2025 19:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765250096; x=1765854896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifyWoLihFbEjhSX2XnNDSy6MvDQZJMVFCA4NUjV6CHw=;
        b=eQ1otKoHifAd3Psk+U9jjy7Cx1rPq86D5mninsRo3zjA+NleCCDPSkCpOueRPrwUis
         HTV1wlP31It2CLNobXk5Us5hCOSxNvQ2G0D9IvXMx1bLGOQsETfkfELxx+16LRXrg8mW
         +7ize6mRlEv4U464PgnV1oUqG3w/6vEBuONjvG4t/LEkHKATDfe72BDK/PecUKNnRGlH
         l89XVz2yRyXjKDJ6QULwizlhI866Invm+iNU8pR4KsdUyU01Kdpb0KcFz8WZDXBJYt0H
         v0ca0QDv8FympRVcquobridL4OGWEhK/pPxrjJ2eL9KgvvaceiiET8pt+vCxRTrbh9pW
         1+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765250096; x=1765854896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifyWoLihFbEjhSX2XnNDSy6MvDQZJMVFCA4NUjV6CHw=;
        b=qb2xO2zOwquB6N+MnJZkUN6cpTQ2irFAetqcDWcemhiq0GMFcztr+1i1ga6NpySJR5
         s2hEtojrG+c8Ad1KTVqn9Jp8BJGWe2S4g3jgIROquRe1d6k9DqqML1woDUz/rooHdbXs
         SuM2KCmkJDS1JeWV/fjbWd2vdu1IPFSsLbZNheyI2sbo67LNjxNjBsQdbvf5x103lUGJ
         yd0tFJJWdWhphv/DRAO9p2Ww9o5nVYB3uQrgvBQHJj+EunnfyOXLH+e2dKnh25q9gn3K
         BF5Xf82N6VUEq8+99q3dyu5tMD15A6QFGHupn/i1LCGVCMB20pWbSNnFElBWJAVvpd5H
         sCbw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/aBR7E17wP+rC0t12qsQ4Jwe9rb9OCFSIrC1m8yaVfXaIjlE+Z9OsfitsqmT0JS6HHKDC6NJORcyeUP/YA3oFyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9QCSj7tuPli/XMVjwtTpucvkDfj72r20831RISLU9u2Y+M15
	WjyFHjrbsl0Y7YqzxRZbKgFXqLdyRRgrMaCzC7co1zOKNSZveb2kz5DzVoKGnhjDAGH/h6ztaxY
	25fqT1yRJ+Nm/9kudVJxYbkEuNSys29o=
X-Gm-Gg: ASbGncteNiKelO0cTH4qeGpRuOZP3pjHvLB1Skva1W8s3Fhq0GzUohIS1mXTiUSqZOK
	XJto3QPl9hdkmHvBTx5UjmCU5Vl42FiVtRBF94w7NKDikefaemK/V9qYAEMa1HrGIud9QsziHTZ
	Umj3UBz3Sek6inYvveg4HjQpdEg8ZsJrIHl63VFpLK9FYrcfxG7mTJNUvnORHGULc6w/uTqp8oe
	YysaNLDhLVaYQW6hC1k9gGqiH0vV0zWdrhvLlT9quEKqt10zbISb53QKoJRVVIAvRHYWO3P
X-Google-Smtp-Source: AGHT+IFrvyPgdnBfM2yVd76EzvFkj1X9M98ZCJFUYBGuvPmu0QbWaoUGOhlmPQcIBGt8QD+cqRlvDvihssFhSkC8yCU=
X-Received: by 2002:a17:907:8e96:b0:b76:ece0:368e with SMTP id
 a640c23a62f3a-b7a247dc7d9mr986498766b.47.1765250095440; Mon, 08 Dec 2025
 19:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208131917.2444620-1-dolinux.peng@gmail.com>
 <20251208131917.2444620-2-dolinux.peng@gmail.com> <20251209094810.fb53ac6296656d361754d593@kernel.org>
 <CAErzpms+qYntOEqbRtvVah_khBTG_ObU6keJyz8zbD9rF8BRLQ@mail.gmail.com>
In-Reply-To: <CAErzpms+qYntOEqbRtvVah_khBTG_ObU6keJyz8zbD9rF8BRLQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 9 Dec 2025 11:14:43 +0800
X-Gm-Features: AQt7F2pErgThqvlLzUOI8RIaFiVQbetNakMVtJD6MW2iEFMAsuz22-JDlU7QNT4
Message-ID: <CAErzpmupfPU9AW-76Jw7qNc1McPOuC2d1vcJEyQBOxHNEt76sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fgraph: Use BTF to trim and filter return values
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>, 
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 9:42=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Tue, Dec 9, 2025 at 8:48=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
> >
> > On Mon,  8 Dec 2025 21:19:16 +0800
> > Donglin Peng <dolinux.peng@gmail.com> wrote:
> >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > The current funcgraph-retval implementation has two limitations:
> > >
> > > 1. It prints a return value even when the traced function returns voi=
d.
> > > 2. When the return type is narrower than a register, the printed valu=
e may
> > >    be incorrect because high bits can contain undefined data.
> > >
> > > Both issues are addressed by using BTF to obtain the precise return t=
ype
> > > of each traced function:
> > >
> > > - Return values are now printed only for functions whose return type =
is
> > >   not void.
> > > - The value is truncated to the actual width of the return type, ensu=
ring
> > >   correct representation.
> > >
> > > These changes make the funcgraph-retval output more accurate and remo=
ve
> > > noise from void functions.
> > >
> > > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > ---
> > >  kernel/trace/trace_functions_graph.c | 64 +++++++++++++++++++++++---=
--
> > >  1 file changed, 54 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trac=
e_functions_graph.c
> > > index 17c75cf2348e..9e63665c81e2 100644
> > > --- a/kernel/trace/trace_functions_graph.c
> > > +++ b/kernel/trace/trace_functions_graph.c
> > > @@ -15,6 +15,7 @@
> > >
> > >  #include "trace.h"
> > >  #include "trace_output.h"
> > > +#include "trace_btf.h"
> > >
> > >  /* When set, irq functions might be ignored */
> > >  static int ftrace_graph_skip_irqs;
> > > @@ -865,6 +866,46 @@ static void print_graph_retaddr(struct trace_seq=
 *s, struct fgraph_retaddr_ent_e
> > >
> > >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION=
_GRAPH_RETADDR)
> > >
> > > +static void trim_retval(unsigned long func, unsigned long *retval, b=
ool *print_retval)
> > > +{
> > > +     const struct btf_type *t;
> > > +     char name[KSYM_NAME_LEN];
> > > +     struct btf *btf;
> > > +     u32 v, msb;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > > +             return;
> > > +
> > > +     if (lookup_symbol_name(func, name))
> > > +             return;
> > > +
> > > +     t =3D btf_find_func_proto(name, &btf);
> > > +     if (IS_ERR_OR_NULL(t))
> > > +             return;
> > > +
> > > +     t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > > +     switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
> > > +     case BTF_KIND_UNKN:
> > > +             *print_retval =3D false;
> > > +             break;
> > > +     case BTF_KIND_ENUM:
> > > +     case BTF_KIND_ENUM64:
> > > +             msb =3D BITS_PER_BYTE * t->size - 1;
> > > +             *retval &=3D GENMASK(msb, 0);
> > > +             break;
> > > +     case BTF_KIND_INT:
> > > +             v =3D *(u32 *)(t + 1);
> > > +             if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL)
> > > +                     msb =3D 0;
> > > +             else
> > > +                     msb =3D BTF_INT_BITS(v) - 1;
> > > +             *retval &=3D GENMASK(msb, 0);
> > > +             break;
> > > +     default:
> > > +             break;
> > > +     }
> > > +}
> >
> > Hmm, I think we should have another flag which directly tells the print
> > format of retval from BTF.
>
> Thanks, I thought about it and the format flag could have the following v=
alues:
>
> 1. HEX - hexadecimal (%lx for pointers/unsigned)
> 2. DEC - decimal (%ld for signed/error_code)
> 3. BOOL - boolean strings ("true"/"false")
>
> WDYT?
>
> Thanks,
> Donglin
> >
> > > +
> > >  static void print_graph_retval(struct trace_seq *s, struct ftrace_gr=
aph_ent_entry *entry,
> > >                               struct ftrace_graph_ret *graph_ret, voi=
d *func,
> > >                               u32 opt_flags, u32 trace_flags, int arg=
s_size)
> > > @@ -884,17 +925,20 @@ static void print_graph_retval(struct trace_seq=
 *s, struct ftrace_graph_ent_entr
> > >       print_retaddr =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
> > >  #endif
> > >
> > > -     if (print_retval && retval && !hex_format) {
> > > -             /* Check if the return value matches the negative forma=
t */
> > > -             if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> > > -                     (((u64)retval) >> 32) =3D=3D 0) {
> > > -                     err_code =3D sign_extend64(retval, 31);
> > > -             } else {
> > > -                     err_code =3D retval;
> >
> > The original code just guesses the type (signed/unsigned) from
> > the retval, but we don't need to do that with BTF.

Sorry, I think the above guessing process is necessary to display an error
code. In most cases, the return type is int, but retval is of size
sizeof(unsigned long).
We should perform sign extension to check whether it represents an error co=
de.

Thanks,
Donglin

>
> Thanks. I will fix it in the next version.
>
> Thanks,
> Donglin
> >
> > Thank you,
> >
> > > +     if (print_retval) {
> > > +             trim_retval((unsigned long)func, &retval, &print_retval=
);
> > > +             if (print_retval && retval && !hex_format) {
> > > +                     /* Check if the return value matches the negati=
ve format */
> > > +                     if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(3=
1)) &&
> > > +                             (((u64)retval) >> 32) =3D=3D 0) {
> > > +                             err_code =3D sign_extend64(retval, 31);
> > > +                     } else {
> > > +                             err_code =3D retval;
> > > +                     }
> > > +
> > > +                     if (!IS_ERR_VALUE(err_code))
> > > +                             err_code =3D 0;
> > >               }
> > > -
> > > -             if (!IS_ERR_VALUE(err_code))
> > > -                     err_code =3D 0;
> > >       }
> > >
> > >       if (entry) {
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
