Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632DC05027
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  9 Feb 2023 14:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBIOGX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBIOGW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:06:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E038B74F;
        Thu,  9 Feb 2023 06:06:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CF661AA3;
        Thu,  9 Feb 2023 14:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB1C433EF;
        Thu,  9 Feb 2023 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675951580;
        bh=cT3CWSl1cLZnecvxHmHoVJTw89O6CRj75VeHnkmHI2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JS60OnUwhCON7W/N1V9swwpyQiSlS1bavgZA0Br1P3y3lIrq/nm9Hx8z0xU7xNA/9
         1DWI7G6WSrvu/wSctLBfaFgL/wDCL9qvCW2Y1hl4lYUNQAlZ5ks0TjTCnXkCo4Yayn
         /M493sr9kdUhJkwHtwCFsYl8L18G5WtSu67WBIhIpw/dyXiAjn9zH84gxdHr285Sf+
         x4OH7we1TScDYUNzPeiDSZatGVyUqjLAyQ03l3LH7F1vLNzCjyivP7T6G+OwY432GN
         CbZfJD2TJRRRdZf6i3gfb/1QAx+IqoPzucVzYOn/+/dRYvIkkqA0QejG2wiVYnV6N/
         ySTe/Vix5onuQ==
Date:   Thu, 9 Feb 2023 23:06:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-Id: <20230209230616.3a731914b271ebaca8877a89@kernel.org>
In-Reply-To: <20230207135147.5ce618d6@gandalf.local.home>
References: <20230207135147.5ce618d6@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 7 Feb 2023 13:51:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The kprobe probepoint.tc test started failing because of the added __pfx_
> symbols that were added because of -fpatchable-function-entry=X,Y causing
> unwinders to see them as part of the previous functions. But kprobes can
> not be added on top of them. The selftest looks for tracefs_create_dir and
> picks it and the previous and following functions to add at their address.
> This caused it to include __pfx_tracefs_create_dir which is invalid to
> attach a kprobe to and caused the test to fail.
> 
> Fixes: 9f2899fe36a62 ("objtool: Add option to generate prefix symbols")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This looks good to me. 

Acked-by: 

Thanks,

> ---
>  tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
> index 624269c8d534..e1b7506c1b11 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
> @@ -21,7 +21,7 @@ set_offs() { # prev target next
>  
>  # We have to decode symbol addresses to get correct offsets.
>  # If the offset is not an instruction boundary, it cause -EILSEQ.
> -set_offs `grep -A1 -B1 ${TARGET_FUNC} /proc/kallsyms | cut -f 1 -d " " | xargs`
> +set_offs `grep -v __pfx_ /proc/kallsyms | grep -A1 -B1 ${TARGET_FUNC} |  cut -f 1 -d " " | xargs`
>  
>  UINT_TEST=no
>  # printf "%x" -1 returns (unsigned long)-1.
> -- 
> 2.39.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
