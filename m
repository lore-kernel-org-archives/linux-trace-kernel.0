Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BF23EA94;
	Fri, 15 May 2026 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778813339; cv=none; b=DYNcRAn9soMjo3wSsnmBzXnDsedhgUux4W8eJB0J2121k2bHHAR5cx8JC6t3V32E6gr/T7PSn+GvhwE6X+vnL64gBkxJCzdeUwc9G6eS4zev9pPm7oY9TS9LvCCNJwBQl6If7Dwhpw1Mb3QLTkUTcbYGapATe4BlbtBPjEEX0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778813339; c=relaxed/simple;
	bh=fn3sbyeJ9aEHNIbhoZsLiUWFsuyelp2Mhxp3TMs7gB4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D39dWSVWBoTywD+GN+1z7qvtXH3KvZreo/d3x7nAT48tNELcdUc03uleYTNaQgTWonOi88WNwIS/q75F9N19nsBCIJGNZ1tmkRE0sJsfIjPIcNrplgnQa/q6kv1ZofI2z3TC5QBdQU1HedyDpvJ5hAOy2TQ+8ZsqGMwah9hE+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UceLzAU5; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UceLzAU5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LDl56P9DXVKuA44aEtTZafXcNPo8mzTvmPJnf+zvCjI=;
	b=UceLzAU5LWnH6ecDuxs0dvaKTNCBxHWZJVYhmynLj99oolo66BRueqDrtZvEl5GHHqtqz079y
	p6l+dl5ez/OIOVztmNo1Lb4yqTrnDI7c9E0In0I2Km1Ie2ATtjU2v7IRCIellcwU9+eHDZJYvsL
	aAE/SHAdWnihL1fWkF3AB1Q=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gGrzw194Wz1K9D5;
	Fri, 15 May 2026 10:41:16 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F0B0B40570;
	Fri, 15 May 2026 10:48:52 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 10:48:52 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 10:48:51 +0800
Subject: Re: [PATCH v7 1/6] mm/memory-failure: drop dead error_states[] entry
 for reserved pages
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
References: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
 <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ebbed082-b104-0bb3-94b8-8e96f6f2408b@huawei.com>
Date: Fri, 15 May 2026 10:48:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260513-ecc_panic-v7-1-be2e578e61da@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/13 23:39, Breno Leitao wrote:
> The first entry of error_states[],
> 
> 	{ reserved,	reserved,	MF_MSG_KERNEL,	me_kernel },
> 
> is unreachable.  identify_page_state() has two callers, and neither
> one can dispatch a PG_reserved page to me_kernel():
> 
>   * memory_failure() reaches identify_page_state() only after
>     get_hwpoison_page() returned 1.  get_any_page() reaches that
>     return only via __get_hwpoison_page(), which gates the refcount
>     on HWPoisonHandlable().  HWPoisonHandlable() rejects PG_reserved
>     pages, so they fail with -EBUSY/-EIO long before
>     identify_page_state() runs.
> 
>   * try_memory_failure_hugetlb() reaches identify_page_state() on
>     the MF_HUGETLB_IN_USED branch, but the page is necessarily a
>     hugetlb folio there.  The first table entry that matches a
>     hugetlb folio is { head, head, MF_MSG_HUGE, me_huge_page }, so
>     they dispatch to me_huge_page() before the (now-removed)
>     reserved entry would have matched, regardless of whether
>     PG_reserved happens to be set on the head page.
> 
> me_kernel() never executes and the entry exists only to be matched
> against by code that cannot see it.
> 
> Drop the entry, the me_kernel() helper, and the now-unused
> "reserved" macro.  Leave the MF_MSG_KERNEL enum value in place: it
> remains part of the tracepoint and pr_err() string tables, and
> follow-on work to classify unrecoverable kernel pages can reuse it
> without churning the user-visible enum.
> 
> No functional change.

As the code evolves, this entry is no longer needed. Thanks for cleanup.

> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

With David's comments addressed, this patch looks good to me:

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

