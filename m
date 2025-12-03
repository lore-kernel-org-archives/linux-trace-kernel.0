Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4227603F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786096; cv=none; b=M4skGeVab2VRSvdziyuXdYnxCZs7TZ28PHup9zB3BKaDcMyi98JqV3taAR+hoRbFivduroWuvojaMRQ2PKKhJO5jll6r9ALZltWEB0iTsN2MwWKDnW8MlghfG7Wpg3U5tQ5+5anvP2/X9h2D7QwHoM2p8X2SB1W7fdeg16U3nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786096; c=relaxed/simple;
	bh=XJ1xcMRdMwOsGfdAXpF2A69QXd/Mrs7f+S0GwB+Q0zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5tllb3q7ZF481sra95exiHDGBB3PLaCGcrev4UcQp8XnQzGRvMnyccLBDUNyTZmIySUy4Y1lPGRrkhubtQq1wRO7IK1GW7tqBUuKwfGnMkbsI6Wxq9PcztpEUjWQycjENx6lSZ8+3CStSPxsu+IyzQxdmwPSv09whGJ6xe39PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGEoa3l1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGEoa3l1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2958db8ae4fso692915ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764786094; x=1765390894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TA5KgmV06QkZagHSOWVDNWdYVxZvmkjGyikqKY+khMg=;
        b=bGEoa3l15XeNrqgVSqbyhcNFcjaWfnk6S8HcntXUOpilrzRT09CIYQMPowdKxH7EWp
         3PIsiL9StQcKR6VQycyCSmWIgmJq1NEjEEy0ZY8JRu2mjBEhMSP9z8ruiHEgsyluAmzj
         dBbAcdEzyBoYa8YMIMMOkdbgrm5HJ4XSI1EDAAICNS/n2q3Dr35eyojoBgrq1fUxJTkr
         gm5djhHFq/gXbBx+i0OYTgPunOZ04ynqsOTXK2ugsDyqCmobbk1MOUC4PKnwvWUkkTfK
         u2TyGgZYjSSD/+q5CLBTMUl133fXaxboTgvso7fIe6TpdRY5Sh88nab/Nmpsk+PDPoLc
         eJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764786094; x=1765390894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA5KgmV06QkZagHSOWVDNWdYVxZvmkjGyikqKY+khMg=;
        b=gX+4yo8fyKZUAwDf7JvS+yvy9xM3xEJWmZvFwPCjkA3TGjyVwqAGnLN0unrujBR/rX
         VWOSHV+1RzKNOItl/T6WewnFLKwZgA0xr2N9ri6wv/ypSNCOc+F04nFe4QU+n3bAkDmZ
         //rh1OlBetjc8tjztXDVZ+QQBwZIEjDkKCXoLx/adKhsw5wn9zHUkpDxjx16vfNYibzj
         2ydBO27oyIinyydeXipQOmJtV/90MunmrLuJJyP8aZ7rZYY1YYO6jNbjALomKnuSgSEW
         VuchMNaE5kJI2BYUNX9ISl6wwuvsWxHhqU16ulGrg0QyGvJrOIvHN+i6xWD2Qvqz6oYd
         RUGw==
X-Forwarded-Encrypted: i=1; AJvYcCWU9A31mdz4/mdxovq7X1jE7tq5d31vup6rQwFYW+6UCtkcGbWEQKjG6EEQn4BSuW6/ydANs3+HWIFqjzF1UuBWkPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgTZaqqxwAuCyKDevmfhs0LtV3d8e4dzFw7xTPfYR0XsV0aAf
	tElN1zVNy3WdEGjguLlAj9+wjjzE92/NlvUpM5Ae34l1Scisyas/lVd/
X-Gm-Gg: ASbGncsVM0NroAeKzOegQ20MQgxNRLEg9fKw1BS3plk0J7kO0x39EVwYrEtvwS+jvoq
	P2szTK3cfp5GQVoV57zfKu8O8KQQe0myfXdIFa0CNVrKLpn0ToZygHTMeWXxVnyEnN1CAlwzopk
	OAHT/8fwcCT0jbdG3VJW7nK9mk6KtUe+orQfG3NXiSK+Ccb+dUqkal+rJBZPtaM2azdEUMNrg+v
	yE7FlN2vJyXIqcO4yFp5Gjn8Bnm/gmcoEhVKIWqw01FjFwsTkbxrmGJwCcF13ThuGJf/tHV9fmM
	ugGJZT4V0xu1JBKkbprOAtNhsfA4h2i4Mws4C8hRKiUwa83M8Zqhl/aVpuuhxcNM41khZGCSDMF
	rteF/CPX8mC3/lJUvfjpC59ziwvbQReYn/Hh4Xiyzj7h+Z/075fV8Prp6AQ11iQdslicRGZf/GW
	OsvoHClsvQlmOHzKUJHbM=
X-Google-Smtp-Source: AGHT+IEJzmJssgbrkH8WJ4QU3sLFJzLPnML2qy4GAU7o/LHkI5r0URBsuV/jtiXbw3XNi9hrDB5Ahw==
X-Received: by 2002:a17:903:90c:b0:27d:c542:fe25 with SMTP id d9443c01a7336-29d683afcafmr41970015ad.41.1764786094501;
        Wed, 03 Dec 2025 10:21:34 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm194659425ad.97.2025.12.03.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 10:21:34 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] Documentation/rv: Fix dead link to monitor_synthesis.rst
Date: Wed,  3 Dec 2025 23:51:21 +0530
Message-Id: <20251203182121.52759-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file 'da_monitor_synthesis.rst' was renamed to 'monitor_synthesis.rst' in
commit f40a7c060207090f41998025fcd1cfad06ea2780
("Documentation/rv: Prepare monitor synthesis document for LTL inclusion").

Update the reference to point to the new filename.

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
Changelog:
- Use proper commit SHA reference syntax

 Documentation/trace/rv/da_monitor_instrumentation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/da_monitor_instrumentation.rst b/Documentation/trace/rv/da_monitor_instrumentation.rst
index 6c67c7b57811..b847c58a96b6 100644
--- a/Documentation/trace/rv/da_monitor_instrumentation.rst
+++ b/Documentation/trace/rv/da_monitor_instrumentation.rst
@@ -168,4 +168,4 @@ The probes then need to be detached at the disable phase.
 
 The wip monitor is presented in::
 
-  Documentation/trace/rv/da_monitor_synthesis.rst
+  Documentation/trace/rv/monitor_synthesis.rst
-- 
2.34.1

