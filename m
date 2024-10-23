Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E620199934;
	Wed, 23 Oct 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675793; cv=none; b=BZuR/efMER9zqbxJBYmKJXTzsnk61XwB5DvcKKaWtYPSA5AVzFx+NTA8jXQHcQGravU3+wsbjUCIH9aA88bJUK7c9gxLHM6FUP+29UbDLBpzdEBw+sl9+snk4jRrn6JKFOvCX/xThGcruS3n5W0TExM5fEzNYCtFItWChLp/oJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675793; c=relaxed/simple;
	bh=CeptQilqR5aeHrn6R/5BUuZVBe5RfsLmTrtKIzphXYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVIvWbI/Q5jwW0MCEBsR8e9+agf7Z8tx4XGd1d8tuskEmTkzCIGIr532M9GKJV8nNdmPbMbxm5b8CH7FOmGZDtFhMpai4wXoeFh2lInvbYPZ3A5Hezl3TTCsJ8ikm1EtRIWJCG51E1TyG7noHMmHJKsfclDTT155b3ZCQQ0kvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1527EC4CEC6;
	Wed, 23 Oct 2024 09:29:51 +0000 (UTC)
Date: Wed, 23 Oct 2024 05:29:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <dan.carpenter@linaro.org>, <mhiramat@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <oe-kbuild@lists.linux.dev>, <lkp@intel.com>
Subject: Re: [PATCH] fgraph: Fix missing unlock in register_ftrace_graph()
Message-ID: <20241023052948.0285eb2c@rorschach.local.home>
In-Reply-To: <20241023170448.808512-1-lihuafei1@huawei.com>
References: <20241023170448.808512-1-lihuafei1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 01:04:48 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> Instead of returning an error, goto the mutex unlock at the end of the
> function.
> 
> Fixes smatch warning:
> 
> kernel/trace/fgraph.c:1317 register_ftrace_graph() warn: inconsistent returns '&ftrace_lock'.
> 
> Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410220121.wxg0olfd-lkp@intel.com/
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/trace/fgraph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 41e7a15dcb50..98fa7b2a4903 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1259,7 +1259,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  					fgraph_cpu_init, NULL);
>  		if (ret < 0) {
>  			pr_warn("fgraph: Error to init cpu hotplug support\n");
> -			return ret;
> +			goto out;
>  		}
>  		fgraph_initialized = true;
>  		ret = 0;

Actually, I'm thinking we just should use guard(mutex)(&ftrace_lock);

-- Steve
