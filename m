Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F82C0F93;
	Sat,  8 Aug 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149881; cv=none; b=P3KNlN7eYyOfCl+KwUbiHAeqQPsGb9cBbKzeILMhvJIWOG6ERFRBuV9vh5YjIONZ/xCKnOpTxD715d1nwTGdKfOqFq76hCHblcTVYCexuE+pnOpt+l5dfyc58cJJs9xfx4xxX2/8uYGjo1MVcxiRw2O3J2NXC3oL7x0LCAxxGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149881; c=relaxed/simple;
	bh=NVt6LZTcraoSfFqp+02c3N3zHk/htmnudH7UuYizWHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SkuoSCDf/Cyqm/q1hCTrcdDPLpnGG6cjX1iyPjav8p7MCdfrwAvpPRpIwXmb9uTkxmcdCCDcbS3c/St7ykNFWbIEEzn9L84uHXvFXJjJ6OsKTPex2pWtPVfoUfQVqL0uLMLyKBwMaNB6RmaM747iEYUxszKrZ+TDQ5sf+z12TFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=uuLOihL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V8hd5+Kl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="uuLOihL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V8hd5+Kl"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 134591400128;
	Fri,  7 Aug 2026 20:44:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Aug 2026 20:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1786149878; x=1786236278; bh=A4
	tml5VsplrVAaUZ4iBW70/uug6/4mWsPU5I3LeKWEs=; b=uuLOihL2bGfZwL7vFx
	Nbp7DN09/8ZNVj2XtVUfMMZQdxUna5QKIGl+SANcaf9XXyiqzzNIkJJdVMfxaZjq
	cmoL2AMdWLvgU6uvUaNUMJQu+7zaDu6Lqfx+PmPm5o0tkLxzCjEspHx9kUi2scrb
	O64/YklXYgOypwaKBb5NCU9nMwfV+sSzWZ/IM1Vdn0uUKnkMBaOl66Y9i097S6wN
	kqr4P4PfUXR5VJs2C7sJihLip1/6LJAxvwTp/Qxq83hXJ+W6bwvZHhpaxdRyLaTq
	SdE20VsmaASd35bQQBEvijqFIbVZsBnuN/DNl4P0/+zGv4kku9h/mWunQR0tEgvb
	yO6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786149878; x=1786236278; bh=A4tml5VsplrVAaUZ4iBW70/uug6/
	4mWsPU5I3LeKWEs=; b=V8hd5+KleljlhfcqUZqhvdnyXfOWw6+lHT8/F+rpVFc2
	Lp5N3JZ8ydtQzd1hKm+7nZtFU2pKbGrbgBXRCZbUhR+D4pjBhs9cMqwH0Xy1cbXK
	xAqt4WW0fxFseqUdzahBvouCU7OoY6obrOb7LFBEjvPQnznh3vV9GuPx+kNJcxLI
	rTy+P0NfHHbEM5nZ1T/LU5XRCMBISO43Gylh7RwxAIJ2wVMi38txGDCcg/iwO1TS
	M3ztDqUUYoEqxVrrx4rS89uWiI4xogIk9sGqgjrWQTw1eAJ2OECIyFrUUoThm834
	Gds+7bAU0crHNbpNr21+XTDjxtuxmQXkamI/CHzygQ==
X-ME-Sender: <xms:9Xt2aqifRzXxUeHP1NT7kGPSwX1UXMA2VoI1s2EqNr9SIamnQkAy4g>
    <xme:9Xt2ao3478A1q010AgUpk-x_VRiFUTS3G7dSnDcJE66x2jf_XH1RKmzxfwGUYYTb-
    7EscPgweU9imuN3aIgXaKr_9KSRrX5c-2d1QlOE0r4qcqOSjvgYI6o6>
X-ME-Received: <xmr:9Xt2asi3uNQXO8syFRci2eOh-sREsl8oYiG7BZdoSJK4jYcJpVTQNL_jVItHIR7ZnMYig_iP>
X-ME-Proxy-Cause: dmFkZTFN4P37v1lyJv4q4MMHb6Y7Fl+huj4fb5+IgGLhdWTlHowF0MRqnYi0oXl7fNKZYd
    9WJzROIe0tccN5lxRwLK+ef74QLvOd7Y3mlJjbuesdN3hFI50rXg2HeNVnhubTk6hMsa0c
    k9V4Wb9mgBtKOnrADfkIzSSaKe/+FkDRJSMJ2MUoW3WhxSIf6cXVrChqsZEhYlaxtkfS60
    dqZ0t/jFAurscjITByvu+3L+ZOz7vvX4WlsHXfQsUvijR1Lcxcmd7BFBfnBBqrmOmp4rU9
    o1638/+TyFhDl0wI1Gqpj3RWHwGS8AzsnlyrhSazWm94VjLVqtaagsSgvAX42PfxxMAmHC
    UvqwvJf88gKuQ3wCIgsj9PNFvyec6kIXFGFttfa8kqqx0+kFR6ReF05+qB5weiY4QUQ0CF
    EjIarrg9KZH+WjgK8Afsy9GAXMBQB8aoCMCxgn1j58g/ZYhyDxBSu6o1Tsy87Ar2SJAiz0
    4f/FFRrpa1jmM3//mCM/mbE9egCkVM5i4YJeUXIa2JRMZWpL0QPXnvJowrWsGsPpJONQUH
    un1SK/KP/5UZJP4X8rx5dpJSrxBTbLdMLCrXoArVOwdIiwKsh5fIG7jv864ZEn2xBC3w2M
    Tz+MgBhW96LOrRyKPD0SCZxm+fBaVT+VDeXqR6lUNwZhK6IN2NE9bwpmq0Bg
