Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245313BC0C;
	Wed, 24 Sep 2025 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673594; cv=none; b=SSp5FC9ELjLiqsXInyWwj8MNNiPSAABHab45DGu5jsRCVL0Wyxlpw5QVEmihdJvuNY2JzV4qHR1ZlSKBSj9b9R84vVBqqq3jgTcDtyjDfjh+/f6tyy+zt67qTbotox2Cx0yzJOjn5ruCxU138B/pgqpDNqCuBBcmXAdVeU0chGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673594; c=relaxed/simple;
	bh=wLP2mrqM2e5+SoEMo2MRqMfkI1+jTpVM4NNQqTkfDSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rV10AorbwOyKv/Ve4swOBXXu+DJ3OWvxYI4+xJGxqQnIBq6ssYWfYrxMp7X8dQsay6AzC269ZtSFl4H20lp8MrwypXQkYM2mcNMT/0FsDpZRUpfS2slD9ceEacG2qimyRRP4oq2WrDxxyjM/bFNRKDwF1zHDRdt1CbE0Jk5XOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCD0CCb+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCD0CCb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AF4C4CEF5;
	Wed, 24 Sep 2025 00:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673593;
	bh=wLP2mrqM2e5+SoEMo2MRqMfkI1+jTpVM4NNQqTkfDSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DCD0CCb+Tu/Ba2yv844NrIy2uCQXcN4P8sobkyVlqy10GrXZfHb2XQRjIFcjkJUzp
	 AjgjgJU7DJY87Y1Uzi9rgqD74hZMCG6zp9szdHnod+1ytlzUYxM2FUGgDZidbb1oq7
	 ynyIb6n2oXvlJR+pP4Pav9lbgpjf8xiz+mKQ6obMt2lOceUAx0EHlZxBO3raRPo0l5
	 aC1Juv+u6eEwSa/VmmnGi1h/mVTRIZnq3eVxxuSRBdfDGroXL1Dn9k0tBlC3GpXpgP
	 Fb0RaUWuSP3RYoHsNFCD15Fq2CAYHRbxwuBJLVTSZxPyLDnbH/AYhmv4bqviemwUDK
	 SAmQKyBUydhnQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: fprobe: Remove unused local variable
Date: Wed, 24 Sep 2025 09:26:29 +0900
Message-ID: <175867358989.600222.6175459620045800878.stgit@devnote2>
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

The 'ret' local variable in fprobe_remove_node_in_module() was used
for checking the error state in the loop, but commit dfe0d675df82
("tracing: fprobe: use rhltable for fprobe_ip_table") removed the loop.
So we don't need it anymore.

Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6a205903b1ed..12ec194fdfed 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -457,8 +457,6 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
 					 struct fprobe_addr_list *alist)
 {
-	int ret = 0;
-
 	if (!within_module(node->addr, mod))
 		return;
 	if (delete_fprobe_node(node))
@@ -467,8 +465,7 @@ static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist
 	 * If failed to update alist, just continue to update hlist.
 	 * Therefore, at list user handler will not hit anymore.
 	 */
-	if (!ret)
-		ret = fprobe_addr_list_add(alist, node->addr);
+	fprobe_addr_list_add(alist, node->addr);
 }
 
 /* Handle module unloading to manage fprobe_ip_table. */

