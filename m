Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB541F03DE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893393; cv=none; b=hf+l7YTtdn3/6sxoDpbMSE/AM6Jcxg2XlVMIoEGRQzlXVmhQSohZkvSHRydFd+Z71gMme0xMRYtsxoA2rYm/WL5e0XfGpQf/p8YlmXPMty5/eMdmHN6umh8sfjcUpO0akjDojkiuBQF0vTyX1klGbRl2VvcqDi+UwhtdOL2qUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893393; c=relaxed/simple;
	bh=kpFwhlcTG0rF/I/s8HoWH53BhL4HGJLLXP7MD837SsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=srJwrjE+tugctxt7rL8Df1UPc3KiXiRmmKYjyEVDuizwLg1cN6wr7Eu5cKjDKR9V25ZLAjnNvvgpGzKSQhdw2CoUSzngD8MKZ37+uLbmaS8iFkiS15IwyDdkvYNg1YUN2eMHkZTDgLh7abAvrrEr7LR4dhRI0NOIruoOY9p40v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mrnx7wsg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mrnx7wsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779893390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdPVJ+VpB1x1IM+fdJS5CcHJ7rdqir9ZZNYdpCb0MGg=;
	b=Mrnx7wsg5yHyftirnDM4WxTHLhkYPSpA7R1XSqvJvu2xA+Z4zYWSIlMdiLzVgsq0/oCIyl
	zXZFtbnzENUlnUUht/3LbdyWlwj8sJXoOZt1OV1R1kLWTECvODQNhXI7c6XzyTFW1QXw5C
	uWizTek5evV5/PIorlXAehdf+ceIQfs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-aKYWDmkCOG6kNx3sVFkoKw-1; Wed,
 27 May 2026 10:49:47 -0400
X-MC-Unique: aKYWDmkCOG6kNx3sVFkoKw-1
X-Mimecast-MFC-AGG-ID: aKYWDmkCOG6kNx3sVFkoKw_1779893386
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7372918002F3;
	Wed, 27 May 2026 14:49:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71DB6180034E;
	Wed, 27 May 2026 14:49:43 +0000 (UTC)
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
Subject: [PATCH 3/3] Documentation/rtla: Add -A/--aligned option
Date: Wed, 27 May 2026 16:49:28 +0200
Message-ID: <20260527144928.2944472-3-tglozar@redhat.com>
In-Reply-To: <20260527144928.2944472-1-tglozar@redhat.com>
References: <20260527144928.2944472-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: tjoTrcptIuIloxPVbNc6hKHesEImGCZ0T_CeX5tg91w_1779893386
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Cover the newly added -A/--aligned option that aligns timerlat threads
using the corresponding feature of the timerlat tracer.

A note is added to clarify what alignment means, similar to the note in
the tracer implementation in commit 4245bf4dc58f ("tracing/osnoise: Add
option to align tlat threads").

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_options.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.txt b/Documentation/tools/rtla/common_timerlat_options.txt
index ab159b2cbfe7..0a01fbc93ee1 100644
--- a/Documentation/tools/rtla/common_timerlat_options.txt
+++ b/Documentation/tools/rtla/common_timerlat_options.txt
@@ -95,3 +95,15 @@
         * **full**        Print the entire stack trace, including unknown addresses.
 
         For unknown addresses, the raw pointer is printed.
+
+**-A**, **--aligned** *us*
+
+        Align wake-up of timerlat threads to a set offset in microseconds.
+
+        The alignment will be applied when the threads wake up at the start of tracing while
+        the timer for the first cycle is armed. Each thread sets its timer to the wake-up time
+        of the previous thread plus the alignment.
+
+        This option may be used with any non-negative argument, including zero, which will
+        align threads so that they wake up all at the same time.
+
-- 
2.54.0

