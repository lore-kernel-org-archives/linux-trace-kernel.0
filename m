Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF7BEE49A6
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 14:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjHUO3c (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjHUO3c (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:29:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0436DB;
        Mon, 21 Aug 2023 07:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF80639EC;
        Mon, 21 Aug 2023 14:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37131C433C8;
        Mon, 21 Aug 2023 14:29:29 +0000 (UTC)
Date:   Mon, 21 Aug 2023 10:29:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <song@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230821102943.758dca19@gandalf.local.home>
In-Reply-To: <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
        <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
        <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
        <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
        <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 20 Aug 2023 03:02:18 -0700
Song Liu <song@kernel.org> wrote:

> > For the "unique symbol" + offset, you don't need the kallsyms, but need to
> > access the System.map or vmlinux image. In this case, we don't need to expand
> > the CAP_PERFMON capabilities.  
> 
> I agree this is not needed in this case. But I wonder whether it makes sense
> to give CAP_PERFMON access to /proc/kallsyms. Will this change make
> CAP_PERFMON less secure?

I guess the question is, does CAP_PERFMON allow seeing where the kernel
mapped itself via some other means? If not, then no, I would nack this as
being a security hole.

-- Steve
