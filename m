Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1EC7618D
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Apr 2023 08:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjDFInJ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjDFInG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED96C44B6
        for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680770539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y0tZmRfYIE91Jaer/04bl4Fm550S07hZzVbO64bi9Us=;
        b=ahudFrijpzbaob1Dt/s4Ixm00FJRlax0n5RAGdR12ua7YUDnY+JIyfemqJUFbUFYjftDtG
        C/tVMafcH7c32M7c7M9T2UchqSzQsIBuW3fAeq90Pe/ZWugrWgtG9vrwbdaoCmUSwj+nK0
        1N6xcSm/xDtW5+LZS54NPsNSSNKrhWY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-BBZZy-MgMre4lkLKfRXPKg-1; Thu, 06 Apr 2023 04:42:17 -0400
X-MC-Unique: BBZZy-MgMre4lkLKfRXPKg-1
Received: by mail-qk1-f200.google.com with SMTP id 72-20020a37064b000000b007467c5d3abeso17417823qkg.19
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770537;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldHV+XIGjqnKLgrogu4ymW/uHw5sLtMqia4m5Dy9/lk=;
        b=wCl0SndSpoEQp6Yk3dVdZNsFwOY0GG6QJgHJmtZBn48hEQ8bTLeJibsId2wTifRUNL
         dWvxkzV3faXqBsxW9h0KGxXYGxvBVK7q1FKlffE6AHPwnYjefKRSao0teVvScH3utZIv
         wFs6cFCt/exFHGnbyrYxQj74688Yc6ZBYLmMDSEOqGQzL8AY89me3K1fTE+8VjoJaxvg
         XlLmo1f98xKi2Pb/Zrb/8rQx6NKj143qLncY7f/+X5dgSSgcwyWQGqxlPYa/Kw+H0xvT
         vd3LFS97I3kr9i9AvpcPkrACbzVwfNvbwijqzbGtKRn5IRLZ7UDP+qvjXzmGRDu2nYfq
         1l5A==
X-Gm-Message-State: AAQBX9d++AHkGlxvayW6PR3r06u2Yr+9+7XIKGNVe4mAz3gd7FDJNQne
        +MvdeKUz41KVDvTuwWLXvLHzid2g5u627L3ZAqBj0VAGKtWSO38gP6u7mG+PkWAwBjcavo9e+Pm
        Vwbg0428X0q7KVIKgQS3XE/qskW6uyNay
X-Received: by 2002:a05:6214:4111:b0:571:f87:a665 with SMTP id kc17-20020a056214411100b005710f87a665mr3248307qvb.35.1680770536945;
        Thu, 06 Apr 2023 01:42:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350aLUmUZ/m5d7fNwMka9R8oM9oBZuuaGHKpjQzidpRVrnIQl2yfS9DGazmn9qXNJnGVWsuG2Og==
X-Received: by 2002:a05:6214:4111:b0:571:f87:a665 with SMTP id kc17-20020a056214411100b005710f87a665mr3248293qvb.35.1680770536691;
        Thu, 06 Apr 2023 01:42:16 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:2599:3b52:5a:179c:6ae7? ([2804:1b3:a802:2599:3b52:5a:179c:6ae7])
        by smtp.gmail.com with ESMTPSA id dj3-20020a056214090300b005e0d14cf0f6sm347503qvb.124.2023.04.06.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:42:16 -0700 (PDT)
Message-ID: <cf8d18d80222c561da1865514734d92e0e2fb3d5.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Date:   Thu, 06 Apr 2023 05:42:13 -0300
In-Reply-To: <20230406081501.pS4ZnWaK@linutronix.de>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406081501.pS4ZnWaK@linutronix.de>
User-Agent: Evolution 3.46.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2023-04-06 at 10:15 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-04-06 04:57:18 [-0300], Leonardo Bras wrote:
> > When running RT workloads in isolated CPUs, many cases of deadline miss=
es
> > are caused by remote CPU requests such as smp_call_function*().
> >=20
> > For those cases, having the names of those functions running around the
> > deadline miss moment could help finding a target for the next improveme=
nts.
> >=20
> > Add tracepoints for acquiring the funtion name & argument before entry =
and
> > after exitting the called function.
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>=20
> Check
> =09https://lore.kernel.org/20230307143558.294354-1-vschneid@redhat.com
>=20
> Sebastian
>=20

Hello Sebastian, thanks for the heads up!

IIUC Valentin is adding/improving tracepoints that are collected in the
requesting CPU, at the moment of scheduling the IPI, which are also useful.

But on my scenario, would be nice to actually have the information on the t=
ime
window in which the requested function is running in the requested CPU.=C2=
=A0

This would allow us to check how many and which IPIs took too much time to
complete, and caused the RT deadline to miss.=20

(I noticed there is an include/trace/events/ipi.h that could be used instea=
d of
creating a new include/trace/events/smp.h, what is your opinion on this ? )

Please let me know if I am missing something.

Thank you!
Leo

=20

