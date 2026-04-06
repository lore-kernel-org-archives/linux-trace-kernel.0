Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E756388E5E;
	Mon,  6 Apr 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492713; cv=none; b=S28nZU38Bm8/kSJvCub6Kgkqrdg0J0HIocKVVjVtEIU+EvROU2PUUvhYiN9p3fGUyXLw+svObneo0pXFbCdM9SRrcYcII+YfF4wxi/KzTv2c6STDm/7g+YU13XPyZHJzqIoVrXrkV+qhJnb0LYFvPnEsD/dms3X5cTmYMFqWKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492713; c=relaxed/simple;
	bh=GsmVdYzXrKWRlb+Lg9F21Kzq4MHUyBa0/BHLYIeAR/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hTfNjXJEHJI3HowgkJl1+R35mCHD+mT8oKk8IOqMjiXBOK94OGP/YoVZvuvA1gZLKoNiqUkEnfOuiYM9i9KU8m+ZUat/hbp3x3tC9X39mOAacf/JGI1IQC+0BI9KxLD4I28N2idOGlRobnS+aTD54+Y04l51HPkkoZS97giqyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ag3oN2YF; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ag3oN2YF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=P1
	hgZMrSLq8zzRv5wwydc25xkKXCXmjx+zhVgs+cWtM=; b=Ag3oN2YFlZeqbTBOgZ
	Q6CmwEySrs0iQRULdlgDUkrYuBJmKqZh/4LBUjTavCQxkhikg/dYgyfX/X6VD5Zd
	jU7pScIT07Wc8CPFU3IEg5aUTUuZGKqAtj4FINnThi7vZ9xoBfZX4yc2E3c3zLUv
	pSCRi68nPtmIB8Q3KknacFQbA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3n_9H3tNpsy_CDg--.22472S2;
	Tue, 07 Apr 2026 00:24:42 +0800 (CST)
From: CaoRuichuang <create0818@163.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/ipi: report ipi_raise target CPUs as cpumask
Date: Tue,  7 Apr 2026 00:24:34 +0800
Message-Id: <20260406162434.40767-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n_9H3tNpsy_CDg--.22472S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr17Jw17ur4rGw1DZF47Jwb_yoW8Ar1DpF
	98Ars0grZ7JFW0gw4Iv3yIqry8J34kG3WqyF4fWry3Aa9xJry5XFWIgr43Aa1rGFZ2gF9r
	Xa909r40qF4UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPpnLUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC5wsZUmnT3ktWjgAA3Q

Bugzilla 217447 points out that ftrace bitmask fields still use the
legacy dynamic-array format, which makes trace consumers treat them
as unsigned long arrays instead of bitmaps.

This is visible in the ipi events today: ipi_send_cpumask already
reports its CPU mask as '__data_loc cpumask_t', but ipi_raise still
exposes target_cpus as '__data_loc unsigned long[]'.

Switch ipi_raise to __cpumask() and the matching helpers so its
tracefs format matches the existing cpumask representation used by
the other ipi event. The underlying storage size stays the same, but
trace data consumers can now recognize the field as a cpumask
directly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217447
Signed-off-by: CaoRuichuang <create0818@163.com>
---
 include/trace/events/ipi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index 9912f0ded..fae4f8eac 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -68,16 +68,16 @@ TRACE_EVENT(ipi_raise,
 	TP_ARGS(mask, reason),
 
 	TP_STRUCT__entry(
-		__bitmask(target_cpus, nr_cpumask_bits)
+		__cpumask(target_cpus)
 		__field(const char *, reason)
 	),
 
 	TP_fast_assign(
-		__assign_bitmask(target_cpus, cpumask_bits(mask), nr_cpumask_bits);
+		__assign_cpumask(target_cpus, cpumask_bits(mask));
 		__entry->reason = reason;
 	),
 
-	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
+	TP_printk("target_mask=%s (%s)", __get_cpumask(target_cpus), __entry->reason)
 );
 
 DECLARE_EVENT_CLASS(ipi_handler,
-- 
2.39.5 (Apple Git-154)

