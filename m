Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309305;
	b=yysI9PeSA4E+YPwvllSiJVqvvphv5xASzAGbjUiMphybPWTTx0iSOj0sEnubSco2buOl
	 nCH4oNVzMze9JITWqhFX8saBDao1wZsBDRgY6OuCqvUCf50yYFp/guSifOJ97nhMihNBa
	 tbLvERaNwn11MZGoE2dqYRHCbnozmynS9fXGw0tcP2m9XfdCqmXymd5A+jjeWHPXbOprz
	 +wtmZnXai0rdxtAWlMdkKzVdqCN+501fySxz/q8QPNh/T3cQ93I0GomaBeM6m2tS/l3SA
	 HnAYSZ/WCGiutsvMzgHDPSeSS1es28BPBazweS/LKL3gMJ61xrbvBwmkdVeFR8iMZfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f8oD3StepKAq57WQHx98dwXn6vomk0k4tBPHUkOr0Tc=;
	b=1q2VCgpQ+kHMBgEMFqZyyajxTMld9yPwljive+c8mxujRcmOym6tef80OjKBCw51NJnI
	 lp9ZBqH/150qVCrlvf/ce4cYp6suQYDcgsiY8H5ga+JMGDC1XJAGaKwAf1VmZsWnMFHu6
	 H6eTJnVmL7slunSYbmpsCc1lOZoZ9poAFjTZ8XuTUMpTs8Jkwpasz/2j1xVSXfPQb3T4q
	 AAUrQqC0BAW1Szi8vMQGtzS26Mhst3h9OTtMSnd3KbFq7PeHdEFfoGY0dlmf2Dv5lPSks
	 x92SqzQo4rGuQbe49Qeu80mJPgZDYAXCLAiQL1piig+ivd0R75T24wrOv8jKUCEUXBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aa9GzVts;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F21606A32C;
	Sun, 22 Nov 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aa9GzVts
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8572C1F000C0;
	Sun, 22 Nov 2026 01:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309305;
	bh=f8oD3StepKAq57WQHx98dwXn6vomk0k4tBPHUkOr0Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aa9GzVtsebKvnHbv1q0FrMuM08O8EM+cdv+emoLHL0IkUi/9B9W7wC5wPuq9WqHgk
	 J0k2/apo2kCFoDaAWwpPuH8/uhVsQKjHddxJJOiPKh9xQUBjflOo05lc2dbJA2EaZ2
	 NQ7OdGhxXGser0VyEku3SE2+RXgoCzwAtc1yxSZtnPhWL5QEO2s97FO6YoApBfcX1r
	 uyhYhvahU6QDwGAbGdhHral6q4zT1R+sP9E8ULldfaxC6LLS6KCgj66ETSyD9bBVIO
	 EqkC2NF4Vco+JWn7vIL2sIGyYAkYkbmjKCAb7PfkdCC5ZLWXGr1laVNRITpTmGpLhs
	 zxi8Qkvuol5qg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] bootconfig: Fix xbc_node_compose_key_after() for value nodes
Date: Sun, 22 Nov 2026 10:01:41 +0900
Message-ID: <179530930140.109991.1418783350874051238.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179530928294.109991.3079999508446852151.stgit@devnote2>
References: <179530928294.109991.3079999508446852151.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix two issues in xbc_node_compose_key_after() when @node is a value node:

1. Since array values are chained via the child pointer in
   xbc_parse_array(), the 2nd and subsequent value nodes of an array have
   the preceding value node as their parent rather than the owning key
   node. Climbing only one parent (if (xbc_node_is_value(node))) caused
   preceding array value strings to be included in the composed key
   (e.g. "foo.bar.val1" instead of "foo.bar").

2. Checking `if (!node || node == root)` before climbing to the owning
   key node allowed a value node belonging to the subtree @root key node
   itself (e.g. `foo = "val"` with `@root = xbc_find_node("foo")`) to
   pass the check, climb to @root, skip the key-collection loop
   (depth == 0), and return 0 without writing anything (not even a NUL
   terminator) to @buf.

Climb parent pointers in a loop while the node is a value node, and
perform the `if (!node || node == root)` check afterward.

Fixes: ca24306d83a1 ("bootconfig: Change array value to use child node")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/bootconfig.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 026d88a65c5c..280b7e73321b 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -421,12 +421,12 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 	uint16_t keys[XBC_DEPTH_MAX];
 	int depth = 0, ret = 0, total = 0;
 
+	while (node && xbc_node_is_value(node))
+		node = xbc_node_get_parent(node);
+
 	if (!node || node == root)
 		return -EINVAL;
 
-	if (xbc_node_is_value(node))
-		node = xbc_node_get_parent(node);
-
 	while (node && node != root) {
 		if (depth == XBC_DEPTH_MAX)
 			return -ERANGE;

