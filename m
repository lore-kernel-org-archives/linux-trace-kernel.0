Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9C267B6F;
	Thu, 13 Mar 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877091; cv=none; b=olM095cG4ahaXUPaMeT+n3VjxAakT5NKGvIqWR4TWiTdPxdyA0QaRpSS3mRmbBdZbzIDQyaol1eVRhDzpgtk9F/8RB0VOIuPyHsmf1OmO0RlA1Lit3MqFYb/rB/Mtj7lpUEsEqJ4yO20tUr78v2m3gewlDV1AAsaZoqaSC4I1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877091; c=relaxed/simple;
	bh=l7GsMMZMGmSfErdZ8McttU2Xh1wov44VSJprx2ImFro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsZN6z2ydUQkM380OxkMzXU41IGGlizaegVEin5M6BNhXINseU0XCpeX1CwV08eIZiZKKdQAy3rYN4tS0paa2AMl6eadpSiLGieKoFEMy6EwEmt2fZRP4/sqmAssnmWEpwqsoW6q92iZz1GZ7AlOfa4IKcAiTfqRMFJDddMJkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2084C4CEDD;
	Thu, 13 Mar 2025 14:44:49 +0000 (UTC)
Date: Thu, 13 Mar 2025 10:44:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Zheng Yejian <zhengyejian1@huawei.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Correct the refcount for hist/hist_debug file
 if single_open() fails
Message-ID: <20250313104446.7b31820e@batman.local.home>
In-Reply-To: <20250313103719.1191073-1-wutengda@huaweicloud.com>
References: <20250313103719.1191073-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 10:37:19 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

> The function event_{hist,hist_debug}_open() maintains the refcount of
> 'file->tr' and 'file' through tracing_open_file_tr(), but it does not
> roll back these counts when the subsequent single_open() call fails,
> leading to a refcount leak.
> 
> A very obvious case is that if the hist/hist_debug file belongs to a
> certain instance, the failure of single_open() will prevent the deletion
> of that instance, as it relies on the condition 'tr->ref == 1' within
> __remove_instance().
> 
> Fix this by calling tracing_release_file_tr() to correct the refcount
> when single_open() fails.
> 
> Fixes: 1cc111b9cddc ("tracing: Fix uaf issue when open the hist or hist_debug file")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> Cc: stable@vger.kernel.org # v6.7+
> ---
>  kernel/trace/trace_events_hist.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index ad7419e24055..900b06fa8505 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5702,8 +5702,10 @@ static int event_hist_open(struct inode *inode, struct file *file)
>  	/* Clear private_data to avoid warning in single_open() */
>  	file->private_data = NULL;
>  	ret = single_open(file, hist_show, hist_file);
> -	if (ret)
> +	if (ret) {
>  		kfree(hist_file);
> +		tracing_release_file_tr(inode, file);
> +	}

Hmm, this function has a couple more error path exits after taking the
ref count. If this is to be fixed, let's fix it completely. Each of
those error paths need to call tracing_release_file_tr().

-- Steve


>  
>  	return ret;
>  }
> @@ -5979,7 +5981,10 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
>  
>  	/* Clear private_data to avoid warning in single_open() */
>  	file->private_data = NULL;
> -	return single_open(file, hist_debug_show, file);
> +	ret = single_open(file, hist_debug_show, file);
> +	if (ret)
> +		tracing_release_file_tr(inode, file);
> +	return ret;
>  }
>  
>  const struct file_operations event_hist_debug_fops = {

