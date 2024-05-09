Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007F13C91A;
	Thu,  9 May 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715227227; cv=none; b=be2vEPPBr7OdnqEw0yMJ7jULbbqCEJNw1K/5kYtv4Uvruzwta6OmAO7025mDgxZQBFd5tEekOoFdnQXLMD9geJniwvPryaHPnSTsEuyrhlMlWnBznfp6YRnMzgNT4vvC+PVdQlb9QE8U31XJpnUROA2yJm6uRAnm2t/ig1Afk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715227227; c=relaxed/simple;
	bh=/WuVnMddurzRtwEvdj/SXUmfhB8S+diULnomVZxDPDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EloGbTd8levwlF1a25K/9Y4LT/cOghs4fsRoLSOwNdpME4yxzqP0nVCpWtxl9A7+eyl7tL2vxINKBOP8dGkWGq4FdKJx0M/sqMT3dFJRnHdxB2P56IVSySashlIp9O6PvQ755qCPSLTL0uhK6Cch8fxescPk2dU/DdPefu83KfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86446C116B1;
	Thu,  9 May 2024 04:00:25 +0000 (UTC)
Date: Thu, 9 May 2024 00:00:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Luck, Tony"
 <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, Joel Fernandes
 <joel@joelfernandes.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, "wklin@google.com" <wklin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Suleiman Souhlal
 <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <20240509000023.096d4032@rorschach.local.home>
In-Reply-To: <ZjJgIIOvvEdnisNA@kernel.org>
References: <20240409210254.660888920@goodmis.org>
	<20240409172358.34ea19f0@gandalf.local.home>
	<202404091519.B7B2221@keescook>
	<SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
	<3391c693-cf54-526b-79a8-d565e7140947@igalia.com>
	<20240411154007.5bdf8d95@gandalf.local.home>
	<fa5fa4c6-2b02-f47e-b9ba-65cfd85f57f8@igalia.com>
	<20240412132243.053ad096@gandalf.local.home>
	<ZjJVnZUX3NZiGW6q@kernel.org>
	<20240501105455.42b78a0b@gandalf.local.home>
	<ZjJgIIOvvEdnisNA@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 18:30:40 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > So this will allocate the same physical location for every boot, if booting
> > the same kernel and having the same physical memory layout?  
> 
> Up to kaslr that might use that location for the kernel image.
> But it's the same as allocating from e820 after kaslr.
> 
> And, TBH, I don't have good ideas how to ensure the same physical location
> with randomization of the physical address of the kernel image.
>  

I tried this approach and it unfortunately picks a different physical
location every time :-(

So it is either adding to e820 tables or we create a new way to
allocate memory at early boot up.

Below is the patch I used.

-- Steve


diff --git a/include/linux/mm.h b/include/linux/mm.h
index b6bdaa18b9e9..74aaf0bcb363 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4204,4 +4204,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
 
+int memmap_named(const char *name, unsigned long *start, unsigned long *size);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..3c015395d262 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2243,6 +2243,101 @@ void __init memblock_free_all(void)
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
 }
+/* For wildcard memory requests, have a table to find them later */
+#define MEMMAP_MAX_MAPS		8
+#define MEMMAP_NAME_SIZE	16
+struct memmap_map {
+	char			name[MEMMAP_NAME_SIZE];
+	unsigned long		start;
+	unsigned long		size;
+};
+static struct memmap_map memmap_list[MEMMAP_MAX_MAPS] __initdata;
+static int memmap_size				__initdata;
+
+/* Add wildcard region with a lookup name */
+static int __init memmap_add(u64 start, u64 size, const char *name)
+{
+	struct memmap_map *map;
+
+	if (!name || !name[0] || strlen(name) >= MEMMAP_NAME_SIZE)
+		return -EINVAL;
+
+	if (memmap_size >= MEMMAP_MAX_MAPS)
+		return -1;
+
+	map = &memmap_list[memmap_size++];
+	map->start = start;
+	map->size = size;
+	strcpy(map->name, name);
+	return 0;
+}
+
+/**
+ * memmap_named - Find a wildcard region with a given name
+ * @name: The name that is attached to a wildcard region
+ * @start: If found, holds the start address
+ * @size: If found, holds the size of the address.
+ *
+ * Returns: 1 if found or 0 if not found.
+ */
+int __init memmap_named(const char *name, unsigned long *start, unsigned long *size)
+{
+	struct memmap_map *map;
+	int i;
+
+	for (i = 0; i < memmap_size; i++) {
+		map = &memmap_list[i];
+		if (!map->size)
+			continue;
+		if (strcmp(name, map->name) == 0) {
+			*start = map->start;
+			*size = map->size;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Parse early_reserve_mem=nn:align:name
+ */
+static int __init early_reserve_mem(char *p)
+{
+	phys_addr_t start, size, align;
+	char *oldp;
+	int err;
+
+	if (!p)
+		return -EINVAL;
+
+	oldp = p;
+	size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
+
+	if (*p != ':')
+		return -EINVAL;
+
+	align = memparse(p+1, &p);
+	if (*p != ':')
+		return -EINVAL;
+
+	start = memblock_phys_alloc(size, align);
+	if (!start)
+		return -ENOMEM;
+
+	p++;
+	err = memmap_add(start, size, p);
+	if (err) {
+		memblock_phys_free(start, size);
+		return err;
+	}
+
+	p += strlen(p);
+
+	return *p == '\0' ? 0: -EINVAL;
+}
+__setup("early_reserve_mem=", early_reserve_mem);
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
 static const char * const flagname[] = {
