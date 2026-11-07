Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030044;
	b=gKrKsHYNNm7fFURQmU48+fQYBJMWs3fSaU8izVoYBUFwonnS1PaGhDOv0dPx61mlQAOq
	 gyCZ77Sss/VJJm3McD1pw5ZIS7xQraTevJ0sQdpsyrWTla8EDsAs9oI/IYfH4EM0kPoao
	 +n0ped6RIJrnYzleEWERoOI4JBHJDgPTDMDozlFVN8bWYhG4kXHqkfTLSYNgPMOP9bOov
	 4ysPINN+88Z6VWtKhPLF6lmgq5UjpdWMDorMR4U4VhceMj5NL7XtTaVsqJEHvvuot8GRI
	 ZZUbjbYzD1AELIo+bJrvXwxEe0nICf63BCej7q7HnOe6lhW8MHeDjGPCO365mEhQrfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U+0pTkB3+MWRLSYz9PVlpdTWCZvpDF7n5p0vN/UixaA=;
	b=VqwcT+p8N0oRnFPyw4LmLT6T2o/pEPWTPPGeSf1ddwtQSEEK0oszXO0ZRTY2U7dNuJbx
	 XG6xFZGYFC6qKXTMB9tjzXGDznWXBkJvDoD8JIFIdmRSG6YGtrC3UW0FfQH8CynWYOTqz
	 c16WpzG6tef0rF26hZ73RlWwOgB6xrfykg+lO3+5bE7nvOPcSM+m4wl8vULYZwNaDPxsx
	 IN6JK1kTdbibRovB1GypP0hqz8uo9h3JbMILSk+31+6Qs9rig4J08nNH4JCOpojpsrCB5
	 /8CdQGL6me+ctA4vk5mdX+jqRnnDWyUKjlnHw3ak7mvRABH0VfagGNrCtaN9TNo7stg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MKKfBy8c;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC4606A32C
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 05:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DEC4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MKKfBy8c
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so676931a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 21:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030043; x=1794634843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+0pTkB3+MWRLSYz9PVlpdTWCZvpDF7n5p0vN/UixaA=;
        b=MKKfBy8cKXapsmlYd8GOwL/ZTCcezrUbWwB0OqF5FjEPGS3PRmlqS61fHiccoL9MGR
         jQiwSHoSjQrFn5Wj/D4vDaOSjN/+4kzY5aGKTHsXJqNOVuCf03zIoqsNt9WbLv4rdHTd
         af9JsvxOc8J/50gWAu624GSz6J2egf1JjB4hMsOt9wW2cZvQ67Hp1a58eo5GzX60furA
         R67LX83ZH5EEqS1hlkhpAoYzV0Yh+WmEQoOV/jYt9vxhervEObCUCHCwDg/CizKShOv9
         jhlKU4eegdoUpRYmGeZW78IIsijX8MRJgyxUiRaL4SJBukmYR7PaBr7bhkiOZ3veavyJ
         IZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030043; x=1794634843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+0pTkB3+MWRLSYz9PVlpdTWCZvpDF7n5p0vN/UixaA=;
        b=cBcbuBA7bP/tRBpGHceua0IDhauQ9E0S1rwTsrX3JLgkqpbaMBMnjt6a1fXJiSUbjR
         WuGVre/9uUnpIAKxsctE4up6aGp5x5WRqtDaXDZTI5JzcPJ6xNt7qrqvNNpSzilxjBmz
         wNzOxjPeJyWzfupbRAiflXwMFCkXqugeRYkJKe1X4vrmAsqWVgH5x98+DYoS7BRtZvJK
         siwDa5ORAduV670bExk7a0yZKN/lOTGC2rKWp50Qy1/0aUIXljaU2BRXrHHL4ZTy60aK
         Op7+kH6ZD76X4oR7SkmCuvp43bQXiyvdGsHMVSoM+evYxBEg46dQg3SRtF5T+uAhpU4i
         +r2Q==
X-Forwarded-Encrypted: i=1; AL+hErGuKnuCEhlh19jVaSWxBGO3LjAuaRz7G0dhPaCX3AVgLNpqoMuv/9VcSj/X5qk0l/bg/izdMAn2Y6nVmTanHPm1HCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z95+xlnmd+SgE/S31fzH34v0Oqr/tV9fSLi0Iz9isuZF1t0sAaY
	rveTzUxw7QQVJQ0ALSq3Ve+PzIgwTIufjNgKyhNSr/urCimwztdjPzqK
X-Gm-Gg: AYBFou38ewhvFuV82OltRzR1s9mAu0g5+LFgPuAUtvkht54JbZNasbmGypvbn94TWBa
	NfMrFmldFJUgp3Hi5j9KFvhD+56VilbZVOvhphP4Y6ipI/aaLtV3akixL3U0sPiO+kdJPpooZ+k
	Ad7okIydEdaFfH/B2ZJG5E9xyW7Uos5bzCvp658TS/AvgedGqr4TxrZBKcuJJXr9Srosa8pbOcI
	QBUIfqOfE5+H3ULOb61YFam6a0n3Zp10Ezd9tZ39SoFn6hWU5xk74587Kd+ALLGs8WwKp+UojOx
	dBUEmx5W0RONW4jgtNdoyrCsKyjP/plTWoVTRihg/gcFriApZzyScp2w1+eM6iqmfgZDiNYLnWt
	aNH5oeGDO9x8EgDiJZFC03p4sEBZwRPKwD8qPh3EoMRxlHy7KD87ZD1DpeX6xGOxtmXekev3Cxh
	jxy3M7FHuJD5vkh8FGcnjw2Fz7s/afDDCFmM0CTPWFwf1lDmeDoOz30lCyqwtCvn5bvy4OYT9Iv
	GhpQGSJDTg6ZJwTBKVZKpEtyiXO/N2qDmkmwFIk4xezn1991hV7JN7i9iylijbkw0DHn1wmTNbE
	1XBe+qgEOY2bPUEGVopaC4Dxr/9f5D5TY+pQlku+RhspHW5HW3QDIgp3iSDKPK5HaOmS9g==
X-Received: by 2002:a17:90b:39b0:b0:3b0:a757:e372 with SMTP id 98e67ed59e1d1-3b0db71a88amr4553467a91.47.1794030042944;
        Fri, 06 Nov 2026 21:40:42 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a0475sm1847682a91.0.2026.11.06.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:40:41 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v7 00/10] trace: stack trace deduplication for ftrace ring buffer
Date: Sat,  7 Nov 2026 13:40:23 +0800
Message-Id: <20261107054023.3077908-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103194429.739feafc@gandalf.local.home>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com> <20261013020321.1898006-1-lipengfei28@xiaomi.com> <20261103194429.739feafc@gandalf.local.home>
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

From: Pengfei Li <lipengfei28@xiaomi.com>

On Tue, 3 Nov 2026 19:44:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yeah, the cookie + generation looks like the best way forward.

Thanks, v8 uses that format.

v8 will be the core, the hookup into the stack recording path, the
statistics file, the documentation and the basic selftest, with your
comments on 01-03 addressed. The binary export will carry the generation
in its header, so I would like the core and the cookie format to settle
first; the binary export, its parser and the capacity boot parameter
will follow as a separate series. If you would rather have them in the
same series, I can include them.

So there is no need to look at 04-10 of v7.

Thanks,
Pengfei Li
