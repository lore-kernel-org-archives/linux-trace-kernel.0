Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E131F1316
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330008; cv=none; b=cE/bNOipGLiker6BhYmli8DEm6pJSEuicwHj/c4jypeQIc4c9PN/D0np1h1t6orITi6D3PIjGD5NSwCnN49BhAbh5+j+3+UwKi5T+N5vxlLi56CdoKM1HyV1S8iuRtpxaCk+4koLOM/3eMmrZW7ZCKp4a1k0jd/qB17GEc6/pI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330008; c=relaxed/simple;
	bh=YLqX/28N5thdvuWAhBCT6xbYIfwdHgRjjlYUHnZfPww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rgFoNNQUhaWXZgKOga//jyE7GXSsju8uthkdXR5hdv9jFhEgxiYXexZARCVywmh3aSWPpmVZO30/Kfdvx5sc0ZHHDS8ihgw8TPhSRi56GAtGJPfU0omgLY11/A/DeqtAdzuWboib52g45Fekkn7UnZLR/oNRaQw2d8JtMXD6CTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cbOP1qWm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cbOP1qWm"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so36845b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330006; x=1733934806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HFpbZOKpkO7AeS8bDe3st3+sWFuj7iai+TcTZhQd9c=;
        b=cbOP1qWmavkAFYTjIGGtxmICesXawjm7Tw0HYbCU1e44Cjsq1mwqI9RYGBfu4ZdzCK
         etKRraOqeFHs+Ev7wG0NXqYDvsRggihA2pOCYbBGpiJviaXUzVZmna5PzJxDURJv+Cm7
         5Xvk9nJxjTGRomDor9qKlDvik1uEDVH1o8ZsiaeKN5p8J/oyplIlNkbF5iX7vdlw2FOF
         DxeKZo2qOalyVhtPNcerN3p9rSaWa517MC2NdiNs5wmvWOoIjmX8enlrB2XluUmce7PB
         zjdgkdN25dDPEYQ9iH4uN90fOFkmqKuhbeTqYDPD/tT5+20PN3jNwbfzMa/vZs79YmSa
         6epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330006; x=1733934806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HFpbZOKpkO7AeS8bDe3st3+sWFuj7iai+TcTZhQd9c=;
        b=DwB+wUYf4mk/iGyLRpIVhoyV/ctK6Nmmr0GoukuzAmbVo3jGTUq5B7hT2ZTGTckxe3
         cYvu+81Qjch0pFSq2zbyfb0Gc0pmUP7qUM3M1M71gdrlbA7o90Y2hw5Yu8otWDYDAS/H
         ldhQGwTqlbQg8QxQqDyFLzgzTitZtZhrfAAFDfW9qEEUbrYDMIHgPMhJjgpmMz4LQkiG
         dWNMmKep+uyzHvwWwWZ1tPlc23PVKpHCTjJZLdxcGPiRqpYWFjFuXurdD5fD6rrcxsiC
         U8zndiXOVYfMf0ggnG2zkbiJ3+8mZ7XpP36y11Nn055rh3RTkZhuUAQjtbcAVC5nKmJZ
         r98w==
X-Forwarded-Encrypted: i=1; AJvYcCUUEEwwEggldtBGlCpDXecKDwi5FcqaH1WW/saN6GiShzxJesZJCyFtHLC75FUdOU0ohDABCXQOWrlmGpQV0vzKig8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuqcEdL/I14KbobzRr5eBPEfWEQ2Qr3G1NCOMUzG6T1ElPi6Rx
	n/sOMjQHe7c61C0TX1GYWM17gGUWbW+FuF/ijhYOgcLx4iD/VUGY43iH2OEHuFE=
X-Gm-Gg: ASbGnctQw/uP9DbluE8ZjZr5oo/RXFHKDBRR6+BRekJRUnLEg75jcdpnN2WBC7+Wcr8
	aDr0FNILC+Gds+8MKD4q8TVErg8uO2VWJdpkEs3P51noQFjuwI86Jm1YPwEgwhZiuQeO/3y7lue
	6DV66VGYBuVrWM68V+MvrLFyQ26sRwzB5w+6pfjVvsgF/V9UnAEGUbfnYoknV7slSNIsMTxBr3r
	4vBRynMRV2O4olJAjT0heL1jNbIAQ==
X-Google-Smtp-Source: AGHT+IHGetUSTLBEO7g1Mr54/8uXPJm1zbpOiVPZj2JidglSRGFFA2sX/e54bN5zcvRXs+5U75O04g==
X-Received: by 2002:a05:6a00:995:b0:725:2b93:3583 with SMTP id d2e1a72fcca58-7257fcbc006mr8373190b3a.21.1733330005713;
        Wed, 04 Dec 2024 08:33:25 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184952csm12955492b3a.185.2024.12.04.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:33:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204150450.399005-1-colin.i.king@gmail.com>
References: <20241204150450.399005-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] blktrace: remove redundant return at end of
 function
Message-Id: <173333000444.511414.17569005007152720429.b4-ty@kernel.dk>
Date: Wed, 04 Dec 2024 09:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 04 Dec 2024 15:04:50 +0000, Colin Ian King wrote:
> A recent change added return 0 before an existing return statement
> at the end of function blk_trace_setup. The final return is now
> redundant, so remove it.
> 
> Fixes: 64d124798244 ("blktrace: move copy_[to|from]_user() out of ->debugfs_lock")
> 
> 
> [...]

Applied, thanks!

[1/1] blktrace: remove redundant return at end of function
      commit: 62047e8946da6269cf9bcec578298dd194ee4b7f

Best regards,
-- 
Jens Axboe



