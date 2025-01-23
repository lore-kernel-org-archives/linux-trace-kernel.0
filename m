Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6D212B3B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642260; cv=none; b=XgA2HjKxy1Ik9CqdNPu8x/jybllrI5/aWcQR/PB51/VSotzymQ0ubj6GJCIWGk6gBbKCFCiN6lUbaJMo+xF0OoLZL8Qtt3u/Bj007QUNpOOqDmOpCqnhO5Up9+/lnrpm5eOyOXZAfNy+LZMhJqo+THZqCZF/GvRr0hJnVzkhWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642260; c=relaxed/simple;
	bh=vzV1pu569wUAZZPK2GM3xIcUxpgyTnYsnbHAqylWgVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCZtgSDAV/xKrv1/41bTryjFnNv/xiZ1eXkRiBVjayMSWl2HrKfTw+YWU4klLktcYytbYSVnXlQ2e/HDwvIEzoMBzcwnk0qQEsNY/5qqeMrIcDjTlgnhWhV4Wj+BHEJtKENrvkXp6bbF7L+D34E27Yuu64bL8X3h9iM/36eDyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J65kmbWo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J65kmbWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737642257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhEbJ0twsd+a13mE/uEYxjwrWT3AcdPk5UPVwuPtOrE=;
	b=J65kmbWor1OlCNxNtabHEgVxc1B9ZVphTFSpH29KPALnVhB8bfXiMYX27V5wX+NJWiTIUJ
	ADMPumotYmvf5wmo3hyynDjfrAiHz2hGmQZ71ZTd+O1qzvs/qUS2x9gLECBcdhgVx1WIcz
	MIPYIgmJd3BGgmapt/rSyq+xpYluGzI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-OUpqexOXM2qDqRPhMcYNVw-1; Thu,
 23 Jan 2025 09:24:16 -0500
X-MC-Unique: OUpqexOXM2qDqRPhMcYNVw-1
X-Mimecast-MFC-AGG-ID: OUpqexOXM2qDqRPhMcYNVw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90E261955DCF;
	Thu, 23 Jan 2025 14:24:15 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AD28195608A;
	Thu, 23 Jan 2025 14:24:13 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/4] rtla: Report missed event count
Date: Thu, 23 Jan 2025 15:23:39 +0100
Message-ID: <20250123142339.990300-5-tglozar@redhat.com>
In-Reply-To: <20250123142339.990300-1-tglozar@redhat.com>
References: <20250123142339.990300-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Print how many events were missed by trace buffer overflow in the main
instance at the end of the run (for hist) or during the run (for top).

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 1 +
 tools/tracing/rtla/src/osnoise_top.c   | 1 +
 tools/tracing/rtla/src/timerlat_hist.c | 1 +
 tools/tracing/rtla/src/timerlat_top.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 214e2c93fde0..21376c00bcb3 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -440,6 +440,7 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 	trace_seq_reset(trace->seq);
 
 	osnoise_print_summary(params, trace, data);
+	osnoise_report_missed_events(tool);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 45647495ce3b..3d3daf12538d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -280,6 +280,7 @@ osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
 
 	trace_seq_do_printf(trace->seq);
 	trace_seq_reset(trace->seq);
+	osnoise_report_missed_events(top);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4403cc4eba30..c18b3456a3d5 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -656,6 +656,7 @@ timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *t
 
 	timerlat_print_summary(params, trace, data);
 	timerlat_print_stats_all(params, trace, data);
+	osnoise_report_missed_events(tool);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4..8869a0988955 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -435,6 +435,7 @@ timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *to
 
 	trace_seq_do_printf(trace->seq);
 	trace_seq_reset(trace->seq);
+	osnoise_report_missed_events(top);
 }
 
 /*
-- 
2.48.1

