Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7969421EEA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216979; cv=none; b=ro4BlWtHDxBDuOENi8HelG8i7miaHkMqwKe3vbgJ0VF1Pcym9H0JaMjPMezZRBFzUHXVvx0PWcPrdX4RJepF7+M/Jj9pNR1yMPL/cdnHFd1TIVRctGHEucL/7rGcGKdMLZDRaZpvhpesxXdDrfIfmwdUrtmd+3L/bI4hfFuu0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216979; c=relaxed/simple;
	bh=kGQgel5Bam0L4+dTUknKjj4VeT7+LhGjT7frHIxd5S8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dYSu5ozCL+sPFDl73Mwcwir23P4/Kuit76ICp7sFGf6/uWsehMQ9UTMULo/tmPZAOGu/Z65X3+Bo0KtgKWeMhLnZfQF7z2BYsshXb9VTNFUnMoceEM+/r68HUEQqZ44d7DdYsss0QWTSQNLYO46uI5GnSaQq84lg7mFQqerw6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV2BaA8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV2BaA8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTKjXOGKrqTlHNVdJz+DTqnNe/95MpnGXuAdQBexCfc=;
	b=CV2BaA8BDt8lQyDY6tIU9bsM7zbAefxJoqcXs1tKd1flGGy4uJ1Sl86KzVnfpyusaOcABQ
	77wUDu/mzwhHEx+kKq/l5GZ20/X0ufST4EDlJnt7ng5fi34y+WN6FMlKW3Ares6pR01Sil
	VuiKFXkt/AS79LMjcfiw5ID5bhq+Wyo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-tv4_DWIXMtKJMjCtaKQlbg-1; Wed,
 04 Feb 2026 09:56:15 -0500
X-MC-Unique: tv4_DWIXMtKJMjCtaKQlbg-1
X-Mimecast-MFC-AGG-ID: tv4_DWIXMtKJMjCtaKQlbg_1770216974
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910C018004BB;
	Wed,  4 Feb 2026 14:56:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F4EA30001B9;
	Wed,  4 Feb 2026 14:56:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 19/20] rv/rvgen: fix _fill_states() return type annotation
Date: Wed,  4 Feb 2026 11:42:45 -0300
Message-ID: <20260204144914.104028-20-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: QOjMwpu8jjQciwPeBt4nxbCptNH8uel87YQhPDzcniE_1770216974
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The _fill_states() method returns a list of strings, but the type
annotation incorrectly specified str. Update the annotation to
list[str] to match the actual return value.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index 2c564cc937235..de765b8486bd1 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -71,7 +71,7 @@ class ltl2k(generator.Monitor):
         if not self.name:
             self.name = Path(file_path).stem
 
-    def _fill_states(self) -> str:
+    def _fill_states(self) -> list[str]:
         buf = [
             "enum ltl_buchi_state {",
         ]
-- 
2.52.0

