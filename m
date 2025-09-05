Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA707225761;
	Fri,  5 Sep 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112269; cv=none; b=XzKZ3m2JRiGAN815DNWcNAY4QJIydzD/Gyt/UcIrIH7N+n071wkGZNpjRp60yR524ptFmPntYQOw66R1rmHwpQQybxrUTspCpP5tKhkbsv4BNt09S/4M79c1qDoQt0K+XZ5BVCOkIVJuSu9MKcxc+UbTltHEHYi9h4IgVpcyF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112269; c=relaxed/simple;
	bh=b4E7YUBbTxDl1IdysgCGqbCapfo4w1LJG0OG5yD8YxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6Wy7GZdPyu242O+lKvdzZWhif/6LUBaABc4IicjPC2kpWe1vfThJ8kpaziR2aKgbZ3gjv9KtE+HxpyM4aTcSJ7qSd00qq7n5/0Ga773K+qZh7zAEapbb3SXI85j0yEXSA4I8xKnSgD0RvnLJxpkWNc0ZaNv1aQHNpZSYVjpUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EAC60855CF;
	Fri,  5 Sep 2025 22:44:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id DDBB92F;
	Fri,  5 Sep 2025 22:44:16 +0000 (UTC)
Date: Fri, 5 Sep 2025 18:44:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <tglozar@redhat.com>, <yuehaibing@huawei.com>,
 <zhangchangzhong@huawei.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] tracing/osnoise: fix null-ptr-deref in
 bitmap_parselist
Message-ID: <20250905184456.084d1ff3@gandalf.local.home>
In-Reply-To: <20250905032544.231962-1-wangliang74@huawei.com>
References: <20250905032544.231962-1-wangliang74@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: DDBB92F
X-Stat-Signature: sjoifturoeki6aihikoggsk8y3dmy1i3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SWaqcfkOCS2nIjaR4KErsCdEd0BUKlF0=
X-HE-Tag: 1757112256-800584
X-HE-Meta: U2FsdGVkX18i4FTtYOVj3V6ntD6buYHMMmm1w5EGeVUV8ilFeNUH4cD91YMIjgLLGmdtEh3QFPa47ad2xaJFpqrOMJOKOmJ0BPjO5iaHAKHv5O1um9Sq3i+bpx9zyLvWJTPYXkIfM2uYlqQoteurtVZkcwiMSRIo351D+3kVWotfElcvezUibVNR1Ub3p+Rv1EPmFYcec3mMRNk7u333XRwkgNPWr1dO3DQyk28jfb6N2JSD0doxzDYEOfmSR/Q3vCRceiq9WxGDUp+R260OWd5qOAsVXqiF/gzCe5wEzaFWUzz3V3QDHQIVf5BVwFFFVFNhzdC7fhMOJyTEkYK9q9nuYM+SOAj0

On Fri, 5 Sep 2025 11:25:44 +0800
Wang Liang <wangliang74@huawei.com> wrote:

Hi Wang,

FYI, the tracincg subsystem requires capital subject:

  tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()

And parenthesis for function names.

> A crash was observed with the following output:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 2 UID: 0 PID: 92 Comm: osnoise_cpus Not tainted 6.17.0-rc4-00201-gd69eb204c255 #138 PREEMPT(voluntary)
> RIP: 0010:bitmap_parselist+0x53/0x3e0
> Call Trace:
>  <TASK>
>  osnoise_cpus_write+0x7a/0x190
>  vfs_write+0xf8/0x410
>  ? do_sys_openat2+0x88/0xd0
>  ksys_write+0x60/0xd0
>  do_syscall_64+0xa4/0x260
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> This issue can be reproduced by below code:
> 
> fd=open("/sys/kernel/debug/tracing/osnoise/cpus", O_WRONLY);
> write(fd, "0-2", 0);
> 
> When user pass 'count=0' to osnoise_cpus_write(), kmalloc() will return
> ZERO_SIZE_PTR (16) and cpulist_parse() treat it as a normal value, which
> trigger the null pointer dereference. Add check for the parameter 'count'.
> 
> Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  kernel/trace/trace_osnoise.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index fd259da0aa64..edf5178d0317 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2322,6 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>  	int running, err;
>  	char *buf __free(kfree) = NULL;
>  
> +	if (count < 1)
> +		return -EINVAL;

Sending a count of 0 is not invalid. This should simply return 0;

-- Steve

> +
>  	buf = kmalloc(count, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;

