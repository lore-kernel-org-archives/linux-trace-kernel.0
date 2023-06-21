Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E1BEB64D8
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 21 Jun 2023 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFUQq1 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 21 Jun 2023 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjFUQqR (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E032100;
        Wed, 21 Jun 2023 09:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3480615D9;
        Wed, 21 Jun 2023 16:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283ECC433C8;
        Wed, 21 Jun 2023 16:45:59 +0000 (UTC)
Date:   Wed, 21 Jun 2023 12:45:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] Documentation: Fix typo of reference file name
Message-ID: <20230621124557.40200450@gandalf.local.home>
In-Reply-To: <168584575125.2056209.5771945721143181243.stgit@mhiramat.roam.corp.google.com>
References: <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
        <168584575125.2056209.5771945721143181243.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun,  4 Jun 2023 11:29:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix a typo of Documentation/trace/fprobe.rst.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306040144.aD72UzkF-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/trace/fprobetrace.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> index e949bc0cff05..7297f9478459 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -38,7 +38,7 @@ Synopsis of fprobe-events
>                    with a digit character, "_TRACEPOINT" is used.
>   MAXACTIVE      : Maximum number of instances of the specified function that
>                    can be probed simultaneously, or 0 for the default value
> -                  as defined in Documentation/trace/fprobes.rst
> +                  as defined in Documentation/trace/fprobe.rst
>  
>   FETCHARGS      : Arguments. Each probe can have up to 128 args.
>    ARG           : Fetch "ARG" function argument using BTF (only for function

