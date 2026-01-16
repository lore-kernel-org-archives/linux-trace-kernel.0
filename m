Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DAB31B108
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565409; cv=none; b=J7SktUXfqTpZQsGbfi0sBCvkuPgLpxhojMW5kJu4GlNe0TRjYOk9eS+j5l/XVnZxf/jDryUwoZU7TbmhjYrkFam2LA6cbExC2/DvENQgBhAa6Ij3sqZHbUypb70UWyLWz844wOXXpvX0qG8vhdJkfA3MuDpV/b6jSUnbaO5WpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565409; c=relaxed/simple;
	bh=wzqwRBKyLSM4GRh0kCYODc/MRx83ikN2FZc7umGbfq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UNJklPcBfIjsv/VSg4tg2TnM26b5PxK4YIcqZ/Iexj0E7TPeq0CjS7uYIysxsB8bY4OIVkqSwra0zvfU0B8UxxtZBr+aI59WhMLdrMn4SbsmKSYDJ8FcR0MIwrND4ngsimmK+qH19FAnvQRO8K3zXpT5gb6GK4RxBfypE2yeE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=xLPLbLhj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="xLPLbLhj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1557751f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 04:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768565405; x=1769170205; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mi5C2RjIhBWHQ4b9al8Pcu5M4rgSXenEslgFD0XFaWQ=;
        b=xLPLbLhjm7Uj09EdP1Co4fxCV+g0ZFFAgZETxzfZhmC6pCuv9wOtxzXAhJtrfiZlBA
         h4nLMLcv058hiu+6WT7oaqCSz//oU15/6I+1+YZ9ahI9VI4XiolYjeru2J017r2MSzG2
         AfAB1qoPjm1Lgbe3IbFhqkNOC424O1pKXAxubrzZkdJYwkJtei0p0KXpCF5RiNV6EIaW
         VR2nb371I9AYYnV7XMvUpwXUbyolNjlzJXXS9abCSl8m9plwKHtguxd6x3ZInhRjj7+N
         OOLKgsdQpuB2nyYHjqgr4/pM55M8dZ8TBFVh91SAkYllJohh81DVIr0/MSS5niq5lq6g
         ZpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768565405; x=1769170205;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5C2RjIhBWHQ4b9al8Pcu5M4rgSXenEslgFD0XFaWQ=;
        b=H7GnXM2UkzZytWMOAt1XdefgQ9a1q6xkslYQlTQEKpmsfXLUVgoY1ycwPwBD0K994j
         SYaRCvbdmT0+NPXd/mO+BgIEWWtjZM3sjeG/fpEMTPWV4mDMMjtVo3hsc2/doWv06n1H
         lIv8v1XOOqW4ORT7i4RLtVibwRSNm1yDnO1WIcTKfWNQBzheXJU9gmBrv2ILGHLq2wMK
         L0N2RxmQXV4c8PvNkAXOcykeEBeTRdVSJQqj6XqQAAxFYAZiE35NYpngwoPZ+1wViNeu
         yS3KO0irbgUK4D3RC2NzkcEhwpvQlSxmdaiBebcfBoxR3k3H88Kg1PWP1OSJ8py9ZRbp
         jQVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDPDF45ttFVbZALD5SAwj/cozMEwXF4Qu41NtNtdTHuCVcf2y1t1hxYuGtzm2Li+M7YkLkghmxOceyfMFRdD1S30M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXaO9ReT4aBS9BbbR1b5R/6MwZIZ+bhzXMcA2YSI/WD6BCNso
	Pz+xAOmE78v0omRrpZME6q3WUbW6R9DKHbWT14Ztr8AARM+XBKE1L+sQQfilmnvlad8=
X-Gm-Gg: AY/fxX6nUp1p9jM10UyKv4FvA3BcNdztq/kRhnPlBGhfJ8WOj8iG8UoPHGyDB1Kf7CI
	rNa0hyP2kZL9lwEUp3Wsvn8P3Y80b2s+WV7vU6Qf8AWu4lb+G9FuDWf73Nk0O6l3U/djVOStOjT
	qiOb+MoobEkRWgO0SL85yxfuUUxQ2BU3cUqlRwHR1WuS9YCaesTKxgrDqF8YJSgnM2zus/yvmea
	L3h3YaLsbwMgk+4kLcJwgAVyNhDfzp6N/nK08z7c+gyiCID2Ge/xEeyGtbygM+5d8EZNBixVlNn
	mteu1t3W6+TM1g/HneEXIVfoAq3DiSyfN8gCcpFjIfTrk90NyRUgO15giu9J3u/i8rZt1JhIQoz
	bGxT+NClFl0A41rS6+CPg2uoPPhHeK6WXh2wLPkpOLAl0JLFGwz6oSLm5a/kBEbITg3Ajsax8fB
	CUwVirD4tuEWSwx6AqWe98DbL7T3DYinXyeu7M5r9QamhfR+GK5wFEFmxkkhw4muOxrmJVm995l
	1p7IyPVW3BPm5yHDdH9ctq2CD2R59P+gWu+OGSSNnCauR9cgm990Jac13PwjVCAHTr481DcI2Tb
	qNQnnss=
