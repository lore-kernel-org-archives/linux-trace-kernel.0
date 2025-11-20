Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A7D531;
	Thu, 20 Nov 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763620693; cv=none; b=Ht88VVihcUdZB7e1V/MgB/DiwVa8HT/x1ZFWyWklzl7PPkyfsVL/nm25zbxPkxYl7815r/zix7xow5t+5DRhu9L0eYeXQ1iIwfYf5/MBKnLOd44ukOleDInVrItgEZKsD/rR8HFHtwEAsNK255NgWwjvuG2onUd8Aiw08lngkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763620693; c=relaxed/simple;
	bh=8OcFBDBeJO7+pib2I4Hka2OsG+X/xma3Rtr5f2jsuS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMZFkPRIhSkugYSolJKTOzVw80qdwlVTrat3APN9x4lIPVRJBcVzeDFsirKu4vbtGbIWhmH/N8s9R9T6JMtR0jTjeRdi1YZ/Kg+jA9N9LuXaOY98PjLE+wsb77lj3i343MYhB+f7JJvvx+f6/Y6tGkBl2l454+prWMe2EEUJaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XinI6Abc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XinI6Abc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763620682; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BX9rFfaKdKny49Aru+ZL28mbNKoUR069Ni3qjLSN1/M=;
	b=XinI6AbcNb6oIacynTUA8YNdPKuPTLDoRIUgtx8lFxw+8F91p8ZdsuDeHO+YdOyyIHPFEGThKehQTK5uxcpMxxow5xrxdsOu1j3MNubovcqkXVljU6F62FXoqGGokHarpTWgIC5sesj8V4cKvIRU8L4xA4h4YnmxWFp+cbXD6cw=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WssTONS_1763620638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Nov 2025 14:37:59 +0800
Message-ID: <cb2f5978-5fdf-4e4d-a662-14c5858b0fe6@linux.alibaba.com>
Date: Thu, 20 Nov 2025 14:37:58 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 14/15] khugepaged: run khugepaged for all
 orders
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 ziy@nvidia.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-15-npache@redhat.com>
 <2f1cdad3-6ac4-4502-a599-5bef9dbe0847@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2f1cdad3-6ac4-4502-a599-5bef9dbe0847@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/19 20:13, Lorenzo Stoakes wrote:
> On Wed, Oct 22, 2025 at 12:37:16PM -0600, Nico Pache wrote:
>> From: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> If any order (m)THP is enabled we should allow running khugepaged to
>> attempt scanning and collapsing mTHPs. In order for khugepaged to operate
>> when only mTHP sizes are specified in sysfs, we must modify the predicate
>> function that determines whether it ought to run to do so.
>>
>> This function is currently called hugepage_pmd_enabled(), this patch
>> renames it to hugepage_enabled() and updates the logic to check to
>> determine whether any valid orders may exist which would justify
>> khugepaged running.
>>
>> We must also update collapse_allowable_orders() to check all orders if
>> the vma is anonymous and the collapse is khugepaged.
>>
>> After this patch khugepaged mTHP collapse is fully enabled.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 25 +++++++++++++------------
>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 54f5c7888e46..8ed9f8e2d376 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -418,23 +418,23 @@ static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
>>   		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>>   }
>>
>> -static bool hugepage_pmd_enabled(void)
>> +static bool hugepage_enabled(void)
>>   {
>>   	/*
>>   	 * We cover the anon, shmem and the file-backed case here; file-backed
>>   	 * hugepages, when configured in, are determined by the global control.
>> -	 * Anon pmd-sized hugepages are determined by the pmd-size control.
>> +	 * Anon hugepages are determined by its per-size mTHP control.
>>   	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
>>   	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
>>   	 */
>>   	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>   	    hugepage_global_enabled())
>>   		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
>> +	if (READ_ONCE(huge_anon_orders_always))
>>   		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
>> +	if (READ_ONCE(huge_anon_orders_madvise))
>>   		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>> +	if (READ_ONCE(huge_anon_orders_inherit) &&
>>   	    hugepage_global_enabled())
>>   		return true;
>>   	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
>> @@ -508,7 +508,8 @@ static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
>>   			vm_flags_t vm_flags, bool is_khugepaged)
>>   {
>>   	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
>> -	unsigned long orders = BIT(HPAGE_PMD_ORDER);
>> +	unsigned long orders = is_khugepaged && vma_is_anonymous(vma) ?
>> +				THP_ORDERS_ALL_ANON : BIT(HPAGE_PMD_ORDER);
> 
> Why are we doing this? If this is explicitly enabling mTHP for anon, which it
> seems to be, can we please make this a little more explicit :)
> 
> I'd prefer this not to be a horribly squashed ternary, rather:
> 
> 	unsigned long orders;
> 
> 	/* We explicitly allow mTHP collapse for anonymous khugepaged ONLY. */
> 	if (is_khugepaged && vma_is_anonymous(vma))
> 		orders = THP_ORDERS_ALL_ANON;
> 	else
> 		orders = BIT(HPAGE_PMD_ORDER);

Yes, LGTM.

> Also, does THP_ORDERS_ALL_ANON account for KHUGEPAGED_MIN_MTHP_ORDER? It's weird
> to say that an order is allowed that isn't permitted by mTHP (e.g. order-0).

The THP_ORDERS_ALL_ANON has already filtered out order 0 and order 1, so 
it matches the definition of KHUGEPAGED_MIN_MTHP_ORDER.

/*
  * Mask of all large folio orders supported for anonymous THP; all 
orders up to
  * and including PMD_ORDER, except order-0 (which is not "huge") and 
order-1
  * (which is a limitation of the THP implementation).
  */
#define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
