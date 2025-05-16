Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAE3D69;
	Fri, 16 May 2025 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747365660; cv=none; b=WofnVF2r2Er7ubX+TGKxafnmeRP048w388KNkalEKj/4nqdgSRU9QeqjY0qhIAXB5BvYXg61JqvbTWxRYzgR/JEoj3ejhGfuwrOw0X2V69L2XSeRmAfi39AZCIwwLjitH1fJI6MYG8IOeVUpRr1YcuR1ufzVhHmSED/GT1q2X6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747365660; c=relaxed/simple;
	bh=hO+rR+dWcD6f6Hge8HMHr7Cb8QAg8f4oCX2KJ+iFwGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThYBdsP6hx/dFQoSi5G7HUkYLbGRsGFAJWJiJ/JAQDeoGjHA+G1N/dpvlG0riiLGbzy6n/JSHiX1Teek4gatIb11DwM8C2ow3S/IBdQuC8K4jMp3Ihc9gVZBEf6Gt0B4YyCfWQGKq9yzW/VnFclJZPOzTiQwBn6BJSx5ZX8PoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qe2vQ5ES; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qe2vQ5ES"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747365649; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GExNtFmUWMDmQxbl32tS+x8auE8iVSf/kkBrvwmxa6I=;
	b=Qe2vQ5EScnbO8JSIBIePdAgK5F+iwDwlWl4bdEp+3E8ZhAvyGiZWaPpNeFweKwaA47898Zp+6bEWBnG3dJzSHeqU9toaqcH4ZkIRu6WDU1KY6NNykvf05JhEu8cdGtExjm1413XDlB0o+ABqA7EsEcKGnXWpLXF9nuxHV1pkib0=
Received: from 30.74.144.109(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WatldDB_1747365643 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 May 2025 11:20:45 +0800
Message-ID: <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
Date: Fri, 16 May 2025 11:20:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-7-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250515032226.128900-7-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/15 11:22, Nico Pache wrote:
> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> To add mTHP support we use this scan to instead record chunks of utilized
> sections of the PMD.
> 
> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the anon PMD. A minimum collapse order of 2 is used as this is
> the lowest order supported by anon memory.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> When attempting to collapse an order that has its order set to "always"
> lets always collapse to that order in a greedy manner without
> considering the number of bits set.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

Sigh. You still haven't addressed or explained the issues I previously 
raised [1], so I don't know how to review this patch again...

[1] 
https://lore.kernel.org/all/83a66442-b7c7-42e7-af4e-fd211d8ed6f8@linux.alibaba.com/
