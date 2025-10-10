Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6C26A1CF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067538; cv=none; b=AH5Ja+eGC3nJE1zsaJnEPMHg9OqzxWfzRYe7pX574UURMVxBaDG5BOZQpUJTVSEButVoXsZPvv56VLIUnjNg8nVCsTMm66OW8ao+3FiXmydemBzUAv3NqTklvzxkdfFsshoWXINqvXBhRpAmyCfDIbWMTYwOq1GYTkoeg1oFQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067538; c=relaxed/simple;
	bh=5qqJUczig2l29D4JIBSIymNxAk9sEevSR5zoATmnADc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9JlTHQYetIdHVsO7X7+NDwCM3FJANqBeJ5/znKaezoUulrbTzTNUzutbCvhY3vsAP0mTwyWSBy4O/BbQqRKwy4fwEFOryw9zoYlE2A9ms+gZNDYzPMeNALm3kPyYdEtPrh8YutOEpaxA/pTLBo4IqIteF9WimGjbj/DA/eX9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib2SFpet; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib2SFpet"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7833765433cso2198865b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760067536; x=1760672336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caMS6Y18E0X9hrIxsvxznzwmexissryzyTlpkHtobr4=;
        b=Ib2SFpetce/YXj8vq5KGkxi7hC4F6vBHXNe78UdkjPBGMhvtM674Qo9s8r4OK8qD5s
         HkTvb5IVzIxgbYEbUKSZ0xS5YvyXvguWu9+OBDvtL2jDgggs9JoIsqyuA3r4xHWiPkpI
         cA+J8EHmBNVyENnkyovfw4HF52IWWb7EqZOIU2XR4QWS060k1hrGpHZllE3TbJe2WIvs
         Od/fvwNqtTOysH/soYwzNiaCySv1dgPK10TaCXpAc10t4vi4+ayMqRyDKJ/I8YH6jykt
         cOs/ZffUGQRMYXGdwHHSVHW6bjPhQqMKSIwcpfXUi+Ay/B9rXzItZWz7zeH3T7wkqSkO
         gptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760067536; x=1760672336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caMS6Y18E0X9hrIxsvxznzwmexissryzyTlpkHtobr4=;
        b=ZIvCJN3DEyBUzbYMBVqg1KELvzw4c1DmEHdKB1CSna1ts8pSVs20Iw77buDnk+wXj/
         Tf8sttF6TXexA9yiy3Wly9K9NCBI9qANNbfwc7T1RvZ/Alb/SU+sSWXlm5z+BgTTplmz
         1hUEEfPFFFiQorwhV3I7uZYyhtsyg+xVpz7Wh+sYsEhUzTPQpzKeZolyctSEPuLkYEJq
         H3A23T+qbbW24DSk1MJCFM2OJsKlFADuDIBzgmhJLGlnHN9l7Fm40RDGwPd/uBT1wecx
         URfByv2Ey+wDFpdsQrG0jnb5BY1EOgzpP/9kNPnakZEHAlDwj95G1CiwBn0TLG+RJAIj
         mh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtHPTYBoaU+w7q+gcemTn+DgBPb5jPFZKY3O3+PeN/gtN8Hd86hUpchjd0O+dxUDd/xcjVjfqlvpK9Ql0C+6+7Vj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aIeC1ATXEofqp7HzhvNor3Elnt3HXYIT3PzArnIsHB3DC2y5
	LZOHhetWk26T2L1T3iJTh0/7M4owcAGzQO9EU9j+J7P7sIVk8eEI2e/p1BZap9yygCM=
X-Gm-Gg: ASbGncteT/WtPWBgl+68mY4gzf+gs7yDWidpxESaI0+TzROwR9r6F3J9dj0jqsZfNI6
	Van44KgyF1ivMYyZjk9d0V2znoOA6pnrQhS7aWOJQIe98iGsgH/nihOkLWVBTWkyBmX7Q+al60/
	Qxl2fwR7H7cdPVdao13NE6nmTsYcGpfkjiOxaNSaaC+PyrwkvJGMdJ+hybwbWznMYQcGAkMtf83
	fTgyCbxRQbU+8LFHSpkI17YwTIewoiumRou4NVLiYEYj3ZUIk020M8FDcvXwzr4Yj4A5bQtadTS
	4Jz+ZsARwlbvpKUC3zdXAj/4QICN8bgXOfdc23kT3OWBajXpRpu6UU+t9mru+4kMbauyFx5+jIY
	1pcHDQc5dcHnZRe9T5AknM5zGpOH7MuiMEF9qAmuAo/V5Ce3O
X-Google-Smtp-Source: AGHT+IF24F2zhzRlHXkJG3vE8zteAajopgAiIJ6/HmBuwskVoW5wMnZM1SXUIGAoZsViQJiW5B9opw==
X-Received: by 2002:a05:6a21:329e:b0:262:5e70:3393 with SMTP id adf61e73a8af0-32da8138eb2mr13769287637.13.1760067535732;
        Thu, 09 Oct 2025 20:38:55 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm1260148b3a.74.2025.10.09.20.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 20:38:55 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: fprobe: optimization for entry only case
Date: Fri, 10 Oct 2025 11:38:45 +0800
Message-ID: <20251010033847.31008-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 104 +++++++++++++++++++++++++++++++++++-----
 lib/tests/test_fprobe.c |  99 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 12 deletions(-)

-- 
2.51.0

