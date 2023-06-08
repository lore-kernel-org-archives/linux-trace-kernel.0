Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47294C7EE23
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  8 Jun 2023 17:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjFHRTf (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 8 Jun 2023 13:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjFHRTe (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:19:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E14D271D;
        Thu,  8 Jun 2023 10:19:29 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9500F20C145B;
        Thu,  8 Jun 2023 10:19:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9500F20C145B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686244768;
        bh=vHFWL4OmnL1LTZcnfAluMeMCHwhUx7iXNArGhpAQSi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6XHKEUfkN5VuiTCYtCMbDTGGv6zSKNNBs91L3J+lb8pp1iYn8WFfu/N00LSRc/mZ
         QYlenr88SGfE8D75o0GQAQs8G4aRETh8oj45NBDOtLZC0LFwsmGmHRxzxZZBGonoV4
         KDfA7hzWgHHguNI7eh08Di0ydhKriOnKKgSaiSdc=
Date:   Thu, 8 Jun 2023 10:19:21 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com
Subject: Re: [PATCH 1/3] tracing/user_events: Fix incorrect return value for
 writing operation when events are disabled
Message-ID: <20230608171921.GA74@W11-BEAU-MD.localdomain>
References: <20230608011554.1181097-1-sunliming@kylinos.cn>
 <20230608011554.1181097-2-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608011554.1181097-2-sunliming@kylinos.cn>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 09:15:52AM +0800, sunliming wrote:
> The writing operation return the count of writes whether events are
> enabled or disabled. This is incorrect when events are disabled. Fix
> this by just return -EFAULT when events are disabled.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 1ac5ba5685ed..970bac0503fd 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  
>  		if (unlikely(faulted))
>  			return -EFAULT;
> -	}
> +	} else
> +		return -EFAULT;
>  

I'm not sure this is a good idea. Imagine this scenario:
A user process writes out a user_event and it hits a fault that gets
returned as errno (EFAULT).

The user process is likely to either forget it and say, not worth
retrying, or it will retry (potentially in a loop).

If the process does retry and it's now disabled, it might try many
times.

I think that -ENOENT is a better error to use here. That way a user
process will know it got disabled mid-write vs a fault that might want
to be re-attempted.

Thanks,
-Beau

>  	return ret;
>  }
> -- 
> 2.25.1
