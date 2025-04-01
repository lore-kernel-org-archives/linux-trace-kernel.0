Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F104C85;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539550; cv=none; b=J8DftLjIijkg5o+urtXYpy5CkB2whAv3xQ6ykvIWIjbOilTb+KChGGWR2imXqbuwq0Qx8ejs5QNDkChoJGVo98xTkopTJF6vCcCz5hqX6RlBKR9QsHCYIZm+ko79jRsq505l6KEED8/Bpi6ub5mLXJSF6yocaXLG9JSsJcSere8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539550; c=relaxed/simple;
	bh=rEmdcZLXYxDN2vfbOB7BVcj2LM4H14D/E3gVEVWZP94=;
	h=Message-ID:Date:From:To:Cc:Subject; b=mNh1Vx6C9tDfhJCVrxtpNxvtD8Z8MpgRQdSDIYgBShPyUWL+QUWV/qH591X6RyNVUW1EyILOBqlX93fNmRgysYxoqXQfBOOz8CG+h6hqEv0kflOBari4pUBlgZwutKrJGithVE+nF8DQgXFK+Tgglvzas77kaV6P/tW/1lR+fFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ABFC4CEE8;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tziId-00000006Ico-2DnA;
	Tue, 01 Apr 2025 16:33:31 -0400
Message-ID: <20250401202549.409271454@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 16:25:49 -0400
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
Subject: [PATCH v3 0/5] ring-buffer: Allow persistent memory to be user space mmapped
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

- Allow the reserve_mem persistent ring buffer to be memory mapped.
  There is no difference now with how the memory is mapped to user space,
  only the accounting of what pages are mapped where is updated as
  the meta data is different between the two.

Note, the first 4 patches makes the code a bit more correct. Especially
since the vunmap() does not give the buffer back to the buddy allocator.
I will be looking to get the first 4 patches into this merge window.

The last patch which enables he persistent memory mapping to user space can
wait till the 6.16.

Changes since v2: https://lore.kernel.org/all/20250331143426.947281958@goodmis.org/

- Basically a full rewrite once I found out that you can get the virtual
  address of the memory returned by reserve_mem via phys_to_virt()!

Steven Rostedt (5):
      tracing: Enforce the persistent ring buffer to be page aligned
      tracing: Have reserve_mem use phys_to_virt() and separate from memmap buffer
      tracing: Use vmap_page_range() to map memmap ring buffer
      ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()
      ring-buffer: Allow reserve_mem persistent ring buffers to be mmapped

----
 Documentation/admin-guide/kernel-parameters.txt |  2 +
 Documentation/trace/debugging.rst               |  2 +
 kernel/trace/ring_buffer.c                      | 54 ++++++++++++++++--
 kernel/trace/trace.c                            | 75 ++++++++++++++++---------
 kernel/trace/trace.h                            |  1 +
 5 files changed, 102 insertions(+), 32 deletions(-)
