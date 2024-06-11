Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1017D898;
	Tue, 11 Jun 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116835; cv=none; b=ooZ11Oy7gCie9cUOJvP/EX0txIxiu5y/5WSJ1iQa+Q66s7uMlGNH8Mkf7ktCRQWYHIX1jIGJr5h3OKfOYqeNSlWoXfy6d8Gg/7mE5rNjjOH45qcgtoUe/ZbvsOOr4jESRNeLZJ60zgkR6uPTtXDaM9kbVGu6aluEwz6RxJ2pdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116835; c=relaxed/simple;
	bh=E+eifSgiqjt0/Xb7FI0O+6SLORcIIdWOsj17VsAssYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgr9PhchtgrSOn+Z07vFCVgvnX1cGX5ljVgxCUk9iH5ftyVpAkxrZj2j7ZhY5qrDWuoRY6aBkVOpAg7Qla8h1s9OYDzb3RuL+xLYlgg69c/evAnHRQRGTKnpFaTbQYOVwN2qQXlbeeLEmFrgwwAwwFmL/oXhPWXDTEsM1KAq41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE6jUO9I; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE6jUO9I"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f176c5c10so129936066b.2;
        Tue, 11 Jun 2024 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718116831; x=1718721631; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD74/Q6BwBYrB0ifBeus+QerIwpQuK+1OT0JxpVCDgY=;
        b=iE6jUO9IZgUTtXbL2BUhuIbqQBr262KkNyrNC2geNCgFzhRBdQGXjuwXzIa3c0hZH1
         uQqxawdSrGVoTWZre6jmTnrfoQ5R6hbWoHiisNOKn6hhIUIR9oKRR6ekpMQulNoTEPQ3
         yB+9raoWGdklYWwi5N9xGtnPOOJjYnE0/pfI2E8Ujx4xdjZ+YzHwqwQxCIJSpH3nwia3
         wEXxfcwiZWtA60fddc2dlwRsfXnFxcs4ojs4TQvMzlbSP5kNLcX+hKYGcQifYOZf96Kt
         6dEpUuAwZq2MrldraoLh8gQlktMy3rR9f9kLxj/Ph6kSPX2+hUyxqApS7pbqsObroKVW
         K+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718116831; x=1718721631;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD74/Q6BwBYrB0ifBeus+QerIwpQuK+1OT0JxpVCDgY=;
        b=rYAkbof44XMC9tqjjIs5AwEP8xI97zIgru7MhL0ufmyqOeT4x8R6Ktag33cFaCznIv
         8DRMxs8k6eWWjGQ5ttrvzxENN4wHQTwaRi3KxjzaPg4l6giu9E6P42pUctJMvNjMlggj
         WSf1Gh12c4kPEQSZUPYnYXNrb/ZD+o2/nQsBoyMLNnTVkps87GpaChbu5VGrIfR2nW2y
         0VxG5CqmCO1/RX0PJ1/1qFxe7zt+J1ME5EicYuQEmlpVgc0tXI6xd32V6wyvb2opOceX
         bl5QyHt99Sbil1axm7IHsn4xORv1I4AxstJJdfZVjSCfpworhWSld+54cMDLKf/QZW9N
         EZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvK1vsu7U9SD2BS8VUik0usSZvn40eYPKbMJAYdGTk+XQdIMe+ojdBndE4F+gf3RwlFnDQthwA9KYjT2fOl476KUxKk4DepqAgCvnDH28wMWl3frnE0kxkrqHr7UZZZXIk7e9yZcwaQSEWigytaCejSWX+
X-Gm-Message-State: AOJu0YwJnpND2xcb7epz8+/BG9/RFLEaqFFhuYwKPccN2P2WaKiz4nvR
	Q4qBGs02FXFNbWw709jU6M6I3VwNmfyDLj5NfwFQX3ngqUnFIU6DP5DPvm/dwPY=
X-Google-Smtp-Source: AGHT+IETTSmb9f2mSZl1DzcL730oxQUbsn9eKmJZp9/x4oOat5y9b76ZBSsAyPdKyr0ZFXTiyYPY+w==
X-Received: by 2002:a17:906:b0ce:b0:a68:d2dd:e006 with SMTP id a640c23a62f3a-a6cd6d17d61mr867037466b.17.1718116831044;
        Tue, 11 Jun 2024 07:40:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f34591542sm115300466b.55.2024.06.11.07.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2024 07:40:30 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:40:29 +0000
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
Message-ID: <20240611144029.h7egl4aif5mjlrwf@master>
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
                                        ^
Suggest to align with previous line.

>+struct reserve_mem_table {
>+	char			name[RESERVE_MEM_NAME_SIZE];
>+	unsigned long		start;
>+	unsigned long		size;

phys_addr_t looks more precise?

>+};
>+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
>+static int reserved_mem_count;

Seems no matter we use this feature or not, these memory would be occupied?

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

return ENOSPC? Not good at it, but a raw value maybe not a good practice.

Also, we'd better do this check before allocation.

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

early_reserve_mem or reserve_mem ?

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

Better to check if the name is valid here. 

Make sure command line parameters are valid before doing the allocation.

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

We won't free the memory if return -EINVAL?

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
