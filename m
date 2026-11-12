Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485756;
	b=kxHDsT9gMLxVSJZNYNyAMWmspyV58q5nb7kS6p3Fqt19HIbwMrkW31XjMjDp2XSmZBfC
	 869SucgshjLNisr9soj1pqBQV9gEoTJJqZEpdckQRt8+tKPBXPpGTAKbCdoHOl1WEHTV2
	 nosYakULeE6vo4SSyTI3VsVIN3YyeQGVZByolHrAirkQ7e1BiMai1CzQ5zWMQ7r9dkwdi
	 OpJgABaA3MHn8xlCAbhP4BaTdgyRQM/UmSK9zWi/7gjo2vlw2L/3sVFyaN2dU7lpVUFp7
	 CQk24CfgKsJBJaZlBVlvhTqzllfBqn8xM8myUs+rFXDoyyw52TRh9YCCcADA+FyKPEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B5dwS+JSg4KVRmJk8D3bUXhM4YDMd6Zv8kscnFZDGw0=;
	b=r+aCNgVG/u0XPXOb0YaM/GgDzLBuwC9zhiqDuEheMZs0lmSBDvNS79s3oZexhdYjkNh3
	 Zfz5czSvensAqXqPcC4cLsfKmh3drD0/+DpF02jbwWGBuOw+ck/m7nUsdYkp6LRJ5M/+U
	 t2+PaLnibjnzcS39CTZB6ZPiHagFIm+pTcuGoPWpiUb93S5us4u64c1frbkNa8Geeyi3l
	 muybNTFdAsnIX0uqEc9kMXI2uoHfgrdFxgrFwbSRsiw1XIrXKa+/nUaAi8DZcdV2J4Qs+
	 B9/jyFOoj71cSV7m5UI6O8Ra84bztpPkc7AuA5ktr/KyJ8Wflidg56DmN+FH/Fn2LYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojOTqk+E;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C0606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 12:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24C0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ojOTqk+E
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36dc4797082so216076eec.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794485755; x=1795090555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5dwS+JSg4KVRmJk8D3bUXhM4YDMd6Zv8kscnFZDGw0=;
        b=ojOTqk+EuQHLzkYchUS8u1NhiDCGXK6+ZTCp8wr8E8MxxCh6KGaOgiWkpF9wEo+Aq5
         9Oycc0UkhL75g3VBdDtUpJCTnJSC1961/Ty9O1jYte/X+dRsz+xqcfSrjIcKf1ktYBSg
         yvi8ppQpABu72JEff7Nh7ulrGWgNHwO74ICgPLrmHDqi8h0LBdXi2KFgRYqOFXW+zsTV
         gKbECRsgfuHX9IZdhPZhwYHiYwByF08YDUIdizh9MpdBNl3bgqBxoDpzMEEL+JNJUxb8
         pVxAyZD40+j7XJ2C9YUzyWlSHctrH2XTkZzJb4cPoZvBn0+WviVhYPraFFQKGUBZ7rBT
         D/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485755; x=1795090555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5dwS+JSg4KVRmJk8D3bUXhM4YDMd6Zv8kscnFZDGw0=;
        b=niseaantmW8k5pfeDfH8CZFZUJwY48S9M8qQPdhR3xuqgAcHzuYtbB657gyeCZ2b1q
         B44tjb0/HTZdxSfZAYeVYGq7WXG6N9BrPElPGl/fQKvh+QrB6RDCB4qeCDprzOClegX8
         eRaDWumNaOI2sBgqQ1c7zA7cFuBnMp61Phoc5ulCjLMvcNy8grFeBUdSKQJfk+UNS/WI
         oUn4ufH7w/46ILUv44puppq8JpYFbKFqQ0POTUWbg3PmUQXhsNMPb2wTgpmx3Nuzuiyh
         PF34aURd5nweQ8e2X9TotFLb9Oz+ZWb9JuRp/KaxxZHy+weR/YtcY8sMFzYVzPegvlZK
         o8lA==
X-Forwarded-Encrypted: i=1; AL+hErF9fiIYQDD0YXSt4f4Eo3STl/UMF8h5Qbbgq1fJlagW1W5Aq96a2ViCM4vpz+SPtKiYmj63hSXQQi7+JlOuf2gTmMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z968E4Pw89CWLyqCuMQAFri9wWNjsa4qWiffYqAb4flk+7EXgQ2
	a1npGxSvV9/qEBPbh1CUxjgFvpuWEXU2bLOoM1AQ2oVhZlJYxLBFz/fv
