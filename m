Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F01F667B;
	Thu, 24 Oct 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780087; cv=none; b=dks4q5MZccypZefRGcAlfFBAGtpYg6E+tl2h/vDWUoJ9GNnXKUwfUJ12VuMn/9fK8/8AZutFitd+GKWSLYg1XJ8UhVAOjYHQJaPnr80o2XAUqPrn7SExgymO4/5EZxAGuniXkJPxbkADS6vIrzWV4+5abKDZ1xPz0HYSl2NlA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780087; c=relaxed/simple;
	bh=t476ydiJw4Yxe6GO8SwSasYToXGgWXap70lQnOiSPYY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G5phr8fXYOWOx5+9rjCs+4myJRdQhKOovicPQMqsRRR70xi+6WfhSldcY0alNmXYWTvx52qgTmmq7/G0Dq9sBoMFpIgI8UTJ1/NdPJY6+HVshbUJGCQGmfILMVWe0MbkgZAOHyth6+bTUHLW22cppAAL6zy8Fcm4E0nxqGL5j94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsrHhhpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsrHhhpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB11DC4CECC;
	Thu, 24 Oct 2024 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780086;
	bh=t476ydiJw4Yxe6GO8SwSasYToXGgWXap70lQnOiSPYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rsrHhhpIiPkkOjI/h2w0LELI2aDTqIDAsFWc1yNkMlU+q+qeajpojUmzuBNlgEe5x
	 Lxl0bi5/roh0cVZgGBK7uzGMYWW8FBRORaN6qnuyd5QqStb82d8X07RKySPOksd6WO
	 efzS+y4Q5rHaVXzLFLwFGKJCF7Lw1HVeVo2d40t4FSeADBPQNS3RmRZwWSFYlaLqGL
	 HxxBuJpvTpVfenBHR7HTTtRcWTvw3wKnA/86auKyeLw0o0vMcAMGW/Rh02Ujz7u6UZ
	 0nBfzYTRcShZq9RxHsNte9+Nol2wKPUhbKgBtaDlPHOHVgEB/i3Iv4md0H3R0A9K1m
	 s94pE0DN8XHoA==
Date: Thu, 24 Oct 2024 23:28:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <rostedt@goodmis.org>, <dan.carpenter@linaro.org>,
 <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <oe-kbuild@lists.linux.dev>,
 <lkp@intel.com>
Subject: Re: [PATCH v2] fgraph: Fix missing unlock in
 register_ftrace_graph()
Message-Id: <20241024232802.57bb710cc1fee46608c4aed4@kernel.org>
In-Reply-To: <20241024155917.1019580-1-lihuafei1@huawei.com>
References: <20241024155917.1019580-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 23:59:17 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> Use guard(mutex)() to acquire and automatically release ftrace_lock,
> fixing the issue of not unlocking when calling cpuhp_setup_state()
> fails.
> 
> Fixes smatch warning:
> 
> kernel/trace/fgraph.c:1317 register_ftrace_graph() warn: inconsistent returns '&ftrace_lock'.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410220121.wxg0olfd-lkp@intel.com/
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
> Changes in v2:
>  - Use guard() to acquire and automatically release ftrace_lock.
> ---
>  kernel/trace/fgraph.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 41e7a15dcb50..cd1c2946018c 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1252,7 +1252,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	int ret = 0;
>  	int i = -1;
>  
> -	mutex_lock(&ftrace_lock);
> +	guard(mutex)(&ftrace_lock);
>  
>  	if (!fgraph_initialized) {
>  		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
> @@ -1273,10 +1273,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	}
>  
>  	i = fgraph_lru_alloc_index();
> -	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {
> -		ret = -ENOSPC;
> -		goto out;
> -	}
> +	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub))
> +		return -ENOSPC;
>  	gops->idx = i;
>  
>  	ftrace_graph_active++;
> @@ -1313,8 +1311,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  		gops->saved_func = NULL;
>  		fgraph_lru_release_index(i);
>  	}
> -out:
> -	mutex_unlock(&ftrace_lock);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
