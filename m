Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5CB2FF641
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244539; cv=none; b=FuSbfvfpd+Pu7IsbepTg6B4fjz9He/JyxR7Ux14w3SDpdE0LA1R26XUx+WOrwrFnWAYPnz7yF+T+6QTT/KzPeHjvsP9ydXBmfxJEYsIOe03IIRC9GNpBVzfpxe7AZ0UxZEnv9zXuYhxkrnTn3gcB8EKVL0Am+cRUYs64JAQQUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244539; c=relaxed/simple;
	bh=9dUQ9xqYlglE5vy75Gv43QlPG39jRsPTIzxo+1Bs7zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X63MwyizLIYG01H3AsJRCFz5rO2gFbeVXIDGWBvXdUgv2TbbW/xZnkyx0PLidU6SAtI0S437+Gp5/jNI238yJmo5yJDZFZhzMhKZ5pLgA1uCmcKkIbPQBvcdRokJy7V9NmLcwgqeg4H0poOfyIRZYF9MYJZiI0ALxMW3zuzHGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTi1H1ev; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTi1H1ev"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so729778866b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Dec 2025 17:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765244534; x=1765849334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daL4xtrrMvul9Iz4S+G2unKptSJMQ+v804tsgO2Pvf4=;
        b=KTi1H1evxMHdI9xSxtuVmlZ0TO8L/IK5t+98byJHSMD0tEhNgHjD6vtM1hn+86fWuO
         tNoMoAuxMjq5iM/nJsQrEdgGEYBuiwtQurOZzK6jLZ3NyN0ERLJpDmbaWtBbgs2MnzC8
         p/abcfk1Ui6YN5Cdq2hSbRFWd1Y6MzEp2cIdxqqUSCG4yae50/GGlErYdz/hN8b+v1nN
         3uRwtfuf/6MHW7/1UyO9x017mEcrxC73tg16Wyxhnb26FtLTBDS4JaUkr5Ks5dgVmOgp
         ngekK7Id4kkmXXe3l0wXbrTjI6hDjoeHXzsLMqO+fjoY1riZRI3j8ZEB1Onka/y19tul
         SUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765244534; x=1765849334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=daL4xtrrMvul9Iz4S+G2unKptSJMQ+v804tsgO2Pvf4=;
        b=ipi3BFFOTddGBn8WURBIb4k+t10D2ELuugE5xfvAbibV7Kec0WKKd04AtaV5rO9NSB
         V+4rIeSnBmqSiKAgURGzeccwxkA+chCaxt9dKboWOFceDEnp9BZ/jq6WlGkI7LqU/B2H
         /RZgQD6nmRNo3kflK+xoQ1RiTMgBjtjBcb21PtmAqCZtOHA4y/RAnM4QaEU7rr92JAWp
         cBkY4Ghl68YDheDBKk33Q6Koi7P6zULNgezfhNouD1EtofeljMiD70n86mnoeEFOLfcO
         /h/PHlr10RYRBODZCjZqKI7leOhs6RuV1QnKR7zinUvl49dHxZfLfsPmDZXSn1BXyEl6
         wQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrMbekSyblVIdleb4HfQvPC7ZTByorH3gaPMzvoX5v6I9+n3oxfDZD2j7s9tC67WAgdz650Oimh4A4OEHjjaFuEmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcxix0pVJSPomOK2hGinecY2duil8bvHFQQNmbedSX9gdNDcDn
	6CpJmpmHtw5CR+G2XT1KlzAU7oMxM5Lz8RA+1Sdapf3i5LOsMlbUmokWHI7rnuk28308yU/GqNR
	X6CWqnwsIOK4lPkub9n8Pg+IDJj/X7S4=
X-Gm-Gg: ASbGncsA63AL2eS6IhZknU43nwsh4I/zMNgzhRpbB+NzCXF9oAaXcgScbvZveBL8JDK
	Miv+MiVewjOykC5s62odlQzcJNb589d9NTlvbgJ9wbB1vOV+rX0prdUUDLtC/APRte66+RKGkSb
	tl4I6Ew2QYs5v3dGnE01d7WFvtSRyByPhXCt2xLa1D8o6zqTEoTcma0CzrjTWVbCqoPbdIaZTgK
	9/UFYu6rgXz/+4ge/DOP3cQJd3BDe1TlEBRSGGSnCie7h1JgteLJyPiLyPVUEJzlse4FSvA
X-Google-Smtp-Source: AGHT+IGXTSsvJBWFKO6HPjUz3Isl8zqnIyOGAK7FXlARIRavfW/oXZ19vJlDnZKgBsRRGafCFWIkQFnbln4Cn+PcEC4=
X-Received: by 2002:a17:907:608c:b0:b6c:38d9:6935 with SMTP id
 a640c23a62f3a-b7a242c07e4mr1058918166b.24.1765244533707; Mon, 08 Dec 2025
 17:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208131917.2444620-1-dolinux.peng@gmail.com>
 <20251208131917.2444620-2-dolinux.peng@gmail.com> <20251209094810.fb53ac6296656d361754d593@kernel.org>
