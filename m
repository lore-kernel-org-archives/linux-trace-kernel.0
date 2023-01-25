Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1DBC38142
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 25 Jan 2023 00:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjAYAQv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 24 Jan 2023 19:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAYAQu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:16:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FF34A232;
        Tue, 24 Jan 2023 16:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F29A61387;
        Wed, 25 Jan 2023 00:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF81DC433D2;
        Wed, 25 Jan 2023 00:16:38 +0000 (UTC)
Date:   Tue, 24 Jan 2023 19:16:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Yipeng Zou <zouyipeng@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Fix bash specific "==" operator
Message-ID: <20230124191637.0b2b8785@gandalf.local.home>
In-Reply-To: <167434397083.3069767.14730152459198287532.stgit@devnote3>
References: <167434397083.3069767.14730152459198287532.stgit@devnote3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 22 Jan 2023 08:32:50 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit a1d6cd88c897 ("selftests/ftrace: event_triggers: wait
> longer for test_event_enable") introduced bash specific "=="
> comparation operator, that test will fail when we run it on a
> posix-shell. `checkbashisms` warned it as below.
> 
> possible bashism in ftrace/func_event_triggers.tc line 45 (should be 'b = a'):
>         if [ "$e" == $val ]; then
> 
> This replaces it with "=".
> 
> Fixes: a1d6cd88c897 ("selftests/ftrace: event_triggers: wait longer for test_event_enable")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Care to pull this through your tree?

-- Steve

> ---
>  .../ftrace/test.d/ftrace/func_event_triggers.tc    |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> index 3eea2abf68f9..2ad7d4b501cc 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> @@ -42,7 +42,7 @@ test_event_enabled() {
>  
>      while [ $check_times -ne 0 ]; do
>  	e=`cat $EVENT_ENABLE`
> -	if [ "$e" == $val ]; then
> +	if [ "$e" = $val ]; then
>  	    return 0
>  	fi
>  	sleep $SLEEP_TIME

