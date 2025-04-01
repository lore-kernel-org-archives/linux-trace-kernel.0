Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC141E5B93;
	Tue,  1 Apr 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743544352; cv=none; b=tFaNxF/QI+yf3utwwu3lpWbeFXNsbNxzKMtZonech6jX7VpO/s24gYRFaskzL1Mwusp4Gg0ewJvTanKSpRL0pDZDLcypDXNfUnkdKhLeVRER79Hq22OAkonHmzxWwg04mrarjhZnU5EAPGDFXgVMNraZdIFDU34SmiQ2VqDGgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743544352; c=relaxed/simple;
	bh=zTiEvmWuhZML2k/GukJVWo/rVOq+9i7uiMMvaK10dMo=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cgUlM0mcP598L6odDOOtRIG6Qk0HGFbI5ELMrEmFYlSOE0PMGuGi7XYT9CzT9euJzVUYRcBDeWltRdLqVNpkG9wInFaln4bvGZhy3leDGiavd0KfCajD37jhz8xn+LbgDUa266uyj2rzxhhbEzOYRsLk5JfmuK6mamrv4wV0qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8374CC4CEE4;
	Tue,  1 Apr 2025 21:52:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzjY5-00000006Jts-0xY5;
	Tue, 01 Apr 2025 17:53:33 -0400
Message-ID: <20250401215115.602501043@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 17:51:15 -0400
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
Subject: [PATCH v4 0/4] tracing: Clean up persistent ring buffer code (was: ring-buffer: Allow persistent memory to be user space mmapped)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


[
  Note, this does not include the update to allow the persistent
  ring buffer to be memory mapped to user space. This is only the
  4 patches that I feel makes the code more correct and also
  has a bug fix.
]

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
  returned addresses. Also use free_reserved_area() to give it
  back to the buddy allocator when it is freed.

- Treat the buffer allocated via memmap differently. It still needs to
  be virtually mapped (cannot use phys_to_virt) and it must not be
  freed nor memory mapped to user space. A new flag is added when a buffer
  is created this way to prevent it from ever being memory mapped to user
  space and the ref count is upped so that it can never be freed.

- Use vmap_page_range() instead of using kmalloc_array() to create an array
  of struct pages for vmap().

- Use flush_kernel_vmap_range() instead of flush_dcache_folio()

Changes since v3: https://lore.kernel.org/linux-trace-kernel/20250401202549.409271454@goodmis.org/

- Fix whitespace in patch 3

- Updated change log of patch 4 to include bug fix comment

- Removed the patch that enables persistent ring buffer from being
  memory mapped to user space. That will be done in the next merge window.

Steven Rostedt (4):
      tracing: Enforce the persistent ring buffer to be page aligned
      tracing: Have reserve_mem use phys_to_virt() and separate from memmap buffer
      tracing: Use vmap_page_range() to map memmap ring buffer
      ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()

----
 Documentation/admin-guide/kernel-parameters.txt |  2 +
 Documentation/trace/debugging.rst               |  2 +
 kernel/trace/ring_buffer.c                      |  5 +-
 kernel/trace/trace.c                            | 73 +++++++++++++++++--------
 kernel/trace/trace.h                            |  1 +
 5 files changed, 58 insertions(+), 25 deletions(-)

