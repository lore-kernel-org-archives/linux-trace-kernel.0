Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11C326930
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957528; cv=none; b=lUbR1suBi9dodGnBijbKFPcAfisStlUn86pGvspeZ0ppytvLxn5znpLsbuSDm2bjHBM3+Nd+h586g/uUU6t59LucG9ajIpepw0lJLkwN36h7zM0Z27dXiItfh0+M8vJ/zGuxdYdpcxtCCS0OES6DN0EenzgHTk0GWeJnnmzGQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957528; c=relaxed/simple;
	bh=Hhh+x/aIcBYOReApr+Pc1Fq4ARuStX2+QbBxascteWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rGR1ckBP5kLpVJ8GBgHfJN8tjiS/9Il4o4+fMtxwe2SwXn4gG0RQmSHyLK4Xnb01LQWVgv1poAk/HOkbzQr9CIp1FDbZLMEvRowAvpk6uOVo/oDCJ8Ole5DpqRDqPb7fxZvPe5Y7x8ffh86XztWPNPuMyeO0U7qGE0O5eEZbG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnDK/SYf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnDK/SYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776957525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02ivVQLZXEiiH1k/LQi6XZgckhEW7oBgvHmte7wg1S0=;
	b=MnDK/SYf2JJXumumVGsv6w9dw4qGNdzDVImgKO7lGP21e87i/Z6rRqTvSaEHAxnr5W5tFP
	y6n58h8qhM0iURk7uLp7BPVX+JF2yUKVCgOC55720RErU013u1+QB8c7k6WT0n8iXFnqiH
	jwd5ukGt8NGDas4rg6h7gN2OsHP/F38=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-CN83baJBMom1HXrIGLpBSQ-1; Thu,
 23 Apr 2026 11:18:40 -0400
X-MC-Unique: CN83baJBMom1HXrIGLpBSQ-1
X-Mimecast-MFC-AGG-ID: CN83baJBMom1HXrIGLpBSQ_1776957518
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AEDF1800578;
	Thu, 23 Apr 2026 15:18:38 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.80.103])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 893571800348;
	Thu, 23 Apr 2026 15:18:29 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 3/3] tracefs: make root directory world-traversable
Date: Thu, 23 Apr 2026 11:17:46 -0400
Message-ID: <20260423151746.16258-4-ashelat@redhat.com>
In-Reply-To: <20260423151746.16258-1-ashelat@redhat.com>
References: <20260423151746.16258-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 7hI84ymILnO9ZSOikN4CiSxDTrN5E80HKQaI0msktIc_1776957518
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Change the default tracefs mount mode from 0700 to 0755. This allows
unprivileged users to access the eventfs directories underneath which
already use 0755.

This does not expose any tracing data since access to the files
themselves is controlled by individual permissions.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 03f768536fd5..9506450fbc91 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-#define TRACEFS_DEFAULT_MODE	0700
+#define TRACEFS_DEFAULT_MODE	0755
 static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
 
 static struct vfsmount *tracefs_mount;
-- 
2.53.0

