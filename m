Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD521B9FD;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431674; cv=none; b=ZFrdNkF4e9RglB2dSejEDwylqbCVMzFHthk7ElzhLeYWHtNXcYKAs3c9e8bRO5CWD7OC+VThcKNyKiTPQ72f5zuF4d9h84+J0CBUZ6GBAx/EuWIKSjeMjxMW29D2iT964mkw/5Qhwe1oLyjt5z+ufRV5DGrHE0GCnpQtyMd7O0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431674; c=relaxed/simple;
	bh=UJFg1dao4GQMCub2MUS4ClAwY2RgA/iCJuXqVOviieY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Z4tahidy7p/xejeg1N0ZCjA82/9ynUfcjUZjLPGjRqaAkO6io1qoYYg9Gdeg5DQRoMyV0xkT0xYkZf4u0ogBvSXv13/IttvgMleJWUPCe0ANa+qC59d3ZHCPnvP1JRf4H4E6jS7HkCLXzAvj01yOQ35xP5va56Ej0sN6nRlybDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E36C4CEE3;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzGEe-00000005pAG-1o8S;
	Mon, 31 Mar 2025 10:35:32 -0400
Message-ID: <20250331143426.947281958@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 31 Mar 2025 10:34:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/2] ring-buffer: Allow persistent memory to be user space mmapped
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Allow the persistent memory mapped memory to be memory mapped to user
space as well. Currently, the user space memory mapping requires the
buffers to have been allocated via page_alloc() and converted to virtual
address via page_address(). But the persistent memory is memory mapped
via vmap() and a simple virt_to_page() can not be used. Move the control
of the physical mapping via vmap() to the ring buffer code so that it
can then use the saved physical and virtual mapping to find the pages
needed for memory mapping user space.

The first patch moves the memory mapping of the physical memory returned
by reserve_mem from the tracing code to the ring buffer code. This makes
sense as this gives more control over to the ring buffer in knowing exactly
how the pages were created. It keeps track of where the physical memory
that was mapped and also handles the freeing of this memory (removing the
burden from the tracing code from having to do this). It also handles
knowing if the buffer may be memory mapped or not. The check is removed
from the tracing code, but if the tracing code tries to memory map the
persistent ring buffer, the call to the ring buffer code will fail with
the same error as before.

The second patch implements the user space memory mapping of the persistent
ring buffer. It does so by adding several helper functions to annotate
what the code is doing. Note, there's two meta pages here. One is mapped
between the kernel and user space and is used to inform user space of updates
to the ring buffer. The other is inside the persistent memory that is used to
pass information across boots. The persistent memory meta data is never exposed
to user space. The meta data for user space mapping is always allocated via the
normal memory allocation.

The helper functions are:

 rb_struct_page() - This is the rb_get_page() from our discussions, but
                    I renamed it because "get" implies "put".
                    This function will return the struct page for a given
                    buffer page by either virt_to_page() if the page was
                    allocated via the normal memory allocator, or it
                    is found via pfn_to_page() by using the saved physical
                    and virtual address of the mapped location. It uses
                    that to calculate the physical address from the virtual
                    address of the page and then pfn_to_page() can be used
                    from that.

  rb_fush_buffer_page() - this calls the above rb_struct_page() and then
                    calls flush_dcache_folio() to make sure the kernel
                    and user space is coherent.

  rb_flush_meta() - This just uses virt_to_page() and calls flush_dcache_folio()
                    as it is always allocated by the normal memory allocator.
                    I created it just to be consistent.

  rb_page_id() - The mappings require knowing where they are mapped.
                 As the normal allocated pages are done in a way that they
                 may exist anywhere from the kernel's point of view, they
                 need to be labelled to know where they are mapped in user
                 space. The bpage->id is used for this. But for the persistent
                 memory, that bpage->id is already used for knowing the order
                 of the pages that are still active in the write part of
                 the buffer. This means that they are not consecutive. For
                 the user space mapping, the index of where the pages exist
                 in the physical memory is used for the placement in user
                 space. In order to manage this difference between how the
                 ids are used, this helper function handles that.

These helper functions make the code obvious to what is being mapped
and how they are mapped.

Changes since v1: https://lore.kernel.org/all/20250328220836.812222422@goodmis.org/

- Changed map_pages counters page_count and i to unsigned long

  In case someone uses over 4 billion pages on a 64 bit machine to map
  the memory, have the counters be unsigned long and unsigned int.
  The way machine memory is growing, this may just happen in the near future!


Steven Rostedt (2):
      tracing: ring-buffer: Have the ring buffer code do the vmap of physical memory
      ring-buffer: Allow persistent ring buffers to be mmapped

----
 include/linux/ring_buffer.h |  19 ++---
 kernel/trace/ring_buffer.c  | 180 +++++++++++++++++++++++++++++++++++++++-----
 kernel/trace/trace.c        |  65 ++++------------
 3 files changed, 186 insertions(+), 78 deletions(-)
