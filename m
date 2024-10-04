Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E94148827
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035473; cv=none; b=LBdhiTSr0WwCC+hYkc2mfVNeDLJpQQ+CBsYzp4bkCuSM9vNVzZKZXMdGQmLEh3lSOYkD//H8MWPA4P91YKJ9UXWdYJLvBC0zoyIcqK9gnz89Uo/HBspu7HJcQFNrck3lPAZCuHkV+bPJMzomk0a+palrBMKW6/9cmWlNnXRRtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035473; c=relaxed/simple;
	bh=9F2uPd8roFeepy1Bnw8J121BG0ZL35cWvxF4RS+8ZSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acKnYyC3FFBUlYIPUtIkA95jvelXquUgw6+bTi919GEBR7UIkaSL3WX84D8wln1EbqOUowQf87l/2PjUkWUU9oQWbBPge2CfrhzcweARv+GxE3AGtyuPgJVb0aZpGooT0OqI4nQH3qzBdQmkcjN6pTmOaPgN022fv+x1gsZKz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaVvI7c2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaVvI7c2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728035471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RLpiA7AShPd7g4GTVrGj9nldU4+h9pRmGoRNB9um7g=;
	b=LaVvI7c2o4l2Xq0eIcsSRgtTuvkjcJ4eYmFwqxW7TIvPCoVcewnwGAmJam/PjeSglHwicf
	+FsN8E5woYu6YF4MUSyNfLlfNAP/RB4624r5frs9LJ9Jzotfwf7XUMLv6c1+a313JLwR4C
	yb3qHpciwZAiJuKxLmuRDstllqMqwTE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-LJiOQPHKM2e2uxLQtVOSHA-1; Fri,
 04 Oct 2024 05:51:10 -0400
X-MC-Unique: LJiOQPHKM2e2uxLQtVOSHA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB8491955E8C;
	Fri,  4 Oct 2024 09:51:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 332853000198;
	Fri,  4 Oct 2024 09:51:05 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH RESEND v3 6/6] rtla: Documentation: Mention --deepest-idle-state
Date: Fri,  4 Oct 2024 11:50:14 +0200
Message-ID: <20241004095014.2492813-7-tglozar@redhat.com>
In-Reply-To: <20241004095014.2492813-1-tglozar@redhat.com>
References: <20241004095014.2492813-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Add --deepest-idle-state to manpage and mention libcpupower dependency
in README.txt.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.rst | 8 ++++++++
 tools/tracing/rtla/README.txt                        | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index cef6651f1435..10dc802f8d65 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -31,6 +31,14 @@
         *cyclictest* sets this value to *0* by default, use **--dma-latency** *0* to have
         similar results.
 
+**--deepest-idle-state** *n*
+        Disable idle states higher than *n* for cpus that are running timerlat threads to
+        reduce exit from idle latencies. If *n* is -1, all idle states are disabled.
+        On exit from timerlat, the idle state setting is restored to its original state
+        before running timerlat.
+
+        Requires rtla to be built with libcpupower.
+
 **-k**, **--kernel-threads**
 
         Use timerlat kernel-space threads, in contrast of **-u**.
diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index 4af3fd40f171..dd5621038c55 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -11,6 +11,7 @@ RTLA depends on the following libraries and tools:
 
  - libtracefs
  - libtraceevent
+ - libcpupower (optional, for --deepest-idle-state)
 
 It also depends on python3-docutils to compile man pages.
 
@@ -26,6 +27,9 @@ For development, we suggest the following steps for compiling rtla:
   $ make
   $ sudo make install
   $ cd ..
+  $ cd $libcpupower_src
+  $ make
+  $ sudo make install
   $ cd $rtla_src
   $ make
   $ sudo make install
-- 
2.46.2

