Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AFE27B359
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216689; cv=none; b=hcx+Ln5F+kxXTePbE5xPsU0B5EHidYrKxZd+GS67ZCLTVHbhhDJ7dM4BgsgGRh3mZlWaIfjb7pBD063i7TFxm75DYIEvpQKm9dpp9xVSOHAoiWhVmtiF0fI7+CQ/Azj+qX+wt3xfakVhlpwfNroHzw7ObgLgaYs4+4yNgjiY0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216689; c=relaxed/simple;
	bh=x7f/QArb6Yd58zFMtFyowo0pjz38ig88AIQ7PNG9Fgg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sFQjssPSttMOOdzDtTztyZ3QZ/5J9aerZtuJ1izvfaIWHQaADrqiFKlR5VtPFg32wBYssYP1Mu8cGBviWpBSKCZGqrnFqE2euwyHnkcoUfv9oklqxWX9Ptq93jgekeN8ojG6eXyPBpkcBw8401dq2M4+vzoKYuAq1Oza2EYgPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yr7y/Hhr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr7y/Hhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKJIIR4sCiicMLk+1rg/I2qnycwySEM7ioO+qJg8T1I=;
	b=Yr7y/Hhr5wFgZlglpSYj35kN0IphrJJdJ2MF0396feriateDAGWB5C+OVU4JljNPUiwzC/
	RrGUhIHnDHzLx170V97PF3dtAnn6H0ZV9oYKILOHomX1kNCVdCFgsZ7RDL+T8yLSDTptQa
	oBMbPgS0kTj4E7sEZeb/y9ZmgVwvnu8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-x6iJdHTnPmueyuxtwS179w-1; Wed,
 04 Feb 2026 09:51:27 -0500
X-MC-Unique: x6iJdHTnPmueyuxtwS179w-1
X-Mimecast-MFC-AGG-ID: x6iJdHTnPmueyuxtwS179w_1770216686
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90831800451;
	Wed,  4 Feb 2026 14:51:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 622B730001A5;
	Wed,  4 Feb 2026 14:51:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/20] rv/rvgen: remove unnecessary semicolons
Date: Wed,  4 Feb 2026 11:42:31 -0300
Message-ID: <20260204144914.104028-6-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: gGH57p4DNHyKHCe7EwgY4P_UO3_jjcdpsRn5lCw4bLg_1770216686
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Remove unnecessary semicolons from Python code in the rvgen tool.
Python does not require semicolons to terminate statements, and
their presence goes against PEP 8 style guidelines. These semicolons
were likely added out of habit from C-style languages.

This cleanup improves consistency with Python coding standards and
aligns with the recent improvements to remove other Python
anti-patterns from the codebase.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 6d4151acc9fe3..c70a9812abbf6 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -37,10 +37,10 @@ class dot2k(Monitor, Dot2c):
                 buff.append("\t/* XXX: validate that this event is only valid in the initial state */")
                 handle = "handle_start_run_event"
             if self.monitor_type == "per_task":
-                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
-                buff.append(f"\tda_{handle}(p, {event}{self.enum_suffix});");
+                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;")
+                buff.append(f"\tda_{handle}(p, {event}{self.enum_suffix});")
             else:
-                buff.append(f"\tda_{handle}({event}{self.enum_suffix});");
+                buff.append(f"\tda_{handle}({event}{self.enum_suffix});")
             buff.append("}")
             buff.append("")
         return '\n'.join(buff)
-- 
2.52.0

