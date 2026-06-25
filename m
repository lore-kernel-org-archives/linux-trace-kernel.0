Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA3A3E172E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389777; cv=none; b=AHEMv1QUMFsVGROfwWCWJJVM9sZFeyLG5CoEwbG+a3SnI0Jopq2BP7d7nTWJoE9Z0eIT6Ixd7cqXhTHju0a1wMOg4bu1IILGhepwypvQQ9/doVjptTBLyjYJ1Q2jaGyKNq2cyymqHb9Qj5JtikS/GafeHqepddjgouBQeirJQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389777; c=relaxed/simple;
	bh=U1pqNX+BJ74HEhh6caU62dRwVORV30e9LKR9ULgVQE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ra9nAr1xP5GDBSoRyqag1PxnniF9g677aBcCPMG4Ja+w7/R9/1CcSmJIXDAXCgYvixCh+t3tg1lcoUZ8YdVItKFjgD/KhMOrtEWpbwmq5ZI0v4/2Ub65L7K8vKf+QrtWEkKE2y+3p09pqnvdLCLR21ezLWMQCrzebRSGNxpcfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHqNWtse; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHqNWtse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBJ9kjRIkq6gge4BL/L2/zeS5GDse2As/wY5ov0r78E=;
	b=IHqNWtsetP/GZJ0eNdmCtq9BU9eExRte4CQzQ7lMHOI0ilGzjLSElMefLMQnmhWeYNivbI
	HKYZgSpq1rlGgsNdlUaNbxVXX1f8eIrqa1YVVXhbj/FCgT7ELuNwW42N+TW4xeMwF3A0bL
	mSsY4j0C4w+iukFTGvBof3tChNbapmo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-nIDSxS_gOCKCVMypg4lrLg-1; Thu,
 25 Jun 2026 08:16:12 -0400
X-MC-Unique: nIDSxS_gOCKCVMypg4lrLg-1
X-Mimecast-MFC-AGG-ID: nIDSxS_gOCKCVMypg4lrLg_1782389771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62074193F044;
	Thu, 25 Jun 2026 12:16:11 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A0E63000B4C;
	Thu, 25 Jun 2026 12:16:08 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 16/17] selftests/verification: Rearrange the wwnr_printk test
Date: Thu, 25 Jun 2026 14:14:38 +0200
Message-ID: <20260625121440.116317-17-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: haffAKtyFGhUHTfPoIeRcekVLWq5j9SIzBpm8s1WGXU_1782389771
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The wwnr_printk test expects no reactions in some situations, after
fixing the bash assertion, the test is failing because expecting no
reaction after a previous step had reactions is flaky without making
sure all buffers are flushed.

Simplify the test and run the steps expecting no reaction before the one
expecting reactions. Also simplify the load function to stop loads as
soon as a reaction occurs, this limits the number of lines to flush and
makes tests overall more stable.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../verification/test.d/rv_wwnr_printk.tc       | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
index 96de95edb5..a23d22f6ec 100644
--- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -4,27 +4,30 @@
 # requires: available_reactors wwnr:monitor printk:reactor stress-ng:program
 
 load() { # returns true if there was a reaction
-	local lines_before num
+	local lines_before num load_pid ret
 	num=$((($(nproc) + 1) / 2))
 	lines_before=$(dmesg | wc -l)
-	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
-	dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr does not allow event"
+	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q &
+	load_pid=$!
+	timeout 5 dmesg -w | tail -n +$((lines_before + 1)) | grep -m 1 -q "rv: monitor wwnr does not allow event"
+	ret=$?
+	kill "$load_pid"
+	wait "$load_pid"
+	return $ret
 }
 
 echo 1 > monitors/wwnr/enable
 echo printk > monitors/wwnr/reactors
 
-load
-
 echo 0 > monitoring_on
 ! load || false
 echo 1 > monitoring_on
 
-load
-
 echo 0 > reacting_on
 ! load || false
 echo 1 > reacting_on
 
+load
+
 echo nop > monitors/wwnr/reactors
 echo 0 > monitors/wwnr/enable
-- 
2.54.0

