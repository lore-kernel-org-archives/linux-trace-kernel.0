Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404D18EAB;
	Tue, 11 Jun 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144772; cv=none; b=PK72SLYfnyGH1gcNsoJ7uKmtfiK+59gixjSYWrM5uofTscMnoEFuu87aP3t71M9LchON66ZAtPYfXIW/6nixy1EEzoiJeklRaAk0Agr1Im6tGyeAIEmtoUx2WaIaR2GPk7o6pRfitOKWsgaV9xO/eFT69U+B23ikU7tYKY94Jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144772; c=relaxed/simple;
	bh=97P3M9tSwxG1+WXAVu//u6Lo+Muf0Jlq0PIE3q2jHpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9uPSU8xGCeOTa2Ou64ZUkc8lt0RMlpTl8jvv0JX0ZGIid1zgb4c0D58mktqPnpTUsWgvc5q/hhwptsrFkqKYXEq2i7bt6VhMjmsHUJUmQ8RA1arbbVKcZKwgT1Fs8nUWZVpkArNBaMHWiGzhMft8FHv82SP2ZBAyRW1Zdu00lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQyW+b2U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQyW+b2U"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7041a7d4beeso3819957b3a.2;
        Tue, 11 Jun 2024 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718144770; x=1718749570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hGskSVQkT2mm+p3WVge1MIXMpsZtd5S/K/cQqHXRB6Q=;
        b=FQyW+b2U73mX+YkJo7ZaBPwynNK7YCmGoCzsJQ/ERPN4/vwqdvut9p4Gh18bdK6vdq
         pz7020kKyxBGA7LvOjCBl/FPLPTeKPyGb6JRgH8QLyuqsI5CdfQjJvYsNrPEfoogao0e
         JcF0KbGBSEFVfZPp+OEB9SoLFeUQADG0S0ofzez7wgR0cQcGIOVuPArNXdedluFYNx/M
         1lGIfNrRhrzpq+Fc7YHzNXK84ggTUdIDDsuKMoP1s4dFrdgP5lkBNUrfLzqIgRWDaTYn
         IT7kzHVhSSFDyyl+LFiKeog8Us/SCsIpLkDFSfEzKqKXEMr+jyUWLbYD0NGPKg6aj6qY
         pGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144770; x=1718749570;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGskSVQkT2mm+p3WVge1MIXMpsZtd5S/K/cQqHXRB6Q=;
        b=mxsOas7zRUivvmJQCvFhi3jfb1OkSwtPmQc3KENG5cBNfxyzkZtFFFN3GOpv+7+fdf
         GbqUihTYFkwsNEuR1P1U0BOrS8rx0jnuvyUBmJqZgUA93fFbwnj9xBD4a0WOEODSMghc
         rNjGXr/R+UHMvWOOEjCCq3iQS2VuwLG8u1ScAW8L2ESd+kyBPqMFnbLI9YtYErOi5pZs
         vxt8TFf+WeIJgZzXIL0Ii6R1Es8OAIObtLY2C/McWXq+9kC7XNjhXilQ9xIw5oiCK6C6
         m1JEX20WK3AJZIGQ9wnnb7QY4lz+JUA1HhwhEgvagjhT1NKykjcvWqqEOOF+JtGBmL4K
         aLhw==
X-Forwarded-Encrypted: i=1; AJvYcCXEVS/m4hpGpugDf9P99oIVG+36ueADHnLDgCdEglIuU1rrEAliUZLnn52zuG/RJucRs5WoC6MmULZBQO9D1PDAZdCJE1BNFNx2EJcTbAKx6daonjWwx8iXTe3yrSDM+UGmYkvyrPBBC43TptXCD4TZRr1iT+XJeMogfrn+v5AaYpudPq27oZemIhQvQBNRuaOp
X-Gm-Message-State: AOJu0YyNmx2VJdC1Eyl9aIg7aCwOYGQZXENz1xD+2xc9J3Dp8kiVr8Z+
	zMISeRhRrTBVDRkdDPE6Npxfy2AroBXDQSffBm19TBA0h72Cj2s94FbCmA==
