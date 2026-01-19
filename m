Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7627F756
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856494; cv=none; b=A2p2fNERV5xHfOUoNLH+3W1PWMil3VMG+9w5r6eitZwr38j7z1HBMvPHlQ0Wwghj7ThKH/+4E2T9FjIAeLXagarR7MxZylnJr2my15DkHZ4hinD3ZOQMkP7gAMaykeA8URbvlFoyI7fZq1cbWB7VZR4HEXCPtCOJqlo7v1tyjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856494; c=relaxed/simple;
	bh=pW65pJ3HZRQGJKGr2pCi9tYX8rTKrrz+q8humsAMrA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEBzl7Xme1Y6R8bPTna2eYjD/Vd3rKR6qXeqpRD0TzBUex2asO4QXl1cVqd/NeXPKsxL536EVG37NkuNXm4Z2zCPTw3YYzb9paLulpO/wlXSNqS9aQcx9LvAf5dDQwNuYtn1zxGCrrSKXHTOqBCKtZef5z43v/Q6NlfYO7kBFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLUN2C/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLUN2C/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XERC8Z3HUdi/lg0y+Jk/anNqkNoun9YsdNJdLNhv39g=;
	b=VLUN2C/6nnNuMi0Md1h4e+vsvvxqbcgaa/W5xJE7cY8GqePcxoUuV2BQ7BhUWnmag6k7IW
	M9MxVDlbkn9z6GUQT7m8v+UFH06GNVUooJh9z2Z5AZ0Xy/bP4rWE1aSfvrDifefGZ005gS
	qVORwLXS8x2NeQV0M/ioRhxFNGsFvYs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-P9elRolsMQyGYWDwqm3Jxw-1; Mon,
 19 Jan 2026 16:01:30 -0500
X-MC-Unique: P9elRolsMQyGYWDwqm3Jxw-1
X-Mimecast-MFC-AGG-ID: P9elRolsMQyGYWDwqm3Jxw_1768856489
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 545A71800378;
	Mon, 19 Jan 2026 21:01:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80BF619560AB;
	Mon, 19 Jan 2026 21:01:26 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 07/26] rv/rvgen: replace __contains__() with in operator
Date: Mon, 19 Jan 2026 17:45:43 -0300
Message-ID: <20260119205601.105821-8-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace the direct call to the __contains__() dunder method with the
idiomatic in operator in the dot2c module. The previous implementation
explicitly called the __contains__() method to check for membership in
the final_states collection, which is not the recommended Python
style.

Python provides the in operator as the proper way to test membership,
which internally calls the __contains__() method. Directly calling
dunder methods bypasses Python's abstraction layer and reduces code
readability. Using the in operator makes the code more natural and
familiar to Python developers while maintaining identical functionality.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index b9a2c009a9246..c97bb9466af6d 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -207,7 +207,7 @@ class Dot2c(Automata):
             else:
                 first = False
 
-            if self.final_states.__contains__(state):
+            if state in self.final_states:
                 line = line + '1'
             else:
                 line = line + '0'
-- 
2.52.0

