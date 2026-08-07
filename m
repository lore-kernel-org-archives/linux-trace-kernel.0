Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F33B42C1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095971; cv=none; b=CD7fKnH71hdyAcbHnT0xK94WrQKLGCmL1bpfOAZouDyYwIWtYBmpeVGzn/RsZeIJJtjtYYHSxCwWB2IIsCId1DiA9FnRmZ3eczWvBi18IBkcbTqctfOyp+IwaJEcol1LU7p4c/02rwry1oJ54qGR/L75rWoMI1Kg+O1zaiWyaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095971; c=relaxed/simple;
	bh=pp/HNxJtm2qgKpoVk0PTHkP9OBX+9Rk9zKwRGrNHuqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=BHCcySkdUVbKcCUBJQLq80ttrPNfd3MPkXoAfyvpL4WrsHEo1mysII8pNPXavKVflHKNT24EoK3Gi8zwM/8DocKahJiK8od9AUwrmaYQ9pfBBTIfaiqxKt/+CBp61t2T9nODY1SEb1sirlIwZYbXOiJLabiwq9ZXH4GWrfULSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTswKFIJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTswKFIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786095968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y0QGvq8Xmf+ZVN6jXbeinSkN5fKa+U8pqjn+i2I6yBQ=;
	b=GTswKFIJaASFfXiNSSSJLi8IS+gv4zuFZh/mlm3vtcudKKQIj0L3eHN5NUcgH9iJzAT2S6
	wKSgIeiNUPkanbFXzV5QsivLABIyH9tUTU5ku3pNNzgb6w8l/KcCdGOTmWwxIwqIb+e4r0
	6wQQ7sVHjAv1fAzACXCT9OL8lsdPNuo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-tpeMzjC4OemFQwF7jmX1VQ-1; Fri,
 07 Aug 2026 05:46:02 -0400
X-MC-Unique: tpeMzjC4OemFQwF7jmX1VQ-1
X-Mimecast-MFC-AGG-ID: tpeMzjC4OemFQwF7jmX1VQ_1786095961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C3DD18002F8;
	Fri,  7 Aug 2026 09:46:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60ED31956049;
	Fri,  7 Aug 2026 09:45:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] rtla/tests: Test actions in absence of threshold
Date: Fri,  7 Aug 2026 11:45:55 +0200
Message-ID: <20260807094555.1244103-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 0MXc07uNLyrBQOayIwRkf_H68240v1G6Aet9yGvjq_A_1786095961
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit fafb66e5903c ("rtla/timerlat_top: Fix on-threshold actions firing
on signal") fixed a bug where on-threshold actions were being triggered
even without a threshold being set.

Test all four tools with an --on-threshold action, but with no set
threshold, and verify the action does not trigger.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t  | 2 ++
 tools/tracing/rtla/tests/timerlat.t | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 214fd40fc610c..352b302372453 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -98,5 +98,7 @@ check_top_q_hist "with conditional continue" \
 	"osnoise TOOL -S 2 --on-threshold shell,command='if [ -f a ]; then echo 2; exit 1; else echo -n 1; touch a; fi' --on-threshold continue" 2 "^12$" "^2$"
 check_top_hist "with trace output at end" \
 	"osnoise TOOL -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
+check_top_q_hist "action with no threshold" \
+	"osnoise TOOL -d 1s --on-threshold shell,command='echo BAD'" 0 "" "BAD"
 
 test_end
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 5116857d7da45..1d317c851a0fa 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -136,6 +136,8 @@ check_top_q_hist "with conditional continue" \
 	"timerlat TOOL -T 2 --on-threshold shell,command='if [ -f a ]; then echo 2; exit 1; else echo -n 1; touch a; fi' --on-threshold continue" 2 "^12$" "^2$"
 check_top_hist "with trace output at end" \
 	"timerlat TOOL -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
+check_top_q_hist "action with no threshold" \
+	"timerlat TOOL -d 1s --on-threshold shell,command='echo BAD'" 0 "" "BAD"
 
 # BPF action program tests
 if [ "$option" -eq 0 ]
-- 
2.55.0

