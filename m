Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739DC6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 19 Apr 2023 04:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjDSEFM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 19 Apr 2023 00:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjDSEFL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC57744BE
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681877068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRyVsg0+emwg1L/GAcLjuB7QTTlIQjgc6ihdDmPrBrE=;
        b=JXS8NnCixzAje9aNCWzJ/mf4xCBZzZbsAOLj5VViJpjUrGW3WwbJKTnUqe9+jT2n4nXbf3
        rg8h81FCjJEQlCBPtSMGq2ZmiWciFOZepb+8k4pmraT+HvtvQTxpRaDV0T24sMcAgmcxnC
        NVAJIs4+0k45NRX7EQy3aCFKPQyD2tQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153---o9Gjx9NCGjYsK6_hC8xw-1; Wed, 19 Apr 2023 00:04:27 -0400
X-MC-Unique: --o9Gjx9NCGjYsK6_hC8xw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-38e0523ba37so972392b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681877067; x=1684469067;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRyVsg0+emwg1L/GAcLjuB7QTTlIQjgc6ihdDmPrBrE=;
        b=FPhARWJyKor2mIEh+1rRlTgcsHVhuBkg+IbV1iULNXmN2lurULB129E6L+3OGowTzw
         rD7Fxdd3Vjjf+lPVbupccspDZRL49slJgW9bHgARW9T02CQ9YVsAnF2w1WiOTwS+B2XM
         G1wj9aEGnv3ZzWg0gZ7+ts0l+wphD7Fel/MaSHbriPJtJk26e5dpxUYVi1Ow9/rZkuVD
         xuSrxlpDfZ7Jt0Ztf3Tb1Y8kvJN0Q8MaGV2Sm5PoajBD/PRjkVLB0KKp8Ei9Tq3FUJMa
         OasEEFe2oa6OQ6xTZeDea8RF7u2HAqx9gyK8idCPrtdOD+nBhRlPRNhzu8KTF68DrCxo
         MMwQ==
X-Gm-Message-State: AAQBX9dnt9/ALwQX1gGblzbJk+wItST/E0g8P+Y+0fQKwYyidwePfKta
        9RsEM71W1tDDE74CbouPHPXlntMuAky7B367YScMi1Z3Gl60yybVz3zGd9aNqoYbHCW5K70Vtyv
        FWRLygQQSl1qU8i/I0I0sQctqZmwntlhi
X-Received: by 2002:a05:6808:1a22:b0:389:7d66:131a with SMTP id bk34-20020a0568081a2200b003897d66131amr2509631oib.0.1681877067053;
        Tue, 18 Apr 2023 21:04:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350bYkmNZB67LdtZJBLL2yN4fDR8tYIRf5rwlhYoTZWzZRTJRFh7g8xH4Cf01U3eVcEgiTSDr5w==
X-Received: by 2002:a05:6808:1a22:b0:389:7d66:131a with SMTP id bk34-20020a0568081a2200b003897d66131amr2509622oib.0.1681877066844;
        Tue, 18 Apr 2023 21:04:26 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c? ([2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c])
        by smtp.gmail.com with ESMTPSA id k188-20020aca3dc5000000b0037b6f5d6309sm6642173oia.2.2023.04.18.21.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:04:26 -0700 (PDT)
Message-ID: <637d8a822f130c63711169973a737273cffa5c3b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Date:   Wed, 19 Apr 2023 01:04:21 -0300
In-Reply-To: <20230406094947.6b92084c@gandalf.local.home>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406081501.pS4ZnWaK@linutronix.de>
         <cf8d18d80222c561da1865514734d92e0e2fb3d5.camel@redhat.com>
         <20230406094947.6b92084c@gandalf.local.home>
User-Agent: Evolution 3.46.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2023-04-06 at 09:49 -0400, Steven Rostedt wrote:
> On Thu, 06 Apr 2023 05:42:13 -0300
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
>=20
> > Hello Sebastian, thanks for the heads up!
> >=20
> > IIUC Valentin is adding/improving tracepoints that are collected in the
> > requesting CPU, at the moment of scheduling the IPI, which are also use=
ful.
> >=20
> > But on my scenario, would be nice to actually have the information on t=
he time
> > window in which the requested function is running in the requested CPU.=
=C2=A0
> >=20

Hello Steven,

>=20
> Well once you know the functions that are being called (running your test
> case with the IPI trace events), then you can get the timings of those sa=
me
> functions by:
>=20
>  # cd /sys/kernel/tracing
>  # echo '<space-delimited-list-of-functions>' > set_ftrace_filter
>  # echo function_graph > current_tracer
>=20
> Then the function graph will give you those timings.

IIUC, the use scenario of your suggestion would be something like:

1) Run something until we get a deadline miss in given CPU
2) Get the log -> Which functions were scheduled on that CPU in the last N =
time
3) Add those functions to the ftrace_filter
4) Run again until a deadline miss again

If that's correct, there are some points worth mentioning:
a) It requires getting the deadline miss again, which may take non-negligib=
le
time for reproducing, slowing the debug process. The suggested change would=
 get
the functions in the first run.
b) Where is no guarantee the next deadline time window will contain (only) =
those
functions. In case some are missing, we would need to add the new functions=
 and
run the test once more.
c) Those functions could be called outside of remote scheduling context, an=
d
would dirty our log.

>=20
> -- Steve
>=20

Thanks for reviewing and contributing, Steve!

Leo

