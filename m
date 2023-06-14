Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356A8EB64D8
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Jun 2023 04:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjFNELK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 14 Jun 2023 00:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjFNELJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36C19B6
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686715822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apBkNGMEYE+N3GwoyYOeikY/4uKgz9iLGzWWWnCUdRs=;
        b=PjA5W1FftvO5apfRiJVmVGNd2ghB7zz2M2HWQcYQ3hTOSGIZAib+X8hgp/wimm9c7v+1y6
        od0eoyMNb5i2GuuFgZNiFbBeFO+IG+VqJPlmZG50gkMkoD61ChSjWw3C+NMnnok/sdgbiJ
        pyBrQSUPM4RfWmRJ+9p6jclfAcJKR60=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-RnHm_OxVMdmp7S16-yanIA-1; Wed, 14 Jun 2023 00:10:19 -0400
X-MC-Unique: RnHm_OxVMdmp7S16-yanIA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75d4fb030a8so220480685a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686715819; x=1689307819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apBkNGMEYE+N3GwoyYOeikY/4uKgz9iLGzWWWnCUdRs=;
        b=MF6kplx7cfTFdF5vNDses3xQd2s4zLd9CLbUL1ijoqAewV9EvmoGkW+QUmdwiJBRLF
         XA2qW20wvLBOBnr3e0VZgEk8PKmGzLfpg9ZovFKTbLW8+IGcX1KiKe+72kAcUwOwYVIS
         N9Xn9uC+5vHwJWWEdonl0cMSJO2RkmyQQWKIKBEXqfcIuZMVs5MVuITv0ShpyNg9f05G
         WFwislswh8oLJVmEumEAg6jqzA+GZQttaPyMIDBa5vYVu6XJC5jOAZPVOdFuMsKaE2QU
         TqZmqqKyZklTE1K8efyxRvMuYINVH8ZD8yjjUkmLZJbG2lWOQYRBXzIuT6COKgI2ewK7
         is+Q==
X-Gm-Message-State: AC+VfDzAy+Cz3DwGHvj9YiQqoYRJcWIrjOKiJb4/if++0Ec57N06FqCQ
        +J1nbXO8kVGgiRTi6kJuKVi2H+fGfV8LASRh+IEdKYMdruukB2FItXjxKymW5dYL8T1wlz6LJqN
        ih+Ymh0HZ/gM+WamqEt+cFw3q7Ch1ApnXYissFtdnTzdz/ThC
X-Received: by 2002:a05:622a:130e:b0:3f8:6eaa:dcce with SMTP id v14-20020a05622a130e00b003f86eaadccemr1040073qtk.27.1686715819024;
        Tue, 13 Jun 2023 21:10:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sRQ8XUksUCnGvFQNbEecZBTDO2TVo8cHS+eoF0AFJEddvKBtc5OUH1TSB1de8EDJyszhrISLyLKeiWdmwefY=
X-Received: by 2002:a05:622a:130e:b0:3f8:6eaa:dcce with SMTP id
 v14-20020a05622a130e00b003f86eaadccemr1040063qtk.27.1686715818834; Tue, 13
 Jun 2023 21:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230515183045.654199-1-leobras@redhat.com> <20230515183045.654199-2-leobras@redhat.com>
 <xhsmh353ep0m7.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmh353ep0m7.mognet@vschneid.remote.csb>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 14 Jun 2023 01:10:08 -0300
Message-ID: <CAJ6HWG6x4WgLtr3RGNar4jFoccD4bCocid-_WzSFofDRP8+2gA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] trace,smp: Add tracepoints around remotelly
 called functions
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

Hello Valentin, thanks for the feedback!

On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 15/05/23 15:30, Leonardo Bras wrote:
> > @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, call_single=
_data_t *csd)
> >               csd_lock_record(csd);
> >               csd_unlock(csd);
> >               local_irq_save(flags);
> > -             func(info);
> > +             csd_do_func(func, info, csd);
>
> I'd suggest making this match the local case of
> smp_call_function_many_cond(), IOW pass NULL as the csd when executing
> locally.

Sure, done!

>
> IMO this is required for postprocessing with e.g. synthetic events for CS=
D
> delivery measurement, otherwise we'll try to match this execution with a
> previous CSD enqueue.
>
> >               csd_lock_record(NULL);
> >               local_irq_restore(flags);
> >               return 0;
>

