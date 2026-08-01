Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA83C10A7;
	Sat,  1 Aug 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611438; cv=none; b=meCFRndxi2EwYcYbZUegWu0u5uPJUqIoJjNvHlZ+uLbpIj5oGwRsanDl+0vl4u55Q+ZU0LxBgRluJ0J9Srwk0Qc1QiJt6vZc5DaK666p3uQq7XuiON3s0V8NlACuskDzlNzR6V3gSkB59on6gxchU1o+Cwc4P6d4RoYevb8yyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611438; c=relaxed/simple;
	bh=lOXjJnwV11xLmT/x56QLC/Z5yyRXKkYl21jBWh3zSOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ss4A2sGtJPeaGbWh+th1MfYofkhOs0vG9kBd9x+3LEIoypMi8o80Z705JWInDbI10nDp1Px08UrI5L7JWannYzrzUUIK95BgrhS45Er/xGolCvZrUms3+svaRZgi1tmuGZV98zUztwzLk0XSNKWCqcyCLsljYo+oG1Qr5/wqiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=NblRaDNW; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="NblRaDNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lN1m/I8PieEZoPbV23xzJKbm0GD3D6HSBwK8WEQ2XOc=;
  b=NblRaDNWVwfRxN2UJibLOZYisnwuo4b446gks4S/kqVRwPlUsCAfKd2P
   g0eaRdWSelZUfvv1x8SuNFyr7avQWgYSUe4ujACQfD4FZG7Q5Oxy3RQ0R
   8Nwe2ahvLVKkWbrcOdNztWHUGWuGMiKK/n0p6NKcIPrcR31INj4oTtbnv
   g=;
X-CSE-ConnectionGUID: xTvK1QbrQ/+00+J9a/QkYw==
X-CSE-MsgGUID: SOwu3bYZTPGjPCDjEI04gA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288769008"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-janitors@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:52 +0200
Message-Id: <20260801191002.1383835-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/trace/ring_buffer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e2485bb3..7749dd2ac 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -405,11 +405,11 @@ static void free_buffer_page(struct buffer_page *bpage)
  */
 #define alloc_cpu_buffer(cpu) (struct ring_buffer_per_cpu *)		\
 	kzalloc_node(ALIGN(sizeof(struct ring_buffer_per_cpu),		\
-			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
+			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu))
 
 #define alloc_cpu_page(cpu) (struct buffer_page *)			\
 	kzalloc_node(ALIGN(sizeof(struct buffer_page),			\
-			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
+			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu))
 
 static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
 {

