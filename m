Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249D34CFD3;
	Tue,  2 Jun 2026 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383940; cv=none; b=px4oaP0bPqGebFiyo7ry2ySCDA/yn845ra6Nc+5e1jvguO+wfBMPXn5UG3XM7qj3AEkO8vQ0ipNetSI8vpu5NnAfK0N6WP2x/ZqbmWJwjgSENX9j36IYOMXQQvtfg3tI2Xejq4IGz5vQDP0Kl/n0apHB2ETRerjk6NwGMlHEBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383940; c=relaxed/simple;
	bh=IYeo6c8VaIc0I6De68d9Dc6uoh6+x0T5ZPPO2A/0xnY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CYFTwAc6XqpjTQjNEWplBVmE8IdztowjGtAgRUuL5m7ADadP4MwA/ueuY3EnpbUA+/SFWHONbcpVi9lQoO3b6q6Ek4F7yxVHRFEzWHSv4iHnazNSXBEHFA4aSc1I/UB9A0JItUMPsIVBW7P/iz2hCthiIg6JqnDXXRluW/krPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Bs1n6fFK; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Bs1n6fFK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ywNJBGpmmj9NFHoVdWRVSdCZGNodVCyyTVIIC+PjNKE=;
	b=Bs1n6fFKha43sqYhA2tcjSKsQDx7BaUGA6NUMdju6QLI/zIcoj6MivYNkd4KB5UzwgTwlRGRz
	DBaCYzG3lmH9nMWSDaCaN/QE0DF2txBBIS+FXHu0AyqAciCTvM6wFX81QkZB7TvYIsS+e91oBXo
	OMxjbX/ncrB1e4iZFAn9le4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gV1q845Hhz1T4fx;
	Tue,  2 Jun 2026 14:57:24 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C5BA4056D;
	Tue,  2 Jun 2026 15:05:34 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 15:05:33 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 15:05:32 +0800
Subject: Re: [PATCH v8 4/6] mm/memory-failure: add panic option for
 unrecoverable pages
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-4-9ea0cfa16bb0@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4d7b720a-7975-8a4d-a00e-e888d63812a0@huawei.com>
Date: Tue, 2 Jun 2026 15:05:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260527-ecc_panic-v8-4-9ea0cfa16bb0@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/27 22:06, Breno Leitao wrote:
> Add a sysctl panic_on_unrecoverable_memory_failure (disabled by
> default) that triggers a kernel panic when memory_failure()
> encounters pages that cannot be recovered.  This provides a clean
> crash with useful debug information rather than allowing silent
> data corruption or a delayed crash at an unrelated code path.
> 
> Panic eligibility is intentionally narrow: only MF_MSG_KERNEL with
> result == MF_IGNORED panics.  After the previous patch, MF_MSG_KERNEL
> covers PG_reserved pages and the kernel-owned pages promoted from
> get_hwpoison_page() via -ENOTRECOVERABLE (slab, page tables,
> large-kmalloc).
> 
> All other action types are excluded:
> 
> - MF_MSG_GET_HWPOISON and MF_MSG_KERNEL_HIGH_ORDER can be reached by
>   transient refcount races with the page allocator (an in-flight buddy
>   allocation has refcount 0 and is no longer on the buddy free list,
>   briefly), and panicking on them would risk killing the box for what
>   is actually a recoverable userspace page.
> 
> - MF_MSG_UNKNOWN means identify_page_state() could not classify the
>   page; that is precisely the wrong basis for a panic decision.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/memory-failure.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 14c0a958638c..dcd53dbc6aec 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -74,6 +74,8 @@ static int sysctl_memory_failure_recovery __read_mostly = 1;
>  
>  static int sysctl_enable_soft_offline __read_mostly = 1;
>  
> +static int sysctl_panic_on_unrecoverable_mf __read_mostly;
> +
>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
> @@ -155,6 +157,15 @@ static const struct ctl_table memory_failure_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
> +	},
> +	{
> +		.procname	= "panic_on_unrecoverable_memory_failure",
> +		.data		= &sysctl_panic_on_unrecoverable_mf,
> +		.maxlen		= sizeof(sysctl_panic_on_unrecoverable_mf),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
>  	}
>  };
>  
> @@ -1255,6 +1266,15 @@ static void update_per_node_mf_stats(unsigned long pfn,
>  	++mf_stats->total;
>  }
>  
> +static bool panic_on_unrecoverable_mf(enum mf_action_page_type type,
> +				      enum mf_result result)
> +{
> +	if (!sysctl_panic_on_unrecoverable_mf || result != MF_IGNORED)
> +		return false;
> +
> +	return type == MF_MSG_KERNEL;

Would it be more straightforward to write as something like:

if (!sysctl_panic_on_unrecoverable_mf)
	return false;

return (type == MF_MSG_KERNEL && result == MF_IGNORED);

Thanks.
.
