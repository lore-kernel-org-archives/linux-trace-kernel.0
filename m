Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D445CC77B75
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  3 May 2023 04:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjECEY0 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 3 May 2023 00:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjECEYZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C81FCF
        for <linux-trace-kernel@vger.kernel.org>; Tue,  2 May 2023 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683087817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orSkx/1be5MWUXjh1xr5ECEtOCT6SB/XNpXgwJD5H1Q=;
        b=ItqjLhLvhanrtW0GvQKWl6bHaVo8dOdnL5u1osYqaqnbyqOenUQHCX/C4G5ckMJ3AobWKo
        Xl8rGHRwDWr2/GFvV9Jcqyb95sim6cQyHOVDCYIjg+0U8KpVEggQnDAZdTNvfnlE1cxtOm
        wAeBnV+5t2MAN7JZBRR/QHDmPH7Egmo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-7Qo_hpjINTKvXQn7skPz5w-1; Wed, 03 May 2023 00:23:36 -0400
X-MC-Unique: 7Qo_hpjINTKvXQn7skPz5w-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6a5e616d5d3so3420055a34.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 May 2023 21:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683087816; x=1685679816;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orSkx/1be5MWUXjh1xr5ECEtOCT6SB/XNpXgwJD5H1Q=;
        b=TN/HDiFLHPmu+2xGZGn7CaS0EGhYKyhuOSG1FdbetUB3qUz+mVYgnlCc5oEltzWm5l
         YOXw6/ufU2k1dKWTIcCsnms3ikmTm+vEvYZR2Dt55et5s7WRnRY4WKuDrUvQq+MJiC/5
         q5uazRYc18M5iq/QkIzoAA9cf7/NHicO9nVOCE2yldhAu1S1ozQ09lSWGi1iU7Iohqs4
         KO42it3UEkSXrWIgLJdhvqX/F0rPbkbSScm7jqx+b9cXQ7jMmqbwvfjifQEpnQWDnZRx
         GIrNItEpLj2simGw8Js9sXGQSIuXKeM4/KgDZb4uiKjLQzOEy9xU1w35V2V0/PZH/YDc
         Q1Yg==
X-Gm-Message-State: AC+VfDxM6/dpltwu4jAtmigWEYorttEx2Iodyz+2gMmqZ6fzin9bMtRh
        67lX11lUOenTZmYGGO4jOLFYtnjDga5KLnD3d90NograD0vFHYjg/KRztwl+FnCp9gMkEco/Evv
        H8vAc42feJROrsTei819SGanWtbUQXRFI
X-Received: by 2002:a05:6871:3d6:b0:184:3f99:c982 with SMTP id a22-20020a05687103d600b001843f99c982mr10263753oag.20.1683087816241;
        Tue, 02 May 2023 21:23:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65O8KObLiZbBW/Kc9xGueUDr3zfhLQ7U/ZRakIOyacynsT02MgHQRoHcpfapsfUQYPofS0vw==
X-Received: by 2002:a05:6871:3d6:b0:184:3f99:c982 with SMTP id a22-20020a05687103d600b001843f99c982mr10263739oag.20.1683087815999;
        Tue, 02 May 2023 21:23:35 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:fb9f:720f:65e5:7914:9a9b? ([2804:1b3:a802:fb9f:720f:65e5:7914:9a9b])
        by smtp.gmail.com with ESMTPSA id l1-20020a4a4341000000b005421d52de9csm1792694ooj.45.2023.05.02.21.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 21:23:35 -0700 (PDT)
Message-ID: <aef178472265e86b89f2af2632b95b8cd1d2d321.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Date:   Wed, 03 May 2023 01:23:30 -0300
In-Reply-To: <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406095519.GG386572@hirez.programming.kicks-ass.net>
         <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
User-Agent: Evolution 3.46.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 2023-04-19 at 00:45 -0300, Leonardo Br=C3=A1s wrote:
> On Thu, 2023-04-06 at 11:55 +0200, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
> > > When running RT workloads in isolated CPUs, many cases of deadline mi=
sses
> > > are caused by remote CPU requests such as smp_call_function*().
> > >=20
> > > For those cases, having the names of those functions running around t=
he
> > > deadline miss moment could help finding a target for the next improve=
ments.
> > >=20
> > > Add tracepoints for acquiring the funtion name & argument before entr=
y and
> > > after exitting the called function.
> > >=20
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> >=20
> > How are the patches queued there not sufficient?
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dsm=
p/core


Hello Peter,=20

The trace I proposed will run in the CPU which received the request, not in=
 the
one which originated it. Meaning the trace will run in "cpu" from
smp_call_function*(cpu,...)

IIUC the trace introduced by the commits in tip/smp/core (which you pointed=
)
will run in the cpu which calls smp_call_function*(), which is different fr=
om
above.

Did I get it right?
Could you please help me understand how the commits in tip/smp/core are
sufficient for my scenario?

Thanks!
Leo



> >=20
>=20
> IIUC the last commits add tracepoints that are collected in the
> requesting CPU, at the moment of scheduling the IPI, which are also usefu=
l in
> some scenarios.
>=20
> On my scenario, it could help a little,=C2=A0since it makes possible to f=
ilter what
> all other cpus are scheduling on the requested cpu. OTOH it could be also=
 be
> misleading, as the requested cpu could be running something that was sche=
duled
> way before.
>=20
> The change I propose does exactly what my scenario need: track exactly wh=
ich
> function was running at given time in the requested CPU. With this info, =
we can
> check which (if any) remotely requested function was running on given tim=
e
> window.
>=20
> (An unrelated thing I just thought: We could even use the commits you poi=
nted
> together with my proposed change in order to measure how long does it tak=
e for a
> requested function to run / complete in the requested cpu)
>=20
> Thanks for reviewing!
>=20
> Leo

