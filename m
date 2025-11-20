Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577430DEBF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641492; cv=none; b=ZgGai3DsrIPrEfmsbK8YWbGmUdfE4WDVcKtxz+IrSOYBbsnyeMqHCYpG0xGf87cffKCozPi1hOdSSHCbrVzU2Bw//Uolcd7du4I9XAVAmcB7FWQaADYytND8TXzZZe0xaR/AFcuMdMCl/2ogTQkxXlkeIKRPg+1Yd+/O/SCu0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641492; c=relaxed/simple;
	bh=PoV40xAdbaotfJYh57+lhSmxroJbISak5OEYpITze58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaWawE7GPo9+C9kyxunnq5NRvkXc4HdnXIkHEMOi0SzmVap6j9NuLgImE4nYDh5p22sK7rqT35HDZAd8jQLYZ1I+uMjquC/r9zNoDMvXJsRQFncbphLvNUHm05Ztvc+LfGVEz6fad+MIPyO6ex0XkGKbs6OZts8PSQsH0om/oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyQRrg2z; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tyQRrg2z"
Message-ID: <ef4a0c2c-62d1-46de-9ea2-dd946857a03a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763641487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrpSiTB/zy6tqtQWNYybUDpdeQBD/EoPTcGuovzkLAk=;
	b=tyQRrg2zcjxF25xy5X14pftfbqhkRV9KgqB3y6poZGjp7jBlvejZmiwdnhDFkEh0PFyEUB
	zdAT2EGR9n5UxlBKcW5Xq7ycxyefTn8Vsz1U7CdONNUfLMkJwY8LiNL4JuxahT5sPbS662
	W/6wQwaexPBTBRP5Dpik+r7kXm4/O34=
Date: Thu, 20 Nov 2025 20:24:19 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 2/2] mm/khugepaged: map dirty/writeback pages failures
 to EAGAIN
To: "Garg, Shivank" <shivankg@amd.com>, Dev Jain <dev.jain@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@kernel.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251120065043.41738-6-shivankg@amd.com>
 <20251120065043.41738-10-shivankg@amd.com>
 <6c1d6b80-d290-4110-9a49-53e7404136bc@arm.com>
 <33476cb4-318b-49db-9cc1-a354eca9e883@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <33476cb4-318b-49db-9cc1-a354eca9e883@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/20 16:17, Garg, Shivank wrote:
> 
> 
> On 11/20/2025 1:33 PM, Dev Jain wrote:
>>
>> On 20/11/25 12:20 pm, Shivank Garg wrote:
> 
>> SCAN_PAGE_NOT_CLEAN is confusing - NOT_CLEAN literally means dirty, so why not SCAN_PAGE_DIRTY?
>> Or SCAN_PAGE_DIRTY_OR_UNDER_WRITEBACK? Since folio_test_writeback() is true as a result of
>> the folio being dirty, maybe just SCAN_PAGE_DIRTY can do.
>>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>
> Thanks for the review.
> 
> I chose not to use SCAN_PAGE_DIRTY because dirty and writeback have different meanings[1]:
> 
>      Dirty: Memory that is waiting to be written back to disk
> Writeback: Memory that is actively being written back to disk
> 
> [1] https://www.kernel.org/doc/Documentation/filesystems/proc.txt
> 
> IIUC, a page under writeback is no longer dirty, so using SCAN_PAGE_DIRTY would be misleading
> for pages in the writeback state.
> 
> I considered SCAN_PAGE_DIRTY_OR_WRITEBACK initially but felt it was too long.

Nit: If SCAN_PAGE_DIRTY_OR_WRITEBACK is too verbose, how about 
SCAN_PAGE_DIRTY_WB?

It keeps the specificity without the length, and is arguably more 
descriptive
than NOT_CLEAN ;)

That said, LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 
> SCAN_PAGE_NOT_CLEAN covers both states that indicate the page is not in a clean/stable
> state suitable for collapse.
> 
> [1] https://www.kernel.org/doc/Documentation/filesystems/proc.txt
> 
> Thanks,
> Shivank

