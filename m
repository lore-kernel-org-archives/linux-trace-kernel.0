Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A42E9755
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046430; cv=none; b=DPH7XPAZTlxRuE9Cbrjshv0W9ptNrJ2WVlwxfRzJaa+AM3vC89phzNfkPiIiI1z+pRtkSDtrI027/nJ6oVBMA+ACw4ezF4nqbDIgSq3Oq57VywKq0gjYbvN2i0i7kWGbpnfgo8/PMNVxCHxcfgo18Q2MwfyY2xskAhr6ta4wLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046430; c=relaxed/simple;
	bh=fPcIX8fp3mJsS5Q1flExwFks1I1x70RSSUO552JaDNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf8q09NdlAsGbROj3hbn50zECPrvTYBU5ha6GgLzHz8t9Q2XLc5Tk1iKzWb1WdkNFmgzST3trGC3j9HXfj/QpoHbZ92sRABJiSG5tRyWqjm4Uz/Cyaqr4qPYyKX5NdPdJkoE2EFc35IILMxfuPuxKEnnPihSPXrnMDdIXpyywM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnYHUmIt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnYHUmIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763046427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbeObiU36nTjaYg0u9GHam1yFcnev2OSKEbyP2/eY5c=;
	b=YnYHUmItkf3TAVfaS6xlDvzYoarOThUWVQHk4UcfF2d2IeTPedxZqmGyq9MXyxQ23wQXY4
	CFcEL0oVDRnziIVuIoJe7dvQ/AFxgf6cff0AuwyLfaQO2qtWZdTDyNNB/UfA2eRMQeABaK
	HXGnjxvl3CW91I86qdH6fxDStgoR69Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532--Ip3naHzNraJs20jv--39Q-1; Thu,
 13 Nov 2025 10:07:04 -0500
X-MC-Unique: -Ip3naHzNraJs20jv--39Q-1
X-Mimecast-MFC-AGG-ID: -Ip3naHzNraJs20jv--39Q_1763046423
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB46D1800452;
	Thu, 13 Nov 2025 15:07:02 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F355030001A4;
	Thu, 13 Nov 2025 15:06:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: rostedt@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: [for-trace:latency/for-next PATCH] rv: Fix compilation if !CONFIG_RV_REACTORS
Date: Thu, 13 Nov 2025 16:06:18 +0100
Message-ID: <20251113150618.185479-2-gmonaco@redhat.com>
In-Reply-To: <c4bb3aa4a73c0ec815bdc30c104b6f90fae5ed39.camel@redhat.com>
References: <c4bb3aa4a73c0ec815bdc30c104b6f90fae5ed39.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The kernel test robot spotted a compilation error if reactors are
disabled.

Fix the warning by keeping LTL monitor variable as always static.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511131948.vxi5mdjU-lkp@intel.com/
Fixes: 4f739ed19d22 ("rv: Pass va_list to reactors")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

This patch fixes a patch that was just merged to trace:latency/for-next.
It builds locally with both configurations. I started another kernel
robot run and, if it passes, I'm going to send a pull request with only
this.

 include/rv/ltl_monitor.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 00c42b36f961..eff60cd61106 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -17,12 +17,7 @@
 #endif
 
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
-
-#ifdef CONFIG_RV_REACTORS
 static struct rv_monitor RV_MONITOR_NAME;
-#else
-extern struct rv_monitor RV_MONITOR_NAME;
-#endif
 
 static int ltl_monitor_slot = RV_PER_TASK_MONITOR_INIT;
 

base-commit: 69d8895cb9a9f6450374577af8584c2e21cb5a9f
-- 
2.51.1

