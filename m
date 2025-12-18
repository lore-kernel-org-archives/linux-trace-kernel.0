Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB22E62D9;
	Thu, 18 Dec 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049488; cv=none; b=qhzDbhL6w1jxBBCtV42anw5gv204/BJge07H6oBJx8adraUeuh5d0y897HQNc9pTMnX+auG/D6waE5H67nLziIPrsFmHQV4ZsmIesRV/qXtpWMEnpu1+v1F6RXd+M4W/+V5U8/VZZ8qOEI2EBn48CeIl3WRf+VCP31rGj8WBWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049488; c=relaxed/simple;
	bh=R/1cioPEOc1Vk50SGuTN9wyMBRaVyyQItGpm9Hs+iiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hoh0AoOtntZhwHmdN3G987Ugodpi3K9ixv+3QOmxM3V6L31+pel/6zIM5t7r7azcWVNGU7etKu3yOfAUNTbFsKholbHAO6GOfTMi0ABWhhraIPCCZGoIrR1oa36LZyCotROP1W1NsVcn2PRojG8vJc4fHxPuVoozhihzPTM6Vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab6Q3KvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab6Q3KvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD39C4CEFB;
	Thu, 18 Dec 2025 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766049488;
	bh=R/1cioPEOc1Vk50SGuTN9wyMBRaVyyQItGpm9Hs+iiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ab6Q3KvJgMBLV3G4RIuyN+yILZbFaNvZnEhCAQ3x2PTBQiDhfDretICwWC0nupJUK
	 NxuSN4c32MWWrg8GkkaMNM45JWaNGUujMFqdJiiysdKSVePOJ7JLAyqEkxkslrTsoT
	 k6jL3iCaannu48zvDM5lzxptx90paltEqZWDcXRd/o4HcA9u5Ra3nemNbDUthBcv4t
	 WBAPSdwDEHVvJi0hwRC2gA+kH4wlzCt/8D+iL4Q+LBOz3+q6cWluXuR4GHmR/bBHE5
	 aLq+UeAiGNFJSaZHyy4YtWDgM/IdzHBTor6TY6LSzbC2v2AoH2f+NGXLHJl7LQpYKD
	 p3YPr6iXT/Qqw==
Message-ID: <c68f94ff-a9e2-4af5-adf0-90fd7b593949@kernel.org>
Date: Thu, 18 Dec 2025 10:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/khugepaged: make khugepaged_collapse_control
 static
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-8-shivankg@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251216111139.95438-8-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 12:11, Shivank Garg wrote:
> The global variable 'khugepaged_collapse_control' is not used outside of
> mm/khugepaged.c. Make it static to limit its scope.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
