Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072D42846D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772108; cv=none; b=rxKnnVP7e2aR9FP4lyPbkFuVvCL1CtDMGPNZbXsmRnllNKhKyxvAU/gTZ9EhNHYUQuoyuG0WKj/AcgRPb4tX6GQujVCTXEEhNBa6FjADKs0JBm3pBuxN4UtxUrF6ur7cUW/IDNVXWJRNcaF8r8Mfk+Fn2Y39xksKv5P6LKS3yuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772108; c=relaxed/simple;
	bh=0C6RfvaonJpqY5+r3oZmoyYaaprqQ+dSZ/HR09CNLNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=R2hN/JJA3UFaFWynCnDVhHOcEFDiFmPh7rjXxCn1hCYYypt7RpKmgPuRMceqzQs1rHwkDnbYUtApN+UYHz+R47Ah/6KO5b+lZfdY2Flb7xuFIOx0QWApEb/Jlh56QQpW7v5hVmd0FWnpUxGIrq00i3Dwz5aJiiU/SvRVLbmE77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCfGSdRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCfGSdRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yr0V9/34qco1aQYqxDHUIvyNht8oHMlUR7CJ+DlzE58=;
	b=FCfGSdRsqv1gCNpF++mymnXKB6eDE+pYwrHGn80WRLAYgkT1EW/PtTNj8OZB2owrwrszYJ
	TJ5nOd+muCbHIQeHwq0AHhEmudTFLB2XfGdgue7zuXLUb0nlmA3zBBCqWu7h9ZuCXSTqzt
	81jHU5i4xUUB5TpFe88q5OmX7T0CRSQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-Y5-WadFFM_6U8Dhj7q9lNA-1; Thu,
 14 May 2026 11:21:43 -0400
X-MC-Unique: Y5-WadFFM_6U8Dhj7q9lNA-1
X-Mimecast-MFC-AGG-ID: Y5-WadFFM_6U8Dhj7q9lNA_1778772102
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FC40180061D;
	Thu, 14 May 2026 15:21:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20F6430001A2;
	Thu, 14 May 2026 15:21:38 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 07/14] verification/rvgen: Fix ltl2k writing True as a literal
Date: Thu, 14 May 2026 17:20:48 +0200
Message-ID: <20260514152055.229162-8-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: A0VgaZT-Q5h1q-DicQ_edMmPBSO04dOXhbBdnytFldY_1778772102
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rvgen parser for LTL stores literal true values in the python
representation (capitalised True), this doesn't build in C.
The Literal class should already handle this case but ASTNode skips its
strigification method and converts the value (true/false) directly.

Fix by delegating ASTNode stringification to the Literal and Variable
classes instead of bypassing them.

Fixes: 97ffa4ce6ab32 ("verification/rvgen: Add support for linear temporal logic")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2ba.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
index 7f538598a868..016e7cf93bbb 100644
--- a/tools/verification/rvgen/rvgen/ltl2ba.py
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -122,10 +122,8 @@ class ASTNode:
         return self.op.expand(self, node, node_set)
 
     def __str__(self):
-        if isinstance(self.op, Literal):
-            return str(self.op.value)
-        if isinstance(self.op, Variable):
-            return self.op.name.lower()
+        if isinstance(self.op, (Literal, Variable)):
+            return str(self.op)
         return "val" + str(self.id)
 
     def normalize(self):
@@ -382,6 +380,9 @@ class Variable:
     def __iter__(self):
         yield from ()
 
+    def __str__(self):
+        return self.name.lower()
+
     def negate(self):
         new = ASTNode(self)
         return NotOp(new)
-- 
2.54.0

