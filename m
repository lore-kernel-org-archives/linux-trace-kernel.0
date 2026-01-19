Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87492F547D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856595; cv=none; b=Nz9KNoEpkQRhZXg3oSznnKULwTqYGarAeOn3ywUmMZwfkH5A/wOdOcVC7Vt9Zw6vlgAftXiZN0AgfqeEkf6cMZ8wU3hHUBaoJmpiRZjkw04HE7y/9GK3zlnelS/ucLOjqP1CNgLNc6HMtHaHRWy1vExY8TIOIFWikqjU1smS9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856595; c=relaxed/simple;
	bh=Jv5+K98VizUM1mXRwDMUfBAd5yY4osV4n8dduP0Gjzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiUzGUxRqqFhfAMkSVXjPD8tXsufCEbqnoFAIEy/BTIVI2M/V9XUYKq0y+6tW7gsN66pxqQn9/AQPaKBpXkM4x9svOnlARa1IIz1br79xRpwpDBpOA+svtJ3XNiRZe6S2N0NljpXiyaOcHsOsm2p9E1xgkpSAOPjRcdp7HNMb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Se0Drxwu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se0Drxwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZA8TdjTDpZCZzwuKRz2gWQ7ez/p2MAQq/3Y4NoDfsuY=;
	b=Se0DrxwurE5qjwPBOOGUWH/8vZVwZFbvjWeN+HFGHVDtfnuZDaVRPcIqWkWfmFoJmk9Yuc
	OXdYy49lWEBH8ghuLQFOFM3w7a9sgvq+y9xGikCmsAM4h9feiroqCS/Qy8jGLj0rd+OCr3
	0z8Hrz5uZ5Wp59oZYyWCMtccqD3L2cc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-GKvFdqt8N6isZNQ9JeaeMQ-1; Mon,
 19 Jan 2026 16:03:08 -0500
X-MC-Unique: GKvFdqt8N6isZNQ9JeaeMQ-1
X-Mimecast-MFC-AGG-ID: GKvFdqt8N6isZNQ9JeaeMQ_1768856587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A778195609F;
	Mon, 19 Jan 2026 21:03:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB92819560AB;
	Mon, 19 Jan 2026 21:03:04 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 11/26] rv/rvgen: fix typo in generator module docstring
Date: Mon, 19 Jan 2026 17:45:47 -0300
Message-ID: <20260119205601.105821-12-wander@redhat.com>
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

Fix typo in the module docstring: "Abtract" should be "Abstract".

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index fc9be5f6aaa1f..ea1fa0f5d818d 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -3,7 +3,7 @@
 #
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
-# Abtract class for generating kernel runtime verification monitors from specification file
+# Abstract class for generating kernel runtime verification monitors from specification file
 
 import platform
 import os
-- 
2.52.0

