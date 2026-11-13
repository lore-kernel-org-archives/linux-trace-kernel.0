Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563404;
	b=gdvBmDnU3+kiycvDrj8dB10cUz1XJ/G0ra/QyQpn5m70HneKOWReIgYsLJ5V4/yQWckQ
	 VOhb+ePL3Twizwh7Vn0DeXh2jDbV7Bxy8cckL+OX0bIlvup59bd5fFUmOnVh7zE4FWRne
	 1xZyV6O9tqwCWFuC9hwE0tujiShINxfMZie4NwHh5k0Kdi6aq1l4HKugWeYxXPU4u00+G
	 C9zVyGf2/PYXZVb7qNZLibaCQisHbGRWVUg7ZXzEQDjBwURrXnxrYHx0wsOEhTZJP2w7p
	 0GNLQX7DCKlN6SFuPfmOzLFvkI+cHmPUtZHbrlV8tQmmO/2ubsCVRvrhjQWMJOIy2aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JasxHhLs3JaYlABeqrE3u49mBt09/wnmvwa42/5JLzo=;
	b=nuAFxiajbO9hoUhJy4+/QFZrvtgt0DiQP5pXoVkGb54dX21umlJ5FyTVeCoJtVI+gUtB
	 rfzrFpZZ1p8UtcyOz5qcgy7g44LIMH5aKiRLB/4ZxqjUE9e+5Z6/eLqWB4TzedS1L75jx
	 YEcKSBeLxrgpdd93EKXdqfkhF/KSy1M0hhvc3KKWd2Aq9NnCFT2Gd0J8CXyIWhcIOsmTD
	 OHmw7w4/DVixIiEPOHKSaNqutUZMbF+Luc4CRIU6qmS0Bm/2mAwthpTu/NvdjACEd5cXh
	 QgU+2zdr+2jH8JZZjOIHc3GwGNO12p14Gmmbb6728YaiIOHJMl5THv3L+Eplp/kHqbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0ECkkw2;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F5606A32D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890F5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0ECkkw2
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3719e3cb82bso91792eec.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563404; x=1795168204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JasxHhLs3JaYlABeqrE3u49mBt09/wnmvwa42/5JLzo=;
        b=O0ECkkw2Pfd8V6XhiIkeo7HqRqSsOrXEuAb1LDG6fu3ddYqvy0x6Dtk3NnsQfUUQM8
         r9X2LC0LLtkVVSnXPHGo86rC+IrrgrrLZJ1Mdao5WgNzCQmB4wI4aWgXE6m88l6xdJaU
         XtK4+9GxM1T95Mjn8yYIT534uAzqfhl/vmzhUXr8unG6FdKCZzLjOvyX8XGxfqtGCOOC
         O2gd2kOKx7Rlc0ExilVBrvetiMUomS913waDdelmUCEDsVRF0kFyAYws38jkjq17Ty6I
         M2zOsHBCG3HkymP4d/NDHKpOgS4+TKZI+f9zl6oz9B0+ut4mrW19kUPfv0xcQRl9vq8b
         vFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563404; x=1795168204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JasxHhLs3JaYlABeqrE3u49mBt09/wnmvwa42/5JLzo=;
        b=vGq9kCIN4SV4EmZC5y/vIBt/kaELvaOD6CVjACcrB3j6LCYECsPwUCd5CbiywfSpbZ
         Y7V6HMNVRbM204z2gQTUB2XlpQ+4h+RTg+u+WcRpWNHsC89WMyUSlUWFF4x5mtEdYy5Z
         6BqNjR8Ua714BInhCpXyZqdvWZwezfdaBaBxwSNaUBJiBsgZGKUrI++5+srH6bm2X/HH
         9knuEpbosHTIzAvD3T49QahdT63pumXaa3L3+YyFdvxVHPPTmu9dVm7g/pc7xf6zKfRH
         ryZkEWfOiHV5GlL0w87oK3J4Qiw4gXHwWQ3bw4WWWv4UZ9oG+C6dd4PwzHAZL78vG4ak
         TdGQ==
