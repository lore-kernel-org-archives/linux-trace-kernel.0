Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309324;
	b=ncdICI2BT2z3dqLh3iKAxI7kEfgCGuR7wo13Ad6/gmjnzClakk1N7VBfKQz4WdREHz3R
	 +Sv4pEwAvqrQf2KsFtOXkU6h5a+iMskmQX4r35Kmv3J0aVsQKVmYa4fO/kFKx5J1U5t5s
	 QABbZFj+f+Rt6lIRTMEL0/0Jg760b/9S4a9Dbh3wrYTugTrcDxT83qH5dCAlaQuo6rV2i
	 qW6Hmk3NKXCwPc3qZz8zC8lVmrbqx3m3u0BdsTaIUhZI7U1KCGkrVE8Y8tGy29m3qfvhu
	 bD9i3cO9OUcUBu4aw2/t/XpGZ8ChEEQYo5Q1ebVqXLtyRQFEzCSYfCTJudcMUHfZV6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309324;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lnBEH0p6r3UPknc3C4wg4y6qEbBf3lVN3JOIh9pdOW0=;
	b=LYb9Embe9CiyYHoNw+Y91dPLb67SQC7Vn1/3r5T/KT+J3FXkDGAEzcxIk+ToPGpdlt+e
	 mK9wCyYdwaaDTxIcVOJsku70Nh7Uf6LYkPXqLHMSwNA6fbBeRnLKr7GuC1fuLEt9hwlaj
	 Im9q71Ii2AiNlgROfZqVTgeGPjQl4TyPulCCS8ngScuCFrCDIU1phvZcNznOYtlwxywfp
	 eZ+dOw1rOEuwwLoz5RFT9WknhOtLwirudRy2JQWGRZO51EViA/Me7CYRui1CDLMHjKmLE
	 AnWmb3lFA6K9xutoyanGTFFmxmJcqjVZ3Hai6GQKr3HCug/MU809EkQ7Mtu8ouli37g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHhx2rKG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8B606A32A;
	Sun, 22 Nov 2026 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHhx2rKG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468AD1F000C4;
	Sun, 22 Nov 2026 01:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309323;
	bh=lnBEH0p6r3UPknc3C4wg4y6qEbBf3lVN3JOIh9pdOW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHhx2rKGE0C9nNpe3Snx697fxqPdAHNAikiICivvJaXPfRC7jmvJHQEYvV/+WU3vp
	 7wRfAZcZkuROYbwy8AIghF6squ90bANwQQhSYdmQO7d0ih0r1fTfVQP1joeYDxeteF
	 q+a6GkSHnmhUJL9SbLEqamPkafQVI+aKZzrnbnhJgoQt65bAsxBBidBuIuZX5J+l6x
	 jbSBiST8PgVhdHKWE0X1ijCaA+7LDq6gWNFG+wX7piERW++7g8RgT/dW5vYC4biu0u
	 xUVFYOz0SEp53U1d6PtEAcgdsUwn3Gs7Y/IGfmzPKf0B9aPS6fOtNBXUgPJK9lhZMj
	 DTKPljwgm7BGQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/4] tools/bootconfig: Add tests for unclosed brace position and mixed-kv limits
Date: Sun, 22 Nov 2026 10:01:59 +0900
Message-ID: <179530931973.109991.15787416583892751589.stgit@devnote2>
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

Add regression test cases to test-bootconfig.sh for:
1. Unclosed brace error position reporting in xbc_verify_tree()
   (verifying both samples/bad-tree.bconf and a multi-block config).
2. XBC_DEPTH_MAX (16) and XBC_KEYLEN_MAX (256) enforcement on subkeys
   under a key node that also has a value (mixed value+subkey).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index f584f7637e12..6b396dea9095 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -220,6 +220,39 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
 $BOOTCONF $INITRD > $OUTFILE
 xpass grep -q "value" $OUTFILE
 
+echo "Unclosed brace error position"
+cat > $TEMPCONF << EOF
+a {
+  b = 1
+}
+c {
+  d = 2
+EOF
+echo > $INITRD
+
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
+xpass grep -q "Brace.is.not.closed.at.4:1" $OUTFILE
+$BOOTCONF -a samples/bad-tree.bconf $INITRD > $OUTFILE 2>&1
+xpass grep -q "Brace.is.not.closed.at.2:1" $OUTFILE
+
+echo "Mixed value and subkey depth/length limits"
+cat > $TEMPCONF << EOF
+k1 = v1
+k1.k2.k3.k4.k5.k6.k7.k8.k9.k10.k11.k12.k13.k14.k15.k16.k17 = v2
+EOF
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+
+awk '
+BEGIN {
+  printf("root = v\nroot.")
+  for (i = 0; i < 255; i += 1)
+      printf("a")
+  printf(" = v2\n")
+}
+' > $TEMPCONF
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

