Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DB349B17
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Mar 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886410; cv=none; b=g0TlkqMmrAE+3hgKuLkdzKhojH2lAev1P9ndGnEPrac1cycO8mhcqGsUi1L5BoLob/Cz61pSR2EwmpcWQrAKkU077eDmUOGd9wqNkK8IB23FwdEv3AqjEwWVtD407H9xxijs9aR8ecnsI7cEPBk8gkDi+GPz/TxFE9PQO26VmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886410; c=relaxed/simple;
	bh=Tszwr/b80jteMp43aPMxayAyHU3S80KsQ6pREfgnw5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfihoEWExvM0idC3/n4Cr01evLmf/HkO92GT0pWz0gkjsvVYAnXU3vvaubOlX5a5+nDr1XVXhgiaHlKSvKaJIUEuzyH9ml74hXuCokHSDlpKmB/PHE+JyBEIi1956+EKJp2oAE36AiRxWcLKFN7X564WXQZ1tn4+yG9IF86/WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPVgOd4G; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPVgOd4G"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a5db525cso93884446d6.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Mar 2026 04:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772886407; x=1773491207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySCfYST72H79uVuS6rk4TQ1ddmhn4LF+GYeJE0lX+bA=;
        b=OPVgOd4G5xoWpOqh/mcMUYrzgZwq7z4B1bhI3+GEBTnCFArvC6mylVwe3nnA5u71R1
         z99/C4Rrd8kIZCKy1FVAoCI8EqxDNsnL+6meUWu6ajxuBUIdtFUSqteZ4o22B6Om/GRV
         kRxQw8NrqWm05scLDL7nPxLBTLZ5tmeaf7qJDyFNIy9c3gVQZ53+vehw36z3jtcN3oir
         TjmQuCL5GabdjdAEAivKUQJwW/LDH/YT0R73XLejATy3/qB9u6ti0dMuKWF/TDg7y/UZ
         AkxOAOiPYj2hhxdFJ9qgUe9mzA53RI1JnRarNamH9oBVPu3shJifTW+dbqBBcWC70TuR
         /5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772886407; x=1773491207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySCfYST72H79uVuS6rk4TQ1ddmhn4LF+GYeJE0lX+bA=;
        b=GYkHxVpabwgWVhHbmtIxyRGGf5kpQ6CCRXgDHk5QItJ9uEu6xivw40J6bPzQXwFRXE
         /3C71m5XxhI9vvD83jHRX14um5LQ3Hsb3/iiBSplXOk/8KdLWxwJzU8FQB2MA7uNbwCz
         zTBXJFSQp7dRNx5o9lf/68agiG0qAF2hhzTzYB7bKLKBY2xweQOwNPrTdYLeX9YlYC7x
         ZRdIAYza7Dh5MC0qCRT4V6XLf74kr+PjsDV9ZcP+C+X0scGFGEHgb14YpXFO4RQsBv8t
         8pN23WBLcqjE9CAeIBkQ55H9hsJCdOSfBEfkAnDM58FD3Lf7c660DgqPhFHY9w2nJ8PD
         Ei4A==
X-Forwarded-Encrypted: i=1; AJvYcCVLCtaflapuotbY0fqhVPDS9RMis7BeTI7FRSmKTp+5fm4s6IbqXvKyJURzMHoOGfXLfOFt9bNQbRERHNZ+EragdUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgP60mXcHwcCihJhrAP+BtsACUg1zQ6fY0LL7dKfPO8IMuLjti
	HPhxKpqff4k72+7amUlLqVVgFnKKyo7c0b4+9uhNUhuu+uxlcM0mLdXzY8IM0FAw
X-Gm-Gg: ATEYQzxCAquwXstXQ4W0oD/Nje/nHC4jClWc0AUp0jNIkTSTuLlQPfTOm5DfwH3psQr
	I5mq4bS+m0wJKWlZFMq71qULyC3xJm10bIgQoFMyIJpTvDrHgj8tDE3iZUkAVztmWOhp5rfe3mX
	VolJ8K5DcWsvGBD4gdAoKm5b346FESzzkEQFK1rhJ86+uoPIkFrJJVArd8sNGQIn+SdlszWpDM/
	8ewRBVtZqhmp43522qWOh/pCrbAhEF5AXY+eUR+IHnlYXecNq+wyw1dzkxnw+/dbCCbJmAQ8Uh0
	Tpf/rarKygPi9IEJGNixFp2NjlzqVI70T/+yaVUNwitopcK/zYpbJhYEdJ6IE998xLvV3hLkqOo
	HQQVf5d1XwW5wXVCLOqiFyaZdVfae9sF0NLKvToU3Ade064YjgoHtzFAwC1aitBOB7bc9NOLK2Z
	gYEY0clZL8TARFT+QosnWeuOAEKD4x0Tjl429GXNLKM1Y05DFuy48lg1xjhv+n4Z7LD+sce94YR
	wZt
X-Received: by 2002:a05:6214:d69:b0:89a:df:164 with SMTP id 6a1803df08f44-89a30a9e9c6mr71244036d6.39.1772886407488;
        Sat, 07 Mar 2026 04:26:47 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a31719bb3sm37093286d6.49.2026.03.07.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 04:26:47 -0800 (PST)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: mhiramat@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] lib/bootconfig: fix typo "budy" in _xbc_exit() comment
Date: Sat,  7 Mar 2026 12:26:46 +0000
Message-ID: <20260307122646.2838540-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

Fix a spelling error in the _xbc_exit() kernel-doc comment where
"budy system" was written instead of "buddy system".

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 449369a60846..2bcd5c2aa87e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -911,7 +911,7 @@ static int __init xbc_parse_tree(void)
 
 /**
  * _xbc_exit() - Clean up all parsed bootconfig
- * @early: Set true if this is called before budy system is initialized.
+ * @early: Set true if this is called before buddy system is initialized.
  *
  * This clears all data structures of parsed bootconfig on memory.
  * If you need to reuse xbc_init() with new boot config, you can
-- 
2.43.0

