Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794813B7AF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853524; cv=none; b=coiYCt7CaAd9hK5lwQQT1jrWIBLnD+IXLZrLZYIZ4H8RhHPC2tFm4x1hiEwnZXMt7XfmtV9+MJ42+DZBvZMfqPJC1OTYEUq17pxt7RivUKF9QqtG3iSZ+2MvSTO8ejr1sJKGNsJ49eTYtzv0X8XB5W6pIgC/byXOKSZpgybz3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853524; c=relaxed/simple;
	bh=DukxrWCXAjyyH7zpUw9lAqh0pCE9UlNjO3BaKcx0yMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agdHygTRXR1kIVHfn6JmVOaNe+5ZOUuslMED4zHdTY8Xx/n7pf3ySQy17l2KAiFnftprP26KqV7epzANGC02U/D8WCVw+DLrUwE8lwalc8F9dnFYWtHTQtcNsaJfammjmw4RcAX00EZ2WYIaE6jYzeQzMrEeOaUkYyIkhsWzGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zv3Fm8NW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zv3Fm8NW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354fb2d9026so192590f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853520; x=1717458320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LabiRKd6+Fdc1S9teFQ4XXd5rRTCMDgsFOfIBlpIeJQ=;
        b=zv3Fm8NWfLrh94W5mbCakfMstwMO4wu8AdTeDfEvLpZSjKRj/4qeCIwudlWxcYS8ol
         p/Eb3wAeirABuNhlt5fJ69Pbrl6sTz4RECNH6BHdBgfxzo1Oz7afBzHmRWPChALa+v6n
         gIHFNppSN7onGqSKdvk00hjjUaltzuTdP5Oqmy7Lf0gaZ/fjX/oc8+6LY445PtIwURfp
         vVhZ1EoHqaVsXZRy3MdTpqE6o4Rf/CSPIPS93M4nXMU+0lBVSz63EvB9IDGG4SJOGrK3
         eKuNQaKYD6iobPN6WcIeIIJ+w552eGfxrJEh2VCugtOCUIddCiifv/EXBboMlW75GA9C
         kQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853520; x=1717458320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LabiRKd6+Fdc1S9teFQ4XXd5rRTCMDgsFOfIBlpIeJQ=;
        b=lmkulCYmbc21jkqJrtPM1zvWDtJffbtuy2wx69ep5NSXyA1g7BvgbK58+tYQI0oQl3
         DMxidmBOJWIsGY/VoNBLznQG/iccftr3+ZQyvf8sFSdesQkbNxV7WEV4tpkBKSeeR591
         ddgkcBt18BzO3pbZkgozvQkmIjnJ0ayVUj6JKu5OHV9ZHhBVEpnl6N23fp5okT4n8uvB
         wKs4UPED9xbRhiS6eDY8eBAvkzCsLCKQN9aDboKNRoFs/dp/FhXTzMX+T580F8/K+Yfp
         DrNIf7KalfYSPbhUrStIGFc7akCYgW/LdDdd74l2PkuxTIHJbc3gsmgbIcmjPJjx5p4E
         5JUw==
X-Forwarded-Encrypted: i=1; AJvYcCUfskLxi7yAAOavqnBmp1JZMLiVaga4TIP72XkU7v/gIUWeUBdOIrx/vWskIZfVfJ8ImQ7pd+UlRAgJCB40tzw63ifj5xBt3k6bseQrsw9N7JFM
X-Gm-Message-State: AOJu0YxeciRVDzY/ret+1Wp6pPd+Hy3PGTj7CF63MWWIccB0HYJj9Ra7
	X2tZzACHL67EOyfXHAqkyft+tGi54XX4ju7kczkTKBJSa98BtdHRJJ/50/6Ve/o=
X-Google-Smtp-Source: AGHT+IGy/gagOKc04QMh7vQyWY1fx5jjEL/7vEbfZ1S7DNLjj4/0M9wIHpNhOOn/pNT8THqBrympIA==
X-Received: by 2002:a05:600c:3ca5:b0:41a:b54a:9ad8 with SMTP id 5b1f17b1804b1-421089fa29dmr70623995e9.0.1716853520726;
        Mon, 27 May 2024 16:45:20 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:20 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 2/3] hrtimer: Convert realtime_task() to realtime_task_policy()
Date: Tue, 28 May 2024 00:45:07 +0100
Message-Id: <20240527234508.1062360-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527234508.1062360-1-qyousef@layalina.io>
References: <20240527234508.1062360-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Sebastian explained in [1], We need only look at the policy to decide
if we need to remove the slack because PI-boosted tasks should not
sleep.

[1] https://lore.kernel.org/lkml/20240521110035.KRIwllGe@linutronix.de/

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 89d4da59059d..36086ab46d08 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2073,7 +2073,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (realtime_task(current))
+	if (realtime_task_policy(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2278,7 +2278,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	 * Override any slack passed by the user if under
 	 * rt contraints.
 	 */
-	if (realtime_task(current))
+	if (realtime_task_policy(current))
 		delta = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
-- 
2.34.1

