Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60933CEBF;
	Wed, 18 Feb 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409655; cv=none; b=KRxh2Y0L/QHUBsnQ6pxRwUmmTlw0zwtwEgMvjiiRvJRtHvXKfFI1pVCSlviIZeGK4emIusLkBgUVooNnSaIvWNm54HxJnpIglLI/JpuNlR3PwGh69sOYR5UmJYrFYzZvezacTrgsQsh3CK41VVzw1G/P6pNwz5nMm6/M1sFnAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409655; c=relaxed/simple;
	bh=zZEzVg2AtdyiMFiqlLwPqN7ZMlKIiTAfXMddKDPE2u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpXu/kcDB1CNDNLAFOIHxIZLmauz/qwlJdEZKQcKTFu4896ziGCwxwWzDi+HgR7RuWLwSJsrkBJSc+RRTYdJ63IeEsCKL6juNiASHJMlKj1A+5s7cRaB/ki3lCTEuaPGNNgHLW64vZRPWOySRqnnZFF9Ry+E0/YIC2Ww//qVf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7+bQfBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7+bQfBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C169C19421;
	Wed, 18 Feb 2026 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409655;
	bh=zZEzVg2AtdyiMFiqlLwPqN7ZMlKIiTAfXMddKDPE2u4=;
	h=From:To:Cc:Subject:Date:From;
	b=Q7+bQfBxAxZ7OY7XEUhP2zOoynInVmldSzf3IfieCJ0/LGpj78ewK7da+lAltf4jQ
	 Y5SjQrVEEnIEbdwWO7KYrPYGTnkFr8h3U1htWbmCYqp2Jp7n3XYgb6ohfPsA8bWsaP
	 n/o9EUh7ZI7tYIVS99zhwnvRThfecFx4wYXWLlCieHBmmvKhw3XqErwRAgm0ykvfOI
	 /3rQvOYU7jFXHd2wPnmxsf0+rLX/K+OY+GbX7H654Zs/i2AWonedhWnl4j3wtrCwnp
	 TyvE6XCQUh7DZXGkQyxkOlxQCpIPMjdXMsy7AGznbEGkGDEQF526LMzjuFptyZcopd
	 GOaLi5eNRbLZA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ring-buffer: Making persistent ring buffers robust
Date: Wed, 18 Feb 2026 19:14:10 +0900
Message-ID:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is a series of improvement patches for making persistent
ring buffers robust to failures. This fixes some issues of
persistent ring buffer on real machines.
We naively assumed that event data stored in a persistent ring
buffer would be preserved across reboots. However, event data
is written on the hardware cache and is not flushed on reboot.
As a result, the data on the ring buffer will be partially
corrupted, which will be detected during startup validation
and all ring buffer data will be erased. (I have actually
observed this on an actual arm64 machine.)

To fix these issues, this series introduces following patches;

- [1/4] Fix to check event length before using it, because
  if event data is partially saved, the data length will be
  completely wrong and the rb_read_data_buffer() will access
  invalid address (which crashes kernel at boot).

- [2/4] Flush and stop persistent ring buffer on panic.
  For the kernel panic case, we can use callback to stop event
  recording and flush hardware cache for the persistent memory.
  This ensures that the ring buffer data is written to memory
  in the event of a panic.

- [3/4] Skip invalid sub-buffers when validating persistent
  ring buffer. Instead of invalidating whole CPU buffer,
  invalidate only corrupted sub buffer.

- [4/4] Record invalid buffer event on invalidated buffer for
  notifying users which sub-buffer was corrupted.

[3/4] and [4/4] could be combined, but I have separated them
for ease of review.

Thank you,

---

Masami Hiramatsu (Google) (4):
      ring-buffer: Fix to check event length before using
      ring-buffer: Flush and stop persistent ring buffer on panic
      ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
      ring-buffer: Record invalid buffer event


 kernel/trace/ring_buffer.c   |   84 ++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.h         |    1 +
 kernel/trace/trace_entries.h |   15 ++++++++
 3 files changed, 87 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
