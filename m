Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AB262FC1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085278; cv=none; b=I0ZHfdp4uqEX2RQM+6Rox+6mTrfatE13+iU89oT2u2B2gVMVOdMGIW86t7ClA7e5PUnD5o09cGOT9aBRKzTzvgfPDRAUuavD3HeF2lTE+ttZSAQH/c8+UdPZO3T2IGkNy9dbuFNqtAlZq0PfeLwk7sPal8kKR+b6D1WU2NftdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085278; c=relaxed/simple;
	bh=sUChDGfLfRo2acVDpiskhoCecnBt0+lRXhNSLm09ydA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwk9cDHTAV4CuXAU8A24dTv+nJMnonNPYcp44jZga9L1fE5NNeD+zVRMNwJRVwfHcUwwxgGtzZgfGipo0RFzEMsg7RNogL76PJY51RfxyMXjJi/+LoEo0XdsKvrAAw4bmRcL8vjVJMCEl7NPey82ydxXqpNC2Mr84PRHHGqt4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7ZTT0PX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7ZTT0PX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oejrMhy4RaX8WADxWIYHBRaQd+uYLCICR2ZFUHvioRI=;
	b=S7ZTT0PXAfId9FAihCQZvkCBHefnsJ3T3UnhSv7eY5dvBascUTvjni7oUMhv2ibF+wsvY6
	cX1fHrZ3cRpGjsYWh+YcjB+vwnd7ulchGrx7cEi07ZN7+NdTV0hrp+j6D3Bp9QJ5EGUzEZ
	NOY5FjWZ0iMtYbRFI/YnX7kmk6WldTg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-RkSkV1QBPUujzH0JmvtpiQ-1; Fri,
 10 Oct 2025 04:34:32 -0400
X-MC-Unique: RkSkV1QBPUujzH0JmvtpiQ-1
X-Mimecast-MFC-AGG-ID: RkSkV1QBPUujzH0JmvtpiQ_1760085271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88EFA19560AA;
	Fri, 10 Oct 2025 08:34:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2315F19560BB;
	Fri, 10 Oct 2025 08:34:25 +0000 (UTC)
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
Subject: [PATCH 4/9] Documentation/rtla: Fix typo in common_timerlat_options.txt
Date: Fri, 10 Oct 2025 10:33:33 +0200
Message-ID: <20251010083338.478961-5-tglozar@redhat.com>
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

Fix spelling error "equilavent" in place of "equivalent".

Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.txt b/Documentation/tools/rtla/common_timerlat_options.txt
index e7074eb36468..33070b264cae 100644
--- a/Documentation/tools/rtla/common_timerlat_options.txt
+++ b/Documentation/tools/rtla/common_timerlat_options.txt
@@ -13,7 +13,7 @@
         Set the automatic trace mode. This mode sets some commonly used options
         while debugging the system. It is equivalent to use **-T** *us* **-s** *us*
         **-t**. By default, *timerlat* tracer uses FIFO:95 for *timerlat* threads,
-        thus equilavent to **-P** *f:95*.
+        thus equivalent to **-P** *f:95*.
 
 **-p**, **--period** *us*
 
-- 
2.51.0

