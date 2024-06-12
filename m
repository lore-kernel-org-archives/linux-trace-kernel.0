Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B416EBFD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188593; cv=none; b=cJ4kBQpfoVSatgY0rRylYxwsB9TCytCbvhOq2/I+gFRpDKoMk+LsWM6vY0cPrNkMLZynmCXlMa2SPEj3CArUl5gxFQKhJilhNNHC3qFJAVEew3qolOnU+MGguetDayf9A+u9NiIiqJEAljuNL+fMhHTP4KtGPVkPnQ1145ynBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188593; c=relaxed/simple;
	bh=eX0hMDs+PRjjxkDL9dZLNeFINrDNoCX8o2tqm0A4dhM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sVohLiW5vjwIT55NIRVcaSU19xecCy/EYG7yxp+JiPx6jzub0itvgGCOi0BeV/zcOsLft3qE3gx16ocQ2l7IoASRHOBYWbNilkHia5NnUScBi7MG6rW4bZTrHAhxyw7SK9dT4l9qZ/MEqWCBE4nDstHKr7v/MfaMqjoFmsSDNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhSpMeLv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhSpMeLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718188590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=J9SukMWyQNIS5OWhxrsad2CeSFU7AFbK+BapPzKpiNg=;
	b=VhSpMeLvyUTylYwZiySySz77zLc6uYBzTCDT+lzRP7S654W9tflij640ZNai7vyE0BD3zL
	bN/+ScAlUs0JdvCWN2/1+KKJGf2ZYdU1fb19M8Wa9e8vrMeyFcg0eVt0isIMlFVoSt1H4h
	exvS+VIfZg0pYDO9RN5mOUY2iRzezQ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-a9BIPxjXNV-Tve-9jF0Mnw-1; Wed,
 12 Jun 2024 06:36:26 -0400
X-MC-Unique: a9BIPxjXNV-Tve-9jF0Mnw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1002D195608F;
	Wed, 12 Jun 2024 10:36:25 +0000 (UTC)
Received: from localhost (unknown [10.22.8.85])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F11DE19560AA;
	Wed, 12 Jun 2024 10:36:23 +0000 (UTC)
Date: Wed, 12 Jun 2024 07:36:22 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla/osnoise: Better report when histogram is empty
Message-ID: <Zml6JmH5cbS7-HfZ@uudg.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When osnoise hist does not observe any samples above the threshold,
no entries are recorded and the final report shows empty entries
for the usual statistics (count, min, max, avg):

    [~]# osnoise hist -d 5s -T 500
    # RTLA osnoise histogram
    # Time unit is microseconds (us)
    # Duration:   0 00:00:05
    Index
    over: 
    count:
    min:  
    avg:  
    max:  

That could lead users to confusing interpretations of the results.

A simple solution is to report 0 for count and the statistics, making it
clear that no noise (above the defined threshold) was observed:

    [~]# osnoise hist -d 5s -T 500
    # RTLA osnoise histogram
    # Time unit is microseconds (us)
    # Duration:   0 00:00:05
    Index
    over: 0
    count: 0
    min: 0
    avg: 0
    max: 0


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7be17d09f7e85..214e2c93fde01 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -374,6 +374,7 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 {
 	struct osnoise_hist_data *data = tool->data;
 	struct trace_instance *trace = &tool->trace;
+	int has_samples = 0;
 	int bucket, cpu;
 	int total;
 
@@ -402,11 +403,25 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 			continue;
 		}
 
+		/* There are samples above the threshold */
+		has_samples = 1;
 		trace_seq_printf(trace->seq, "\n");
 		trace_seq_do_printf(trace->seq);
 		trace_seq_reset(trace->seq);
 	}
 
+	/*
+	 * If no samples were recorded, skip calculations, print zeroed statistics
+	 * and return.
+	 */
+	if (!has_samples) {
+		trace_seq_reset(trace->seq);
+		trace_seq_printf(trace->seq, "over: 0\ncount: 0\nmin: 0\navg: 0\nmax: 0\n");
+		trace_seq_do_printf(trace->seq);
+		trace_seq_reset(trace->seq);
+		return;
+	}
+
 	if (!params->no_index)
 		trace_seq_printf(trace->seq, "over: ");
 

