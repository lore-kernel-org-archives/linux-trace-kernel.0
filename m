Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09471AD5A;
	Mon,  7 Apr 2025 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743990238; cv=none; b=o5xO8gPxgHXTF9009tTTmbz60JEXI/NtIKWABLXs7L2B6FA8gQUXbD+oEDl4hxuXWkw8HYD5/iFNTPydTq7Lhk5phEDjixVfk0B4zs5VNHC6v+10EXgvfzUbCaFsCuDj4xPjTtSePbQXD9CltGNmR0/wys0aXmBU/4n52dVnpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743990238; c=relaxed/simple;
	bh=YaxfyaahaOVirPTxQFyiHvZmst3YssmDcY0w+WZuZgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3Qm72uwfAcJAhcaO+Js6yPlK+SDmb4gyTFP6Y6hm2/Suyt/cTHaYl6l9xE91cKfj7q0qov7wI/ZC9FezpBRFkGZkYa+1GV0E3/UmE13u/cx6ywy8/uqCqyMK2irJeF092X4Slm6EJJSZ9rDtMVdgJovACZ/NyItKPehOOybohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWTbW/32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWTbW/32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26135C4CEE3;
	Mon,  7 Apr 2025 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743990236;
	bh=YaxfyaahaOVirPTxQFyiHvZmst3YssmDcY0w+WZuZgU=;
	h=From:To:Cc:Subject:Date:From;
	b=qWTbW/32IPeahfjqzPtj1A2/Bx18EVmxYADS1NW/pbZl4ep2dJusCRv+e0sdfKgON
	 ZOqX/Dpnq8wqU+oA9RPB2gyNizfkYMrsiKMj2xn2h32Uw5R9XyotDCn+Zzswt2B6tP
	 Ze/xgzD99fCizgreNgSisaFOXQ+qA34NSJlCBUYEaFeVEbOEkTRMu2zNtT84nqTlpj
	 bZlJdye/LpjMyKcLd7vTz1i2Jb4a+kSL4f8Xb2Iwyw1iBUloGhuXfvD4TNo+vsrG5d
	 6sND+eSelbK61GRnSU0tKDdomkKM+ivDGZbUjwdn1W0Tswxwum/ao9ZKw4393c2YlD
	 U1ts2dmrHc1pA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] memblock tests: Fix mutex related build error
Date: Mon,  7 Apr 2025 10:43:51 +0900
Message-ID: <174399023133.47537.7375975856054461445.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix mutex and free_reserved_area() related build errors which have
been introduced by commit 74e2498ccf7b ("mm/memblock: Add reserved
memory release function").

Fixes: 74e2498ccf7b ("mm/memblock: Add reserved memory release function")
Reported-by: Wei Yang <richard.weiyang@gmail.com>
Closes: https://lore.kernel.org/all/20250405023018.g2ae52nrz2757b3n@master/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/memblock/internal.h    |    6 ++++++
 tools/testing/memblock/linux/mutex.h |   14 ++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 tools/testing/memblock/linux/mutex.h

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 1cf82acb2a3e..0ab4b53bb4f3 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -24,4 +24,10 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
+static inline unsigned long free_reserved_area(void *start, void *end,
+					       int poison, const char *s)
+{
+	return 0;
+}
+
 #endif
diff --git a/tools/testing/memblock/linux/mutex.h b/tools/testing/memblock/linux/mutex.h
new file mode 100644
index 000000000000..ae3f497165d6
--- /dev/null
+++ b/tools/testing/memblock/linux/mutex.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MUTEX_H
+#define _MUTEX_H
+
+#define DEFINE_MUTEX(name) int name
+
+static inline void dummy_mutex_guard(int *name)
+{
+}
+
+#define guard(mutex)	\
+	dummy_##mutex##_guard
+
+#endif /* _MUTEX_H */
\ No newline at end of file

