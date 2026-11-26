Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729550;
	b=C91V4puix4+dF4Zqus2tcFK0PAiSSZsXknq3VWMjVQ7hoFvdURPsAEYCnDvYXLDylQJE
	 DxBVLpLMaPXjvGjas2xsma4lanPtdr+3rt6ccbfnvQc6eV9m/uWUTYFF48n0n+ZMH3YAf
	 2/nTcBXQbjTfaX8lykya+f2e6iXHSXJyQ4boQY6DLyu3kFDZ6r9dKzGQXjaQ4Lr40nW3G
	 Va4sdJM1wQiPuEQh/pBGCtiZ4Y4PJQh3kdYWFliEQXXWTTF5xUNe2WX/26MJGcv+q3jWY
	 rhGE9uT5dIjxEIRxvlAhH/AxpiI5N/iHtNHHgd+swgE5pNGzUMFh4AX7v0IwoxWyJpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbnALwWQni6QwZzrT13h6XvdU083PfOU1t4S0GjBaUw=;
	b=Qx2oSu4jGbbMaH0jpT7ItwLQCeF4a5RN6k5N76bjxfYAsvcernOvvW+QsgQwUwShotD2
	 4q782YrvbwI8Cy0HOlvIn0Sbx9zFuVocmb1dNd6rxmLfS08kDwNVlkGUpUiSMF+FjDjAe
	 LOWDCGa3ZC8xkhcyFVFhdlzwUZaaW5KxIgd1mP2IALkKpEdR20DDrpFaGx0mCjkxkbiVM
	 OLNV+zujxkNV2ICksWzQZir40FCTFRDd4DgJ50ubcBa1UQvUi1znJrOjZ3AMwhQLe7y6u
	 y+kDVuEeAogWdEp9R5zNhHtVz0hZB8K7BDjzu9n7FPN4drA4ChpSZ/W/PdmqFo5V2zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nvn5o3t4;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AE606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 21:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C64AE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nvn5o3t4
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso75444225e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729548; x=1796334348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbnALwWQni6QwZzrT13h6XvdU083PfOU1t4S0GjBaUw=;
        b=Nvn5o3t4utjFHwq8P8C6aVYApdvQi/eP6pXDMwbDBFNn+Zgs+Spze6FEolyTC2A32Z
         w46FB8WOcZWJVaNrPLBu66odoBKakmSn6VG+/uO+VsppyYJU8O9cyQ8jmcSIp+bm7piE
         URb3Is1TN7AbvHT04OMQVQnQ5gV430WRjcampM7+J7jQdNV7Ufq4+jUDbR4ztiYtABZk
         S2gT+BLg97r0yPg6jKQNXzJyItAtSz3UxeyZ5CxFmA9EHnJAlsr2plu3Q4HqT5HN3HFf
         Cz/FI32hxPt106VQserQpFlOmXee2KupSO1NBxKW17hz4yt0f+BRX68pg91EWjnNhkDd
         l3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729548; x=1796334348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbnALwWQni6QwZzrT13h6XvdU083PfOU1t4S0GjBaUw=;
        b=aOV3SolaT4QeHEugxmENQPH5U6OAczFRS2EyVGgD1ao1mfHZ8Z43q4hSrv0qIoBHHU
         GsbOz2KrY+Gto+Z4pjtGhG00MGc7QB19GbyzxOrhbCbMmWdricTLNJNtRvc9T7Yp0omA
         j5ymArVwfNjxcpgG0wqNSaY2JB50z2Cj2LXKy4LfCgSepCYxQm+d7xn+eLLHebicjeQL
         cHIrzR9YuNn/HJVwSE5q0XthvhySXpZhzb0iKCVdO+MwCkRL1zYcnbanrQiNXxSFgdod
         p+LMsj8CJjhNHXwG5LBzFTI/tFGQ70Wq6QTD0pjK7bhaZPLOD/pMKaoS7KTKTr3cTU0V
         /bug==
