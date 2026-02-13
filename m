Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CC277CB8;
	Fri, 13 Feb 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976914; cv=none; b=kGbYMmkb2pZkN4C/YwoosQoXHzJ65Eq+BNY3mnSZNH0mOJkoIlD4eIrHi+oIkCNUAIhsowQ5LkN4bgNUwoyqR6+tsE049tkvHMpIiqxf4BUXdf8Rg3cha9oTQTjxhwyjy5dTA8BZDkuaTdhfy3/dggGbwVLwrJQtCMbwHnojwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976914; c=relaxed/simple;
	bh=rr92s6ZCEgflz+1Ww9CQ/JtQLS9bsoxT2827kjWlWZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPojUdJ+tqnhb/nQJoL9p42maYEM1dKgs1XDdNzQKiE/lvk9kOK5MpdxipHRroafkOK/rnHaZXkUt9+nTgKtQaT0uq3Bnb09LsZ1yEaacvSnV5L88OUtSu3H9l61CoFj1UzF17PjBLFP4Sq5PznG3NpeYF3NQfPPg4XfZ8eIg3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=M5w6xUVh; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="M5w6xUVh"
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1770976897; h=from:subject:to:date:message-id;
	bh=rr92s6ZCEgflz+1Ww9CQ/JtQLS9bsoxT2827kjWlWZ4=;
	b=M5w6xUVhvSET5yMsM/WJDIcNuLVQyE25Y/KqRcA0BLIRhuCSMhA/pZ7hz7j5cX0BH7Nvh2jE1HQ
	W21pjudqjHyOSNyWwWOGzdJrenbKAXVFIeChaGjuou9LxKqoiN2MNejU+H5THigr2Y0hytXPMnp9J
	mUnCdTRt6VmCEzVL+WTlnRxqQx2n4P46KCTN2fRc69X2YxXAja6KczIZ+tWcIb0mLQGdsn0lWIG/q
	F+Q0y92VJWdtYSF4DaUY/xTmJkYwYPlhT2MZA24uuY6qdOXeIC14yQM3qtsJXuK6hkNv5i9jQzceN
	neJSxvU9tZmm23VzNS9yIgDSpdDG7dXYzsAA==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "open list:TRACING"
	<linux-kernel@vger.kernel.org>, "open list:TRACING"
	<linux-trace-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "kernel
 test robot" <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] ring-buffer: Fix possible dereference of uninitialized pointer
Date: Fri, 13 Feb 2026 13:01:30 +0300
Message-ID: <20260213100130.2013839-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

There is a pointer head_page in rb_meta_validate_events() which is not
initialized at the beginning of a function. This pointer can be dereferenced
if there is a failure during reader page validation. In this case the control
is passed to "invalid" label where the pointer is dereferenced in a loop.

To fix the issue initialize orig_head and head_page before calling
rb_validate_buffer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202406130130.JtTGRf7W-lkp@intel.com/
Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 630221b00838..ad08430347b0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1918,6 +1918,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	if (!meta || !meta->head_buffer)
 		return;
 
+	orig_head = head_page = cpu_buffer->head_page;
+
 	/* Do the reader page first */
 	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
 	if (ret < 0) {
@@ -1928,7 +1930,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
-	orig_head = head_page = cpu_buffer->head_page;
 	ts = head_page->page->time_stamp;
 
 	/*
-- 
2.34.1

