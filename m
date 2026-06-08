Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AC3C345B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927325; cv=none; b=OE2uTs7thqb94P3+JFucFTw+GV63OOBeiaUntjv4AKuMBOQSYte61SOhiozgVl7FotnSXqKs1u2sxscnYU+cQfuQK1m0wH0+CTMmjgia/Vz6OQUjxrblkgTLv4meQfGXN7cLPhadIPhMFRgsCGkgvk2y27JkmnMr1/3yVP7GZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927325; c=relaxed/simple;
	bh=dQjT7rzCNeu/bg/vQvbwRqW8olT3j6SyfomzRT28F88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkJaTQ6HyVqZXi5fXQcPSkY3zPMPuzUo5RUJOFmkIv068gnw+bv+hfkWuWK4lxWcm4jzwk1tWvUUr+OlmbwM8Jx0p69kB4coXbcJxZvmo3VmfrDKu3GDjJVOLkunpC44WA+Mc2y8JrSe/gZMGe3KjeFQgcz6MMMnrILuhQ5SH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNiFND76; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNiFND76"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c3546924so28133735ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927322; x=1781532122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQjT7rzCNeu/bg/vQvbwRqW8olT3j6SyfomzRT28F88=;
        b=PNiFND76CbguWnBedD2u96WLxGyxhjcgVjTpj9MDLaVgaPS2NiO7qV4u+aMf1ffhe5
         LxX76cIlwOf2OfutfLJjKnI8hAR/3OoR6t0H1HShzpiLrc2K1SHlUivvMKy21Te6X9sY
         clbDvJQzGW3vb9Jbwkx39Z4DJ5GT4wjDZGFs13rXMG8JPhjwQcpAw/vtNnqS+xR9gPnp
         NdJj3jILT25ALgXpdh86n03ntKZKhUMmSqq7cR4Cv6Stx6Ej3paqeS5oU/m1z5iW2skP
         bivyNwkA4MiipuTcttujBzp5x5P2lOqGXvjBgr6SzFTvqbN6o9sFTOHKF9AsslD9zbZj
         zczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927322; x=1781532122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQjT7rzCNeu/bg/vQvbwRqW8olT3j6SyfomzRT28F88=;
        b=f+QoWTDogMxnII2QhPoSKizgTjQ8jZvwzDB4QlQQiWdj61bAmEfAC4KNDXJs/zPV78
         2xR3Jt0RCqNnvGQO390QU3huaR/9H5Yuz4/0BqVw+BQPpQ5k21oxDf7R/jxtD9fOfvZo
         goOjcYuOsAm7nr/zseCzP+FkD5AVzUQIDzoQua5qx62R7aoDoiykHJDGmVDHRZL8qoV0
         CIxNkj9EcPeU28kgyLzsq6wF+n8fiJaroyyC3oxXfBBdtBYQ1CgHUkzi5ws8n4mIspqu
         jHD42olU3jcGk93NgxVxf1e8RQ/HMGp9rJCnPD0QaS6whRXenkXyVFUbVi4/uQMpdMad
         N3/w==
X-Gm-Message-State: AOJu0Yz0xXaVcSD81E49Jb1jgEgFxaINsSRrC/BVBjHiXjV6Sfp8rGBJ
	LrEamilci3iNFucWq39zF5YvKbtSgiP2VKWYUhZBBY+WDWBRrzB63D7gCfmovFEweqA=
X-Gm-Gg: Acq92OGma210rNhG8m3RCklpLu7seqCTM2+iA4HszfXfbFqsr4zIHHPJoGDNxzCf8OJ
	WFzHy/60eks0z9NH+BZj42i6dhRSuGmVffLYTc06n1ISQKFXRMx/Iq7cmKT2beqzR3h/JV44gfv
	IhnUqWxSUh0k8wWXFesqayX6g00bJfiv4V9gGaQnWa8Zs6QgHDY8o7KtG3WnPwPG3qNBnxvWtaF
	ybrrIw5G5fkjDYabk+TUqtcrU2yWTgsVZUsBWKfpFdAQGmEERgAqa/w8Lk5YVWXBR9xyHI+d4Vg
	ElQT743aWM6UFB30UdaRTKJJ/P9zX7nL3mINzRR1n/YVrW4cWwUDkvFwYl8mbkhlanXIhkJyNWx
	tFpO/cSin0RSgEYdjbvgzAXnQowV4sXzF7V59va2945a8KwgsURkA7lWCvWtha2IZhX7r8pHGmi
	V3hWuJjYDJ9rDgA7WNLIXgfpSptjicf8ILV4+2KZG6U13XRvvU5DaQlso=
X-Received: by 2002:a17:903:4b28:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2c1e89579ccmr161784115ad.35.1780927322171;
        Mon, 08 Jun 2026 07:02:02 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([106.51.251.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm185529645ad.51.2026.06.08.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:02:01 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	glider@google.com,
	nogikh@google.com,
	mathieu.desnoyers@efficios.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Write in ring_buffer_read_page
Date: Mon,  8 Jun 2026 19:31:55 +0530
Message-ID: <20260608140156.136897-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAG_fn=WVfi9=M8VjJQt8jCpXf-0D30-BQDCZZM+FX_0d8V+yhA@mail.gmail.com>
References: <CAG_fn=WVfi9=M8VjJQt8jCpXf-0D30-BQDCZZM+FX_0d8V+yhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


From syzbot initial report, I noticed that
ring_buffer_read_page() checks data_page->order against
buffer->subbuf_order , whereas in while
ring_buffer_subbuf_order_set() updates subbuf_size before
replacing the old pages. I think this allows reader to
use older spare page while observing a newer sub-buffer size.

That could explain the report (KASAN UAF, memset of 16308
bytes order 2 into an order 0 spare), while the AI
reproducer may hit a related race later in via copy_to_user()
tracing_buffers_read().

Before spending more time on a fix, does this sound
correct, or i am missing something in between?

Sincerely,
Yash Suthar
