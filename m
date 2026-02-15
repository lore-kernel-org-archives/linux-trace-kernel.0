Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89D1EA65
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Feb 2026 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771181554; cv=none; b=kYX4BmIPHebms/9PRLAZF9Pt0Eq1nnBdJzhx93hOBcuuRUJ60bsLzlTB7TkE052SlMR/vW5lDCNFZpYHV1y/sIk0CGGlYN3/Dku4DowYsIWV8LArRDTXPZpY+0LkxvucCgG1wgQXt97ByxYgfZ0TFt29oGLMx8t7V8L4plTLiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771181554; c=relaxed/simple;
	bh=NoNskTe3uZW4RgcxjeNpjg/9c7kZ6FWlUlEfAyhmGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+IAilSJikD1d0j/WR2w7vdKop/lwi4BLfVWzOo4kd0ROK1toOpF3sENI6S0EBFDQBFmqhsONSfRGSDTwqsQxDzwCgar1+5cSjoX8ZD3KZbew1XcpEwzRBuVl6xSDwgP6dnG+BW59KfOifEBnow5RjrYwZssdLIL4Lofm4h++jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMGThPyE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMGThPyE"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ca01dc7d40so271344085a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Feb 2026 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771181552; x=1771786352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsfzKYmpLSxAAOTiptt7aFVx1ktWi2rGfqaYFT6oD3Q=;
        b=SMGThPyEWfxaa8U9PKlPyLmaQ/Wmp9rzH6U6QxYwUZPiMq1S0l/AEahnWcbrBh6hRc
         G2seRBToawPiC7DGAJMRj9WMxLd3jZbYULmNmKGX5Kula36ZSDPGF+uLvgrZgpe+zkBa
         lfZfzatsjb78aIHg+7MhqeupKEdbtAfl3cm+SK7TFlEOE9jCHE9YsIkJXqMQMN2nZ7a9
         /dnny39dXsoxNdd1ojVI50jwCv3zGTs+Q0Y3oZSlv1WDaxyTSIClm+J/8j0xHNjM4YYu
         ASkbbQRuku0O7T2g2ncfwxvfY32pAfgeqIcPkDhrAqeXXBDLxF2BoU5c//IbI+fn11N9
         pb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771181552; x=1771786352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsfzKYmpLSxAAOTiptt7aFVx1ktWi2rGfqaYFT6oD3Q=;
        b=G9lgyotXjRThbEuo1q3RxMs0l5NH87BgFHZw35LZbWFuYDtn8JwTB8rJTJ20K0ROvc
         cYaioSFKLrAt5pOnUVFpNItJiLaebw4uBmP73bWsbuXlAn9lZYt+K6kOEIZp3lTieANy
         woON5v3x9N3z9Sn7rzhRJ1S7x/2umazAQJcNcchYPsX/q0Dw4L6ejdYH9TTqgRiQYefE
         eJpd+NFD8j/EfiZYhbO84LTa/S4/qWABIcx0eWt2UG4FWPVrwMKeeUDotmcr5QRQXeif
         VGZ3eJnM2W5Bc52Z+iElnF3ewZNvtRljsYX8wjwlXyMkVdIidmVKSaPfOTxCOqUDhco8
         +4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUTq0kMlxXWuNzndW9eysodIyRa2d2IR0r40X4kN2y1iFOSI54TESl/hRt5uKuK+Zp+M2YjF69Y4WT61dbyFJiKU4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrBB5RIA4/2pmQavt5iUWfKgOewVOtoQhkL+2jSYQMfjhJm5T
	BbwtmWlpXgxICV7fsSLSO+TuadjHNJQnuw2utcgrNNbw4PB8KGBp00Sf
