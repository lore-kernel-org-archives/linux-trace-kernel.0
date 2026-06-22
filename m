Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3033B6E3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146330; cv=none; b=p2N1ZpFEV2fYmOXXNMQsfx6kxIdmtmtPVtbyWMvFN87HBloodMQwtTkrlLh77AmNh3x7SKD9cuR3+YF1o81w0XaV7cm26qqkdGyQAZnGKbLKhmnHt/qN4LO1a/JhxTFj3Lsoqs+Qr+A3Ly+hd0vKp1OWy8cBToo6Uqv6X3zZr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146330; c=relaxed/simple;
	bh=JljHqn12P8R8Fn3axWCUA5p7fOcYHm35tuYT5IJZ8cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+gfTvXjaCT2hIZjHs4EVsbASXYinD/TlIdoVNjClpnB2+ndd2IfEUyBI+xQ0/NNPEjnjrkGoVHAsCTmI+MFdsDNdVO+IQPSPIdiZCNiQQ28Y9YMuFp1vmnc86uwAmWVbZie6ZxYRdBJkHUNi5FO5TNSnXADTOh9oJsqjybkPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G0xGUlj5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G0xGUlj5"
Message-ID: <8407c3ed-cade-4ab5-b6d7-78f83956e013@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782146315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2HLTO5tyNJPMYKw3VOzgy0NWTUYIs4xZWvzz0/vGJQ=;
	b=G0xGUlj58gBLaG3E+cxhFrDel6gO0Ct1/wEVBCM1PEeohMTOXVmjkZVU6yDw+IDnhSqOl3
	k8jghyYemtAWpfUyIbEEiUg2zfNj6jby2ahQqwtCvxiv40eMxEkabjS9l8roppxVVfGUef
	UZ6Ti8kGwwGCf6Zc5oq4/5NVcuZ/Bck=
Date: Mon, 22 Jun 2026 09:38:18 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm/lruvec: trace LRU add drains and drain-all requests
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, usama.arif@linux.dev,
 akpm@linux-foundation.org, mhocko@suse.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kasong@tencent.com,
 qi.zheng@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
 youngjun.park@lge.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260610195220.12403-1-jp.kobryn@linux.dev>
 <06122cae-e28b-4ded-a9dd-d380d31c5230@kernel.org>
 <ajK1YsIJmD2ImbAk@linux.dev>
 <1136baf3-3967-4202-9eaa-5fd667c235cf@kernel.org>
 <3149bc84-dd3a-43ba-826e-6364965fdafd@kernel.org>
 <bbcb6db5-6a01-46b7-979f-dadd52a5176f@kernel.org>
 <d4b55716-97c7-4e75-8500-6a1171ad7fc6@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: JP Kobryn <jp.kobryn@linux.dev>
In-Reply-To: <d4b55716-97c7-4e75-8500-6a1171ad7fc6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 5:38 AM, David Hildenbrand (Arm) wrote:
> On 6/18/26 10:30, Vlastimil Babka (SUSE) wrote:
>> On 6/18/26 10:21, David Hildenbrand (Arm) wrote:
>>> On 6/17/26 20:18, Vlastimil Babka (SUSE) wrote:
>>>>
>>>> Yeah and I don't recall ever that a change to a mm tracepoint would ever
>>>> break someone who'd complain and we'd have to revert it.
>>> Really? :)
>>>
>>> Read the context of the link I posted once more.
>>
>> Ah, I see. I've only read the single mail from Steven that referred to the
>> old powertop breakage and didn't notice the context.
>>
>> But I don't think these worries should stop us from adding easily usable
>> tracepoints.
> 
> Steve explained a way how apparently scheduler people are handling it without
> trace events.
> 
> You can always remove/modify tracepoints, but not trace events.
> 
> Anyhow, just wanted to mention it, because so far MM didn't rally know about
> this implication.
> 

Thanks for pointing this out. I'll sent v4 using DECLARE_TRACE() to
avoid creating a new event.

