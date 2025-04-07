Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070E2192E2;
	Mon,  7 Apr 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049279; cv=none; b=G7kRNXrMyEKrXH4hMRlkvfjfu0JEwPcopsaFbvB0/8QQ/iCBnuSWIWwy7Mv+9zUELHuKdZdu971ZpJ8cKx0XAiB3GbMV00dLuVig9E7DGKy4yh9Hx3w/SUwPEwA4sjcWy0HR6h5viVb6Sfe2w75kYeZDp8V7AFwmCP+WosZaTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049279; c=relaxed/simple;
	bh=/df2Ey3ne83fw7bnn9fR1uwqWEyMkT/oNl6KFsmfLFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HiQFv/kIngS4R1DeHMyIaQiioNQDws9+46b9ZZtdGvGBKSdvZg1A7yUfjv8PnSYTx1IsKUN15rUv39q28LokrJGytRnptF1+86rW1+3nF+sgMM2CqJ0H5w/wLkdp7xDV3pjVcet+TLY+aNYRGqItk5vTASA+SKgepn4Ba84gM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN/vZoH5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN/vZoH5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so43508635ad.3;
        Mon, 07 Apr 2025 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049276; x=1744654076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JGLx9cA1TljZmfuEUh/FVufeozZmgO73O0M8+k3RKY=;
        b=PN/vZoH5SEI9MLXCbtvurGAkPaMmXHc02egz+skg/Ig8i4kUHeHn+u64DDLLQ1JrFg
         bLm+Bb/sNl2NgaDQXnDchsYH0J/FWt2YlcfT+h50zFgBWSBwREBNQQM3uA1xOW+V3Ov3
         3LPhc68Ol2mXB7C8couXL093bZwOPus/zG5KriyxfBz2iY+5SHw2dje4AweIDw4HDdFk
         xsW6Kc/mxi6kx8sQJgMn182k/s8BkTkHX2dFzTnu8D8By6Y08iBhZkZ6wI56C3biaEqa
         RBXUbj5TCZLNT04MH0+gu9CkEC/pxcLD7pIUSaFfmfpKj4b2f15mL9ZfJFr+YzL/kB4V
         IODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049276; x=1744654076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JGLx9cA1TljZmfuEUh/FVufeozZmgO73O0M8+k3RKY=;
        b=IAYeAQt9/Brdtu9G8cSxC4T2ZwCSRhDTFF5Mb9RIil2OFVx9+QNAI8rapGBKCriIqy
         eQggdvs3J22byfChha3DJUiqM8tlXG/CiEtURWPKznXz3eA7ZGI6pCM3+9kDM4Gmitl1
         LImn9y11U9BxueXof53GYHZIN/4L5e8SO/KQ08WvRXVOpJi1OeXPS3FGlBK34GftL1/y
         Mq+nenVkAhufEXceuzR/w7a6LkMOkgyLy89KWyCBSk1iOdiRBc2gNLPfnipzxse1xBcQ
         tPBWjFA0D8uXpPjgIYNK7Owy0hPrfgcbfReYXJgbIDFzlq7U8KN6cA1Nn+ynna+eY+O9
         HNAg==
X-Forwarded-Encrypted: i=1; AJvYcCUoWDgXjoaZ/LeiI8k+jW34NsT7rJ33ZEfg8xy+eJwiwg811TTmzaFyzSdL/SGlR44ZqBgcL0hc2imT4ggkg38Rdvzt@vger.kernel.org, AJvYcCXtBszMBi+zcgbmUSKciRwAJbeOh90DW3Bm9BV8GbVHRCWdhW1e1xWKI7VAF68TLQEwMr3/mLodTTqNa+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70MkIxRg60modu7dMdT1iZLrFj73teuynK1+YQ5+Xws1Jt8Jo
	B6zk5ogNkNqHTLWflXj0K/dhLnegvl0+Mb3xNec5UjQLKr9BOk4S
X-Gm-Gg: ASbGncsNmjoz4D1tOmiw7CWKgZ0yD1XxmsSGbgpkLFCD/28Np33tv+5gYn93kzvdNEW
	UZ08S8PzzTx/7qP1FQyvDBiUAf3XQKxw5E+euZe/7NnRpLwoFU49+fxcgEbRXefNWbskj6DRAfW
	FgRie8NbllSvJ8ETbY9M+iUH7G55q90nK/3uPKW2kGOItbPRs+fSOcb4/4jvRsVmGnCIIV3n7n+
	mtkuznLgF4sXYSqcas7erhhepiJ36W9nqZ29ziGvrtlR9urqUXj8LTT2YuHEGU9uBHLq1OsH8Nv
	zvce6isQNm7gugLs/5cx4V9RAYIYz5srQYRCN3vGq7oq9yof5ikZtqUhpzP9u7jordyaTsAtHMN
	0+vAH4kAHcVTmqMgfG9L5K+SzlI6VvLuWMQ==
X-Google-Smtp-Source: AGHT+IEpZypmsJX+3x4lxGaOQe/NCjso9+9m/W+K10wS4dQshHoiI9ILyOjFk6fPXQuZEHwd7JKxdA==
X-Received: by 2002:a17:902:f54f:b0:223:88af:2c30 with SMTP id d9443c01a7336-22a8a0583d6mr178366325ad.16.1744049275791;
        Mon, 07 Apr 2025 11:07:55 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787763b3sm83736725ad.236.2025.04.07.11.07.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:07:55 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mark.rutland@arm.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	Andy Chiu <andybnac@gmail.com>,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	paul.walmsley@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	eric.lin@sifive.com,
	vicent.chen@sifive.com,
	zong.li@sifive.com,
	yongxuan.wang@sifive.com,
	samuel.holland@sifive.com,
	olivia.chu@sifive.com,
	c2232430@gmail.com
Subject: [PATCH] ftrace: properly merge notrace hash
Date: Tue,  8 Apr 2025 02:07:44 +0800
Message-Id: <20250407180745.42848-1-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global notrace hash should be jointly decided by the intersection of
each subops's notrace hash, but not the filter hash.

Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to manage many")
Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
 kernel/trace/ftrace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..ee662f380b61 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3526,18 +3526,17 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
 		notrace_hash = EMPTY_HASH;
 	} else {
-		size_bits = max(ops->func_hash->filter_hash->size_bits,
-				subops->func_hash->filter_hash->size_bits);
+		size_bits = max(ops->func_hash->notrace_hash->size_bits,
+				subops->func_hash->notrace_hash->size_bits);
 		notrace_hash = alloc_ftrace_hash(size_bits);
 		if (!notrace_hash) {
-			free_ftrace_hash(filter_hash);
+			free_ftrace_hash(notrace_hash);
 			return -ENOMEM;
 		}
 
-		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
-				     subops->func_hash->filter_hash);
+		ret = intersect_hash(&notrace_hash, ops->func_hash->notrace_hash,
+				     subops->func_hash->notrace_hash);
 		if (ret < 0) {
-			free_ftrace_hash(filter_hash);
 			free_ftrace_hash(notrace_hash);
 			return ret;
 		}
-- 
2.39.3 (Apple Git-145)

