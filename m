Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0E275870
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 May 2026 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708581; cv=none; b=A1WYlicSmuxFs15YuWWuSxzSqfO8pkGXK324L4b9ev77D+fmYWA0OqO/cP7PTD67mK9YkFLp+Cma0oskKXXRdqnh7Xuk54ZC5zPMpg4Hm5fKF3LvQI1ITITrMscLADgRJlbswVl0kr9B384lVpgsxA3UCVzWgjWV/xZX0oI/x5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708581; c=relaxed/simple;
	bh=GoffBHbQYFrw6Z0Wmn9y4jK2vvEUyta7lPGW0p12fcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdX2Az3U0xPFSDHRmLHT1mLVu9zmC5sHxXmA/emLzTC1rw+ywn5y7GX25kiwrmR9yx4U42QKve47vAPH13Xpsyh3Bp1uUSn5EyP8VFZurDlNjsNgWNAnxlQKf2KFYlEYdX6RLrP75qg6hX1DzcD2R0EfT9yHccb1eBcfDpitxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh70oteK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh70oteK"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so1091008b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 02 May 2026 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777708579; x=1778313379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibf/edoeh3l105s3NNDXpaKtoD450DpqiDhI9gwuPoU=;
        b=Eh70oteKs4yTgEwkW6nhm+HmIHNEjkXwESmwrGWi5/jKjO1oNw09fqyJ3uOxzc6W/7
         MWrBaVljHnQy3tojqagpjAFAVxuBzRYxbrIzoseLOEXl4z234xrtJnwgp5fDnS0GSO27
         dYm3zzkXrAeTBpbL1LEQPIoEOQn8XpeWDrXZhvZkzsaol5pDX4fB6fI7KmogbHhHwzfN
         jU5mdTiTZ4HygQ63XuHo8ijfcDnQNoyFxUNMaMTNonOcVyGgLZJAL7quzh2iwsb5tYJb
         7y6PBW/253c1366Exoax2hp6ObgBQxUrcICRVU0hY7fNCHTssoFP6elIy1jFPWmtdpjI
         DTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777708579; x=1778313379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibf/edoeh3l105s3NNDXpaKtoD450DpqiDhI9gwuPoU=;
        b=XrwVkRCYo6eOYQ0N5MaiRRvbz11mwL7LRsXOrItd1zRtPST1kdx1GR6BiU2BpvTs5+
         Nc9fby6kITm2VPWZyKqD/UwJeIFkgTis9F91NNmLizYNR11YElfQMVrYOGU7SFDGQuJt
         wo4XGujt4lFIdnjOkoNKPF9mldQ+MIQuaZcw3KSPvRighWsyUIl2tAHyE1QBqAS6zuDV
         M66VlpboUsNJaR/cpbL2v00JkPtLU8owpWYUK+W6MwT0H0wyE/TTXt5fJRn+AXEPtObS
         koxjDZbgDWAg1zKJcdw/J96etG77de22u9kszIJ3CY2VcBYnqifDXJKnK2lpmiCHjl9s
         3dzw==
X-Forwarded-Encrypted: i=1; AFNElJ+bG9OMW1CWFCiUleFykrLBLVEWLsH4sLxYZdIR5TSrkDR+KFK8kZ0S3tlnCDDIibigJmHGjBQ7jfVXr4lXi7nfSq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiiIBjl2zQ1InZqGNowIUpEjosDTP/+2npr1qh580KX8EtA8x
	itfBbEttwYBDiD58eWrl8upsgTIyuJK2KHh0h4GH1sIwAYM1HkD7H5+bD88+Jb4a
X-Gm-Gg: AeBDieshkdw60HouHcearUnyqG1mLecnHqhPivLjdVXltmtWT/P4xvssNKUsWcdLtk5
	LcM4LNh/4+BdpL4odN3pYN25RAYQzX+cd8tyb0ru5TWwQzNORf3ZLdbmf4Y1lpIlyNmQ/qoN7W4
	Ubv6UfSrsgPF0bun602P3ZSD/33m++M+7RswKiqaJgMzEyMZyD/4pmXQmkLYHxElWM6PwZJQQ7X
	MKmyH/iU94sAzBnT8WlJHX5QP2R3+qJUdeahM8D0kqfOXDtdvjDUHRuZnmysDvyVx5UzhL/LRMM
	DjOgZA7eZYYAs5yLH0NFJ66foIenpjrUuTSoeKHW7sAxLoeuIVB5++rrrbhLSc1QttKEb6zoAAT
	Tve8Jl5U38iDdML5WTdM9noQ8WcgT5kpbGANbUyjwODvFGJeC02VwYkJ4o4jdYutrCm3shJHWdu
	5t5xNqXCHzmL5M9Z7nXoS8izyUlW1GqKrC
X-Received: by 2002:a05:6a00:14ca:b0:82c:e5d0:5249 with SMTP id d2e1a72fcca58-8352d1c59e5mr2386858b3a.8.1777708579315;
        Sat, 02 May 2026 00:56:19 -0700 (PDT)
Received: from nova.. ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158312c5sm5247062b3a.8.2026.05.02.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 00:56:19 -0700 (PDT)
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	david.laight.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qian-Yu Lin <tiffany019230@gmail.com>
Subject: [PATCH v3] trace_printk: remove local variable for argument detection
Date: Sat,  2 May 2026 15:55:34 +0800
Message-ID: <20260502075535.34997-1-tiffany019230@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429165707.7020-1-tiffany019230@gmail.com>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace_printk() macro uses a local variable _______STR to detect
whether variadic arguments are present. This name can shadow outer
variables.

Replace the local variable with sizeof applied directly to the
stringified arguments:

  if (sizeof __stringify((__VA_ARGS__)) > 3)

This eliminates the shadowing risk entirely without introducing
any additional includes or local variables.

Verified with objdump on samples/trace_printk that all four cases
branch correctly: __trace_bputs, __trace_puts, __trace_bprintk,
and __trace_printk.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
---
 include/linux/trace_printk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 2670ec7f4262..3d54f440dccf 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -86,8 +86,7 @@ do {									\
 
 #define trace_printk(fmt, ...)				\
 do {							\
-	char _______STR[] = __stringify((__VA_ARGS__));	\
-	if (sizeof(_______STR) > 3)			\
+	if (sizeof __stringify((__VA_ARGS__)) > 3)		\
 		do_trace_printk(fmt, ##__VA_ARGS__);	\
 	else						\
 		trace_puts(fmt);			\
-- 
2.43.0

