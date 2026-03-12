Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90006401483
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342708; cv=none; b=MDvtOz3H/v0+O6TlQxoUTClPC2C5oR3d9ubTQtSKhx/cCyElbXE7YifW8tgUrXSLXKb/9rvUsITCPXliVXasO8y+JL9BewgRXA5hyOuM1vseVSUnBJFEOp4/Z4ZbLoI0+YfPfxSXMPhj/HTIN0Vnm3c+lr9udW7w7QY0GqLZyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342708; c=relaxed/simple;
	bh=ucLeCOCDouCO7UufOBxTBTI1pPSlVnt7A7p1S/jHbcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saD3LdbrfB5ga3HpzRCMlbDsoEtr8hR60HicsuWhHsH4jNwAE5D/phrXd761xyaGjgvD4CLMssKy24KWLKEs2iaKUhp/dTxykwZOJgnIRxC030/pvNC3xN87BybXQeGRKQlGKu5g8nFVpywUdonAXQPOKuDXidQZ5D4XmaW/YN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuhpkNTN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuhpkNTN"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a1322af04fso1695344e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342705; x=1773947505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oYoshde2XtkYb9vO2NHUjUuyf39EF1O91LJtB3a3dI=;
        b=ZuhpkNTNAhq3VvUFf+cwx+BjBV0lR1DmfaDoxKsaPBMraQRkBs23JOwgCa9jUoxvBn
         kPpPiZ+xhwoKn4RLcj6bKzZQdPOUZYfFL39zxYYzCZCQOUWXnIuZf5uBWJMOhJu36OH3
         gtd6/2zzx6xT4ZqfJs1e/uGX10KuDfePTiLQ7WdM4OqirLHbSSgkOE2WCKv7wki2v1r0
         isGSEZhSURQ8oMF0S55bNy381E8t0Jb4//zQhfsXsVY+D2z41NCZOLlHPIcpRB9f2M1U
         Hpnm7Ho20zeopt/eYnWYJzkAEM00LxvCivYDgL129WW4iVDCuamltcqk/q3HeMcYIa/E
         22Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342705; x=1773947505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oYoshde2XtkYb9vO2NHUjUuyf39EF1O91LJtB3a3dI=;
        b=DZz6EeOdHWshPn2FJNKBq6xsilePLmT0nYs+K5vptxqRclSzYQ94X7iBvq/N3l4gnp
         0JH5wK8YETiDoNTx6YSd8Vvhx6i/wShzTV8FV4zlCSsrVpijO9oAcB2IQWadOlRz+YTz
         VVPKBDYNf8vJMi5znp7ypeEsHD51xjk2+jqCf5GFK3d1qQx+fw3KR0ZYaa2dmtAJ/y/R
         MGaocP9y8OvdXOft7Cxsa6Dw0c2sfRQ/cApWI9ij49HIcKVtINLA0W2td6x9RhtsBKci
         qL0KeUQug6e6V1r+YRHBuCZwbLtWYTu8nqrHkGfq86MK/tRHsU6/vVcm+7u1acd8rZtr
         HTYw==
X-Forwarded-Encrypted: i=1; AJvYcCWxiQfN8cCYG8hZGITjpjDa0hCQVLBtu5TlBDccCxNHsfyr2OjBUkQbYIN72DrEbIfpGhbTnmCtNw2api03T/V0RQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxktAdbjgDDPD5G+4Jw51NOIMhUVlQ5qe8RGn6GafXASjLawIbt
	1Yy375NNiO7btcNPmE//8m7+6zqFj+tgIeKhhfGWwxbvpo9beNBxbPMQ
X-Gm-Gg: ATEYQzxUd94LdaHLR14wPWFJ6V0p/Q70mrGmLRDqaLg7TMFtdymYDk5KZEsNPdn9LX3
	wr3wEIXZOOvrk27pNKEYYINdd1QUs2A6gyYvipS6ogMAO39VaZ4JBJkvle9CBR84J//Dkq0CrKy
	qRV4H5CspE+LgG5uWtDDxdKeE2HQgAWTXLnDVmKVyr05LaDopvXkcAg+XhLuUUnOUK7yCBE/paS
	u2/ZCoKchFiLLvmmgiSMTE243ejXhgDVvLLbiSOyKWoaMbHvrc14KbEyvUNEVtrycuFZqkx6EY+
	36M0ZAZmme6o0b9ByBvL8navXxzQgBPXnTi31kEMK51EdL6zHHqa/Nu3T8FhtIgbSHkbtc9EN5k
	C51nYUM6YiIXg5zOWM8lhXf7QBr7NkfkKlHOeLTR/WCGkwjMpxIOluXv/eSER0DbUMXqv21+T5u
	3rMdkDKhW2/DVZmSQiq6Zni375CLT/N90LUsGV3vLxEGwk9onaDl8S6gQzZymNg345HlwUbfs=
X-Received: by 2002:a05:6512:61d5:10b0:5a1:23fe:1b71 with SMTP id 2adb3069b0e04-5a1626f88aemr179518e87.3.1773342704589;
        Thu, 12 Mar 2026 12:11:44 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156375198sm1112249e87.88.2026.03.12.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:11:44 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] lib/bootconfig: fix off-by-one in xbc_verify_tree() unclosed brace error
Date: Thu, 12 Mar 2026 19:11:41 +0000
Message-Id: <20260312191143.28719-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312191143.28719-1-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

__xbc_open_brace() pushes entries with post-increment
(open_brace[brace_index++]), so brace_index always points one past
the last valid entry.  xbc_verify_tree() reads open_brace[brace_index]
to report which brace is unclosed, but this is one past the last
pushed entry and contains stale/zero data, causing the error message
to reference the wrong node.

Use open_brace[brace_index - 1] to correctly identify the unclosed
brace.  brace_index is known to be > 0 here since we are inside the
if (brace_index) guard.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2bcd5c2aa87e..a1e6a2e14b01 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -802,7 +802,7 @@ static int __init xbc_verify_tree(void)
 
 	/* Brace closing */
 	if (brace_index) {
-		n = &xbc_nodes[open_brace[brace_index]];
+		n = &xbc_nodes[open_brace[brace_index - 1]];
 		return xbc_parse_error("Brace is not closed",
 					xbc_node_get_data(n));
 	}
-- 
2.34.1

