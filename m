Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A722AE7F;
	Sat,  6 Sep 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757174973; cv=none; b=PMTVXbUjgb4ZpRji3urvWzXxpGPRY6vAyQRX0XzijDWs69mPn4JnZWzmB7GCPknX3lH/0MHuK23Fl464SP+n7H9fpY72MBzCBahd7a7li89uhoAk6p0iJyd0SfP3vlcpbVU0wHC1DA3Lvy7mG2A2o5e0FXYmgDELbG5FrWvvg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757174973; c=relaxed/simple;
	bh=ZVMnFSiSfId55V+CDp45AtQsnYf+aWQvUGnkZ+tpdUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq5lDzp9VHIEyP3YH98eZzlnqF6cKcWinNTtzamVgpEyvGchWUvDJmmi28I7qRZN0sxLIe7V/aRb8zMDSzMNn2ZhrRQGvSWbF6aZh1KEb/B9IXI4Pc7n6nZbsJj83puYj+z63TTGpwOxbNhModXfBIflVL+S5GMOT4u4SmVB+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CCFA81DEB15;
	Sat,  6 Sep 2025 16:09:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id E16B92000D;
	Sat,  6 Sep 2025 16:09:26 +0000 (UTC)
Date: Sat, 6 Sep 2025 12:10:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <tglozar@redhat.com>, <yuehaibing@huawei.com>,
 <zhangchangzhong@huawei.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/osnoise: Fix null-ptr-deref in
 bitmap_parselist()
Message-ID: <20250906121007.5ceb3436@gandalf.local.home>
In-Reply-To: <20250906035610.3880282-1-wangliang74@huawei.com>
References: <20250906035610.3880282-1-wangliang74@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1wkxw71sn6a7x1od7ec9zyyxscasf8nt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E16B92000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18s3X8X1w8plByCinU/NOmjwVSy8nGncNk=
X-HE-Tag: 1757174966-487100
X-HE-Meta: U2FsdGVkX1/k2vEet8ITzYIMZSz2CbnnnDo5IHtKNKv+JJ+vbWfowAYjjsVjkcE5SqQaTUNzZ28wsPtZtOTc6eZzIiP6ElQauKGb08HCYcsKs47i723FVegAE9uRM1JJWdAH/PGzAeOvc9to/y/tYsSaD5MVVrNQPDCvelUW4dEkPYWS3fpSDsagAayH0aylUigDMXYoSvO5EB1v0UHoAFO6Fqxy+f8VYR4AByzOLGllECeZxwmro4HoLxwzwXd7cEv8p7KIYfaBpiKtGxDiyxxMi00jG7qh1ZmfrLFOP8ZmiRJ3/rFjWLV2DkPWCQluLmOA/5vt13czUr+TxqntmaJ0xaE3drigyIcIAldv1a1o8hOwwLTgoA==

On Sat, 6 Sep 2025 11:56:10 +0800
Wang Liang <wangliang74@huawei.com> wrote:

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
> Link: https://lore.kernel.org/all/20250905032544.231962-1-wangliang74@huawei.com/
> Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
> v2: return 0 when sending a count of 0.

FYI, I usually have this say:

Changes since v2: https://lore.kernel.org/all/20250905032544.231962-1-wangliang74@huawei.com/

and list the rest.

I know Linus doesn't like links to the patch, but I find them useful, and
even more useful when the patch has a link to previous versions. ;-)

I see that you did add it to the "link" above, which is probably fine too.

-- Steve

> ---
>  kernel/trace/trace_osnoise.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index fd259da0aa64..337bc0eb5d71 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2322,6 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char
> __user *ubuf, size_t count, int running, err;
>  	char *buf __free(kfree) = NULL;
>  
> +	if (count < 1)
> +		return 0;
> +
>  	buf = kmalloc(count, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;

