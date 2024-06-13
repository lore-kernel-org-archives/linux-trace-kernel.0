Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85F63A5;
	Thu, 13 Jun 2024 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238893; cv=none; b=an4CZBk4rnrtxPHWg5yEYJo9wY7lvvDKS/pIa4PZbI5NnsSalqoo2nF5Sw6mTaFFV237AJWWkMffoX3wsFmJ5s3Y8w7NLW76DeM2FsbIsfYa1l5ME7xYCoqwcgKCC8t3ZGEKSUHVfrNDYEqWAfbvhNHxUgz+6A1YmxolQW8edNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238893; c=relaxed/simple;
	bh=uhP9G8bT8fUmRQ2ghs8UzgPprc3W3L4JLL0dPpaSGH8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IjJswwRxQ4PomoJjTaOJ0AcbM2fzrJpZ2pBPhdOQlJrRVAyv/5hsjVU1vN/Zuc3KdiVZom9R5aEh9fq+TuUNe1HLZ5afheOMglL9aQV2g6phMTtShxAB7GfdJoQ9bCzeLNaUe6dnPSvmNt4kyXAEavgOhy5kfnYpGjV2PjYZxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BCCC32786;
	Thu, 13 Jun 2024 00:34:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHYQm-00000001eN3-3lZi;
	Wed, 12 Jun 2024 20:35:08 -0400
Message-ID: <20240613003508.752963299@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 20:34:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 1/2] mm/memblock: Add "reserve_mem" to reserved named memory at boot up
References: <20240613003435.401549779@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In order to allow for requesting a memory region that can be used for
things like pstore on multiple machines where the memory layout is not the
same, add a new option to the kernel command line called "reserve_mem".

The format is:  reserve_mem=nn:align:name

Where it will find nn amount of memory at the given alignment of align.
The name field is to allow another subsystem to retrieve where the memory
was found. For example:

  reserve_mem=12M:4096:oops ramoops.mem_name=oops

Where ramoops.mem_name will tell ramoops that memory was reserved for it
via the reserve_mem option and it can find it by calling:

  if (reserve_mem_find_by_name("oops", &start, &size)) {
	// start holds the start address and size holds the size given

This is typically used for systems that do not wipe the RAM, and this
command line will try to reserve the same physical memory on soft reboots.
Note, it is not guaranteed to be the same location. For example, if KASLR
places the kernel at the location of where the RAM reservation was from a
previous boot, the new reservation will be at a different location.  Any
subsystem using this feature must add a way to verify that the contents of
the physical memory is from a previous boot, as there may be cases where
the memory will not be located at the same location.

Not all systems may work either. There could be bit flips if the reboot
goes through the BIOS. Using kexec to reboot the machine is likely to
have better results in such cases.

Link: https://lore.kernel.org/all/ZjJVnZUX3NZiGW6q@kernel.org/

Suggested-by: Mike Rapoport <rppt@kernel.org>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/linux-trace-kernel/20240611215801.443593152@goodmis.org

- Add all checks about reserve_mem before allocation.
  This means reserved_mem_add() is now a void function.

- Check for name duplications.

- Fix compare of align to SMP_CACHE_BYTES ("<" instead of "<=")

 .../admin-guide/kernel-parameters.txt         |  20 +++
 include/linux/mm.h                            |   2 +
 mm/memblock.c                                 | 117 ++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..ce7de8136f2f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5710,6 +5710,26 @@
 			them.  If <base> is less than 0x10000, the region
 			is assumed to be I/O ports; otherwise it is memory.
 
+	reserve_mem=	[RAM]
+			Format: nn[KNG]:<align>:<label>
+			Reserve physical memory and label it with a name that
+			other subsystems can use to access it. This is typically
+			used for systems that do not wipe the RAM, and this command
+			line will try to reserve the same physical memory on
+			soft reboots. Note, it is not guaranteed to be the same
+			location. For example, if KASLR places the kernel at the
+			location of where the RAM reservation was from a previous
+			boot, the new reservation will be at a different location.
+			Any subsystem using this feature must add a way to verify
+			that the contents of the physical memory is from a previous
+			boot, as there may be cases where the memory will not be
+			located at the same location.
+
+			The format is size:align:label for example, to request
+			12 megabytes of 4096 alignment for ramoops:
+
+			reserve_mem=12M:4096:oops ramoops.mem_name=oops
+
 	reservetop=	[X86-32,EARLY]
 			Format: nn[KMG]
 			Reserves a hole at the top of the kernel virtual
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..077fb589b88a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
+int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..739d106a9165 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2244,6 +2244,123 @@ void __init memblock_free_all(void)
 	totalram_pages_add(pages);
 }
 
+/* Keep a table to reserve named memory */
+#define RESERVE_MEM_MAX_ENTRIES		8
+#define RESERVE_MEM_NAME_SIZE		16
+struct reserve_mem_table {
+	char			name[RESERVE_MEM_NAME_SIZE];
+	phys_addr_t		start;
+	phys_addr_t		size;
+};
+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
+static int reserved_mem_count;
+
+/* Add wildcard region with a lookup name */
+static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
+				   const char *name)
+{
+	struct reserve_mem_table *map;
+
+	map = &reserved_mem_table[reserved_mem_count++];
+	map->start = start;
+	map->size = size;
+	strscpy(map->name, name);
+}
+
+/**
+ * reserve_mem_find_by_name - Find reserved memory region with a given name
+ * @name: The name that is attached to a reserved memory region
+ * @start: If found, holds the start address
+ * @size: If found, holds the size of the address.
+ *
+ * @start and @size are only updated if @name is found.
+ *
+ * Returns: 1 if found or 0 if not found.
+ */
+int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
+{
+	struct reserve_mem_table *map;
+	int i;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		map = &reserved_mem_table[i];
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
+EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
+
+/*
+ * Parse reserve_mem=nn:align:name
+ */
+static int __init reserve_mem(char *p)
+{
+	phys_addr_t start, size, align;
+	char *name;
+	char *oldp;
+	int len;
+
+	if (!p)
+		return -EINVAL;
+
+	/* Check if there's room for more reserved memory */
+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
+		return -EBUSY;
+
+	oldp = p;
+	size = memparse(p, &p);
+	if (!size || p == oldp)
+		return -EINVAL;
+
+	if (*p != ':')
+		return -EINVAL;
+
+	align = memparse(p+1, &p);
+	if (*p != ':')
+		return -EINVAL;
+
+	/*
+	 * memblock_phys_alloc() doesn't like a zero size align,
+	 * but it is OK for this command to have it.
+	 */
+	if (align < SMP_CACHE_BYTES)
+		align = SMP_CACHE_BYTES;
+
+	name = p + 1;
+	len = strlen(name);
+
+	/* name needs to have length but not too big */
+	if (!len || len >= RESERVE_MEM_NAME_SIZE)
+		return -EINVAL;
+
+	/* Make sure that name has text */
+	for (p = name; *p; p++) {
+		if (!isspace(*p))
+			break;
+	}
+	if (!*p)
+		return -EINVAL;
+
+	/* Make sure the name is not already used (size is only updated if found) */
+	if (reserve_mem_find_by_name(name, &start, &size))
+		return -EBUSY;
+
+	start = memblock_phys_alloc(size, align);
+	if (!start)
+		return -ENOMEM;
+
+	reserved_mem_add(start, size, name);
+
+	return 0;
+}
+__setup("reserve_mem=", reserve_mem);
+
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
 static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
-- 
2.43.0


