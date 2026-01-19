Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845962F7AA1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856793; cv=none; b=kbvLjp4hzbMxA5sGppvoMjUUxLTNJt8zFe4VoXKx0PEwOzWCWzF6Cd6GBWG/izDLnoFxLK+yDz7Cr2Dhm+tYcNibiOk2SSBq72RUrYPNhkIHXTDRsJM1hRNMEjYVEyTHtb77PbsMrlZohuGEQ+Uh6Yy/elO7h6fcVyyB78GZ1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856793; c=relaxed/simple;
	bh=Yy25pbOzQY6/67FaeeOQExnC7iSweIy85nMShC6rW2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDs8cxv7tG0KKMtGMKQDnrOAnPUDzMy2iB5nqlxis8QRrOg1ZZvo4waBg6tgmgqNRI2sAjs/hC/FDcvSL66ihZyStfgQK3BGSrzEBMUkL9+RSb8/swbsLAq153IwkRUdokyNrDqi8MFmeHNR20/rHTR7XJcPlykmfAZ8hViCIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMAniPqA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMAniPqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjiIcWBI340zaieB4Zxm5IDzcw38iqhycJCiEUWs664=;
	b=EMAniPqAcGSz4/NYC3zepzJ2fAGwYpKo1pgmf3ZiLOoH16uS7W/QnFpMvnp0dNOIpxkV3e
	JuTXrmFqE48tjOYNuchKT/nGSFZL8iQ6Ahkp8bGWQXxM42hWOKd70KU2PbTzPpxmI7Dklr
	VEmzMbnqLA7Oeo3H10HsYMnyv/pGe/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590--A3fUC0QMzKeBb2T6Bm6cQ-1; Mon,
 19 Jan 2026 16:06:22 -0500
X-MC-Unique: -A3fUC0QMzKeBb2T6Bm6cQ-1
X-Mimecast-MFC-AGG-ID: -A3fUC0QMzKeBb2T6Bm6cQ_1768856781
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D5F81956094;
	Mon, 19 Jan 2026 21:06:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6D8C19560AB;
	Mon, 19 Jan 2026 21:06:18 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 19/26] rv/rvgen: add abstract method stubs to Container class
Date: Mon, 19 Jan 2026 17:45:55 -0300
Message-ID: <20260119205601.105821-20-wander@redhat.com>
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

The Container class extends RVGenerator but was missing implementations
for several abstract methods decorated with @not_implemented in the base
class. This could lead to NotImplementedError exceptions if code paths
attempt to call these methods on Container instances.

Add empty-string returning stub implementations for fill_tracepoint_handlers_skel,
fill_tracepoint_attach_probe, fill_tracepoint_detach_helper, and
fill_monitor_class_type. These empty returns are semantically correct
since Container is a grouping mechanism for organizing monitors, not an
actual monitor that generates tracepoint-specific C code.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/container.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/container.py b/tools/verification/rvgen/rvgen/container.py
index 51f188530b4dd..65df21dfd17b2 100644
--- a/tools/verification/rvgen/rvgen/container.py
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -30,3 +30,15 @@ class Container(generator.RVGenerator):
                              self._kconfig_marker(), container_marker)
             return result
         return result + container_marker
+
+    def fill_tracepoint_handlers_skel(self) -> str:
+        return ""
+
+    def fill_tracepoint_attach_probe(self) -> str:
+        return ""
+
+    def fill_tracepoint_detach_helper(self) -> str:
+        return ""
+
+    def fill_monitor_class_type(self) -> str:
+        return ""
-- 
2.52.0

