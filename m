Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC532227565
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Mar 2026 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850527; cv=none; b=Q2eAwfwUlPVR8p2UcPZkQy1Mpn6tp23bvNJG4bt8mNHTP9Z2FiVGZzqhn+UkT5BL6BD9NjrAjSDMRbjJ8wUcdgkEjZU0hMAcW8xrkXvSzWTDzOEOCGwmpRjGULmkDWn+yZlgfCrZwyTSk6Qs42d2Z67lr41sbhRjxGs4kD/bpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850527; c=relaxed/simple;
	bh=+29eQWDBWb73NBxQd+481FLVPXc0t1AxcBCmLMgUBXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lb53U7oudUWCHmrIHT2pZAECevPlb2kpLuuyd5oAqY/U6D/hUVnxf6GwJytbU9GYhIcYANpp/LptcJkuzbXMndAvLYQIqbqfBYTS5f0ioJxNWyGvgK0k87GW2IhinpadpXNqcQrbzlExK6KoMs3ze7k3v2C/pAXl4HmTWjMdtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=LcXR2ypQ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="LcXR2ypQ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be1d9c356cso2886463eec.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 18:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1772850526; x=1773455326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6vMLTpBGGoSqyMwv4Oyb/USA3LI1oQt5aqADT5YB2Y=;
        b=LcXR2ypQ7DGDkEPHNs9xzRaUvSa++wQzxtkIeEwG8lXjCGj5pqMrhHCNJP2Lj1t8FV
         FiwZ7cor1rdjPj5EIFWh675MubKBF+JLTtp4uWZ0B7RvfnYrW831EVJa9J8B4XTyYfMc
         XSZuIwF8wtUqLJLNiw6NmaqCNAyv0qhHQGJ9I/rUQaNjFRRKZqShSI0urkHboyHX/MgN
         tstgdtKZqo0yRJ7CWGffSYSUHhjm0/1ZqcUbJVGUeCxVvi9gLUxDV8bYl9UdXl1HTDVP
         pGTi2d4SHBjCgmeXYp90o3n1X1uYZl2ATaqKK72NJPnRxzCSDLBADMnkOQlo1bdTcybP
         oirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772850526; x=1773455326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6vMLTpBGGoSqyMwv4Oyb/USA3LI1oQt5aqADT5YB2Y=;
        b=j2YZAOz5Ok8MuoSKpz1T9usFkrwIAEe4k3OTQeTk0v/lNB9EUGL5Sops3lfa7MflyY
         mPzrm98bl+QTNG0nbSW10w71WXIQ52Qq4zmw9bzDNTU6LS0P8n0yogQiDOBuIWda1sc+
         OxDvkIB4Mbn65/ZmTvS7TkL9tHugkNdpZ3Ge1UP4P3Cf5JJp/OqNIjtFQniP5mmtwQso
         RaNVnecnpuMp4xxwbtyGnU7S+Vddn9x97ffOPlmhTwDsReIkLOVVzfv9Sb3LCyMWUzkA
         nWAwYPtNDY9uo5yP6iyIWYTmlwaFgDq3/MZOnp6LNK6SFMPFQSDxVgBlmFPoqAkHCkjJ
         NgUA==
X-Forwarded-Encrypted: i=1; AJvYcCXrPYWiAR5+g775OtCz+8Zm1DScIYLRJNYvPixlPAqKn7bbx7Zb8YOlhb1CxY0bX121uXbHjEb6rr4urSpkoD0Iy00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnUzbLMpyZxKALgZfcVGAeIBjg4tpEEv2zQsiv2I1z2XCE+US
	P/Pbnk5xfQXcPJluZ8ErFvEK6vIsd4N9YyhsD/T4OnxSWnpRzkWAAPFeFQwYoE/9+q8=
X-Gm-Gg: ATEYQzyLN3fUX4zXODwbFvSvL0CoaNihEYexdZ2fF4O7cUmX7+cKw1ky9Gs8TeHRPHO
	B87+Hh4Z0Y/1znOK3V0LbP2vIXRZgbhubzKbOvx8ropzrW1S5AcS0XY5wX19EQRxykxszQsphQX
	JcJF1D+DJD2T2XXyD55c7ZOu4ai3R4NCRyhdYppVcaacnlWVg9yQXEa0CNJiDUYwoQPnRXOW4ov
	J7IvRLt1fjqAV8gZyxmSYPa80+eqC4tTEsGnCBtKJSm8cWemlVHipp95brEEPcOiHGwdtxzSXOG
	vC/ItWFqm+wZKI/W/19e5zSd6h4Eh/k/FAD9Y4aeJSgsnEek9Imm/TMcAqdk6VphguEHNjoiTD/
	IYARbDh0sJiwy5FtwSdZgDz4FC6dNNlJLffE9mtFycPPOG4wS1DhUC+8sZdFvQGIDhrchECNWUG
	7z8Q7HOJvEZea03X5emCPa8fv7lgsr4HS1zt4F
