Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213F10F2
	for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Jun 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782035537; cv=none; b=dF8eHo9vZzbRLgSiSpZWpr+sUEf6CpgsJD7LOUVyDDYghGbLwtZzVb8r3oVkM9UgN1Y1a/ax0XL47KENGxmseouQI/Jh12lraQ+JlrYx2dLLmu9lDmR+YUipGMsUFRSR79wlr2SNharj4KYi8Q4zkpRZEVqsJv1KAjHnfOUH2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782035537; c=relaxed/simple;
	bh=GNyQIhqg/9ZmmKBuHCyKSzXdMn1U5U4sK5DahMCLuPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dvs4xXqYWCjeIutCcU6gIDVkWhIvVpzMBp/sW3MGM7GStnEoPEqmSw1SaaArXfzHAxHZ1YqnEsh40H1HRmIIjmZmFQBBEVQfkWvE2GvdrX6EYRWH39DtkqGGZx7syLnXAFf6QpXBCgxA3UGtmXd3XYoyyYNqnaBsb8bgZcI0qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahlym38U; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahlym38U"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30c00d41e91so289434eec.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Jun 2026 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782035534; x=1782640334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzHG3L2G05OyIyXQ6A2w5LWsmDz+8PwNLSKgUubaVXw=;
        b=ahlym38USxXMbLjQGksHBisE3TZatVogA8mV0IG4m2A6fhSW6xrmTis+uD7f27daRK
         CHUUwpRJURhEI/5sWSST0y5SNdkC2vYbJ+VT/BBkeU1exnaEm8r//DBJUEOASkz128P3
         59v+JHrttjiINBf+EHLz/lzAvFOSsXyeYt1a87Q+FXSy3rKFboYs6shi6frD2m+Nm7Hg
         BO4pVhvU2k8a4EP+JcxqHvMcBGthCSlimj3eCE6IVVvZnjgl+fhNTocFzFf7bgLCxVHa
         hyFbCargbxKhu3/ruRpMMMjplspDnsi9Vjvin9SjHQQq+EejgsnwSqzb+vEWnbH5Kfmq
         YlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782035534; x=1782640334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzHG3L2G05OyIyXQ6A2w5LWsmDz+8PwNLSKgUubaVXw=;
        b=e6I51M2PQySUqY0VNJmNkiRxTCRgeKbVcuWwa1xc5c9PFny9cT0kUKkFIAGqT+gXW2
         pPOSlPjmUl71nhlHxBHnHrslVBxeiupJQmkEqPX5D8mTmjJjzmyxrrOmCoNX0vIlgWM+
         G0BzKkYoewnHci+C5N95t6AFI4noLpA/uoqwHBTCfB0ZV3rejtj5r/4ED7gjfqDFXXq/
         RTuMmNXh89XQbn9ERDZL1M1H2mOwb5B8ry5GeTz4YkGhNr1DMvGnRvrMFA2tzMeFzz0h
         Ew9Vb4U6vqwOHCnTWslvS96hEMFlLcDAnyW2J14C+4dqO+uozYnFVk71mV0h43JyeE0S
         ZB2g==
X-Forwarded-Encrypted: i=1; AHgh+RqU8YSrGxXgfLNH10I/HLq14Eqsu6XFnoKn8P7vuVLom2n3+U75c4T5kQ99YrGAjUk6tBNIf1ScKjy4W+u7EtqQzKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjaTXDqQBq+lCpG6dmdDVWoxlgCJKM28g78oAPOgWm2QbrYvCc
	PrNJWhgBTbHYI1Bdj9xa6ZEz1hVtzsHR7ohmU2RuFg4jH8MMHditycoKqzfcY+g4
X-Gm-Gg: AfdE7ckAEvtgNOXJ8Cr+7HNwsX6NsxnMug+a2Z9RXrjPgMlwPfyQ7FCpedYWDCz9buV
	dKL5ygKSABN1TXL7GVXl6ldOpYpu8VsLYL3jQekYVjekpRXjyD6ERGgu+UbCdM1bOroLo8l89QA
	5qCiB8WvqEYsFr+0JXtyCx+q/47L14jSZLCaM79BljFvf0oLclzZ9ueuMje77MBn65u0FP+7Kba
	YJ9VBOOn5KHQpjeNrz9pminaHT9KDkZT8ZwsQlFenVYDIJvhE1ctYwSZeTu3hpOJNb29bUwupmA
	krRF9Lp4Cm8Z9JeHdsGpVBHRbGIckttCWlOJ3JIsVCQG0B14Hp/7u8SG8aoW3P5MkLZaz2S3tN9
	ln8DXs5TmMjIi3Lz8teYfe6fRQpovlshFKbr2kUVWQsSOi9+k5OHVSsuaSQihj3hsth4FPF6L2c
	8nm47hBn5nyXxyMR7lomjvfxs=
X-Received: by 2002:a05:7300:80ca:b0:30b:e157:2641 with SMTP id 5a478bee46e88-30c0700658cmr3297131eec.6.1782035534401;
        Sun, 21 Jun 2026 02:52:14 -0700 (PDT)
Received: from pop-os.. ([114.10.72.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdeb65fsm6415786eec.22.2026.06.21.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 02:52:14 -0700 (PDT)
From: Yudistira Putra <pyudistira519@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yudistira Putra <pyudistira519@gmail.com>
Subject: [PATCH] samples: ftrace: fix typos in benchmark comment
Date: Sun, 21 Jun 2026 05:51:53 -0400
Message-ID: <20260621095153.93762-1-pyudistira519@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two typos in the ftrace operations sample benchmark comment.

Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
---
 samples/ftrace/ftrace-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 68d6685c80bd..152ffc1a30b6 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -232,8 +232,8 @@ static int __init ftrace_ops_sample_init(void)
 	ops_destroy(ops_irrelevant, nr_ops_irrelevant);
 
 	/*
-	 * The benchmark completed sucessfully, but there's no reason to keep
-	 * the module around. Return an error do the user doesn't have to
+	 * The benchmark completed successfully, but there's no reason to keep
+	 * the module around. Return an error so the user doesn't have to
 	 * manually unload the module.
 	 */
 	return -EINVAL;
-- 
2.43.0

