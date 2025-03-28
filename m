Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F51E835F;
	Fri, 28 Mar 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199709; cv=none; b=qT4vjv0GYUWvRRuzbADlR8+Tt66Gv4dtfv162CXE2SfS9QGUYpGjGL9im8Cv1xSoOXU/MajxvnCgqjt83HiGHVmrFNI3mK1wMD05QU8MiooKqq1EKvnEIycIbDO4t6bA5/So7zizZuZmlm6fASr9Ngu1FJaumAyw66ujo9nCIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199709; c=relaxed/simple;
	bh=KVt4VN7lxhBm2C7oVfmeJ9VEn+73nB8GuOHnILWzfxw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=iDyqP6M1rtXATJ99DePg47baZ/Vf2A1VzVfito5225APWSM6t4pVu/krbMpQKqUuyZ3ae8160iND1OGZguFFLplyIoetj5UXdnAc2l43I6+5ANpp6EPpK0v+JezFNUPFjjqvDFtmyqjc8rhgvfer1vvrnMNKA0rM/RVEUP5HLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18230C4CEEA;
	Fri, 28 Mar 2025 22:08:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tyHtB-000000044Bn-1C3P;
	Fri, 28 Mar 2025 18:09:21 -0400
Message-ID: <20250328220836.812222422@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 28 Mar 2025 18:08:36 -0400
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
Subject: [PATCH 0/2] ring-buffer: Allow persistent memory to be user space mmapped
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Linus,

This is an update to the code that we discussed in making the persistent
ring buffer work with user space memory mapping. I based it on top of
the second version of the pull request I just sent out.

Note, I'm not suggesting this is to go into this merge window. I'm
happy to wait until the next window.

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
what the code is doing. By doing this, I also discovered that that "hack" 
you did not like was not needed for the meta page. There's two meta pages
here. One is mapped between the kernel and user space and is used to inform
user space of updates to the ring buffer. The other is inside the persistent
memory that is used to pass information across boots. The persistent memory
meta data is never exposed to user space. The meta data for user space
mapping is always allocated via the normal memory allocation.

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

I personally feel this version of the code is much cleaner and with the
helper functions, much easier to follow. As doing this exercise found that
the test against virt_addr_valid() wasn't needed in every location
(which is no longer used here).

Steven Rostedt (2):
      tracing: ring-buffer: Have the ring buffer code do the vmap of physical memory
      ring-buffer: Allow persistent ring buffers to be mmapped

----
 include/linux/ring_buffer.h |  19 ++---
 kernel/trace/ring_buffer.c  | 180 +++++++++++++++++++++++++++++++++++++++-----
 kernel/trace/trace.c        |  65 ++++------------
 3 files changed, 186 insertions(+), 78 deletions(-)
