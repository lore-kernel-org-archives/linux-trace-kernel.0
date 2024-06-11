Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C11171D;
	Tue, 11 Jun 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118727; cv=none; b=gHTu0yIj7zVdD2s9mPILkd4n7+eRrHZPVj69uGpDNK9h0vsNc/+aQqPYbqy8TJo1vYk27SDMjMTp3S9cDdT72D4SeKyEJYTqlo4jYUdhW+DKwfr9Z1a5rTq1epxItukkXQExumSVk59557RsWxwOLlrLAyVftlBs4h0lUQkvX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118727; c=relaxed/simple;
	bh=5saQjaJkdTYLgiKxvn1SsXuLfM3+RuyeeBdZ6pEK4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIx5/YINBcktlWWf9NcKaiFUzkHEtOEazYG7qOty+JlbViewQl8X6r+CRh3oJyzURFDKAj4Z4Jgm1aGmsrypTu6rbTXI801jdUeE5H50PqvdldYlzw1IZnSHyAOoqpgu18iwSATmQfCG7hcnvAF1rx2Ay71mLjgNPXsTUBpTWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D9BC2BD10;
	Tue, 11 Jun 2024 15:12:03 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:12:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel
 Fernandes <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240611111218.71e57e0f@gandalf.local.home>
In-Reply-To: <20240611144029.h7egl4aif5mjlrwf@master>
References: <20240606150143.876469296@goodmis.org>
	<20240606150316.751642266@goodmis.org>
	<20240611144029.h7egl4aif5mjlrwf@master>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 14:40:29 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

Missed this just before sending out v3 :-p

> >diff --git a/mm/memblock.c b/mm/memblock.c
> >index d09136e040d3..a8bf0ee9e2b4 100644
> >--- a/mm/memblock.c
> >+++ b/mm/memblock.c
> >@@ -2244,6 +2244,103 @@ void __init memblock_free_all(void)
> > 	totalram_pages_add(pages);
> > }
> > 
> >+/* Keep a table to reserve named memory */
> >+#define RESERVE_MEM_MAX_ENTRIES		8
> >+#define RESERVE_MEM_NAME_SIZE		16  
>                                         ^
> Suggest to align with previous line.

It is. But because the patch adds a "+", it pushed the "8" out another tab.

> 
> >+struct reserve_mem_table {
> >+	char			name[RESERVE_MEM_NAME_SIZE];
> >+	unsigned long		start;
> >+	unsigned long		size;  
> 
> phys_addr_t looks more precise?

For just the start variable, correct? I'm OK with updating that.

> 
> >+};
> >+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> >+static int reserved_mem_count;  
> 
> Seems no matter we use this feature or not, these memory would be occupied?

Yes, because allocation may screw it up as well. I could add a CONFIG
around it, so that those that do not want this could configure it out. But
since it's just a total of (16 + 8 + 8) * 8 = 256 bytes, I'm not sure it's
much of a worry to add the complexities to save that much space. As the
code to save it may likely be bigger.

> 
> >+
> >+/* Add wildcard region with a lookup name */
> >+static int __init reserved_mem_add(unsigned long start, unsigned long size,
> >+				   const char *name)
> >+{
> >+	struct reserve_mem_table *map;
> >+
> >+	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
> >+		return -EINVAL;
> >+
> >+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> >+		return -1;  
> 
> return ENOSPC? Not good at it, but a raw value maybe not a good practice.

This is what gets returned by the command line parser. It only cares if it
is zero or not.

> 
> Also, we'd better do this check before allocation.

What allocation?

> 
> >+
> >+	map = &reserved_mem_table[reserved_mem_count++];
> >+	map->start = start;
> >+	map->size = size;
> >+	strscpy(map->name, name);
> >+	return 0;
> >+}
> >+
> >+/**
> >+ * reserve_mem_find_by_name - Find reserved memory region with a given name
> >+ * @name: The name that is attached to a reserved memory region
> >+ * @start: If found, holds the start address
> >+ * @size: If found, holds the size of the address.
> >+ *
> >+ * Returns: 1 if found or 0 if not found.
> >+ */
> >+int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
> >+{
> >+	struct reserve_mem_table *map;
> >+	int i;
> >+
> >+	for (i = 0; i < reserved_mem_count; i++) {
> >+		map = &reserved_mem_table[i];
> >+		if (!map->size)
> >+			continue;
> >+		if (strcmp(name, map->name) == 0) {
> >+			*start = map->start;
> >+			*size = map->size;
> >+			return 1;
> >+		}
> >+	}
> >+	return 0;
> >+}
> >+
> >+/*
> >+ * Parse early_reserve_mem=nn:align:name  
> 
> early_reserve_mem or reserve_mem ?

Oops, that was the original name. I'll change that.

> 
> >+ */
> >+static int __init reserve_mem(char *p)
> >+{
> >+	phys_addr_t start, size, align;

Hmm, I wonder if I should change size and align to unsigned long?

> >+	char *oldp;
> >+	int err;
> >+
> >+	if (!p)
> >+		return -EINVAL;
> >+
> >+	oldp = p;
> >+	size = memparse(p, &p);
> >+	if (p == oldp)
> >+		return -EINVAL;
> >+
> >+	if (*p != ':')
> >+		return -EINVAL;
> >+
> >+	align = memparse(p+1, &p);
> >+	if (*p != ':')
> >+		return -EINVAL;
> >+  
> 
> Better to check if the name is valid here. 

You mean that it has text and is not blank?

> 
> Make sure command line parameters are valid before doing the allocation.

You mean that size is non zero?

I don't know if we care what the align is. Zero is valid.

> 
> >+	start = memblock_phys_alloc(size, align);
> >+	if (!start)
> >+		return -ENOMEM;
> >+
> >+	p++;
> >+	err = reserved_mem_add(start, size, p);
> >+	if (err) {
> >+		memblock_phys_free(start, size);
> >+		return err;
> >+	}
> >+
> >+	p += strlen(p);
> >+
> >+	return *p == '\0' ? 0: -EINVAL;  
> 
> We won't free the memory if return -EINVAL?

I guess we can do this check before the allocation, like you suggested.

Thanks for the review.

-- Steve


> 
> >+}
> >+__setup("reserve_mem=", reserve_mem);
> >+
> > #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> > static const char * const flagname[] = {
> > 	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> >-- 
> >2.43.0
> >
> >  
> 

