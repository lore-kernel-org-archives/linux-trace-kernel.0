Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786442065;
	Sun, 31 Aug 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635472; cv=none; b=lWUbBbgiiQ8p0iv8RcaCnlUHaxf7au28h2V0FibIAkhG6yHnzJgc3JvaxQ3z0nNlOi7GN4to4qrQrqYoc7m/fKS942OH7w5vtxIrO1dfJO161x7RXwRP2TV36Nctl8c3979YpJVGyWD8e5ODd8TENwvyUVMqgkCuQRxg8dCAtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635472; c=relaxed/simple;
	bh=WgMXyIuYHUXdsskYc7L9F2jvIhSMcMVwt1SocD3L+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFKCeU3obJn9Mjzbz5cuZyTP6ps5hDFejNw9nJPZ4yZtfVTYPxjvAkqmz7OMuUdc7pifcPiuE9K64KR9jNDBJWbPUQWQCFCNW80GpDmlTpECF5i25ICPnw000hG/LUgp5J9YnacLSR88xK52Z+OjXZs219kALiX/cDJtIx/fZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU7wK/YF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU7wK/YF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7fac8fdea9fso298276085a.2;
        Sun, 31 Aug 2025 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635470; x=1757240270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipp/CqJGnu3UvrsRy3sfGCJOG70DAK1lDD2BMO20XEI=;
        b=cU7wK/YFujPyQQc+T7Cj8ZJW0KholGExLbmZuUhbvkh4QdCloPzzHeQ6V25ETIZZK9
         E8snocOm8gfS2S1zAGo6o+Adp6fSzExKP5S6SfI8TOFQFfr2go3nUKqvoiHJDz6DAJV8
         5JUcakbKkairbDn9TqfiH+ZLnyyDGcvnWLYCoTKzPqBBERY7oNBJnlmP6UIy3a3Dbyn1
         dduLNTXK4buLIkmyU9QNwzg8PwNF1cd2ytKp87SxdBYOxRStFs3wdrtr2rHAVkfAEu+x
         lFmpa1+bYqmcQL43iQPCrIRBiy+drP0xBbVRhzZFMljYZmHu6lB6x4x5CtGEsei6fHfB
         px2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635470; x=1757240270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ipp/CqJGnu3UvrsRy3sfGCJOG70DAK1lDD2BMO20XEI=;
        b=c+QBvYX58/HYeTDemves+vKUiyHPXMsptU7a3Blj4vbMdPvbod1m4y0SdRoQdJvUyj
         fVjEeWmbH34j8Aqx4wKp/NOiCKWZ9WzcViXXzmS4Ao8jqXElqzqQwv9jVOqbXrT6Ivy+
         EfwN7G6m55BroxRKqOSiNRHnHwHlYIbvJGzYbVoR/v4DMvNcgLDiLvheY4D+F0r/RG5W
         EymNon1hfw6KCVOe1KY4SOpndSjEIz7/42qWOHnx8eLHFbT8d8HV9E4nkelTsCwEylW8
         Ee0Lg8BNF2WfJMhyZ1279n5oyyFu6gudehxy0jF+QnEW33H6Jv0tta5DtRi9lVTzchYa
         ju4Q==
X-Forwarded-Encrypted: i=1; AJvYcCURaUWesqbSNylsQQ8uSmBh0mWmaTIGwiu+JKBmyPm7OOWAl6HKuGBfh/B8R4HQx4mDfyumG3e45BHoQwt8@vger.kernel.org, AJvYcCVLHfaofFL6niWHm3K1UzSmq240atMlqF26benCo1zsu2/CWziC28NLqvOAPUZGj/TsRijj430u69aL0X6CdWOUjBt+@vger.kernel.org, AJvYcCXTTtPpKKWlMPOpz2tRKneHyT8iJJOKwrLyTJybGX62S0QnSS03a4uRoWrq0DpS0HbNws0ghDoHHP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV0IWK8WNvMH9CZglUvL0LqIuLb6wh8J3CF8m22R5RcPROsrJ
	oYs1uav+v3r/o0G+mS9DNIIx2JKKLcxKIpO0DE5ejABVRkNa6ZQBk/+l
X-Gm-Gg: ASbGncvghCIBjVERXWxtB7MUX9AhX2QeEKWBgbWCGGPDcGaUXeoiRjC4KVF4wU7cRdI
	D4DSVJDG1is/Ixt+ynPk/yz96MzhC+HTaPVkOcw2LN/UNGZTllEX5xB2LXiABwWOZAmunfc16op
	cEXPCnjwO8H4CtxwOSwvscGdrGYDsv+qk43FA5PHv5ifPBK9dE3KyhiUnLSPFZuWDVK4REIyjBx
	y9GOTGr5FFt+R6wWvDpWxQRo8EUqE7B8ljKvR1032ZdVnIr6kNhhMZEcavmi9xB/eBZdxfrag2B
	Kh1GV1kyEKrj9zPVXSksmY3pKMyfrbawHZ5bzGJPyb5XI6A65PWbY75dsVsHDeVFMoADQoGNRJf
	sMHUiQaCx6jh+ibMgNwHGiBUjMMkQX1Jm9GgOixq5JG2mDfry6v7DxFAdtJ0PKahEPVounn74F/
	4jRw==
X-Google-Smtp-Source: AGHT+IHZ1ssnnZzP2UdpQ0Ya7Rknskr0E+/ay0R2C3CfiGo6hckrP+f/i5G8f4xMd9tGm5cHuX19EA==
X-Received: by 2002:a05:620a:179f:b0:7f3:4a0f:3581 with SMTP id af79cd13be357-7ff26eaaf8fmr392838985a.12.1756635469980;
        Sun, 31 Aug 2025 03:17:49 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm480262785a.66.2025.08.31.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:17:49 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] trace: minor documentation fixes for clarity and
Date: Sun, 31 Aug 2025 19:17:27 +0900
Message-ID: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend: fixed recipients; no changes

Hi all,

This short series cleans up two small wording issues in the tracing docs to
improve readability. There are no functional changes.

Ryan Chung (2):
  trace: rephrase for clearer documentation
  trace: fix grammar error in debugging.rst

 Documentation/trace/boottime-trace.rst | 2 +-
 Documentation/trace/debugging.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

