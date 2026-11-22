Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309296;
	b=NX9OJj8S9+YqOFwp+mvJKije7f3rrZK+IDLoAOUoosTQIjZUe2fHy9TVgW2QK0374eiE
	 4lTyhSwDOmgWnI7s0qSWrAEze+56ANHtF5vFYefVpmCZmbaxj8TCERo3awSo0E+A6t/IN
	 too/O/W3G2pTHAgXG/gNhMLz+MGmZ+8dAicKouXZOe++0rMg9sKWvZzTmI7eXP053agtj
	 F+hg5wZl0H8dxQNkfKBh1q2/tl47uPD/KKgSdX0r1Uw9o43B8zbE5jvFI44IfbJI7qDOB
	 o43JoCaR00kdRarsZc8KJfwF3eb/qga+nCYNWtI4bpYnMBDWDBj+kyl6OBHKAV9vUnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UM9h60BPkjbdH6I1J2d6HtVxOw6X2XVy8a/TAEnzBpE=;
	b=4dGydU3alAznlFOe/pTkB7//2/ZbH5/F+NkkQd+uvZBaFc7S68rCfqo1u1eBz6ucs9cJ
	 KmsVWhqF0pQDY3uZcpuCtlb3B+RLyPMEgBgEnYMsYStsOHnZjjnP4+iOx9hJnkjRm/qqP
	 WThtXBi80/A/F14+FlOo1XMcNPrxyuSIumGz8ZPnlSSUzl6p9CeL3Xsz6lrRq83Wp8ivS
	 Gh0evIDhSAAn+Y2bmFEOJ1dMbe796eemFtYQl2H0UC60yYMTe1YKMXgwvxoy4CC7dc5VX
	 YSOQD8WtGQj1Uh2Y1FBf0ZlW1V1C8aqDr8f5hxid3dSQQrXLiM5DYvuNjJJ4bMBBuCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkzlAoJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66911606A32A;
	Sun, 22 Nov 2026 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkzlAoJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822951F000CF;
	Sun, 22 Nov 2026 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309296;
	bh=UM9h60BPkjbdH6I1J2d6HtVxOw6X2XVy8a/TAEnzBpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkzlAoJ87XKv3rSUCfdcIFR/XEXSuXa7JgpHWl8AD+iyqVnhp+FsSiMtoKAECaOaL
	 i3WoPZuZvMHwN2GZO05F/gU6+katLJh4c+zaU4FPpZZ+8z578wYv6VbUSVKuTs8Cn/
	 U5W9vx7piV5Y6Ur4pW9fUBiCP4Y9183SokC18E5jESGX350mEYrAP0pogl2VkKJbuf
	 v2b/Ttw1GMDriWl59WuH23uu34E5u1M3uAg4z1y9oWph606QS23CTs5Bb/340pom0T
	 vjQy4oNEea9YYtWnBYsQcHyxk9U1+HjLH4LEc9iIZYVBmKoSHH44tuqGIWfsQuWX+R
	 fR2oYig0fBTmg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] bootconfig: Fix xbc_verify_tree() to check subkeys of valued keys
Date: Sun, 22 Nov 2026 10:01:32 +0900
Message-ID: <179530929234.109991.150550090881188440.stgit@devnote2>
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

When a key node has both a value and subkeys, the value node is always
inserted as the first child of the key node (xbc_add_head_sibling()), and
subkeys follow as next siblings of that value node.

However, xbc_verify_tree() uses xbc_node_get_child(n) and checks
xbc_node_is_key(m) to descend into subkeys. When a key node has a value,
xbc_node_get_child(n) returns the value node, so xbc_node_is_key(m) is
false and xbc_verify_tree() completely skips verifying all subkeys under
that key. This allows subkeys under a valued key to bypass both the
XBC_DEPTH_MAX (16) and XBC_KEYLEN_MAX (256) checks during xbc_init(),
causing runtime -ERANGE failures in xbc_node_compose_key_after().

Use xbc_node_get_subkey(n) so that subkeys of mixed value+subkey nodes
are properly verified.

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/bootconfig.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 948c8c10e4b9..026d88a65c5c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1058,8 +1058,8 @@ static int __init xbc_verify_tree(void)
 			return xbc_parse_error("Too long key length",
 				xbc_node_get_data(n));
 
-		m = xbc_node_get_child(n);
-		if (m && xbc_node_is_key(m)) {
+		m = xbc_node_get_subkey(n);
+		if (m) {
 			n = m;
 			depth++;
 			if (depth > XBC_DEPTH_MAX)

