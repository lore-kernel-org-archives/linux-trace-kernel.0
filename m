Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693250E5B0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686180; cv=none; b=aVtod4qjx/xDNPmx4qh05o1onIB0vwqfGMguzHlRoIexgcE27xq8PIs9o8mMHATYqPLSWkhzEmkUP4z9HrG7xNkA2Pot4feESvD+vcOwKrpg1/7qZ5o3W3/Oz+Q/gIKKAZnIW4TYT8MSQCfgRAPIx9NKnmyoS5tijB+otsxAeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686180; c=relaxed/simple;
	bh=pnek/z8jxQn/VD8dAPg5/TP3YGb++H6KlWA3Mwbt7JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gi/SQAyCE4HRPT5RRRZfRmVMGXhZeictYeiH8qItl+DeHsNatH7yESVSWJATamNAHgdNBGDOjSl9TmnH+76QRVIgJla7xE06UIjI6ZxBIXCRQzKBmGBa6lc7dv0Tfq35jfxTDUXRS9DgPf823y820w85Vhw+rrWnUa6jrinMy1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYEzpkYL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYEzpkYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBebhacO09D0g9Rsrj+rBtPy7Gg8a/+4S+y1fDgrNuE=;
	b=PYEzpkYLrdR84ZFtR3lAR7IaUXs+Jryw4/MUnVBBaJZ3SNCTBEco0qIQMR2h6jIMnIbBpb
	hGedAC0YE7wXnHMKDpEDtAFwCKEJJVycrRbUif/7GmkAKmDUObqiO7z1qtfAs67uc9j4bx
	is640ZsHfUFjE0AytLjoZHmMVen7UGA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-n6ngbFj8NaKtcSL4CBtJhw-1; Tue,
 29 Sep 2026 08:49:35 -0400
X-MC-Unique: n6ngbFj8NaKtcSL4CBtJhw-1
X-Mimecast-MFC-AGG-ID: n6ngbFj8NaKtcSL4CBtJhw_1790686174
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8778F1805A2E;
	Tue, 29 Sep 2026 12:49:34 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 794B11956095;
	Tue, 29 Sep 2026 12:49:31 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 04/10] tools/rvgen: Default to HA_TIMER_WHEEL for jiffy clocks
Date: Tue, 29 Sep 2026 14:49:02 +0200
Message-ID: <20260929124908.177676-5-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: jZuG3pwc5EqykZ6_bj31GpO761eV0Z7oaLXRw8nHlOs_1790686174
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

HA_TIMER_HRTIMER now requires a ns base also if the clock is in jiffy,
defaulting to using it in that case adds no precision while increasing
complexity.

Use HA_TIMER_HRTIMER as default in the generated code only for ns based
clocks and use HA_TIMER_WHEEL otherwise.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index c8109f3602a6..5d60b1b9fa28 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -495,8 +495,10 @@ f"""static bool ha_verify_constraint(struct ha_monitor *ha_mon,
 
     def _fill_timer_type(self) -> list:
         if self.has_invariant:
-            return [
+            if {"ns", "us", "ms", "s"}.intersection(self.env_types.values()):
+                return [
                     "/* XXX: If the monitor has several instances, consider HA_TIMER_WHEEL */",
                     "#define HA_TIMER_TYPE HA_TIMER_HRTIMER"
-                    ]
+                ]
+            return ["#define HA_TIMER_TYPE HA_TIMER_WHEEL"]
         return []
-- 
2.55.0