X-Forwarded-Encrypted: i=1; AL+hErEwwYcHOYMAu2jWYhiHjMLGpk3L2Lz3qEiCvHjjl5YF7G1QTBzNVER0yGnsOSAAaG9Jk8TG2y3qOdTbJ1SppdFS9Zs=@vger.kernel.org
X-Gm-Message-State: APuU4Z980TQhQm2oz5sdQUL8F7d2uT1aj1sbpF2i8cxhAhc/IXyhbiZO
	4tTdC5L8PdOMYXJyvs8Fe9M80EZTVSjoyid3trSgnpvLTDbj1eKT07ZI
X-Gm-Gg: AZFdTZcBf21E/SFY1PYSEc2OiqqQx+bXiLQXaiGbWm4iUXGX4GkV5GZhwITjvRChRtf
	FMOrlEKoOOMVUUd6T8R03XxOEaFBhCKx3CZ2z8M4lXBYRqab2/wubHLWPP5EztC8aPewxQ/Hfrp
	6K7qvgkkIQ97grlm88NUjxvnziEoXzRavLWjNijJwKnx4L7wHfgwajqhtoKFLgpjDGYfqYysVZu
	F9Zv5TatBHkCgzD+mIAo5aMJCMwg/NoirPt6/nqq6RfPAMFBem7ur6u5EEz8HMRq+uh3x5Easre
	FD5XoOOF4V0muowzNDeC0NUZxnTFkhILbPNNkvEcEFdBDkpKHhbvYCLbP7ttPxdp+2iIOixfFBx
	zsLkVRM5+zo2ROM3zJ73wKTazR5uY2PhAlw9atExzdGDtmcZalAoO/sdTQoT8iwE7UlTwsZRrqg
	xXLbPOPzt3j3A2DA3IQHdhrwLfvnPOqGiXBoWhm5remc0G1DvjLpzY/BgORq6fzdeA884QJvcba
	xgJV95IxX85DHYERzTAbIzrH8u1sdTGJTH7n1RSYrkbPVN5foQOV6W2nWm1+ge9/XcSv+VK6i8d
	IgxQDQvsIHbDbsyWpGpEyoMli5wV3TWbKepTT+NwIVJjlorJwRC31ioy/Ky4wuBwAadb4Ra1G+y
	XyGOqrkSdl7wb0A==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr472705935e9.34.1795729547788;
        Thu, 26 Nov 2026 13:45:47 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm623698185e9.10.2026.11.26.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:45:47 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix trace_event_file leak on read-only instances
Date: Thu, 26 Nov 2026 21:45:44 +0000
Message-ID: <20261126214544.1202386-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

event_create_dir() takes a reference on the trace_event_file that is
dropped by the release callback of the "enable" eventfs entry. A
read-only (backup) instance only registers the first
NR_RO_EVENT_ENTRIES entries, so release_ei() never reaches that
callback and every trace_event_file of the instance is leaked when it
is removed.

Move the release callback to the "format" entry, which all instances
have.

Fixes: 2c79da099aac ("tracing: Make the backup instance non-reusable")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7f89160aeff3..b3f63b1f86e0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3276,7 +3276,7 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
-/* The file is incremented on creation and freeing the enable file decrements it */
+/* The file is incremented on creation and freeing the event directory decrements it */
 static void event_release(const char *name, void *data)
 {
 	struct trace_event_file *file = data;
@@ -3298,6 +3298,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "format",
 			.callback	= event_callback,
+			.release	= event_release,
 		},
 #ifdef CONFIG_PERF_EVENTS
 		{
@@ -3317,7 +3318,6 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "enable",
 			.callback	= event_callback,
-			.release	= event_release,
 		},
 		{
 			.name		= "filter",
@@ -3380,7 +3380,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 
 	file->ei = ei;
 
-	/* Gets decremented on freeing of the "enable" file */
+	/* Gets decremented by event_release() when the ei is freed */
 	event_file_get(file);
 
 	return 0;
-- 
2.55.0

