Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C34BA34
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830835; cv=none; b=WWbjD5NGji//F9eYog51x4yBGE6QWXSI7C5PMGJU4C3ibTBun8yIIpe/sfefUxIaxWbojEJgBDNUH9AJ/wGgR7cIZMvgvf6poWA1p61ER+H79q+cfypbfi6HqCqwHxkb/LetsDYJ3ZQJ2d5ipc/oA1KdGqnP4pQyvgUnraEdCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830835; c=relaxed/simple;
	bh=FxlpX1H2RfzCNZAacZWIc1/ddNhlxgd1jNU+mLDaBfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fh2iHH//j/YOz0SrF7W1fGjByqKZ9fShcdQoJ6dalue5WihzTBIZ2C+GD3FeFGCMuYKCsPTOcOPYJhLVLkOFnTEJFnE9Nfc7yk5/X7oyar2saU7z3ZUXZ8f2AIQTgzZHCu7KhiNjP+HXhWgFOnUgK8lCtbzUtfH4uy+sQDtTQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajmijdjk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajmijdjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfw1qZEbCpaKdybsFhf5WdXue/7jcyGvMTJdXkduoEc=;
	b=ajmijdjkgzDvx+1H9vDBWwaC1SJEmWseKxlObEpRNOo21oo/RhjtBUqk8qM9VsSanbWJXq
	FL1g6cnjZRr/0QJ+7FWCdeW0jhWBaqK9njxnStbBUNz5UKTfbtD+XKX0RHVqbBZiMw5LS1
	JtRkhA7um7kW4tqlzTVyUdfCDVi6mZk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-NxS8-x-lNG-KVC7lxLbq3w-1; Tue,
 07 Oct 2025 05:53:51 -0400
X-MC-Unique: NxS8-x-lNG-KVC7lxLbq3w-1
X-Mimecast-MFC-AGG-ID: NxS8-x-lNG-KVC7lxLbq3w_1759830830
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1E71800365;
	Tue,  7 Oct 2025 09:53:50 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A766A18004D8;
	Tue,  7 Oct 2025 09:53:47 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 1/3] tools/rtla: Fix --on-threshold always triggering
Date: Tue,  7 Oct 2025 11:53:39 +0200
Message-ID: <20251007095341.186923-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 8d933d5c89e8 ("rtla/timerlat: Add continue action") moved the
code performing on-threshold actions (enabled through --on-threshold
option) to inside the RTLA main loop.

The condition in the loop does not check whether the threshold was
actually exceeded or if stop tracing was requested by the user through
SIGINT or duration. This leads to a bug where on-threshold actions are
always performed, even when the threshold was not hit.

(BPF mode is not affected, since it uses a different condition in the
while loop.)

Add a condition that checks for !stop_tracing before executing the
actions. Also, fix incorrect brackets in hist_main_loop to match the
semantics of top_main_loop.

Fixes: 8d933d5c89e8 ("rtla/timerlat: Add continue action")
Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerlat and hist/top")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Crystal Wood <crwood@redhat.com>
---
v2:
- add one more patch fixing a bug noticed by Crystal in context of
the following one (doing v2 just to avoid conflicts, the first two
patches were not changed)

 tools/tracing/rtla/src/common.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 2e6e3dac1897..b197037fc58b 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -268,6 +268,10 @@ int top_main_loop(struct osnoise_tool *tool)
 			tool->ops->print_stats(tool);
 
 		if (osnoise_trace_is_off(tool, record)) {
+			if (stop_tracing)
+				/* stop tracing requested, do not perform actions */
+				return 0;
+
 			actions_perform(&params->threshold_actions);
 
 			if (!params->threshold_actions.continue_flag)
@@ -315,20 +319,22 @@ int hist_main_loop(struct osnoise_tool *tool)
 		}
 
 		if (osnoise_trace_is_off(tool, tool->record)) {
+			if (stop_tracing)
+				/* stop tracing requested, do not perform actions */
+				break;
+
 			actions_perform(&params->threshold_actions);
 
-			if (!params->threshold_actions.continue_flag) {
+			if (!params->threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
-				/* continue action reached, re-enable tracing */
-				if (tool->record)
-					trace_instance_start(&tool->record->trace);
-				if (tool->aa)
-					trace_instance_start(&tool->aa->trace);
-				trace_instance_start(&tool->trace);
-			}
-			break;
+			/* continue action reached, re-enable tracing */
+			if (tool->record)
+				trace_instance_start(&tool->record->trace);
+			if (tool->aa)
+				trace_instance_start(&tool->aa->trace);
+			trace_instance_start(&tool->trace);
 		}
 
 		/* is there still any user-threads ? */
-- 
2.51.0

