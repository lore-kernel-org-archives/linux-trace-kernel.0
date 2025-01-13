Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077B136351;
	Mon, 13 Jan 2025 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736738972; cv=none; b=sGeiva0SszCdCYvOHhZ+I4NobFn+8AunsFH3OF0QVLl/bEzNjy6qQZg3KF2U8/s3Mlj6cBn8lqZjxZ5a2DnMeO3pVv5sFbsc5UOfOgkMtVWSXu6MvSg0Vd8WXreuaB5JbzxFwLC58eLKOjQcfhn9O+gpEv5XZ6IgDkoDF46CCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736738972; c=relaxed/simple;
	bh=hY7ztXHLiizNckQ3rP6H9P3/p7bmZv2bbJOtRO+NEDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kBZ34aVOtMV0eiC6VWvSJAp3B2csH1X7Qhdc3FwOwax+UiQvU5r/7ULnKkxV0X1MSljE0sVAREIJjQzLpQPNjkD/1FqKBrxhqq5Ao2BxS0tSmjO87quyw6dhcQemIx4wUw57qhosr8BlP7EqCPn4C+Ywnse4BYlHUBLHaahx7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YWd1p07gjz1W44j;
	Mon, 13 Jan 2025 11:25:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D7951180087;
	Mon, 13 Jan 2025 11:29:21 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 11:29:18 +0800
Message-ID: <b5c16ffd-d70f-48b1-b026-79dc5ff4ffaf@huawei.com>
Date: Mon, 13 Jan 2025 11:29:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: check dir in trace_hugetlbfs_alloc_inode
To: zhuxiaohui <zhuxiaohui400@gmail.com>, <muchun.song@linux.dev>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>
References: <20250113030702.58502-1-zhuxiaohui.400@bytedance.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250113030702.58502-1-zhuxiaohui.400@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/1/13 11:07, zhuxiaohui wrote:
> From: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>
> 
> Anonymous huge page has no corresponding directory inode,
> which cause a null pointer crash when access dir with the stack
> 
>    trace_hugetlbfs_alloc_inode
>    hugetlbfs_get_inode
>    hugetlb_file_setup
>    ksys_mmap_pgoff
> 
> Signed-off-by: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>
> ---
>   include/trace/events/hugetlbfs.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
> index 8331c904a9ba..5daa52053edc 100644
> --- a/include/trace/events/hugetlbfs.h
> +++ b/include/trace/events/hugetlbfs.h
> @@ -23,7 +23,9 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
>   	TP_fast_assign(
>   		__entry->dev		= inode->i_sb->s_dev;
>   		__entry->ino		= inode->i_ino;
> -		__entry->dir		= dir->i_ino;
> +		__entry->dir		= 0;
> +		if (dir)
> +			__entry->dir	= dir->i_ino;
It has been fixed in [1] by Muchun.
Thanks,
Hongbo

[1] 
https://lore.kernel.org/lkml/20250106033118.4640-1-songmuchun@bytedance.com/T/
>   		__entry->mode		= mode;
>   	),
>   
