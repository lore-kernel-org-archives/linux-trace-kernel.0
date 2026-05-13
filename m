Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813904534B9;
	Wed, 13 May 2026 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684440; cv=none; b=e/3vDi0fzlQfpnESbs5OUWXQet6GU+F3IgSdIxSV7uIJRPYz+abY5pOmnSgldd+2gpd2MivuDOCuGMWPaKX6eb5cUwpt38RwzS7Sv/LpLgEQgaJh97FqmYFPG6H7DHPor7/+iRtx1MeWGbo/JmV/Jj4kN4Q+ocwhc8KKDdrfKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684440; c=relaxed/simple;
	bh=rFQxbFf+d5v40nY8+ULLt7p0+NDFB26iq1h3cbEuAmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeAsnlcS9+BLhRrW5lIAfXDsSgHY/6N0r6PQINhtijdvOBC8+EcRYaNuMqDq2G5J7w4UVxk0eU7+9YK2Oyp04OgTkW2t7W0f2lvWGZ4xBRV5K21MBWZHKCJeFw3vU1r/RYbgdhJiR8wLyx4cA4UXq/g1a8TYPN+oB91IKCj7H80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxinpcWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxinpcWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6067DC19425;
	Wed, 13 May 2026 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684440;
	bh=rFQxbFf+d5v40nY8+ULLt7p0+NDFB26iq1h3cbEuAmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fxinpcWicIgDP/jjCLvgA8QAhRzHwuNnSTLNbHpNh7LOH+bC8AKIalAivbk0uMKKF
	 dq+RbDNdaq6+GAW3+9qNFnDX9vYtSZht/5yHP+dgTYUJP4wenFJC/MiN6gt6Jg7xkc
	 ISZPm8IbCFH0pwDulPD0PyQ2NNs5JfmHxBhexRTXQ7e6Rc3vG8LcisZlpTTSIVO3mo
	 SehVfsInq5CECU/dl9kI5KgqF7af4YS/fdr8H6RxsS5ti97gEXFEsoj55QGYVMjZVx
	 PkVik3ugjSSi4yLzqifdDrlVkw0mGRTCbfWnbyRnyeKpqNtn4gxba7Dqb4BAF1PRRh
	 gY5/EPm9Kx3/w==
Message-ID: <f00caef7-9f89-4252-9794-76e32a2c3336@kernel.org>
Date: Wed, 13 May 2026 17:00:35 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: add zone->lock tracepoint verification
 test
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
References: <20260508162207.3315781-1-hawk@kernel.org>
 <20260508162207.3315781-2-hawk@kernel.org>
 <d440b00b-6d7b-48cb-b37d-43f6f885ed01@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <d440b00b-6d7b-48cb-b37d-43f6f885ed01@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/05/2026 22.15, David Hildenbrand (Arm) wrote:
> On 5/8/26 18:22, hawk@kernel.org wrote:
>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>> Add a selftest to verify the kmem:mm_zone_lock_contended,
>> kmem:mm_zone_locked, and kmem:mm_zone_lock_unlock tracepoints.
>>
>> The test has two components:
>>
>> zone_lock_contention.c - a workload that spawns threads doing rapid
>> page allocation and freeing to generate zone->lock contention. It
>> shrinks PCP lists via percpu_pagelist_high_fraction to force frequent
>> free_pcppages_bulk() and rmqueue_bulk() calls.
>>
>> test_zone_lock_tracepoints.sh - uses bpftrace to verify tracepoints
>> exist, have the expected fields, fire under load, and that wait_ns
>> is populated when contention occurs.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   tools/testing/selftests/mm/Makefile           |   2 +
>>   .../mm/test_zone_lock_tracepoints.sh          | 212 ++++++++++++++++++
>>   .../selftests/mm/zone_lock_contention.c       | 166 ++++++++++++++
> 
> This really looks excessive and ... not really how we usually treat tracepoints?
> 
> I don't know about others, but I don't think this is really what we want as a MM
> selftest.
> 

I wanted to have a program that tested the code I changed, so I simply
made AI write a verification test and asked it to create as a selftest,
that I've run to verify my code change was correctly implemented.  As I
needed to trigger lock contention the test is more advanced, but luckily
AI solved it in only the 2nd attempt.

It makes sense to drop this patch. We shouldn't keep this code in the
kernel tree, it simply verified that my code works. There is little
chance that this test will catch meaningful regressions for these
tracepoints.

--Jesper