X-Received: by 2002:a05:6000:2c0c:b0:430:fdc8:8bbf with SMTP id ffacd0b85a97d-43569bd0e34mr2813514f8f.59.1768565405191;
        Fri, 16 Jan 2026 04:10:05 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921da2sm4927533f8f.1.2026.01.16.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:10:04 -0800 (PST)
From: Daniel Thompson <daniel@riscstar.com>
Date: Fri, 16 Jan 2026 12:09:37 +0000
Subject: [PATCH] iommu: Fix NULL pointer deref when io_page_fault
 tracepoint fires
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAIAqamkC/x2MWwqAIBAArxL7nZD2ILpKhFittWAWmhFEd2/pZ
 2DmYx6IGAgjdNkDAS+KtHsWmWcwrcYvKGhmB1WoppCyEbRvW2LqwyyorUnu1D45py3dwrZyrLA
 d60qVwIsjIOd/3w/v+wHzBVHIbgAAAA==
X-Change-ID: 20260116-iommu-io_page_fault_null_fix-f81b4e8b5423
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 linux-arm-kernel@lists.infradead.org, Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=daniel@riscstar.com;
 h=from:subject:message-id; bh=wzqwRBKyLSM4GRh0kCYODc/MRx83ikN2FZc7umGbfq8=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBpaiqObiokix9ae2QyYoXTSoETuIWNZIj3AJUUG
 dcO25z3zdCJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCaWoqjgAKCRB84yVdOfeI
 oWobD/sGxlA1+2P2xosSrO13NYJuNZAvTUSac9q9A0JGt+RfbDnbjNkUz/OKwmpHoGl+ylFcOE4
 xHMYQEmtqKF1KkXzkOPGr0IEN/KdKhvka+YTz+Uz1MhWM5GX2ayo865KyFqCrYXoexOiNDG/FE3
 lSZcRReKaQ7mwbD5WfIiBtLJMIG7nPZv3TnBJUVnZvPOBGp8/4kERiYfaudH0y/EX8NuQEfXnJ6
 6QvFoGHo9UUK7SLHbfjjA1UwECfGVHvMG6J3fj14t9rbSaQJNn23qhj6MqnP9RPshash32ysBFB
 NizeW7gcbGu0kHH6XW8dzfoJIa78Ue4O2Rmt4SAvCEB+qZl71K6+lb8b5qWv/c+tW76HFSHZRQo
 sNmT/9n2Qo6VIvTQ5lbSNZYemcwknir239IP8uf4PTBf/7pK8HhAbUa6uca/paZvJstYMLzZS4f
 Pf0Q79d+7ymhZvM5xgo7xB/KI8nk/x9ynnfRED6nl/S/yOY92z8RpnH7Kj5AmdZamfX9jJsAaWE
 aEJ10qFthfAZ6gcBLeZ14fK/lMIWA9iUv/GViESqtmXmzNcLgajTildIRTwsV7KMLwtqC84W762
 IvCXiwv48f6E99w/KL8qF2IeUV9/moPd0y4Mh4DQyE8oR/eWC/VzoTQggoMKgSdiXXXBGsqMmID
 TURsYXBqfWJlzzQ==
X-Developer-Key: i=daniel@riscstar.com; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The arm-smmu driver is unable to allocate the blame for a page fault to
a specific device so it calls report_iommu_fault() with the dev argument
set to NULL. Normally this doesn't cause anything catastrophic but on a
system with the io_page_fault tracepoint enabled this results in a NULL
pointer deref (resulting in a fairly spectacular crash on the hardware
I'm currently working on).

Fix this by adding logic to the tracepoint to safely propagate NULL.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
 include/trace/events/iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 373007e567cb827458a729b8200bbcc1b7d76912..1315193f13b8812ad4e29e6b0c0c66ca806ce08d 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -131,8 +131,8 @@ DECLARE_EVENT_CLASS(iommu_error,
 	TP_ARGS(dev, iova, flags),
 
 	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(driver, dev_driver_string(dev))
+		__string(device, dev ? dev_name(dev) : NULL)
+		__string(driver, dev ? dev_driver_string(dev) : NULL)
 		__field(u64, iova)
 		__field(int, flags)
 	),

---
base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
change-id: 20260116-iommu-io_page_fault_null_fix-f81b4e8b5423

Best regards,
-- 
Daniel Thompson <daniel@riscstar.com>

