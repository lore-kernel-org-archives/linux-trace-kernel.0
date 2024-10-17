Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5431DEFF8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174200; cv=none; b=LOa1qBsQmJ55Ys8dGNMhrMOrB3PPasIlOhpliZjiTVwSBRmsSXgxl7ebek1t/76q771yIquvMcE+yH1N+M54CPbIaVckw1ZQ0SebspeZEPXfXulHW9va4zdaKLUflfpQKDm/jlK5HWHEspNNRiOYND91WKCKlS3gIj/3goCgW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174200; c=relaxed/simple;
	bh=iY21IH3eF8iJdFXYvdZBPuYiIxe6V7mRo+rrMEF6eKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmlr4mxkRqWab981fk1CZJMC5eDgl70fNuEeSspu1bQmG+hoEATezH55M4RYYDC+13I8hSN+bE4LE5Hr7k+Zk68z66ht7Ft5j65P3tZiPICXLc+9Cl+rwlvRZSf60QKu8B/9heMqhMIhl+eezMiqJUJZnJ1t37+Iayh8tad2kWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKu0GnIW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKu0GnIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729174198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPNyQIVmdnqt03qJYroky5p+HPi+skedO7eQPH1tSRI=;
	b=aKu0GnIWfr2SmhY7ZKYlhiLEOLkxSFIkdN7AJnje3jjUcMXsO0IrNYhdKTebFi2+O/kC4L
	k7XNaFJDrqYhgaYQ9iLYdSNxmdU99Uy04Cdwq9awmwCChsaxnUtgoXuH1F1TTbw1ho9CKs
	JyLF2kMGz0olz57HP8Js1/nnWp1g6iU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-cAQmYdsiOuatg90TaK7Fjw-1; Thu,
 17 Oct 2024 10:09:55 -0400
X-MC-Unique: cAQmYdsiOuatg90TaK7Fjw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6119C19560AD;
	Thu, 17 Oct 2024 14:09:54 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CFF819560AD;
	Thu, 17 Oct 2024 14:09:52 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v5 6/6] rtla: Documentation: Mention --deepest-idle-state
Date: Thu, 17 Oct 2024 16:09:14 +0200
Message-ID: <20241017140914.3200454-7-tglozar@redhat.com>
In-Reply-To: <20241017140914.3200454-1-tglozar@redhat.com>
References: <20241017140914.3200454-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
2.47.0

