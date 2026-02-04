Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F98421F02
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216897; cv=none; b=S06yo8PWyoxy84wOF7pLMVagCRcyxnUpO49Rq5Kn9bHwG17kakYCd48vdohFjI9zHHK0CO19mucZ6nq74ZM+Wn2knoDKUIAyAmRLwFfXjAPk9DMSUPHrn3FcRvtjtl49FqyK2zVDV2Rnlx2FW9EyjMBSPbV6/qQpJ5m6KFSJRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216897; c=relaxed/simple;
	bh=7VkHUZ85BsRXWcQ1fJVsqBu4kJDs32MwdEPil2AgmiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WvHNXuMDLDJPYkdAigHA9mWn0SjBWG6d8rfRsf0O69f7I3h9ZEt/COeYtYyZ3hgbg8O3BmqtUZCXmsqX4x/j0AHGnM7xQ9VguLxsBKtVx76Mv5HfsVrxI09B7K7iAGN5yAWc++dnq48rClPYI9FfzqtmLxBObKdD+MAr1uUn9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3qty1DE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3qty1DE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5nDGm8I1q8jSi+6bxCtbd9yEAB2mdaSd/Cp83kNOj4=;
	b=d3qty1DE82y9ZxsyT+GckT4YdQLG9bU+EuyG2OMt5EgkRzfo2+Vd5yPQOfSFKHVY4k6H0+
	k9KaIMHh9yrD61WLjyOebvFYbIeOXYxk3Pz0RZQliNfGe0vj5Dff10FehsqPMBh3t8IL/G
	pfan6jRQGaR91ER74pmKK2ryZYPRkV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-U8IYSYn7NVy6juP88Be2bQ-1; Wed,
 04 Feb 2026 09:54:53 -0500
X-MC-Unique: U8IYSYn7NVy6juP88Be2bQ-1
X-Mimecast-MFC-AGG-ID: U8IYSYn7NVy6juP88Be2bQ_1770216892
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70A45180025F;
	Wed,  4 Feb 2026 14:54:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26F7A30001B9;
	Wed,  4 Feb 2026 14:54:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 15/20] rv/rvgen: fix isinstance check in Variable.expand()
Date: Wed,  4 Feb 2026 11:42:41 -0300
Message-ID: <20260204144914.104028-16-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: NwEg27apWVMbq1W6yRE4q8M4nT6DBj9E9cDnYVUeIBs_1770216892
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
index f14e6760ac3db..28f9a5682c830 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -394,7 +394,7 @@ class Variable:
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

