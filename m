Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667C8C09;
	Thu, 13 Jun 2024 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238893; cv=none; b=qpUSPYzeYxme72usGv0cj/NZJ9yNEB1lJ8TDjMop0Zy1fBYgP5fx5vz8MJ7H7IlgYVwEhg/6aU2WzcFKRsfAzpPWK96tnWOI0+hvO++uhVn5NG25KFCLeJWNXtbdEicnM4vpvj+8WPMWr4aTruA8dL3eG8YiwhAPtrHkxd400Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238893; c=relaxed/simple;
	bh=sm99DwASeQO1ECKvTnDxPmJJ6qHTDXWNprQagI7uP4s=;
	h=Message-ID:Date:From:To:Cc:Subject; b=QAHnADwHgXmG+rGGaFmNuYMetRsO3nrBtMZFP98lLsgwxy5G4LGqInD7Xg9r2XFgvXpJLW8UdLZMP7U/Nu7kXdNEa2sATvmLZ9LKMFNalA9oj65TtC6Apm01LBQELrYOYGTaGg+WWOs+PR0kX1xsWnkzZ0q8QWyPq7ZfZc+igxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C3DC116B1;
	Thu, 13 Jun 2024 00:34:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHYQm-00000001eMY-32F3;
	Wed, 12 Jun 2024 20:35:08 -0400
Message-ID: <20240613003435.401549779@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 20:34:35 -0400
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
Subject: [PATCH v5 0/2] mm/memblock: Add "reserve_mem" to reserved named  memory at boot up
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

Changes since v4: https://lore.kernel.org/all/20240611215610.548854415@goodmis.org/

[ patch at bottom showing differences ]

- Add all checks about reserve_mem before allocation.
  This means reserved_mem_add() is now a void function.

- Check for name duplications.

- Fix compare of align to SMP_CACHE_BYTES ("<" instead of "<=")

Changes since v3: https://lore.kernel.org/all/20240611144911.327227285@goodmis.org/

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

----
 Documentation/admin-guide/kernel-parameters.txt |  20 ++++
 fs/pstore/ram.c                                 |  14 +++
 include/linux/mm.h                              |   2 +
 mm/memblock.c                                   | 117 ++++++++++++++++++++++++
 4 files changed, 153 insertions(+)


diff --git a/mm/memblock.c b/mm/memblock.c
index 044ddce8f085..739d106a9165 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2256,22 +2256,15 @@ static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
 static int reserved_mem_count;
 
 /* Add wildcard region with a lookup name */
-static int __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
+static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
 				   const char *name)
 {
 	struct reserve_mem_table *map;
 
-	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
-		return -EINVAL;
-
-	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
-		return -1;
-
 	map = &reserved_mem_table[reserved_mem_count++];
 	map->start = start;
 	map->size = size;
 	strscpy(map->name, name);
-	return 0;
 }
 
 /**
@@ -2280,6 +2273,8 @@ static int __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
  * @start: If found, holds the start address
  * @size: If found, holds the size of the address.
  *
+ * @start and @size are only updated if @name is found.
+ *
  * Returns: 1 if found or 0 if not found.
  */
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
@@ -2309,11 +2304,15 @@ static int __init reserve_mem(char *p)
 	phys_addr_t start, size, align;
 	char *name;
 	char *oldp;
-	int err;
+	int len;
 
 	if (!p)
 		return -EINVAL;
 
+	/* Check if there's room for more reserved memory */
+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
+		return -EBUSY;
+
 	oldp = p;
 	size = memparse(p, &p);
 	if (!size || p == oldp)
@@ -2330,11 +2329,14 @@ static int __init reserve_mem(char *p)
 	 * memblock_phys_alloc() doesn't like a zero size align,
 	 * but it is OK for this command to have it.
 	 */
-	if (align <= SMP_CACHE_BYTES)
+	if (align < SMP_CACHE_BYTES)
 		align = SMP_CACHE_BYTES;
 
 	name = p + 1;
-	if (!strlen(name))
+	len = strlen(name);
+
+	/* name needs to have length but not too big */
+	if (!len || len >= RESERVE_MEM_NAME_SIZE)
 		return -EINVAL;
 
 	/* Make sure that name has text */
@@ -2345,15 +2347,15 @@ static int __init reserve_mem(char *p)
 	if (!*p)
 		return -EINVAL;
 
+	/* Make sure the name is not already used (size is only updated if found) */
+	if (reserve_mem_find_by_name(name, &start, &size))
+		return -EBUSY;
+
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
 
-	err = reserved_mem_add(start, size, name);
-	if (err) {
-		memblock_phys_free(start, size);
-		return err;
-	}
+	reserved_mem_add(start, size, name);
 
 	return 0;
 }
