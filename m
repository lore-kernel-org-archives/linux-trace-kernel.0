Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3511C3C1F;
	Sun,  8 Feb 2026 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575891; cv=none; b=jWMts1OP1nWZfdrWxpG+WenQtNFGM5dH9/IHGdrrg/NFm2MhRghUS8gESay7fSh3ACVaGfDBPk6Nxf8mrdk9MkiWulu+6FrzZdSqhvickMygOJyHx/a1Gc7lHIHXijYjaJpSl/TSuqaaen1KHbmfjV6y380MAQG7l/wwg2SmjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575891; c=relaxed/simple;
	bh=8CMYXyklR8g1Qr5A+wdIudfFlbo1J+mBP8ZYhRLihYg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Rshk1u9enZyTHlJf0m1LetFg/vlCgpq860HKCaBehKWlPeIt/Y6uzFVaA9mI0A/JLErOcNbOy3Ov0NAhp1ICI5cAJBW5r6Ssq9vR58z1Igj+/IDGNKt8AkK/4hKvCooilRR6JaM/W5iuxdQzMnKaIsQF+cj577HGJ2MyJUI3pUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl1pwtx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl1pwtx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38726C19421;
	Sun,  8 Feb 2026 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770575891;
	bh=8CMYXyklR8g1Qr5A+wdIudfFlbo1J+mBP8ZYhRLihYg=;
	h=Date:From:To:Cc:Subject:From;
	b=Rl1pwtx+oSMDOai7LkdYJNGozmWdvRstfO6Y/eGggu8R6HQmKsrh0/9PZ58NfGQI/
	 D46YvMw7O9l61suLBGPEIwhaixo1q6I6oWjpUg6nCq1q/PBbzggkbudzg6B+O/p4hA
	 mJE8K7mEDqRbGZPQAVJHKkgp7N1RHVj58VqbdRdb1zvh/6fBouROT6LTtzVcK0ztEo
	 4H5oYRspDDugvY0xKVcawG5fMeXEgA+yjqTduCv6AUjMR0SaYYENOI4iJaW7uu/eXn
	 UGwA3mPv3h6iiE12fLa2ytqwlYa5Tlqu5eK7DQiHDauCsO/gSNhw4Yd8jFY9+Qw23h
	 ahR4OyW4+gV1g==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vp9gO-0000000AVMg-1gFa;
	Sun, 08 Feb 2026 13:38:56 -0500
Message-ID: <20260208183832.118080581@kernel.org>
User-Agent: quilt/0.68
Date: Sun, 08 Feb 2026 13:38:32 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/3] tracing: Clean up the snapshot and max tracer code
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

When tracing first was added it had latency tracers that used a separate
snapshot buffer to swap the current buffer being written to with a static
buffer that is only read. This later became a feature that user space could
use by attaching to the latency tracer snapshot buffer. But the buffer was
named max_buffer which is not what it is used for in all cases.

Rename the max_buffer name to snapshot_buffer.

The "use_max_tr" field of the tracer structure is only defined when
CONFIG_TRACER_MAX_TRACE is defined. To get rid of some of the #ifdefs in the
code around accesses of that field, use a helper function
tracer_uses_snapshot() that access the field when the config is defined, or
returns false if not.

Finally, since the latency tracers use the snapshot buffer and snapshot
buffers do not need latency tracers, have the TRACER_MAX_TRACE config select
TRACE_SNAPSHOT config and not the other way around. Also clean up the code
to properly protect the max tracer references and the snapshot references.

Changes since v2: https://lore.kernel.org/all/20260208040156.005531619@kernel.org/

- Fix tracing_set_tracer() when CONFIG_TRACER_SNAPSHOT is not enabled.
  Seems that some fields that are only available with that config were
  still exposed, and the local variable used was still hidden.
  (kernel test robot)

- Fix trace_create_maxlat_file() declaration when CONFIG_TRACER_SNAPSHOT
  is not defined.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20260206193741.767171392@kernel.org/

- This separates the updates to snapshot buffer and max tracers from
  the last series. It was a rewrite.

Steven Rostedt (3):
      tracing: Rename trace_array field max_buffer to snapshot_buffer
      tracing: Add tracer_uses_snapshot() helper to remove #ifdefs
      tracing: Better separate SNAPSHOT and MAX_TRACE options

----
 kernel/trace/Kconfig          |   8 +-
 kernel/trace/trace.c          | 192 +++++++++++++++++++-----------------------
 kernel/trace/trace.h          |  44 +++++++---
 kernel/trace/trace_selftest.c |  10 +--
 4 files changed, 127 insertions(+), 127 deletions(-)
