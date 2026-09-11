Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DB53FD54
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155604; cv=none; b=oXI5adlO1fRoHotUGV6kVqX/vUNAue6BqcL9jb0znIdd4T6W9YqgeCBd6T4HDFThzVL7eUXV3SblhbrilaRYf6nVoqpcmH5noRGGqaJc09aaujko3/4zltQMjakqJqC0MOALXvRAWzM5iZ9SFr4laSnx8sbRU/ba8uQlp9V/4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155604; c=relaxed/simple;
	bh=p/PNA9lb1ujgnjktgM201CRXtbHR6ZSSOZ1hHyPZfg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ru0iKNuZmC6x9EoqM1tlEL/Ssq3UAn3UGh75Io3gnOtSR8ug/BR2znBbYflQSTyXUr4LH1QMOzn4h/Wg1yLaGeTthRqvBta+9lhkP/suI61OENO81gH1JfYhlIA5EuUNzk3ZxlTxCX+XMCUlpOnTuxNq7pg4QkO02/PVYiBqDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoDyFOQj; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoDyFOQj"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c293743f5cdso133859766b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155593; x=1789760393; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeMy/DaNVJkSXZ0N2fL3KCM+KXX4amcR67/b0vTZpco=;
        b=UoDyFOQjNmHA1HUmVNlBfCpdLI4VuGA2MJEe62TAs68xZyToe4JdePa2HKFpXbwH54
         eu502RxzOqqpJTzbHHlNr4jdXh0wZfHTgdQRxSRSLv0YHsa4JEl4pfYAYALAWHJ/cVN2
         xOy97sOmVOe1oqT32+SItDHs/OMcSWHIV2HOiHPzE+tqleRwABNU45tySQo73yGmb/qi
         uKyd0oWswPRD+Bbi1qgdV5lE443FrEr+uKqAzT8JW4YTPnNobrvdql5DwcTZOdQxosPb
         ccxkZcU1hKWYYEjyHwSaR5C/wZbLiraaBGmpao6zPR+PSk46iK7v2Vr/C/WPUu6ps7cn
         MaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155593; x=1789760393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WeMy/DaNVJkSXZ0N2fL3KCM+KXX4amcR67/b0vTZpco=;
        b=SGWNz+p+8ZP+nULSjcJwTj09qH0DKIm3W9PIS7g6t7dg5QO3i3px8hfzzllwg0zx1y
         lyw9pOsiEsnolr2lXdl3f6xFJb7VxhndXPDm7D59aKQcfoBmX5/VgougBFtN+faI0veG
         l+ylaB/7wKPs0+Ukl7vB2XkDc1qZZhg4Nv6MqOW/uBC3t1CLMr+LkwK+q+nHFEEj2H9l
         ntAwr33a/3Q9z2F0wy0AV8pr66fFCgTwgWoe2RGHLdFVGwFlFWzXq6V8eL/DHqV22IFg
         iYC229fFA081Y8AIX+24DBYuN6SIG8U+HgELTOU49gmJTfqS3kyzEqz/oczDOLt5I6+M
         yOnw==
X-Forwarded-Encrypted: i=1; AKwUvByFF+0/B+l0IEcuREz67S46Af1B3AoApfK4UNmBpPu4z/xJsmE48BvrQKRXA+6fTFknUNPPrD6aaHj0ehrPiuZkEAA=@vger.kernel.org
X-Gm-Message-State: AFuF++mm/lf157oWXziby5LYnMhudqM54ft8IQTC57FvDiuF7bVMhIKc
	/17d4jEQPIiWViOOB1faSPRy1zEuiYrqIY2kB612/AXm9JARYY1RiCRmGkQoAyc/5uFQKN56QCO
	cdwJZdP397KWy+QpHpMzjOw==
X-Received: from ejbox4.prod.google.com ([2002:a17:907:1004:b0:c29:6e48:1427])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:c14f:b0:c29:4d53:787f with SMTP id a640c23a62f3a-c2966737ef4mr240602566b.41.1789155592434;
 Fri, 11 Sep 2026 12:39:52 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:39:35 +0100
In-Reply-To: <20260911193937.602202-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911193937.602202-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911193937.602202-2-vdonnefort@google.com>
Subject: [PATCH v2 1/3] tracing/remotes: Account for ring buffer page header
 in size calculation
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_buffer_desc_size() and trace_remote_alloc_buffer undercount the
required pages because every ring buffer page contains a header
(BUF_PAGE_HDR_SIZE). Account for that header to ensure allocated remote
ring buffers aren't smaller than requested by the user.

The newly introduced helper __calc_nr_pages_ring_buffer_desc() can
return a value that overflows the descriptor nr_pages field (32 bits).

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/ring_buffer.h | 15 +++++++++++++--
 kernel/trace/trace_remote.c |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index afc7daa6ee7d..11bffb6a142d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -3,8 +3,9 @@
 #define _LINUX_RING_BUFFER_H
 
 #include <linux/mm.h>
-#include <linux/seq_file.h>
 #include <linux/poll.h>
+#include <linux/ring_buffer_types.h>
+#include <linux/seq_file.h>
 
 #include <uapi/linux/trace_mmap.h>
 
@@ -279,9 +280,19 @@ static inline struct ring_buffer_desc *__first_ring_buffer_desc(struct trace_buf
 	return (struct ring_buffer_desc *)(&desc->__data[0]);
 }
 
+/*
+ * Returns the number of pages for a ring_buffer_desc. The caller must ensure it
+ * does not overflow ring_buffer_desc::nr_page_va.
+ */
+static inline unsigned long __calc_nr_pages_ring_buffer_desc(size_t size)
+{
+	/* Takes into account the reader page */
+	return max(DIV_ROUND_UP(size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;
+}
+
 static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_cpus)
 {
-	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
+	unsigned long nr_pages = __calc_nr_pages_ring_buffer_desc(buffer_size);
 	struct ring_buffer_desc *rbdesc;
 
 	return size_add(offsetof(struct trace_buffer_desc, __data),
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 75fa1ffc4c96..c17902e42ef1 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -980,7 +980,7 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 			      const struct cpumask *cpumask)
 {
 	size_t min_desc_size = trace_buffer_desc_size(buffer_size, cpumask_weight(cpumask));
-	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
+	unsigned int nr_pages = __calc_nr_pages_ring_buffer_desc(buffer_size);
 	struct ring_buffer_desc *rb_desc;
 	int cpu, ret = -ENOMEM;
 
-- 
2.55.0.1007.g17ff1f9808-goog

