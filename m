Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887374;
	b=zy/1/qkUWMzMZsCJUNoRR0X2ozSX2ZdtbOsSxNqnpqqc9RBnUnQ2WbEJnC/QSHQR7qp+
	 /gX+hc8GA0ZkiqC/nClgKARTpavx4tu7S+5LtcTYNLPpxFyzZmE46Pfcrxs7nzmWaoo0Y
	 qshLe1CbRioYBmjUIByjQQUO71d7hmn+AVCRH1F5G4cUODOCqP1yptT3qm4YmhAPozNyz
	 a7/jz8y/5y8tOey8noMEgAEqaqy3Q58nmJQaMmcLUAdMiLqBOS872PgbKwZJLC3490eO7
	 AE0+ExDX+z6gt3+gIe6stZduB+QhJhCiKbLHHSMG6QNeGgxiwyhkyKAvJH5V99zxbdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ccnom0mZGa552DJG6TPUMA/Iqkl36ZDF942n5bxWo1Y=;
	b=wGQ9wrdMNAr1cH7WVoeJBC1c7gqJUtY3aRNff6Jz/hjgs1yCEhsEmDRIRHKNrDJaBsYC
	 P6rPSpQRuxUezLtVwrsMy6lPKFhdLTN3ZA8oNBsQUFBV+eaN7RHpqf2MiEeQBVIA1otDh
	 /8gILT9zt23Kw/eHWv5e6WJPQrFZ9Vo4I4bRZ0I8KQA1ZV6TFGZGg5NEUHL9L6AWWSAqB
	 dKvm68ZPqxFIlqmI97t7ijFslC12b/Ckt2AQcnYmiHpaxk2f4RhPfmohaQ4B8iwC9qI1X
	 p0E4LXnMsvlmPBD5fRreQxgbl9rZcZaxosbDcKqtLEyzI3wNCsefTeFH5VdeZIdQs3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGrHlaFA;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CD606A32F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82CD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGrHlaFA
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a18fc7a38so2155724eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887373; x=1794492173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccnom0mZGa552DJG6TPUMA/Iqkl36ZDF942n5bxWo1Y=;
        b=KGrHlaFABfrQQPuyh9DhZ4bkjg+B3lEvH+y0ekE1M0MxL9p6XcNHlvNZVoGHcrlyaf
         YIyY36yVKrkBt+IF6hq7cKBFlFRqgpDffVNdesxUSWN06IdLLC97ghtZ5Cu8Vs2N5XUD
         uKWXwhVnjGkiAJLkv7kF4tCJ7eDEEQ6rHASXwdrqC+iLxbijLfZhsflQAaVp+hYMzSmn
         d9bcDbCfxfrrCboxWIcUn6eWwCb7cBOTEZttPrCSZ2pc7BVMyfZPv7C0SxOSryXnf9KD
         nNLebG6+4Yge6gSY0m+NwE9159HYASPllg/y0uoZ7ZTGeeZO1oqLagWogFAYTW358FCn
         P83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887373; x=1794492173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccnom0mZGa552DJG6TPUMA/Iqkl36ZDF942n5bxWo1Y=;
        b=xnd3ksCEWVOS0eqVFf6t6EjyrmGqvHT8RT5r8lokDgA8WuHkktEswK+Nt/GareqxSN
         j64F7Kw4m4+NRiD5xl92ATqWUAYUElBrR/hDsp1KSmksJEZGN0Hqw3LHUsW0NljciPSM
         n6Gt9SDPIvhm9Xe9eiNW/U/EdG/ryARqets4do8Axp3vbCYsnfPYLvkwvx1rSdho2ug6
         MGZAoyN/tNL3xRB9M0qOWjuJ34Tau04gWP4fyrOvjslv/gexC0qx7q2LRviSSw4SCRMw
         HEI4I2q4F1nJG1PGN8hfAdWcc1DXcOBEKxDFqPVziVjxnQyJkgeikpaZynRYSuskqSDs
         aFYA==
X-Forwarded-Encrypted: i=1; AKwUvBxLiymjFMsJNB/8JeJmqPiQODHN7AwTmlNwIAvbDaWEUuPUqej2H4VLkSYZJ1PWAa6u1hBhlfXkmMCOKOKS0wPclcQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RdkYCiOGYGaSFoDQ9Wzhua5PxE/HRD7QyFPl1OGynIPgTDoHj
	aE508RoeTqE5PFyMcXFiDpYU0lnVRuSD3kfKL5sp2810plQbFrPoZV8w
