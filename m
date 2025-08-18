Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6D31E0F6;
	Mon, 18 Aug 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520132; cv=none; b=XljK8LgMKX26ejje+8jsrCKIC4voZMkUJupuU5aqGQSUexToRqPhLF2DkMI3j5zAPgsrqzZsJmG6siD18EsieLRQkGRCnadvOWvtyKNbVlydlgo5l0jygUmmNgbVAZjGrmezai9wnLbOKOTlCGNgfbl6GP0sCIUk29C4EQfDfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520132; c=relaxed/simple;
	bh=wmZX4iZ1QAttu+GtMjiuZJVJaEt/iIJgpSC1JIHJR9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM+RwbA3u11Oolxynu2F5cgrZLknyUJ65M0PbZcjMyHTfLpzAXEPqxEg9mr1RUUCurRuu7KKmOhpwEuzDpkMPiq9VRzkvdgCtB22o8qrHqvOZ+4MUEJxZBZC9ohZQFmBLDd2kybPQJ0UlTHpS5Z+L6nw7on0JCwHMKJeiYvOYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUAz77bj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUAz77bj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47156b3b79so2999378a12.0;
        Mon, 18 Aug 2025 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520130; x=1756124930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/RS8QNjk0KWNIhfT85AHfvR5fdku6bJ5ncWD3++qNE=;
        b=YUAz77bjYzzeVC9lAOa8/jrxH1xO+P9q5JDeR+MdAe0k8WH+70DaEqOV4JuVSKWk/f
         mdfIxJUozkCCIpMoI1EaeE6prAtH4gIosqAKCJv0HNx0A5cDg/qH4HHy30PHJamJo+sI
         ZB1rtRvpMMEm+Y8orEI8zDqXsjXKiT1fQQLV/5/NhAqlhUPrd7DIjEWlRVQwT4X/Vowz
         pTcIakOauCNx/v5uK3w+eK9nNT1RkRbLc2P6Y24qEv+lWt4H2e9TdjaF+LtRJjVIhiD/
         CcSBAdeJ4m80LmeCyhJVZDMfoXuXW3MdNy9pC0n/u4M4LL/R5U8cb6UbYuZYP73ie9YG
         O2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520130; x=1756124930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/RS8QNjk0KWNIhfT85AHfvR5fdku6bJ5ncWD3++qNE=;
        b=izcUyrapcfLGfT6So+fELPN1mW+LXmJgr/yWNcF9vLSA97K/B/dcM1Ixe7dn3ObNJb
         PXvIlKxMzrjwKojJBDnrzSQTQlE8rH/u/XDU2W8eu8GKkYc9GjqOD13+K3IFPXuJZ9EQ
         tD7BnqW4WKH40xD8lhfB6jeD8AP70mnbkVEzSE3xBdz3tOOVrbmdmU2gTuutFX60mV+c
         NhfXOt3IyRgY2/Nkq3BQ7Qdc6gqFsAkIOYoHXHt5rXBRCHTEECI0qhfBVflPoRg44x9D
         IkSYkwnPawUTVK7maW6HdfiCRRXpzkHE26+ZOI2qWQpE2WihwswSrcoppr++WqbAmUl9
         qaWA==
X-Forwarded-Encrypted: i=1; AJvYcCVNNkqCkkfcVASxmOD8T+O2lquHNJ/KcnWzegjBY9Dpy8CuNU1bbEnocByvXq99tEq8px83QcCpSWSiK+QYgpWv6M3y@vger.kernel.org, AJvYcCWzC0K5VQj9DI3jIN5Mhdxt2wEHaa84njSi8xA3cW6VA7uJ/1AfHVHS9MUhm15UpCkqjxyalkkbSJwyZq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWOPWmdMrXHXvMCaqniez9JMwvPEuUWTvCbUtE1wXqVYSdrLZ
	i7Pl6iByHViETl/BH9JhvRARSbwhaTkuREMu1x2RigWDh+p5yugnFXKP
