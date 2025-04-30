Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938B1E1E10;
	Wed, 30 Apr 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999558; cv=none; b=HAq+p13VbyVE0zz3ie0LtUY/1PZsy6iPdLNhyeArrjyXATlG8cycxlAOJ/lBdTzCtqjBSU44w8JNhnPBx33HmOKKxgRp8AzOCnpXiKSpHXRHi313X718DAafYR2Ut4OeTpb30vLI01Fih06rJlommF8Puu1B1lGZqGxjtOxsnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999558; c=relaxed/simple;
	bh=ViuCqa1O0ArkQ3KKEAI0bCV9+N50gtg0uhrcmWdxvZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmfr1TDO9sVbSePwI862Ry5KERevvR9bZyehysAJMQLqVjMQFf2hKVqT6NwauVuNRkm5JOdIwBPG1GP1JIemZ3xSjVt1pRKV5j1+tG2Amf3Ud7AENsHdTg0QgqCbwdgqggwo7qrr9Wn3RscegyBW+tjQc24huYF042OF4K2OEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EI1cFIQj; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EI1cFIQj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745999552; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iI6C5Rr8n73x6s2CrV03MiOdT5s35UobKP9ILv8Xhu8=;
	b=EI1cFIQjOcxVt3EMOHhHL9lCzFRUDvRaRwdM1uCaLmN+0zuUELj7fWxTuDp7Oct0Zoyc+GBxGCWLQiodb10fhjZQ1woFljP+CidPlmKeGFP29XhZsgYcSMEHCwWXBtBgOxmvQlzYGrzkHW+qSKE+OH8f/rkEVULdmM06sGPtiJo=
Received: from 30.74.146.9(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYnlqwD_1745999226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Apr 2025 15:47:07 +0800
Message-ID: <02c73c31-d52c-4ace-bc2c-eb6cd0eab253@linux.alibaba.com>
Date: Wed, 30 Apr 2025 15:47:05 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] khugepaged: rename hpage_collapse_* to
 khugepaged_*
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
 <20250428181218.85925-2-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250428181218.85925-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/29 02:12, Nico Pache wrote:
> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> as the function prefix.
> 
> rename all of them to khugepaged to keep things consistent and slightly
> shorten the function names.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
