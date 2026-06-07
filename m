Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4A2F5328;
	Sun,  7 Jun 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817409; cv=none; b=YDqd79DNER5M07f2mK2nXZjIFEcQvX82Yla+c7uAU83rcpDUeVfOeb+44ygl39G1jVBWYFJ9kbwXtITrINV5UHca1vVgJjlXfhKJEQCOD6WH2khBMzw4JQuFfaVsKE0oBtFiqccn5kdNFIZB6ftcbBLLlvCUR3droEXJl7fWoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817409; c=relaxed/simple;
	bh=RkQF8lRbTFbKoWVeRbYJJtgDjACBKW9f4O6+Zj+KJwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRx0rAFsf9FvfXE5wibVWnSdGSciD/G+YnwFwbch9dRaTR10mEa1tdSRIZqmrPNJJEGh0ioL91MCwTNxZ5bXv/UtRtjUndpTkzHcZMXq19E2xtVvIBA8aH7Ohv8Y8rWMJYz8sZFkn3Fq/ozGf4x42eLUbFcBO+rQfST5jnfp22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=it4IPQRc; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="it4IPQRc"
Received: from hwang4-g16.. (unknown [120.244.199.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B19673F861;
	Sun,  7 Jun 2026 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1780817078;
	bh=ddikXD3l8TYjtFnVsxE8N0l73vEnH4C/n+VO9I+q5cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=it4IPQRcsCT6KdGN18nITlblRVKq6EImDBlDcwQfsVzruEcHYiZZbIUVDfEt+Zvmk
	 weaS4ACzupm8r7FQ4Vz3kBbykmjsAcpXE2WhXmswJ2ncxisekb+hLYdHWZdQdNR4Qf
	 vN3T9GZh2cSkKAvyD5qbp5F+ow5bko3JMUtCO+b6y1db/lUAPXlFTU1xKjeEKcU9gG
	 8Hog3tPexSt/hMZFTcwwhFCv8IQod+nKjaTaGtMPuq2kuEL1i34XtBTXUcGO+mz0//
	 v8rDGad+zSYE4gd5/aTuefMN0mlZL2CGiwsfQNvOU25o0drAUhdR2f1fnjiRyfogRf
	 J90Aau6gFU5Tcwe7W5fo8GOPjFTv0qWg7/200YDLh9QAbsCDkX5PBmYixJ9i/94rIr
	 8u1DFBcTCae2Oy+QRAJGS4nBF1I5jO6R3Z/r5Rwv5YaNfDSl4SzZCwl9AigVoyF4Ji
	 yBQKKoiHeatjp/X8g+o2aHIPfy6JDr6kAuXnr6T4h0O9Q0IpPsCt1hvd0CAl7GwRhL
	 Re8xSkb5++ycp7BOR6CuYy4FAUUVfm6JrLNiNv0QFFDBmReaWaCd4n8OGMl0yYsUlp
	 0SIDTSE7M5FpSnYNM99qI4kvIi2lojlqjcVS/5fh/ZeLSXNir9i0rEM1B10W3kb092
	 dmqJhvlHXb2Go2k7qhza7VoM=
From: Hui Wang <hui.wang@canonical.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	pjw@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	shuah@kernel.org,
	wangfushuai@baidu.com,
	linux-kselftest@vger.kernel.org
Cc: hui.wang@canonical.com
Subject: [PATCH 0/2] ring-buffer: Fix forced 8-byte alignment event length
Date: Sun,  7 Jun 2026 15:24:29 +0800
Message-ID: <20260607072431.125633-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the event length reported by ring_buffer_event_length()
when RB_FORCE_8BYTE_ALIGNMENT is enabled, and updates the ftrace
trace_marker_raw selftest to account for that layout.

On architectures where CONFIG_HAVE_64BIT_ALIGNED_ACCESS is enabled, the
ring buffer forces 8-byte alignment. In that mode, the event length is
stored in event->array[0] even for small data events, and the payload
starts from event->array[1]. However, ring_buffer_event_length() only
subtracted the extra length field for large events. As a result, small
events reported a payload length 4 bytes larger than expected.

This was observed on riscv64 with CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
when running the ftrace trace_marker_raw.tc selftest. The first patch
fixes the ring-buffer length calculation. The second patch updates the
selftest expectation when the running kernel uses forced 8-byte
alignment.

Hui Wang (2):
  ring-buffer: Fix event length with forced 8-byte alignment
  selftests/ftrace: Account for 8-byte aligned trace_marker_raw events

 kernel/trace/ring_buffer.c                    |  3 +-
 .../ftrace/test.d/00basic/trace_marker_raw.tc | 16 +++++++--
 .../testing/selftests/ftrace/test.d/functions | 33 +++++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.43.0