X-Gm-Gg: AYBFou0tiuC4Lu63COHJ8Eit+yxWd6RVZ29SegIUhll/DMu0+UN3ISQVGIl7m4j62Qx
	NPEodD52OBIQtF+NhTuAOkElrapkw+sd3cRcEMHOTlGHnEA2JrUUCUv/09y9ucbYNYqIjr0JDsN
	Gw+DqXCkkUFBPbI4ZmGBsNxlMbZUOdN3EhULcagV59gv108ArZg9oX1a6EGlhCw0TP5Gr+JO3oY
	7DNwjOjlN18SDPoLzxzxwSEMY4df3LBXhgBSbwtC/lGzGV07NW1V8WgS3jL0CmLyDfyo1Q0pfof
	1GZcgKSgn/0MYbKIEXODmQIOdu+IjaBojpygJcJj9z6mDLG4lnbzjAYwWUcQOIMV6AlxrWzdaz0
	YtCUc/RTX2m+zmsnHf346wx1H0X22n8ORh5oOQFuU26ctX00Slwq0bEHiec/P3fGahFRGU/JH66
	M0tELv3Y+j95RCfM3IPncvjJ8PL/fTrhaK+8jLVfJDi3wNp2MIAZAxFHm1fph0tclpw5pFwXNtP
	+Vf5nnIRl7ejinFVvxZBQiT9+97GYsAPE/J9WSVh3NMfNOXtcXt0lG6WYSnxcXmekQ8khXHx6o3
	TkGwPi5lpJ9z6IkdXrJGA7qe07jDbbktPkJF/b83jWzMqD0yOJXQBtkOEQWFbwRo6QePqg==
X-Received: by 2002:a05:7300:7c16:b0:36e:1fbe:3571 with SMTP id 5a478bee46e88-36e1fbe3944mr4304252eec.3.1793887359174;
        Thu, 05 Nov 2026 06:02:39 -0800 (PST)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm20969616eec.24.2026.11.05.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:02:38 -0800 (PST)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v5 1/4] ring-buffer: add ring_buffer_memory_size()
Date: Thu,  5 Nov 2026 22:02:18 +0800
Message-Id: <20261105140221.44614-2-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
References: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper to report the page memory consumed by a ring buffer for a
given CPU. It accounts for the data sub-buffers, the reader page, the
cached read page, and the mmap metadata page. Unlike
ring_buffer_capacity(), which reports the usable data capacity, this
reports the full pages allocated to the buffer.

The function is generic and returns a size for any buffer type, so
callers that need the memory footprint of remote or persistent buffers
can use it as well.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 649b2276b557..e83e94623e76 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -174,6 +174,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
 unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu);
+unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
 
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..0396ec671998 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6566,6 +6566,43 @@ unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_capacity);
 
+/**
+ * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
+ * @buffer: The ring buffer.
+ * @cpu: The CPU to get ring buffer memory from.
+ *
+ * Returns the page memory consumed by @cpu, including the data sub-buffers,
+ * the reader page, the cached read page, and the mmap metadata page. Unlike
+ * ring_buffer_capacity(), which reports the usable data capacity, this
+ * accounts for the full pages allocated to the buffer.
+ */
+unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long subbuf_size;
+	unsigned long size;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return 0;
+
+	cpu_buffer = buffer->buffers[cpu];
+	subbuf_size = PAGE_SIZE << READ_ONCE(buffer->subbuf_order);
+
+	/* Data sub-buffers plus the reader page. */
+	size = (READ_ONCE(cpu_buffer->nr_pages) + 1) * subbuf_size;
+
+	/* The cached read page, if present, is a full sub-buffer page. */
+	if (READ_ONCE(cpu_buffer->free_page.data))
+		size += subbuf_size;
+
+	/* The mmap metadata page is a single system page. */
+	if (READ_ONCE(cpu_buffer->meta_page))
+		size += PAGE_SIZE;
+
+	return size;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_memory_size);
+
 /**
  * ring_buffer_max_event_size - return the max data size of an event
  * @buffer: The ring buffer.
-- 
2.34.1

