Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C212EBD7;
	Thu, 13 Jun 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294107; cv=none; b=kup602NpPnBTOm98b0+p4V25sawjWv4NbbmF/hZDg22nChpeX6Kka02+A41FgnyCHek47DD2CvEFA/u7bWov7oWFk9yA584OmhLui9bwfIiNthTunlDKxwMghMt+NL4KGuZdSD9fnlzzRAIjKoB0CpmrEQVj21HU+Zk3JWalVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294107; c=relaxed/simple;
	bh=tO7USuu1n7GU+y1fL78lddsGFdHxI0IygRmOV+2laY8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=OSgIs9u8fxzTCY8ie7JMS1BMsSIRNJbpp3kQilzdA1/5QDa+wMlgqsNZwaeazDq48pqEAxVIxMVTHCiDOoYoBoDtYw/tD3bBUDI0LTu5xZZWnmory72Ot7+bzQ5kjOrCCiodLinPiozEBQfLH9JGrmMAVX3/TACUR9mMPhDQO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C568FC2BBFC;
	Thu, 13 Jun 2024 15:55:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHmnP-00000001jmV-1iER;
	Thu, 13 Jun 2024 11:55:27 -0400
Message-ID: <20240613155506.811013916@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 13 Jun 2024 11:55:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named  memory at boot up
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

Changes since v5: https://lore.kernel.org/all/20240613003435.401549779@goodmis.org/

[ patch at bottom showing differences ]

- Stressed more that this is a best effort use case

- Updated ramoops.rst to document this new feature

- Used a new variable "tmp" to use in reserve_mem_find_by_name() instead
  of using "size" and possibly corrupting it.

Changes since v4: https://lore.kernel.org/all/20240611215610.548854415@goodmis.org/

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
 Documentation/admin-guide/kernel-parameters.txt |  22 +++++
 Documentation/admin-guide/ramoops.rst           |  13 +++
 fs/pstore/ram.c                                 |  14 +++
 include/linux/mm.h                              |   2 +
 mm/memblock.c                                   | 117 ++++++++++++++++++++++++
 5 files changed, 168 insertions(+)


diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ce7de8136f2f..56e18b1a520d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5717,9 +5717,11 @@
 			used for systems that do not wipe the RAM, and this command
 			line will try to reserve the same physical memory on
 			soft reboots. Note, it is not guaranteed to be the same
-			location. For example, if KASLR places the kernel at the
-			location of where the RAM reservation was from a previous
-			boot, the new reservation will be at a different location.
+			location. For example, if anything about the system changes
+			or if booting a different kernel. It can also fail if KASLR
+			places the kernel at the location of where the RAM reservation
+			was from a previous boot, the new reservation will be at a
+			different location.
 			Any subsystem using this feature must add a way to verify
 			that the contents of the physical memory is from a previous
 			boot, as there may be cases where the memory will not be
diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f85142182d..6f534a707b2a 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -23,6 +23,8 @@ and type of the memory area are set using three variables:
   * ``mem_size`` for the size. The memory size will be rounded down to a
     power of two.
   * ``mem_type`` to specify if the memory type (default is pgprot_writecombine).
+  * ``mem_name`` to specify a memory region defined by ``reserve_mem`` command
+    line parameter.
 
 Typically the default value of ``mem_type=0`` should be used as that sets the pstore
 mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
@@ -118,6 +120,17 @@ Setting the ramoops parameters can be done in several different manners:
 	return ret;
   }
 
+ D. Using a region of memory reserved via ``reserve_mem`` command line
+    parameter. The address and size will be defined by the ``reserve_mem``
+    parameter. Note, that ``reserve_mem`` may not always allocate memory
+    in the same location, and cannot be relied upon. Testing will need
+    to be done, and it may not work on every machine, nor every kernel.
+    Consider this a "best effort" approach. The ``reserve_mem`` option
+    takes a size, alignment and name as arguments. The name is used
+    to map the memory to a label that can be retrieved by ramoops.
+
+	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
+
 You can specify either RAM memory or peripheral devices' memory. However, when
 specifying RAM, be sure to reserve the memory by issuing memblock_reserve()
 very early in the architecture code, e.g.::
diff --git a/mm/memblock.c b/mm/memblock.c
index 739d106a9165..b7b0e8c3868d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2301,7 +2301,7 @@ EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
  */
 static int __init reserve_mem(char *p)
 {
-	phys_addr_t start, size, align;
+	phys_addr_t start, size, align, tmp;
 	char *name;
 	char *oldp;
 	int len;
@@ -2347,8 +2347,8 @@ static int __init reserve_mem(char *p)
 	if (!*p)
 		return -EINVAL;
 
-	/* Make sure the name is not already used (size is only updated if found) */
-	if (reserve_mem_find_by_name(name, &start, &size))
+	/* Make sure the name is not already used */
+	if (reserve_mem_find_by_name(name, &start, &tmp))
 		return -EBUSY;
 
 	start = memblock_phys_alloc(size, align);
