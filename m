Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DCC6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 19 Apr 2023 03:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDSDqL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDSDqK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8DF5595
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681875915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YuuAJn1OCoUYnZzUOuo4+29qTgUEGG9kBKj+L9J4Ys=;
        b=BHtlGm+jdwxMegGyqx5IaJJN/5IKLXrpWbdDfGn1NIlsMBv5lx6KuOOOUxBtNX+/4K3FCf
        AwW+dPC7eFzz41U8HT0d/DwqhYyFzahQa/rpa9M2j6ElbHryDFMQZH0p5RK4F34/EzAE6j
        yRKWKR4Sf1k8H7y5b+nfJcFnFkfjWsM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-vbmeZGvDMFiY6eQtMitC-g-1; Tue, 18 Apr 2023 23:45:14 -0400
X-MC-Unique: vbmeZGvDMFiY6eQtMitC-g-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1878fb22699so521390fac.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681875914; x=1684467914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YuuAJn1OCoUYnZzUOuo4+29qTgUEGG9kBKj+L9J4Ys=;
        b=DZDWKLV5HVYdC9TT4dhTSIPEdtBisBk5eUN0Tl3mfNj9A6S7Ewwh9lFlSZM8T7LO0/
         lL7BvbLyMhokOVBwgerv+QjBE5W6KDcplWlpJCn50quRdePlR91eBTqKRGFVYomFLE8M
         JsjD9pFSUmRhpSHvBm914st/PEMgnnXLGMREgKu0hTUHAIDnSfIZThfqI5HFjKRagfeu
         j1GVrVIuBR3pTsH9DcZb8xM68JEE39bZUMvqmhZQ288o9ctV5zzK7TLlAJbjTsXSKs6R
         OvBkioxxVyobbz+9BoCg+PkTyvuUomwjjuUvoZ804esEQ8qdHylokrmOMcB9rnrIUnoD
         TIhA==
X-Gm-Message-State: AAQBX9cEVdWE7iDJyvA7iR91ZjKup7G5m5bw9B8DOASlDT+STB5E/UYE
        dSSsrIKFp9DbsS6Nojd/3mnGoufEVH5wgqsEPt0VWVQBSd4VNTde8stz+DAnJ3LeAwGT4SUcilF
        0wIz8G6lptC0C23yNgfr5Ymrzj7xK1g4r
X-Received: by 2002:a05:6870:a10e:b0:180:13a4:4256 with SMTP id m14-20020a056870a10e00b0018013a44256mr3219164oae.36.1681875913980;
        Tue, 18 Apr 2023 20:45:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zc/n0XS5LBqwVMuTKQ0TMzDYd+d6AXCJnHrNrZG1OgEaTKc8AHKb0V0BCzMHgpOmku1E/Azg==
X-Received: by 2002:a05:6870:a10e:b0:180:13a4:4256 with SMTP id m14-20020a056870a10e00b0018013a44256mr3219155oae.36.1681875913749;
        Tue, 18 Apr 2023 20:45:13 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c? ([2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c])
        by smtp.gmail.com with ESMTPSA id 26-20020aca101a000000b0038e34b0a0ecsm1249499oiq.8.2023.04.18.20.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:45:13 -0700 (PDT)
Message-ID: <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
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
Date:   Wed, 19 Apr 2023 00:45:08 -0300
In-Reply-To: <20230406095519.GG386572@hirez.programming.kicks-ass.net>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406095519.GG386572@hirez.programming.kicks-ass.net>
User-Agent: Evolution 3.46.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2023-04-06 at 11:55 +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
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
> How are the patches queued there not sufficient?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dsmp/=
core
>=20

IIUC the last commits add tracepoints that are collected in the
requesting CPU, at the moment of scheduling the IPI, which are also useful =
in
some scenarios.

On my scenario, it could help a little,=C2=A0since it makes possible to fil=
ter what
all other cpus are scheduling on the requested cpu. OTOH it could be also b=
e
misleading, as the requested cpu could be running something that was schedu=
led
way before.

The change I propose does exactly what my scenario need: track exactly whic=
h
function was running at given time in the requested CPU. With this info, we=
 can
check which (if any) remotely requested function was running on given time
window.

(An unrelated thing I just thought: We could even use the commits you point=
ed
together with my proposed change in order to measure how long does it take =
for a
requested function to run / complete in the requested cpu)

Thanks for reviewing!

Leo

