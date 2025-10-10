Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B7262808
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085264; cv=none; b=SWpGdsmK1PTqoGFnizJUI01y+G88yjL8A1+pXnB3yjhdTiyOXAte6pexZNYjfZlcajtSsUaAqIywaREAxawt1XfnUoBLBdL/43wCZ06c9nmIFjQZQ71jqFvhTBdfAkz9EpKMunwSbVpkRCPjWtJY2O+qIa01RVW7t6A8EMBMzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085264; c=relaxed/simple;
	bh=bHdkT0SRpvckR//u62FZqAiNJWH7odfKGe/eJNBu7ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfwh+C6aNI7OnJv7efZgahEwYr19ibfJ7U8PZAnh48PPfMGKN1+f0nsZ9/MxhBSrUUYR4wqZGieJAqg9eIV3B7P7/U3NI+sfM4mC/PcCZRUl4dlmgIJ0GoL0NXzSIsieSPFgvUdAwBdAZjtS3+wu01iQ+8nyRM4vmEzFz0iE3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7sQaa+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7sQaa+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW1e0jQ2GbtaetsTGdGfNR8Fk/nO8dWFHEsXFoHlOlM=;
	b=V7sQaa+boyUid6nG6lvkTqNa0BQsp8Vwc+Q9boDPO3RS+V5/w93bar5fURihQ65C9n2sB7
	3d0VAIIlp2sYCFjDh61BeWo6NIBUaUfjB1kcXcVo3F67wOlmOsbbeWJEOssddzz24ypNsU
	Ybu0uUiayBZT9L3UJ6g+/GR3ZPDEi7g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-WQV_c8CRMyG_KVUkvr2SLg-1; Fri,
 10 Oct 2025 04:34:18 -0400
X-MC-Unique: WQV_c8CRMyG_KVUkvr2SLg-1
X-Mimecast-MFC-AGG-ID: WQV_c8CRMyG_KVUkvr2SLg_1760085256
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA68F195608D;
	Fri, 10 Oct 2025 08:34:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BA3219560BB;
	Fri, 10 Oct 2025 08:34:11 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/9] Documentation/rtla: Fix typo in common_options.txt
Date: Fri, 10 Oct 2025 10:33:30 +0200
Message-ID: <20251010083338.478961-2-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix "unlike" being spelled "nlike" in --on-threshold documentation.

Fixes: 70165c78e31d ("Documentation/rtla: Add actions feature")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 77ef35d3f831..8ca424ab0faf 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -67,7 +67,7 @@
         - *trace[,file=<filename>]*
 
           Saves trace output, optionally taking a filename. Alternative to -t/--trace.
-          Note that nlike -t/--trace, specifying this multiple times will result in
+          Note that unlike -t/--trace, specifying this multiple times will result in
           the trace being saved multiple times.
 
         - *signal,num=<sig>,pid=<pid>*
-- 
2.51.0

