Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA928EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Jun 2023 05:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbjFNFR1 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 14 Jun 2023 01:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbjFNFRY (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9421A5
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686719795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcLO5Brc+F9RY3h/Vkhh4dPuhU1v5kJgJ/964zE6Pnw=;
        b=FL468Xu4pItE9mCVElOJdYdKTXSW6WDrRZehtjaCHGf3csnqjrcrDP2H7Z0bKFJeEA9jjr
        z32oeFeMM7/9iJqoQDchtk+F8ZHOdgh/kdVlV+Ttg6woyLexmwjirsdf2NEcXSmbjkROW+
        AAkhPJ/HuuVE6I6ALttwvcpl29Z1CkM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-WdsdPoVzMMWRaMnsITsrHg-1; Wed, 14 Jun 2023 01:16:33 -0400
X-MC-Unique: WdsdPoVzMMWRaMnsITsrHg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3fda1a83608so8831871cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686719793; x=1689311793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcLO5Brc+F9RY3h/Vkhh4dPuhU1v5kJgJ/964zE6Pnw=;
        b=Oa8rxfHlKnvOdJcOB3g1WQpn0tbp6AKp4dBIPQQSMrCDf/r6mRanRi1Twra7ayaszp
         eF6LVrislt5S9PaKxBREaJy/YT06p0ECC3tELs/OQSLyoRW4ej9xKLUvW6onn5AQJbyD
         3XY3kTFe74ZetgzTSM1xOO/F+LMC83rdtiEyEG49BEhkfmtDFMEYyQWwQ4AZHlDcwjz6
         FumQtxVYHT8GAP0LUFFzjyjFhodu0bl9FNKwzInOg4sB4AWy6G2GXOBs5uxOtqY5dKZj
         mqiGzjF1s3HMeI0GA1dOrlCjGdrTtzQswg8R8RewCjea0zVoNSzb3e/DczYK4qvGIJ5G
         H/BQ==
X-Gm-Message-State: AC+VfDxyXndneibqYf8uAXBUJk+26kveI94uzZ+KDmkUxajub2o0dPeP
        FrfPOik/ZmVk5FPnJlK9dEmY98Bvxn0nB5u6Ivj/qfOi4b06daOC+ngbh9Pk/grHN4NyrDGIa9R
        kL60o4lrdke7KKb89ZZOQCYu77GWr2cAIJHKIuvUO0oPCWwcX
X-Received: by 2002:a05:622a:19a0:b0:3f6:a92e:7f47 with SMTP id u32-20020a05622a19a000b003f6a92e7f47mr1172800qtc.13.1686719793419;
        Tue, 13 Jun 2023 22:16:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NYJjDE8hS3pJhq0es58Qm4gSXAfnpvHmwRDM0CuYvFfly4ak9JYLZs3X7Pycw+nqlEkLPoVMh8vlZjxBVWqY=
X-Received: by 2002:a05:622a:19a0:b0:3f6:a92e:7f47 with SMTP id
 u32-20020a05622a19a000b003f6a92e7f47mr1172789qtc.13.1686719793248; Tue, 13
 Jun 2023 22:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230515183045.654199-1-leobras@redhat.com> <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
 <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
In-Reply-To: <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 14 Jun 2023 02:16:22 -0300
Message-ID: <CAJ6HWG4sRHCTtkxe8G2csjBhJxeJZcO=cQ9Reb1cJrN2VA1nzg@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 1:14=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@redh=
at.com> wrote:
> >
> > On 15/05/23 15:30, Leonardo Bras wrote:
> > > Changes since RFCv3:
> > > - Split the patch in 2: entry/exit and queue
> > > - Fix 'struct __call_single_data' & call_single_data_t alignment issu=
e
> > > - Made all TP_printk follow the same pattern
> > >
> >
> > One bikeshedding nit I have is I'd prefer to see the csd_* events in a =
csd
> > trace system, to have a sane nomenclature.
>
> Oh, here you mean the file name? (ie: trace/events/smp.h -> trace/events/=
csd.h)

Or just
-#define TRACE_SYSTEM smp
+#define TRACE_SYSTEM csd
?

>
> >
> > Other than that and the other comment on csd_do_func(), this LGTM.
> >
>
> Thanks!
> Other than the above question, it should be fast for me to send a v5.
>
> Best regards,
> Leo
>
>
> > > Changes since RFCv2:
> > > - Fixed some spacing issues and trace calls
> > >
> > > Changes since RFCv1:
> > > - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneide=
r
> > > - Using EVENT_CLASS in order to avoid duplication
> > > - Introduced new helper: csd_do_func()
> > > - Name change from smp_call_function_* to csd_function_*
> > > - Rebased on top of torvalds/master
> > >
> > > Leonardo Bras (2):
> > >   trace,smp: Add tracepoints around remotelly called functions
> > >   trace,smp: Add tracepoints for scheduling remotelly called function=
s
> > >
> > >  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++=
++
> > >  kernel/smp.c               | 41 +++++++++++++---------
> > >  2 files changed, 96 insertions(+), 17 deletions(-)
> > >  create mode 100644 include/trace/events/smp.h
> > >
> > > --
> > > 2.40.1
> >

