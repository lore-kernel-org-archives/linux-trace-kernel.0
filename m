Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9A15383D;
	Tue, 11 Jun 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143065; cv=none; b=pxrWnQMcHsWVxSj+d0rUODV8EzP/51lYYJtVeDSoAtJ3yeD1a09h+aqIow1YDSgFYEiiswu0s85DVBEBIqDhwhkvQ636/bQ3Ih2aUY5M2Tuv94UgXFDKyWQYfY6kJdBETJ6TAf5NUAtT98LAydRshxePXODVgd9djXOSF8sL1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143065; c=relaxed/simple;
	bh=QbebTA/mPlAlWAfAArNwWxAgzrx+BQhUoQiQg16EKEQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=MQPSqjK3SYNzRscZ8obOiloCQff4AdJKfuyk8vtlunj0nn8khWhGr8pqoKRXE2WlG2vGSM2u8kfOOJ3d99TrvQXNz4v+GvhDbxVc/YYfO9cGrlGvhROsqAi/mrK3ypWaXyhXXmXXbf4ddwzxOqHXU6s8WeD6Z8rpoTigEEbySUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1C3C2BD10;
	Tue, 11 Jun 2024 21:57:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH9VB-00000001VSw-1jX9;
	Tue, 11 Jun 2024 17:58:01 -0400
Message-ID: <20240611215610.548854415@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 17:56:10 -0400
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
Subject: [PATCH v4 0/2] mm/memblock: Add "reserve_mem" to reserved named  memory at boot up
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Reserve unspecified location of physical memory from kernel command line

Background:

