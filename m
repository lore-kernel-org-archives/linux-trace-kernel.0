Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CE19307E;
	Thu,  6 Jun 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686192; cv=none; b=tWOuqlt1ILyYk68TAukXERgV5M/ey5I0ujuh25kHB9EmInSPPa5gf+JZnIVGZiUAM+LhxUJMrCbmV5EoYLrpmW9nsdy7aI+VxT/4WBdKyPKk7OsVc5YjK19YtZQyHSIixMvIYQpas2ct/PPnrleILGcMhsykRLDCmdPOy6QTEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686192; c=relaxed/simple;
	bh=xs5J20Qut3DYk5X4qb3dX8ARaN02QrksOWuKtXawG3I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sRxYwkkbD9IECaqApxfXoqfGvRlr7dJX9LDsAUCj2Q8Jel32/f08Qh+FF4imxeeJ8fIqAfFDptI3QpmU6yDfx+vCfq9Rk8LqMftaOmOMylYkGZh2MU29dGWxwobYfyWrL2PqTgaL6hh59aQqBev+9Fj3kBhScVgCAyHnPnDKONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2368CC32781;
	Thu,  6 Jun 2024 15:03:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFEe4-00000000oRH-3kir;
	Thu, 06 Jun 2024 11:03:16 -0400
Message-ID: <20240606150316.751642266@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 11:01:44 -0400
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
Subject: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named memory at boot up
References: <20240606150143.876469296@goodmis.org>
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
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 20 ++++
 include/linux/mm.h                            |  2 +
 mm/memblock.c                                 | 97 +++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..4b2f7fb8de66 100644
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
+			reserver_mem=12M:4096:oops ramoops.mem_name=oops
+
 	reservetop=	[X86-32,EARLY]
 			Format: nn[KMG]
 			Reserves a hole at the top of the kernel virtual
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..b4455cc02f2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
+int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..a8bf0ee9e2b4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2244,6 +2244,103 @@ void __init memblock_free_all(void)
 	totalram_pages_add(pages);
 }
 
+/* Keep a table to reserve named memory */
+#define RESERVE_MEM_MAX_ENTRIES		8
+#define RESERVE_MEM_NAME_SIZE		16
+struct reserve_mem_table {
+	char			name[RESERVE_MEM_NAME_SIZE];
+	unsigned long		start;
+	unsigned long		size;
+};
+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
+static int reserved_mem_count;
+
+/* Add wildcard region with a lookup name */
+static int __init reserved_mem_add(unsigned long start, unsigned long size,
+				   const char *name)
+{
+	struct reserve_mem_table *map;
+
+	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
+		return -EINVAL;
+
+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
+		return -1;
+
+	map = &reserved_mem_table[reserved_mem_count++];
+	map->start = start;
+	map->size = size;
+	strscpy(map->name, name);
+	return 0;
+}
+
+/**
+ * reserve_mem_find_by_name - Find reserved memory region with a given name
+ * @name: The name that is attached to a reserved memory region
+ * @start: If found, holds the start address
+ * @size: If found, holds the size of the address.
+ *
+ * Returns: 1 if found or 0 if not found.
+ */
+int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
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
+
+/*
+ * Parse early_reserve_mem=nn:align:name
+ */
+static int __init reserve_mem(char *p)
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
+	err = reserved_mem_add(start, size, p);
+	if (err) {
+		memblock_phys_free(start, size);
+		return err;
+	}
+
+	p += strlen(p);
+
+	return *p == '\0' ? 0: -EINVAL;
+}
+__setup("reserve_mem=", reserve_mem);
+
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
 static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
-- 
2.43.0


