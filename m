Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD362F0C5D;
	Thu, 28 Aug 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366489; cv=none; b=OBhEV4w+/fdxmp29+9tMzzHbR4J3Z9QUit/sQQ+UEn3NeXwU9QUKmmYeSBUjA+RihHTeMIsEpxRlx32Uh4RCpttmyZt+6v3kr1RxPlCkxvnEye+INo7Fk7Lp4zQR13ikBzmxyw16ejgn7Rk9pKqsFkTmL1Fbxz5vhnZaH8kek94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366489; c=relaxed/simple;
	bh=QKroQKgE786tSVKjng78IPN4xWkjXaZ/DFWdSoJQlsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENCcWNZqp1Pihqv7kKRoOZkMaH+3l30OkiwZCH4k0fATsdRez64sO2GTFl2MUtZ9JjjT0H4KhIwBiwdssz8rvYR1cIhoWwbcuS4vKGjDHoOr6IuNRx9m2cMlgIlnOfBD/n34+KNoEN+tpxiLXZTzPpTVD0PfMEu/xpAxc8zOBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWQQU0XV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWQQU0XV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-770530175a6so425430b3a.3;
        Thu, 28 Aug 2025 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366488; x=1756971288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HWJW+tuPYyKxysGDOHcH2OoItBTHApdsbmGOaraLm0=;
        b=lWQQU0XV3Y1DTeR9zvp0cR5y8aD3C0/wX9mviP9LXh0wefLJY+fQo+T235TvrXKM4U
         KhpB358zSqycw9C1tOqZFHP7RSW0kMF4PLh3U3RB06CuBDIAGcutu0QmSwroup7omQk4
         NalSAhykAWcG0/TwVZ0hNPwkfkTsvbNqVUa0EO62fEaEHStibLkVi66SyIRRjepXZSkf
         t1i6CmT0ebHCvHYr2gJ8Tdu61fzhHh+zzwbtL3yW42svP5VfnsDB0zOMu0tLOXavTGSE
         peH5BHtfobhNQ1Z+sFjvOmcZbGcv2/zdD0HY/xtVJcbOWh4hpBfnZSzbqFVqdjdnzqDR
         LaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366488; x=1756971288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HWJW+tuPYyKxysGDOHcH2OoItBTHApdsbmGOaraLm0=;
        b=YF9E0q2iKU+fr4MHVzVJ1ks+cs2QnWHvlCpfaEOucsskdlPNsUZ8WEN690aYElxf7w
         bKR5QLX/0V/wHVjfHZM+j6TRz5N5Sk2ZsPa2tIy+BWtYul662pfhcRgz7DyG6pg9DT74
         4Pqxq9C+cYYC1sqauTdOSNzB7RpYfCZ4/JM6xG/oGHFa8MTba/sv07nSTlfCCJ8QRqc7
         GUYYQCHVOwC2xOWTVnpJTebOz5TFxRqLn6mjOUqp/QEHgtw8Oy8nfbvuo19/bCqbXrf2
         Qw0diq+5JipBBm8aqjI8h6Bped7r5sSLFaAj9TXzkCIXBSiv+vr8/YEoOqU0SqFv8pLw
         atuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr3QcfOes2CdBctz17U23zutHd2cQz3ymSYaUxS5qrRpw8K7vmSVyjoMu/UpwABE6d8VrDgxWD1/OMQGt+jhbe4xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL01fGFs3M0lkzX7/bSEfwO843uYJacugaQImTIBqPfffgCBj7
	G05gJ/F5XlCVPvOHCEY1HlxAy9XZhmbAcT2v+cc4BAwgcfcY+5V/Y9Hx
X-Gm-Gg: ASbGncvq+R7cKC8wO5Mi58CaGbeOcz0zzQjCn9nz9GYrO1eRmcthln57+pMUUs0n1OY
	4MiT8sE0i3VMHu/HKhljCA8JD9eRbf/tJ89dskFlQMKeAJmkq7rxw7Z6G7bzPGkx2Vs151uS1sl
	n8XEzhMFVRMcM6pN4EfUH7HevHWAgItNybSVXYaVvykIYWu3nk0jjZulObAuNz3Hpr77kcN22up
	GdTZ8ZN0iXoa5iu0RslHU8OwgHhTBopgqjQp6rfWCoonGAwke0IRVML57yrKn7oWBANPWs++Ocr
	uCCV8Ba+cNRgCcrK4s/YDMeoqtr7dmsgJb+roQhVTeFt+JAV/TOxhgHTsaMW3e5fZMgxC5PfLjj
	5oJ32ujcipsSseq1kH2u7m7X1adoVQ8Yw0XRajYe7dNpgBbeyM7lFByzIl6ue
X-Google-Smtp-Source: AGHT+IHMS2NPWoxRpnmY3flLVzQUfw/v5SMsqEM3beAW5o+sLJcBBLfDbzGyGozdOk7sQZB2BLTNOg==
X-Received: by 2002:a05:6a20:3ca8:b0:240:750:58f with SMTP id adf61e73a8af0-24340d91edcmr29392145637.30.1756366487573;
        Thu, 28 Aug 2025 00:34:47 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:47 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 11/17] mm/ksw: add self-debug functions for kstackwatch watch
Date: Thu, 28 Aug 2025 15:32:44 +0800
Message-ID: <20250828073311.1116593-12-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ksw_watch_show() and ksw_watch_fire() for runtime debugging of
kstackwatch's watch mechanism:

 - ksw_watch_show(): prints the currently armed watch address and length
 - ksw_watch_fire(): forcibly triggers the watch by writing to the watched
   address

These functions help validate the dynamic watch behavior and facilitate
testing without requiring real events.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index bc8664af4fa6..d1bb5ae75aae 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -47,5 +47,7 @@ int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
 int ksw_watch_on(u64 watch_addr, u64 watch_len);
 void ksw_watch_off(void);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 284facaac8fc..158843876958 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -118,7 +118,6 @@ int ksw_watch_on(u64 watch_addr, u64 watch_len)
 			ksw_watch_on_local_cpu(&watch_info);
 		} else {
 			call_single_data_t *csd = &per_cpu(watch_csd, cpu);
-
 			smp_call_function_single_async(cpu, csd);
 		}
 	}
@@ -160,3 +159,19 @@ void ksw_watch_exit(void)
 
 	pr_info("KSW: watch exited\n");
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	pr_info("KSW: watch target bp_addr: 0x%llx len:%llu\n",
+		watch_info.addr, watch_info.len);
+}
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	char *ptr = (char *)watch_info.addr;
+
+	pr_warn("KSW: watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately
+}
-- 
2.43.0

