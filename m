Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077B848A;
	Mon, 17 Jun 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587727; cv=none; b=lUH++8nHVSeIq7FKnTGAiYUY+vgj9p+naaIwlgkFu+dZnDLfmgTssM3d/DFuSNvHecAXWs0GPmiKGt43NsGUgL3r+3wHUUeefaCln1jYphheNoKVRvy0r1WE3rzrYqjhkbuuOJnnOIKyQ+E7q04hsmjCf7IIRtSauvVEjP5llno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587727; c=relaxed/simple;
	bh=gcYyX/rbhGxEUiapHWTkebAWwAsd6CushS/uwpFde7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBpGZTfqHx/QAjV57D0M4yoTbQbbxF0rISxtaaA3HEmbMsH512XWFTiREr78nGCAlTabAsLpPvr+jD6jQtW8FXI4khLh8Mi8/W5iMfrkX/jWkAm5ZE3CXoly2SHTv8kvOSkzZdP8e2/G9T0672tsf6j1rDJUTyGbinfcboLap8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2rbv/P1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2rbv/P1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso502108366b.2;
        Sun, 16 Jun 2024 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718587724; x=1719192524; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F6WKgEDMzn0d9tYaT7mXbP9z0Sy1xJPRz6agENMzNg=;
        b=M2rbv/P1bg3a0CUKMr+3PEIV7TeTPwwpbhU89LWo39kwn/d3RE/C4Z2qzx4DgPOqRN
         mR5B4ATXoVx5YOQe8JcjF7QkC/TVmiDA0cgN2sj+mpMmmt+Dq/2UcA2CpVWZJDJXtyj3
         /oD/K4w6JmVfdximK8whkW3m7wS1ygKDYEwbFS1/gNeYuPgbwaq6uXRvQBRaVcGoFSUa
         j5uPTxirRtn46sR71HLVw35Xq99hqMuqLUWKvRll5cgYBdIyK8JM3W7Cixx9NPWFxarB
         QHq7zD+V1ko9WrkvZnA9MEqDfTT4Qtcr9FeMwVaxOqdjMrHRfOq//cr1PbgEz2JC23Md
         X2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718587724; x=1719192524;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3F6WKgEDMzn0d9tYaT7mXbP9z0Sy1xJPRz6agENMzNg=;
        b=FPfeNL6K09Qw+04VQklJvpZM9Ins67nT3En+HNOPP1J/0vJ2QUY7AiC60qkE6xf8jM
         ze0H1V8JRYYEYujT7ywgBv80L9f/sxuKCi4xg/PsZ2i/xiD56BiCcD6u9r3pZ7g9nv9H
         J+QbCHByySuoK3JKu+MwZQK0Jlx29EQZahHHPpBDCh2mmtBXxrDCyeP9c+ieeV7jt5j5
         8BW83tzHJaiKTDy+V+LiEHBPIg62gOGouGKMQNr1vxaKbojmu8g/NSvpLf2XfPZBudcE
         x3igPYaoX9g5gOKeLE+MRrOmroMd1kHP5c/+/KlF417zQ3wbC7ODeidZTmuWO1uDA2ff
         F1RA==
X-Forwarded-Encrypted: i=1; AJvYcCVYK16bea6RifIkP8joM/oPJ4/nCzFCVV/aZUcofYp6uHB0b9gGY+nQe97MiacRTXlDyb3oUEj9OxCej3bBzSAjR//VEA4UpfdIF2Uy6ajznE4v
X-Gm-Message-State: AOJu0YzYTQwYBWGsAOQoFzTURftoKv7sQNW2Kiid6EvNgDeWTGXOFBCg
	b/g+OAkbYYHCuZWYIY/bf5+nCUTlr3rsfB1oOL9w9icBuTbsUg4k
X-Google-Smtp-Source: AGHT+IFH7+ZwEZLw7wwu7bJNNep8fcBre79on1oim32JMFfUL9uZHZs/zPt0Kv6P+8T0XaWkz7l6Mg==
X-Received: by 2002:a17:907:96a3:b0:a6e:fb9b:676c with SMTP id a640c23a62f3a-a6f60de5d93mr730309166b.68.1718587723404;
        Sun, 16 Jun 2024 18:28:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f88f5debasm54168766b.167.2024.06.16.18.28.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2024 18:28:42 -0700 (PDT)
