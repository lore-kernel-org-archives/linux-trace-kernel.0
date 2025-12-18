Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C22E62D9;
	Thu, 18 Dec 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049461; cv=none; b=PMWI5K6rmdL80z5Iuh4yPnAfZrGaSdC5PgcwgYaUgAQIrYI7jGbw31W6P/mcZaHcu4r2k3DmHBRZBmhR4fE2ADwpYtVvSqjPnd0vCdG4pCfnkPkbMyJvLDLBzup/F0LVc9irhitALn4AaFJk5cLGCZ9IH1wJHked/3123fjWphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049461; c=relaxed/simple;
	bh=37Ohf4DMrjAATjaSx4voZUgGI8O/luesleMUuxP6vso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugqT61cd7crrIHtA4ouihu5Wb8N0y/KMHvUWl1NZTYeFFehWSLJQff863kfG4FGwAd9fN1WPX61jq+h2y4jPKRcENNBhOzo25TulPr16xlbh5FsBffepQbj33r6LIfSyCNRocn/INujvGCXtnh70OV/qjbwAvTkPqisZTQaWrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM21Im+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM21Im+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E60C4CEFB;
	Thu, 18 Dec 2025 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766049461;
	bh=37Ohf4DMrjAATjaSx4voZUgGI8O/luesleMUuxP6vso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oM21Im+6iUETflQKtyMaPSYjGnK8ExPLI1RjP+LY2mL7g+hAA6OAuBnoxoVW2jlku
	 sLjiqitH0JA+sblatUFJwOkgXZOOkOorbjeoMnlpoYwee04aZXdXWykGIT2AukEhFH
	 jZfRcYfQuV+sX8T8Wit+hPm/QQiJCrzAbt/ulboVL2BpKeGAr6coGSvaZDlGOXl/uZ
	 E73Z0N5jLG3Fqz4JEA+Y0B3lO7JZVlsUKLOwinjhTgyvIoCW/Phlp5KqfFjj3oXk4O
	 mAKnJwaTSwDCB2pOmrbz8blMcf2zb80MH/qYtsf7dzq/1w+c+WlH9uyvEEJa/mRN4M
	 3z3ljVrLDYZBQ==
Message-ID: <b75674c4-2439-4515-9b4c-bc3d40f76fc9@kernel.org>
Date: Thu, 18 Dec 2025 10:17:36 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/khugepaged: use enum scan_result for result
 variables
To: "Garg, Shivank" <shivankg@amd.com>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-6-shivankg@amd.com>
 <D9E6B402-528B-46F2-B4B0-9CD9549A449F@nvidia.com>
 <79fb5cb2-8a24-4260-a9e9-bdf2c5ef602f@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <79fb5cb2-8a24-4260-a9e9-bdf2c5ef602f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 06:40, Garg, Shivank wrote:
> 
> 
> On 12/16/2025 9:08 PM, Zi Yan wrote:
>> On 16 Dec 2025, at 6:11, Shivank Garg wrote:
>>
> 
>>
>>>   int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>   			    bool install_pmd)
>>>   {
>>
>> And here.
> Since this function is declared in khugepaged.h, I need to
> move the enum definition to that header. I see two options for handling
> the CONFIG_TRANSPARENT_HUGEPAGE check:
> 
> 1. Define enum OUTSIDE the ifdef: This allows the static inline stub
>     to also return enum scan_result, keeping the API consistent.
> 2. Define enum INSIDE the ifdef: The enum is hidden when THP is disabled,
>     forcing the stub to return int 0 instead.
> 
> The only external caller (uprobes.c) of collapse_pte_mapped_thp currently
> ignores the return value.

Probably best to not expose that enum (especially when nobody cares ...) 
and instead expose a new void function for uprobe purposes.

Maybe

void collapse_pte_mapped_thp(...)
{
	try_collapse_pte_mapped_thp();
}

Maybe something like that?

-- 
Cheers

David
