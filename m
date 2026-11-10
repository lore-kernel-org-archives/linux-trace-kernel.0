Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316846;
	b=EkOtD4NRvv3j2ipBZ/QwojrikrZ1Psm275VFqobTSPcaNnHyoEqBqZ5Y/6is0+w0LzaU
	 uNPIPdTOekkro4rvV3Tq/prL3MLBnDjgxMq7ut+R9Yaup5EIczw1Yv19PbU0G5N60Ne5F
	 hhHUO0wBZ8PqwStrq7CyjvGVrHqcjhbNwbwbQnlVFBjZvBX8ur1f9PFKtBMeCBdNB81yR
	 OG4GgLNFlHNo3Pf85s3938jbgDDQPKrk0qodJQG3mSC8FGhiGjDoQwedC1SjL6ASet8W3
	 UPCGSyBb07f/xeJCK/3O+qIyU/fT5YEbq92UHJTQnyL/sbP1wKiq7morovJ+/P7bzPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nOV6h0PZaqwHwVMl2GxvCHfQDmp289bzmQPwDxXJnZ0=;
	b=5iIRI4T8wzlI7CXJc2Relc2vwor0DsvkhkjQdZAn9tVoFxveBy7qttKZ5Qtb4aujuH4B
	 ODLlCPau/xVp7FiPyQC0VwZ5YypNEDeh7KsR8QMi+c0bT8PSXi9jJeoUuGduITTSkohA6
	 /MXCiByAl0/r69yRQgw3hcHZfm+W97boh9bbHkd2GL0htmv15j7d3kYJynXXJjcN9q7bs
	 EOuxcDHCSmhtiW3zTDuPEPCCYqpoPSzv1L4+6n9isZhD5sFLvBkCK66lhCvkRLIVTY54O
	 rp0oItw9XiOtpnIh7Y9XhFy/KTyYsyDjIGrOrjd0DGuCPAKjhgqb0WiwCaekhNCIs5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMfdCrHB;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CD60A6F4E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 13:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2CD60A6F4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMfdCrHB
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so27033845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316844; x=1794921644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nOV6h0PZaqwHwVMl2GxvCHfQDmp289bzmQPwDxXJnZ0=;
        b=VMfdCrHBw2dfp6abCT5rVeYVHN0aZKjAE8RDXt5VvgNtzo6LeoUbcNxkJjTkymNzLm
         fdHeygnzwD0bqmE7+K478UL3kPfaxtQ2NHMjNHV4ZezRWeDlLK9pEK7bsPSdGds88wq4
         KZSUinfmHGlcYgqCuC/e8j7qdy30r4XeOvsGDQRMzkFZhSH0++4Ik2S9rx991hw0a8tU
         YQQ8I+BoMK+fhwQFksgN5i0vTIQTWrfM/u4SZw43iZul0GfZkvsE0MuIORUcLFIZYZ8d
         qZfjDV0fcCp5N8OCRO3gb3KGNmG7nma0uKqRmhixoDK8WYv4H6AHJvJVweOSljthRDIF
         A26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316844; x=1794921644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nOV6h0PZaqwHwVMl2GxvCHfQDmp289bzmQPwDxXJnZ0=;
        b=mk7IO/iToaR5sbC8NV8kjmde1VOpRIvjVmmbpA6yl5ARO6cZ0T8hJ3cSPmCeXUkQRv
         QNbtIWDHeSDHSSBGjKqhMotW4G00lOFHMuqXF1CJ9SwvyszZmXxaWE9VfectXKjwC0hM
         DJdJIcT5SMv8O2d+Z4X8FLt09E2JJuPGcUgraqP0+qt/rZ9kFBu9YMDQeTXNEDigTxlF
         YAFFpNQXQlQZX15Yaf6cUkkFqCgWQ6soEg9Qijcvx02qY11nrd03pof82Fx+da8UTp/f
         kxvqUIDMlLmT2AhQnshgqavrSOIJ1D0Rx6/WrvoCU4ZavSNW+P+R1p469ktekneAKFwz
         Y0yg==
