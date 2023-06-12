Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50847C7EE2E
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 12 Jun 2023 05:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjFLFdW (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Jun 2023 01:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFLFdV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FF9B;
        Sun, 11 Jun 2023 22:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A20961EE1;
        Mon, 12 Jun 2023 05:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624EDC433EF;
        Mon, 12 Jun 2023 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686547999;
        bh=DWdxQmn2lQW7lp07K3aZRrfVJ16y3PIMhFImAxla3ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZy2qVImfXbY9mkrpLw0PqcaM2BGbWapHCmlVfrJqzrKDc4yDfQgQyEQaUGW/IV4b
         N0u6gKc6YNY9GNbEkCGTn38VThvyZJDZmh99f/50fZN+Ai4q1wYtpvtP6FnkeXMp1Z
         g4BqpcJ2yEbPVeDzORB/PxV/4LVSWwwEevpnBybUyDzqmu0h0T3SctEFQTzpuOscWQ
         4Zb+AHF5E6dqk5kMn+1S/HNUD0Tfa2TPYdqMlDr4IVcgYXK+OU99fnmjIRbrmI7wtZ
         ufxs97I1+Zfe94jv8wHEpCV+We+6WPYzTh2RjtWjVl2kr45qfvwq7OmvZEywlbIxdq
         oJ20hexHPZqXg==
Date:   Mon, 12 Jun 2023 14:33:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftace: Fix KTAP output ordering
Message-Id: <20230612143316.1851a0fd7a49971f1b2209bf@kernel.org>
In-Reply-To: <20230609-ftrace-ktap-order-v1-1-0abf4d0d6922@kernel.org>
References: <20230609-ftrace-ktap-order-v1-1-0abf4d0d6922@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 10 Jun 2023 15:27:55 +0100
Mark Brown <broonie@kernel.org> wrote:

> The KTAP parser I used to test the KTAP output for ftracetest was overly
> robust and did not notice that the test number and pass/fail result were
> reversed. Fix this.

Oops, I also missed that part. According to the Documentation/dev-tools/ktap.rst,
the result string ('ok', 'not ok') must be the first item.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, could you pick this?

Thank you,

> 
> Fixes: dbcf76390eb9 ("elftests/ftrace: Improve integration with kselftest runner")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 2506621e75df..cb5f18c06593 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -301,7 +301,7 @@ ktaptest() { # result comment
>      comment="# $comment"
>    fi
>  
> -  echo $CASENO $result $INSTANCE$CASENAME $comment
> +  echo $result $CASENO $INSTANCE$CASENAME $comment
>  }
>  
>  eval_result() { # sigval
> 
> ---
> base-commit: dbcf76390eb9a65d5d0c37b0cd57335218564e37
> change-id: 20230609-ftrace-ktap-order-d5b64a74dc79
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
