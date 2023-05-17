Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8528AC77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 00:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjEQA4Z (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 16 May 2023 20:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEQA4Y (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:56:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFB10F
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 17:56:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-966287b0f72so19995466b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 17:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684284981; x=1686876981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u19sBi6Gx4oX3ZUtePL5RNvvMU7eDU7T5lpZ8DtlLqE=;
        b=Dhs7nVF3izFamLJjTGR0ZbHI69tmrp8fOuQLZ+L32hSWy9TF1Wb24kF8i4CeEss1xd
         XnziBMBnlhUWthABZmZTo9HFNU2wPWeouyZ2yy+6S8MC++vO997RWeJXzBBAvFww0BGu
         G9/w6HJVRLBmP9xw02fSczkRTKCHQM//F2nYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684284981; x=1686876981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u19sBi6Gx4oX3ZUtePL5RNvvMU7eDU7T5lpZ8DtlLqE=;
        b=lNPM+kMvEXEpTRBjMb3C+QXFjv1vCTblYLy833o3A6Hc1tLhO1Mn5vW7ld1wI7MxVE
         AzPbqcQK9IqZBxbPpIV7RPEk7xzDHQDJtxZ8/OgG5moCQA8i6bYh21xFLb4vgqtX+e3W
         vzjDH4BBHtGubZs45JfcuD8PMkU6pd4A4NJPdPX89O5Ck59p3p1Pjezc7NDeyAPAD6O9
         D/22aOaTyd5b67bTY257NIl8pvPxce+DDb4njTxq8FV4aZ3S0lEt9xWWv0drKnkOVoJX
         BpNC+DiJ2VRKHuz7JmSrYPwxisykVW4F1b6oAuBpbYaw9PaUkrNPNgsA0oeevaZW9LLB
         3jSA==
X-Gm-Message-State: AC+VfDwHlndliSukudyrt/q2A+fpJIloKSI+/YOyPhXi4lTDxCQ986gX
        fBXRKGwM371uhpH7E6irXRfOa7rHtMgw4Cnfl0iTIg==
X-Google-Smtp-Source: ACHHUZ66ALToknXiY9aaLAZFsjFyYpBDsmUDexAAOXj4YLDXUBXXNB7KgGSY2JS0Me5iPsAhqtffeA==
X-Received: by 2002:a17:907:25c1:b0:965:819b:1e73 with SMTP id ae1-20020a17090725c100b00965819b1e73mr34104812ejc.59.1684284981066;
        Tue, 16 May 2023 17:56:21 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906070d00b0093313f4fc3csm11564998ejb.70.2023.05.16.17.56.19
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:56:19 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-965a68abfd4so17660566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 17:56:19 -0700 (PDT)
X-Received: by 2002:a17:907:3e13:b0:948:b9ea:3302 with SMTP id
 hp19-20020a1709073e1300b00948b9ea3302mr44683119ejc.1.1684284979144; Tue, 16
 May 2023 17:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
In-Reply-To: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 17:56:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
Message-ID: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 15, 2023 at 12:24:07PM -0700, Beau Belgrave wrote:
> > > >
> > > >   ret =3D pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL=
_NOFAULT,
> > > >                               &page, NULL, NULL);
> > >
> > > ... which will call pin_user_pages_remote() in RCU CS.
> > > This looks buggy, since pin_user_pages_remote() may schedule.
> > >
> >
> > If it's possible to schedule, I can change this to cache the probe
> > callbacks under RCU then drop it. However, when would
> > pin_user_pages_remote() schedule with FOLL_NOFAULT?
>
> Are you saying that passing FOLL_NOFAULT makes it work in atomic context?

Absolutely not.

It may not fault missing pages in, but that does *not* make it atomic.

That code depends on all the usual MM locking, and it does not work at
all in the same way that "pagefault_disable()" does, for example. That
will fail on any fault and never take locks, and is designed to work
in atomic contexts. Very different.

So no, don't think you can call pin_user_pages_remote() or any other
GUP function from atomic context.

We do have "get_user_page[s]_fast_only()" and that is the only version
of GUP that is actually lock-free.

Also, just FYI, those special gup_user*fast_only()" functions simply
will not work on some architectures at all.

               Linus
