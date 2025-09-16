Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131142D6E55
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001345; cv=none; b=XprsdT8dqA1RXy43zLE9xCpF4vmQRd5IOFoqBUWUAeHKnQAXOoEXGZhJiYSxww/vw42xPDvxJy04ly9AtmAiMwRFXXF7vj6vFrLll4Lm1cCX8NxGNSbHpjoVf0Bsa/qXU3GOi9qeEuhnqFoaRKG4JLPMD0VuxymnLGdLoEfcNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001345; c=relaxed/simple;
	bh=IM0I2qOotzNuT503Elh5AFKW881D8AA0LxYsvx+eLpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rua7n1OYnP7/+UCQQA9fitZZtTe/Z2b4vHzc7N6mcvTPihhYvEk4VgLv4JtDujJXfpcEsFQiAFtxsqfBN7SwEh4U+iVIUX6N7mx+8W4+sKCzXYzF9DUdFG/RGGUbAgnDJl5Dgfvg08MllAT+r+WX5tkKvnbHsWodaNmCoM3GJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsAoY9//; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsAoY9//"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b523af71683so4121291a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001343; x=1758606143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DPf9GY80lnpMXx7381cdrBChaqI4wIuCjM7QR2i8T8=;
        b=WsAoY9//wbPwPNHGeS1FGPPUsNOsm01pp7uBWqFx3DIyxzZMoXWLsKZMHnpor4buPO
         3HntoLR6D0XKI2PBAaYojE0kx9mQfDWEFLoi1cT4CSo8fmlw3tYVOK2LK93bngblZWQS
         puVBY89WVT3EBa4ZsImZAlqswCatN+B4aSpijA8MMYiQhOgzitqB6HeRFmphztkYRttq
         cB3LxU38wq91G7dx3InvbXV/swPCMe1+oIogRA76YObxyc30FOwhv7vMrC5ZhR4hZ0lb
         caH/qoHRWncV3rjhYWE2e7qkg2wji3oibap54Vi8FeJ3DzNxbRfwqyaa3aR1M3SChQqp
         qKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001343; x=1758606143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DPf9GY80lnpMXx7381cdrBChaqI4wIuCjM7QR2i8T8=;
        b=PnDyu6AQK73OCk6XrDKohkZABEdPRyWAaZFPnijqi5yZ6oyGaa4cd5C13UsqFWhsww
         /hy1Kg/Oxc8N9RltGL/1pjasl2Wc8ck/B8A3/9mEMSjH+oLbltMapipnR7YKfGHBywnV
         gISf2ffRymCWFSM7GgxLRIDyyVuA1OEQYIKupuIGh1hT4tN9MldFsN7tHEhAPLtIFcQu
         AEgP3cMNgl/xTx6Et+XTxgZohlCpD3cONpyDDFbp3UOLWh2HsAkyQnjUhEO1qcr+CaO6
         Qe0q2lgoIXlxUaW92+YVcBx6U+Zc6n2LatpAPKiChCrL2eH/4LWP7H4r0JIoyRSDG73M
         qPCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBu+GqNG0V/uDYtGPE4aBUiLO/EsUhIxN+0mbGlLP8pliXqHraO1mSw3MMEaaX/V/gmTyydj70y8PibIUJA/J0vNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NedqwPJ8g31I47CDNIHFBuUiR/a3Xx8WvouNItkJr+d05g+A
	KoIQ6h0m7NInlg53njPlNImHtVEPQFwU5FPWot+SyLHw9KV5tbIuVfUF
X-Gm-Gg: ASbGncsjPsIf92M9pWPAo36oJwIQfCIaGjag8hp/MS3BdXAeR+MN+lngZ91XRQ9yfef
	xqxsj8zyOXSh4YnmktmYKZea6AFc8CHYo291CsG1GyHMJOtcnWdjY5LHT0EfWPXKxycDtTXUPxJ
	khEh7qKPiAtiHPnitmOTuKe2qvW3pKLYyE3NI7HhuUrbRnBnf/0ntX35wVlWIWB15Ecpyy96H5a
	+TlY18SNInD1cF2kP8dXALisif3l7Gle8XD8MbZVLqRi1eOwdnWGcB3l+TocL0PkSH5ZHOrdlQL
	6Tli6134vAAvLEF8r/h0gNRM2Uwof3qE7NB2mt50abEXSDV5liQgf7e5p6opUJOrqb1qydBB69R
	oV4CD5dMrgozupchFzy5CJ8efHw==
X-Google-Smtp-Source: AGHT+IGjod8lqjLaEANJx/f3tL+YzsyYDJl9LPFcu3JZwKlmcwWUqkWf82sUbluRqo8+bR8l8AKKKw==
X-Received: by 2002:a17:902:e5d2:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-25d24bb34c6mr224282945ad.19.1758001343029;
        Mon, 15 Sep 2025 22:42:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267d4d45427sm5867495ad.147.2025.09.15.22.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 741414227235; Tue, 16 Sep 2025 12:42:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 3/5] Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram
Date: Tue, 16 Sep 2025 12:42:01 +0700
Message-ID: <20250916054202.582074-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=bagasdotme@gmail.com; h=from:subject; bh=IM0I2qOotzNuT503Elh5AFKW881D8AA0LxYsvx+eLpo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfphxGN/7ULjEouzlt4szEw/k37Flv/6dZ63ARYX5Y ot85Ho3dpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiUWKMDJs52NIrfC1VFE8w xNt+yFR7KRVl6JGkdfB9y2+2HQrvYhgZJi62L+duSouZsfq5xTLb6Xo7QtkrNi5drHSFcaebxdT 3LAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Section heading for sched_waking histogram is shown as normal paragraph
instead due to codeblock marker for the following diagram being in the
same line as the section underline. Separate them.

Fixes: daceabf1b494 ("tracing/doc: Fix ascii-art in histogram-design.rst")
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram-design.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 231a12bd7d461c..4faff1669b77bd 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -380,7 +380,9 @@ entry, ts0, corresponding to the ts0 variable in the sched_waking
 trigger above.
 
 sched_waking histogram
-----------------------::
+----------------------
+
+.. code-block::
 
   +------------------+
   | hist_data        |<-------------------------------------------------------+
-- 
An old man doll... just what I always wanted! - Clara

