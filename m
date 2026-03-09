Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0773D7D74
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073566; cv=none; b=EsO3wR+bcwITdu5kWeNAKqf+bxBT1VRkMsSe84ItlU+9lhMOyPXbv5R+dxvYptdByV1sNxWYM/c+nx2ruBDLTVW4MvkQGTQl5WAB+k2voQ2Br+B0CcHCfhcpunCmlCjqgxS3HCiCePsptFKnWh45n5gc8ouo76V2uoQ6MnhQN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073566; c=relaxed/simple;
	bh=xq5OrRPhHQiL8pLn6OQfbpras6MBA/YNtjsXU1Nqdco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNGwPiBJWVJggmrUMZ2Icpp6dptTOBwv24dRdWCkas5K2msnXFgbBJxe0IyjVr5LKLLDyxAXTs6Td1bpU/5zP2fLSvrXqZrh6X7Gip1chNhSc/fss80HhFKzSG/v1pwbuZ0fkqT4f4XhXZ9QQTakoJK6Ce5eulbCb0bGI0EHACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuRRz78e; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuRRz78e"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-483786a09b1so5521645e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073563; x=1773678363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIAmVVv2A3LDKUFGtswIg5tSBiw6xfgb8ZrLFDafxOg=;
        b=ZuRRz78e917964bxA9+1SdH1vyN92Loe3hZQsq2Ug5CVnD4d0RggQ9/HHru6mSM9M3
         7fQ6nsk/wcLc4G1QWZSs6PpvuThsufSvPlTyfPzNkqzr1CRnQV8V0EqS8dAhHLEkKUeG
         N/uiqgLmHvm/GSTOa/YCSpOEufUrARBEHnczRWHV+XUq2abB+tatsOLcQ7+XYAXvQu+j
         ZzM3yNYYSInSmOYf8lap6+pQbsLkK/g/y4UmmFFgAVq1QLLvj7Jte9W2jw6qOpUxw3jl
         jKQjeYy44l6z1jVef+dW56oMxB9MC5qv/pBagSsxTsDst3xuB1utcH821QzqN6jB9TFW
         6GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073563; x=1773678363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIAmVVv2A3LDKUFGtswIg5tSBiw6xfgb8ZrLFDafxOg=;
        b=FCLpuiVZcbIrj0ngcmknV+A668Ejlt6oo4hUjmklhUuU21jHIv3SdG/qUehAPkENwj
         occWi6caWt9ZNTBKQjtKrOVMpBDOIVL+CoZN7sPcWYnK0VTQz4sJ0wZNgF1ixaVDIKtN
         BWud0SChAHLzs7CkGF6Rso9oX1KpseJCPoiezQjly1epWtSH+2myhmAidGxVLWaXpzhF
         rnD5LNFmSgIWnRufdZP64cAmPWSkygZ7QezArv7ZyL/I/hwdChc8CC8vPw40HGB4bfwR
         4HBKZdtxMXgTLXe7BU892uB4R2y5oTIrsLWYoLIL9EUZoi+Laa9gdy9Vu//zh34jx3Id
         QUVw==
X-Forwarded-Encrypted: i=1; AJvYcCW4B3Ajce6964RE8sc219cQQn2zCZlwfJFdPRxuUils8VzTsHvw4TcMBLdTZf+XWOwEEJhIO80ZeSWEE4OLzCLNNVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPzRVB897if/R23+/jEq5A19+WRNNM60TODJJrGW/zSgHJnau
	YmQe4IjeAcbxfiwImGRPGkaT/JSpBspPJsiHpx5B/K1FxLiA1Y11TZ9yjfEyKKchLFzBgjIwsdz
	WnLglrw+0tmCSrHaJGqvtkA==
X-Received: from wmv3.prod.google.com ([2002:a05:600c:26c3:b0:485:40d2:1ebf])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ecd:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-4853c2dd2e5mr52980145e9.22.1773073562472;
 Mon, 09 Mar 2026 09:26:02 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:24:48 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-3-vdonnefort@google.com>
Subject: [PATCH v14 02/30] ring-buffer: Store bpage pointers into subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The subbuf_ids field allows to point to a specific page from the
ring-buffer based on its ID. As a preparation or the upcoming
ring-buffer remote support, point this array to the buffer_page instead
of the buffer_data_page.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 82b4df579670..3d2804a7e8ab 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -555,7 +555,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7036,7 +7036,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7045,7 +7045,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7055,7 +7055,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7064,7 +7064,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7220,13 +7220,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
+		struct buffer_page *subbuf;
 		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs))
 			return -EINVAL;
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		subbuf = cpu_buffer->subbuf_ids[s];
+		page = virt_to_page((void *)subbuf->page);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7253,7 +7255,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7277,7 +7280,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.53.0.473.g4a7958ca14-goog

