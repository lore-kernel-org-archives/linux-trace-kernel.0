Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034415B99B;
	Tue, 18 Jun 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715332; cv=none; b=iA9mUpDPKFxgMupnfxLfbYjhKp0DrH0jX1q2oRCpLWT4bZOo1rw8iWBgi7f3Ca8fzzKg/SEmFhJ3T+g7/W5m8vD1n9RGichZ8OoBMqK4zYnb5nhTc28e40J7PFQ+aR+0XYNjpR3G9XnQDzyC5yOqhKxyUx/VBrOxa3DQCWFbVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715332; c=relaxed/simple;
	bh=Kn8S8dUnZbDCIC+TWAp5uw60QXnA0M97hIF8La7hjMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfLtZ4hsf77wYsamSG35StzrGldL8GDNtbNCvKRTGarpLlaA3lCUA2Xims3kWAxvliB1M15SL7lv7wpJi5IuFKFkCFopGkrnJk5zJ2xDjuFybwRBOMOSGv65c+iKl3Q0dPSVhyGl+Gvqjr5F/GO7NbZFrGa/zRaF8xZU2Gn2pJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3RYY5Z23z4f3jtC;
	Tue, 18 Jun 2024 20:55:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 91F081A0FAD;
	Tue, 18 Jun 2024 20:55:20 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgCH8A21g3FmuWgiAQ--.31099S3;
	Tue, 18 Jun 2024 20:55:18 +0800 (CST)
Message-ID: <5ab67b75-4334-3678-40d2-8be98460d496@huaweicloud.com>
Date: Tue, 18 Jun 2024 20:55:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com, Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, David Howells
 <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
References: <20240613155506.811013916@goodmis.org>
 <20240613155527.437020271@goodmis.org>
From: Zhengyejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20240613155527.437020271@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH8A21g3FmuWgiAQ--.31099S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW3tw13Gry5Wry8Gr1Utrb_yoW3Gr18pr
	WxJr1FyFZrtr1xXr4Ikw1Uu3yru3Z3KF1ag34DAryDuFsrWr12gw4jgr4Yv3s5ArWvgF4q
	qF4vyayI9w4DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/6/13 23:55, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In order to allow for requesting a memory region that can be used for
