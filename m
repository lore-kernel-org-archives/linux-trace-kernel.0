Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEA273810;
	Wed,  3 Sep 2025 04:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872923; cv=none; b=j917O72SM+Om1I1/3AzWIsUlxdGqtVhJ3lHHLetuYtGmqTXenrhkNQwgyhDm+ya2ctvrU7lGgZgEw8jeSbgd6huK+cSkDBJYEhNYRd7VvnF/7/GATHZh740hS7hLpXYd0W7wXrgr+hkSV7m5c9iFUPYYTBrZDLkWoW9FZETfeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872923; c=relaxed/simple;
	bh=GuRr763jlK6fbSSNGrRKUXsei1H3/BG5/gQDE61R2d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ud5EnafJ/Km1yF0G5Wgrh8jNq5OR3nL0gDI7zTS9t7PJI6IYUiV54FhgX7btOPm/Z5RYss6Jtmh+kyvZIOiJ9LCiwCP7pCrN2f2o2q5ZCdPB2L7pGi/kcsMTtDqqj8I51N6W/tcCl8xnl3nCYVX1ClgwP6ttBR/PfBZcz9eSFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cGq5R3y3bz14MXT;
	Wed,  3 Sep 2025 12:15:07 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 82A5514027D;
	Wed,  3 Sep 2025 12:15:17 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 12:15:16 +0800
Message-ID: <e3c22d00-1a0c-45e0-bc76-955d367ab4d1@huawei.com>
Date: Wed, 3 Sep 2025 12:15:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Content-Language: en-US
To: <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, Pu Lehui
	<pulehui@huaweicloud.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250821071721.3609109-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2025/8/21 15:17, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When trace_get_user in trace_pid_write parses an only space, the
> !trace_parser_loaded branch will break with no errno, causing
> tr->filtered_pids to still be assigned with pid_list, which may trigger
> potential problems.

Hi Steven,

Sorry, this patch will break the cleanup functionality of 
"set_ftrace_pid" as indicated in [0]. Pls ignore this patch.

Link: https://lore.kernel.org/all/202509022339.ae20a8bb-lkp@intel.com [0]

> 
> This patch will also silence the fault injection syzkaller warning in
> tracepoint_add_func [0]. We can reproduce the warning by following the
> steps below:
> 1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
>     and register sched_switch tracepoint.
> 2. echo ' ' >> set_event_pid, and perform fault injection during chunk
>     allocation of trace_pid_list_alloc. Let pid_list with no pid and
> assign to tr->filtered_pids.
> 3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
>     tr->filtered_pids.
> 4. echo 9 >> set_event_pid, will trigger the double register
>     sched_switch tracepoint warning.

As for this fault injection syzkaller issue, shall we need to silence 
it? How about the below fix?

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e6b50b416e63..c17c031e7917 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -834,7 +834,11 @@ int trace_pid_write(struct trace_pid_list 
*filtered_pids,
                 /* copy the current bits to the new max */
                 ret = trace_pid_list_first(filtered_pids, &pid);
                 while (!ret) {
-                       trace_pid_list_set(pid_list, pid);
+                       ret = trace_pid_list_set(pid_list, pid);
+                       if (ret) {
+                               trace_parser_put(&parser);
+                               return ret;
+                       }
                         ret = trace_pid_list_next(filtered_pids, pid + 
1, &pid);
                         nr_pids++;
                 }

> 
> Link: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com [0]
> Fixes: b27f266f74fb ("tracing: Fix return value of trace_pid_write()")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   kernel/trace/trace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8d8935ed416d..feeb7eb71318 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -853,10 +853,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
>   		ubuf += ret;
>   		cnt -= ret;
>   
> +		ret = -EINVAL;
>   		if (!trace_parser_loaded(&parser))
>   			break;
>   
> -		ret = -EINVAL;
>   		if (kstrtoul(parser.buffer, 0, &val))
>   			break;
>   
