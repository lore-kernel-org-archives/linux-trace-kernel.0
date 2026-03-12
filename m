Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D9345757
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341124; cv=none; b=cEc+4UuOS6t8O45rZQtuCh5w08OyVmbGSwUw66DFWYKgqI7AKQf2jjOIlNHKgOaqmnn24lIWiDq834itQ20WRyM3GxwWbUVwZvckY30djIiubU4JsuSzyIIaL5hvZQoIIa8SZNJM8Z83YSwrrGdTj5qTpGf0NNH4u4P2sohPuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341124; c=relaxed/simple;
	bh=hU/VGb3yH21YeL4A5VehtT/XBLjvs/a5om/0zQIeRrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iz+YBO4SUXBN9FLSRG6NQcS/3tBOMTP2tQtJaHrhZpS15cZuGUeHryPnKyJmLbChuTevXym6ZGJFyltoxilKTX7D/xW0aMsxdbXB9+eZ1jd2DS+v87hOPaVcGGen00xL0dEASd0Rqy1HMWnpC+VFAonYJ7tZMsp4/YM4RZWPMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShglveBq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShglveBq"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a3066b68bso13011471fa.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773341121; x=1773945921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0hRm0NvHlM6XWE83yipHMAEU8541DZieRPUAjm3PCU=;
        b=ShglveBqNjxqLR41lNGd9NdOOElTmA/oNNwMC6OXdafL8VE3OVQmVj9MUjqBrdxyGZ
         Wvmxc8CkQzz+2XipvAuy7nQKK+KIZOdk6lWsQTHFN3ZappClN8BJ8dfQoIYi8SUH8DPA
         Hyk8+XEfZ8J/IM8vuUN15ajOEs/xUZJA5KdJcyXvtQaeL1aCD+59opYmEsZLR36t+HJM
         QqUXk2WSrIVhT9r5GsUxa/TvlMC6qEHkyWIEdtAY7IpsZ07E75rU8uYcdBbWL8f+dTlV
         MIyZIC3+xsCv2k6LsVZt+HDDrDRvSsuIFmw4zx4ct+rPW+jbzwx7nGz8orqtb5gc4w+e
         0dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341121; x=1773945921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0hRm0NvHlM6XWE83yipHMAEU8541DZieRPUAjm3PCU=;
        b=K41Nzvcb+YUC5WYdkBTa9KsdsaqHA48XwdGV6TdmSICwOB1f4pGcHJ6jHy4nQZF75s
         DnEqKP42y6S61cCKii85gyyqeMbXQBW1hZSr5cDdVakwnfpt3IEt6mIfflLsWfxn8bb3
         WUBOGuNrF2F2hD4qYsk95bGg3OCgppXf665/pOGu/Gkcq/0FNUv5Apgdb29r3Si2ulPq
         gwZ3V4MgNloYN4LIlHLxYjN9iyXej1ihCmQsLO5JebBPvNiJNqupM1gLD3ZtdHbX2mvM
         ipFzAbiVnqW02UTWCa8iAJ7HoDTvKrrqNjflH/RpnumgwcA0Oif34yynH9dteCSflkE/
         72Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXCo3tXNdB0XoRdpFTPXM2WoeBzZ5l3M/0Eyrs+hu9y1hJ6ujGZfE9/RtSujNFP4rIU8h6DNDlBDbAO6TdZ1iXPGwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDNiVQ4V8YwCvMMooNG9dFQmW+wa5n4hHPHep2TzkqvDvicCj
	N3Vo2BYW/o+HcrXCyaUI9fRIsPHQIy7kNO6OeUp9kzGpqHBqFVzZ3az7
X-Gm-Gg: ATEYQzw/wE0YuSRX3EfHgbR11B1fWpSVzYrz1kYCULiHBAc0XeSN2dkkX2nLaqjJCgk
	H3q4O2AA3Gnrgy1wTrT6/WxGRfD86Cq2rVNkdrcy1hBa3xyfmt8mimrsEZJ3SYaWVqy1H5t4CzM
	bTB29twenZlXOToP0ohoVBrRuN9cnIH1pYxsosAg88YcA6IqQKDbcue0HqE2lcBg7qrIG+lbsHE
	8cO/E7x8r9qhrNnG3HYQyrlaiakNJTiKbeWm/DxRUy/Wl2ycQKykLM87l0W46c9v91AYt0fjbli
	VcqFdtGSJKP2cu4wcU3GCItDkTXVJh0OWmYsCzqCetWnMVRWrNh5vzm5p/gvvt8/EbgC9fPe86/
	oyhmuyZAjUZP7rlWDs8/XMLru7eY8+ftHSwe3a8fouuJDyDPz9h05+FwJMtalDydHDvB5OrHBL3
	7Wj/274SK2Gn+Zl6nnlFrgUBi7Gz3AAt7cejTI7c4x1Xw2BBVIVEvLLHdUezuPOZ9VU4VIDhw=
X-Received: by 2002:a05:651c:1584:b0:38a:32bc:6afb with SMTP id 38308e7fff4ca-38a8983ffa3mr947221fa.40.1773341121164;
        Thu, 12 Mar 2026 11:45:21 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e7b64bsm10382991fa.43.2026.03.12.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:45:21 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] lib/bootconfig: check bounds before writing in __xbc_open_brace()
Date: Thu, 12 Mar 2026 18:45:19 +0000
Message-Id: <20260312184520.24399-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312184520.24399-1-objecting@objecting.org>
References: <20260312184520.24399-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bounds check for brace_index happens after the array write.
While the current call pattern prevents an actual out-of-bounds
access (the previous call would have returned an error), the
write-before-check pattern is fragile and would become a real
out-of-bounds write if the error return were ever not propagated.

Move the bounds check before the array write so the function is
self-contained and safe regardless of caller behavior.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a1e6a2e14b01..62b4ed7a0ba6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(char *p)
 static int __init __xbc_open_brace(char *p)
 {
 	/* Push the last key as open brace */
-	open_brace[brace_index++] = xbc_node_index(last_parent);
 	if (brace_index >= XBC_DEPTH_MAX)
 		return xbc_parse_error("Exceed max depth of braces", p);
+	open_brace[brace_index++] = xbc_node_index(last_parent);
 
 	return 0;
 }
-- 
2.34.1

