Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DC2D5948
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760884; cv=none; b=pk4uZ+TIww53E60SLFjNtQhZx/tppDWSqgauvO/CAB7rTLphozp7G4b1ajQCMBaC6bbL/Vd1zR59uMwDtkFaqaXkCtzUC4md9T8TilFmcJwnNPgyKTJNr5jDxIzDtwrQy02Ouo315Y4Eqe9B3AvYNeTNTV5XeABLlMuaxiaOcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760884; c=relaxed/simple;
	bh=xVtfM3JRYSqC+SIoH93jwT1PFhhCKThPkZrcS1esKR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0jherUc22DBlMJd87rUCClmshZNWs24htepaMppfL2Z79FUlXDlMa6Xp5uYDrGD3+U6K56aI4HyqQo7TjkhNX10eblLeQHFsKPoQkgWqdkatPp8Vy8fih1FIsi9c/z0p3kug22PbFszBeeRHNGh6PCK8Tjgbrpry0i7VVOTr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwrUHtCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwrUHtCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759760881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4YREhDhTKRj23jxYbDvCNJFLgooe91K9tKdJ9eclRr8=;
	b=WwrUHtCfhk6NX/Xe+VWn2h9mlx78IhyAEHCFCKo3VzWO34HCY+5+5Hygtbl9YJKKz8I371
	kc8uw8niw62Gc++jjOh2s6uTAz4Kchskw3hszSu2P8taPCVrzzvfzF4Yad0EHguXe34Xr+
	k9LrWT7DWtZEwB5+jHs1vY4TEgbUcCA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-fOwlC6smPGijgxE-Gr_kvA-1; Mon,
 06 Oct 2025 10:27:59 -0400
X-MC-Unique: fOwlC6smPGijgxE-Gr_kvA-1
X-Mimecast-MFC-AGG-ID: fOwlC6smPGijgxE-Gr_kvA_1759760878
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF784180034A;
	Mon,  6 Oct 2025 14:27:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B386A180035E;
	Mon,  6 Oct 2025 14:27:55 +0000 (UTC)
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
Subject: [PATCH 1/2] tools/rtla: Fix --on-threshold always triggering
Date: Mon,  6 Oct 2025 16:26:14 +0200
Message-ID: <20251006142616.136296-1-tglozar@redhat.com>
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
---
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

