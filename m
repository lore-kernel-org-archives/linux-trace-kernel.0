Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D21C36
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405589; cv=none; b=iEUvlGaIgbIRk30MGQjoScCmTQzHbMB/uhS82jOI2pI9mKuIwfNxXnYCIlaN+Z/L7fgnlCArHeihGYaEMSHTTG47StCDc3CNFt9xM7SPTAZZMRE69YS9XWuiZYY3h3kCsyLqbgHbT/e52gfNt3XWtDYpOuOhr/gX6ZgK33rPInM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405589; c=relaxed/simple;
	bh=rvQRWCu9cS772ZrTi4BEdrbP1w2fnh2vicivjIigjvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hg2qtJc7Z5I0ew8upWR/ueZFkDppkFHX5y2DuZyeizxJxi2KVKTePcpnFVJk/EaFX6e4syYIa6jnocQuMzBNdn1DD56nUARuTwEIo1cehRjsyNEInErE2017/U20uwKqw7AXjR/IqBjOuXq3kLuckrmuLUm1CNrVlYSs5uXXh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbxbZLMZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbxbZLMZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ca2a4a5so14854695ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741405587; x=1742010387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfcaNFAbCYfNTjpD5XRwdqCXVY7RMkDJJWe0/7joWPU=;
        b=IbxbZLMZh++mBXcNZvDirbOzqKxEpwtTwEcnNmvMV2FgVDttzpLg2YIE77rYq7KX5R
         Sl9Pe90BlPL8xy6UIM5Tw7AE1ZtaJJQ1jWBxO4EJAd5NievmLMcWpCb6GyHxqaB+zIo6
         bZdnhbZPKihMQfvMNrvKc2xKZllLnwyvAnqxZRCNXjLSOK6HFBD8cYjLVm6lJDrCHcBl
         iX8Fk7/gjopnKKFVhzypGSGo0kL8FjtfYNfeCr6TY41dGsl/VqNGs5a5zT08hsQe6+dm
         Wb2Zw94KSaPJBXlqROTQ83fpZ1ezkSEWe4EBlJM0CoZighK8bXmVC/45UtsL5tnHcTfW
         QE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741405587; x=1742010387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfcaNFAbCYfNTjpD5XRwdqCXVY7RMkDJJWe0/7joWPU=;
        b=MMwSN6cdmkVZPRc69+UWqDQCMVzN52yF0iJaVyfHee2+LQkKOtImXGzqU2Q3+TVUnN
         yHGGXbPL/5jXJgXdqx/p4U3Ugjnm9OBqncQ+Bj8wS0XKgP/gLmM++0+PTHiUX89+rSDM
         1ZK6LsBliKbfNJnk36LSC4FXt4JRwvbam/uyVYfKWlcOq0NWgchaioSd5SBmWuxFQKrA
         dvDZOht7ovj2WkYyxot5D2dbykXHZy8ZUVex8OA/brylq71NRDHRhc2EBbZCn9BWLGUM
         NmfGd5oMVKfMa0F+VY8LW+SUhe8LHOQMjPsvuL6waBjRnRferWOobt9ZR36yzA2JyFR6
         ChdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoH0cnohvB68X8CbJqfbQ/+WsaOThtURQ8PE8FZ6U3MZR5+F3FVAJXE9CI6OwXR5/xxnQLmwmGIFg92FlhnkXXMPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySa77LPFQ+VSaytBs8+vcg8ksoxPKasyNgx4VfxXJYejB9REkp
	I+l2DOdNat7YodtR01y452PpVLU8FGk/l9nk9/sia85oUpPgMRlMoWsSqRUfC/N/2EROVx+a9Gk
	jDkwdFENUA4ggtw==
X-Google-Smtp-Source: AGHT+IFCL+xm6Fwg3GqZF4t7IcDWhXaeSW59E7l9ZedWtDNW1moTHW3B12u5d+oN/PjxO3PrRmaNltxn/VkJRYw=
X-Received: from pfri16.prod.google.com ([2002:aa7:8d90:0:b0:736:46a8:452d])
 (user=liumartin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e88:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-736aaa229dbmr7080003b3a.13.1741405587197;
 Fri, 07 Mar 2025 19:46:27 -0800 (PST)
Date: Sat,  8 Mar 2025 03:46:00 +0000
In-Reply-To: <20250308034606.2036033-1-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308034606.2036033-1-liumartin@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308034606.2036033-2-liumartin@google.com>
Subject: [PATCH v2 1/3] mm/page_alloc: Add trace event for per-zone watermark setup
From: Martin Liu <liumartin@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces the `mm_setup_per_zone_wmarks` trace event,
which provides detailed insights into the kernel's per-zone watermark
configuration, offering precise timing and the ability to correlate
watermark changes with specific kernel events.

While `/proc/zoneinfo` provides some information about zone watermarks,
this trace event offers:

1. The ability to link watermark changes to specific kernel events and
logic.

2. The ability to capture rapid or short-lived changes in watermarks
that may be missed by user-space polling

3.  Diagnosing unexpected kswapd activity or excessive direct reclaim
triggered by rapidly changing watermarks.

Signed-off-by: Martin Liu <liumartin@google.com>
---
 include/trace/events/kmem.h | 33 +++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |  1 +
 2 files changed, 34 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..5fd392dae503 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -342,6 +342,39 @@ TRACE_EVENT(mm_alloc_contig_migrate_range_info,
 		  __entry->nr_mapped)
 );
 
+TRACE_EVENT(mm_setup_per_zone_wmarks,
+
+	TP_PROTO(struct zone *zone),
+
+	TP_ARGS(zone),
+
+	TP_STRUCT__entry(
+		__field(int, node_id)
+		__string(name, zone->name)
+		__field(unsigned long, watermark_min)
+		__field(unsigned long, watermark_low)
+		__field(unsigned long, watermark_high)
+		__field(unsigned long, watermark_promo)
+	),
+
+	TP_fast_assign(
+		__entry->node_id = zone->zone_pgdat->node_id;
+		__assign_str(name);
+		__entry->watermark_min = zone->_watermark[WMARK_MIN];
+		__entry->watermark_low = zone->_watermark[WMARK_LOW];
+		__entry->watermark_high = zone->_watermark[WMARK_HIGH];
+		__entry->watermark_promo = zone->_watermark[WMARK_PROMO];
+	),
+
+	TP_printk("node_id=%d zone name=%s watermark min=%lu low=%lu high=%lu promo=%lu",
+		  __entry->node_id,
+		  __get_str(name),
+		  __entry->watermark_min,
+		  __entry->watermark_low,
+		  __entry->watermark_high,
+		  __entry->watermark_promo)
+);
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c..50893061db66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5920,6 +5920,7 @@ static void __setup_per_zone_wmarks(void)
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
+		trace_mm_setup_per_zone_wmarks(zone);
 
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

