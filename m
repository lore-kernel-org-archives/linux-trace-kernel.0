Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0802BEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  4 Jul 2023 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGDNnI (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDNnG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90511D;
        Tue,  4 Jul 2023 06:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50276123A;
        Tue,  4 Jul 2023 13:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62808C433C7;
        Tue,  4 Jul 2023 13:42:58 +0000 (UTC)
Date:   Tue, 4 Jul 2023 09:42:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     mhiramat@kernel.org, ebiggers@kernel.org, azeemshaikh38@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/boot: Replace strlcpy with strscpy
Message-ID: <20230704094248.1b36c3e7@rorschach.local.home>
In-Reply-To: <202306201335.D6D772A@keescook>
References: <20230615180420.400769-1-azeemshaikh38@gmail.com>
        <168729290245.455922.11993639418267016143.b4-ty@chromium.org>
        <20230620163325.35c9203c@gandalf.local.home>
        <202306201335.D6D772A@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 20 Jun 2023 13:35:14 -0700
Kees Cook <keescook@chromium.org> wrote:

> > > Applied to for-next/hardening, thanks!
> > > 
> > > [1/1] tracing/boot: Replace strlcpy with strscpy
> > >       https://git.kernel.org/kees/c/b1c38314f756
> > >   
> > 
> > I was going to add this to my queue.  
> 
> Ah, okay, no worries. I will drop it from mine.

Maybe I should have let you take it. I had v1 in my queue, and pushed
that one :-p

I'll fix it later.

Thanks,

-- Steve