X-Forwarded-Encrypted: i=1; AL+hErHOYjALXbLLhcS9z4tqfRktxM6LiBo691f57HbtwtuWwU7hwtjzwVEjrEfyJCNQJlSxMMKomlXTh4yHRWjX70y7GNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+o+VXRGdwBDoot/y9TObseMZHoLJ44vekK85HQvYJVUG9R/xt/
	JqpZbVCjsMDnArCaYKVCECsbR+8PZpCxefrEOr/TKPug2lGOTwN6w/5b
X-Gm-Gg: AYBFou13Dlmz1ukaWpweN1Zv24msavP46ukHTzNIwruVTIQ475HedRtdf6Tx5cTniM1
	sHq5P/ERMTeBtNe2th8Ss0DaX8k2oIRh8wDw/+pF9opAr8PoLoD5KJdMa2EJQaVdyJ2a1HP4eMD
	dDlbD1TqWoMouw24wolhlgdpopAgPCC3fjLZyyN+ArN0vmgIxwMiSpAvWLLyOiQtDWZwACBJc3Y
	s0FrG5gDclRt6T6VVd+0I//e254bmDbpVTcma3XnTqTiYbA2NbcWvx+4mm3qz8tBBG9DSAXwgXP
	3fEveUPhUuXXRmFl7ANqxEiQ6uiziKJNWxZru7BY7DwlMiLcPxsc4yoB5qHmjSLIKe9RRUFVjS8
	cxrwTsVuv6LNZ2WlnGEW9v8aI5oj2jZl280UjeMCYWe5aProaKuJT3kzPNK4G3mjP+gd56nxZsX
	sjW5RpdCMXVJ+D3G5Tm40IBUI5TQt7g9x8na2R2rYGMO6SuKJFA3w271JFuP4g2IUB7rVGQoqbX
	uMG4D1nOqutXYA9OHsKPAvgvKG3MbRhyf55Bbr1DshLdh/v2zrreUIKJvxPRXZsggo27UBr3ob0
	LqY7sslEyM39q6vuO0d1eEyZgDc/fqxPHR4PhyEiFPw9tb3xukzwg8BYdl8MCwrv7lkrLix7VKz
	qT3+dVZA+bjlV3uuNijCxGsmJPNwFJm6sDU7nyTwd
X-Received: by 2002:a05:600c:1f87:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4ba023485ffmr42762735e9.19.1794316844000;
        Tue, 10 Nov 2026 05:20:44 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([197.45.135.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm5043287f8f.10.2026.11.10.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:43 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Temitope obabi <obabitemitope765@gmail.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
Date: Tue, 10 Nov 2026 15:20:07 +0200
Message-ID: <20261110132013.732-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sst_ipc_inbox_rdata tracepoint has had no callers since commit
970d299b0a0a ("ASoC: Intel: Remove unused code") removed the last one.

Tracepoints that are defined take up around 5K each, even if they are
not used. Remove this unused tracepoint.

Fixes: 970d299b0a0a ("ASoC: Intel: Remove unused code")
Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 include/trace/events/intel-sst.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/trace/events/intel-sst.h b/include/trace/events/intel-sst.h
index 0416e91f8181..ae7c269b0824 100644
--- a/include/trace/events/intel-sst.h
+++ b/include/trace/events/intel-sst.h
@@ -69,14 +69,6 @@ DECLARE_EVENT_CLASS(sst_ipc_mailbox,
 		(unsigned int)__entry->offset, (unsigned int)__entry->val)
 );
 
-DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_rdata,
-
-	TP_PROTO(unsigned int offset, unsigned int val),
-
-	TP_ARGS(offset, val)
-
-);
-
 DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_wdata,
 
 	TP_PROTO(unsigned int offset, unsigned int val),
-- 
2.53.0

