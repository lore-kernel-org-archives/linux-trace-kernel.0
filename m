Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291833C536
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405852; cv=none; b=XLlvDbAf2sitTpWLJc8wQyB55eODl39oimuP7IOWfeidFTHeuLZT/jFF58QaFYQcx3+AvATH713lmNhAO+asYWbsh+ldWAqJ012WAnU14Rt+cYjfkBOEIdDXTj66s4YkRCtw7iXer+YuGKBqogSX6mRHEEq6Do2lRbAs45yEar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405852; c=relaxed/simple;
	bh=bD12Zma+HqAn33iDOUsFKDSv5z71KSEUkEEij0/v2hg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI9Y2+F7Ye8och49Zf3N3i6IorZrzWlskugsNs0FHePBFMQcCuevZUxYIDqHk3I2qJ53p+f1j/Auu62R8/EKHV1lfsZQFundo0T5kNxLohaBv1lSD1bDJuVG1J0AMLCNc9UDZTuEH6sOg1VPAj6E1DJXC4r10T+a0D0dzmcM7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1V8jRIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1V8jRIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJgzWUqlEf8G/5190vKWYurdG9FvRAIrgrn7gi1E2RQ=;
	b=d1V8jRIwiSffn9wR11QT75XAY9V6UDdduJ6KLsD48yxywbJgWLMXMZVRf2vqjVO+Sy8mBe
	Fz8m5PgKiG7FLB+3JLfh3kW3CmxO9HnDfhjHX1YTVmnP4mMVHb7dkT5wHdXUjXS45VNE1/
	hDbuVWdptmkCEvhInfl14gzKQHiObBU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-k3ENyNDvN7KLae-DJ5KLZg-1; Mon,
 17 Nov 2025 13:57:27 -0500
X-MC-Unique: k3ENyNDvN7KLae-DJ5KLZg-1
X-Mimecast-MFC-AGG-ID: k3ENyNDvN7KLae-DJ5KLZg_1763405846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E867E1956069;
	Mon, 17 Nov 2025 18:57:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1255180049F;
	Mon, 17 Nov 2025 18:57:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 13/13] rtla: Fix inconsistent state in actions_add_* functions
Date: Mon, 17 Nov 2025 15:41:20 -0300
Message-ID: <20251117184409.42831-14-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The actions_add_trace_output() and actions_add_shell() functions
leave the action list in an inconsistent state when strdup() fails.
The actions_new() function increments self->len before returning a
pointer to the new action slot, but if the subsequent strdup()
allocation fails, the function returns an error without decrementing
self->len back.

This leaves an action object in an invalid state within the list.
When actions_destroy() or other functions iterate over the list
using for_each_action(), they will access this invalid entry with
uninitialized fields, potentially leading to undefined behavior.

Fix this by decrementing self->len when strdup() fails, effectively
returning the allocated slot back to the pool and maintaining list
consistency even when memory allocation fails.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 2d153d5efdea2..4aaaedadcc42a 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -76,11 +76,13 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 	if (!action)
 		return -1;
 
-	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
 	action->trace_output = strdup(trace_output);
-	if (!action->trace_output)
+	if (!action->trace_output) {
+		self->len--; // return the action object to the pool
 		return -1;
+	}
+	self->present[ACTION_TRACE_OUTPUT] = true;
 
 	return 0;
 }
@@ -115,11 +117,13 @@ actions_add_shell(struct actions *self, const char *command)
 	if (!action)
 		return -1;
 
-	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
 	action->command = strdup(command);
-	if (!action->command)
+	if (!action->command) {
+		self->len--;
 		return -1;
+	}
+	self->present[ACTION_SHELL] = true;
 
 	return 0;
 }
-- 
2.51.1

