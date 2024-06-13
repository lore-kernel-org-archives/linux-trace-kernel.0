Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460314D6FB;
	Thu, 13 Jun 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321665; cv=none; b=drdQlMH9LvkIkL8iWB1s8WtcKiqdo3vwDonw+KzQb1wivUFdCf4trHuwnAIEsIfi9fAgjMppkjYcldLd7SoTZN8oGjJy5Hr4GfzdK0fH3AVvN7YVr6RzWDXIa3HJSQtLBHkYkJ+V624wjDsPs/gc5lsO8yLjKHYaJDpZNmlPcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321665; c=relaxed/simple;
	bh=zi+QiPlY4W2TaesV1AIQgrf3hq4puQ7YAO+tN75xudg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=PZWsSCRGBEZAht6qzTFerfoi2BcPUMNn6B0wZEGHWSRd1egMyFkK8oRgPe5Ho6qBwOTlcSD0gUKPGolBQiVGh9KBc1o+tigE7aD2+0q8xC9Hd7kZUI2aS3f5LIMNR6IZmiOAoSo80AIQTWpd45P22Do9sTmNwxn9iT1SS+JOt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB16BC4AF1C;
	Thu, 13 Jun 2024 23:34:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHtxu-00000001m4X-0POz;
	Thu, 13 Jun 2024 19:34:46 -0400
Message-ID: <20240613233415.734483785@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 13 Jun 2024 19:34:15 -0400
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
Subject: [PATCH v7 0/2] mm/memblock: Add "reserve_mem" to reserved named  memory at boot up
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

Changes since v6: https://lore.kernel.org/all/20240613155506.811013916@goodmis.org/

- Fixed typo of s/reserver/reserve/

Changes since v5: https://lore.kernel.org/all/20240613003435.401549779@goodmis.org/


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
