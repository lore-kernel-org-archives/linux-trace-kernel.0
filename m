Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA919ABC6;
	Thu, 28 Aug 2025 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346581; cv=none; b=RksJnHjVhHy6ooYfFs3Fr7HUAx7Us5meVuRMHDgAaQOI/r1zdlDUU1DZ9aiqA/EWeKfGwVv8Eco7U/0NdT6SPM52+UTIXdMXtMVzSsIDN4eT6cOKbfcwzlG42T7pkyVNp3F+QgMJ6SLP0ZtJoFH4KmMLd9vOxVgRRMTRsJXke7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346581; c=relaxed/simple;
	bh=mYAnP+HruVA69djouFy3l2Jw0RHQipvEnoSFqJXv/No=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VWz/1NQd5CTyq9ITxZO/WXc+bt7oRos7nFT0WZ7n7N6sdAW1rUG0GJjW1GjLnuUydJhWX00EJ/BXNQQlrMksWA8DH08BzKgPYhsAYUn9SRlnnYyPjQG3Upuwn05TN4x/GK64FXnBxy6+OmUVmx8FzHfd3XvwCshpKIN3xYsBQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cC4LY5T8Nz2CgPF;
	Thu, 28 Aug 2025 09:58:29 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EA3F51A016C;
	Thu, 28 Aug 2025 10:02:55 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 10:02:55 +0800
Message-ID: <d759c163-9673-48e5-bd6b-49446511b7e0@huawei.com>
Date: Thu, 28 Aug 2025 10:02:54 +0800
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
To: Pu Lehui <pulehui@huaweicloud.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250821071721.3609109-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/8/21 15:17, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When trace_get_user in trace_pid_write parses an only space, the
> !trace_parser_loaded branch will break with no errno, causing
> tr->filtered_pids to still be assigned with pid_list, which may trigger
> potential problems.

Gentle ping~

Hi all, Is this commit looks proper?

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
