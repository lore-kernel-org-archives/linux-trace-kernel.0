Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB950308F26
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168171; cv=none; b=iNprZHbvm7bMz88vg+kZVhYuCOrVcCQ51f5wmYr/Jr4reYO9ba98PxjTlzIiGq8g4n1h/5oqZBCXqRB8uZDKy4cDsgTUt++ctt7JOMJuGnLuZp5oDZ+NtPrqokmxz+yGQ0/RnMMeOWAGJ6orFR2M/G7nZ0CYxSyHiUW3bivnAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168171; c=relaxed/simple;
	bh=eD1PWDaHGsgjL84lRbHENXkGOB17roHnhotuHZoVJLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2sHLcgr/Jjq6LqdKIdsuK6xs0wXvcuDZ/mosD/DuvxXfm2wuxlWZHeaHGUEQBvm74CtkoTKbEJcP6P7ax4mMVJaMApVzlXn0ov0iWCa/bB94OkXc2FUQIIUEyQVSbKvqYDXsrJGXrFM83gcFNRpQqGybLnd3BIyUz3h111XN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/1abZh1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/1abZh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dY22nWp5keVSnEHuBJ8H55WEBcTJdpzMuvZ42aGcmhY=;
	b=G/1abZh1pAWp49k2i3q2/8mYtbQMbiEGd+VRbfXf6YkO5EFsaK1wNd087O81aSjiaBKU5Q
	eGsOflJuWyiutqsXN6rzFgWgp4BYsPA4yt3XbnfuVqLFSwMRWpdIozsQCpNe/zt8y/NZS3
	2PTlbLZcOQ0vL4VLIFVGp7eN6YO66OY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-ZyTEHPYRNf-NhVvBRNpBNw-1; Wed,
 26 Nov 2025 09:42:45 -0500
X-MC-Unique: ZyTEHPYRNf-NhVvBRNpBNw-1
X-Mimecast-MFC-AGG-ID: ZyTEHPYRNf-NhVvBRNpBNw_1764168163
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FA7319541A7;
	Wed, 26 Nov 2025 14:42:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25CBC30044EE;
	Wed, 26 Nov 2025 14:42:39 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 6/7] Documentation/rtla: Rename sample/ to example/
Date: Wed, 26 Nov 2025 15:42:04 +0100
Message-ID: <20251126144205.331954-7-tglozar@redhat.com>
In-Reply-To: <20251126144205.331954-1-tglozar@redhat.com>
References: <20251126144205.331954-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The sample/ directory in tools/tracing/rtla was renamed to example/ in
an earlier commit.

Rename it also in the documentation.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.txt b/Documentation/tools/rtla/common_timerlat_options.txt
index 33070b264cae..0cf7eca1f7b6 100644
--- a/Documentation/tools/rtla/common_timerlat_options.txt
+++ b/Documentation/tools/rtla/common_timerlat_options.txt
@@ -64,4 +64,4 @@
 
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
-        See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+        See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
-- 
2.51.1

