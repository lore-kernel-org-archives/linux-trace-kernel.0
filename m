Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C5EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 22 Jul 2023 08:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGVIFY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 22 Jul 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVIFX (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6132733
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690013082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jbSZkv9qcwLx6TkEBQeR4Wnol8rh9QTnB0QIfSJxe8A=;
        b=YK9ZEdrnR1ZS9LekE+2hbyxeUaVRPy+OpP28V8H35F4h1wejr9dCJ8ysWeJriZFZGimNEz
        3/tkDE5mYxIGrXzp38Kz6Fn6Eivf85hhkotXnbyvM2LUk08pt0ELHLp7Wnrs6tCVceGvtq
        NgIdzyX64M12waUTmpEL3r4+lMqWWvA=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-LWXHVtj8OsiycgBLqjS_3Q-1; Sat, 22 Jul 2023 04:04:41 -0400
X-MC-Unique: LWXHVtj8OsiycgBLqjS_3Q-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b016818400so4812120fac.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690013081; x=1690617881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbSZkv9qcwLx6TkEBQeR4Wnol8rh9QTnB0QIfSJxe8A=;
        b=hWG8yogYCJwgwxMgdtGPrht+nGfdQeCRP7GO4zXs9ifkpq7iwPqOnODsjl/01WldWn
         tVVekHhOuEHBEjrmJiortm22Mi0y+FEzk8wPsng9Uw19t+IBK3mztEt/bt+bNrvmQLVT
         ERA9ZH3phUgE2/YQfxEcvR8uf0p60NYVx3S2czy7WXwfWUJmdt0+qIeJx1PZOGKyjyeU
         PDb//0RDvR3EpyFOM7DBoYQMCNwPIKKDwnAiv663S1Sg2IRDzPzSJNyDGF8KhJfkmdGK
         HSNGNEWCR8aZhAgJ4C50fdUUJFDrR0RqPO+BtC1gf/XEcXipIuISY+osKsxkefeQ/vyy
         1hsw==
X-Gm-Message-State: ABy/qLY0TX+IeViz/F+mpmWoEN5kmde+dPYXAkf3SGWFXmJz4H7qZRLN
        4Dd+i/UxsA7GTcLDt39aPmDFCXsNvapcPDh9fdU2Ye6kQ3EpgJaOIHedvkzspT1qi5qwMlYiyC0
        ssRtJ+BwhClhxmION7Vd40+EGZ4l399vVswNW7kXvVYmN+p4W
X-Received: by 2002:a05:6870:f69e:b0:1b0:43b6:e13b with SMTP id el30-20020a056870f69e00b001b043b6e13bmr5415913oab.54.1690013080956;
        Sat, 22 Jul 2023 01:04:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTHBxJ83OPWYjyyNOUC3XHdVgTNzaset85zkOMNxYBC17Xoo0VXVQRCj/sg/zGs6W4odjxmgoFJn4fb7835PI=
X-Received: by 2002:a05:6870:f69e:b0:1b0:43b6:e13b with SMTP id
 el30-20020a056870f69e00b001b043b6e13bmr5415901oab.54.1690013080765; Sat, 22
 Jul 2023 01:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230716193000.231406-1-costa.shul@redhat.com> <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
In-Reply-To: <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Sat, 22 Jul 2023 11:04:29 +0300
Message-ID: <CADDUTFx+tfdkLp=wp-XH-U1iB3ZM90W=ktbR4ckp62pDmUGPMg@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Add latency threshold
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

> rtla timerlat has the --aa-only that ignores the trace until
> the tracing stops, and then do the auto-analysis based on the
> tail of the trace.

> So, as I said, I am not convinced that adding this interface file is
> better than setting the stop-tracing option... and then waiting for
> the trace to stop... parsing only the tail of the buffer.

I see. Stop-tracing option of rtla timerlat solves the problem for
most of the cases.

Thank you very much!
Costa

