Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3967C64ED8
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 27 Feb 2023 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjB0QuV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0QuU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:50:20 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FDC64F
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:50:19 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536cd8f6034so192285417b3.10
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZeTsz2LgmEqTFu2D1y6H+6n8BeVxT4dDCxIvwbJYZY=;
        b=jMbv2r0SjzyLfd/109qTg+Zt8ATsSAGsZlaSIpfCNwq5MIkuMOmLkPrv5s0SX2Niqc
         MW13m5uCGpMy+WActWyp/aBFjIsABYD7rOJZxYz+L8ev/at3VpEsOl1aSGD/fg9fAxua
         eJ06FHs9y2Gd2u2RJdup1zDKoxef+VlmA1id7W+V1aNeMurRTMCoKUeuxbOl/2FJMH+K
         69ocsLyGP1GZMP839JOIlS0Gn2tFsDBARF/ntfFuAjaNjJAF8gfgd+ru+qMGlRREUcd8
         PoQCRdH5cvAnSFFw/+0AoDeKZqRUsNif+iN7CSIiwJgxom+C+kB7bPml9a7g3HDM5xhG
         H+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZeTsz2LgmEqTFu2D1y6H+6n8BeVxT4dDCxIvwbJYZY=;
        b=uaaSFSxGXVDz23YAKfrbe2NYiqsDlxBG6Bzb5TY3x6Pf9w6lfoBnq2OFmdxZvzog6A
         XrbIric2ueBuUJHpBYmSs6PlBbLmvPB29ioAxWLkW8u6CeLI8sA1mJj30wSKKdhXpIhw
         c7X+UeHP/oVuzMIse6YTIF9ww6iefdIuvEXtTa4obd8gOU/+PIbLsnbp63PeJj/RYn0q
         kC1YI+2ZAfIUQjlCSILp4D0apUqoEsq8T6zfPRWp/VEbvQGYrL8ixNIN0iWjzU4X/K9I
         C97EZUVpmi0Bx0DcSmZyxFvNedXqjWs+0LQYvTk9zCW0Bh44JYLaWTdzsfyW/j/hFoQK
         5Wpw==
X-Gm-Message-State: AO0yUKX28a4l4Z1HhpDUpXI0azoPQcXxjojXmZHCy/6wBYj5bjifo9+v
        M8/col/A0teL9FqG3dRWKCN8gJRyd3bNiQS2nOHXpw==
X-Google-Smtp-Source: AK7set8lTXaiez4ACEuOb2wNkB4Dm/JTTL0C1kWWQrm108DPBrKq3P5Ta7PTFE2EKJWgLgv4skNklgr9Jbg7qnJNPeI=
X-Received: by 2002:a81:ae52:0:b0:536:155a:b73d with SMTP id
 g18-20020a81ae52000000b00536155ab73dmr10845609ywk.2.1677516618212; Mon, 27
 Feb 2023 08:50:18 -0800 (PST)
MIME-Version: 1.0
References: <202301301057.e55dad5b-oliver.sang@intel.com> <Y9dETROtv9Bld9TI@casper.infradead.org>
 <20230131052352.5qnqegzwmt7akk7t@google.com> <Y9iq8fRT4sDgIwQN@casper.infradead.org>
 <20230131055743.tsilxx5vfl6gx4dj@google.com> <CALvZod7TuaJ7pCc2nJKehwGkcuvsvjdL+4hs6qC3bZsOmGzXzg@mail.gmail.com>
 <d5d0bcf75cbaa2792a3ad0e7b15a84fd67e54454.camel@intel.com>
In-Reply-To: <d5d0bcf75cbaa2792a3ad0e7b15a84fd67e54454.camel@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 27 Feb 2023 08:50:07 -0800
Message-ID: <CALvZod7wP9n+cqJV4VN3YNnf6CPQ8PJZbkAgK=fv84D4Sk+Heg@mail.gmail.com>
Subject: Re: [linus:master] [mm] f1a7941243: unixbench.score -19.2% regression
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        lkp <lkp@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 10:35=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.co=
m> wrote:
>
> Hi Andrew, Shakeel,
>
> On Tue, 2023-01-31 at 10:26 -0800, Shakeel Butt wrote:
> > +per-cpu memory maintainers for FYI.
> >
> > Thread started at
> > https://lore.kernel.org/linux-mm/202301301057.e55dad5b-oliver.sang@inte=
l.com/
> >
> > On Mon, Jan 30, 2023 at 9:57 PM Shakeel Butt <shakeelb@google.com>
> > wrote:
> > >
> > [...]
> > > >
> > > > We could cut down the number of calls to pcpu_alloc() by a factor
> > > > of 4
> > > > by having a pcpu_alloc_bulk() that would allocate all four RSS
> > > > counters
> > > > at once.
> > > >
> > > > Just throwing out ideas ...
> > >
> > > Thanks, I will take a stab at pcpu_alloc_bulk() and will share the
> > > result tomorrow.
> > >
> >
> > OK, not a one day effort.
> >
> > Andrew, which option do you prefer?
> >
> > 1. Keep the patches as the test workload (fork ping pong) is not a
> > representative of real world workload and work on improving
> > pcpu_alloc() for 6.4+.
> >
> > 2. Revert the patches for now, improve pcpu_alloc() and re-introduce
> > the patches once we confirm that fork-ping-pong is not regressed
> > anymore.
> This performance regression still can be reproduced on latest master
> branch. So we took option1 here. Right? Thanks.
>

Yes unless some real workload reports regression.

Shakeel
