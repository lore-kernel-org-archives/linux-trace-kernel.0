Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BBAC77B7C
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  1 May 2023 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEAWay (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 1 May 2023 18:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEAWax (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:30:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656432123
        for <linux-trace-kernel@vger.kernel.org>; Mon,  1 May 2023 15:30:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf70676b6so11338605ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 May 2023 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682980251; x=1685572251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0vZEv/FmAjqR4OATKlbblWETdmbuJQmkbVqTAuStBc=;
        b=WKCw2ix+6dihGEpad4r0eJJquJbzoo5nOCEgYNWxUUgvKaWldmAbDrEooWLrv4sGrc
         bbwT4R5ad+zKhAmSVBsWmdHi7UocjItrB9hXDbZjunjUTj+USPCHEyOvk88S0hg/xy3l
         z6ktRPkV+XY1lcchAYB7O5M/0adGmD2EZi2887oEvtsiI5q1/IWXJNQe/6V4gJ3CMmuR
         77uDaZnsR+JTqwUlJNbuH1GqqspvBSVQnbZThyGMsA/OGdXOXB6VL3gk/U3023ElAC4B
         tYFjIC953WZT77XYoqzN+pGHgYTneqWQ33jA7XS8g5eaMGJx3orsHepBNokbNkU6YSwi
         WvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980251; x=1685572251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0vZEv/FmAjqR4OATKlbblWETdmbuJQmkbVqTAuStBc=;
        b=hTuylslseknh44vhXnizYYrLOdozcvCRz6bmizohaW+tSmodS713dilYrIyHTXPAU9
         PwZQkmUxBrpV9GtwjvCKuJN8BK5G28Eo5N23LYJ6f42nNtLW8hErj0WRLeDp3qYvgHCE
         M1eTflCNjlUTs77zMOtZKQXkYHbaJWyJ/8IHww2n9IzQZc6FSBZmIEvFiYPlb8mHmB3Z
         qAyMWnDC1w9cHeIIEiih+mTggU9b/D5nyBoTDgXk6Rk1KOVc2JTx0D0KoQ0836YaJpE1
         wcLEc24yyatKpYGPEWFqp8zbH7AkqKh7/EEzB6RnmfrpDag68A/NLKYqKmJi6P1Vd6w/
         Uf5w==
X-Gm-Message-State: AC+VfDzDD4fJVBUWbc1PX7v5IxulW4/mWmjHhpSC4I1SyCkkBs2T127Q
        lE6gQc+gqTx8GldL4hETZZs2RN9aty/pkOriPStOCA==
X-Google-Smtp-Source: ACHHUZ7jIPANuM1sqTIbuiAlms9FW/dcjpUfPf8qR/hIGsTZHUlWNVU5LIbFTwoJV+QoEkulsThBRTy4qagbvX+vERw=
X-Received: by 2002:a17:902:e744:b0:1a6:b23c:3bf2 with SMTP id
 p4-20020a170902e74400b001a6b23c3bf2mr18550422plf.10.1682980250619; Mon, 01
 May 2023 15:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
In-Reply-To: <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 May 2023 15:30:38 -0700
Message-ID: <CAKwvOdkgwHcZKndei2NcMn+Z8y1HjKCUpMxnNCbcCGm9EB-o0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Peter Collingbourne <pcc@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, May 1, 2023 at 3:02=E2=80=AFPM Peter Collingbourne <pcc@google.com>=
 wrote:
>
> On Thu, Feb 23, 2023 at 10:45=E2=80=AFPM Peter Collingbourne <pcc@google.=
com> wrote:
> >
> > On Wed, Feb 15, 2023 at 11:33 AM Steven Rostedt <rostedt@goodmis.org> w=
rote:
> > >
> > > On Wed, 15 Feb 2023 09:57:40 +0100
> > > Marco Elver <elver@google.com> wrote:
> > >
> > > > Yes, you are right, and it's something I've wondered how to do bett=
er
> > > > as well. Let's try to consult tracing maintainers on what the right
> > > > approach is.
> > >
> > > I have to go and revisit the config options for CONFIG_FTRACE and
> > > CONFIG_TRACING, as they were added when this all started (back in
> > > 2008), and the naming was rather all misnomers back then.
> > >
> > > "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> > > really should just be for the function tracing infrastructure, and
> > > perhaps not even include trace events :-/ But at the time it was
> > > created, it was for all the "tracers" (this was added before trace
> > > events).
> >
> > It would be great to see this cleaned up. I found this aspect of how
> > tracing works rather confusing.
> >
> > So do you think it makes sense for the KASAN tests to "select TRACING"
> > for now if the code depends on the trace event infrastructure?
>
> Any thoughts? It looks like someone else got tripped up by this:
> https://reviews.llvm.org/D144057

https://reviews.llvm.org/D144057#4311029
Peter, please triple check.
--=20
Thanks,
~Nick Desaulniers
