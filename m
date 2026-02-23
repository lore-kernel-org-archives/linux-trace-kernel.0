Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8E30FC16
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864019; cv=none; b=DQnL9Nr/AnCXqbTuYhQNl4Qc3O5VaeMS5LYqyHEMPagNIewMkg5ncgOgsrIcqHE+WDpUs/FWkZSa8AlsMjCGzypIRyBu+8T6Jm0H4f4IyVy6S3Ye7Vg7hG+9RbuGazdTUgFwBih0THRkEyg8mA6W9ESmwgD+c5O3h5VVwQi0eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864019; c=relaxed/simple;
	bh=QL2ejv2+3YvAWL5CSkNwYRn11wU4PTBvlTsWRS+pJ9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aRx/NmQylCz0RbCJcNjrzb8kUZg+Y7JrlBxUYpD/mcaJYj2dxe+DRVGAHzJQg3DobWIeVHnbobg9I7Ra36FKIBFfTIN2fTR1AMF1hQcsU68qLelaBCo3ol8TNCgL0kCLd1yiN2vuN6Oy59XrM8SeDdD8taepT7P8J9/VSJoOjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfKJ7Vt3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfKJ7Vt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toYc/KytBJDS3v29J7Ao5zr1crGTZ/8ZX2w/8ex74No=;
	b=JfKJ7Vt38i6gAVOhp+advKC3r/t07GlvY0pUEjg5464j9Utdw0ZuWDHW9cM0oB6Y9IgEgy
	iJZcPsHyy16WTrHdu0dDbaBSoGKdFTiXEp1FnVdvX4oSW02AnNm0cwsVHFrXXQFsEB3TxV
	5cmSnLthnZoZ/oJ0LeRsRmMWDSloaSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-ciXsZJhrOki_xPsqwN-fCA-1; Mon,
 23 Feb 2026 11:26:52 -0500
X-MC-Unique: ciXsZJhrOki_xPsqwN-fCA-1
X-Mimecast-MFC-AGG-ID: ciXsZJhrOki_xPsqwN-fCA_1771864011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D59C218003F5;
	Mon, 23 Feb 2026 16:26:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9BC01800669;
	Mon, 23 Feb 2026 16:26:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 05/19] rv/rvgen: remove unnecessary semicolons
Date: Mon, 23 Feb 2026 13:17:48 -0300
Message-ID: <20260223162407.147003-6-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: XvBa1G3FhKhW2xcJS37C961MAKqiR1NS9ajAK993N08_1771864011
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
index e26f2b47390ab..47af9f104a829 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -46,14 +46,14 @@ class dot2k(Monitor, Dot2c):
                 buff.append("\t/* XXX: validate that this event is only valid in the initial state */")
                 handle = "handle_start_run_event"
             if self.monitor_type == "per_task":
-                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
-                buff.append(f"\tda_{handle}(p, {event}{self.enum_suffix});");
+                buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;")
+                buff.append(f"\tda_{handle}(p, {event}{self.enum_suffix});")
             elif self.monitor_type == "per_obj":
                 buff.append("\tint id = /* XXX: how do I get the id? */;")
                 buff.append("\tmonitor_target t = /* XXX: how do I get t? */;")
                 buff.append(f"\tda_{handle}(id, t, {event}{self.enum_suffix});")
             else:
-                buff.append(f"\tda_{handle}({event}{self.enum_suffix});");
+                buff.append(f"\tda_{handle}({event}{self.enum_suffix});")
             buff.append("}")
             buff.append("")
         return '\n'.join(buff)
-- 
2.53.0