X-Received: by 2002:a05:7300:aca3:b0:2be:2f58:2eef with SMTP id 5a478bee46e88-2be4de91d51mr1629114eec.2.1772850525634;
        Fri, 06 Mar 2026 18:28:45 -0800 (PST)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:7be4:3a14:1272:85d2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm2743485eec.20.2026.03.06.18.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 18:28:45 -0800 (PST)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix trace_buf_size= cmdline parameter with sizes >= 2G
Date: Fri,  6 Mar 2026 18:28:38 -0800
Message-ID: <9a65e27b0394069040c9b8f8684525687dc15d6b.1772820006.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the sizing logic through tracer_alloc_buffers() uses int
internally, causing unexpected behavior if the user passes a value that
does not fit in an int (on my x86 machine, the result is uselessly tiny
buffers).

Fix by plumbing the parameter's real type (unsigned long) through to the
ring buffer allocation functions, which already use unsigned long. Also,
tweak ring_buffer_meta_scratch() to avoid void pointer arithmetic.

It has always been possible to create larger ring buffers via the sysfs
interface: this only affects the cmdline parameter.

Fixes: 73c5162aa362 ("tracing: keep ring buffer to minimum size till used")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 include/linux/ring_buffer.h |  3 ++-
 kernel/trace/ring_buffer.c  | 10 +++++-----
 kernel/trace/trace.c        | 13 +++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index d862fa610270..c07eb463ca1c 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -95,7 +95,8 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       unsigned long scratch_size,
 					       struct lock_class_key *key);
 
-void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size);
+void *ring_buffer_meta_scratch(struct trace_buffer *buffer,
+			       unsigned long *size);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 17d0ea0cc3e6..30e579fd6b9d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2650,22 +2650,22 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 			    scratch_size, key);
 }
 
-void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int *size)
+void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned long *size)
 {
 	struct ring_buffer_meta *meta;
-	void *ptr;
+	unsigned long ptr;
 
 	if (!buffer || !buffer->meta)
 		return NULL;
 
 	meta = buffer->meta;
 
-	ptr = (void *)ALIGN((unsigned long)meta + sizeof(*meta), sizeof(long));
+	ptr = ALIGN((unsigned long)meta + sizeof(*meta), sizeof(unsigned long));
 
 	if (size)
-		*size = (void *)meta + meta->buffers_offset - ptr;
+		*size = (unsigned long)meta + meta->buffers_offset - ptr;
 
-	return ptr;
+	return (void *)ptr;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1e7c032a72d2..f6f5c44ddbf7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9282,11 +9282,12 @@ static int mod_addr_comp(const void *a, const void *b, const void *data)
 }
 
 static void setup_trace_scratch(struct trace_array *tr,
-				struct trace_scratch *tscratch, unsigned int size)
+				struct trace_scratch *tscratch,
+				unsigned long size)
 {
 	struct trace_module_delta *module_delta;
 	struct trace_mod_entry *entry;
-	int i, nr_entries;
+	unsigned long i, nr_entries;
 
 	if (!tscratch)
 		return;
@@ -9350,11 +9351,11 @@ static void setup_trace_scratch(struct trace_array *tr,
 }
 
 static int
-allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
+allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, unsigned long size)
 {
 	enum ring_buffer_flags rb_flags;
 	struct trace_scratch *tscratch;
-	unsigned int scratch_size = 0;
+	unsigned long scratch_size = 0;
 
 	rb_flags = tr->trace_flags & TRACE_ITER(OVERWRITE) ? RB_FL_OVERWRITE : 0;
 
@@ -9405,7 +9406,7 @@ static void free_trace_buffer(struct array_buffer *buf)
 	}
 }
 
-static int allocate_trace_buffers(struct trace_array *tr, int size)
+static int allocate_trace_buffers(struct trace_array *tr, unsigned long size)
 {
 	int ret;
 
@@ -10769,7 +10770,7 @@ __init static void enable_instances(void)
 
 __init static int tracer_alloc_buffers(void)
 {
-	int ring_buf_size;
+	unsigned long ring_buf_size;
 	int ret = -ENOMEM;
 
 
-- 
2.47.3

