Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887404;
	b=n1cOR7Ns6lfrlCGR0QXgWikNuCqcmVtj/wX2PpYT5WtPmPIufRtunMgdzIzmveQm0grG
	 qM4eylWmeVWBcmyxc5gSydR9gBF1iqcES7+87xfjko0+oOpDEw+9iMyml1cW5uwgvUidu
	 qzmQTEnl4YmBWh84+BnD5n8Hlu4dm0WwVHRDBgT54wX3PlrSY3lGiMJ19ab3FdK9NXdTF
	 Uy/Ep+4peTLBpGfxwxyA+NPrFofKPbYIFWzCMskxyNjKf5mgTtd7kEsc1kGmxlgH7FQn1
	 byzt3FY5isLXuntMctrkStbLclbyOnikVlh2FdvevTF7tIR/jcv1DRj98kN42chTlqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q3zuYC4N+4jQg9NxR8G2yKJ6ru0qT8VeCTZSqUBui/g=;
	b=UByQKHx6wtEzLOC9WWK6jXELgpLipyiwvhf62i2SCY6c/vA6PRyuMUlyK8GBowBPZiYr
	 yTdV5gBaW0So0x4EJ/QiKtmqTQBoO/6Bx4gBLOpsyPgI/9ioXeYRQ1G25I5gpIoUKmNh7
	 k8i6TB2tG7wZOyGBDDrZ+zePf4TuO0ua2oHcC6JNRi7FYqPhorZZ0dLvgAzfkCoBLUyR9
	 5qCgg32ys0jIx2lPBjbL7Gfz9NbXf+Zg4hk02a7vcaNaCKcT9HDIc253jXmsvzlyROGjq
	 Wlf4Le5bkANa8GCVieyFNtA29Be0mph8CgRQHI4WsoNZ29UoLbbxdw18jP3XfhenwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjFgMmYX;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC83606D827
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC83606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjFgMmYX
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36d6765756fso2217054eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887403; x=1794492203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3zuYC4N+4jQg9NxR8G2yKJ6ru0qT8VeCTZSqUBui/g=;
        b=YjFgMmYXFwlaHwMzX29PaiUvO+EMotve+U7w4xLuFRkknkgMc1Bu2sIdIkhSlDWjTs
         WSVUCAYAVPSa9OSqKVkCK0ciEgcIKhYAiKwh9PnYNUyUvSucoEa2ZLoTs/jgkouhUvTq
         EAtv6KeIvF+bM1EQERCmBEYHWCfZRqnL2kGjU8Zv5JnM8msN94Efi1EXI6KTK/4AeTBZ
         8Sbhr6sIhFTYmonqAhuxaPl96JJjwDaz8L8OdhZ4tcnIQOb5XokHo5Rp/3GmjaY2kI/G
         22ZzBO1ufO2OU1lHc/dN9ZjAsETgRgdHlvjH0ySvoRtTVHwfcThHtdouCKkIpWO6+F46
         qi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887403; x=1794492203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3zuYC4N+4jQg9NxR8G2yKJ6ru0qT8VeCTZSqUBui/g=;
        b=xGOBt1KCAO3Qhs6/n8UmJ1sTuFF1Qo3Tg0t1I6dV4g9UlARC8fTqABaoFyz/KTE00k
         /nXV6h//u9Kr2YlZagfAW2gRya1biHicHj22bFoRUZ3derXC8kerZ1rGBxYrZb4XtTMs
         PRp58c527blq2h6trcJZDpxjRyMIhV/20iNAzlbmpJxMzYWHQ0TUhVxpw2jrYOq7R4Kw
         w1mov+vLYFYmNxL/mY5v0t6XR3IQeV3G8Lx1BPAx2Ylyf0TyUyP3ysg5A54NoQri2fob
         XuUj50pwVCy2mnb/5uAsytJRlVYE+NG9KfyFO9q22iHnM/dhrf786ADK/Zqa09QehPg+
         +5/A==
