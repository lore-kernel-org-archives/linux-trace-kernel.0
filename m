Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41A195B11;
	Thu,  6 Jun 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686192; cv=none; b=il03mLvGyoyKhH83sIfl8LUVtIXqG4f7XG1A+yl5TBB6ksQpCPY8QC8of+3oWl+UIfgzMsiYQQfcGhOFJgOMILL3LW02+6Nh5fzQhah/ofAEOqRFoDzC/KhvARE4qnNq4rSuhaffLj3qgSlxK+okDktimom5MVes+OITmdSW+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686192; c=relaxed/simple;
	bh=Q2LqmW2aRbh6XJaCkkMR6/aMEOHTutoVQmaZuLn/uuM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mIIl/hA46YjaMMQjPjaMvyV/ml6bR2gY2KcNqr0QMZObssB5+Z8pKtzYAfCs9MaFHSbPLTlNsEOsMYJihNgBJiMwoKdaMOBwLwzFD1UoTfg8W6s0YiU/iehnmkXmInaJT4JPkxwi5EZzJ5OxzlXeKgUHQWQGfUzNxXW5yopdxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF5AC2BD10;
	Thu,  6 Jun 2024 15:03:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFEe4-00000000oQl-3217;
	Thu, 06 Jun 2024 11:03:16 -0400
Message-ID: <20240606150143.876469296@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 11:01:43 -0400
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
 Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/2] mm/memblock: Add "reserve_mem" to reserved named  memory at boot up
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

Changes since the v1: https://lore.kernel.org/all/20240603233330.801075898@goodmis.org/

- Updated the change log of the first patch as well as added an entry
  into kernel-parameters.txt about how reserve_mem is for soft reboots
  and may not be reliable. 


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
reserve-mem

Head SHA1: 94c7d2d9093e9a7a899215c65adf28180d44a247


Steven Rostedt (Google) (2):
      mm/memblock: Add "reserve_mem" to reserved named memory at boot up
      pstore/ramoops: Add ramoops.mem_name= command line option

----
 Documentation/admin-guide/kernel-parameters.txt | 20 +++++
 fs/pstore/ram.c                                 | 15 ++++
 include/linux/mm.h                              |  2 +
 mm/memblock.c                                   | 97 +++++++++++++++++++++++++
 4 files changed, 134 insertions(+)
