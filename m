Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AB410D34;
	Fri,  8 May 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262056; cv=none; b=lAlMuW/iR+EOrcJNv8qgtbvVLk3yzOd/gMntatPhkWmb1zsdRmC36HasO3E7OkFRRekneWHBz7NtTvL4c1wsrHw2z9IXTg6WYuHSSMkUuPF7qG6c+iYelvJ/e+WF057bFjiPD1lnTIKyQ7NvOCNGV7KmpNwL0EGFfnS66lI6TyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262056; c=relaxed/simple;
	bh=/XMdVotwUAZISngQqqj5MIoZIgwfggXWKoKAcLMe8cA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZwEVpt37KUSvCjFGVzTqiCdF6WuIa0x8iv6wcntf/YOahdukAFDsPYL7EBkRkkwAjFbMhMjefb0eWiryFw6xaHDofMD9DxLWj57zGcFTT4+TuVcVkQ60ss4Q52xw3BHQUUZ84l0wdjEmJGfjbZkm7sBvwyudmFmc4Zp9EPpsv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iomCB9gP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iomCB9gP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B71AC2BCB0;
	Fri,  8 May 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262056;
	bh=/XMdVotwUAZISngQqqj5MIoZIgwfggXWKoKAcLMe8cA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iomCB9gPhjoBNsOLJ9ZqZ5N6KsyO+HSTdGjXRMgLrWeAuCQzg9NCYnZV5D0xKKh4Q
	 5w8scCy1kL789eFfK4CGcw/9Seh82TvZYFGiCTjOi8qo+eSOYvBPtn4U8YHyJIJz1L
	 0lqs8p8zq4lEtW5Lb6i5hXARsdaZbnyRiclNG8eOhhnJIpn85yMlgo61cCePGmSbeW
	 1JfBlVky+tnpKg6rPd7vMlc+atBvICMGykTbucdnQSqJTIu3OdD/vE202dh6yQLFjW
	 3MzBN9/BhMW5MLCBWnU0najLhjYuyU+Qs7SwJQA8GRsKIerHRjliDnu8eWGrSBX3Xf
	 uud1TPcQLx9fQ==
Message-ID: <4f61457e-deff-430f-8a1e-d3c33c925db3@kernel.org>
Date: Fri, 8 May 2026 19:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/page_alloc: add tracepoints for zone->lock
 acquisitions
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, hawk@kernel.org,
 Dmitry Ilvokhin <d@ilvokhin.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
References: <20260508162207.3315781-1-hawk@kernel.org>
 <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
 <832e4333-4079-4865-8ad8-3dd8868fb964@kernel.org>
Content-Language: en-US
In-Reply-To: <832e4333-4079-4865-8ad8-3dd8868fb964@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 7:38 PM, Vlastimil Babka (SUSE) wrote:
> On 5/8/26 7:29 PM, Andrew Morton wrote:
>> e .configOn Fri,  8 May 2026 18:22:06 +0200 hawk@kernel.org wrote:
>>
>>> Add tracepoints to the page allocator fast paths that acquire
>>> zone->lock, allowing diagnosis of lock contention in production.
>>
>> Thanks, I'm surprised we haven't done this yet.
> 
> There was a recent attempt [1]. Not being a generic solution wasn't welcome.
> 
> [1] https://lore.kernel.org/all/cover.1772206930.git.d@ilvokhin.com/

And this is the generic solution I think?

https://lore.kernel.org/all/cover.1777999826.git.d@ilvokhin.com/

>> Unfortunately "mm: use spinlock guards for zone lock" messed this up
>> (https://lore.kernel.org/all/cover.1777462630.git.d@ilvokhin.com/).
>>
>> So please let's give it a few days for reviewers to comment then redo
>> against mm.git's mm-unstable branch?
> 

