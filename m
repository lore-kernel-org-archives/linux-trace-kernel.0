Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98D2D949F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303247; cv=none; b=HgyRTD+KGD6VcdB5qZHWgXvss2ETmNQRMiV4wPQmAlcI6OkIbEKhIg14kNc96hDVXgQ1R9rzatzKGSwKAFLHUPpLSRWDaORwWUmhsPPPCZ7C48bTLwuHHm8WMS21w4t7Xoh/WclRKNpzthAPo3k9J0C2oSS4mteeJ85uuJkYGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303247; c=relaxed/simple;
	bh=Uw7xO0Q16HjOAXs1hKye25XLYelb3OAYCUKMaV5veWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TglwFFHmKBOwh33AWmpE+8Uw5dt2Wl+D8fLKTUnxUNcpOaJFJyoE81mLobmncwpVnDs8ms3kGWwY4GqgeKUJPum73dr19VpAE/0VT7APtPhQrFQ4Ew90Y6Qo/rozavA0FbXWdsfMkPRm4qUCC6aWW/8I3WIzAbOizpRhrmkHEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfCGvRXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfCGvRXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRsyI/L+f58WFos4uAj8vqraroEwQ77J4d4gsSqTPYs=;
	b=ZfCGvRXipEYWNfmeLhzc1OGhc8uIYy4cESOfDzwklVcwOQLx27Qtis8dOE1cXriw7cEDB6
	fpifqSjrc7pO+Ne2e2FSMPgaxXbzYA3NqW9Slhfeqhy72jR5HqnuKYziMki29zGbtumATf
	uLHNL80Ca+WbjKm13LxrJPvzz2sVmTM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-BOICZ40hNjmLpqefDPt3IA-1; Fri,
 17 Jul 2026 11:47:22 -0400
X-MC-Unique: BOICZ40hNjmLpqefDPt3IA-1
X-Mimecast-MFC-AGG-ID: BOICZ40hNjmLpqefDPt3IA_1784303240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC67318007EF;
	Fri, 17 Jul 2026 15:47:20 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C89F83004183;
	Fri, 17 Jul 2026 15:47:17 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 05/17] verification/rvgen: Improve consistency in template files
Date: Fri, 17 Jul 2026 17:46:26 +0200
Message-ID: <20260717154638.220789-6-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iPPmWNo982V20qDBBGfT4FMoE7DGMHeIsPwYzZ9kN7s_1784303240
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Template files for rvgen had minor inconsistencies in their
placeholders for default author and default tracepoint examples. The
user needs to modify those anyway but keeping consistency may help in
bulk editing or checking.

Change default author from "dot2k: auto-generated" (for DA/containers)
or /* TODO */ (for LTL) to the general "rvgen: auto-generated".

Align the sample tracepoint handler name in LTL template to
handle_example_event, consistently with the rest of the file.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2k.py                   | 2 +-
 tools/verification/rvgen/rvgen/templates/container/main.c | 2 +-
 tools/verification/rvgen/rvgen/templates/dot2k/main.c     | 2 +-
 tools/verification/rvgen/rvgen/templates/ltl2k/main.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index 81fd1f5ea5ea..f3781a3e0856 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -222,7 +222,7 @@ class ltl2k(generator.Monitor):
         return f"\trv_attach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_example_event);"
 
     def fill_tracepoint_detach_helper(self):
-        return f"\trv_detach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_sample_event);"
+        return f"\trv_detach_trace_probe(\"{self.name}\", /* XXX: tracepoint */, handle_example_event);"
 
     def fill_atoms_init(self):
         buff = []
diff --git a/tools/verification/rvgen/rvgen/templates/container/main.c b/tools/verification/rvgen/rvgen/templates/container/main.c
index 5fc89b46f279..e6a20d74886c 100644
--- a/tools/verification/rvgen/rvgen/templates/container/main.c
+++ b/tools/verification/rvgen/rvgen/templates/container/main.c
@@ -31,5 +31,5 @@ module_init(register_%%MODEL_NAME%%);
 module_exit(unregister_%%MODEL_NAME%%);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_AUTHOR("rvgen: auto-generated");
 MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index 889446760e3c..bd3e0aab9cc5 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -79,5 +79,5 @@ module_init(register_%%MODEL_NAME%%);
 module_exit(unregister_%%MODEL_NAME%%);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_AUTHOR("rvgen: auto-generated");
 MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
index 31258b9ea083..c33f21535a7a 100644
--- a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
@@ -98,5 +98,5 @@ module_init(register_%%MODEL_NAME%%);
 module_exit(unregister_%%MODEL_NAME%%);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR(/* TODO */);
+MODULE_AUTHOR("rvgen: auto-generated");
 MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
-- 
2.55.0

