Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750329;
	b=PirJAPYkeeYMfzIW4/ZbzKwI6sVdBdbGo99ktnXmYQcFzvsSHSTUiunfireEmvKlvbwf
	 kQNyZP59sKhEajT2w17DgsFTm4ke+j9wqcOuBXt2fE8V7bBVr8kRWG2hOnh56CahOES5d
	 05RPctvJ77m01vuwT3VJHJEhOj4qPLi502rfj5mEgH/kYsDkkXsmoUhkjHlOOlxABYWhD
	 Vd6tSUEQK0+L+GZGBEajIH0z75gOcSZ6z8smbW0aNoU7sqlV+KHxbQEK66al0JJ0HYww2
	 AcS/IVEzHnshF099blVAiiwVDv9nMwnao95OtJzB2qgAmU+cA5SLaQ3JjCAFaYEG+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qd2iCywGDpitsLzlhl91Kh3S1izNYB4FIjR0QAkR6OM=;
	b=x6+OptgTDXaAWjmNg0jFbkBYdlbHx/CYaCd4MzbFiawpwuWHXMR+tSJiyn9NiN4UlKWg
	 CsXoam6Xjm6OkCHawq4+ohzBmcX4IqSobpIexxZ5n8h8lYg5lvfqkrdnQT+jhbXMlOn5O
	 Tffi8lhLlzZU3WFmBglgbQfe4p4fqmSYUgpvXxM7oXYGMSTIG81sZWuNzuRs9u05HBBUa
	 RuqxyXKlxIAwYdHTTPgqWEJ8rayBT75LV//ildf4LliNLy2hcR88gYqN9R/unk6Yg1FK8
	 NJVQIbJZNJ3A3yuowUv5d+ziYriFx9et/VfXBlf30kQ2S1H7Iv0sCVVTW70uii/LkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhBUsDMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AB606A326;
	Tue,  3 Nov 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhBUsDMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9721F000C1;
	Tue,  3 Nov 2026 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750329;
	bh=qd2iCywGDpitsLzlhl91Kh3S1izNYB4FIjR0QAkR6OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EhBUsDMhsa1O0m/abhC6OcAsCiibPfx9u3P5yikF8HpmVV1Rd6bputtpLqUGUxTwD
	 UUUUDJUjYYvtjKoyXTD70Wnic8te18hNuve6Ruts7t86VUlH412+nnCFuWYcSYMKA7
	 +Nk6sPE2v3Ae2t1nC8MGWaeAu5OU52rMq7nXJaAGQpkM3uBiEDjcbqZ0zm5CQ71psR
	 AayekDTIlNVEbliX0wjn3YhIhGPoH67mTitO/sMRM5W4GRuOEAIxWJcCUua0/rP5Bz
	 iXMOMk0KRRmsiZmrL5cF1yRNYIUfk07QPvnvBJekGu/ejHILuzw4f1wPq8qyAHoEHu
	 ULKMSU1g1H9Gw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/8] kprobes: Validate re-registration earlier in register_kretprobe()
Date: Wed,  4 Nov 2026 08:58:45 +0900
Message-ID: <179375032568.247640.17429793187163536192.stgit@devnote2>
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

register_kretprobe() only checked for re-registration if rp->kp.addr was
specified, skipping the check when rp was registered with symbol_name
and rp->kp.addr was NULL. In that scenario, register_kretprobe()
proceeded to allocate a new rethook (or kretprobe holder), and when
register_kprobe(&rp->kp) subsequently failed due to re-registration, the
error path freed and NULL-ed rp->rh (or rp->rph) on the still-active
kretprobe, leading to NULL pointer dereferences when the active probe
was hit.

Resolve the target address via _kprobe_addr() up-front and check whether
the probe is already registered at that address via
check_kprobe_rereg_at() before allocating any resources, and drop the
WARN_ON_ONCE() in the re-registration check now that re-registration is
gracefully detected and rejected.

Fixes: 0188b87899ff ("kretprobe: Avoid re-registration of the same kretprobe earlier")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   72 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 7a3da809bac7..0b41d69540ae 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1793,52 +1793,61 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	return addr;
 }
 
-static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
-{
-	bool on_func_entry;
-
-	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
-}
-
 /*
  * Check the 'p' is valid and return the aggregator kprobe
  * at the same address.
  */
-static struct kprobe *__get_valid_kprobe(struct kprobe *p)
+static struct kprobe *__get_valid_kprobe_at(struct kprobe *p, kprobe_opcode_t *addr)
 {
+	struct hlist_head *head;
 	struct kprobe *ap, *list_p;
 
 	lockdep_assert_held(&kprobe_mutex);
 
-	ap = get_kprobe(p->addr);
-	if (unlikely(!ap))
+	if (unlikely(!addr))
 		return NULL;
 
-	if (p == ap)
-		return ap;
-
-	list_for_each_entry(list_p, &ap->list, list)
-		if (list_p == p)
-		/* kprobe p is a valid probe */
+	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
+	hlist_for_each_entry_rcu(ap, head, hlist,
+				 lockdep_is_held(&kprobe_mutex)) {
+		if (ap == p) {
+			p->addr = addr;
 			return ap;
+		}
+		if (ap->addr == addr && kprobe_aggrprobe(ap)) {
+			list_for_each_entry(list_p, &ap->list, list) {
+				if (list_p == p) {
+					p->addr = addr;
+					return ap;
+				}
+			}
+		}
+	}
 
 	return NULL;
 }
 
-/*
- * Warn and return error if the kprobe is being re-registered since
- * there must be a software bug.
- */
-static inline int warn_kprobe_rereg(struct kprobe *p)
+static inline struct kprobe *__get_valid_kprobe(struct kprobe *p)
+{
+	return __get_valid_kprobe_at(p, p->addr);
+}
+
+/* Return error if the kprobe is being re-registered */
+static inline int check_kprobe_rereg_at(struct kprobe *p, kprobe_opcode_t *addr)
 {
 	guard(mutex)(&kprobe_mutex);
 
-	if (WARN_ON_ONCE(__get_valid_kprobe(p)))
+	if (__get_valid_kprobe_at(p, addr))
 		return -EINVAL;
 
 	return 0;
 }
 
+static inline int check_kprobe_rereg(struct kprobe *p)
+{
+	return check_kprobe_rereg_at(p, p->addr);
+}
+
 static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
@@ -1969,7 +1978,7 @@ int register_kprobe(struct kprobe *p)
 		return PTR_ERR(addr);
 	p->addr = addr;
 
-	ret = warn_kprobe_rereg(p);
+	ret = check_kprobe_rereg(p);
 	if (ret)
 		return ret;
 
@@ -2505,20 +2514,19 @@ int register_kretprobe(struct kretprobe *rp)
 	int ret;
 	int i;
 	void *addr;
+	bool on_func_entry;
 
-	ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
-	if (ret)
-		return ret;
+	addr = _kprobe_addr(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset, &on_func_entry);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
-	/* If only 'rp->kp.addr' is specified, check reregistering kprobes */
-	if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
+	if (!on_func_entry)
 		return -EINVAL;
 
-	if (kretprobe_blacklist_size) {
-		addr = kprobe_addr(&rp->kp);
-		if (IS_ERR(addr))
-			return PTR_ERR(addr);
+	if (check_kprobe_rereg_at(&rp->kp, addr))
+		return -EINVAL;
 
+	if (kretprobe_blacklist_size) {
 		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
 			if (kretprobe_blacklist[i].addr == addr)
 				return -EINVAL;

