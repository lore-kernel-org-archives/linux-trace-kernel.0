Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221BEB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 28 Jul 2023 22:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjG1Wzl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1Wzk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A43C34;
        Fri, 28 Jul 2023 15:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE586219A;
        Fri, 28 Jul 2023 22:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F7DC433C7;
        Fri, 28 Jul 2023 22:55:37 +0000 (UTC)
Date:   Fri, 28 Jul 2023 18:49:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kprobes: Prohibit probing on CFI preamble symbol
Message-ID: <20230728184913.27bb666f@rorschach.local.home>
In-Reply-To: <168904024679.116016.18089228029322008512.stgit@devnote2>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
        <168904024679.116016.18089228029322008512.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 11 Jul 2023 10:50:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Do not allow to probe on "__cfi_" or "__pfx_" started symbol, because those
> are used for CFI and not executed. Probing it will break the CFI.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  Changes in v2:
>   - Check "__pfx_" prefix functions too.
>   - Make the check unconditional.
> ---
>  kernel/kprobes.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
