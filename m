Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FCC4167B
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 15 Dec 2022 19:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOTxE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 15 Dec 2022 14:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLOTxD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:53:03 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2E537E6
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:53:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id n1so81128ljg.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7WnaZc2bs26QE2S1hFU0wWVtk2SkMXSSpzkb6FSS1RI=;
        b=aGblDN6+LiroAi5Ce2HI0sla+sv/MZ0o1VnWUgJkTxIOUl93xZYtZDnsd8zl1DABm2
         OfhiFJBPHg9RSV8cw+9sGyvjAUzHb9igov4etIG+PT6jB8if72VmeESBXHF3IHsiLc5M
         b2CmaXYJsYqhGPOOzKvG2srf3DxtCyWSKXn2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WnaZc2bs26QE2S1hFU0wWVtk2SkMXSSpzkb6FSS1RI=;
        b=3Lh7gYv8q3ZnpZReloO3yYXNiAKcTPwtdSb43fh/Nva1KSHuQnuTUf4beQLG2bfIzW
         ajB5JiM779Hg3BHxNq7KfrPVM0T3n39BuFui763y1i+LH0nPOPXBzuZGT65Xk8D/exyF
         eu2hef3JOaFu2KfdWOgX8gb6CngNESxWYoBYZ5/uNIV6tlj47IxzxCaJ2iT5JgOjX8yE
         cOK6/HycknSffJq36BWfZhtFSlHlaO03lKV/3Bs5scPG5Dy1MAuRAI4mvuG065u1wEUE
         tCphZVcGjtq3vFpgpsOUhOwPe++5rBDIvwytfI2+8MPjTgmEmX5bDR66oTfESSNrEfhk
         Y1wA==
X-Gm-Message-State: ANoB5pnhIbtF55h9MfKop/uNbX3VVCjdXuuCxfxMG1ZIZMXYODFcsn9A
        D24nUE3yZSoHf3+hDXVhAWkiFzE70eVxKZWKsWOfNTfQyL8jSvWX
X-Google-Smtp-Source: AA0mqf4FW9H2CtluhofbPQJiA6xZ7ZdK14RZtc7ewZw8cqvcl+H7LOmqZe+1wc0FJ8tx6X3g9uIC6DD8PJrYGi5UrrE=
X-Received: by 2002:a05:651c:124c:b0:279:f45e:ccd6 with SMTP id
 h12-20020a05651c124c00b00279f45eccd6mr7839328ljh.483.1671133979884; Thu, 15
 Dec 2022 11:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214233106.69b2c01b@gandalf.local.home> <Y5trUep9IvCv1Uwy@google.com>
 <20221215141146.6ceb7cf2@gandalf.local.home>
In-Reply-To: <20221215141146.6ceb7cf2@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 14:52:48 -0500
Message-ID: <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 2:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 15 Dec 2022 18:45:37 +0000
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Wouldn't it be better to also check trace_acpi_print_enabled() here in the
> > else if() condition, along with IS_ENABLED()? That way if the CONFIG is
> > enabled but the tracepoint is not enabled, at least the messages will go to
> > dmesg instead of skipped.
>
> I really don't want that. This was purposely done to be mutually exclusive.
> The reason I added this in the first place, is because too much enabled
> will render the system useless if printk() is used.
>
> After boot up, if I had enabled all debug events and then I were to disable
> the acpi tracepoint, it will likely render the system useless again if it
> were to switch over to printk.

Ok, sure. I see where you were going. So you want no debugging
messages at all if the trace event is disabled. That's fine with me. I
would also add a note about the need to enable the specific trace
event, in the Kconfig message and/or the Documentation. Otherwise, you
might get someone say, "hey I enabled the CONFIG option but I see
nothing in the trace buffer".

Another approach could be to always enable the trace event by default,
if the CONFIG is turned on. Or do a printk() telling the user about
the event to enable, so they know why their trace buffer is empty.

Up to you and the ACPI maintainers. ;-)

thanks,

 - Joel
