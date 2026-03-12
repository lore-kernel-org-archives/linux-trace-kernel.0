Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF833CC9FB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327974; cv=none; b=RgXgfIpRAmZUrBqYUjR597/9OaocNIZG2ZusTd0eZPW7Eiss0NWFltV7Ar58Uy1TVoyJxV2lrc1CVm1eCq6vl1u9K2QitazsZuLB4wv6RyIDXzEeyD47njccvCn4ox+W2ljZU1y3DYtNJGwGEEwaAJargW7rIrrhdbTyuEbvyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327974; c=relaxed/simple;
	bh=Z1SDsa40pLRy8uZbCXpxwacAlGX8VoE5mm2vTI4i4hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLPSvgsh8uIcFUZdcSWTZzLtpIZ6odv95iCz6ZWXcxep+YAyXIjOsh7oBrsSUQbqBfsh0bXqr7EPncqNebbvpFDJk4eVtGRiwt9bPHbCzUA6WZS00K36/GlUTJFqpTSu7APBB3wPAltKqiPFy5C9+eLNMdLDUiFTgINDFh5ytRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=VATFKGp4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="VATFKGp4"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d74a59262fso1033797a34.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327972; x=1773932772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIVG0NEGvvMnZSblOn2xrLl5Gb2A5oGJQYQs/ymyUQY=;
        b=VATFKGp4aak13YrbJXLhruQhdO/rD36lriTAW4znYu/KkTRUWYpUSiYpHATgKNhoXb
         6LdSM/1ESXTgjoE96Dbj0VKptBvYsxkdPZd5iykCzyyYgzGniVuvDLvHaPavUCWKAgIx
         IrXgOOCmpUZW9lJ+JgrZcAWGQpdQRyLRsRKg/5Cs1e8AHHWsDPXfPk1JI63CXl5woIaG
         EpX9Ff/QOMqecqp5ET96LKOOVnOVCH+i6ZqzM5jo1jXTu4fLC0tcJ1hf3lT7QRdsJIXB
         U2GpmTE81JDApcrdxDl/V36C+IwHN4FwEAniP1rOjgEjDR6YmVY/w//anI1//37y32Kh
         p1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327972; x=1773932772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIVG0NEGvvMnZSblOn2xrLl5Gb2A5oGJQYQs/ymyUQY=;
        b=bARMdf/dx8956m3vXAQTOVv0gutJuAHa5saBCDQ4iV0cdSR2hjAkZhbCa17DTTbWEF
         zzrV8QFJ3DWzhvmUDTigyPp9eBLywNbDw0NQt9MNhX1K6UbKKUh1IZVwvE8Uf9lgCvx1
         IvFqjAJKHd5zJZEsWgw5Px1dVJ0tL27Xfb+fTFvIokoGM+kmafawW9MmlSbJ3fw4lKp5
         jfDnZ9n03r7FVEK48sJZ2+Gg6VBqKM33cBIkpox30kwPBPZL4zRDNefJE3daJJnblGyy
         BP5J6Xedtbm2sdfGk+0c8d5cjET0MK1ISEsy8ttne/7qlzoWeTN658aIHMGutC2RucOZ
         XIMA==
X-Forwarded-Encrypted: i=1; AJvYcCUfu0CbgFWd3upsgPs62+ZP0tUd/xmn1iOjnNPbSh8zqBoo9LwXyrEC3UsIgqZONeUl+B0oFyX8VsPaEbzTP/1azE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTINJS04h/xli42XKvxqGJjHUXXfYcmNnED1BaWNr7OlbeHwEf
	gc0sqaRUIRrv8TkSYvNR55apRyVrfaxN6PSh1/6Ik1nkDigO4QvLfgoCaSqhG6cgjLE=
X-Gm-Gg: ATEYQzw0j/MjWmJV5Z4eHrFqX7G88vHPDDqRa+0sTEgTt5BYm4B87DTK4i02TX7er/H
	z+vyYw9ooRaO7ugu/1KoTgBAP1UB/rYUwhXE+HOi7psDbqFPMPkSDDMDkDY35ZQoFFnwP28vkgV
	pRCCcDpLxzCABvIhzTDrs6rCcaDv1WALY25AS5p9mD+L0s6MjsOspAVz9K5K6OACy/iYzrZyn6Y
	boYehYfanADKl5kaNQEXdkoxENghI4/RML7HWxxqHW+ebqgbAU0aGVkIK5U2SLirUAW9eNmQWhR
	rh6OOwL0dn6N1OaDrUlopCVnqOmID/gwptCMkIs7FsZDkcbSwCLBXLGv/kqNcSXJQcrLtqHX6Jh
	RPGEcG81FIaadXStDHQyXLfoiZ+SblTuMVSMYuj6BpoLaMFoy+x4knnUD91xr2+mb4vCsLzHvVM
	sWPNURReyG47+uDqtpXvO0H4ejBeiFxb+22krkLte9o3WOQHka8HRa5L+1TFnwDneo0w==
X-Received: by 2002:a05:6830:838e:b0:7d7:5209:34a3 with SMTP id 46e09a7af769-7d76a7c909amr3711039a34.27.1773327972116;
        Thu, 12 Mar 2026 08:06:12 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:11 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 13/15] spi: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:08 -0400
Message-ID: <20260312150523.2054552-14-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 48ee5bf481738..44e618bab2f0b 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -953,7 +953,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_start(msg, xfer);
+			trace_invoke_spi_transfer_start(msg, xfer);
 	}
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
@@ -987,7 +987,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_stop(msg, xfer);
+			trace_invoke_spi_transfer_stop(msg, xfer);
 	}
 
 out:
-- 
2.53.0

