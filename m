Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434B433B3;
	Thu, 27 Jun 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508132; cv=none; b=NV/VN7sHFlGPGsmKTGOme2owEoEMt8NNplM9xnYEA3gUIfcst2L7D3aJBEYmYEI0PwjkRFDysZnLXnKqX6thBx4ym73ni3ZwXjrBA/KRjRHJmHx/o1xHE190TIO9NSKRAWaa0TzEhjTvoNumiyLLCg47Ww811EiEYThEP7W3sbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508132; c=relaxed/simple;
	bh=6a+QzgfITt8frxG2BinwNLUcugEG8Lp4mDKzxGhzYm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d6Oot6BmsHFOSI8YADIhJRo+oZnkgwTTi/kjGp7QRUhC5IUAA1zBIrpAmY8WrYoJMFV7bLpVJWC+uCKUbGyuz1AK6oN3zUkKdZbqHxVFdY9QytRSDB9qNxVD1tV6joIzlRE2IBguJo+jYzEBKwWrIk1hdCvIOQoKrze5Ed4aEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+kNx+ND; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+kNx+ND"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso13857075e9.3;
        Thu, 27 Jun 2024 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508129; x=1720112929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cd52TDCo23vBUICUzAHPR5YFmSE3EhQH6c918u4ugTM=;
        b=l+kNx+NDwiJN6QHmYwbT4SGurL9WxLn07hFdAH4sd/lEfWKy6Noq7f+ijhr67RwKZB
         onULGKKtnqUOdckxbqL+OIFdpUyeaJN6TmKBuzAMu4N9CD3Q03myC8KJxToUx8zHH+4u
         UX9TkxglsiIwhnV00lj3kCjDB6rHgsWWNRLIUtNf1j1zl56ciR5b7wA6rxdLRbwep6Gu
         uopXkX66+IaBD6+ROZDX+eBfqqkPnqs6pbT9YBu9H2/qWHL8eQcSWI2cdKvdgjb9pLk4
         gBEQXq8vrIpXXD1VaYZGB8sSbSlunmaW6bS7Eb/jsXlO21s4c+unLCQl8ZTgxf+GcLJ0
         Blmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508129; x=1720112929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cd52TDCo23vBUICUzAHPR5YFmSE3EhQH6c918u4ugTM=;
        b=T6XD5c50Og8elC3ksQM7arGF0ZpN4yP5HXAm7uNtCPafy6AZ10pnrfzS5MQZaycWza
         vMpe9my3x+IID4+N/mT1wl4ogLe3dQmMz7WIUXRf78Xt9TLfAO1Snpcbq3puLQmt68Ly
         MX/Ko6IysghGsZBO3pZJ15fePizmZUh4SDFIfUm0fUatSMFMAEq4/cs0MfU7H3W3nOw5
         YVN63MPHEoc3tT9gTTcqSnmbtguUV2k/VD7Hc2p4gQl1kEe23FAe9V1M7RsaAoiXxEMn
         2X3euc/7flJRPOn+iOo9uFgAkoR7Q3IVi/KiKRRsVwanIR49at46kYTe6psmb3HBEuza
         S3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtY1I/ugo29QsI4upeDo+IKg4jYn/YpB9vq0cNoixyxaypcsTq+a5Zm9XYpNyycfrfnQRk+d016NrZPrL4WhjCgmLTN/ZneoSnUazGXPm/WK5bsk36c9yMenuMdZuoCbcR/8gA9W/UQrrPGQcNf6T+
X-Gm-Message-State: AOJu0YyS5jnyy6diMrYxY/zrBg/PzwM6ihUMJSL3zIpMfaeG2/ZfoqDE
	7PEmO7/DHJd9MeciZto0NQwX7VgcD7hUk7EtwFSOvdm0NaTmtfJ4NHUAwA==
X-Google-Smtp-Source: AGHT+IE5bMkYh7fWJfWBM1m0gURnI3pYwYNUdfjazbH575zk32WvUb2At7eMuejqYxfL6YI71DOP4Q==
X-Received: by 2002:a05:6000:1010:b0:367:f2b:aeff with SMTP id ffacd0b85a97d-3670f2bb07emr4426806f8f.0.1719508129193;
        Thu, 27 Jun 2024 10:08:49 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357c12esm2493077f8f.15.2024.06.27.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:08:48 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH][next] firewire: core: Fix spelling mistakes in tracepoint messages
Date: Thu, 27 Jun 2024 18:08:47 +0100
Message-Id: <20240627170847.125531-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two spelling mistakes in the tracepoint message text. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 include/trace/events/firewire.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index d9158a134beb..86330ba58336 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -853,7 +853,7 @@ DECLARE_EVENT_CLASS(isoc_single_completions_template,
 		memcpy(__get_dynamic_array(header), header, __get_dynamic_array_len(header));
 	),
 	TP_printk(
-		"context=0x%llx card_index=%u timestap=0x%04x cause=%s header=%s",
+		"context=0x%llx card_index=%u timestamp=0x%04x cause=%s header=%s",
 		__entry->context,
 		__entry->card_index,
 		__entry->timestamp,
@@ -891,7 +891,7 @@ TRACE_EVENT(isoc_inbound_multiple_completions,
 		__entry->cause = cause;
 	),
 	TP_printk(
-		"context=0x%llx card_index=%u comleted=%u cause=%s",
+		"context=0x%llx card_index=%u completed=%u cause=%s",
 		__entry->context,
 		__entry->card_index,
 		__entry->completed,
-- 
2.39.2

