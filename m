Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D138911E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615331; cv=none; b=M7PXq8PwzBwVgiX9r94MwI3sZFp45Nae/JhTjzTfmq91abu8AL4oIyRMzOSUe1v/0+tYeqgUvjBTveszIWE+NWyZsgHJqYH9wjVb2rhTVoYGnHzOZL1BSjfitsJGMg3PH4YkAc3fgAbuoQfErZqKS/58hM+W8rUioRXdALMh6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615331; c=relaxed/simple;
	bh=yl/KOYtn7JZaIGJ+SR0TQ6PTflOSgSYVMpOp0AALSDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRp8sQgCQLtn7+U1zkavHkBz3fecG7b1F2d4UFgAtIK8jU7TiTC3WwzYp3MVbZLquaXYXEVCrOAwdHA57w3CgQkfWxEo3PjUeuST2u97pesBX2QxcWRD3Yp7LlU4QD+Zt0GFWStr7qh9MFf6acea0DaDpz1AiLHPChOBjrDxen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u6nTGN7v; arc=none smtp.client-ip=91.218.175.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u6nTGN7v"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yl/KOYtn7JZaIGJ+SR0TQ6PTflOSgSYVMpOp0AALSDk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789615325; v=1; x=1790220125;
 b=u6nTGN7vfwbYe7PCRLE0iIbUUHW2Bf0Z8jwqGG0xde6hwjR2OE7yW+6khwRWfwpf6PwMC06B
 W8vILp7/v3pQE+Pcoe+2Ot5r6i+Pk9MyXjiEkRTswBQj3d6Zg0zu0dl/loB49sVYwklmLO5UOa1
 GublyU9w7HlrtYMy/VRjGwfw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3c089fae2f5f256c;
	Thu, 17 Sep 2026 03:22:05 +0000
X-Mizu-Trace-ID: 3c089fae2f5f256c
X-Migadu-Flow: FLOW_OUT
Message-ID: <f12d0cd4-0704-4231-8199-4a04af367040@linux.dev>
Date: Thu, 17 Sep 2026 11:21:57 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/mglru: add tracepoint for scan_folios()
To: Baoquan He <baoquan.he@linux.dev>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)" <linux-mm@kvack.org>,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260911102939.2485750-1-ridong.chen@linux.dev>
 <20260911102939.2485750-3-ridong.chen@linux.dev> <aqkoeJvFzqpoGeaP@fedora>
 <e38f2b80-20f2-4787-9e07-fb601552f550@linux.dev> <aqn7h3BVCCRFI2TI@fedora>
 <20260916095122.50cbb620@robin> <aqtBG9Oyu-RVI7jv@fedora>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <aqtBG9Oyu-RVI7jv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/2026 9:23 AM, Baoquan He wrote:
> On 09/16/26 at 09:51am, Steven Rostedt wrote:
>> On Wed, 16 Sep 2026 10:14:31 +0800
>> Baoquan He <baoquan.he@linux.dev> wrote:
>>
>>>> However, 'sc' is an internal structure, so sc->order cannot be accessed in
>>>> TP_fast_assign(), and I don't think it is worth making scan_control an
>>>> external structure just for this.
>>>
>>> Agree.
>>
>> Or what you can do is to move include/trace/events/vmscan.h to
>> mm/trace_mm.h (or whatever you want to call it) and struct scan_control
>> into "vmscan.h" and then you can use internal structures within the
>> trace event.
> 
> Sounds very reasonable, thanks for the valuable input.
> 
>>
>> Up to you, but this is what other subsystems have done.
> 
> Yeah, leave this to Ridong to decide.

Thank you for the suggestion.

I think it is worth doing. And we can also use that for other tracepoints that 
are using sc->*.

I will give this approach a try.

-- 
Best regards
Ridong

