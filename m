Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80D4594D;
	Mon,  9 Dec 2024 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712106; cv=none; b=cGonDhFiHuX6gNngjmabeRByYqeZWtpCPwZD3KDneg4bcSeLKj6titc0Q2GzWcvS6YcHT0vdDcOCjFy+PMgI+rEPtxvCSqrImQZEefSG9+titFqmmN/7nWYhswijaB3r2JV3agj0ikBJzinCKkoCyinDySLnOtAWjkf1go73FDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712106; c=relaxed/simple;
	bh=YI34RXWyW3r1EI6GTGvDFujx5+lI9n8gUg1Yl+QM0As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8rxDXW0ZpqtH4jMlK4OsO6IKoZ7XePa4RwpdM2phuMK2dTAEJ1cyZFJ2nu6ms0iC/YL0VmeYSyiQbATjPkvl2WXAP9W+lMpKZy5RWS0+KAwGQAnnn9LCIWVspN/vwm1aSWr5Z/gVK8YUwbnN1lwRNQvr+7Za9Unufh1Bjua+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFOzsvq0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFOzsvq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A92C4CED2;
	Mon,  9 Dec 2024 02:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733712106;
	bh=YI34RXWyW3r1EI6GTGvDFujx5+lI9n8gUg1Yl+QM0As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFOzsvq0FNuCaLc0pm4iTMQHmGp9Y5xR8m5Nh2vA18TFfsVgPKs7idFULlqSbJobB
	 9WAnm1hZj8DW87WNG0dgkbLwrbzCT0u8d/RXTdzw6MB0T7Q7d2VEKs3eYxAlnApn0K
	 ABoewCN4hOTP7f+OvPwtRrilCDJXDLeLthJVhvAO0SUT+DHteuC9svj40lLZLlG7ag
	 53YOyFdWr1MzxGR7WK6BtI/kZ7vioVE8lrdd/v79ciePQq4lJewtHTkqfYB2UjR7bP
	 u9PKxkbviKKecB6D1Botrj2C1Oq+22/o7y+m/EfSKuuZdONzzZ2MEo9o0X/IpPiHml
	 aGXy7PGmrXTYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/5] kprobes: Use guard for rcu_read_lock
Date: Mon,  9 Dec 2024 11:41:38 +0900
Message-ID: <173371209846.480397.3852648910271029695.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173371205755.480397.7893311565254712194.stgit@devnote2>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
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

Use guard(rcu) for rcu_read_lock so that it can remove unneeded
gotos and make it more structured.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   66 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 004eb8326520..a24587e8f91a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -144,30 +144,26 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 
 	/* Since the slot array is not protected by rcu, we need a mutex */
 	guard(mutex)(&c->mutex);
- retry:
-	rcu_read_lock();
-	list_for_each_entry_rcu(kip, &c->pages, list) {
-		if (kip->nused < slots_per_page(c)) {
-			int i;
-
-			for (i = 0; i < slots_per_page(c); i++) {
-				if (kip->slot_used[i] == SLOT_CLEAN) {
-					kip->slot_used[i] = SLOT_USED;
-					kip->nused++;
-					rcu_read_unlock();
-					return kip->insns + (i * c->insn_size);
+	do {
+		guard(rcu)();
+		list_for_each_entry_rcu(kip, &c->pages, list) {
+			if (kip->nused < slots_per_page(c)) {
+				int i;
+
+				for (i = 0; i < slots_per_page(c); i++) {
+					if (kip->slot_used[i] == SLOT_CLEAN) {
+						kip->slot_used[i] = SLOT_USED;
+						kip->nused++;
+						return kip->insns + (i * c->insn_size);
+					}
 				}
+				/* kip->nused is broken. Fix it. */
+				kip->nused = slots_per_page(c);
+				WARN_ON(1);
 			}
-			/* kip->nused is broken. Fix it. */
-			kip->nused = slots_per_page(c);
-			WARN_ON(1);
 		}
-	}
-	rcu_read_unlock();
-
 	/* If there are any garbage slots, collect it and try again. */
-	if (c->nr_garbage && collect_garbage_slots(c) == 0)
-		goto retry;
+	} while (c->nr_garbage && collect_garbage_slots(c) == 0);
 
 	/* All out of space.  Need to allocate a new page. */
 	kip = kmalloc(struct_size(kip, slot_used, slots_per_page(c)), GFP_KERNEL);
@@ -246,25 +242,35 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c)
 	return 0;
 }
 
-void __free_insn_slot(struct kprobe_insn_cache *c,
-		      kprobe_opcode_t *slot, int dirty)
+static long __find_insn_page(struct kprobe_insn_cache *c,
+	kprobe_opcode_t *slot, struct kprobe_insn_page **pkip)
 {
-	struct kprobe_insn_page *kip;
+	struct kprobe_insn_page *kip = NULL;
 	long idx;
 
-	guard(mutex)(&c->mutex);
-	rcu_read_lock();
+	guard(rcu)();
 	list_for_each_entry_rcu(kip, &c->pages, list) {
 		idx = ((long)slot - (long)kip->insns) /
 			(c->insn_size * sizeof(kprobe_opcode_t));
-		if (idx >= 0 && idx < slots_per_page(c))
-			goto out;
+		if (idx >= 0 && idx < slots_per_page(c)) {
+			*pkip = kip;
+			return idx;
+		}
 	}
 	/* Could not find this slot. */
 	WARN_ON(1);
-	kip = NULL;
-out:
-	rcu_read_unlock();
+	*pkip = NULL;
+	return -1;
+}
+
+void __free_insn_slot(struct kprobe_insn_cache *c,
+		      kprobe_opcode_t *slot, int dirty)
+{
+	struct kprobe_insn_page *kip = NULL;
+	long idx;
+
+	guard(mutex)(&c->mutex);
+	idx = __find_insn_page(c, slot, &kip);
 	/* Mark and sweep: this may sleep */
 	if (kip) {
 		/* Check double free */

