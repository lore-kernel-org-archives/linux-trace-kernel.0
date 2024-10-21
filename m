Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E31CCB29;
	Mon, 21 Oct 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526105; cv=none; b=JX2d+FRAVTAr4GtVIZAUS0ZFww1YATmNKeJhBBK4E9q4JJSfA0aGYXg4trwpKUtgL/Sv8W+nvGpGCHjcWwUee/JE3kRPvrQ8f5+SVQhvRRn+bSuRQX4kqr5mdRhVL6MCKGzI+Ju4vQHsfdQri/x4XMExTYdDrg36ixC0F71nR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526105; c=relaxed/simple;
	bh=xAumv43BNFsGKsMqasYPmqwir94NH0Fv2u1Mzznbwxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmnoXyuKiNAmU/xbtmHsGq6hiXRViicBhZJY/UhBZGzUNSuqeSh/+4UsI+I9/eRDOjiSnvY9rhAc4pECPLoHZijxoHJsqoDapZAEHqTCTHStaohDOZxEc1pjADh/sI7w4m2lkrFUMPf1ULteWVWKAPZJg/86c8v4K3DbS4cR5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vpphh4XG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpphh4XG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c6f492d2dso53683825ad.0;
        Mon, 21 Oct 2024 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729526103; x=1730130903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh1aJBxWv0VwDDcKCoEkZD4rXl4897TVpmKVT9zgLRQ=;
        b=Vpphh4XGZTJ1MPVamWEYBHbHQMJkHEjRyT8IG2+YpWHiC+IrsdYpTI9jVCZnBnkkAs
         pz0MTv0i1D0m6UHI6JSqiMWh8XGHeTAdCjcMNxHswFUtGHA86KdYFLdOLcp9F10SqWWk
         lCyHnr/bPd/QmvxB3yg01G14j2zvoxjFXgZ3umJddv08fsY35W0Sp/8qYBVe5dor6KgF
         OMcpSPKrWaD6+qyDJZxNVFtVzLcjN2Z3y1jTDhV29ymlp2gIpojLZa+XIHmSa+PNBuhj
         SPjW3Bs3ZXoc+/io3uUTx5Tt1sLLcb5eJEHJv47EKlv5RYKzQHcSzA41I3dFkA6rOqdt
         i79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526103; x=1730130903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh1aJBxWv0VwDDcKCoEkZD4rXl4897TVpmKVT9zgLRQ=;
        b=DnjWmpwE5x+tp62XaKVrjdO/WzU6YENMu9l+3DcHURVa4yqv7IBf3+UXLjjymVnUZO
         4Vl52PYRaGipkAtaHuEk1fNUPs65JO5YXY02TcCP2UvSkhhVvvyGtCGCAmK+6rDtmzt2
         +L9VwS4sLcq1tQJ8opuuhWPmoa4iz/laJPhiL4AQw24JJDKMztwFTuXBk/VioydpHm/E
         7lUv0A33Z6yhXwZk7w94AZKUanoPnhOKgnZKlPFq9HvwwCXUCoz85W/4XX5vLqa1Q4YW
         oRoIRy4JIBucCwZS7knzoO2WT0OGMp52qx31Jnsu36DX3KBCk++CzEbepSb6xRFLFpbJ
         Kvvg==
X-Forwarded-Encrypted: i=1; AJvYcCW/xqB6/ydkWDtcOOUG6lcytQp0Ywtur9iX0azYevx52kCmzpPhmTATM6E3rxT7ikoi5WEqeisjljN7bWdxf7LVDho2@vger.kernel.org, AJvYcCWMbn5uUTU5qWUgtO6oj4EFX1/BppPwp/aGWH7xPWJcuwX3JjbcuaP54EUs8cjiFJ4R+dkTdAZvLd6fHs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyDNI7VmmPB8GePeDllxxFxP6X2VFeA07XbkoxgTYCsfMCiTj
	LP5Hsbt56Csv11+touNa8hDiIE51rs99RvKpxGDpWdUHPtdlHBIipfZpCEzuv1s=
X-Google-Smtp-Source: AGHT+IHJDq6KQ/Z+VA/Ppwmy86CaogWcH97pdQYjvExuTNdZBgq2iRpRli2bAOSYM4yVUpe2a2DI9Q==
X-Received: by 2002:a17:903:40ce:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20e5a8d1560mr147067215ad.33.1729526102969;
        Mon, 21 Oct 2024 08:55:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:23:59fe:c0e:3382:bbfd:44ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0ad34sm27688725ad.68.2024.10.21.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:55:02 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org
Cc: av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] fgraph: Remove unused value
Date: Mon, 21 Oct 2024 21:24:37 +0530
Message-Id: <20241021155437.5633-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `ret` is assigned a value which is unused.
Fix this by removing the redundant `ret = 0;` assignment.

This issue was reported by Coverity Scan.
Report:
CID 1600916: (#1 of 1): Unused value (UNUSED_VALUE)
assigned_value: Assigning value 0 to ret here,
but that stored value is overwritten before it can be used.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 kernel/trace/fgraph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 06d254edaed7..306f1cb7bba3 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1302,7 +1302,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 			return ret;
 		}
 		fgraph_initialized = true;
-		ret = 0;
 	}
 
 	if (!fgraph_array[0]) {
-- 
2.25.1