X-Gm-Gg: AYBFou3PAy3an1jqqT2PAJDQmdB/T0fKRYpHZKNan0QPnDFKllUfVcgX2m41kAsiG9B
	FMJiozHVn+7QgEDTMswHNI9LN//6apUjDdmfDtGxia2Q+9P6gC6THwmhmkgezo1Os0/3gZk1jpi
	GWnAN+efILaI8ZgjXJzNocgLKqigadee7LOCm8XVyjwUYdKn17TdCnRSJPG+PgmqepFS/UgC7Ym
	GxCuwtlfPgypKcfffP0tfP/tQycEym0AqbRxRAJEyaWzHomAfP1A4jETwtlgM2OU9cmd48tuoru
	yy8wNRJOkUZoZhL3Ni9rpSNYqjitrL3KeTtPc71L7CsiuHEq27ol73NjlFW51WTXDtLxwsWIB6V
	luO5e46oLv2ZmJbhmxfK4mJ9JzUKwzCp1tUVDD7d3WgxaBP6HpL545T2e40XjugZIekZ78inYkh
	1nJ7VZSC2zQp2PXC9sqmCjfnam92z+HlDMz78rqZm526oVkg3LK0G9vNvGCCC9Sv/01ZLs0vW+b
	AZjeMcMIL/yyAbDY2+HThcANRsOG4h3m6iTcqSFYcoMJlW4UComJjrwEr7vE2wKEOr+r42ic+qw
	ftNJiv7VX4aNKD7+5wrLurQ90edetJ0AtiAPU6JsTDbHfAKx1zSjHwxVDAlDAQ3B5Myo5l26B2h
	+
X-Received: by 2002:a05:7300:7aa5:b0:36a:e7a:e89 with SMTP id 5a478bee46e88-37685c76d17mr8719831eec.2.1794485754829;
        Thu, 12 Nov 2026 04:15:54 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm29740235eec.14.2026.11.12.04.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:15:54 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenwu Hou <hwenwur@gmail.com>
Subject: [PATCH v2] tracing/hwlat: Do the latency calculations in nanoseconds
Date: Thu, 12 Nov 2026 20:15:01 +0800
Message-ID: <20261112121502.2070755-1-hwenwur@gmail.com>
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

Fixes: e7c15cd8a1133 ("tracing: Added hardware latency tracer")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
Tested in a 4-vCPU KVM guest; all three hwlat modes worked as expected.

Changes in v2:
- Perform the latency calculations in nanoseconds instead of converting
  only the maximum latency, as suggested by Steven Rostedt.
- Convert the durations to microseconds only when recording the hwlat event
  to preserve the existing event format.

 kernel/trace/trace_hwlat.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 65e184d800ff1..a16905ac12b0d 100644
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
 	int ret = -1;
 	unsigned int count = 0;
 
-	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
-
 	kdata->nmi_total_ts = 0;
 	kdata->nmi_count = 0;
 	/* Make sure NMIs see this first */
@@ -229,7 +227,7 @@ static int get_sample(void)
 
 		if (time_u64(last_t2)) {
 			/* Check the delta from outer loop (t2 to next t1) */
-			outer_diff = time_to_us(time_sub(t1, last_t2));
+			outer_diff = time_sub(t1, last_t2);
 			/* This shouldn't happen */
 			if (outer_diff < 0) {
 				hwlat_err(BANNER "time running backwards\n");
@@ -240,7 +238,7 @@ static int get_sample(void)
 		}
 		last_t2 = t2;
 
-		total = time_to_us(time_sub(t2, start)); /* sample width */
+		total = time_sub(t2, start); /* sample width */
 
 		/* Check for possible overflows */
 		if (total < last_total) {
@@ -250,7 +248,7 @@ static int get_sample(void)
 		last_total = total;
 
 		/* This checks the inner loop (t1 to t2) */
-		diff = time_to_us(time_sub(t2, t1));     /* current diff */
+		diff = time_sub(t2, t1);     /* current diff */
 
 		if (diff > thresh || outer_diff > thresh) {
 			if (!count)
@@ -286,8 +284,8 @@ static int get_sample(void)
 			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
 
 		s.seqnum = atomic64_inc_return(&hwlat_data.count);
-		s.duration = sample;
-		s.outer_duration = outer_sample;
+		s.duration = time_to_us(sample);
+		s.outer_duration = time_to_us(outer_sample);
 		s.nmi_total_ts = kdata->nmi_total_ts;
 		s.nmi_count = kdata->nmi_count;
 		s.count = count;
-- 
2.43.0