X-Forwarded-Encrypted: i=1; AL+hErFJ2m5GXwEmq+Vg3XJQ699H6XhXcp2EnpujXeZUqBX9JMAcFhTXwj8ocHmnNQ2efFXa8eHS8eFF3azpv6g1QfMR/R8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IBBV6rgP2PGsxS0mGVGQM/0yG6qqvcnGC9i1d1WpdAYKdtFN3
	RoQu+g0sxrscgGC/GjrYK0yd4wOqc6TliFIeIFccfcvnzVChJInz5fYq
X-Gm-Gg: AYBFou127p2QrJ5KC1pZrhbtHjOI8rC+T12k1Kit9tKXaPkoSpBxs0UaVLHsU9JwmpH
	ZgeJSC9irz6v9Shx5DPFocGSZlH3Pwiy7xPOOuZHluHsT0Fj9cEZyrU4oYMvy+MO37ETTqA58GL
	qEMdEh2Hxogvnd2OkPAy/2UgCtE1djHKjh9ZpgZyJNiRCykykX835zEwQOPUvSmzpYwqkRFOcrT
	ZG+WVc0jyiayMdttmU2Krh+wNnpOHcuzpWfWcQpxM7kYWVy4t2bFcexLMZAlo7spD/xEGe1Ide+
	JZbIlCk6eqSVwWGNxTttOq3ZuRuvkYOIySEgnY7cjwi/3830ovkXMV1lpQ8rY/Iz1W6clIpI27U
	lwsTzcHjxHSEud0qLDt12qOgeqh1PyjJIsmhu1eBYZr3RC3upivlFu3QC513TuA/0hwcnIK1acI
	k/GCrhf80MOpDnInXxmmx+xcq6PljyjzaoCZpQrUWcdwtlI1gJJv1C9ezsODEtyJp/zfzADFQZB
	C21ywnbxZAEx+Hld4aZFCmaV1czK8SVdetnbNBKhpgmMh1TK6A3Aex7gvJW3oQ9jnqDRXNleoJ+
	OuDqiUNCIQLNAncZE2uaFhxCCeEjcadRET7trifbslPmYbVnWGBQenM=
X-Received: by 2002:a05:7023:88b:b0:16b:4f52:a08 with SMTP id a92af1059eb24-1b502fe08aemr3394919c88.0.1794563403415;
        Fri, 13 Nov 2026 01:50:03 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm7489366c88.4.2026.11.13.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:50:02 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenwu Hou <hwenwur@gmail.com>
Subject: [PATCH v3] tracing/hwlat: Do the latency calculations in nanoseconds
Date: Fri, 13 Nov 2026 17:49:18 +0800
Message-ID: <20261113094918.2402297-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tr->max_latency is expected to hold nanoseconds: tracing_max_lat_read()
converts it with nsecs_to_usecs() to print the usecs documented in
hwlat_detector.rst, and the other latency tracers store nanoseconds there
too.

Do all the latency calculations in nanoseconds instead, and only convert
the durations to microseconds when recording the hwlat event.

This also makes the backward-clock error paths reachable.
Previously, time_to_us() passed the delta through unsigned div_u64(),
so a negative delta became a positive value after division. These
error paths jumped to out without clearing trace_hwlat_callback_enabled.
Fix this as well.

Fixes: e7c15cd8a1133 ("tracing: Added hardware latency tracer")
Fixes: 7b2c86250122d ("tracing: Add NMI tracing in hwlat detector")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
Tested in a 4-vCPU KVM guest; all three hwlat modes worked as expected.

v2: https://lore.kernel.org/linux-trace-kernel/avW1t81WLQ9YrylB@gmail.com/T/#t

Changes in v3:
- Fix trace_hwlat_callback_enabled remaining set on the backward-clock
  error paths, as pointed out by Sashiko AI.