X-Gm-Gg: ASbGnculhiVukAkkk12PagJOBmUfvCQGiEp3JWkKntAaBjQ4ydjKGcawCl2JfCxaQy6
	2L8kJ84AXAqZvLYh3NDygDBPjbGJDYLoQGn/wQoIioNUxPkIEVUwIbxzijFALVfI7XarhAtKnV2
	kawaoa7+1MujKCpZYy4hqC91F5PrueJ3ro3pOk+zo7p3Avq1LvrH+07Afs6+eE7X2nULplovbjD
	81DBS3WU/+R3cmHuJumA5QD4yEGKCqB760dpbhTBAGxsZN0ifM0Zpr+h4PYwOYXM8AhAp+qD8Ti
	KwGR8ORjTJGVXLyKIpn7fTp9iLmjtSrEOOd65nERw8X3h8D2/tWz5zlkaQxbq/74uuaRtM8JKVA
	Pe44Tp4PlkAuXWyLkDhW2OfkO+MFeR0qcfaZroYIYj+kY
X-Google-Smtp-Source: AGHT+IFshKCn58LpNxaRlYFZ6LZcaPJSmzPeYiERgbkx+OgOwBhC9613S8BZN35Pd779veDghhniVA==
X-Received: by 2002:a17:902:f550:b0:231:d0da:5e1f with SMTP id d9443c01a7336-2446bdd72ffmr162785695ad.21.1755520129990;
        Mon, 18 Aug 2025 05:28:49 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:49 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 11/13] mm/kstackwatch: Ignore corruption in kretprobe trampolines
Date: Mon, 18 Aug 2025 20:26:16 +0800
Message-ID: <20250818122720.434981-12-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-11-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
 <20250818122720.434981-8-wangjinchao600@gmail.com>
 <20250818122720.434981-9-wangjinchao600@gmail.com>
 <20250818122720.434981-10-wangjinchao600@gmail.com>
 <20250818122720.434981-11-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds logic to prevent the KStackWatch tool from
triggering on events that occur inside `kretprobe` trampolines.

The `kretprobe` mechanism temporarily diverts execution through a
trampoline to handle function returns. When a HWBP is set.
It can be triggered within this trampoline after the watched function
exit, and before the exit_handler called, leading to a false positive.

The patch resolves the address range of the `arch_rethook_trampoline`
and checks the call stack within the breakpoint handler to see if the
event's instruction pointer (IP) is within this range. If it is, the
event is ignored.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 7ab247531961..1b4cf5d42db9 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -31,11 +31,48 @@ static void ksw_watch_on_local_cpu(void *useless);
 static DEFINE_PER_CPU(call_single_data_t,
 		      hwbp_csd) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
 
+/* Resolved once, then reused */
+static unsigned long tramp_start, tramp_end;
+
+static void ksw_watch_resolve_trampolines(void)
+{
+	unsigned long sz, off;
+
+	if (likely(tramp_start && tramp_end))
+		return;
+
+	tramp_start = kallsyms_lookup_name("arch_rethook_trampoline");
+	if (tramp_start && kallsyms_lookup_size_offset(tramp_start, &sz, &off))
+		tramp_end = tramp_start + sz;
+}
+
+static bool ksw_watch_in_trampoline(unsigned long ip)
+{
+	if (tramp_start && tramp_end && ip >= tramp_start && ip < tramp_end)
+		return true;
+	return false;
+}
+
 /* Enhanced breakpoint handler with watch identification */
 static void ksw_watch_handler(struct perf_event *bp,
 			      struct perf_sample_data *data,
 			      struct pt_regs *regs)
 {
+	unsigned long entries[MAX_STACK_ENTRIES];
+	int i, nr = 0;
+
+	ksw_watch_resolve_trampolines();
+
+#if IS_ENABLED(CONFIG_STACKTRACE)
+	nr = stack_trace_save_regs(regs, entries, MAX_STACK_ENTRIES, 0);
+	for (i = 0; i < nr; i++) {
+		if (ksw_watch_in_trampoline(entries[i])) {
+			pr_info("KSW: Found rethook trampolines, ignoring hit\n");
+			return;
+		}
+	}
+#endif
+
 	pr_emerg("========== KStackWatch: Caught stack corruption =======\n");
 	pr_emerg("KSW: config %s\n", watch_config->config_str);
 	show_regs(regs);
-- 
2.43.0

