Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032916;
	b=4zxhpAFtJp5fdizMSZST7NcdIU3nxgE9WcKG5m9LjVRjFire7enAx7KgTwtcZAK82h+/
	 A2jUT8WRE8FVTptcRvjeCyBxewJfxFufToaPW0UNRj0k/MrRwnKhpB4xJXFHIDCBoaoff
	 0xawYbf3S5FTyaPQJeuwAqUd5ePR6eVUQKGhC/5QbL0Lx9wrvFmA5SpjIvwi6CnwzT6Nk
	 cHFpiqlT3VJCyzasso1KPsavNlPLQLk/tdRCuwV7OnWYdOf6vdv6oL4Ikjp5t8r69Lwq8
	 ho0BYgzy/oVzbIa+LzWVETfycMTRrnqe2eJSI3a+T83c54biRFA0XvfhgCLNjPHPqDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y3fAM8CU6fD90S4RyczeRFzjWR9lUGI2XBHnFrKKF58=;
	b=YXJGg2eZ3LC7qeon71+SU2a7Pwa38WQhy2nl4Q8Dr+CcJIKznndAbwVRB+577xGi9O00
	 u6iyYzyZXMwRhQwgMt0FM7A1bgIu/IJnRZAyw1a3EYJt/MfN1jpOksnae2jlRUpCdvb0v
	 FdgdAomK2eIFbQBnrGZi2U5Ip5GvISkGqaHXiI6P/qxsIApN5Z1V3O5cUHY+io9L5Z+p1
	 XX4UnDUcwz0XaZ9CspZBEe0/vZ7YZixbEROkF6kFJEZU6fDWJIpLBpCMYaSTop8u7GM29
	 rlwrj1SQNsVIKxDcDa9+GoFJLbQMgBdwg83Biwmfs2JBKNDvGnWrMQgHRZns21smLSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q7zAdbIM;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673E606A326
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 06:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B673E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q7zAdbIM
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e95bd1c14cso12274825ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 22:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032915; x=1794637715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3fAM8CU6fD90S4RyczeRFzjWR9lUGI2XBHnFrKKF58=;
        b=q7zAdbIMkptkkFDlti+X0Wa3Z7jrU9yPPQq01Q6EArrGJ2FUruaEi2/1Hp2EAL3kxQ
         wlCSarsWFfQBdr+E/M1M2GuzcHs3bSNPxaVNvjVtR8liPd94qpR9QNhpXCPMp6f09303
         R1vvI+zoW1cfUaINREvos2TpRr/2Z7V1KU384BWTN06fRKzaHhyvoafscuu1BhDADMzV
         OpvtKi8Jp2w2059j2Y6IosLTQ/VNsRZBTzo+3IRLAl9f00RVaPEwifvmkr2GGinN7cBF
         xI+Am02u0eh/k+AL7FOB7AaXury6qLrh+eqASjK6cEYk/PrVXeZ1Hp1a2d6iB61RWoSW
         uH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032915; x=1794637715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y3fAM8CU6fD90S4RyczeRFzjWR9lUGI2XBHnFrKKF58=;
        b=ayv6PQD4Jgf1c1/zMHbhfBzgtoW26wSp4mpc58UgWhA3ySfdkg7arVjaDfecJXmas8
         JQwOr2WMTeA10P1RLAAqCwhk+z7kvjOQMQ7+HoSH+DJinnJTszKibK6+wBsHMR465a2S
         Yv9NZCgRER3kmoPHUBLnucFyesmX624cI3wNeduRYVmMM1ZeAyaRQ/RFHLyMAo2ctWrr
         hYjr90XWhdzcAX2XNWiQLNtSAhRwWGG78GjNtAdnnxwvOGal/Uzsu91cHbij7O3ah/2d
         5UFeQysubuIxOISzFUHwnSC6tM9aDeCMIJs5eDqW/3Q2U9+lYf9/5dWIZM2q0YrnR6rO
         IDHw==
X-Forwarded-Encrypted: i=1; AL+hErEK69ANk8KkvAMyDrAio0/dC1xCAv9LjKw9R88ASLV7t/LSwPcX06uaAOUi+W9fVcxohSfIM4zYdXFfRBhYlbqiFdc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ne/FLaYBaGsM+xUkgzJVnmKE9E+w5NwNeK4umFlPZ2YstuyLp
	M96O+W84ZHTEAHVm+fqjoYrMEo3m7G7MFsTPH3elH4p2316ERH+gFWJA
X-Gm-Gg: AYBFou3TcRLgZNKtB5rN9ylF9xpr1k7MQr1DZ+48SPbS2/z+foKSeV9iqDrc9NsG9Y5
	VlWHJ2y1xx1z2zUuNAyjs/XUfLmp5c1cFgN8paRalndGOzImIs79OMj9pfPyFbWgw44rVUNpCqe
	hyqoM4YoWcDHjJ/NAt0Rtrxkgqhq2CGbnWq+ngR1QtTwsPTvcKxnQr1hwldTeWr0xG6chgnJbWn
	j9Wh7eX71IxltetVAy5Am+ywYIxHIlBA+NN1pilfwhy8nO2xq58dcW+LC/2K3MyeanzKS7CAmAH
	EESEug+yheFN1uKyusAxbzAG1CnRvEQn/rHsbSuGmcsXuzkAo4mVHenqiRG0vkHI+/2R5cO4M47
	txC/YOKfkPDrlTl+2H2rgIK69e9T2z7QgLT/xeaUw+UL+LLLUhDf4lUrSkMHguWJhPT3JeNhJFv
	R3+1FgXJKpzUDAp6SFj/abSjhZ9VsFtGrP94x8P8b1HVbx1TYmp9a9y/1Z3srnRQmRe/fBBlloh
	xrgCBQXnAaY4bVimFD67cvhe+dh4L9lTfQvlAUbyAqHJo+6aB6ztJ2MLfNJjby2jVojFcmirekr
	bAyDfepprfu9VW2ia6vjI0guV4hAZs90fZhHa41zQBJolvYMjFG0NZQAbN87lWpnTkcOgg==
X-Received: by 2002:a17:902:e80f:b0:2ed:3ca1:848d with SMTP id d9443c01a7336-2ed40c17e5emr56027075ad.25.1794032915018;
        Fri, 06 Nov 2026 22:28:35 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47da3e33sm11176045ad.76.2026.11.06.22.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:28:34 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [PATCH v8 3/5] tracing: Add stackmap statistics interface
Date: Sat,  7 Nov 2026 14:28:05 +0800
Message-Id: <20261107062805.3361142-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-202646@kernel.org>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com> <20261107055139.3138633-4-lipengfei28@xiaomi.com> <sashiko-outbox-202646@kernel.org>
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

On Sat, 07 Nov 2026 06:04:59 +0000, sashiko-bot@kernel.org wrote:

> Can ftrace_stackmap_get_cookie() undercount smap->fallbacks when the
> element pool runs out during a concurrent insert?

Yes. The slot left without an element makes later lookups of that stack
take the "insert in progress" exit, so they are recorded in full but not
counted. It only happens once the pool is exhausted, when fallbacks is
already non-zero, so the counter still shows that the map is full; it
just reads low. The next version counts that case as a fallback.

Thanks,
Pengfei Li
