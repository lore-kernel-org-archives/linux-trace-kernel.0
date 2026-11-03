Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750320;
	b=SjrpUNUzinkGMfy7LVeShjqfXB2mrcbL00gkl5N0xhVR+Ar0kHmyoTrsui2RcC/KgcgB
	 X4ZUKcorDcalkgApYiTRvqcMg8sjqYcig5j0JKRhRHLE1MH+q4Pcl8u+JHNTzVaiKx2Fj
	 RTkgDf85ZQBcrgTmPE2u9bSMNiHIyVqjV6hyTkkMqQnNTBuz/6jTS9mdo+i6A/k463bT0
	 Y6kmlnQynLDkSB+p5lQIcJuSB07Z2pg+Znc2SYZNofRaZ4fLQZPvOO7xwzPgYafgSflj/
	 BTMFXGO2sISiIzKmJA4iOTBZYaO0b8SwU1XVDxeUs5GX9VLJdin78zSShNsnMfhNTNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dXPxpSwgj9CkvTzByV3NkCE2tsVV01v4gYY5lEUyS8c=;
	b=eNYxM3wVacMHNY3sF9EGz49zh4do6lX3EWlmqpa4Gc9IxZY5CM5BGvRc5OgJEeveek71
	 HNRcSYZgZWMqJss1qECWq0JPEkAh05HfD7+Mj+J9t8XLBleE/tqtbGjiNnvgq6L4WdGiM
	 K25FsxpC52P3tOsyzJ4fwRh7Cj/Xn2NAPZy9NgJjkfOJhUTZVpcdVebg3Nypd6kDp555o
	 MzJXXnQkWCX27cCm5PZf5X0vTDuplatDKcug5lnhcpqOXcXIYMbL9hjExCezvRGcZFcYa
	 zuHzY2jz3VVk1zc/4zIIU9LENNF1rg99oQ5WPchk0/3JqqzvysuAWrkUjr+OauxyCSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bt0QPcAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D380606A337;
	Tue,  3 Nov 2026 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bt0QPcAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80041F00A17;
	Tue,  3 Nov 2026 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750320;
	bh=dXPxpSwgj9CkvTzByV3NkCE2tsVV01v4gYY5lEUyS8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bt0QPcAF/W5UJ0gzr3r41g6S6WhI9o4+tWx8jj3t1SOgfHUpHxWw0SnLg1/PQ304f
	 EeqZdQsvUKqAsJTpN0215n6xGpM2870th+xYm+GIQkusaJnWW4UQnyJ/Sf+qH2P/kj
	 8zV6Ywv0x9czAEPJeAPpxJabrc7Jww8cUUmt029hm5BwlgrRKQesR3Mz/NEFGczJw7
	 sRnPPhjW9Xp6/E29iQkwNUH9h3ggTjIjJC+tiR5p91rfM5eT/S4HkVUcbiweyTTdQl
	 ZNyMNVqXjJSWjndgilKfGko+bE5UTrgTcs6xJDYAOF/jA4QsqMp1COULzD/n8fmFaO
	 JNcKRRr+PL0yA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/8] kprobes: Fix double free and NULL deref in unregister_kretprobes()
Date: Wed,  4 Nov 2026 08:58:36 +0900
Message-ID: <179375031660.247640.6349602689169856649.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179375029807.247640.13024754173032838618.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
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

In unregister_kretprobes(), if __unregister_kprobe_top() returns an error
(e.g., if the kretprobe was not registered or was already unregistered),
rethook_free(rps[i]->rh) or rcu_assign_pointer(rps[i]->rph->rp, NULL) is
still executed. For rethook-based kretprobes, calling rethook_free() on an
already-freed rethook causes a double-free / list corruption in RCU. For
legacy kretprobes, rps[i]->rph is NULL after previous cleanup, resulting
in a NULL pointer dereference.

Skip rethook_free() and rph cleanup if __unregister_kprobe_top() fails,
and clear rps[i]->rh after synchronize_rcu() has waited for in-flight
pre_handler_kretprobe() invocations to complete.

Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 10946658bb35..7a3da809bac7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2605,8 +2605,10 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	for (i = 0; i < num; i++) {
 		guard(mutex)(&kprobe_mutex);
 
-		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
+		if (__unregister_kprobe_top(&rps[i]->kp) < 0) {
 			rps[i]->kp.addr = NULL;
+			continue;
+		}
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 		rethook_free(rps[i]->rh);
 #else
@@ -2618,7 +2620,9 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	for (i = 0; i < num; i++) {
 		if (rps[i]->kp.addr) {
 			__unregister_kprobe_bottom(&rps[i]->kp);
-#ifndef CONFIG_KRETPROBE_ON_RETHOOK
+#ifdef CONFIG_KRETPROBE_ON_RETHOOK
+			rps[i]->rh = NULL;
+#else
 			free_rp_inst(rps[i]);
 #endif
 		}