In-Reply-To: <20251209094810.fb53ac6296656d361754d593@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 9 Dec 2025 09:42:02 +0800
X-Gm-Features: AQt7F2rlXgYrN5P94S2fweTMYp5oSDV19L3QXzFXxFYoxMyPd6bOPzLMpkTWKAE
Message-ID: <CAErzpms+qYntOEqbRtvVah_khBTG_ObU6keJyz8zbD9rF8BRLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fgraph: Use BTF to trim and filter return values
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>, 
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 8:48=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon,  8 Dec 2025 21:19:16 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > The current funcgraph-retval implementation has two limitations:
> >
> > 1. It prints a return value even when the traced function returns void.
> > 2. When the return type is narrower than a register, the printed value =
may
> >    be incorrect because high bits can contain undefined data.
> >
> > Both issues are addressed by using BTF to obtain the precise return typ=
e
> > of each traced function:
> >
> > - Return values are now printed only for functions whose return type is
> >   not void.
> > - The value is truncated to the actual width of the return type, ensuri=
ng
> >   correct representation.
> >
> > These changes make the funcgraph-retval output more accurate and remove
> > noise from void functions.
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  kernel/trace/trace_functions_graph.c | 64 +++++++++++++++++++++++-----
> >  1 file changed, 54 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_=
functions_graph.c
> > index 17c75cf2348e..9e63665c81e2 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -15,6 +15,7 @@
> >
> >  #include "trace.h"
> >  #include "trace_output.h"
> > +#include "trace_btf.h"
> >
> >  /* When set, irq functions might be ignored */
> >  static int ftrace_graph_skip_irqs;
> > @@ -865,6 +866,46 @@ static void print_graph_retaddr(struct trace_seq *=
s, struct fgraph_retaddr_ent_e
> >
> >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_G=
RAPH_RETADDR)
> >
> > +static void trim_retval(unsigned long func, unsigned long *retval, boo=
l *print_retval)
> > +{
> > +     const struct btf_type *t;
> > +     char name[KSYM_NAME_LEN];
> > +     struct btf *btf;
> > +     u32 v, msb;
> > +
> > +     if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > +             return;
> > +
> > +     if (lookup_symbol_name(func, name))
> > +             return;
> > +
> > +     t =3D btf_find_func_proto(name, &btf);
> > +     if (IS_ERR_OR_NULL(t))
> > +             return;
> > +
> > +     t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > +     switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
> > +     case BTF_KIND_UNKN:
> > +             *print_retval =3D false;
> > +             break;
> > +     case BTF_KIND_ENUM:
> > +     case BTF_KIND_ENUM64:
> > +             msb =3D BITS_PER_BYTE * t->size - 1;
> > +             *retval &=3D GENMASK(msb, 0);
> > +             break;
> > +     case BTF_KIND_INT:
> > +             v =3D *(u32 *)(t + 1);
> > +             if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL)
> > +                     msb =3D 0;
> > +             else
> > +                     msb =3D BTF_INT_BITS(v) - 1;
> > +             *retval &=3D GENMASK(msb, 0);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +}
>
> Hmm, I think we should have another flag which directly tells the print
> format of retval from BTF.

Thanks, I thought about it and the format flag could have the following val=
ues:

1. HEX - hexadecimal (%lx for pointers/unsigned)
2. DEC - decimal (%ld for signed/error_code)
3. BOOL - boolean strings ("true"/"false")

WDYT?

Thanks,
Donglin
>
> > +
> >  static void print_graph_retval(struct trace_seq *s, struct ftrace_grap=
h_ent_entry *entry,
> >                               struct ftrace_graph_ret *graph_ret, void =
*func,
> >                               u32 opt_flags, u32 trace_flags, int args_=
size)
> > @@ -884,17 +925,20 @@ static void print_graph_retval(struct trace_seq *=
s, struct ftrace_graph_ent_entr
> >       print_retaddr =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
> >  #endif
> >
> > -     if (print_retval && retval && !hex_format) {
> > -             /* Check if the return value matches the negative format =
*/
> > -             if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> > -                     (((u64)retval) >> 32) =3D=3D 0) {
> > -                     err_code =3D sign_extend64(retval, 31);
> > -             } else {
> > -                     err_code =3D retval;
>
> The original code just guesses the type (signed/unsigned) from
> the retval, but we don't need to do that with BTF.

Thanks. I will fix it in the next version.

Thanks,
Donglin
>
> Thank you,
>
> > +     if (print_retval) {
> > +             trim_retval((unsigned long)func, &retval, &print_retval);
> > +             if (print_retval && retval && !hex_format) {
> > +                     /* Check if the return value matches the negative=
 format */
> > +                     if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)=
) &&
> > +                             (((u64)retval) >> 32) =3D=3D 0) {
> > +                             err_code =3D sign_extend64(retval, 31);
> > +                     } else {
> > +                             err_code =3D retval;
> > +                     }
> > +
> > +                     if (!IS_ERR_VALUE(err_code))
> > +                             err_code =3D 0;
> >               }
> > -
> > -             if (!IS_ERR_VALUE(err_code))
> > -                     err_code =3D 0;
> >       }
> >
> >       if (entry) {
> > --
> > 2.34.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
