Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76673C77B6C
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  8 Apr 2023 14:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDHOYI (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 8 Apr 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDHOYF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7736C15F
        for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5595860F11
        for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C0EC433D2;
        Sat,  8 Apr 2023 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680963843;
        bh=M2c9+7TABtKJScbG8xpYjHjqS1RegDbHIhTwpLLYfT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nPmSBOF/NsdyX4yoq30LbAZfTAknLV/8eAg7lqFJ01MknFcOc+Da9ZAde7cC0GgGl
         nkBNWfZAtShcrs9mHEdkWatKR35OpYNbGaMSoSUbUNJZhSDtozCmgoecEWZTjWx08O
         KyMm3+154T35BhM13vmTreAjVO9A63+xFP78vW8aIBNaQe2hYX8MKpmwFBqXwEiiY1
         icz/bYBOAJHKKUU4W7biQxyniePHvEzF3G8fpCtOJeRR6wWatoj4p4OksQcmMrkjh5
         Kt7SPSeKgk8JaP1HysWBslXCg0/oUYnXSltdJN1trbtpTjH9tTwQAkVRHQIFU6x4dx
         cDu9gAp6S7RBQ==
Date:   Sat, 8 Apr 2023 23:24:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] fprobe: Skip exit_handler if entry_handler returns
 !0
Message-Id: <20230408232400.467608f3b7c809d39096d3b1@kernel.org>
In-Reply-To: <85429a5c-a4b9-499e-b6c0-cbd313291c49@kili.mountain>
References: <85429a5c-a4b9-499e-b6c0-cbd313291c49@kili.mountain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Dan,

Thanks for reporting!

On Tue, 4 Apr 2023 10:37:48 +0300
Dan Carpenter <error27@gmail.com> wrote:

> Hello Masami Hiramatsu (Google),
> 
> The patch 39d954200bf6: "fprobe: Skip exit_handler if entry_handler
> returns !0" from Feb 2, 2023, leads to the following Smatch static
> checker warning:
> 
> 	kernel/trace/fprobe.c:59 fprobe_handler()
> 	error: uninitialized symbol 'ret'.
> 
> kernel/trace/fprobe.c
>     49                 fpr->entry_ip = ip;
>     50                 if (fp->entry_data_size)
>     51                         entry_data = fpr->data;
>     52         }
>     53 
>     54         if (fp->entry_handler)
>     55                 ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
> 
> ret is only initialized if there is an ->entry_handler
> 
>     56 
>     57         /* If entry_handler returns !0, nmissed is not counted. */
>     58         if (rh) {
> 
> rh is only true if there is an ->exit_handler.  Presumably if you have
> and ->exit_handler that means you also have a ->entry_handler but Smatch
> is not smart enough to figure it out.

Ah, OK. Let me fix to initialize 'ret'.

> 
> --> 59                 if (ret)
>                            ^^^
> Warning here.

Thank you!

> 
>     60                         rethook_recycle(rh);
>     61                 else
>     62                         rethook_hook(rh, ftrace_get_regs(fregs), true);
>     63         }
>     64 out:
>     65         ftrace_test_recursion_unlock(bit);
>     66 }
> 
> regards,
> dan carpenter


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
