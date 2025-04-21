Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA235265607;
	Mon, 21 Apr 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243388; cv=none; b=Fb0qgegglrWdQnnI4X0+Q+RdmcYP6ZEklggXpPpFtV5V5HE4k6JJx0KGRbWjfRUfFYi/vYDjNgQHXn8vFIn1oP9OFevugFDiuLbOxmHJ2MvuDwwk0m5CePTBH3rgrgKwX6nwTPZrYY7qZt1WT1ts4dznMmoK8qRorvYfgkt0RU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243388; c=relaxed/simple;
	bh=wjc8F+3pdcHxUxhxVgoyshc0LQdeJgnbkUnMzjDe+kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0REsRE9bAjJPzY+tSk+CfAf6A/pgAMAIkWoOdARweEN5n6MamofHGKjLGcrd/xn32mEuLf5YuuxuH2BqZNcCZjMZDDqSEUUWNMpYfLEH1SKEEGvXD5ZfTOM3oomjRbrwzCdPQn60LhSAFMedexxywP4JV6yrdWONb67TNKh+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HamHH60D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HamHH60D"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fd89d036so48155305ad.1;
        Mon, 21 Apr 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243386; x=1745848186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgfjM2Tk8XqGcx4yK8b4EOF7qCsq/4Wj/LeFu0QB/AA=;
        b=HamHH60DACPqM2Z+iuFIIX7Z4DyGkDSbW9/kmvSpYnLEdxuKleOEJNaRGaDmVbhSpm
         peahWj3Y9AjmKjRQjD0q7aeblTfW4shou5ifBUQ7lteyxHppT/1XD4GY+HsXV5aBeHFM
         AMWvxvLDuDUS/2oJLcw9PcjjT6B0F1fAHlRIjC4509VC4lvTp31E9Tlg8KM1BWH9Um/u
         FkMk4jM27fZwuYGONM58sNTXyF9jhkTqAFvEAY0pI8LeDJeAod/5nE/1lDPgE+23c32s
         pDh7YDdfmIyMhcFE/KH5Q5IzsJpr5RiLYEMS/HhVTMWJBizE2HcpnJcSTcoy9yCkx5kE
         LYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243386; x=1745848186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgfjM2Tk8XqGcx4yK8b4EOF7qCsq/4Wj/LeFu0QB/AA=;
        b=gdohpEPdLL9pQVBotwXQ1lTpKNSyEpklH21z/PKViLdT/zoHx37bLPkAq976pwLS5i
         AF6b+tWDQZaHZIstwoIE7pJ3DCjAyeH3Jc/ikSYIDvaMn+43AzYH6up03710WGcWltjv
         J0U6K7MjVPKdFqQSHYSNRBuDrslR7yWzZ/HRnJtPQyweeBhAB36B669VHf8wP/1H06Xt
         +8QNZ3M32aZSx+tLpt5zCK5lLtyCNsrsXL8sSfGqCJTyZjVw3rFiyA/d2oImaKKQelUO
         9ptn/powR3rxmQ+ciP0RhWINqXN/VnYR5/Trh2NkqA//Vdjhf9a9epNmNVr3Ej7qj8wK
         eVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDzmvYKNmBBHit4Ggw3qb9wYpo/CGaAeABr5VVFKuAqywExx9ooDYArCMwyy1IR20b/I3i80x27kr3sWU0is44arU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLLYqmdCFe+1fJITCOf4mbmVn/FVOjtSUIPSWaDIzchjcowNF
	csdzHCvxZHNC/tCuF/zLHp6iQtisLrAYveVhTTM1Vx7Af09I/z2K
X-Gm-Gg: ASbGncteMzQ42toWD4tcwP3nqY5rjkOhYdTfbRij9Ffy4tjTbrmjb83LVOYrNO/g4z7
	mypPKoKa3lMsuReDOmG3tCbAkriO3+nW7J3ll21NFa+NVm8boNiKVomKqIgd8AxJmBwuR/9hZy2
	8zF9Lo4yOqwQwidc16QbPlwOgXFCc9Ai5AD6C+kzs0PkbVFAk37QtgMn1qlIdKi8ltm3+3QZZIt
	PQPkVVax8VwwqI2DvLEWXarPOrcj5IZRw/JZgNp9du4ZFe+EeEVAkRBVJG8pOBvDtuxZiZ4CCln
	XJuXxO3xUfo9Aacs2Q6rsIrS3oNknoUtHCO1L/P2J9eiI4y4mYqABcZ5YSE9OfctB688XQ==
X-Google-Smtp-Source: AGHT+IGnuxsdn5+TU30KTH6bFF/bEUzFQd2IdJ0Q9WVtMP7AtRTHi2TEW0+CaCmUdavSq4i6Kr2JXw==
X-Received: by 2002:a17:903:1b25:b0:223:f408:c3f8 with SMTP id d9443c01a7336-22c5357f266mr171450775ad.14.1745243385890;
        Mon, 21 Apr 2025 06:49:45 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdae5dsm65563115ad.35.2025.04.21.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:49:45 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] tracing: fix oob write in trace_seq_to_buffer()
Date: Mon, 21 Apr 2025 22:49:36 +0900
Message-ID: <20250421134936.89104-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported this bug:
==================================================================
BUG: KASAN: slab-out-of-bounds in trace_seq_to_buffer kernel/trace/trace.c:1830 [inline]
BUG: KASAN: slab-out-of-bounds in tracing_splice_read_pipe+0x6be/0xdd0 kernel/trace/trace.c:6822
Write of size 4507 at addr ffff888032b6b000 by task syz.2.320/7260

CPU: 1 UID: 0 PID: 7260 Comm: syz.2.320 Not tainted 6.15.0-rc1-syzkaller-00301-g3bde70a2c827 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
 trace_seq_to_buffer kernel/trace/trace.c:1830 [inline]
 tracing_splice_read_pipe+0x6be/0xdd0 kernel/trace/trace.c:6822
 ....
==================================================================

It has been reported that trace_seq_to_buffer() attempts to copy more than
PAGE_SIZE data into buf, so we need to add code to check the size of the 
cnt value to prevent this.

Reported-by: syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com
Fixes: 3c56819b14b0 ("tracing: splice support for tracing_pipe")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..8ba6ea38411d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1827,6 +1827,8 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 	len = trace_seq_used(s) - s->readpos;
 	if (cnt > len)
 		cnt = len;
+	if (cnt > PAGE_SIZE)
+		return -EINVAL;
 	memcpy(buf, s->buffer + s->readpos, cnt);
 
 	s->readpos += cnt;
--
