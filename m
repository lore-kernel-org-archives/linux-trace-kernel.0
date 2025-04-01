Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8391C863F;
	Tue,  1 Apr 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548260; cv=none; b=UD5U5hwocgD+3DdXJ+usrtryGJzJx2iZmCOwuaXfwZKCoG5c/e46Ml5l0BbcOBCzBpjXACQJ7YU21reaRitcsye6Wi7R0j9ni5f8G8L7ohb+vfn1nIzgRdhTzUnvl4MKLbVTjvHv3+6LhCn0HtuRahcVs8m3pv+cLUc3DkOdPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548260; c=relaxed/simple;
	bh=UyI/JP302xZqnGAVZ+H9RXsetFumokBsiWm5U/n9qhU=;
	h=Message-ID:Date:From:To:Cc:Subject; b=pXReRjEIgNV5a7e2NkvvzR8sINkKcgQR9ceM+1hwEoxetW6JUyk4HHzNOdZ8aa8f1CgO24UJxsL7EVhGQQ8hOTKgg8bJrmFswlbrxJmfP/pV3FwU4jM3iWT/32339I368u03H41oOrN2kTHG8sxu3XSzxAPpdf2Vrb7LXfF02RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6300DC4CEE8;
	Tue,  1 Apr 2025 22:57:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzkZ8-00000006KYG-0yQW;
	Tue, 01 Apr 2025 18:58:42 -0400
Message-ID: <20250401225811.008143218@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 18:58:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: [PATCH v5 0/4] tracing: Clean up persistent ring buffer code
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Now that I learned that the memory passed back from reserve_mem is part
of the memory allocator and just "reserved" and the memory is already
virtually mapped, it can simply use phys_to_virt() on the physical memory
that is returned to get the virtual mapping for that memory!
  (Thanks Mike!)

That makes things much easier, especially since it means that the memory
returned by reserve_mem is no different than the memory retrieved by
page_alloc(). This allows that memory to be memory mapped to user space
no differently than it is mapped by the normal buffer.

This new series does the following:

- Enforce the memory mapping is page aligned (both the address and the
  size). If not, it errors out.

- Use phys_to_virt() to get to the virtual memory from the reserve_mem
  returned addresses. As the memory is already freed via
  reserve_mem_release_by_name() and it's not mapped by vmap() anymore,
  the free ring buffer code doesn't need to do anything special for
  this mapping.

- Treat the buffer allocated via memmap differently. It still needs to
  be virtually mapped (cannot use phys_to_virt) and it must not be
  freed nor memory mapped to user space. A new flag is added when a buffer
  is created this way to prevent it from ever being memory mapped to user
  space and the ref count is upped so that it can never be freed.

- Use vmap_page_range() instead of using kmalloc_array() to create an array
  of struct pages for vmap().

- Use flush_kernel_vmap_range() instead of flush_dcache_folio()

Changes since v4: https://lore.kernel.org/linux-trace-kernel/20250401215115.602501043@goodmis.org/

- Fixed calling free_reserve_area() twice on the same memory


Steven Rostedt (4):
      tracing: Enforce the persistent ring buffer to be page aligned
      tracing: Have reserve_mem use phys_to_virt() and separate from memmap buffer
      tracing: Use vmap_page_range() to map memmap ring buffer
      ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()

----
 Documentation/admin-guide/kernel-parameters.txt |  2 +
 Documentation/trace/debugging.rst               |  2 +
 kernel/trace/ring_buffer.c                      |  5 +-
 kernel/trace/trace.c                            | 68 ++++++++++++++++---------
 kernel/trace/trace.h                            |  1 +
 5 files changed, 52 insertions(+), 26 deletions(-)
