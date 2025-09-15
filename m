Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980C277CB6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959890; cv=none; b=jUP5f4Pb9wgBo2nJe04xQD8wSanZkjZYx+Ix/punLoNRMk3x1vkOxi/BoW6BwWGhwxqj3xLdZLM6wU5J8zEUmeR0xL6xUzvZBzUm5QRrYHesbdKN3a45Xf4gVhEHdKJlTXizFXOFY97QIJ8ebpkXWi9LuAgg6LknVeGCLb7d3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959890; c=relaxed/simple;
	bh=6dFtb8yo/nR+HTajXe+JuuMFZObEuhhvoeynjMd7ric=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHH/JbC6E8wSFl3fo0+cB0oJAdDOqqOy5W+0uvPerZneBeonZck+pwAYVyLU5LOwld7cfCrJHSiUWWXZlPfMWfKihLysI5gr1dKKjGo+OCEu0dwHMJJbWi2hHgwOkRLeDXU9kseuWL0emXgrK4KZ6/5mu6izSjMNjgLpSEjrfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHPNEClP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHPNEClP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757959888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7fFNoSRHvuFMJms0AIALGkDq10Nure1Vnt0hWVWqrOQ=;
	b=iHPNEClPGInd5lo0NzuJXOt19HL24DNGy+nlxZlM8+ypVGNU9PrFOtJ3r5v5Oy2i3dn/MO
	ggKH/XSKlm5h1T2+6Sl6pJgqAfYVpBqAsrbt3kSMT+UAEtoHQTpdrf1rZaSXJLmc+4EShH
	OJFGfrDUM+0us6oaPPjqukZMq8qcB2M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-vlJ8GwEINyauPTlGxzVjOg-1; Mon,
 15 Sep 2025 14:11:26 -0400
X-MC-Unique: vlJ8GwEINyauPTlGxzVjOg-1
X-Mimecast-MFC-AGG-ID: vlJ8GwEINyauPTlGxzVjOg_1757959885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81C161955E9A;
	Mon, 15 Sep 2025 18:11:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCF4E18004D8;
	Mon, 15 Sep 2025 18:11:20 +0000 (UTC)
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
Subject: [PATCH v2] rtla/actions: Fix condition for buffer reallocation
Date: Mon, 15 Sep 2025 15:10:56 -0300
Message-ID: <20250915181101.52513-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The condition to check if the actions buffer needs to be resized was
incorrect. The check `self->size >= self->len` would evaluate to
true on almost every call to `actions_new()`, causing the buffer to
be reallocated unnecessarily each time an action was added.

Fix the condition to `self->len >= self.size`, ensuring
that the buffer is only resized when it is actually full.

Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>

---
v1 -> v2
* Put the commit message in imperative language

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

