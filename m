Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48B1A6829;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214479; cv=none; b=qfx2eV+DD3iKIVvmYVLI/iZwoL1aEhpuozU9XtBEkhMANLB9Nh+/3M/Vh+WuiKf+QBWSxVzeLpfR88zVxOLwpoXZbPzRO2LdhZKUecAmtDhfAAJaeGcNJ6ZfKRUUL1kqgZSOJjMUDGbCW1z0ySjng8r/0ISIAtolrgKxAuPdEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214479; c=relaxed/simple;
	bh=VAHi+PBb8b+++SWfPayXCtK/lkvsgLLw/50K5jGemuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oUJJwIc0DUseTBMgpBp6Pc/YhDVdnROWHpfVie/XyfXLodNqxmUqKqXlH5asvWUwbfoqe2mhJZn6zDn7DWmZtdXJwxeKAMKahj99qv5AvWBaue+OBgWQ/nxuTcv+VBD9UQ8qJ4TsxT/fwhkVl/o3fAXwK9el+oQd219w8WxCPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH2rm2gT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH2rm2gT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB70C19425;
	Sun,  5 Jul 2026 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783214479;
	bh=VAHi+PBb8b+++SWfPayXCtK/lkvsgLLw/50K5jGemuU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=CH2rm2gT+ENl17AEUVXEarn9rco7+PovrVKWa4fIZiN8ItaO4zCzgRN7LmzLiL7ev
	 4fXCx7l19wP6jmoCLdvcJnlvuxgReAJpiBnjGAkGS0mie9k2Jj6xirh+5jovU7Vc4j
	 wM69DRXioDMzMHQFCgPMs8ixhxqTIJiGqEIzxynzbMXYl9Y11Vwafy2jaa8FDFdhV3
	 bLgPX5Xfy8hrD8sjDWNJPyziXr31a1UfhltefJqOq9RYZEB69Y3P0636tnUhtJcdee
	 x38DoOR/I3kFM8YJTQ3RPK9vmepoGK/2R7Le8UamfEWWzqL4clGBJQl8oHzN2vvqV7
	 FSby7J6wivrgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF405C43458;
	Sun,  5 Jul 2026 01:21:18 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Subject: [PATCH 0/4] tracing: add ref_trace_final_put tracing
Date: Sun, 05 Jul 2026 09:20:50 +0800
Message-Id: <20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKxSWoC/53NTQ7CIBAF4Ks0rMUApdC68h6mC8qPJSptgBJN0
 7tLqxs3mriZ5E1mvjeDoL3VARyKGXidbLCDywHvCiB74c4aWpUzIIgwxAiFXhs5TC5CY524wnG
 KMHohNaRNp7gs86wEyO9jvrT3jT61Ofc2xME/tqaE1+0L5egLmjBEsKM1p0wJbAg/3kSy8rJXO
 q0lb6H6IUilEMKUESaa/wRBsSqNQrpmH0K7LMsT7EtDCEUBAAA=
X-Change-ID: 20260624-refcount-final-put-trace-49bd7c39bd5a
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=VAHi+PBb8b+++SWfPayXCtK/lkvsgLLw/50K5jGemuU=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFmeGyslgz5sbDXY/cjNem4Q8wlzhtnsPpu3/pN6mzPJ9
 kbg9qpnHaUsDGJcDLJiiiw1WQnuGStnJRofndQDM4eVCWQIAxenAEzE1Jnhn84GqSPPEpdu+mpT
 JLou4bdi7f9Dedbc/6Z+zhCceWVKfTDD/8AVk68+Uta2fjT/vh3L0aXHcrvqXyRrJDKfZ5Bv8a0
 QYgYA
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

When debugging use-after-free(UAF) bugs, knowing when the object reaches
0 references and enters final release can significantly aide the
debugging process.

There is currently no universal way to trace this information.

This patches traces the final puts in the most widely used refcounting
implementations, refcount_t(and thus kref which uses it), and
percpu-ref.

The tracepoint records three fields:
- caller: function that called the refcounting
  function(refcount_sub_and_test, percpu_ref_put_many)
- fn: refcounting function(eg refcount_sub_and_test)
- obj: refcount object(struct percpu_ref, refcount_t) 

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
Eugene Mavick (4):
      tracing: add ref_trace_final_put tracepoint
      refcount: add ref_trace_final_put tracepoint
      percpu-refcount: add ref_trace_final_put trace
      kunit: add test for ref_trace_final_put

 MAINTAINERS                      |   3 +
 include/linux/percpu-refcount.h  |   5 +-
 include/linux/ref_trace.h        |  26 ++++++++
 include/linux/refcount.h         |   2 +
 include/trace/events/ref_trace.h |  46 +++++++++++++
 lib/Kconfig                      |  10 +++
 lib/Makefile                     |   2 +
 lib/ref_trace.c                  |  12 ++++
 lib/tests/Makefile               |   1 +
 lib/tests/ref_trace_kunit.c      | 138 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 244 insertions(+), 1 deletion(-)
---
base-commit: df685633c3dbc67441cc86f1c3fee58de4652ba2
change-id: 20260624-refcount-final-put-trace-49bd7c39bd5a

Best regards,
-- 
Eugene Mavick <m@mavick.dev>


