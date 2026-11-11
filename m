Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406434;
	b=aPcUmfDiT4TuSwiXcNbp8B+YF+duYdZ9tVUxlq3IIPQlgR2UE9aQ8WTnzvdGKuq9bq+C
	 Ce4hcW4jXetJHFK+Tt+vOf0YnxBr5FE5TzNdZ7VY5geJkEUCppLPtuEyt6mytK84NF85x
	 Unrq0jozEYana0inqwVO1UVw14vo6AaY24yUQd7GywJNp4qMYqUlPRXgK0CYRAyrAXVXs
	 w0yITjapjf/8vNYhuT8CDdbtSe9Pn0HRrIAm/FV5fYoxysR1rl0koI4g05N4pj1Pe3F+Q
	 GV7H9XMQp0+Gm7z5IQJOObtFZhDobqzDhRxnyCqgQdHiUe3ENRcxAloOYA8NdOyBhJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DbszRCpAYSNEHtaRI63AVxdCxUKlD1PtJDbvBtEHyXk=;
	b=sQQghm1jXcjue3KN1yz+zonYigWO61u0OGS4Jy7GgxlPYmOA0c/QffwPmpA7sbYOyqIW
	 BPalA4tbCqg18sy5m4TjXovDqyJvt7nWqlNyxMdsHvCRQ3OZyYOTYVUXgvV83MzFLLpU6
	 BdFK/V423fCZm24LuBBDPpfKxps0vATxPiHe06yC1Dnjsnynn1B0vgMJdeJ8MupqHe7JO
	 qjbluTirAkW1tdMYEljFQ5q9Ls8uSXxRP7yvSaGwaPfq2GLe1xSqk4r6mldGJWlIzTVoh
	 niriUbfxv5yJ8rIDWHyySmUSaqbW2flyApjpUzZqpuNOWguxYnA3Y44JLTUt/eh+NKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMtm9hTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCE60A3806;
	Wed, 11 Nov 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMtm9hTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38AE1F00A0E;
	Wed, 11 Nov 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406434;
	bh=DbszRCpAYSNEHtaRI63AVxdCxUKlD1PtJDbvBtEHyXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMtm9hTZ21hNKKQEaf4i6PuvdAKJh7Kn2YWKXxyoZd2T2wz4AsEmxH9Gfgo9sOmuV
	 QfQTXDPcQOV4ZDWx7j9sufqrZHFQgyFaOGoxzH4SikmJYbBTDVmg9PDSH88XuDvdpF
	 1Ib6L4YJsWlbiFb2bO7EWZPMBsSEMuLIRqRRWGSXxR2oAn+Eymk+BnkftVddYirzMo
	 Myh6iZSPZm2US9ouNmJvfP21VFb95v4XI8wLobdmKPLj44vyXaA9eWrGXe/MaWTXSu
	 50l3mEpdc+RBg9a7oEd4uBG1mTJBWKX1gIbGMHzxs7MFtJ2OVqJzTDWkmDeanJa/zs
	 tlChJs+auSsLA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v3 3/5] kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe
Date: Wed, 11 Nov 2026 23:13:49 +0900
Message-ID: <179440642973.328088.10282643330198602134.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179440640176.328088.17106877243326801914.stgit@devnote2>
References: <179440640176.328088.17106877243326801914.stgit@devnote2>
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

When an optimized probe is temporarily disarmed or disabled,
unoptimize_kprobe() places it on the unoptimizing list, but leaves
the relative jump in text until the optimizer thread runs.
__disarm_kprobe() explicitly skips arch_disarm_kprobe() when
kprobe_queued_unopt(p) is true.

However, if __arm_kprobe() is called before the unoptimization pass
executes, it unconditionally calls arch_arm_kprobe(p), writing a
breakpoint instruction over the first byte of the jump while leaving the
trailing bytes intact. optimize_kprobe(p) then dequeues the probe from
the unoptimizing queue, leaving the jump opcode overwritten with a
breakpoint in text while KPROBE_FLAG_OPTIMIZED remains set.

Skip calling arch_arm_kprobe() in __arm_kprobe() when
kprobe_queued_unopt(p) is true, keeping the existing relative jump intact
while unoptimization is cancelled. If optimize_kprobe() cannot optimize
the probe (e.g. due to a post_handler or disabled optimization), force
unoptimization immediately.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Restore the __arm_kprobe() fix that was accidentally dropped in v2
   while omitting the reuse_unused_kprobe() hunk superseded by commit
   1ffd6efb1b58 ("kprobes: Arm reused optprobe on cooling list").
---
 kernel/kprobes.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c0637302eeae..f7cf77ca70de 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1263,6 +1263,19 @@ static void __init kprobe_sysctls_init(void)
 }
 #endif /* CONFIG_SYSCTL */
 
+/* Return true if the probe is queued on unoptimizing lists */
+static bool kprobe_queued_unopt(struct kprobe *p)
+{
+	struct optimized_kprobe *op;
+
+	if (kprobe_aggrprobe(p)) {
+		op = container_of(p, struct optimized_kprobe, kp);
+		if (optprobe_queued_unopt(op))
+			return true;
+	}
+	return false;
+}
+
 /* Put a breakpoint for a probe. */
 static void __arm_kprobe(struct kprobe *p)
 {
@@ -1276,21 +1289,11 @@ static void __arm_kprobe(struct kprobe *p)
 		/* Fallback to unoptimized kprobe */
 		unoptimize_kprobe(_p, true);
 
-	arch_arm_kprobe(p);
+	if (!kprobe_queued_unopt(p))
+		arch_arm_kprobe(p);
 	optimize_kprobe(p);	/* Try to optimize (add kprobe to a list) */
-}
-
-/* Return true if the probe is queued on unoptimizing lists */
-static bool kprobe_queued_unopt(struct kprobe *p)
-{
-	struct optimized_kprobe *op;
-
-	if (kprobe_aggrprobe(p)) {
-		op = container_of(p, struct optimized_kprobe, kp);
-		if (optprobe_queued_unopt(op))
-			return true;
-	}
-	return false;
+	if (unlikely(kprobe_queued_unopt(p)))
+		unoptimize_kprobe(p, true);
 }
 
 /* Remove the breakpoint of a probe. */

