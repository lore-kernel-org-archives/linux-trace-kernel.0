Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793604;
	b=gPkb/22yajIJxrOc9lqKAxmIBj7YEr9awJGSyRDmNDV6D8La4/1eTU4Xf5HyJPa5HtVK
	 f9FVs0NLxFlD5k+0fcEV90XNFBRfUAAJ6/rEm8Mxc5NMyaw3iM6xGyXwdaBjaiLx/8WAA
	 wqPExTTkIK6gjP6NOV21rahhxkL9Un34fjA37BAIeik3HHxyK2Cy0RT2szauj+etqWMhN
	 DjLBN6rHD3l2HRKFxqEtmHIrwHowcyCw85o58ZQuftZTse4l7tE3wfRbugdKMov5nV7+A
	 um93KxI5TTt5tTZYYLKUasoKBCEng63yWG+8LgxieWw8UPrqTaNVB9HN+QQVgghemyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793604;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=h/wMdd7/CkVfdjpe5bmo57/FUZ7xHhSaSEoZmfTVC90=;
	b=tE90pluOeGW7uzPgh7Upkuf/Pvx8kFYQmfGTfH4ge58l9pcRm4jr30rxzbQHadEzmSL4
	 rX4YyJ4pCQOYGAgZoAB8ZYh4jX2UvMEqZ6GHw7Y0lJK6xGy5mpIrwuH2hy4trbLHCFbW2
	 SsCOyC1PK8bLUVJuD4Sf4TFvV+k/0eD+eChT4ugvKAVKNi9JfhyKM3rraoXwQpgJ56+pu
	 BYpEb1Mt+jzzb1kYRSR2nXoIbMjbASb2TEa6aCMuZrX6RMyVE54Xpyem2wxbE13IRA3Wp
	 SUokURYYPM5C8ihc6k47VVbzaoqDmZz6gUpxbIojXCFo9yLrLUOjuOT48lXyod+WQFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ctmKjgyj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463B606A324
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A463B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ctmKjgyj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/wMdd7/CkVfdjpe5bmo57/FUZ7xHhSaSEoZmfTVC90=;
	b=ctmKjgyji1jdYY+ufvABr2qFoBXLPd9WwiZqLr6EN3kP2UeOBhGbOy5Xj8HJxPzo0XouMY
	7zvoPpzSm7yIDyxH7vhZqG9DcyLPt4p5P7pJMqXCJOIZU7CMi2y4N7BYkWvvuFrmxw4THG
	fGKNH1qxtkYpZoiWDrEZj4xpykztlFc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-WNOaReyfNDGuk2oknF3EVQ-1; Fri,
 27 Nov 2026 15:33:18 +0000
X-MC-Unique: WNOaReyfNDGuk2oknF3EVQ-1
X-Mimecast-MFC-AGG-ID: WNOaReyfNDGuk2oknF3EVQ_1795793597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4F16195422D;
	Fri, 27 Nov 2026 15:33:17 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF0A91955F76;
	Fri, 27 Nov 2026 15:33:15 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 08/10] rtla/timerlat: Save the trace clock at measurement start
Date: Fri, 27 Nov 2026 16:32:04 +0100
Message-ID: <20261127153206.134322-9-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sg41DwzdAbZL5nIJNF7x4CmOGGSBgZ0GehoXjIhgCnY_1795793597
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Save the measurement start reference after the warm-up and before any
instance starts tracing. The per-CPU clock is shared by all instances,
so the clock is read once and copied to the record and auto-analysis
instances.

Reading the reference before tracing is enabled avoids perturbing an
already running measurement, and keeping the read in the enable path
avoids re-reading it when tracing is restarted with --on-threshold
continue.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 169aa9a6569d6..8ae8241978491 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -173,6 +173,20 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 	}
 
+	/*
+	 * Save the measurement start reference before any instance starts
+	 * tracing: the per-CPU clock is shared by all instances, so a single
+	 * reading is enough for all of them.
+	 */
+	if (!params->no_aa) {
+		if (trace_instance_save_start(&tool->trace,
+					      &params->common.monitored_cpus))
+			debug_msg("Could not read all the start timestamps\n");
+		if (tool->record)
+			trace_instance_copy_start(&tool->record->trace, &tool->trace);
+		trace_instance_copy_start(&tool->aa->trace, &tool->trace);
+	}
+
 	/*
 	 * Start the tracers here, after having set all instances.
 	 *
-- 
2.56.1

