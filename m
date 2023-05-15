Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA420C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 15 May 2023 18:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEOSsr (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 15 May 2023 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEOSsq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C6F14353
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684176478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hqIAn873QsCpWU5fVaK4Ln/oVmQG1LGyWmBLtBWvnQ=;
        b=JXGuyn3igdllzMj7q4SiYv66Ec1X17VtxIQgksc8ejf7YvJ7KZkfnD3RmXzvNGAsZ1kTf0
        IkD7BJ9lj6wP2igymf36rxicdXpNYSizhLRfp0esacRFPmNhAAjlLCwu64mxWqQDcoD+15
        MZPzpcmtiuaH1s/AqgdB2JWDe2QBZrc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-2XFTkKgHNdWlYeV35qEZyA-1; Mon, 15 May 2023 14:47:57 -0400
X-MC-Unique: 2XFTkKgHNdWlYeV35qEZyA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6adc88ceab9so1104995a34.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 11:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684176477; x=1686768477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hqIAn873QsCpWU5fVaK4Ln/oVmQG1LGyWmBLtBWvnQ=;
        b=YO3CE+6xRUHmK1l90AQsp4IZ+5ZTqAsXvnMXvHrrFI8B8x9TOuXkJtUAXAH8iqkuef
         0bG2ePPOjo2+eClkefrEUWuyCKJ/PSxG5ez3YIJ8BWUgUgxk/Pc9W9xPeAjpAS/5ETDs
         WrQNopOd40EVYl9DMq5NUpbmXDH63ANCrxZmbuE3HBsRpyxMHdg3WUD7hlClC5apR12w
         vnSPt1zwuPo98yKbv7J147TdkijUcohcUFoi/DRY1XJFmluT0IP8S05UtsR72aqggGwJ
         ZN/Usmib2HRKiVVW2ddiHoYdkOFwJZhUuLk2zTnZCZHr4Pa8i1eBEZVd9Z08wDJa+6fU
         +U8Q==
X-Gm-Message-State: AC+VfDwJthMDi+LYPIidxsMB/X/0YjnkKDHabA35vI9actCysxCrZKR1
        Ix7NiKpLYW2raWWvctAdel+00Jxurt3C2k/UtRMpFwuq2Y2nIHN2cV4kPNyjAZLs9MEtMOHvyOx
        YyHzej6wsnHAm93uhEtvL6MKM5TnTrrE9
X-Received: by 2002:a9d:6c05:0:b0:6aa:f9c8:42ee with SMTP id f5-20020a9d6c05000000b006aaf9c842eemr11342144otq.38.1684176477141;
        Mon, 15 May 2023 11:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7w8rqRjYuIs5zI+oXDDwHSM39djcYXopSet1+cG56krvnX1VIMPKmnMOQaeweOUPK8LYIxHg==
X-Received: by 2002:a9d:6c05:0:b0:6aa:f9c8:42ee with SMTP id f5-20020a9d6c05000000b006aaf9c842eemr11342139otq.38.1684176476861;
        Mon, 15 May 2023 11:47:56 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3? ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a6558ef17fsm11450965otl.30.2023.05.15.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:47:56 -0700 (PDT)
Message-ID: <cefdad7f7154155f69d9613efe53f9cbbea2ed20.camel@redhat.com>
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 15:47:51 -0300
In-Reply-To: <20230515183045.654199-1-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
User-Agent: Evolution 3.48.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 2023-05-15 at 15:30 -0300, Leonardo Bras wrote:
> Changes since RFCv3:
> - Split the patch in 2: entry/exit and queue
> - Fix 'struct __call_single_data' & call_single_data_t alignment issue
> - Made all TP_printk follow the same pattern
>=20
> Changes since RFCv2:
> - Fixed some spacing issues and trace calls
>=20
> Changes since RFCv1:
> - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> - Using EVENT_CLASS in order to avoid duplication
> - Introduced new helper: csd_do_func()
> - Name change from smp_call_function_* to csd_function_*
> - Rebased on top of torvalds/master
>=20
> Leonardo Bras (2):
>   trace,smp: Add tracepoints around remotelly called functions
>   trace,smp: Add tracepoints for scheduling remotelly called functions
>=20
>  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  kernel/smp.c               | 41 +++++++++++++---------
>  2 files changed, 96 insertions(+), 17 deletions(-)
>  create mode 100644 include/trace/events/smp.h
>=20

argh, almost sure some llvm build will output some alignment warning becaus=
e
csd_do_func() has an=C2=A0'struct __call_single_data' argument while the tr=
acepoints
have call_single_data_t arguments.

Other than that, it should be fine.
I will collect other suggestions before sending a v5 with this fix.

Leo

