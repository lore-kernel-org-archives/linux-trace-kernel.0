Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08030C3DA7A
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  5 Jan 2023 14:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAEO4F (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 5 Jan 2023 09:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjAEOzu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:55:50 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1D13D4F;
        Thu,  5 Jan 2023 06:55:49 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id u9so90772059ejo.0;
        Thu, 05 Jan 2023 06:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuOfy85ZwvCfFAcvAn2erozThPTjz6H5x5dkC5MKj30=;
        b=VWPQmb7CKrojM+/15SVqg9cRFL31QXG04D998UUlL78TRKJjfPVis/w0j3wtO6pSy+
         Ni3t9CZqDfFDDdUwte7gp6M4ZVVo1IpHvxi46mDMKXDYGtV9z+aPz1BY7T/pWorEzwhw
         6JYud7StqYFBTz+P9WCD+RJw18zVOTC6ap5zhab9fPcFB9y1mZEy+thBkU2mV+2Ci1Id
         QsfxzRpuA0p8344tiC1mEbQg0mSThE/puhQey6dqb2hqV6atsMI8iqq6uWOV9qhALwCN
         3QLUlqHLRRF/VisUzceSPX98nwgpoH4We0dEysionIniZVyuX+i8BYHfOH8DbB8KrXYX
         sycg==
X-Gm-Message-State: AFqh2kqt5NizVDl17mFxXUPxnCgBQkbstHBk6BoT0BCI9nIEIPaiN0q5
        +C13nERhrjx4+dfrhppZRLCeu+97BYYWgsz9S4w=
X-Google-Smtp-Source: AMrXdXv486tEDcDIfpsnRI+CN8Q3/XCClxaX1CsTCMwkE+Hi2BixnvVL0GgrHDV3E2M3VsmwpTTS+RH+W9IZCTtAsSI=
X-Received: by 2002:a17:906:50c:b0:836:9bcf:1702 with SMTP id
 j12-20020a170906050c00b008369bcf1702mr6583874eja.509.1672930548305; Thu, 05
 Jan 2023 06:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20221214233106.69b2c01b@gandalf.local.home> <Y5trUep9IvCv1Uwy@google.com>
 <20221215141146.6ceb7cf2@gandalf.local.home> <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
 <20221215151333.49af5442@gandalf.local.home> <CAJZ5v0iNdLyOpAxsCTTq-zqRfWDrJ5_c2DUcJYE5ZFn7u+2qdQ@mail.gmail.com>
 <20230104163913.7b13cd68@gandalf.local.home>
In-Reply-To: <20230104163913.7b13cd68@gandalf.local.home>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jan 2023 15:55:33 +0100
Message-ID: <CAJZ5v0ib+Xg_tXb9yURFt91kJ9cFT48KzLaOjJ94gefRHCMbag@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 10:39 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 30 Dec 2022 16:52:36 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > Personally, I would use a command line option to control the behavior
> > and the Kconfig option to provide its default value.
> >
>
> I can add that.
>
> > This way it can be flipped without rebuilding the kernel if need be.
> >
> > I would also make the ACPI debug output go into the trace buffer so
> > long as the Kconfig option is not changed or the command line option
> > is not flipped.
>
> Not sure what you mean by the above? You mean to make going to both as the
> default?

No, just send them to the trace buffer alone unless specifically told
to printk() them.
