Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964316F8E9
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958273; cv=none; b=lvFRcDz2MhBNgRol+46bIyZEjZwD+Bbe92kYgabcCnsGy3TCwcgAd4YWGM7n3oCsKuDO3Scx4pJM2Qz5w0nuOA/bL3SxDn/f5Ot8U7bfTxOVydCSSnUhIAVHa/XLGDMS+E5qtsz6uHupu/6A8ObxdRq3rVBrlPWLhM/dAQKRDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958273; c=relaxed/simple;
	bh=py0PPFc2Z3Eu/s4wBRnKGObvN7Xub9Bvs9CteQbFy8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbOBpFYu5tTCb7sdZAubNCQsAxJ8639hArp5JILKWtVAYpRxtM0JQyWBKzbU2bjlfwn4KsO/L7EpHo4IowmOQ4AUxLc8jXKrlGlFmCsoyXkBsoOrCIsLsVnK4oEoK5TiM3NxLTVluqeiYqYZChUWfcV1pVZxeBUgGsE+7Tu97gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZAby0s2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZAby0s2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727958270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Hl2FfZzxn+kGV/DjBSSLFvJJIbxpboOA9i3mKhddGE=;
	b=XZAby0s2/fZgB3RDO4hz9S/uaU+QzeVbX174R0kcUoREjIqYsu5bl95Ce+m9rxdI/whUxF
	jRWXy7s0eIW+C5ZbZfqhzITjn2wzdD8JUW5W5HyNMkBUs3KhtI5Q7ZEGxs5NHJCVgTLFV0
	lU3nvQRSQ7zpST4cuyISxPj/GV4MM2o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-AY_t0tYIP46NTZzSch3EGA-1; Thu,
 03 Oct 2024 08:24:27 -0400
X-MC-Unique: AY_t0tYIP46NTZzSch3EGA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E03531954B06;
	Thu,  3 Oct 2024 12:24:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.193.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EAB31956046;
	Thu,  3 Oct 2024 12:24:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] tracing: doc: Fix typo in ftrace histogram
Date: Thu,  3 Oct 2024 14:23:35 +0200
Message-ID: <20241003122334.44682-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The Tracing > Histogram page contains a typo in the field display
modifiers table.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/histogram.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 3c9b263de9c2..0aada18c38c6 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -81,7 +81,7 @@ Documentation written by Tom Zanussi
 	.usecs         display a common_timestamp in microseconds
         .percent       display a number of percentage value
         .graph         display a bar-graph of a value
-	.stacktrace    display as a stacktrace (must by a long[] type)
+	.stacktrace    display as a stacktrace (must be a long[] type)
 	=============  =================================================
 
   Note that in general the semantics of a given field aren't

base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
-- 
2.46.1