X-ME-Proxy: <xmx:9Xt2agc-urLa99hFG9NK4L8_0F0CtaroA6w3W1WqmKHlEIGwL45icw>
    <xmx:9Xt2annGZTVb_EJwOEk9qUH2yC3cf-uDlkikgEKohl9Vc5nV1RjB2g>
    <xmx:9Xt2ahseXy1PB5qXBN_Y4hhnLYtPuWhva8IywWYT-Fk2l1SD84kPHQ>
    <xmx:9Xt2al-mgpSt2sLDRYdsmwR54NIUQoxtSSZ75uYej88X3-x_fIxNpQ>
    <xmx:9nt2aoz_FgOhYSzhlt-UZ_lyKuRWJU2h5TU1D7iOy1iUHji-ELIp_Z3h>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 20:44:37 -0400 (EDT)
Date: Fri, 7 Aug 2026 20:44:41 -0400
From: Steven Rostedt <steven@rostedt.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] eventfs: Use children field for rcu head and add memory
 barriers
Message-ID: <20260807204441.75a7db89@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

When an eventfs inode is freed, it sets ei->is_freed and then uses its
ei->list to add it to the srcu link list as the list field is a union with
the rcu list head. As the ei->list is used to iterate over an SRCU
protected list without taking the eventfs_mutex, there's nothing stopping
the iteration over that list to see the ei->rcu instead of the ei->list
and it will read a corrupt target.

To fix this, change the union of the rcu list head with the children list.
On freeing the eventfs inode, set the is_free and execute a smp_wmb()
before adding the eventfs inode to the SRCU list.

On iteration of the ei->children list, at the start, execute a smp_rmb()
and then read the is_freed of the ei to see if the children list is still
valid. If is_freed is set, then the ei_child read is not valid and the
loop should exit immediately.

Cc: stable@vger.kernel.org
Fixes: 704f960dbee2f ("eventfs: Read ei->entries before ei->children in eventfs_iterate()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260807170408.2d324df5@gandalf.local.home

- Fixed placement of smp_wmb() and is_free (Reported by Sashiko)

 fs/tracefs/event_inode.c | 24 ++++++++++++++++++++++++
 fs/tracefs/internal.h    |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..7d2431f2bb08 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -124,7 +124,17 @@ static inline void put_ei(struct eventfs_inode *ei)
 static inline void free_ei(struct eventfs_inode *ei)
 {
 	if (ei) {
+		/* The ei should have no children if it is being freed. */
+		WARN_ON_ONCE(!list_empty(&ei->children));
 		ei->is_freed = 1;
+		/*
+		 * The SRCU iteration has a smp_rmb() to make sure it
+		 * sees a child (that may have already been freed)
+		 * before it reads is_free. If is_free is set, it must
+		 * not use the child it acquired from ei->children, as
+		 * the list may be used for SRCU.
+		 */
+		smp_wmb();
 		put_ei(ei);
 	}
 }
@@ -627,6 +637,20 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 
+		/*
+		 * If the ei is being freed, then the ei->children may be
+		 * being used as the rcu list, which means the next element
+		 * may be garbage. The ei->is_free is set before switching
+		 * the ei->children over to ei->rcu. The read memory barrier
+		 * here makes sure the ei_child is read before is_free is
+		 * updated.
+		 *
+		 * Matches the smp_wmb() in put_ei()
+		 */
+		smp_rmb();
+		if (ei->is_freed)
+			return -EINVAL;
+
 		if (c > 0) {
 			c--;
 			continue;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index a4a7f8431aff..c61481d04c8e 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -46,11 +46,11 @@ struct eventfs_attr {
  * @ino:	The saved inode number
  */
 struct eventfs_inode {
+	struct list_head	list;
 	union {
-		struct list_head	list;
+		struct list_head	children;
 		struct rcu_head		rcu;
 	};
-	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
 	struct eventfs_attr		*entry_attrs;
-- 
2.53.0

