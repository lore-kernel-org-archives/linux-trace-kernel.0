Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8030AAC8;
	Fri, 21 Nov 2025 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763556; cv=none; b=hvDVMyTMClVEwhowOYdUsViASiFk3DoiDRYOSDH8IJXj5DdNGMw5nZmLsNP7BdtCRRQO0DnV5M4QqelXYoVBb2qCr8d/fcZNOgglbSmYUYXbk4t5e8Hf4CPnl4/TfMEYGpvMB9wyVmNIfoHJvYwgWln8Sbysc1Z2MG1fhatFFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763556; c=relaxed/simple;
	bh=vysL4A2wq6r6gVrU9avlkmBtdz64TCRhvXXMAE1N8vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9t1yYQ3czxqfnwdVOTok8NDK2vPyGzcCp5Kb7/v/TTdtMkSco5ZlTD9UlNh1vZjEcjiE5ITGf9rZmUmzlJ8rxhbejWNRMA6YUrvX0PAY7Hpo8qjfJaToDJlOFxsoUvudc9QvO63d1sKi45cK/NPtQieM7QgUR0ayeU3ySgARg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YbCbtqe7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R5xQaRpF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YbCbtqe7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R5xQaRpF"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dCqPr0Tc8z9tjt;
	Fri, 21 Nov 2025 23:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ipaajx5Ok4/jMQtIcRVvEE0OnDZrqJN9kw4rvFB6jh0=;
	b=YbCbtqe72/2WmgtFLbDwpZotLecrpMCOEuZZdSpodH9JMYF83shpHiHC4xOilrY1EzdCZD
	y+u44apTRXPhSYvG+qrlPpwvC8/naUigziYnqH9YlvAlXmqp8qEOK5KyWCfhHqEXXug6Sy
	PjdLE9xveEW1S/PpQuM9RhSgoPifuderlNAvo3YcHuzoH13QR4GQKpzevcoNkV2YQ4eSqP
	kraAMR+hONoPzAmBu/QVmllV/ZxqOQItLNM5gfA8TKxWrWnxDGpDdEXa+1ubzoBt0+2l+4
	qwHMlMQPkjj5EdlS3BdR2IbfcltN3AyAbwd1sivRRPNXzfNWlKnro3C3A58QHQ==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ipaajx5Ok4/jMQtIcRVvEE0OnDZrqJN9kw4rvFB6jh0=;
	b=R5xQaRpFdzCq1SrlqycntIoJlLaeY8vOgOK4oVvZWi/TXkZQqLV92rw91KxuX3YrOq6r4+
	q6RfERdpLj5IiiWUvPTMzvwxW8koTyBSapA2IHWnkU2LBqvO8gVk5UaJouFotltwBlHcgv
	H5WErGFdUGRCQUM9yOlO79l6qunutAo9xn14GBU9gjp7TepTRvaZPh2FCV0H/FHuAKZ08N
	Ezc1woRIy060u+0Xu1T4OeJocs7DYKLEuhl+XCsG2l+9xuBncY6I6ejv5RwZHlr3x05vv1
	HOsJhTPxRW7tHdTlNa1KWpy/KHoIq5YTxShWFtlXdgbH1lhtlB7iqRcBEAEPOw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 10/13] tracing: Fix multiple typos in trace_events_user.c
Date: Fri, 21 Nov 2025 23:18:32 +0100
Message-ID: <20251121221835.28032-12-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ossjrgfwcioonbme6nkwduwagxkk8k11
X-MBO-RS-ID: 9e254cdc71d18b9fb48

Fix multiple typos in comments:
"ambigious" -> "ambiguous"
"explictly" -> "explicitly"
"Uknown" -> "Unknown"

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_events_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c428dafe7496..778f13ef94cf 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1041,7 +1041,7 @@ static int user_field_array_size(const char *type)
 
 static int user_field_size(const char *type)
 {
-	/* long is not allowed from a user, since it's ambigious in size */
+	/* long is not allowed from a user, since it's ambiguous in size */
 	if (strcmp(type, "s64") == 0)
 		return sizeof(s64);
 	if (strcmp(type, "u64") == 0)
@@ -1079,7 +1079,7 @@ static int user_field_size(const char *type)
 	if (str_has_prefix(type, "__rel_loc "))
 		return sizeof(u32);
 
-	/* Uknown basic type, error */
+	/* Unknown basic type, error */
 	return -EINVAL;
 }
 
@@ -2475,7 +2475,7 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 	/*
 	 * Prevent users from using the same address and bit multiple times
 	 * within the same mm address space. This can cause unexpected behavior
-	 * for user processes that is far easier to debug if this is explictly
+	 * for user processes that is far easier to debug if this is explicitly
 	 * an error upon registering.
 	 */
 	if (current_user_event_enabler_exists((unsigned long)reg.enable_addr,
-- 
2.50.1