Date: Mon, 17 Jun 2024 01:28:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v7 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240617012842.prhkeekkgzw4anix@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240613233415.734483785@goodmis.org>
 <20240613233446.127364692@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613233446.127364692@goodmis.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jun 13, 2024 at 07:34:16PM -0400, Steven Rostedt wrote:
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
>Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>---
> .../admin-guide/kernel-parameters.txt         |  22 ++++
> include/linux/mm.h                            |   2 +
> mm/memblock.c                                 | 117 ++++++++++++++++++
> 3 files changed, 141 insertions(+)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index b600df82669d..56e18b1a520d 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -5710,6 +5710,28 @@
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
>+			location. For example, if anything about the system changes
>+			or if booting a different kernel. It can also fail if KASLR
>+			places the kernel at the location of where the RAM reservation
>+			was from a previous boot, the new reservation will be at a
>+			different location.
>+			Any subsystem using this feature must add a way to verify
>+			that the contents of the physical memory is from a previous
>+			boot, as there may be cases where the memory will not be
>+			located at the same location.
>+
>+			The format is size:align:label for example, to request
>+			12 megabytes of 4096 alignment for ramoops:
>+
>+			reserve_mem=12M:4096:oops ramoops.mem_name=oops
>+
> 	reservetop=	[X86-32,EARLY]
> 			Format: nn[KMG]
> 			Reserves a hole at the top of the kernel virtual
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 9849dfda44d4..077fb589b88a 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
> void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> void vma_pgtable_walk_end(struct vm_area_struct *vma);
> 
>+int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
>+
> #endif /* _LINUX_MM_H */
>diff --git a/mm/memblock.c b/mm/memblock.c
>index d09136e040d3..b7b0e8c3868d 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -2244,6 +2244,123 @@ void __init memblock_free_all(void)
> 	totalram_pages_add(pages);
> }
> 
>+/* Keep a table to reserve named memory */
>+#define RESERVE_MEM_MAX_ENTRIES		8
>+#define RESERVE_MEM_NAME_SIZE		16
>+struct reserve_mem_table {
>+	char			name[RESERVE_MEM_NAME_SIZE];
>+	phys_addr_t		start;
>+	phys_addr_t		size;
>+};
>+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
>+static int reserved_mem_count;
>+
>+/* Add wildcard region with a lookup name */
>+static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
>+				   const char *name)
>+{

The logic looks good to me.

My concern now is the name may bring some confusion to others. We have
memblock.memory and memblock.reserved, without some careful reading users may
think this is used to add a region to memblock.reserved.

And the words with *reserve* may remind people of the concept related to
memblock.reserved.

Not good at naming, maybe "prealloc_mem"? Someone could differentiate it would
be better.

>+	struct reserve_mem_table *map;
>+
>+	map = &reserved_mem_table[reserved_mem_count++];
>+	map->start = start;
>+	map->size = size;
>+	strscpy(map->name, name);
>+}
>+
>+/**
>+ * reserve_mem_find_by_name - Find reserved memory region with a given name
>+ * @name: The name that is attached to a reserved memory region
>+ * @start: If found, holds the start address
>+ * @size: If found, holds the size of the address.
>+ *
>+ * @start and @size are only updated if @name is found.
>+ *
>+ * Returns: 1 if found or 0 if not found.
>+ */
>+int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
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
>+EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
>+
>+/*
>+ * Parse reserve_mem=nn:align:name
>+ */
>+static int __init reserve_mem(char *p)
>+{
>+	phys_addr_t start, size, align, tmp;
>+	char *name;
>+	char *oldp;
>+	int len;
>+
>+	if (!p)
>+		return -EINVAL;
>+
>+	/* Check if there's room for more reserved memory */
>+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
>+		return -EBUSY;
>+
>+	oldp = p;
>+	size = memparse(p, &p);
>+	if (!size || p == oldp)
>+		return -EINVAL;
>+
>+	if (*p != ':')
>+		return -EINVAL;
>+
>+	align = memparse(p+1, &p);
>+	if (*p != ':')
>+		return -EINVAL;
>+
>+	/*
>+	 * memblock_phys_alloc() doesn't like a zero size align,
>+	 * but it is OK for this command to have it.
>+	 */
>+	if (align < SMP_CACHE_BYTES)
>+		align = SMP_CACHE_BYTES;
>+
>+	name = p + 1;
>+	len = strlen(name);
>+
>+	/* name needs to have length but not too big */
>+	if (!len || len >= RESERVE_MEM_NAME_SIZE)
>+		return -EINVAL;
>+
>+	/* Make sure that name has text */
>+	for (p = name; *p; p++) {
>+		if (!isspace(*p))
>+			break;
>+	}
>+	if (!*p)
>+		return -EINVAL;
>+
>+	/* Make sure the name is not already used */
>+	if (reserve_mem_find_by_name(name, &start, &tmp))
>+		return -EBUSY;
>+
>+	start = memblock_phys_alloc(size, align);
>+	if (!start)
>+		return -ENOMEM;
>+
>+	reserved_mem_add(start, size, name);
>+
>+	return 0;
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
