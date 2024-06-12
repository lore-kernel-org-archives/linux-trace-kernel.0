Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05829413;
	Wed, 12 Jun 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177455; cv=none; b=M3j+ggPXNFOk14nzrwsyLnNtyM5Pv8l7BwRnVKVAW+X9NquSvErNH78vBJzmaWMI+4YJlevdDd2ZyWLBRc6rKY2Wwvl0idw9sugDAv3VY/1Fpo9afahtLIiHxSi7i9pjFpWeio2QDhG70VD19Kp8iVWbzct1FwpMMnj1Slu6PBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177455; c=relaxed/simple;
	bh=agPMNzLdSO0SU0PfpyNTXaVlt30ktrN5sKjcpxAHw0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TznQNl9gbShhcHMoruh/zYP2ISSeBR507sitPKU2RamtxALkkJmC4w1REyFFODwr9o/A476EYPQMA0MxXznmG5w4YXcdCpEtxUK41G5fhpkRKoSSyr8v4QTN1nwA4B0xKVCmX/WuwseRm8GBOd6A7YkND3nVX7QcwQIyO2jnb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcpDHefw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcpDHefw"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1111967a12.1;
        Wed, 12 Jun 2024 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718177451; x=1718782251; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX3oJ82eNeO5bizIMhHP+nlMW1vS5qyRXC4dQHMZXzQ=;
        b=GcpDHefwV5P9Fdk+n/Bg/5UlnvLqmIArqDbLsVcPKOlodPI8cC9YmFLubkXIfEWPOZ
         G9Wk+Vcv5ytu1l2mEYFFO5PDygPZQIPrgOatYpx99y4RAxD/m29l+GI6FktiFR3SfDt8
         j4xZ79hpImiIEqDJswZjlkpNlYAS39TUOuk86SrqMfbojnWNIe190u1+TFCKYsI2M6QB
         j2PfLjIrGeLjfnzui+SKnAOnUx+XNlNrMOQe3+dARiWUauVWlwdgjt3mplg54ZIz9nOd
         bKxLkbKb813FjvwMBQVFuutKPQBODF2gxx1pYEgUPlijt0c8CeU6xTNwpmT9QlwoTpno
         p41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718177451; x=1718782251;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JX3oJ82eNeO5bizIMhHP+nlMW1vS5qyRXC4dQHMZXzQ=;
        b=gWujIN0aJYrjSkyaq9IHett2hNUHTN2t0DaPs8iwZf7RktD+s1WWKnSyOmI0WqXiKE
         OO8VLaG7t0BvJ+Nc35jAQTK3+3bYN97OE+909Zid0hOqSkQggsWlgP30jQEbQI72DWzg
         53MXNyceocdZThgvAxv5j9x6hXRJ2MLRWc2ML78VBrFbWIB7F6op79YyhZQjLboWTyy2
         YoU3LUU9eCXgJCEohBUi6JXBxqr3dnHzhGtnymwzVBPKaAafmPUsa3Trj2mz2H740jFX
         rzZ4toifvPtITwJgPPhRdd7jIVxRp8IrVcVWsDLzU+cIO5RlzfmYerOqE/izwo+fFvOF
         2Oow==
X-Forwarded-Encrypted: i=1; AJvYcCUE4azTsLj2smnuU1SiTGxFItf9N9aKeBVpz2v3+blubVc9FsK9X5To06tmTFHKQGAVZJys7j/f7wrSHzgrg/vh2fO0eiI82COUgaag9oMYBQaa3PhUmoUs6hGewWRXn7hSXMDW6OhjcM3tKYRbBm4jOfVf
X-Gm-Message-State: AOJu0Yyki771diO3VGsu7i1XrMCvYpDVTbPX7Uimf8Gv9csiy7TMA1ay
	T++I2oOAfhADmxcW0usr2L/ifhmErn+ikX7/YWfcC72Dsyij7jHL2IrG2fGjRYI=
X-Google-Smtp-Source: AGHT+IH10d8wKZW7QVcduV/RLxAQsP/7llA3XpbI+F3SWl6OF6LKMYpTn+arhdpnxgG7EWeXdwdKug==
X-Received: by 2002:a05:6402:791:b0:578:6360:aa11 with SMTP id 4fb4d7f45d1cf-57c90a228admr3208454a12.5.1718177451021;
        Wed, 12 Jun 2024 00:30:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c874e3cb6sm4006384a12.27.2024.06.12.00.30.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 00:30:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:30:49 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240612073049.xof3ciae2x5qjp6a@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240606150143.876469296@goodmis.org>
 <20240606150316.751642266@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606150316.751642266@goodmis.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jun 06, 2024 at 11:01:44AM -0400, Steven Rostedt wrote:
