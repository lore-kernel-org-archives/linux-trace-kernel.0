Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAC2F0C7A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856445; cv=none; b=oQSU7EJ3o6nJPS6Hgn23FT712hRenDDdoC+95Qr8uzTiNFhEo+mFMNJPszv6JckV/LC8OijuTREsxHJTLJfjKzvSiBY1oV4YiOFdMl/NaeV/22Yu1Lp2zwmGGQ9WPVRpp7XA8PXrGDb80dh2oSvm19tMbxahC1NKFmTowfvghR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856445; c=relaxed/simple;
	bh=8DkqGNezhZS+jns6pl7LkC98k3QrxCSUlXLi95NECOc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI/INiqBTRHmKZ7VwP9jQFqd6BQOOX3h7xDjJb/GHu+dL3liZ3RGLNGxZ40DKY6PgT+uIXgUOFfnGycN+kh8s6sugp+EqY/FmEMJGB2ug4EcxyediJU39WdNKVr1WpB8WxYG8657vFyBwUC134GlfJmSETL/IxSfrzGAscAoFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hi5j+2S3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi5j+2S3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDv8xxnb+/FccRewmtuSoSQQbd73qMaYdppoDFSJu5Y=;
	b=Hi5j+2S3dPWptJJJ9jM28hsEjDbGa3vZY4eXvEHBrpEKWA5lrlKFar5jBsRFOt4kMrbQu2
	NDjgQNEljnB6d5tL7xvH61IeqfHG7YIP7FK6JRze1l+eP60bxcCirnQeKvP0er1lupgnQW
	Ya/BYzg1vWWME2GwaqcDes/ipbWi794=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-xnge12KDOD-KRF_wthjfQg-1; Mon,
 19 Jan 2026 16:00:41 -0500
X-MC-Unique: xnge12KDOD-KRF_wthjfQg-1
X-Mimecast-MFC-AGG-ID: xnge12KDOD-KRF_wthjfQg_1768856440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27F421800473;
	Mon, 19 Jan 2026 21:00:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FF6E19560AB;
	Mon, 19 Jan 2026 21:00:37 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 05/26] rv/rvgen: remove unnecessary semicolons
Date: Mon, 19 Jan 2026 17:45:41 -0300
Message-ID: <20260119205601.105821-6-wander@redhat.com>
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

Remove unnecessary semicolons from Python code in the rvgen tool.
Python does not require semicolons to terminate statements, and
their presence goes against PEP 8 style guidelines. These semicolons
were likely added out of habit from C-style languages.

The changes affect four instances across two files. In dot2c.py, one
semicolon is removed from a boolean assignment. In dot2k.py, three
semicolons are removed from string append operations that build
generated C code. Note that the semicolons inside the string literals
themselves are correctly preserved as they are part of the C code
being generated, not Python syntax.

This cleanup improves consistency with Python coding standards and
aligns with the recent improvements to remove other Python
anti-patterns from the codebase.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2c.py | 2 +-
 tools/verification/rvgen/rvgen/dot2k.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 0fb3617ad8ce9..b9a2c009a9246 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -120,7 +120,7 @@ class Dot2c(Automata):
         for entry in buff:
             if first:
                 string = string + "\t\t\"" + entry
-                first = False;
+                first = False
             else:
                 string = string + "\",\n\t\t\"" + entry
         string = string + "\""
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 1c0d0235bdf62..291385adb2c20 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -37,10 +37,10 @@ class dot2k(Monitor, Dot2c):
                 buff.append("\t/* XXX: validate that this event is only valid in the initial state */")
                 handle = "handle_start_run_event"
             if self.monitor_type == "per_task":
-                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
-                buff.append(f"\tda_{handle}_{self.name}(p, {event}{self.enum_suffix});");
+                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;")
+                buff.append(f"\tda_{handle}_{self.name}(p, {event}{self.enum_suffix});")
             else:
-                buff.append(f"\tda_{handle}_{self.name}({event}{self.enum_suffix});");
+                buff.append(f"\tda_{handle}_{self.name}({event}{self.enum_suffix});")
             buff.append("}")
             buff.append("")
         return '\n'.join(buff)
-- 
2.52.0