X-Gm-Gg: AZuq6aLPBv98RxAAP7d3M7EOeB/n0e1c1O32bbaV6P3rEVFzBQMTL1Itesm5lYmAcNz
	nHvl3FIBlmi70fgV2wLy5vrtMCrmvDc1lXWPN+Jp7CdeMcPjuyNLcLSD5rCXAfSatHVybXAWHwr
	meTtiaDCDe9HjyxbyRBzoMbAWFUylKMlqDbyJ+HjZv2SNWZsumYA5CYFcP+8BDKOyeRm17UzJIm
	bXAjlmwJCN/R8NwKcnIWk70L2oruymeB5T3UEiXTNkQgfIkJGB8YBk5nIjnZMBBnmzeqcSAX425
	yi1X1lyGOIudpHbu9fvyZZHjXf6FgdqG7GU4ocsEm1MfrXgOb76UR9vTtHGJ1aAYm8NcjCj9zJV
	ABwONJ8/Kt+MxIlZTF+NEetYsdhEdfpY3JvMSdVv9zfO6etFbWQvlo6aM2cd427bXl254t52wpO
	I4ZAdAMmPwYcSdbso7YVUkWqDR3A==
X-Received: by 2002:a05:620a:290c:b0:8b2:ea5a:4149 with SMTP id af79cd13be357-8cb4248158dmr1092505385a.65.1771181552160;
        Sun, 15 Feb 2026 10:52:32 -0800 (PST)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8ca6esm113306766d6.33.2026.02.15.10.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 10:52:30 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] pstore: fix ftrace dump, when ECC is enabled
Date: Sun, 15 Feb 2026 21:51:55 +0300
Message-ID: <20260215185156.317394-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

total_size is sum of record->size and record->ecc_notice_size (ECC: No
errors detected). When ECC is not used, then there is no problem.
When ECC is enabled, then ftrace dump is decoded incorrectly after
restart.

First this affects starting offset calculation, that breaks
reading of all ftrace records.

  CPU:66 ts:51646260179894273 3818ffff80008002  fe00ffff800080f0  0x3818ffff80008002 <- 0xfe00ffff800080f0
  CPU:66 ts:56589664458375169 3818ffff80008002  ff02ffff800080f0  0x3818ffff80008002 <- 0xff02ffff800080f0
  CPU:67 ts:13194139533313 afe4ffff80008002  1ffff800080f0  0xafe4ffff80008002 <- 0x1ffff800080f0
  CPU:67 ts:13194139533313 b7d0ffff80008001  100ffff80008002  0xb7d0ffff80008001 <- 0x100ffff80008002
  CPU:67 ts:51646260179894273 8de0ffff80008001  202ffff80008002  0x8de0ffff80008001 <- 0x202ffff80008002

Second ECC notice message is printed like ftrace record and as a
result couple of last records are completely wrong.

For example, when the starting offset is fixed:

 CPU:0 ts:113 ffffffc00879bd04  ffffffc0080dc08c  cpuidle_enter <- do_idle+0x20c/0x290
 CPU:0 ts:114 ffffffc00879bd04  ffffffc0080dc08c  cpuidle_enter <- do_idle+0x20c/0x290
 CPU:100 ts:28259048229270629 6f4e203a4343450a  2073726f72726520  0x6f4e203a4343450a <- 0x2073726f72726520

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 fs/pstore/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index b4e55c90f8dc2..9c2d5e5f31d65 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -74,9 +74,9 @@ static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 	if (!data)
 		return NULL;
 
-	data->off = ps->total_size % REC_SIZE;
+	data->off = ps->record->size % REC_SIZE;
 	data->off += *pos * REC_SIZE;
-	if (data->off + REC_SIZE > ps->total_size)
+	if (data->off + REC_SIZE > ps->record->size)
 		return NULL;
 
 	return_ptr(data);
@@ -94,7 +94,7 @@ static void *pstore_ftrace_seq_next(struct seq_file *s, void *v, loff_t *pos)
 
 	(*pos)++;
 	data->off += REC_SIZE;
-	if (data->off + REC_SIZE > ps->total_size)
+	if (data->off + REC_SIZE > ps->record->size)
 		return NULL;
 
 	return data;
-- 
2.51.0

