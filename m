Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EE228CBC;
	Mon,  1 Dec 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615128; cv=none; b=g1n7ELAHhzXSYZYiXuEeENlqUgwJwMqBsQ4GzhhvKSZJYvPpPE4Pn9crRqTlPiG44wJKUxNdPmqPc5AW0s6czhgVMUobxuVKZ5bHFi/ZaTEkCvtHl46w//YNSPkLYXn0Pzw0srqIhTBtDGkn5zakAxnDWDtvT4XEL34IjXFixjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615128; c=relaxed/simple;
	bh=DIF8oHTepnEKrgtFlwXDpYKU3YY0nciGdB6ip0eoMyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwYtBtEndT0us9cLA2OVgr0sIAsVa6FBMkPNYTw5iHA3pN8YzthtyZ+RLDBZEjvNLKRB5kluoEE7rw3/bHqa/pCoDqrOndcXbBb016ILzsr9kOGzfMNXxT5vyhhjW/NpEtmfw0c0rne7K3/s7KaaETNV5iVii0eTcRp+QJajZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=spyrard9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="spyrard9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xQq4Rf5YSiH+AQ90gnOGfpSOtl9SH4z0g6Tkfjuou4Y=; b=spyrard9ft38aVkUTVLqOnaXoy
	L82PpgzGDfcKbkfXHJM6M4CzE35OypceQzerURz2c6et4IIKzwYTSuVmwCFe+xWk9Y4PGz60rKkp/
	Xna952z0RlkEgKcWvgVXfXNiqJRr+T8hAaMqdBeC9uylxwUZpFrMutDf7hoQavBZ1BgCBqr/W9Uc4
	yNZXeanoXMIN67wcFvxcus5BgKelqc+TftabDLzPz97uGIG2lsKbSA3Bp7MfJ3zJUdEH9l8GHR3+M
	wvYwq3pmOjE/RT/0WxmBTO+NT19K0d6bMu7LuVguxhORnIAktTZBRo2CzCaZOOfiq/81kNaVKPndK
	DFJ8NIKg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ90E-00000004RVo-0I4R;
	Mon, 01 Dec 2025 18:52:02 +0000
Message-ID: <37934c20-4cf9-480f-847d-212e7efb350a@infradead.org>
Date: Mon, 1 Dec 2025 10:52:00 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 mm-new 16/16] Documentation: mm: update the admin
 guide for mTHP collapse
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, hughd@google.com,
 richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
 rppt@kernel.org, jannh@google.com, pfalcato@suse.de,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-17-npache@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251201174627.23295-17-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/25 9:46 AM, Nico Pache wrote:
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidance on how to utilize it.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 48 +++++++++++++---------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index d396d1bfb274..87bcfa80886a 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,8 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages of either PMD size
> +or mTHP sizes, if the system is configured to do so

                                                    so.

>  
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -219,10 +220,10 @@ this behaviour by writing 0 to shrink_underused, and enable it by writing
>  	echo 0 > /sys/kernel/mm/transparent_hugepage/shrink_underused
>  	echo 1 > /sys/kernel/mm/transparent_hugepage/shrink_underused
>  
> -khugepaged will be automatically started when PMD-sized THP is enabled
> +khugepaged will be automatically started when any THP size is enabled
>  (either of the per-size anon control or the top-level control are set
>  to "always" or "madvise"), and it'll be automatically shutdown when
> -PMD-sized THP is disabled (when both the per-size anon control and the
> +all THP sizes are disabled (when both the per-size anon control and the
>  top-level control are "never")

                         "never").

>  
>  process THP controls

[snip]


-- 
~Randy

