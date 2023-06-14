Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E56CC001B0
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Jun 2023 09:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbjFNJ2I (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 14 Jun 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbjFNJ2A (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A1DF
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686734839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XA4bJtbX8lGVNErXmlyMvuG2dmyejsrqojE7AOdIYt8=;
        b=dC7dMsvRgh2flMzruUnPa/QRLPuQXpHBapdX3+rEVTazZAEwxExtzALgN0Kj1VpyjMHsXB
        P07KdDSXKHDqwpHyZfYkbb9awYHrb/3xctz7rnSS/KRDcxQ9r1avt7H69M8RZOXyG9HpKB
        hDpvBr6Oi4UMRjxNcgBnpBqzcEpTfkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-vyePK-FeN-i6pVenAA4I6w-1; Wed, 14 Jun 2023 05:27:10 -0400
X-MC-Unique: vyePK-FeN-i6pVenAA4I6w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so2358165e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734829; x=1689326829;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA4bJtbX8lGVNErXmlyMvuG2dmyejsrqojE7AOdIYt8=;
        b=GK7w31DcYu+TaftL2U+DRejbLg69WlwsGzs9DalgCdJwKgxA6ywcpkkqShJJLDQ9PJ
         aqIdXj6voXU3vhlVit0l1LSIVf6RZcz162xiPieyJzLpgmylubrChUIUv5w2Qh+jLHDl
         anS2og43h2f1QmyStFlRaX4HHOyX0sQH9Uhe827XXQxsCdaqslectfh9Ij41JGKOPJvi
         9GaahIkbOo807Hl63MECkfdcEQYsbdC3teJqjQVTCECXfZD8nmXhvPd8EYgiQxNcAYjU
         wFAKWPZJCFJ55j1VB+fCuBL99S/HqWQPYyMCqujW36iOVrGfwbAoWnPODgCfXrvgE+XL
         6rEQ==
X-Gm-Message-State: AC+VfDy9fnNtP/UHL88Egu/Q5yEsPxme0aINCplpq4gdb7lYgA6/RkM6
        Kx3hONNok5A9UBSnL1eNMKQGZOZY2lrANh8G4TNHaf+fuUcM8d7r8OTFk2/wmWa4JqL/j0JgCJp
        AY04CMmF9ddJkqbitxPBdbK6rtr6nXMs3U1qwMu8C5YO47lWz6Y5/GBoQ4MedJr60dIf5BdTAgS
        hm025YjmVALV1BMLNW
X-Received: by 2002:a05:600c:881b:b0:3f7:408c:ad39 with SMTP id gy27-20020a05600c881b00b003f7408cad39mr890295wmb.14.1686734829314;
        Wed, 14 Jun 2023 02:27:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57gLxcK2TJrQrk+pqDItthTRyV3M0raBHWhZZfDu285V1WlTgB1ai1sMxtysg0YYQuJLH8Dg==
X-Received: by 2002:a05:600c:881b:b0:3f7:408c:ad39 with SMTP id gy27-20020a05600c881b00b003f7408cad39mr890268wmb.14.1686734828974;
        Wed, 14 Jun 2023 02:27:08 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f819faff25sm9574216wml.13.2023.06.14.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 02:27:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
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
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
In-Reply-To: <CAJ6HWG4sRHCTtkxe8G2csjBhJxeJZcO=cQ9Reb1cJrN2VA1nzg@mail.gmail.com>
References: <20230515183045.654199-1-leobras@redhat.com>
 <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
 <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
 <CAJ6HWG4sRHCTtkxe8G2csjBhJxeJZcO=cQ9Reb1cJrN2VA1nzg@mail.gmail.com>
Date:   Wed, 14 Jun 2023 10:27:07 +0100
Message-ID: <xhsmhcz1yxul0.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 14/06/23 02:16, Leonardo Bras Soares Passos wrote:
> On Wed, Jun 14, 2023 at 1:14=E2=80=AFAM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
>>
>> On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@red=
hat.com> wrote:
>> >
>> > On 15/05/23 15:30, Leonardo Bras wrote:
>> > > Changes since RFCv3:
>> > > - Split the patch in 2: entry/exit and queue
>> > > - Fix 'struct __call_single_data' & call_single_data_t alignment iss=
ue
>> > > - Made all TP_printk follow the same pattern
>> > >
>> >
>> > One bikeshedding nit I have is I'd prefer to see the csd_* events in a=
 csd
>> > trace system, to have a sane nomenclature.
>>
>> Oh, here you mean the file name? (ie: trace/events/smp.h -> trace/events=
/csd.h)
>
> Or just
> -#define TRACE_SYSTEM smp
> +#define TRACE_SYSTEM csd
> ?
>

At the very least this yes, and making the file name match that probably
wouldn't hurt.

