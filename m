Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FF433049;
	Tue, 25 Aug 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662529; cv=none; b=hQhv+LwBm12sW86pEtm/3IUHvl9CDlz8jarbr5pME/NtnGHkBKBNH5d1D0zliuFtIR7dR/fCv/2gbmFAFaSkFXjhYsbN7zrXPzynY7fpj6i+cULyt4yZgmCN4B4SNassm8RsY5P7a+vNkkFRZvJ8TOGoYHfUxJwsH08XA4/kyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662529; c=relaxed/simple;
	bh=lMbadGI6bG/xSqPmC06/CiaQldQw2eevZZ2Iw3Z1O70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeZBEjb3yvXqQojy+2qPUKyLOOhZupevCQ8gijb9K7wXAuFGBOCm25OFYvnpmMRz9mdxzlIe2HeFMBor6xP/VZS/nJ5keH/w987ESY5Vgi4jw6x82SE/y418vW7RjnhTLAH7JchVZ/OvddRZynH5V2QA8wF8ezGQqEO3iE6V+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=bRUw33u6; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="bRUw33u6"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 28AE41C1959;
	Tue, 25 Aug 2026 12:55:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 6991F20026;
	Tue, 25 Aug 2026 12:55:24 +0000 (UTC)
Date: Tue, 25 Aug 2026 08:56:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] samples/ftrace: Fix kthread_stop() on ERR_PTR in
 ftrace-direct-multi-modify
Message-ID: <20260825085607.46c3814e@gandalf.local.home>
In-Reply-To: <20260825093421.7377-1-vulab@iscas.ac.cn>
References: <20260825093421.7377-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: menmnxybipu397wij5ewrq3ej44uj9op
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 6991F20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PrpqXjqvKvNRYVyAs7J+unq72YZfMGfw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=OKKP5tcxu1fq6t62908DksMjio6J6HxeeQ7e0FapnVc=; b=bRUw33u6AYtRa3uD+i/+6oUxPbsMW0RwCQw8Vnt4vertCAhdVtRhuFbUVEctlCU6biqnyknGolN4hqifgIK5FLbiMt5d/ECoKaSPHQFKDgQeET/RGi8atusBdoeSuxuHiPHdtiNlcPhWSFI6o6hIe6NEYVemPC/JzNsVUxEKDcY=
X-HE-Tag: 1787662524-38958
X-HE-Meta: U2FsdGVkX1/goqlqKWlZLlja3EGV0C6PmBqz/4pYOEh/ZCgot1fGN0qkIW4CxVc2zyGutnBp/vs7fxX+ns5VSTP21/OnIvYmQHYVs29DjQ2oUH9PCBjazs+2wYXaInB03Ic9nZm0Smx9OM51dM3A7YyvV2+52+g7afiJztYoOLtmh1MeBOLc+XOCzpzCZhfHKlH08OpayRgGG3kvlxMDHRKjONZSVhhJvj+USmK3t6eNtEgGjA1MU3D7hrdZ2qEXjzye6+U3hCxDTcX3DFPF9h6tmlKcIb7vmE3ekWKrqyp955snIlK+63p/xTr8YN/F

On Tue, 25 Aug 2026 17:34:21 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> ftrace_direct_multi_init() assigns kthread_run()'s return value to
> simple_tsk without an IS_ERR() check. When kthread_run() fails it
> returns ERR_PTR(-ENOMEM), but init still returns 0, so the module loads
> with simple_tsk holding an error pointer. On unload,
> ftrace_direct_multi_exit() then passes that ERR_PTR to kthread_stop(),
> leading to a null-pointer-dereference.
> 
> Check the return value of kthread_run() with IS_ERR(); on failure,
> unregister the ftrace direct call and propagate the error code.
> 
> Fixes: e1067a07cfbc ("ftrace/samples: Add module to test multi direct modify interface")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  samples/ftrace/ftrace-direct-multi-modify.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index 8f7986d698d8..f339131654c7 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -364,8 +364,13 @@ static int __init ftrace_direct_multi_init(void)
>  
>  	ret = register_ftrace_direct(&direct, my_tramp);
>  
> -	if (!ret)
> +	if (!ret) {
>  		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
> +		if (IS_ERR(simple_tsk)) {
> +			unregister_ftrace_direct(&direct, my_tramp, true);
> +			ret = PTR_ERR(simple_tsk);
> +		}
> +	}
>  	return ret;
>  }
>  

And simplify this one too.

Oh, and if you have a series "[PATCH 1/2]" then you need a cover letter and
have each patch be a reply to of that patch. Otherwise just send the
patches as is without the numbered series. Because sending the patches one
by one with a series number makes it confusing.

-- Steve


-- Steve