- Add a Fixes tag for the commit that introduced NMI tracing.

Changes in v2:
- Perform the latency calculations in nanoseconds instead of converting
  only the maximum latency, as suggested by Steven Rostedt.
- Convert the durations to microseconds only when recording the hwlat event
  to preserve the existing event format.

 kernel/trace/trace_hwlat.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 65e184d800ff1..ed1199a6a9e8f 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -203,14 +203,12 @@ static int get_sample(void)
 	time_type start, t1, t2, last_t2;
 	s64 diff, outer_diff, total, last_total = 0;
 	u64 sample = 0;
-	u64 sample_width = READ_ONCE(hwlat_data.sample_width);
+	u64 sample_width = READ_ONCE(hwlat_data.sample_width) * NSEC_PER_USEC;
 	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
-	int ret = -1;
+	int ret = 0;
 	unsigned int count = 0;
 
-	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
-
 	kdata->nmi_total_ts = 0;
 	kdata->nmi_count = 0;
 	/* Make sure NMIs see this first */
@@ -229,18 +227,19 @@ static int get_sample(void)
 
 		if (time_u64(last_t2)) {
 			/* Check the delta from outer loop (t2 to next t1) */
-			outer_diff = time_to_us(time_sub(t1, last_t2));
+			outer_diff = time_sub(t1, last_t2);
 			/* This shouldn't happen */
 			if (outer_diff < 0) {
 				hwlat_err(BANNER "time running backwards\n");
-				goto out;
+				ret = -1;
+				break;
 			}
 			if (outer_diff > outer_sample)
 				outer_sample = outer_diff;
 		}
 		last_t2 = t2;
 
-		total = time_to_us(time_sub(t2, start)); /* sample width */
+		total = time_sub(t2, start); /* sample width */
 
 		/* Check for possible overflows */
 		if (total < last_total) {
@@ -250,7 +249,7 @@ static int get_sample(void)
 		last_total = total;
 
 		/* This checks the inner loop (t1 to t2) */
-		diff = time_to_us(time_sub(t2, t1));     /* current diff */
+		diff = time_sub(t2, t1);     /* current diff */
 
 		if (diff > thresh || outer_diff > thresh) {
 			if (!count)
@@ -261,7 +260,8 @@ static int get_sample(void)
 		/* This shouldn't happen */
 		if (diff < 0) {
 			hwlat_err(BANNER "time running backwards\n");
-			goto out;
+			ret = -1;
+			break;
 		}
 
 		if (diff > sample)
@@ -273,7 +273,8 @@ static int get_sample(void)
 	trace_hwlat_callback_enabled = false;
 	barrier(); /* Make sure nmi_total_ts is no longer updated */
 
-	ret = 0;
+	if (ret)
+		return ret;
 
 	/* If we exceed the threshold value, we have found a hardware latency */
 	if (sample > thresh || outer_sample > thresh) {
@@ -286,8 +287,8 @@ static int get_sample(void)
 			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
 
 		s.seqnum = atomic64_inc_return(&hwlat_data.count);
-		s.duration = sample;
-		s.outer_duration = outer_sample;
+		s.duration = time_to_us(sample);
+		s.outer_duration = time_to_us(outer_sample);
 		s.nmi_total_ts = kdata->nmi_total_ts;
 		s.nmi_count = kdata->nmi_count;
 		s.count = count;
@@ -301,8 +302,6 @@ static int get_sample(void)
 			latency_fsnotify(tr);
 		}
 	}
-
-out:
 	return ret;
 }
 
@@ -839,7 +838,6 @@ static int hwlat_tracer_init(struct trace_array *tr)
 	tr->max_latency = 0;
 	save_tracing_thresh = tracing_thresh;
 
-	/* tracing_thresh is in nsecs, we speak in usecs */
 	if (!tracing_thresh)
 		tracing_thresh = last_tracing_thresh;
 
-- 
2.43.0

