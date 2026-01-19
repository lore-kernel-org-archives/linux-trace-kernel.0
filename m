Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56052EB860
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856935; cv=none; b=kYpwgs+yXi64OxtsYZTNto/YXAGTWsJR4aPlMf8vuaUi+gXCxYnQcQ8uO37adRJGCGKwDOst5Tfq+8Q0JVqcqe3uUR7oE2woZCi9RYBAKsuyCSKJ+UNaJLTFGNTQtUzGHV7IcQI2hq+dxfg9OD8kSR5zzROKsnWMwyy9ThhGFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856935; c=relaxed/simple;
	bh=c5xB9bQ2gRYuiiCkqKN8cGNiCtTlsD6giWS1xZpe9Uc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULJsqGWNWpGrUaEGRdkisE78AjSqk5GSeGZI4Yn2IzJshpIWzPfs7awbESqrcPDbQq7EgGyN79knJ4u/wl10T3lzxmpoWuaWGdwUWocaGCHc1Yps2hBfi1FRgUvzAWf9RDxRExKnSMbSGE5Mag1WZjNjGpAP2A5rcrvlIcavxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmQnhJkD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmQnhJkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShCVTmEOtwDXLNQOXcJsi+RugUD0oHWkctfo1fKXMms=;
	b=JmQnhJkDlSKj6tl777gPO2CpctO9YTLXQrH7wymILor8fvze8G1GCCgUz+8EHxuPyLDudg
	UsQqHzDTjzXwYCGjEr9vSepBSR2eLS4HP33cjvdgkK2K+JB5aij3bSc4cypeSEux8hUthY
	IQfNIEGeqiCp4yCWML0j0LRdlxDicR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-LZxGZVdoOzG1SvW60N5WoQ-1; Mon,
 19 Jan 2026 16:08:49 -0500
X-MC-Unique: LZxGZVdoOzG1SvW60N5WoQ-1
X-Mimecast-MFC-AGG-ID: LZxGZVdoOzG1SvW60N5WoQ_1768856928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AF6919560A3;
	Mon, 19 Jan 2026 21:08:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA43B19560AB;
	Mon, 19 Jan 2026 21:08:45 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 25/26] rv/rvgen: fix isinstance check in Variable.expand()
Date: Mon, 19 Jan 2026 17:46:01 -0300
Message-ID: <20260119205601.105821-26-wander@redhat.com>
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
---
 tools/verification/rvgen/rvgen/ltl2ba.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index 49f6b9200ff0a..79b45a1d61130 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -404,7 +404,7 @@ class Variable:
     @staticmethod
     def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
         for f in node.old:
-            if isinstance(f, NotOp) and f.op.child is n:
+            if isinstance(f.op, NotOp) and f.op.child is n:
                 return node_set
         node.old |= {n}
         return node.expand(node_set)
-- 
2.52.0

