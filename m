Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF29EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 01:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGGBxb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 21:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGGBxa (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:53:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76CD19B7;
        Thu,  6 Jul 2023 18:53:29 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6378cec43ddso8790976d6.2;
        Thu, 06 Jul 2023 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688694809; x=1691286809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhYfiKKAyu4MadU/WX1P82AGfCr6L53Sij3ZmkQLwO8=;
        b=QQbyqt0Ud4FFN+iv/NSRwhIxdcQjs3vsIHFrKtJpF9ZnMjL/Jou1EsuOiy3c82I0Zb
         lqJhSBFu6IicwnPI+bL8GOD2o5Dc+f9Oyf/rWj08Vtrmeo9FnBL1l2WftrhEY4HFEKuB
         0i62Vc0x98YWoctyRCghjdrJdMzHYk7BtbpsHln3nUArskM/AUglJQfVMBtMCF3WegZC
         hp8ErhY5acCt2D4QNS9DckODdgU2JkA9C5xnN3sHzQlVtyzyYeov9W9CAj/pxqTDkvBL
         yvYqW+9/n/VW2ApZlM1iDktoEJgZQVgZ7rdkQ/x4WKulh8tefmY/HKs3bbCea5mFo+ZZ
         Fjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688694809; x=1691286809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhYfiKKAyu4MadU/WX1P82AGfCr6L53Sij3ZmkQLwO8=;
        b=a9VQPUvTmyjaxf0dip5V/pEGDn7hcD9HUU3TI+uZq7Rke4AJyCyTTs4vfWrNfiFDJj
         S1jDPWTFgLsuiJFemIsvLp8mzfDcKzBKRR0goJSCPejQNbjSD7b55cprCHwbp2GA29If
         CVc62x9XOTPmXItpjotDY/W8ltQKzJQ4yikrjwkfnLdjEsDsPRDy47uwZD2m9Q8hxzvf
         UeEGrqt1u+zS3MNRRrMTdl8mWuizPCPX9/Ggr1WFGzd4dVlbW6xUsSb9H8FFVIJzCAH4
         RDatX48KpGFYfhCR2YlznMEzbwrYkNECpTLGMYM4I0LRW4KUf71aRCDke7IJXCDWp8rD
         PKXA==
X-Gm-Message-State: ABy/qLZqs6xiKj3nRebpmQvcb6x2wQYZhyYfqoENER2Mm7eZXgwZ2UWy
        YQKm64mBgtGNFHXu6dmPn+CvFxI7mIjKAzOqzCo=
X-Google-Smtp-Source: APBJJlHqHT4ih9tuWs/9Zxr9APFTY4bWqr0JomaaRyTPDLqCKWFZVQ0pbS9QLeKDGKGAyJHK+xMlWUf/ywbV95lVLa4=
X-Received: by 2002:a0c:cc84:0:b0:62f:ff00:f8fa with SMTP id
 f4-20020a0ccc84000000b0062fff00f8famr3185208qvl.63.1688694808845; Thu, 06 Jul
 2023 18:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-2-laoar.shao@gmail.com>
 <CAEf4BzZzuPvyhUPnq8eGugRhCAbQVyQ7wfDDe4sUpUQa4cKFWw@mail.gmail.com>
In-Reply-To: <CAEf4BzZzuPvyhUPnq8eGugRhCAbQVyQ7wfDDe4sUpUQa4cKFWw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 7 Jul 2023 09:52:52 +0800
Message-ID: <CALOAHbDQsPZNbUOOa-8q6_WdpcazR-GXAvjwAwDc2Yj+55JAjA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 6:00=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 28, 2023 at 4:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > With the addition of support for fill_link_info to the kprobe_multi lin=
k,
> > users will gain the ability to inspect it conveniently using the
> > `bpftool link show`. This enhancement provides valuable information to =
the
> > user, including the count of probed functions and their respective
> > addresses. It's important to note that if the kptr_restrict setting is =
not
> > permitted, the probed address will not be exposed, ensuring security.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
>
> documentation nit, but otherwise LGTM
>
> Also, looking at other patch where you introduce bpf_copy_user(),
> seems like we return -ENOSPC when user-provided memory is not big
> enough. So let's change E2BIG in this patch to ENOSPC?

Sure. Will change it.

>
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for your review.

>
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  kernel/trace/bpf_trace.c       | 37 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 47 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 60a9d59beeab..512ba3ba2ed3 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6439,6 +6439,11 @@ struct bpf_link_info {
> >                         __s32 priority;
> >                         __u32 flags;
> >                 } netfilter;
> > +               struct {
> > +                       __aligned_u64 addrs; /* in/out: addresses buffe=
r ptr */
>
> addrs field itself is not modified, the memory it points to is
> modified, so it's not really in/out per se, it is just a pointer to
> memory where kernel stores output data

Thanks for the explanation. Will change it.

>
> > +                       __u32 count;
>
> but count field itself is in/out, so please add a comment explicitly
> stating this

Will do it.


--=20
Regards
Yafang
