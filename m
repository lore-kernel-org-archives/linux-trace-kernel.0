Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D3BEB64D0
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 13 Jun 2023 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbjFMO5C (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbjFMO46 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:56:58 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1EE1713;
        Tue, 13 Jun 2023 07:56:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62de30780dfso9336446d6.3;
        Tue, 13 Jun 2023 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686668212; x=1689260212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhVGroCgc0u9hI1EagkjV3Nxh511ZVxUSQa0Z6i5YNM=;
        b=ocSDBQwvWW+KxB516ki+A7dQcj1twPn6BDgJ+Sx8I//9zXDEXWBnlJrtx/MsUMRI3G
         eAboW9n1PDRyMae0C41nNRB64kd3QHrDZ5uPqnNSpRmn3Rch86bJfpbY6LP+KnwlmPA2
         byWOFQYj59/XmHXQ92twcfizd+pjiBDruM7QE7UeDP42XwkgfpPk4GOtCrohzd1W9NFO
         m/1Bp0Bi2cMhMSln5ep5Rmw/iGD+It0a0fCpqXpsF9pDjWUscS6375uj1w69viAwmdVF
         HQ0d6mHRmYNAfU6xmeHpFIry8slj5+rgaTFExbwrGHpXrntVc4tpNEDWjmhbB9KIu5Ro
         gKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668212; x=1689260212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhVGroCgc0u9hI1EagkjV3Nxh511ZVxUSQa0Z6i5YNM=;
        b=CV5pbuDqKVeMr2V7gpiWdqezo3LzCsHIHie0yoMklsJVr+olIQ1jkulLJC/TYkWfXN
         KyCmRO7QL0UfR4296oRI4AYOxwpBq7kzS3GQdhc7yCEGd5oYpbh44mJPRirvpXxyT6yy
         lIkM5auPlrp+90koayMzkS1PVp/xIbC4q12rHpgfCf65SVIoBg7ZTip5ykhp1iHK6ux9
         04smyNTRqKm+q5ku3AhAPoeHKcRCBxv2H9l+FeoO2usxYOXMpgMQMfAAbYrnmyzJs17o
         8x277mufwK5M6oH7s0SEUbyndlClIIPDk3PqyLa7ib+fpFSosMgw3R9zNgzqU8PtiCCk
         o1Og==
X-Gm-Message-State: AC+VfDyoOydUs8flQc+Wread4KbM3KqGSxRl+/4g9zDz0yyWnrCK9WMw
        j66SB5tKdvo9h/m3KbaB78twMJsu6WB1LuJED/4=
X-Google-Smtp-Source: ACHHUZ7sS1ZQulLlbmOyT7GGzWZQmhUJxKz1Y/7ZT4BPtNqwuaNgVkja0p/2mtakaBpFQM1U36TI6KxnASfEgDYHmFI=
X-Received: by 2002:a05:6214:248e:b0:62d:f3f2:a53 with SMTP id
 gi14-20020a056214248e00b0062df3f20a53mr3773472qvb.35.1686668212169; Tue, 13
 Jun 2023 07:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-3-laoar.shao@gmail.com>
 <ffe856f4-9c25-2b6c-a508-bf474df39b7d@isovalent.com>
In-Reply-To: <ffe856f4-9c25-2b6c-a508-bf474df39b7d@isovalent.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 13 Jun 2023 22:56:13 +0800
Message-ID: <CALOAHbBOE36Bg64oo-DrNG2k6uZSyUnj3t60aQBUk4kw8ntbPg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/10] bpftool: Dump the kernel symbol's
 module name
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 9:41=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> > If the kernel symbol is in a module, we will dump the module name as
> > well.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
> >  tools/bpf/bpftool/xlated_dumper.h | 2 ++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlat=
ed_dumper.c
> > index da608e1..dd917f3 100644
> > --- a/tools/bpf/bpftool/xlated_dumper.c
> > +++ b/tools/bpf/bpftool/xlated_dumper.c
> > @@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
> >               }
> >               dd->sym_mapping =3D tmp;
> >               sym =3D &dd->sym_mapping[dd->sym_count];
> > -             if (sscanf(buff, "%p %*c %s", &address, sym->name) !=3D 2=
)
> > +
> > +             /* module is optional */
> > +             sym->module[0] =3D '\0';
> > +             if (sscanf(buff, "%p %*c %s %s", &address, sym->name,
> > +                 sym->module) < 2)
> >                       continue;
> >               sym->address =3D (unsigned long)address;
> >               if (!strcmp(sym->name, "__bpf_call_base")) {
> > diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlat=
ed_dumper.h
> > index 9a94637..5df8025 100644
> > --- a/tools/bpf/bpftool/xlated_dumper.h
> > +++ b/tools/bpf/bpftool/xlated_dumper.h
> > @@ -5,12 +5,14 @@
> >  #define __BPF_TOOL_XLATED_DUMPER_H
> >
> >  #define SYM_MAX_NAME 256
> > +#define MODULE_NAME_LEN      64
> >
> >  struct bpf_prog_linfo;
> >
> >  struct kernel_sym {
> >       unsigned long address;
> >       char name[SYM_MAX_NAME];
> > +     char module[MODULE_NAME_LEN];
>
> Nit: MODULE_MAX_NAME would be more consistent and would make more sense
> to me? And it would avoid confusion with MODULE_NAME_LEN from kernel,
> which doesn't have the same value.

Will use MODULE_MAX_NAME instead.

--=20
Regards
Yafang