>From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
>In order to allow for requesting a memory region that can be used for
>things like pstore on multiple machines where the memory layout is not the
>same, add a new option to the kernel command line called "reserve_mem".
>
>The format is:  reserve_mem=nn:align:name
>
>Where it will find nn amount of memory at the given alignment of align.
>The name field is to allow another subsystem to retrieve where the memory
>was found. For example:
>
>  reserve_mem=12M:4096:oops ramoops.mem_name=oops
>
>Where ramoops.mem_name will tell ramoops that memory was reserved for it
>via the reserve_mem option and it can find it by calling:
>
>  if (reserve_mem_find_by_name("oops", &start, &size)) {
>	// start holds the start address and size holds the size given
>
>This is typically used for systems that do not wipe the RAM, and this
>command line will try to reserve the same physical memory on soft reboots.
>Note, it is not guaranteed to be the same location. For example, if KASLR
>places the kernel at the location of where the RAM reservation was from a
>previous boot, the new reservation will be at a different location.  Any
>subsystem using this feature must add a way to verify that the contents of
>the physical memory is from a previous boot, as there may be cases where
>the memory will not be located at the same location.
>
>Not all systems may work either. There could be bit flips if the reboot
>goes through the BIOS. Using kexec to reboot the machine is likely to
>have better results in such cases.
>
>Link: https://lore.kernel.org/all/ZjJVnZUX3NZiGW6q@kernel.org/
>
>Suggested-by: Mike Rapoport <rppt@kernel.org>
>Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>---
> .../admin-guide/kernel-parameters.txt         | 20 ++++
> include/linux/mm.h                            |  2 +
> mm/memblock.c                                 | 97 +++++++++++++++++++
> 3 files changed, 119 insertions(+)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index b600df82669d..4b2f7fb8de66 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -5710,6 +5710,26 @@
> 			them.  If <base> is less than 0x10000, the region
> 			is assumed to be I/O ports; otherwise it is memory.
> 
>+	reserve_mem=	[RAM]
>+			Format: nn[KNG]:<align>:<label>
>+			Reserve physical memory and label it with a name that
>+			other subsystems can use to access it. This is typically
>+			used for systems that do not wipe the RAM, and this command
>+			line will try to reserve the same physical memory on
>+			soft reboots. Note, it is not guaranteed to be the same
>+			location. For example, if KASLR places the kernel at the
>+			location of where the RAM reservation was from a previous
>+			boot, the new reservation will be at a different location.
>+			Any subsystem using this feature must add a way to verify
>+			that the contents of the physical memory is from a previous
>+			boot, as there may be cases where the memory will not be
>+			located at the same location.
>+
>+			The format is size:align:label for example, to request
>+			12 megabytes of 4096 alignment for ramoops:
>+
>+			reserver_mem=12M:4096:oops ramoops.mem_name=oops
>+
> 	reservetop=	[X86-32,EARLY]
> 			Format: nn[KMG]
> 			Reserves a hole at the top of the kernel virtual
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 9849dfda44d4..b4455cc02f2c 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
> void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> void vma_pgtable_walk_end(struct vm_area_struct *vma);
> 
>+int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size);
>+
> #endif /* _LINUX_MM_H */
>diff --git a/mm/memblock.c b/mm/memblock.c
>index d09136e040d3..a8bf0ee9e2b4 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -2244,6 +2244,103 @@ void __init memblock_free_all(void)
> 	totalram_pages_add(pages);
> }
> 
>+/* Keep a table to reserve named memory */
>+#define RESERVE_MEM_MAX_ENTRIES		8
>+#define RESERVE_MEM_NAME_SIZE		16
>+struct reserve_mem_table {
>+	char			name[RESERVE_MEM_NAME_SIZE];
>+	unsigned long		start;
>+	unsigned long		size;
>+};
>+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
>+static int reserved_mem_count;
>+
>+/* Add wildcard region with a lookup name */
>+static int __init reserved_mem_add(unsigned long start, unsigned long size,
>+				   const char *name)
>+{
>+	struct reserve_mem_table *map;
>+
>+	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
>+		return -EINVAL;
>+
>+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
>+		return -1;

Another thing come to my mind: could we specify several reserve_mem on the
command line?

If so, we may need to check whether names conflict.

>+
>+	map = &reserved_mem_table[reserved_mem_count++];
>+	map->start = start;
>+	map->size = size;
>+	strscpy(map->name, name);
>+	return 0;
>+}
>+
>+/**
>+ * reserve_mem_find_by_name - Find reserved memory region with a given name
>+ * @name: The name that is attached to a reserved memory region
>+ * @start: If found, holds the start address
>+ * @size: If found, holds the size of the address.
>+ *
>+ * Returns: 1 if found or 0 if not found.
>+ */
>+int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
>+{
>+	struct reserve_mem_table *map;
>+	int i;
>+
>+	for (i = 0; i < reserved_mem_count; i++) {
>+		map = &reserved_mem_table[i];
>+		if (!map->size)
>+			continue;
>+		if (strcmp(name, map->name) == 0) {
>+			*start = map->start;
>+			*size = map->size;
>+			return 1;
>+		}
>+	}
>+	return 0;
>+}
>+
>+/*
>+ * Parse early_reserve_mem=nn:align:name
>+ */
>+static int __init reserve_mem(char *p)
>+{
>+	phys_addr_t start, size, align;
>+	char *oldp;
>+	int err;
>+
>+	if (!p)
>+		return -EINVAL;
>+
>+	oldp = p;
>+	size = memparse(p, &p);
>+	if (p == oldp)
>+		return -EINVAL;
>+
>+	if (*p != ':')
>+		return -EINVAL;
>+
>+	align = memparse(p+1, &p);
>+	if (*p != ':')
>+		return -EINVAL;
>+
>+	start = memblock_phys_alloc(size, align);
>+	if (!start)
>+		return -ENOMEM;
>+
>+	p++;
>+	err = reserved_mem_add(start, size, p);
>+	if (err) {
>+		memblock_phys_free(start, size);
>+		return err;
>+	}
>+
>+	p += strlen(p);
>+
>+	return *p == '\0' ? 0: -EINVAL;
>+}
>+__setup("reserve_mem=", reserve_mem);
>+
> #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> static const char * const flagname[] = {
> 	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
>-- 
>2.43.0
>
>

-- 
Wei Yang
Help you, Help me
