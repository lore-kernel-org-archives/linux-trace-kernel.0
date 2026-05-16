Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0722D7A1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 16 May 2026 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778904411; cv=none; b=IC+ZzLevQMZQyTA7ibVEQ2TXN7u89vYDoOxEGB9mdHbay+CZkLcrCCR0tgdMrVWgcNeeN9DzkP83aH5rRsYOoO/18ahB3fcq70EARhAUeXCNwIecNLF+17hc25gxwYYY5C7d2Ok7uc7b8BwqHQpuUSv+do68xt1t9poLpyExghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778904411; c=relaxed/simple;
	bh=GBwaUEyCsHc0bhV3MvwOkn2yoHIHILajZ2KK2Sj624E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPHK0XFbybHTX55ecW4+jhShlNiBbWH2ikm7AEftlH4CLPJBWlsduQEIotX3Gd9FbOd4F5gQ9z8cyXMBdIAIF/Uw81ixBTORSGNhvAKp0M8CspNkW+4FnkqdDpto6mPmAjUgYxmgGIKrKu8oXx5ya9dycDBFnM3xW1c4mJfXQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m/T4jWUy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m/T4jWUy"
Message-ID: <f76b79d3-080a-4931-873e-99d4b3e1020f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778904398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csEBmhV4pBMWZ2fB04greY5anYTJC5J151pnKD1dZ50=;
	b=m/T4jWUyKVPBrEtgI+LssBYE8Jr1JtMKr0LC+7/kLTiQQ5hs1U9JvcXG/ff5kGZB9kDH8j
	yfg3OKQY/qc5xL9N70vxIHxOISGzjIXPdS29DbHnveiqosMrQEKPuglL6ufFzM10cY/+yN
	CEhCLgcRYDzRn7tVG2TNL9cq+EyTS8I=
Date: Sat, 16 May 2026 12:06:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: linmiaohe@huawei.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shuah@kernel.org, nao.horiguchi@gmail.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org, liam@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <agXcPleVC9LGVCmj@gmail.com>
 <20260515070353.87244-1-lance.yang@linux.dev> <agcbfLHT5ZWnNeN0@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <agcbfLHT5ZWnNeN0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/5/15 21:13, Breno Leitao wrote:
[...]
>>
>> Wonder if it would be simpler to just do a positive check near the top
>> of get_any_page() instead. Something like:
>>
>> static bool hwpoison_unrecoverable_kernel_page(struct page *page,
>> 						unsigned long flags)
> 
> Ack. We probably want to call it something like HWPoisonKernelOwned() to
> follow the same naming sematics of these helpers, such as HWPoisonHandlable()
> 
> By the way, I will re-include the self test back to this patch series,
> In case they are not useful, we do not merge it.
> 

Sounds good :)

Can you also test the relevant page types if possible, especially
the ones the new helper is supposed to classify?

Cheers, Lance
