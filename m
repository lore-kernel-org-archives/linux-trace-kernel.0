Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF72D7814;
	Tue,  2 Jun 2026 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371091; cv=none; b=ms4qRzq5iJkcnx5iBgTSPx/KSGA6WSlJ0NnecgCqSJejT9LD/3ObqN7vytT82UVKJfom5l72ZWrAi+3GSjJiNULcref04tDp1QDqGBlqOfdIrXueyVigz+LEs5CbHNmMJA5Cye/w5dh6mA4X2IhY5BLFy4258ffpgWScUfTiRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371091; c=relaxed/simple;
	bh=H+LYvqr7shSZ2FXiWbX0Oc1bgeW/7ID/d53Wfv1nfxM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UiJV5bkJC2k1yT4Umh4DKmVFTy6HpAdZoKtvHryowDiiMOQs2Jm/mXRUYFpAnRDv9vLEI3UKWTgDf4NeHfvrP8aypf+WG5JK2NdWqqWjd/fix8hhdU80hFdXVd+l3Hyg2uUXAwEp1oXNVDXePId0kQ5JCwd6TJ6DODaYEHDtNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rUbsWu8t; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rUbsWu8t"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eKjT6Zg4boSSOeRK+U8oV+FxAjxZtDyhnFgmKfmpDas=;
	b=rUbsWu8t2d2azz8Ev4bysq6LLCcJ/SHmOo0GFrdvlUOILVf2ZXLEW8XEljU1G4WVXJ3vLafjF
	YX68s2tIiko1MsBkDrbA7z1MYsikporFc7syk5ZlzwtT7H9hvc1crRbFfWDTmaDWX245QZQ/0B+
	PCcJvZW5kHYoz43eLR/pMXQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gTx4H0Gt7zcb0N;
	Tue,  2 Jun 2026 11:23:27 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D0274056A;
	Tue,  2 Jun 2026 11:31:24 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 11:31:23 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 11:31:22 +0800
Subject: Re: [PATCH v8 3/6] mm/memory-failure: report MF_MSG_KERNEL for
 unrecoverable kernel pages
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
 <20260527-ecc_panic-v8-3-9ea0cfa16bb0@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <642852e1-933a-a6f6-b6e8-2ef3339bcd58@huawei.com>
Date: Tue, 2 Jun 2026 11:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260527-ecc_panic-v8-3-9ea0cfa16bb0@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/5/27 22:06, Breno Leitao wrote:
> The previous patch teaches get_any_page() to return -ENOTRECOVERABLE
> for stable unhandlable kernel pages (PG_reserved, slab, page tables,
> large-kmalloc).  memory_failure() still folds every negative return
> into MF_MSG_GET_HWPOISON, so callers that want to react to the
> unrecoverable cases (a panic option, smarter logging) cannot tell
> them apart from transient page-allocator races.
> 
> Turn the post-call branch into a switch over the get_hwpoison_page()
> return code: map -ENOTRECOVERABLE to MF_MSG_KERNEL and any other
> negative return to MF_MSG_GET_HWPOISON.  case 0 keeps the existing
> free-buddy / kernel-high-order handling and case 1 falls through to
> the rest of memory_failure() unchanged.
> 
> The MF_MSG_KERNEL label and tracepoint string are kept as
> "reserved kernel page" to avoid breaking userspace tools that match
> on those literals; the enum value still adequately tags the failure
> even though it now also covers slab, page tables and large-kmalloc
> pages.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
