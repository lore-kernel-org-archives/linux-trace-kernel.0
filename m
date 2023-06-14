Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A9EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Jun 2023 04:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbjFNEP6 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 14 Jun 2023 00:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbjFNEP5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63D91989
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686716109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/3CnkcXc0u2eW2baOnoD8oBslXn19GAj6CnKs1pujg=;
        b=R5IyUFyktjgEYNKBkZuicBb5bNIstrpKSispginE8IByEFN+h2tAAymXbsmEO//aZ6Dt5S
        myQ21T9vJ3L8WNKVRdvK8TefEoDodTPbVi0yWcf9o+CyXidKSsXglgcasHZJ49UWQIEHLe
        pVx4wgY7qzKz1/ckFEFs5tCp5ijQi1M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-7u6ndEaMPKK6pTERhi5csg-1; Wed, 14 Jun 2023 00:15:07 -0400
X-MC-Unique: 7u6ndEaMPKK6pTERhi5csg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f9e2f5a2b4so23655061cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686716107; x=1689308107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/3CnkcXc0u2eW2baOnoD8oBslXn19GAj6CnKs1pujg=;
        b=eVktNDrHbch89OkLuJw7eG5GuKmfPSGjsLRQhC/u5PxM2oTmaV9eAw2Lc/dgGnZ1II
         BhlQj/GvkwtSl+Lfu/KQLupw37cIvg4hQwtZ+0O+SRVHKCC4/8kEXv5ZOA93IRw4CBe8
         DAh7niegRZtSzTQ3CE0XeKQP1nvei4OqlqZZ3062geRzVHsGTMjXbvnmYghe6jE4cf8l
         rUOOU6skSxZLqZb4xCgXYFEzC3wVVxG+yUTCHmmp/DKu/gLxqH+OotEFGOD0bnmnbZX1
         zfdJ9+OEjaDSvlET6nrLyv3cGQ/Sber56YDJ42mnUlsKp29phw0M7TsVGYuEvOoJqVOD
         cUJA==
X-Gm-Message-State: AC+VfDy5/pmOShItHUUedOLIb1P9w5KDqGgLfV+TXg2buKG08hgj3Db1
        6Udjeb0YYJOsir4MzqdIfcu9iofx6OqAjQvkEvluXOjdvrCkIs131JDqFrwUMYEZqfTzNj/98Ql
        J2o0R3XzdWy1MKb1SOKifYoJcgwiUD5xT8RGIv5bhtkpaHWeb
X-Received: by 2002:a05:622a:184:b0:3f6:83f0:c579 with SMTP id s4-20020a05622a018400b003f683f0c579mr836395qtw.28.1686716106908;
        Tue, 13 Jun 2023 21:15:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xg+bDM6k9roUSMbzRBljPnpX9s6mPbIvwhitEscS1427CcaN7Z+WGj3AaOh+RUYwuqzNPSUksif4pc576QuE=
X-Received: by 2002:a05:622a:184:b0:3f6:83f0:c579 with SMTP id
 s4-20020a05622a018400b003f683f0c579mr836378qtw.28.1686716106730; Tue, 13 Jun
 2023 21:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230515183045.654199-1-leobras@redhat.com> <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 14 Jun 2023 01:14:55 -0300
Message-ID: <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 15/05/23 15:30, Leonardo Bras wrote:
> > Changes since RFCv3:
> > - Split the patch in 2: entry/exit and queue
> > - Fix 'struct __call_single_data' & call_single_data_t alignment issue
> > - Made all TP_printk follow the same pattern
> >
>
> One bikeshedding nit I have is I'd prefer to see the csd_* events in a cs=
d
> trace system, to have a sane nomenclature.

Oh, here you mean the file name? (ie: trace/events/smp.h -> trace/events/cs=
d.h)

>
> Other than that and the other comment on csd_do_func(), this LGTM.
>

Thanks!
Other than the above question, it should be fast for me to send a v5.

Best regards,
Leo


> > Changes since RFCv2:
> > - Fixed some spacing issues and trace calls
> >
> > Changes since RFCv1:
> > - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> > - Using EVENT_CLASS in order to avoid duplication
> > - Introduced new helper: csd_do_func()
> > - Name change from smp_call_function_* to csd_function_*
> > - Rebased on top of torvalds/master
> >
> > Leonardo Bras (2):
> >   trace,smp: Add tracepoints around remotelly called functions
> >   trace,smp: Add tracepoints for scheduling remotelly called functions
> >
> >  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
> >  kernel/smp.c               | 41 +++++++++++++---------
> >  2 files changed, 96 insertions(+), 17 deletions(-)
> >  create mode 100644 include/trace/events/smp.h
> >
> > --
> > 2.40.1
>

