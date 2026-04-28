Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC477328B62;
	Tue, 28 Apr 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396303; cv=none; b=O7cN0TrL3tSZ3mEs1OtAE/BKXKJWw9dBYj+jPzL7q4Bcl5icuH8cVjX6EkxVSap1U4ZC5GI8YqQilVWGGVhBBAeEJuECH3X02H5nn0O3KwPfsLjhFdNChy0G0F/7NZh3uYtPJ4bpwh+JvKxPE/RdvOV6nPPqoAloYYvM8H/7HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396303; c=relaxed/simple;
	bh=3IEVvhyoAwMsqSlZN1pE1/BSuSg3iJlo8V4AUulUOhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6yhTu7jdn7QpVUhaB1s3j3RN5e3fiEylVJiBwSg/SlM7o0eNOoN4ts3jtLeaEx/pFOMlEz14hKYgfdBQc6371zONc5XQhlZUkZDCn6BzbHZ8wqE4YZsok0d/O0EnYso9eGzA7Ehf08U4ZIJdjHwNJckrXII3XzOHSMLUgJRSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id F0944A00B7;
	Tue, 28 Apr 2026 17:11:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 26E9C2002B;
	Tue, 28 Apr 2026 17:11:33 +0000 (UTC)
Date: Tue, 28 Apr 2026 13:11:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: remove the dead IS_ERR() check in
 trace_pipe_open()
Message-ID: <20260428131147.08fdbe1e@gandalf.local.home>
In-Reply-To: <20260420101236.223919-1-yashsuthar983@gmail.com>
References: <20260420101236.223919-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 26E9C2002B
X-Rspamd-Server: rspamout06
X-Stat-Signature: 3az1pk3wx5wptzskabn8orrdar8qmaxq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18KDwoI78GMHSM1d7h4lnT8LQ86Syck7/g=
X-HE-Tag: 1777396293-450845
X-HE-Meta: U2FsdGVkX18dd6V6bi9RKrxjPv0CURQBLZiyLVaop2Fls/YP5GEJYhBRr9HI9rpP/PoWRMRuIcRGIA/Pagu+dnphmNEmlnbqBgTAHVjtIThY5LxAjGH2F9aPOttQhLDits3Qc7wm52hvZo/aXPsQsilWsRsR1D8WopEwrANhwYtjoSvijlUw0ozj4VUpGETAzAD3kxZL/wJWesbnuWvBsIL1ZngdSS5HXgpFzyK4dxuCo9vY+s0PXMieXDDsVV30glfeg8ZhOqP7+AuTpCA/vq5l57M26zzc7wvRKLRbxYD63HyjvoSCpBhRzx84Mo5dRA2ANzIzy9fhIorsCWvvHXgaJ5PEbOrn

On Mon, 20 Apr 2026 15:42:36 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

"remove the dead"? What is this? a horror flick? ;-)

The subsystem is "tracing" not "trace" and the first word should be
capitalized. I changed the subject to:

  [PATCH] tracing: Remove redundant IS_ERR() check in trace_pipe_open()

And pulled it in.

When submitting changes to a subsystem, please do a git log --no-merges to
see how other commits are done in that subsystem.

Thanks,

-- Steve

> in trace_pipe_open() already check the IS_ERR(iter) and
> return early on error,so iter after will be valid and
> it is safe to return 0 at end.
> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
>  kernel/trace/trace_remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index d6c3f94d67cd..2a6cc000ec98 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -602,7 +602,7 @@ static int trace_pipe_open(struct inode *inode, struct file *filp)
>  
>  	filp->private_data = iter;
>  
> -	return IS_ERR(iter) ? PTR_ERR(iter) : 0;
> +	return 0;
>  }
>  
>  static int trace_pipe_release(struct inode *inode, struct file *filp)