X-Forwarded-Encrypted: i=1; AKwUvBwWktJo1GTwzVHdOd8xVOMjxp9+ijgLkGTtiVS+idoGCtKXvuFmmPuhubyU+ZrS6WwA8IGwBKCJmB3drQQBu6KsVgo=@vger.kernel.org
X-Gm-Message-State: APuU4Z87QCNj7LBkr8MLkC2ZRW/vgXHwltK3kRU7hjKf0S87gwL0W4h3
	/PpsIIzAqCW2UvxsfIFEl7aoI4uA6M+hsxCB3Uuq5F8Xt7vVHyrOHipJ
X-Gm-Gg: AYBFou0Fk+R98ETcYochP46qa5MG9NsEYJvNDsY9PaMqw972GQ7VxHefu+7Syr/A4YX
	CFfOH0bdtPIgGFjaH+usb1l5Wnk5MR9+DrqxS8ZX5/BvlhidSPRDgWNvTAKmeCeMeoFd3aUtU/Q
	CgoNORGGikzxca447fFCrUnLG+xBQIwMGPdQTJoaL5Ax1z4K0+BjWVGy2EqunjJj1EKoJ5epcFD
	Lcj0YyON1pyPVmQKj/3gigZj2LGEfkY8qpn7dJ91XYAoIK0im7KtGH5W9XqMCDGNCrC7ZWyDhZ1
	Rf/cSUC6ZRtz/qmyRzCQx9oNQ8EdvbfPopc3RsMh1Y33qUHTw81Q4r2uUSW/5+eF2EPxmbfEqWT
	5qhbfuW6OuUWoOG9OPvFtLmJRaunfmBSbwzak2anN08t/Cncu0OGybiDw16fJF2MwDBlMoFgBmd
	BjMXyDr3vf1zxu8rtQXM4pDt7As3G835KuOR5aA7KHYvGqFJnUUkQ0kn3LHRtLf3mcH2jZGu5RG
	YHu44PKEACB5LNu1JevTmtZzn9T4SrYm6v5csq7+/otEiqSx3GGWYaeFAtlWKaOyVmC0//qJz8M
	i3ltH3n/Yi9NaiS2CwcTdB7TwJ61OFwhdOCCdM15nNF9jM8ttdPvplkgaledRCxM9nvAJkwUgvb
	H+SRv1mGmBbO/t4c=
X-Received: by 2002:a05:693c:6092:b0:35e:5ca:e0df with SMTP id 5a478bee46e88-36a424609c2mr34113914eec.35.1793887387708;
        Thu, 05 Nov 2026 06:03:07 -0800 (PST)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm20969616eec.24.2026.11.05.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:07 -0800 (PST)
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
Subject: [PATCH v5 4/4] Documentation: document trace_stats memory_usage_kb
Date: Thu,  5 Nov 2026 22:02:21 +0800
Message-Id: <20261105140221.44614-5-gaoxiang17@xiaomi.com>
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

Document the trace_stats/memory_usage_kb file, which reports the tracing
ring-buffer memory usage categorized by buffer type and memory source.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 Documentation/trace/ftrace.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 9423722848c6..d7af1e37e6b1 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -218,6 +218,28 @@ of ftrace. Here is a list of some of the key files:
 
 	This displays the total combined size of all the trace buffers.
 
+  trace_stats/memory_usage_kb:
+
+	This reports the memory consumed by the ring buffers, as opposed to
+	the usable data capacity shown by buffer_size_kb. The value is
+	categorized by buffer type and memory source::
+
+	    global:
+	    instances:
+	    snapshots:
+	    persistents:
+	    remotes:
+	    total_system:
+	    total_carveout:
+
+	global, instances, and snapshots come from the page allocator.
+	persistents use reserved memory. remotes are not yet reported and
+	are always zero. total_system is the page-allocator memory, while
+	total_carveout is reserved memory that was never in the free pool.
+
+	The same file is provided under trace_stats/per_cpu/cpuN/, reporting
+	only the buffers belonging to that CPU.
+
   buffer_subbuf_size_kb:
 
 	This sets or displays the sub buffer size. The ring buffer is broken up
-- 
2.34.1