X-Google-Smtp-Source: AGHT+IGHO0/v3bIPOwuYDy9no5nG00gA81F2repN6PXwifWm5ctvLizddccW9lmxtL+RKYTY2Ktofw==
X-Received: by 2002:a05:6a00:3d10:b0:705:9ba5:f3e9 with SMTP id d2e1a72fcca58-705bced526bmr219251b3a.30.1718144769422;
        Tue, 11 Jun 2024 15:26:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7059534a4c4sm4245488b3a.36.2024.06.11.15.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 15:26:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d6c55ff7-91ac-4505-b821-1416d57edda9@roeck-us.net>
Date: Tue, 11 Jun 2024 15:26:05 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org,
 Ross Zwisler <zwisler@google.com>, wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
References: <20240611215610.548854415@goodmis.org>
 <20240611215801.443593152@goodmis.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240611215801.443593152@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 14:56, Steven Rostedt wrote:
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
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v3: https://lore.kernel.org/linux-trace-kernel/20240606150316.751642266@goodmis.org
> 
> - Changed table type of start and size from unsigned long to phys_addr_t
>    (as well as the parameters to the functions that use them)
> 
> - Changed old reference to "early_reserve_mem" to "reserve_mem"
> 
> - Check before reservering memory:
>    o Size is non-zero
>    o name has text in it
> 
> - If align is less than SMP_CACHE_BYTES, make it SMP_CACHE_BYTES
> 
> - Remove the silly check of testing *p == '\0' after a p += strlen(p)
> 
>   .../admin-guide/kernel-parameters.txt         |  20 +++
>   include/linux/mm.h                            |   2 +
>   mm/memblock.c                                 | 115 ++++++++++++++++++
>   3 files changed, 137 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..ce7de8136f2f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5710,6 +5710,26 @@
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
> +			location. For example, if KASLR places the kernel at the
> +			location of where the RAM reservation was from a previous
> +			boot, the new reservation will be at a different location.
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
> index d09136e040d3..044ddce8f085 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2244,6 +2244,121 @@ void __init memblock_free_all(void)
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
> +static int __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
> +				   const char *name)
> +{
> +	struct reserve_mem_table *map;
> +
> +	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
> +		return -EINVAL;
> +

I know I am picky, but name is never NULL, and strlen(name) is guaranteed to be > 0.
Personally I'd suggest to check for strlen(name) >= RESERVE_MEM_NAME_SIZE together
with !strlen(name) and drop the duplicate checks here (and, as side effect, avoid
the pointless memory allocation if the name is invalid).

> +	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> +		return -1;
> +
> +	map = &reserved_mem_table[reserved_mem_count++];
> +	map->start = start;
> +	map->size = size;
> +	strscpy(map->name, name);
> +	return 0;
> +}
> +
> +/**
> + * reserve_mem_find_by_name - Find reserved memory region with a given name
> + * @name: The name that is attached to a reserved memory region
> + * @start: If found, holds the start address
> + * @size: If found, holds the size of the address.
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
> +	phys_addr_t start, size, align;
> +	char *name;
> +	char *oldp;
> +	int err;
> +
> +	if (!p)
> +		return -EINVAL;
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
> +	if (align <= SMP_CACHE_BYTES)

Any reason for using <= instead of < ?

Guenter

> +		align = SMP_CACHE_BYTES;
> +
> +	name = p + 1;
> +	if (!strlen(name))
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
> +	start = memblock_phys_alloc(size, align);
> +	if (!start)
> +		return -ENOMEM;
> +
> +	err = reserved_mem_add(start, size, name);
> +	if (err) {
> +		memblock_phys_free(start, size);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +__setup("reserve_mem=", reserve_mem);
> +
>   #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>   static const char * const flagname[] = {
>   	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",

