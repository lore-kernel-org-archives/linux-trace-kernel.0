Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04C48AE2E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853759; cv=none; b=rPjKRDvJhjhL0nLBsFxFgw4kqVTaq4NK9CUq2GtEnUpwl5Wfsgb1IgMIHh18IdRaa3eOmNjK7nDA3UlqNOsp1YJMvKKH9pZNpz5MvdSezUqlEikijM21irx6K3Vysg11InVul+ZfpgkXUHSujj5Qpxum7JUUvU476mQtEJg6kGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853759; c=relaxed/simple;
	bh=afPtjVszG169QH6km9gCzMGnB9TiIq5NUkjgJXxJDUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j6qFMBtERml9XkC1wfjIqTR4jqGPzhya1k7Ph8BN2AOrqECCEMuN0/mTdVmj89EFppIQT+txS2gZ4rIGiJ2ZPkhSibD2sbTRTIcmNcpVeYegHUquAhdE7R7L1wTLSx8pxDIPxEv1/+sxh1CdvfeijST8m8GIzCEThO/4ZM6YmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=dJmabCf2; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="dJmabCf2"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-439c00ed7e0so3560360fac.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778853753; x=1779458553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juyqAozJPA3kiT6vrGKXzyTGpJuBd6TpJcgmUOrO5k4=;
        b=dJmabCf2PiOsZv0sv4zyT/YWsEngce3vGvFov/s2UW9pwZkI6nG3oiDmTBhW5+fkuG
         MjaUjtoeM92+epZ2SpPolXffVsGUE264tfu5xuE1LGX6E8jFkR2o1g4dUtBSWXWeqBy4
         hW9IZFUX6dHV5+MUzFDjxTE0/HWS68/lzs2aEBMCq++IwvPZnZcyKOTjSR/e2iSouiHi
         /vVKyVmjoYWmJLBzVu75rbyqZEpeg/4Z7kjazYLQPXej5F0ZJi6bIzq/kdoWRtnrv1b9
         nq5PhzL43BtzIgPjofN34zt9rcVo6akMqhLO/wKZN7o3jVKch3SxzQB9xB5gdgqfuxtP
         Qhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853753; x=1779458553;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juyqAozJPA3kiT6vrGKXzyTGpJuBd6TpJcgmUOrO5k4=;
        b=YjWb4We5QfOQ7Za3Rj9md2XRM9iYKtf4RILP+heEb2r3f7n9Ze7eZWE8n8KDcs0X9G
         oyeWorTzbUirTAwciaN3NNfMXV/7/XTMQZd4jH+sq7nuBea+RrWwYNL06rAqHKXnda4e
         URvrgiY9EE2IztFxTP7zAeINMJdPDsq/ob9anLkzg5EwV9F3OzsH74oquoQWqSqNjehX
         wpV3XFpQ5ZrLuQ/7Z+08QJivfkeJAw6jreY0OqPKQi8DOBFEQaTYbQu+m6mvWiBwhJYy
         8GeP5QCFaPcpzkvKxGGlBQIJIhG1drDkIUXenM4/Ba6eRJ9G36nE4TuLo9AD2o50nOHX
         ijGw==
X-Forwarded-Encrypted: i=1; AFNElJ+PbB/nK3FGrkzqX4tQ3thr2Tfa1F6ZSSYRWP6WsD1JEM6JR+Kn9+M8JTrJsTOENm9+NkbreNCB4GJ8zVunYIi3BXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqlWSNZsP0B86RsLT+C6XjhpugmrtU0hz9py5MheQgZQQC9jn
	GEjLopq91nFjLBYxC1M4QYaqWDtJbsH9sew02LvUPOhmezSa1DQSosqgSgiOp47V3DU=
X-Gm-Gg: Acq92OGLfoQk8lKg9HHVwd0i3SfcGLyxVpLbnrnPW8fXdutjP+jjVcU489zKtalLPlR
	DBP0QZup5GVtI8ITnCSrtFUM/CDcbhLPOaO72q7AumNAbZc09cGn9B6yfeD7rbD9+CYWbTxov2j
	TVYydNMjlmBgjjHHv0N2QY22PWY5SokbPae37GB7yv++7K8NdA5q2YLjT4FdpnhKQ1Qkun4jk08
	czhzkyMeDtL3i91uM+5qMnujlA3dLFdshs7kprDXxrHPM3O7YEe+rsNLSeiTxQ0DRqCMR4T0MnD
	DFZ6XIq4B/U8XAswCFuKBxIZ+261zerhSHVN5mF4V4yPt7HopopzZA+CMYxWDZDSpqJXrCqt/OU
	F7EMZ70RDcGcgh+O+rUrk8xx0ARZKRYViELbr5dmbrP2qNBBjhVP+cz8PCoiEUonhgOEG/srNs2
	rgeh8G4Cnkmxt1Vby1XIOaiaKbyQILNFON
X-Received: by 2002:a05:6871:3606:b0:43a:2320:8a29 with SMTP id 586e51a60fabf-43a2da085b8mr2687226fac.16.1778853753215;
        Fri, 15 May 2026 07:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4dcab3sm3990377fac.11.2026.05.15.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:02:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: io-uring@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20260515135903.2238731-1-vineeth@bitbyteword.org>
References: <20260515135903.2238731-1-vineeth@bitbyteword.org>
Subject: Re: (subset) [PATCH v3 01/11] io_uring: Use trace_call__##name()
 at guarded tracepoint call sites
Message-Id: <177885375208.726485.17873052916016595792.b4-ty@b4>
Date: Fri, 15 May 2026 08:02:32 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 15 May 2026 09:59:03 -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
> 
> [...]

Applied, thanks!

[01/11] io_uring: Use trace_call__##name() at guarded tracepoint call sites
        commit: cf9a29544a01ff818c7f0a01716dc5e48f8ad7b5

Best regards,
-- 
Jens Axboe



