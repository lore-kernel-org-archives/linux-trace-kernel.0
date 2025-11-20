Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16E338598;
	Thu, 20 Nov 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645370; cv=none; b=PAgrZU8s4Nvrnfsdq26WUV+u1ki2cqmFyfAUDNoGYHCh6juLRDGvSH4Q2BHZTo5sDVKufuIHG+fa8WBGpbKaQFDuXFZRF8N4PS4RO08HmzSUi+ifgSW7HnjdsHA41PxAIXbrhGOg+Cb2DrLanXllmos2oWcUJADZ6rccwK0NyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645370; c=relaxed/simple;
	bh=WZU8YZVNbH9FupGqUrgw5DmUou46sjiYKi37MvqORC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnbxLhsGpwonv9Zzm6agCWFNAS7afmZuYT91MUPb2f5N+BP1e7WULGBToTZMEWvFPxAKe/69B2otngRJoOMKbYIwcBah7ewbpLmWhjhWl6kRMhjgCrlQFOo7IthG9hiI+rLIbaL8/n7ziaWIzGQ4C6brfuJmXzNj9inqi2aAbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFxAWLwk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFxAWLwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696B2C4CEF1;
	Thu, 20 Nov 2025 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763645370;
	bh=WZU8YZVNbH9FupGqUrgw5DmUou46sjiYKi37MvqORC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dFxAWLwkeJpmG95tU1YvLqrMFtE1xoY8AMaETQkrrGe8tU5jkl/iVac4wQudxnxY1
	 KhPrO9vx2YTdf90paFpoS7c84BMBaBn8bo979ASlHAC+jJi3qTeKDIj/6mCTvyQwRh
	 ZmfJdYunou9FlkmnekDBfMeM0IoCbbrAF48rrujI5XOjtCoqAWXh+uChbl/DzV9mB6
	 75Cmv+9JGkDrlMPffuEGxVacn5h7I0NSCpUgI6VqACNET/MkhqZFmInU+Bfrv2g8pL
	 O6DINDJsLkG+Q1kuMCJjKyN83HUHi74xMqfGW9D29Gzv6x5IWaZfnqVJUlPl2I8dYb
	 Vvy4xYKZuM/LA==
Message-ID: <81e34d93-9031-4840-a0d0-56d488f3bc17@kernel.org>
Date: Thu, 20 Nov 2025 14:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mm/khugepaged: map dirty/writeback pages failures
 to EAGAIN
To: Lance Yang <lance.yang@linux.dev>, "Garg, Shivank" <shivankg@amd.com>,
 Dev Jain <dev.jain@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
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
 <ef4a0c2c-62d1-46de-9ea2-dd946857a03a@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <ef4a0c2c-62d1-46de-9ea2-dd946857a03a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 13:24, Lance Yang wrote:
> 
> 
> On 2025/11/20 16:17, Garg, Shivank wrote:
>>
>>
>> On 11/20/2025 1:33 PM, Dev Jain wrote:
>>>
>>> On 20/11/25 12:20 pm, Shivank Garg wrote:
>>
>>> SCAN_PAGE_NOT_CLEAN is confusing - NOT_CLEAN literally means dirty, so why not SCAN_PAGE_DIRTY?
>>> Or SCAN_PAGE_DIRTY_OR_UNDER_WRITEBACK? Since folio_test_writeback() is true as a result of
>>> the folio being dirty, maybe just SCAN_PAGE_DIRTY can do.
>>>
>>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>>
>> Thanks for the review.
>>
>> I chose not to use SCAN_PAGE_DIRTY because dirty and writeback have different meanings[1]:
>>
>>       Dirty: Memory that is waiting to be written back to disk
>> Writeback: Memory that is actively being written back to disk
>>
>> [1] https://www.kernel.org/doc/Documentation/filesystems/proc.txt
>>
>> IIUC, a page under writeback is no longer dirty, so using SCAN_PAGE_DIRTY would be misleading
>> for pages in the writeback state.
>>
>> I considered SCAN_PAGE_DIRTY_OR_WRITEBACK initially but felt it was too long.
> 
> Nit: If SCAN_PAGE_DIRTY_OR_WRITEBACK 

I would prefer that here.

-- 
Cheers

David
