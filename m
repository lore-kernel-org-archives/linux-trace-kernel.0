Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8157268E;
	Wed,  9 Sep 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969247; cv=none; b=uIqXIdT1Gc27GHSsPsk/U/gkPDOPJZdII0+OkcPC1A8ecWem22eSvbrTywdZ51RHm0/hYg5F/V2HelvaHZj0/V2eXzalLwSTX8Nu6G5rsk9O5sZSCBkuJ+dEp2vj6RagvhDBRFmTuk5zJzAhizF7wMNc0GqG+UBUbtIZ3Ae6aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969247; c=relaxed/simple;
	bh=iiCqDt9mQIBQuWEbYlHKIjXIwZW1+sg6Y68w5Rr5kBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMnrQr1HV7Jzw4zg1ep6hhsBJxgQ1QuHcQkZfIP5Rz+KiSlNDRjAxXMpl76+8HltogX66+ISAEfQ37RmaW2nxfQJgKtjjmtCg6U1FvWaGsSGZgxJPnJ1Rpzk3WL89DMCY1inkxBfg/R+a5na/3MC7BH4U6FgMg2ctC5j2Zh8hTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWYtl8p3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWYtl8p3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE59B1F00A3A;
	Wed,  9 Sep 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969246;
	bh=lc9EDpaTK/r+zWTBkBXV/JPAZb/7ckGcnzP62wQl6z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWYtl8p3uOWUXs4D4RIv5xoYkOoVPkr9NyxuLKKuHCCO52wcy8xmkpJpy5e4p0Ovk
	 YQ5cMI6qyCWLVVd+2cIb5ERmEOvQk9nR3cY9yqECQIC2y/k+HJxTXHZ/cufz8EFJPS
	 Fi6ujPTEsr0d9BQ/1HHj6R7uFMZa9KoULjvW/29WLlAncIdbrB+EBR2flEz04MS7ga
	 DdoYJSmQxzwMIccBe1hgezt76XAq+t+hMUKEQq4yS+h0rqFhAC6sTjOuWnxZHG0yTO
	 AMjmXcmqC8+HXQBda/rOOsQ91wSTzP3gUvauFvgnti52H6uHYMQcp2kCieAbUwjPhZ
	 vN0bzUCwfONQw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 3/3] bootconfig: Skip internal tree sanity checks in kernel
Date: Thu, 10 Sep 2026 00:54:02 +0900
Message-ID: <178896924262.177508.71609739247457811.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178896921555.177508.434402948295885560.stgit@devnote2>
References: <178896921555.177508.434402948295885560.stgit@devnote2>
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

In xbc_verify_tree(), the loop iterating through all nodes to check that
xbc_nodes[i].next < xbc_node_num and xbc_nodes[i].child < xbc_node_num
is a defensive sanity check against implementation regressions (such
an out-of-bounds index cannot be produced by malformed input).

Running this check in the kernel adds unnecessary boot-time overhead.
Split this check out into xbc_sanity_check_tree() for userspace, so
that it continues to run during userspace bootconfig validation (e.g.
when applying or testing bootconfig with tools/bootconfig), but is
omitted in the kernel to speed up initialization.

Reported-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Closes: https://lore.kernel.org/all/20260905141637.1547429-1-ekffu200098@gmail.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/bootconfig.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 0ec2874db9c7..884f186b1989 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1000,9 +1000,30 @@ static int __init xbc_close_brace(char **k, char *n)
 	return __xbc_close_brace(n - 1);
 }
 
+#ifndef __KERNEL__
+/* Sanity check for regression: node indices must be within bounds */
+static int __init xbc_sanity_check_tree(void)
+{
+	int i;
+
+	for (i = 0; i < xbc_node_num; i++) {
+		if (xbc_nodes[i].next >= xbc_node_num) {
+			return xbc_parse_error("No closing brace",
+				xbc_node_get_data(xbc_nodes + i));
+		}
+		if (xbc_nodes[i].child >= xbc_node_num) {
+			return xbc_parse_error("Broken child node",
+				xbc_node_get_data(xbc_nodes + i));
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static int __init xbc_verify_tree(void)
 {
-	int i, depth;
+	int depth;
 	size_t len, wlen;
 	struct xbc_node *n, *m;
 
@@ -1019,17 +1040,6 @@ static int __init xbc_verify_tree(void)
 		return -ENOENT;
 	}
 
-	for (i = 0; i < xbc_node_num; i++) {
-		if (xbc_nodes[i].next >= xbc_node_num) {
-			return xbc_parse_error("No closing brace",
-				xbc_node_get_data(xbc_nodes + i));
-		}
-		if (xbc_nodes[i].child >= xbc_node_num) {
-			return xbc_parse_error("Broken child node",
-				xbc_node_get_data(xbc_nodes + i));
-		}
-	}
-
 	/* Key tree limitation check */
 	n = &xbc_nodes[0];
 	depth = 1;
@@ -1199,6 +1209,10 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	ret = xbc_parse_tree();
 	if (!ret)
 		ret = xbc_verify_tree();
+#ifndef __KERNEL__
+	if (!ret)
+		ret = xbc_sanity_check_tree();
+#endif
 
 	if (ret < 0) {
 		if (epos)

