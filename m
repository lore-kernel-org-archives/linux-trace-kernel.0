Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8817A2E5
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405598; cv=none; b=Ym7x9EQYUcGSkd7lCEqT0cdqdSDedN0/kVGchC3IgGBk6a2LwG7Qm/3KDSbjojayjdTU6TIce8QDCPV++iJm+QuyRKZ2g/3fG2xU366rSCGm8SI70EJRtLtOD98mqxC6b/CpdQf5OWuvBlBX5e/NyztH2MSGSpnKSh3NaVFgK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405598; c=relaxed/simple;
	bh=NI9X3DgbmxaxolEB+CWeMI2e6PnbwQP48nhp90OwwL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7sccr92jdgMYQruTocKyWRgCCJoZJeAYpwKogj79wmSvckvC9TbcLdyksj37CJ/xB3SRjd3FL2d6YltKD0pw1vK4wQtI8rAhkisIkmwoDWiq7Jrb8pCJO2yMamSWbehtV/M55UM/Kwh2iih8s5/JogrkMuKyU8yxpt827sHSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28TNrnVK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28TNrnVK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so1151570a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741405596; x=1742010396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwsW/fsMcg9hrgcDTPBIA7gFDpTcqMoDXdqlqDc9hnc=;
        b=28TNrnVKTu9M6VyNHTPFufBtewo0ym7vgZs5rk7FTTZ5PvdkvsJaE1IYAaY9XxCsvN
         63uifaSaSCZlW7bbiF6qCvYASW+GkdXznXoIjpMtvgRlDHhLRX/t1fZ1EBT69E0iAxBl
         s1ykV3KE4rDO8b5kV6s8R8yZ0QDOJj98EcUyv4MF4h8PcQ+Ta71cxEJgtVpZEG2SnTSX
         rWd0vaOhcoQ0uKYyINrPEKjPIwVZIMF+aqHdfZISA3NZK/mT2ZyPwkKa/X3qoESO4zR9
         DXpNfochfIBrEKB6MoQnvBMkQ2TkypAIxnkELg+fl/m7t/V22zrcCKSN1ZDmtF8ByNVr
         wa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741405596; x=1742010396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwsW/fsMcg9hrgcDTPBIA7gFDpTcqMoDXdqlqDc9hnc=;
        b=tWWDtCb7vqVg2AY36lI2HmgkCk4+v49W0mlRMBZUyJPWCzA/S1rbX86fqEdiQWYDsn
         1MftT+CRCSDLzZqozu+hMUQbiwsAZsfjxhL35bFj+OhZ+fPd71G/a/w+xeTD71hAksz2
         92Y678WnFsOGlAWjC30MmujcEA0XXznUKxPG3IghMaGq6gHViJgbTeo3Ss27L8Vm39eC
         8tgo5gx8RrRAtbB89BzfuLvvGO9v5gSmcQbOZxXEv99FpzIW/vFFD+jLp9I4Ab2YA2i4
         fDmXbeezcf6VZ0DGxPfwrMGMLprr6QOoZyCP+rAETL0Jq5OHEA0uDMf+xR+KHiLu6qRx
         rf/g==
X-Forwarded-Encrypted: i=1; AJvYcCU7FVvGScp8dp/NugDtQiVDQOrCQc8Ud4ftsjGshonr3xLhQ6dE9/ll2ZT3MQOzxZ0uYY746eb3w1rnc8VKhfkxhqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXZliPXwrjja+eZ3zaXHiA9aSIC6PWXe8P33Ie91ARZSBxb/D
	zbUdW6FodRSP4YxhyBppPF9WpCLfkdkTCuBU6J4/mnyrac4sN3pP2AOSS+eHyxuUnW9VV88WS5G
	El9ETzohzIGjZzw==
X-Google-Smtp-Source: AGHT+IHRnkN6wrQOrKWkYrcoXo9vtRqSQ8tpu752H1VzwAoAmAJAj3Fmg6NgVlqukZi3r99JBHgGyN9zS8N/9j0=
X-Received: from pjur14.prod.google.com ([2002:a17:90a:d40e:b0:2fc:e37d:85dc])
 (user=liumartin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:254b:b0:2ff:5267:e7da with SMTP id 98e67ed59e1d1-2ffbc1468f9mr3198164a91.3.1741405596445;
 Fri, 07 Mar 2025 19:46:36 -0800 (PST)
Date: Sat,  8 Mar 2025 03:46:02 +0000
In-Reply-To: <20250308034606.2036033-1-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308034606.2036033-1-liumartin@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308034606.2036033-4-liumartin@google.com>
Subject: [PATCH v2 3/3] mm/page_alloc: Add trace event for totalreserve_pages calculation
From: Martin Liu <liumartin@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces a new trace event,
`mm_calculate_totalreserve_pages`, which reports the new reserve value
at the exact time when it takes effect.

The `totalreserve_pages` value represents the total amount of memory
reserved across all zones and nodes in the system. This reserved memory
is crucial for ensuring that critical kernel operations have access to
sufficient memory, even under memory pressure.

By tracing the `totalreserve_pages` value, developers can gain insights
that how the total reserved memory changes over time.

Signed-off-by: Martin Liu <liumartin@google.com>
---
 include/trace/events/kmem.h | 18 ++++++++++++++++++
 mm/page_alloc.c             |  1 +
 2 files changed, 19 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 9623e68d4d26..f74925a6cf69 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -402,6 +402,24 @@ TRACE_EVENT(mm_setup_per_zone_lowmem_reserve,
 		  __entry->lowmem_reserve)
 );
 
+TRACE_EVENT(mm_calculate_totalreserve_pages,
+
+	TP_PROTO(unsigned long totalreserve_pages),
+
+	TP_ARGS(totalreserve_pages),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, totalreserve_pages)
+	),
+
+	TP_fast_assign(
+		__entry->totalreserve_pages = totalreserve_pages;
+	),
+
+	TP_printk("totalreserve_pages=%lu", __entry->totalreserve_pages)
+);
+
+
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e472b1275166..69ceab250979 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5827,6 +5827,7 @@ static void calculate_totalreserve_pages(void)
 		}
 	}
 	totalreserve_pages = reserve_pages;
+	trace_mm_calculate_totalreserve_pages(totalreserve_pages);
 }
 
 /*
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

