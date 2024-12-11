Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFA2451CC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889415; cv=none; b=ro+MRUjLEms8W9MZ0OKmbATgjfzIzXy5zKeLImBew5qMZfRBdy5eKr4d8NYntfwOEAutJIcryssJoEbcmLVRcVFfUdKU+HKchkUVpUVepjQF7CSCg1UIN114yqKhUq58XBDl3ATtiEb+1DhJZih9+5mzbq3ms2M/faDx+OZCNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889415; c=relaxed/simple;
	bh=CgT+ukwZBymjCE1aNShsC/UczMXniC9qEpQkMiVGPVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1/X9H3Gjwl1nrBSYP8HSmJOGci76lezyjvh85atAbpRZLIa8Ov8CO/4ngvPb87OaOJPyMLKgROy5rh9m64Dk0MRfQYhq4c8OoVMCYCZcoEATRA7CNaCcCxblUzLUW2OZLqJ0+7FUIVtEwK8i/24Eb2+JeM6DL1YM7nFnZg11B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6AEC4CED2;
	Wed, 11 Dec 2024 03:56:55 +0000 (UTC)
Date: Tue, 10 Dec 2024 22:56:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Li <liwei391@huawei.com>
Cc: <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 <xiexiuqi@huawei.com>
Subject: Re: [PATCH v2 1/2] tracing: Allow custom read/write processing in
 trace_min_max_{write,read}()
Message-ID: <20241210225652.782bfae5@batman.local.home>
In-Reply-To: <20241121021823.1237741-2-liwei391@huawei.com>
References: <20241121021823.1237741-1-liwei391@huawei.com>
	<20241121021823.1237741-2-liwei391@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:22 +0800
Wei Li <liwei391@huawei.com> wrote:

> The 'trace_min_max_fops' implements a generic function to read/write
> u64 values from tracefs, add support of custom read/write processing
> to allow special requirements.


Instead of making a new parameter in trace_min_max_param, why not just
change the hwlat "width" file to have its own ops. Then you can make
the trace_min_max_read() non-static, reuse that, and then have the
hwlat use its own write function. It would make it much more straight
forward.

That could be done for a fix that would be tagged as stable, and it
would also be a single patch.

Really, for a clean up (after that is done), the trace_min_max_fops
should be replaced to get rid of the "lock" parameter. Perhaps have a
trace_min_max_lock_fops. But Linus hates conditional locking, and I
don't blame him. I'm trying to clean up this code with using guard()s
and that conditional locking makes that not possible.

-- Steve



> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  kernel/trace/trace.c | 13 ++++++++++---
>  kernel/trace/trace.h |  2 ++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2b64b3ec67d9..ab5ea6d7148c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7689,8 +7689,12 @@ trace_min_max_write(struct file *filp, const
> char __user *ubuf, size_t cnt, loff if (param->max && val >
> *param->max) err = -EINVAL;
>  
> -	if (!err)
> -		*param->val = val;
> +	if (!err) {
> +		if (unlikely(param->write))
> +			param->write(param->val, val);
> +		else
> +			*param->val = val;
> +	}
>  
>  	if (param->lock)
>  		mutex_unlock(param->lock);
> @@ -7723,7 +7727,10 @@ trace_min_max_read(struct file *filp, char
> __user *ubuf, size_t cnt, loff_t *ppo if (!param)
>  		return -EFAULT;
>  
> -	val = *param->val;
> +	if (unlikely(param->read))
> +		val = param->read(param->val);
> +	else
> +		val = *param->val;
>  
>  	if (cnt > sizeof(buf))
>  		cnt = sizeof(buf);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index c866991b9c78..2aaf3030c466 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -2159,6 +2159,8 @@ static inline void sanitize_event_name(char
> *name) struct trace_min_max_param {
>  	struct mutex	*lock;
>  	u64		*val;
> +	u64		(*read)(u64 *val);
> +	void		(*write)(u64 *val, u64 data);
>  	u64		*min;
>  	u64		*max;
>  };

