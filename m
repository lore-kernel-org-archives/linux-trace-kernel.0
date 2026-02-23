Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2F310651
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864216; cv=none; b=dEZYCRLBGQbwSVVucH46RHy4gryeeYr8hJLxqgQr+0Mv8VymT9uSoODuHMaNwVLG3VwrclPNVMY4AZnzMsuG68sG6qyE8n9SQTIGz/QcfZUzkRPQVHcjSEnclLbOuDI9M3bCHuZR3LvpmoBCxHafUfyDOFCMDg5cIciamfZEaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864216; c=relaxed/simple;
	bh=3+1mH0oEHDjZM17U3urFB35D5e/V331jenjy+2qK/Cc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=i7C21YNqDByy7UiNEqsu3PC4xSjf/L4zdh50Y7VOURmcABZFlAcpNbeoCS+Xgyv9dFR+8fbB+1WJXP/m6HD0rzexnQcdV8t0FlXX+vZG0Tumn9EIVuNgOcitDDSRzdSHIMULZWN8x03kL1dFua6qdgnOoHKpQSQ90To5IpGM+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g92oF6Mt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g92oF6Mt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUGGPkspJ3zMYbMOZig+zlLmAaK6PE0VrPjeBJRZrt8=;
	b=g92oF6MtXFtmWx7O7g4PTvSSCEXh+dvneFqRO1qPVmwg97euLo9kqM1sAkG2CLXFNYfY7Q
	YIJNoaUQlx9vPObl4hNQ0S2KsCDsQmhp/IAR6VzHxRKcFyS5J/UgYWWIkQFF5htMUvNqpa
	JTf7LIYkE6rwVCgF2UaUTGuWD9EaQ+8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-AfcpOgBhMtaRRtK-iLCWvA-1; Mon,
 23 Feb 2026 11:30:11 -0500
X-MC-Unique: AfcpOgBhMtaRRtK-iLCWvA-1
X-Mimecast-MFC-AGG-ID: AfcpOgBhMtaRRtK-iLCWvA_1771864210
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE5F01955F2D;
	Mon, 23 Feb 2026 16:30:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D606C1800669;
	Mon, 23 Feb 2026 16:30:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 15/19] rv/rvgen: fix isinstance check in Variable.expand()
Date: Mon, 23 Feb 2026 13:17:58 -0300
Message-ID: <20260223162407.147003-16-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: gZdJUYXWpmhqSrcEbSkPU__Gk3ps3seppsfEOAdss94_1771864210
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The Variable.expand() method in ltl2ba.py performs contradiction
detection by checking if a negated variable already exists in the
graph node's old set. However, the isinstance check was incorrectly
testing the ASTNode wrapper instead of the wrapped operator, causing
the check to always return False.

The old set contains ASTNode instances which wrap LTL operators via
their .op attribute. The fix changes isinstance(f, NotOp) to
isinstance(f.op, NotOp) to correctly examine the wrapped operator
type. This follows the established pattern used elsewhere in the
file, such as the iteration at lines 572-574 which accesses
o.op.is_temporal() on items from node.old.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/ltl2ba.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index f9855dfa3bc1c..7f538598a8681 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -395,7 +395,7 @@ class Variable:
     @staticmethod
     def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
         for f in node.old:
-            if isinstance(f, NotOp) and f.op.child is n:
+            if isinstance(f.op, NotOp) and f.op.child is n:
                 return node_set
         node.old |= {n}
         return node.expand(node_set)
-- 
2.53.0

