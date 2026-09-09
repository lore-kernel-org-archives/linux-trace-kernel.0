Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9B545DAA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953872; cv=none; b=s0bw3SsfnzZ1ok6Q6MLEY6PIIpj0I0dbME3Yj/uz97zqPzU7TYeUU5Y0+50RPisu3CrG8LWFHwu4E7qE656c/LLRZqBic/egr5AViilhAOF6vR79Uqsi9pEaCD4GGSq3HslP5uW8vVb9a4WSvOvI7kNQm8ONVcVsQVJIwYMb9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953872; c=relaxed/simple;
	bh=q5wYplptnPo5g5OG/Ii1Mn6lJkV50u27645zmx+c11o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RH562W6yEtJV1mqMbn39CudwCOt1QRGOGBA4mPXOj8imCKi43jfRf9qFTdwOIpD1aARjDM4rPnLmlO71uuoODqod0oZU50tUzy+Dh6skKOSP9IjNRYsgZUr7kayG3V2RAScxbW5UGaedbI2kxLnAhjHaLwdBHRamDjU5/52Iclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3P79sMK; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3P79sMK"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q5wYplptnPo5g5OG/Ii1Mn6lJkV50u27645zmx+c11o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788953868; v=1; x=1789558668;
 b=F3P79sMK/J9nfLVId4bzB4+fSyZPnw3Ptc6kxobklsRBMKrdFIM88Scd7EE5hml3dYEkEtM9
 0bB1Fb1NvPYFzcDEHvGnNBVvVG5Y1W1IiL1WcEX00r7L5yOTgq3/yLTU5/lFlQUbuLE4qW4rPh1
 qMkldxg5FXYP8LrWB7SwE844=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f492fb48b4208d8b;
	Wed, 09 Sep 2026 11:37:48 +0000
X-Mizu-Trace-ID: f492fb48b4208d8b
X-Migadu-Flow: FLOW_OUT
Message-ID: <16a81e23-cc94-4373-b201-1e9707576eeb@linux.dev>
Date: Wed, 9 Sep 2026 19:37:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] mm/mglru: add tracepoints for aging and isolation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Ridong Chen <chenridong@xiaomi.com>
References: <20260907042447.2450663-1-ridong.chen@linux.dev>
 <20260908094504.262faa76@gandalf.local.home>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260908094504.262faa76@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2026 9:45 PM, Steven Rostedt wrote:
> On Mon,  7 Sep 2026 12:24:45 +0800
> Ridong Chen <ridong.chen@linux.dev> wrote:
> 
>> Sent as RFC to get feedback on the choice of tracepoint sites and fields
>> before proposing them as stable ABI.
> 
> I'll let the MM maintainers determine the above. From a tracing POV, they
> are simple trace events.
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> 
> -- Steve

Thanks.

-- 
Best regards
Ridong

