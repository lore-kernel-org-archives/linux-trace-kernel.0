Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FDC54EBC
	for <linux-trace-kernel@archiver.kernel.org>; Sun,  8 Jan 2023 21:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjAHVbk (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 8 Jan 2023 16:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjAHVbe (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:31:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB8BD2;
        Sun,  8 Jan 2023 13:31:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAF74B80C71;
        Sun,  8 Jan 2023 21:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCADCC433EF;
        Sun,  8 Jan 2023 21:31:30 +0000 (UTC)
Date:   Sun, 8 Jan 2023 16:31:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/tracing: Fix some testcases for recent
 change
Message-ID: <20230108163128.2860894d@rorschach.local.home>
In-Reply-To: <167309832823.640500.13244630381161014364.stgit@devnote3>
References: <167309832823.640500.13244630381161014364.stgit@devnote3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat,  7 Jan 2023 22:32:08 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> This includes some patches to fix 2 issues on ftrace selftests.
> 
> - eprobe filter and eprobe syntax test case were introduced but it
>   doesn't check whether the kernel supports eprobe filter. Thus the
>   new test case fails on the kernel which has eprobe but not support
>   eprobe filter. To solve this issue, add a filter description to
>   README file [1/3] and run the filter syntax error test only if the
>   description is found in the README file [2/3].
> 
> - Recently objtool adds prefix symbols for the function padding nops,
>   and the probepoint test case fails because this probepoint test case
>   tests whether the kprobe event can probe the target function and the
>   functions next to the target function. But the prefix symbols can not
>   be probed. Thus these prefix symbols must be skipped [3/3].
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (3):
>       tracing/eprobe: Fix to add filter on eprobe description in README file
>       selftests/ftrace: Fix eprobe syntax test case to check filter support
>       selftests/ftrace: Fix probepoint testcase to ignore __pfx_* symbols
> 
>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
