Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE430ACEE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576547; cv=none; b=mSSgHoBzuamtVd9oOXA9iBbwEuuc+y0M84O1z5TJTiEi01zVWkoCeX47/R77GeqhSPca8rPh094NZOWfDMcfiZFjZvfT44bimdLVL1pDm3aRDsN3B3eAXV/zCLc4KoqKSgso81TJaI3wgAK3jbV479tEHNQdgsJ8oW7T7PkB2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576547; c=relaxed/simple;
	bh=E4UmDRrfK427SBmAu3QgG9274GYyOCRnkLTnbkQSZ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGk+Dkl0lhqlLFtvqXY1F7Ew3zZv1BzhOtluaRgSiQNvYVmEMLs/YzEyZkJWgan9QvSgK2oY0StffLXunW3wbTrKZ0CIfnzX4R6LYRoV7Vx/YuzgQx/XHb96PTaIJxshlgFtfqa+fboObxRJcvVedBGigcYreutENrUAX9mACmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSWxiXtI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSWxiXtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8kAhx3O+cWF32TZgKmRfF3DYFNfvgUR9bkHyjA8PvA=;
	b=WSWxiXtI9AXZ75wNw4HzsLZS/e1ykYkwH4HtJOl8zGLPnVlZTkBhfI41IInjsmPfc7QzLK
	w8xEchsx5ay1N75gyilFHseL3iEhihpVed7S5RcYkLmB8lysZ5GlLBnXGLu/ngrqYrNPcf
	94uE03K2eqXfEohcquGRduKQHm1jsC0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-6oaRRRBXNY-BuMGr1MHJvw-1; Mon,
 27 Oct 2025 10:49:02 -0400
X-MC-Unique: 6oaRRRBXNY-BuMGr1MHJvw-1
X-Mimecast-MFC-AGG-ID: 6oaRRRBXNY-BuMGr1MHJvw_1761576541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECA791954102;
	Mon, 27 Oct 2025 14:49:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFA0F1955F1B;
	Mon, 27 Oct 2025 14:48:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 6/7] Documentation/rtla: Rename sample/ to example/
Date: Mon, 27 Oct 2025 15:48:18 +0100
Message-ID: <20251027144819.1034041-7-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-1-tglozar@redhat.com>
References: <20251027144819.1034041-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The sample/ directory in tools/tracing/rtla was renamed to example/ in
an earlier commit.

Rename it also in the documentation.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 1f5d024b53aa..c6046fcf52dc 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -64,4 +64,4 @@
 
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
-        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+        See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
-- 
2.51.0

