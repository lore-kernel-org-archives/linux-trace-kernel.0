Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B9BA4A;
	Wed,  2 Apr 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605330; cv=none; b=rKyxt62UOZ9FAvSK/sDwORp/KQKu5hFme2CNXEBz2CnnQiOifkPFBXMmKTFC5+uPDT5wCi7vHNCRKNhG8E5N2+xWOYegq3IxYF1hLubi4iMajKnWkEI+CuzeC7QQe57BoZmiX83IY/o7YU2FORMyUH/F5jbFLkVlGFiSwpRZJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605330; c=relaxed/simple;
	bh=U9px5UVHXb1f3k98piSHjIih9jGckO0HeXhXWRcHwn0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=umBfVbyD6k9dyoUc2kRObyiiw+IZHwmu2GxNxuLEvXkv0i3DClwae8A7evNINM5GAY+/dZlMEaKyx9QXXDsCp7Kyr3uxSZykNaqKd2yZ+36UFxImk+1Y5dzdKuoI0OW1w3zuL7rJMDWuolfshcgQ2NbkQrPGqd+Sl2luSe97sK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FF2C4CEE9;
	Wed,  2 Apr 2025 14:48:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tzzPd-00000006SNe-1bFR;
	Wed, 02 Apr 2025 10:49:53 -0400
Message-ID: <20250402144903.993276623@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 02 Apr 2025 10:49:03 -0400
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
Subject: [PATCH v6 0/4] tracing: Clean up persistent ring buffer code
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

Changes since v5: https://lore.kernel.org/linux-trace-kernel/20250401225811.008143218@goodmis.org/

- Use %pa instead of %lx for start and size sizes (Mike Rapoport)

- Updated change log to use memblock_alloc() instead of memblock_reserve()
  (Mike Rapoport)

Steven Rostedt (4):
      tracing: Enforce the persistent ring buffer to be page aligned
      tracing: Have reserve_mem use phys_to_virt() and separate from memmap buffer
      tracing: Use vmap_page_range() to map memmap ring buffer
      ring-buffer: Use flush_kernel_vmap_range() over flush_dcache_folio()

----
 Documentation/admin-guide/kernel-parameters.txt |  2 +
 Documentation/trace/debugging.rst               |  2 +
 kernel/trace/ring_buffer.c                      |  5 +-
 kernel/trace/trace.c                            | 66 ++++++++++++++++---------
 kernel/trace/trace.h                            |  1 +
 5 files changed, 50 insertions(+), 26 deletions(-)
