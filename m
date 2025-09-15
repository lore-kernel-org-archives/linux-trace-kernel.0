Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8E2FFDC7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949524; cv=none; b=aiVF49/IDGa2A7Au94yUXJOT79YPMv/8isExewzU4maDUmxylPGikRrj9ikg7irXHzS7NEiYLyRaBgahiPh/RSd7I49VPTeUcKy2cyxe4nH4DdxTNW/XrjjLixA28rNG9nTJGkuVrdbSaZs+Bvc7bxDYwW+q3bHcFzyzAbRgsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949524; c=relaxed/simple;
	bh=aPik9HGsvwOsfEqdkUh++N4ffckuAtgEBjJ9fPrDnzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrDIMEi4aocVcE8HtYh8shq3gYb3cNquAFHf69etTbWJbjA9v6Dgl5A9e9O2sBKf4AuI+1wNI0hz+Lz5b3p+9z2dpElzwHQqC7bpjIevmKL8TkC49W9e2b9c0kbeIKc525dg5O2RhGU0qjrOEHjmModX6rZmWGGYe3oGPrULuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKRYysDQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKRYysDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757949521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2SqFRyWFgIYBBvhgQxkTIZmI2czJO8LiS/YZgcmme88=;
	b=HKRYysDQFr2/PbORyM2XI7NUd7BjWXSVPv3vau7781kAVMsZ3HODgY1vhaEGYInrc5Ik7t
	kr/1KPbdqy8zX8UnRSYvi1atqoG8HYW7Jt/xz3Sxz1z5dYelKUekyn44Dic4RQGT6NbEs6
	tb/L0B1pTWNOn0CFMYTz2YiH7UXkad4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-bLfS603vM3m9PSr8ETAPHQ-1; Mon,
 15 Sep 2025 11:18:37 -0400
X-MC-Unique: bLfS603vM3m9PSr8ETAPHQ-1
X-Mimecast-MFC-AGG-ID: bLfS603vM3m9PSr8ETAPHQ_1757949516
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BE591956096;
	Mon, 15 Sep 2025 15:18:36 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF1811954126;
	Mon, 15 Sep 2025 15:18:31 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list)
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rtla/actions: Fix condition for buffer reallocation
Date: Mon, 15 Sep 2025 12:18:02 -0300
Message-ID: <20250915151807.40851-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The condition to check if the actions buffer needs to be resized was
incorrect. The check `self->size >= self->len` would evaluate to
true on almost every call to `actions_new()`, causing the buffer to
be reallocated unnecessarily each time an action was added.

This patch fixes the condition to `self->len >= self.size`, ensuring
that the buffer is only resized when it is actually full.

Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d72..af5f76bd1821b 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -49,7 +49,7 @@ actions_destroy(struct actions *self)
 static struct action *
 actions_new(struct actions *self)
 {
-	if (self->size >= self->len) {
+	if (self->len >= self->size) {
 		self->size *= 2;
 		self->list = realloc(self->list, self->size * sizeof(struct action));
 	}
-- 
2.51.0

