Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B4309EFE;
	Thu, 18 Dec 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049257; cv=none; b=uKRsY02gqHeg5yv+fBQBTXdW4SmLH5zktksr5vWHuDF8bAHS37ejP+YOgJyWZDYpU0EX9YHOFg5+9qU6FSxcdzleTHUjnxY6z2PpdvLnUwe3j8jGkyjVb6akIlBLoJ3ruMA3xYzp5v9t0uvqMBPZyOEaldDW2Tw2/94YLVYyKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049257; c=relaxed/simple;
	bh=RbU7bkp5JA3adLxntFDCx5PqRnEWhiZPV2jX0v9jyt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY+2kZuAwpUhpSCzsKc4vrno3iqaVh9bzJ9wsQRoxnJ6M4Jt7TWq9iN6zOT+0okl0jfcoMEHmhOBEhTAX0Q71cz4bQ2wC+CikHUg9/nFM715QNYRtk54X7/2wEjFrI9eygIZpKcTLzf7kB2mE9RMZHfOn2r/mQ8zsWrCtIkfJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM7l213Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM7l213Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90127C4CEFB;
	Thu, 18 Dec 2025 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766049256;
	bh=RbU7bkp5JA3adLxntFDCx5PqRnEWhiZPV2jX0v9jyt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LM7l213YCC8qIHUjwHr4WGqsrFGr8FlEg3VWbQJ6h50XdTzP3Soge9oWQGxnrKQk6
	 5iYKwDaWIaYJjSVFvnbY2OrPBvrGSXsh6y8rJtmBElg3zIXvFVy3IpGFdMkPwVFAT+
	 H9CuL+RX7FEEKyKU6JkonHxQNGLIlZoCAaoEigfY1tZhB7dOxf7eds4RuN7bxLS2bA
	 sOi4XzZTrhQ3oVz/LrodLv+n/Oggi1c2vV2ABPmbBUcftzgcVCSxDxk5f+14MXFPh1
	 X6xOOGz76nWZVjztYBw1hld2YUSMO89OIjyRZrk15ERys6Mhqi4qZ3+b4hGYTVBvkA
	 cMZMr3YwjrVAA==
Message-ID: <5d0b97e3-c617-4650-8f24-f67538418012@kernel.org>
Date: Thu, 18 Dec 2025 10:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251216111139.95438-4-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 12:11, Shivank Garg wrote:
> Replace 'goto skip' with actual logic for better code readability.
> 
> No functional change.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   mm/khugepaged.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c8c35d3e0c9..107146f012b1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2442,14 +2442,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   			break;
>   		}
>   		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> -skip:
>   			progress++;
>   			continue;
>   		}
>   		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
>   		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
> -		if (khugepaged_scan.address > hend)
> -			goto skip;
> +		if (khugepaged_scan.address > hend) {
> +			progress++;
> +			continue;
> +		}
>   		if (khugepaged_scan.address < hstart)
>   			khugepaged_scan.address = hstart;
>   		VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);

Oh yes, please

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
