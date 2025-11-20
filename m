Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE842DE711;
	Thu, 20 Nov 2025 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632573; cv=none; b=cn00mJjS0nWVvMCazUuiUoD1kdxHxJR3gedBoRElCt6m7cSNrka3wSXHLNQTD3M+mZXZ8QreB9CrxYd9UsbtXaAzoiaAEhEL52oaHaLiC7ziPNNBJN9nJR8w0tAb64DtlDwph4+vm/0F57hrFvTVSKk2W1yxhm6uv0ig1N8P+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632573; c=relaxed/simple;
	bh=TDuvFXqbDHJMJ5mzlKzSg2+WmG6ITXxWwjZrhf+PkgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnvalB/TW1sVcaCn7xXbbYe8RkVdhPIqK5LuMnJvhtwFep8xq7lI4ldpoMoGlRJ6VrV9vNZulRohdUUnL3ZurKW+sYLrH+fqwRU1ikNynSfFeRuPTI6mNzwepbBShmzOdxYVPuIOwtr6WMvZC+YsjUm+k7JIRQkST7fualRHIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C746A339;
	Thu, 20 Nov 2025 01:55:58 -0800 (PST)
Received: from [10.164.18.59] (MacBook-Pro.blr.arm.com [10.164.18.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2F13F740;
	Thu, 20 Nov 2025 01:55:58 -0800 (PST)
Message-ID: <7696ef91-89c0-427d-951b-56dbb33b4dd6@arm.com>
Date: Thu, 20 Nov 2025 15:25:44 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mm/khugepaged: map dirty/writeback pages failures
 to EAGAIN
To: "Garg, Shivank" <shivankg@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251120065043.41738-6-shivankg@amd.com>
 <20251120065043.41738-10-shivankg@amd.com>
 <6c1d6b80-d290-4110-9a49-53e7404136bc@arm.com>
 <33476cb4-318b-49db-9cc1-a354eca9e883@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <33476cb4-318b-49db-9cc1-a354eca9e883@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/11/25 1:47 pm, Garg, Shivank wrote:
>
> On 11/20/2025 1:33 PM, Dev Jain wrote:
>> On 20/11/25 12:20 pm, Shivank Garg wrote:
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
>
> SCAN_PAGE_NOT_CLEAN covers both states that indicate the page is not in a clean/stable
> state suitable for collapse.
>
> [1] https://www.kernel.org/doc/Documentation/filesystems/proc.txt

Alright, makes sense.

>
> Thanks,
> Shivank
