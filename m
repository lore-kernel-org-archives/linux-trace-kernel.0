Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179549;
	b=O9FgotLp08l9jaGcyvLd6t7xb85jTABsIAcK/9g1HoLV5/TmgtmRbdhCXLo4Ycsv+Jia
	 2JA9P5pvF1yCYNU4CfS1W2oah1rhrT3gJrt546T569LhOdQUECN30B+OrZGuFTcZ+w9BL
	 FSIegA6dywiNWJ/q03oHqFpS+V6VypBSe9UFj9kyKnwfxa9ucVRQ0HHXHNqeEDVczCGEp
	 JvYmmlu5dD4k29C2ageqbIoeI/c41cP6DlPEDntksXVxRxJccyMB2GzQPfsSZ77fkNwVz
	 xlzQrvP/831P+fw/szBLb/xdbzQLp49to00ZAo1LRxUVchDxiPrWjsuulZuQvwIFmNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179549;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CXQaE7qbV7eGxhp+28lFx0wX6wKu8htmvAmFNqL4VzI=;
	b=0D4NJYIbd/4PYv82J+eE4v7PJVsELBvP9vAsGMO+WJs6xDhwAV8zCHtzKj7OUtVSOnzn
	 UieRzODHOlEBx7H7fxPJTwPTgVyvKEAi8DpkixLjweGbcKb2hH7SHEL5v+5UxKKCQ+zO7
	 Af+QKXh4ykytY7embUE8LD8bQfsqj8HN+zdwcx+x6YSUQ+5/BYWfRXuSG2JDnJIke8H97
	 JExFfpYxpmmGDyBFeuJmZLRs5QJH6CWtV35kaaq/bsYdj5aqT3uJ4ab857opDdmt6zQqD
	 H3fFETDkWjk8L/D/vBHD6bS9QoLOsuiT6fJfERAZuVjmNdseDJnno7gKeQruf0MPP7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FhynY7vy;
	arc=none smtp.remote-ip=91.218.175.177
Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A8606A321
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Nov 2026 23:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FhynY7vy
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uBz62HipOUpV8FMMhhDpcgo86aJTWb6jnbXPRjMq07s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794179544; v=1; x=1794784344;
 b=FhynY7vypwbTH9C2GVgf+ELSdqPZ2nvlql2cYf4Y9+UDNNV1s+M4jXEFZnWLt2vhHscqCdAh
 ztsxTqCGIxlVdcyiii6yLlNN8PEl2u1IhxS4VbfXqFHxnecdQOsdEckGPmK9ryY6jpQWhXZnuhy
 XeWr0bRndzX3/W7IV00QF+3Q=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c8a84526f0e83049;
	Sun, 08 Nov 2026 23:12:24 +0000
X-Mizu-Trace-ID: c8a84526f0e83049
X-Migadu-Flow: FLOW_OUT
Message-ID: <490eace6-4ad4-418e-8ef5-5abf18bc8c17@linux.dev>
Date: Sun, 8 Nov 2026 15:12:18 -0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
 <20261021174406.2891598-2-vineet.gupta@linux.dev>
 <CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
 <20261023143816.48163575@gandalf.local.home>
 <75b66acc-354e-4cd2-b9cb-4c22e8a02635@linux.dev>
 <20261023180902.2bf7cef4@gandalf.local.home>
 <88f41f2c-4226-4122-9627-4fc29a29b99b@linux.dev>
Content-Language: en-US
In-Reply-To: <88f41f2c-4226-4122-9627-4fc29a29b99b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 3:25 PM, Vineet Gupta wrote:
> On 10/23/26 3:09 PM, Steven Rostedt wrote:
>> On Fri, 23 Oct 2026 13:13:41 -0700
>> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>>
>>> On 10/23/26 11:38 AM, Steven Rostedt wrote:
>>>> On Fri, 23 Oct 2026 11:13:44 -0700
>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>>    
>>>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>>>>
>>>>> I presume this will go through Masami and Steven's tree, is that right?
>>>> Yes, but it came in during the merge window, and since it's just a speed up
>>>> and not fixing something that's broken, I was going to let this go in the
>>>> next merge window. I rather have a change like this sit through a full -rc
>>>> release.
>>> It is a speed up but not for optimization sake but to cure rcu stalls in
>>> production at Meta. IMHO it should go in sooner than wait a full release
>>> cycle.
>>>
>> Either way, I'd like to give it a bit more testing first. That is, the
>> earliest it will go is after -rc1.
> That's fair.

ping !
