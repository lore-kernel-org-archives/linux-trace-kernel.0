Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A5190462
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864194; cv=none; b=gfo4Bs4bDZZmbvFauOGBd3lK9Yhb92dBgXL+MF9hdSlDKEAc7/grX0JADB3gE8dxsD5KL5nJVaz3rLiLyz8sqk0J6DMzTs6oH2QSnlJbe8fFcxt6aL4HTcnzcsw1xc/aUm4Pea9f8feLxSYOxpmGL5upatuv7T78aBPkfptOn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864194; c=relaxed/simple;
	bh=LMj5rhRFqnrHfDcT6VaaFlcCmAbdPhNnzOV+/AzY8ws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eYCWpg+74EJjvvNGt9ZxLaEpOo3mTxE98PBmAgSsf2slYcRo/TDUgvK9Y6Xd8LrBAph2gdBfRegJZx8313Ezg2QMYoYdoTzWaO87UHFDkCL+QTjATp5B0bnVmOQGJsLQDiO52jC8hyqLh1ZJAd/HDBMLDDpIgIZHohBftnmRDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWfNeJHm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWfNeJHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0szSBMKq3bi1BM65D50ndvrCiTCipHHqtfMmivl635Y=;
	b=AWfNeJHmjnY3JmfXVHBdHAPglY+HE5eKiYcLD3FC5e+CqCp3iCmhNJs6bxoCyLWMnzzeu+
	1/VeOL2zGsFBSsW6Qr8GT2QfMkKbW4tA/JZAiElwxypw4O0ClAkrY5nkMtYZEKeQE7/VZb
	JEmcuFvEMpcWLbTiuwiMOTY+aFrleVg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-2NMBgsh9OoK_W1Ikoc5GJA-1; Mon,
 23 Feb 2026 11:29:51 -0500
X-MC-Unique: 2NMBgsh9OoK_W1Ikoc5GJA-1
X-Mimecast-MFC-AGG-ID: 2NMBgsh9OoK_W1Ikoc5GJA_1771864190
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F153E195605A;
	Mon, 23 Feb 2026 16:29:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6CAB1800673;
	Mon, 23 Feb 2026 16:29:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 14/19] rv/rvgen: make monitor arguments required in rvgen
Date: Mon, 23 Feb 2026 13:17:57 -0300
Message-ID: <20260223162407.147003-15-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 13TjfbMtjL7EgLXCiKClrDT6rx4MVUpdKV6m3fseuJs_1771864190
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add required=True to the monitor subcommand arguments for class, spec,
and monitor_type in rvgen. These arguments are essential for monitor
generation and attempting to run without them would cause AttributeError
exceptions later in the code when the script tries to access them.

Making these arguments explicitly required provides clearer error
messages to users at parse time rather than cryptic exceptions during
execution. This improves the user experience by catching missing
arguments early with helpful usage information.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/__main__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 2e5b868535470..5c923dc10d0f0 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -31,10 +31,11 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-n', "--model_name", dest="model_name")
     monitor_parser.add_argument("-p", "--parent", dest="parent",
                                 required=False, help="Create a monitor nested to parent")
-    monitor_parser.add_argument('-c', "--class", dest="monitor_class",
+    monitor_parser.add_argument('-c', "--class", dest="monitor_class", required=True,
                                 help="Monitor class, either \"da\", \"ha\" or \"ltl\"")
-    monitor_parser.add_argument('-s', "--spec", dest="spec", help="Monitor specification file")
-    monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
+    monitor_parser.add_argument('-s', "--spec", dest="spec", required=True,
+                                help="Monitor specification file")
+    monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True,
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
     container_parser = subparsers.add_parser("container", parents=[parent_parser])
-- 
2.53.0

