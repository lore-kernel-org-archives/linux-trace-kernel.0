Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCE3D891E;
	Thu, 25 Jun 2026 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390189; cv=none; b=ojC8Asad8eQC0yVm1pJlVhqFuhNfAUmBDDdwnfJdfmos2tSo8d0QloC9q7FkJkR6HGrKC04ydZtE6B76qhUOk+ZItz+yH+pm4jHFSx+/ymfTuA9wwOEmJcgfg3nb/LwEofvPTt6QrZxlXE5ReDXak+110JrCquaH1UGAzK/36Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390189; c=relaxed/simple;
	bh=LDEE5G+NOHafeWW3BlHXZZmLZjy75Uy70/2e9B7rEys=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M06yUXymHRVUglGox4sExXvDphKhNWhI/l0yZww4sOsf0uPi7zaCKy5UsacY18N0xw00lEFUl7s6l+Qyr5tf69y7ZxtSiBbDLYgvfjbOTHHLdf+81krXmlxpQNXIFmaxV6d+2+x8RlsU8zLGIHOdlRyoOEJEC455KhJmB3SfpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Pu82SVzy; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Pu82SVzy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DtTrF+dkMhH5wL9XVdpqg+EYpu4n3AZ8BvYl3aOQkWs=;
	b=Pu82SVzyU7dKh9zHrrRfAFclb3zu86TYxOkI5vuEUY0eNHVES52yjxGbOXUnji1L3zyjo7tWr
	hpk2IGB9tsONDex78SNwtga9xcWfokjgnOQKPcT90UfVu7TxF3D3zYuR7ULMeiC3bH5wmKsMKGO
	95g0/YrBB8UU0mZl7x/5OaA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gmHlk23FBzmV6S;
	Thu, 25 Jun 2026 20:13:54 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 820C140539;
	Thu, 25 Jun 2026 20:23:00 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jun 2026 20:23:00 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jun 2026 20:22:58 +0800
Subject: Re: [PATCH v9 4/6] mm/memory-failure: add panic option for
 unrecoverable pages
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
	<lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
 <20260609-ecc_panic-v9-4-432a74002e74@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <80c7ddaa-dd8c-1540-f72e-2a9a56aecdb1@huawei.com>
Date: Thu, 25 Jun 2026 20:22:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609-ecc_panic-v9-4-432a74002e74@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/9 18:56, Breno Leitao wrote:
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

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