In ChromeOS, we have 1 MB of pstore ramoops reserved so that we can extract
dmesg output and some other information when a crash happens in the field.
(This is only done when the user selects "Allow Google to collect data for
 improving the system"). But there are cases when there's a bug that
requires more data to be retrieved to figure out what is happening. We would
like to increase the pstore size, either temporarily, or maybe even
permanently. The pstore on these devices are at a fixed location in RAM (as
the RAM is not cleared on soft reboots nor crashes). The location is chosen
by the BIOS (coreboot) and passed to the kernel via ACPI tables on x86.
There's a driver that queries for this to initialize the pstore for
ChromeOS:

  See drivers/platform/chrome/chromeos_pstore.c

Problem:

The problem is that, even though there's a process to change the kernel on
these systems, and is done regularly to install updates, the firmware is
updated much less frequently. Choosing the place in RAM also takes special
care, and may be in a different address for different boards. Updating the
size via firmware is a large effort and not something that many are willing
to do for a temporary pstore size change.

Requirement:

Need a way to reserve memory that will be at a consistent location for
every boot, if the kernel and system are the same. Does not need to work
if rebooting to a different kernel, or if the system can change the
memory layout between boots.

The reserved memory can not be an hard coded address, as the same kernel /
command line needs to run on several different machines. The picked memory
reservation just needs to be the same for a given machine, but may be
different for different machines.

Solution:

The solution I have come up with is to introduce a new "reserve_mem=" kernel
command line. This parameter takes the following format:

  reserve_mem=nn:align:label

Where nn is the size of memory to reserve, the align is the alignment of
that memory, and label is the way for other sub-systems to find that memory.
This way the kernel command line could have:

  reserve_mem=12M:4096:oops   ramoops.mem_name=oops

At boot up, the kernel will search for 12 megabytes in usable memory regions
with an alignment of 4096. It will start at the highest regions and work its
way down (for those old devices that want access to lower address DMA). When
it finds a region, it will save it off in a small table and mark it with the
"oops" label. Then the pstore ramoops sub-system could ask for that memory
and location, and it will map itself there.

This prototype allows for 8 different mappings (which may be overkill, 4 is
probably plenty) with 16 byte size to store the label.

I have tested this and it works for us to solve the above problem. We can
update the kernel and command line and increase the size of pstore without
needing to update the firmware, or knowing every memory layout of each
board. I only tested this locally, it has not been tested in the field.

Changes since v3: https://lore.kernel.org/all/20240611144911.327227285@goodmis.org/

[ patch at bottom showing differences ]

- Changed table type of start and size from unsigned long to phys_addr_t
  (as well as the parameters to the functions that use them)

- Changed old reference to "early_reserve_mem" to "reserve_mem"

- Check before reservering memory:
  o Size is non-zero
  o name has text in it

- If align is less than SMP_CACHE_BYTES, make it SMP_CACHE_BYTES

- Remove the silly check of testing *p == '\0' after a p += strlen(p)

Changes since v2: https://lore.kernel.org/all/20240606150143.876469296@goodmis.org/

- Fixed typo of "reserver"

- Added EXPORT_SYMBOL_GPL() for reserve_mem_find_by_name()

- Removed "built-in" from module description that was changed from v1.


Changes since v1: https://lore.kernel.org/all/20240603233330.801075898@goodmis.org/

- Updated the change log of the first patch as well as added an entry
  into kernel-parameters.txt about how reserve_mem is for soft reboots
  and may not be reliable. 


Steven Rostedt (Google) (2):
      mm/memblock: Add "reserve_mem" to reserved named memory at boot up
      pstore/ramoops: Add ramoops.mem_name= command line option


Steven Rostedt (Google) (2):
      mm/memblock: Add "reserve_mem" to reserved named memory at boot up
      pstore/ramoops: Add ramoops.mem_name= command line option

----
 Documentation/admin-guide/kernel-parameters.txt |  20 +++++
 fs/pstore/ram.c                                 |  14 +++
 include/linux/mm.h                              |   2 +
 mm/memblock.c                                   | 115 ++++++++++++++++++++++++
 4 files changed, 151 insertions(+)


diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 0653b76c70fe..4311fcbc84f2 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -919,8 +919,8 @@ static void __init ramoops_register_dummy(void)
 	struct ramoops_platform_data pdata;
 
 	if (mem_name) {
-		unsigned long start;
-		unsigned long size;
+		phys_addr_t start;
+		phys_addr_t size;
 
 		if (reserve_mem_find_by_name(mem_name, &start, &size)) {
 			mem_address = start;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b4455cc02f2c..077fb589b88a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4263,6 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
-int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size);
+int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
 #endif /* _LINUX_MM_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 60a2161de351..044ddce8f085 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2249,14 +2249,14 @@ void __init memblock_free_all(void)
 #define RESERVE_MEM_NAME_SIZE		16
 struct reserve_mem_table {
 	char			name[RESERVE_MEM_NAME_SIZE];
-	unsigned long		start;
-	unsigned long		size;
+	phys_addr_t		start;
+	phys_addr_t		size;
 };
 static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
 static int reserved_mem_count;
 
 /* Add wildcard region with a lookup name */
-static int __init reserved_mem_add(unsigned long start, unsigned long size,
+static int __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
 				   const char *name)
 {
 	struct reserve_mem_table *map;
@@ -2282,7 +2282,7 @@ static int __init reserved_mem_add(unsigned long start, unsigned long size,
  *
  * Returns: 1 if found or 0 if not found.
  */
-int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
+int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
 {
 	struct reserve_mem_table *map;
 	int i;
@@ -2302,11 +2302,12 @@ int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned lo
 EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
 
 /*
- * Parse early_reserve_mem=nn:align:name
+ * Parse reserve_mem=nn:align:name
  */
 static int __init reserve_mem(char *p)
 {
 	phys_addr_t start, size, align;
+	char *name;
 	char *oldp;
 	int err;
 
@@ -2315,7 +2316,7 @@ static int __init reserve_mem(char *p)
 
 	oldp = p;
 	size = memparse(p, &p);
-	if (p == oldp)
+	if (!size || p == oldp)
 		return -EINVAL;
 
 	if (*p != ':')
@@ -2325,20 +2326,36 @@ static int __init reserve_mem(char *p)
 	if (*p != ':')
 		return -EINVAL;
 
+	/*
+	 * memblock_phys_alloc() doesn't like a zero size align,
+	 * but it is OK for this command to have it.
+	 */
+	if (align <= SMP_CACHE_BYTES)
+		align = SMP_CACHE_BYTES;
+
+	name = p + 1;
+	if (!strlen(name))
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
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
 
-	p++;
-	err = reserved_mem_add(start, size, p);
+	err = reserved_mem_add(start, size, name);
 	if (err) {
 		memblock_phys_free(start, size);
 		return err;
 	}
 
-	p += strlen(p);
-
-	return *p == '\0' ? 0: -EINVAL;
+	return 0;
 }
 __setup("reserve_mem=", reserve_mem);
 
