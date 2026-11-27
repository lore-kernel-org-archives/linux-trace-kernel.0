Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793604;
	b=WbTBotfhxXb7o6Ped3TaOy/Hu0kO9VMoGaL4H3s4lfkzyfkSkYb++4tzwi2fM/DiWle/
	 j7Cak9TU8szwGdLAXCL2AlWv01FpX3IEnJpfcFNethfjzL1x6SX7AmfGwu7L/5IYNu8LH
	 AubL6rSX9evvo5RxsG2EPamhcWL48SAwFkv9JVYhrbh9oLnWiWunyQvox8z2fyE56wlse
	 EDpWfw/cm9FLhAEUJXfEg42BrJyAK264EGUep/MqR8XN41IJSVlxipQkGmvuYs5vP9J2a
	 +11fyn8frDe3U6BnPWeTtJYUzJXTTDuy5H9Glu7ZGV0k80Wu1jaiQP9HCsEjmCkBvsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793604;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=hDeNAFms5e7MMt1nb95CeiUQANWGpnmxK1Xph46MjKk=;
	b=ELWoFdQ85sB3DKpu+Yubu1lxfLB3xgj7MUVtu2um67ddlTTuU0hYtojSTZXxeL9DchEQ
	 VZ8eqGkrAK/fePH05239xHzCQ4qK8+QhrMv6s8AebP5oopRlv+qbP1Bf5by/EaK+aPjXY
	 O3poRU1chX2rSAfz//dmf1cNckBzhTFrzG0BHNmzLRkkeqeCQap8Fc4VrJOwrRbQjQlPl
	 Cd7bsmiEguAcXiCgF8LMMPvi7cXkUkIy8NkJtOczvTMqE2zh3QwIDO+glM/2sMsc/o8ZU
	 ot3avN6i2rOHN5B6AD9a5Zsm35//Y3E5UHHlrfgFo/6rW/xqZPigC8dm4lflR9RoGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8MSGnE4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E4606A6A4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291E4606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8MSGnE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDeNAFms5e7MMt1nb95CeiUQANWGpnmxK1Xph46MjKk=;
	b=C8MSGnE44CkMq/+lB9X9duvZwWccybRHcHlbQA9KGMmyq7a5imWTD/evodlFETyymlMEDt
	H/fwl4Ua+tjYo7A50sLswgEl3YSRxxJ4D44YzOQoa2kVkn3cRu9hJuGY2Zshep+vw1O7SU
	l/+o5gXuQIQJmYu0GPwEEWPSLEcttbo=
X-MC-Rep: binary re single
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-0dc-eI42M8eBEmFkBTU6CQ-1; Fri,
 27 Nov 2026 15:33:21 +0000
X-MC-Unique: 0dc-eI42M8eBEmFkBTU6CQ-1
X-Mimecast-MFC-AGG-ID: 0dc-eI42M8eBEmFkBTU6CQ_1795793600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29EBC1800612;
	Fri, 27 Nov 2026 15:33:20 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CFD21955F00;
	Fri, 27 Nov 2026 15:33:17 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 09/10] rtla/timerlat_aa: Print time offset and seqnum of the spike
Date: Fri, 27 Nov 2026 16:32:05 +0100
Message-ID: <20261127153206.134322-10-tglozar@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4POO2QcoBNS6du2rtwTO5PMBoQAgwl21tg-WFeOhVkA_1795793600
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Print the time elapsed since the beginning of the measurement, taken from
the triggering sample, and the sequence number of that sample in the
latency spike header.

This makes it possible to tell multiple spikes apart, which is useful
when tracing is not stopped on the first occurrence, for example with
--on-threshold continue.

The time is printed as days, hours, minutes, seconds and milliseconds,
prefixed to the existing header. If the start reference is not available,
the header keeps its previous format, with the sequence number appended.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c | 42 ++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 11ddceab208ac..3c9b86e2f40cc 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -570,14 +570,30 @@ static int timerlat_aa_kworker_start_handler(struct trace_seq *s, struct tep_rec
 	return 0;
 }
 
+/*
+ * timerlat_aa_format_elapsed - format a duration as days/hours/min/sec
+ */
+static void timerlat_aa_format_elapsed(unsigned long long ns, char *buf,
+				       size_t len)
+{
+	unsigned long long sec = ns / 1000000000ULL;
+
+	snprintf(buf, len, "%3llud %02llu:%02llu:%02llu.%03llu",
+		 sec / 86400, sec / 3600 % 24, sec / 60 % 60, sec % 60,
+		 ns / 1000000 % 1000);
+}
+
 /*
  * timerlat_thread_analysis - Prints the analysis of a CPU that hit a stop tracing
  *
  * This is the core of the analysis.
  */
 static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
-				     int irq_thresh, int thread_thresh)
+				     int irq_thresh, int thread_thresh,
+				     unsigned long long start_ts)
 {
+	unsigned long long seqnum, tstamp;
+	char elapsed[32];
 	long long exp_irq_ts;
 	int total;
 	int irq;
@@ -588,9 +604,23 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	if (taa_data->tlat_irq_seqnum > taa_data->tlat_thread_seqnum) {
 		irq = 1;
 		total = taa_data->tlat_irq_latency;
+		tstamp = taa_data->tlat_irq_timstamp;
+		seqnum = taa_data->tlat_irq_seqnum;
 	} else {
 		irq = 0;
 		total = taa_data->tlat_thread_latency;
+		tstamp = taa_data->tlat_thread_timstamp;
+		seqnum = taa_data->tlat_thread_seqnum;
+	}
+
+	if (start_ts && tstamp >= start_ts) {
+		timerlat_aa_format_elapsed(tstamp - start_ts, elapsed,
+					   sizeof(elapsed));
+		printf("[%s] ## CPU %d hit stop tracing, analyzing it ## (seqnum %llu)\n",
+		       elapsed, cpu, seqnum);
+	} else {
+		printf("## CPU %d hit stop tracing, analyzing it ## (seqnum %llu)\n",
+		       cpu, seqnum);
 	}
 
 	/*
@@ -829,11 +859,13 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 
 		if (irq_thresh && taa_data->tlat_irq_latency >= irq_thresh) {
-			printf("## CPU %d hit stop tracing, analyzing it ##\n", cpu);
-			timerlat_thread_analysis(taa_data, cpu, irq_thresh, thread_thresh);
+			timerlat_thread_analysis(taa_data, cpu, irq_thresh,
+						 thread_thresh,
+						 taa_ctx->tool->trace.start_ts[cpu]);
 		} else if (thread_thresh && (taa_data->tlat_thread_latency) >= thread_thresh) {
-			printf("## CPU %d hit stop tracing, analyzing it ##\n", cpu);
-			timerlat_thread_analysis(taa_data, cpu, irq_thresh, thread_thresh);
+			timerlat_thread_analysis(taa_data, cpu, irq_thresh,
+						 thread_thresh,
+						 taa_ctx->tool->trace.start_ts[cpu]);
 		}
 
 		if (taa_data->max_exit_idle_latency > max_exit_from_idle) {
-- 
2.56.1