> things like pstore on multiple machines where the memory layout is not the
> same, add a new option to the kernel command line called "reserve_mem".
> 
> The format is:  reserve_mem=nn:align:name
> 
> Where it will find nn amount of memory at the given alignment of align.
> The name field is to allow another subsystem to retrieve where the memory
> was found. For example:
> 
>    reserve_mem=12M:4096:oops ramoops.mem_name=oops
> 
> Where ramoops.mem_name will tell ramoops that memory was reserved for it
> via the reserve_mem option and it can find it by calling:
> 
>    if (reserve_mem_find_by_name("oops", &start, &size)) {
> 	// start holds the start address and size holds the size given
> 
> This is typically used for systems that do not wipe the RAM, and this
> command line will try to reserve the same physical memory on soft reboots.
> Note, it is not guaranteed to be the same location. For example, if KASLR
> places the kernel at the location of where the RAM reservation was from a
> previous boot, the new reservation will be at a different location.  Any
> subsystem using this feature must add a way to verify that the contents of
> the physical memory is from a previous boot, as there may be cases where
> the memory will not be located at the same location.
> 
> Not all systems may work either. There could be bit flips if the reboot
> goes through the BIOS. Using kexec to reboot the machine is likely to
> have better results in such cases.
> 
> Link: https://lore.kernel.org/all/ZjJVnZUX3NZiGW6q@kernel.org/
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   .../admin-guide/kernel-parameters.txt         |  22 ++++
>   include/linux/mm.h                            |   2 +
>   mm/memblock.c                                 | 117 ++++++++++++++++++
>   3 files changed, 141 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..56e18b1a520d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5710,6 +5710,28 @@
>   			them.  If <base> is less than 0x10000, the region
>   			is assumed to be I/O ports; otherwise it is memory.
>   
> +	reserve_mem=	[RAM]
> +			Format: nn[KNG]:<align>:<label>
> +			Reserve physical memory and label it with a name that
> +			other subsystems can use to access it. This is typically
> +			used for systems that do not wipe the RAM, and this command
> +			line will try to reserve the same physical memory on
> +			soft reboots. Note, it is not guaranteed to be the same
> +			location. For example, if anything about the system changes
> +			or if booting a different kernel. It can also fail if KASLR
> +			places the kernel at the location of where the RAM reservation
> +			was from a previous boot, the new reservation will be at a
> +			different location.
> +			Any subsystem using this feature must add a way to verify
> +			that the contents of the physical memory is from a previous
> +			boot, as there may be cases where the memory will not be
> +			located at the same location.
> +
> +			The format is size:align:label for example, to request
> +			12 megabytes of 4096 alignment for ramoops:
> +
> +			reserve_mem=12M:4096:oops ramoops.mem_name=oops
> +
>   	reservetop=	[X86-32,EARLY]
>   			Format: nn[KMG]
>   			Reserves a hole at the top of the kernel virtual
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..077fb589b88a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
>   void vma_pgtable_walk_begin(struct vm_area_struct *vma);
>   void vma_pgtable_walk_end(struct vm_area_struct *vma);
>   
> +int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
> +
>   #endif /* _LINUX_MM_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d09136e040d3..b7b0e8c3868d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2244,6 +2244,123 @@ void __init memblock_free_all(void)
>   	totalram_pages_add(pages);
>   }
>   
> +/* Keep a table to reserve named memory */
> +#define RESERVE_MEM_MAX_ENTRIES		8
> +#define RESERVE_MEM_NAME_SIZE		16
> +struct reserve_mem_table {
> +	char			name[RESERVE_MEM_NAME_SIZE];
> +	phys_addr_t		start;
> +	phys_addr_t		size;
> +};
> +static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> +static int reserved_mem_count;
> +
> +/* Add wildcard region with a lookup name */
> +static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
> +				   const char *name)
> +{
> +	struct reserve_mem_table *map;
> +
> +	map = &reserved_mem_table[reserved_mem_count++];
> +	map->start = start;
> +	map->size = size;
> +	strscpy(map->name, name);
> +}
> +
> +/**
> + * reserve_mem_find_by_name - Find reserved memory region with a given name
> + * @name: The name that is attached to a reserved memory region
> + * @start: If found, holds the start address
> + * @size: If found, holds the size of the address.
> + *
> + * @start and @size are only updated if @name is found.
> + *
> + * Returns: 1 if found or 0 if not found.
> + */
> +int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
> +{
> +	struct reserve_mem_table *map;
> +	int i;
> +
> +	for (i = 0; i < reserved_mem_count; i++) {
> +		map = &reserved_mem_table[i];
> +		if (!map->size)
> +			continue;
> +		if (strcmp(name, map->name) == 0) {
> +			*start = map->start;
> +			*size = map->size;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
> +
> +/*
> + * Parse reserve_mem=nn:align:name
> + */
> +static int __init reserve_mem(char *p)
> +{
> +	phys_addr_t start, size, align, tmp;
> +	char *name;
> +	char *oldp;
> +	int len;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	/* Check if there's room for more reserved memory */
> +	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> +		return -EBUSY;
> +
> +	oldp = p;
> +	size = memparse(p, &p);
> +	if (!size || p == oldp)
> +		return -EINVAL;
> +
> +	if (*p != ':')
> +		return -EINVAL;
> +
> +	align = memparse(p+1, &p);
> +	if (*p != ':')
> +		return -EINVAL;
> +
> +	/*
> +	 * memblock_phys_alloc() doesn't like a zero size align,
> +	 * but it is OK for this command to have it.
> +	 */
> +	if (align < SMP_CACHE_BYTES)
> +		align = SMP_CACHE_BYTES;
> +
> +	name = p + 1;
> +	len = strlen(name);
> +
> +	/* name needs to have length but not too big */
> +	if (!len || len >= RESERVE_MEM_NAME_SIZE)
> +		return -EINVAL;
> +
> +	/* Make sure that name has text */
> +	for (p = name; *p; p++) {
> +		if (!isspace(*p))
> +			break;
> +	}
> +	if (!*p)
> +		return -EINVAL;
> +
> +	/* Make sure the name is not already used */
> +	if (reserve_mem_find_by_name(name, &start, &tmp))
> +		return -EBUSY;
> +
> +	start = memblock_phys_alloc(size, align);
> +	if (!start)
> +		return -ENOMEM;
> +
> +	reserved_mem_add(start, size, name);
> +
> +	return 0;

Hi, steve, should here return 1 ? Other __setup functions
return 1 when it success.

> +}
> +__setup("reserve_mem=", reserve_mem);
> +
>   #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>   static const char * const flagname[] = {
>   	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",

