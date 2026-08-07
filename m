Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3037204C;
	Fri,  7 Aug 2026 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136649; cv=none; b=BpInANTl/ZNlWzhiUg3Z0C1w1te5P9SRKedpBP742aU1hSK/A2BwdsTVy9y+ULsRJy35YYh0dN711Ktl7JliYhmJjL85G9GvXXz9GsC5A/yNCRrHPBBgczAeMwnUn38jkq/VW8++GxhboAYfh/dhy2ah3yGJEJqp9tPrME2g3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136649; c=relaxed/simple;
	bh=JLgGv+/lZ0a6PjONWxEOdCOcmg6jsnGKFagDbKouyRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jOCyONjmL10Rc73MYCfQ7dtu8lFiXmi+Nlf6hXfmR6CchUr4c6TLLe6iskd5cuIoj4SH8OwXZw1/LuoQ/KssLJE0rQhBXlKWku+XlBFaOH28Zoul18D2VmGnZhiPrjx9vqBFzeM1DTtmIrObKDEgqyS5OEo4W/K/LYg5New1S2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=2K9O9jgm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IH8QmeyW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="2K9O9jgm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IH8QmeyW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 299BFEC00B5;
	Fri,  7 Aug 2026 17:04:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 07 Aug 2026 17:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1786136645; x=1786223045; bh=ek
	ynGHeayKilMRgRQc2c2kmLYN7Rz66dAzJEnRIE9ME=; b=2K9O9jgmbbYOksv5xk
	MDCs0HrMGHUo205w5a8cfCtPMd3JPxh5n5SZCRh7O+58SwOz8xEKcRN4cXk9tyBN
	FNCNpGiHNOFslpxULabebVidvOEonu+igCclQ5ns8UX9loHVuOP596EcFXbj54YQ
	RWDVpk/b6YySE9fQ2gmjCSQFIsFqRXddnnnP8QI6UZLjVsflRKOUzHTjY74LVRJK
	PL3EJ3xD3CVjtee3GeomWre5Y1gG6+BvEbkjq72lgeGxMMm5RESuuNJ10tUkQ55S
	Rj0vW+00LDcWTvjvcEwm14dzta6dgh09lfF3THhLUEWAkIreT4WzhpZ25vW+9xmr
	LfXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786136645; x=1786223045; bh=ekynGHeayKilMRgRQc2c2kmLYN7R
	z66dAzJEnRIE9ME=; b=IH8QmeyWZpi/jbDUd7cQCv0Duj22NnGXsPet0iqX4LaD
	DyaWRRib42uT/uYUg/dToYcba9i/UTGLJY6fxBbcI+3Wj2WKAOLtOvvDuERVRUTe
	orw6QYJNreO2pIIDhDLI6lNZbPRdiSSJVrJykvEt52JOBUzyq/CnVfcwumYmcdcE
	YftA5QTOdVUZlV8TsA6E+qshGwKEmKcj4UnRikQnA+TmrLozhBVZGCasapP5kyEE
	fYpR40S++U+z1PtYv7duQq50mGuPpLvGkMp/KsfWlc6D1a4uQJV7+1mJgp+M5zpg
	yalnhMJYbxKlZmiI5K6adHOaOve1MjTZrOsEQrdQ5Q==
X-ME-Sender: <xms:REh2alOUtb6_OGDoaS2zMGC4Ipasngpxw6zeLm08H0StyTLdrc4DyA>
    <xme:REh2alzHNua1pVqqvhrxDQcIWPXZeJJ8eY8xIUeO5aDFNmxYJH0rYHfsOiThma_Mm
    BGjvr1XUpOrhO7pDbVtDcA0-UBXihU_qBM855xN7usqSZGwZDOG4JI>
X-ME-Received: <xmr:REh2auu_gHrcXKT3QLo9OBj5JMFwDULfkL6bM2mr48_fgV1Ha5ilyGBylop0s8Gr9J0V9_ph>
X-ME-Proxy-Cause: dmFkZTGzUib+ZqcW06o+q3+RWkByAHj1v/ep/bY16CKX4FMaTMGm2f/qjd9AwJB75THpIc
    HbuEo+MJG8ZnFou3H+iNEC41+Za7yzMbwpDLuXhmRm1j+fwMSJIy+0gbmwz3WUUkQKXXB2
    2/W6i5wdWpi5B9UdgjTqujvsmLK3i0PyUptwwkFTuR6Mb31kaWtCHF3Frfe6JHL4uzgboE
    ENM+s1IdprUPDN3g38sGqPpc7oofHIiF5deJeiWOXtezHGm1++/KCBi/KHWrkjaIgaVIyS
    IfqKVN5+VJcZtzqY+HOdZQbNqc0VhpqtKuBOUf6G8rZylpp9CKIC31AuJB9n5GN+UPKmQ3
    eFv4hpmN6FS4yvitEnjg9MP+pOoMmekgSLjLR3E912yb3/4KGpo8qnd2RFzA2ftxcZlevp
    eO70ZI1rymCu/lQsVtIgQhjzZmOH47S7Ex7z3xYZAF15Py893qKSjraaAI7RBEkiDjcsgM
    QuSR98a1zyRXEO4jqSg55DVdyImYq6fbGPEmjPWlZ6baaj0qNO4rnxP56eOlA8QthRB0Dp
    TxOQ34+cceEtW7b2LuK9pOspqRIxdmvIjLvFwo8WYur5wPxVABHYgY7YSLpGCSUcOVrcv7
    DCjsiD+2LEyjr1QPA91Fkz+daWHCl4UheLR/6cKsqHOzFrJU+gj6242n+yTQ
X-ME-Proxy: <xmx:RUh2au4medpHsIQI5SkLwrh38_OF1949yGqlOKLIRFPtINqdpUp1Zw>
    <xmx:RUh2atR64q32GEGwj9ZJLzqOMPWbiFbZe7Jkur-7a99rVWVyArJEMA>
    <xmx:RUh2atqqZbJbmAzAqWBnelK7_8nKNKLE-Z7ChwwOyPbrm8oNtfUjKg>
    <xmx:RUh2arIt1Hw7WFOX9JTlm96i9E8dTyCX0qVILeacS-Mhq9jrh5QrDg>
    <xmx:RUh2au-D6SJnob1Vc9okCBnITzqst8j2e8IxwWfGgFLbVwWKdozYuFvV>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 17:04:04 -0400 (EDT)
Date: Fri, 7 Aug 2026 17:04:08 -0400
From: Steven Rostedt <steven@rostedt.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] eventfs: Use children field for rcu head and add memory
 barriers
Message-ID: <20260807170408.2d324df5@gandalf.local.home>
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

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 24 ++++++++++++++++++++++++
 fs/tracefs/internal.h    |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..677c39b0d62f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -124,6 +124,16 @@ static inline void put_ei(struct eventfs_inode *ei)
 static inline void free_ei(struct eventfs_inode *ei)
 {
 	if (ei) {
+		WARN_ON_ONCE(!list_empty(&ei->children));
+		/*
+		 * The ei should have no children if it is being freed.
+		 * The SRCU iteration has a smp_rmb() to make sure it
+		 * sees a child (that may have already been freed)
+		 * before it reads is_free. If is_free is set, it must
+		 * not use the child it acquired from ei->children, as
+		 * the list may be used for SRCU.
+		 */
+		smp_wmb();
 		ei->is_freed = 1;
 		put_ei(ei);
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

