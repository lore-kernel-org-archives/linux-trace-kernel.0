Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F90215073;
	Wed, 30 Apr 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007767; cv=none; b=YxC+dpBKZjla6twotmpXr1rc/d65cVFcWym5XLtWOjbxQtvJsGJSAEH6RhiO/EPLECQlvuhsJKyNuBBpP5Y86LcD/UwyXx704A6nAUQxLqHTooM4kwnSW2AAb0IIPmGtMCxX4XR5mI47sHTUVmziiLHfvZaNfHnHqu13IqOmxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007767; c=relaxed/simple;
	bh=acUIEYS47N0jfqScIbEZuYGbAxDBtW/KaYO+YY7Fn8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7JUFsGVeW0c7hrLLBL3QuadaqEGIPZTmbBUWyc6lWBn8voXSNowMzy0WgOhxWecerzaifymvGixbpX6YeT5DczB6r4xEESi3Lc4qYa8G8vOXRPVceOBMUeiHT9d6iNVfy0rQAgEzVcynroHrvImXS2RZ0qi45YhGMZ3cRz/3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tQ19MDR3; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tQ19MDR3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746007760; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4nwQzxilbFOqh5VEZWNSx+cKoBVCmfBTfSB2Il9HUho=;
	b=tQ19MDR3vChuXRYCD8wqWAe14Ug2VI2xp7QznEV6lP50Fn7gfGXQc+oeCUqRmm9biFgVdz6THx3iGSJzFfPF9IAvsGOZU9HYi3gS2EP87Ynr6vVGa2HZV2f2xKDHrVudKithlCFqECEduLS/TC6BjVFs+VzZ8Cm+cSZstv8+48k=
Received: from 30.74.146.9(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYoKPvm_1746007756 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Apr 2025 18:09:17 +0800
Message-ID: <140d91bc-13cb-46c4-a6bc-0cbd8d329cdc@linux.alibaba.com>
Date: Wed, 30 Apr 2025 18:09:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] khugepaged: skip collapsing mTHP to smaller
 orders
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-9-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250428181218.85925-9-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/29 02:12, Nico Pache wrote:
> khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> some pages being unmapped. Skip these cases until we have a way to check
> if its ok to collapse to a smaller mTHP size (like in the case of a
> partially mapped folio).
> 
> This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].
> 
> [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/
> 
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
