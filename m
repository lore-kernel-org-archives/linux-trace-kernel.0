Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A434E74B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609190; cv=none; b=mW9mO8jjuaKLuP2+m97reW8Xikrad1N/Spu1ZD3CQkSjx1XxpmAM7UkE8+2V1d9n0xhM11qRiwXMAqbW6U9zJI6j3juv0vZYOpACmmMG9ZlE1BMZ5bqVSsRBfsNcb8m0c/wzepC3W3IfsQmkSBzIk3lyOyUgPeYxVArOE6p7G1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609190; c=relaxed/simple;
	bh=8MaJNyR191CxvKCR93XU24t6Fvj192M1OImBTqOldyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a76qHc21d/AWfex0tx8/99+G9gEJEE9dLI2fmPMb/fqhUOW1TBbpdfizSDPpfrpvbY+063BdCoQb8+jnl/9ilEh7mTqyIWas0iYn8rHRXpAI7WCRSRpd2OO3gW7l7SZCgV4fgLwRMZfWZ5ggJinIyRRn9oO6zfOr/Se8bAItJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1V4Seib; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1V4Seib"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-829759ca646so93792b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 23:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772609187; x=1773213987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=N1V4Seibkan/HhSdngD92EXhIC7OxQ3Lyu/Bg4XJ78nz3Qh/F7jnAe96MQOh00B0tA
         8Tb812uVhs7t+XlUHi9abcULtLKt7rvSJXwr5XebgvcVqtFXLEAbTVxDZ9sVLMyJI1Z2
         KndGfu0ZEuupEWRtv6zBhll9XV82Wk6ItAPU0nGkt13+ezwYbtM+5YUwnhCoqzYsjWdC
         Q1SGrozd/kQcVhL3BfJM9Iv9Vh4tyABzBxKUT/JnNGuh104YBwy4pTQ0unHBTLhXrjRU
         +OEXehLJmQXJPx4ZLdA2KJowRNFMXSv2tvmeHDoaf2U8MnOGneQRLIP82dSWiTT8S0Ll
         GD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609187; x=1773213987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=XhXFkqrBZPaf4gIuTuZYoVaLBGck610YjTjf2vgVlyVcfx2B081JCQ0iP5DGww/x7p
         zV/KwW10dzRpU/qazU9P9d5yp7e37J9axHLXdYdBZKdRSaX5CYg3jv9Bj0rzBIYdHgwP
         cC+tsgsM8Rg51KVQCT3dfFbNIAnGzN7UANVIuWXri67i4E0F1VLmE0d9piGnXByKd62o
         nerq8cSlw+PFlQ4B0frOG75V+5gtrl3vk5lrvTFwXKb3bnpgke0JivEhBWQLCS6nKt1h
         nZ+nZ5czOG3R46RxA0ZjaIUhTKh9qd9fDmgV4qcINJzsyZ7y1LsbtFhzLeNbxt1PtsT3
         XEuA==
X-Forwarded-Encrypted: i=1; AJvYcCV6LeGznpGrML6co/dRkQLba57Z4BjKftjT3E8CdhdWaKk0vB1DIvuAz3jk8+osHJn64zi/jWGAHT8VX7rww71AtSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OKmHexeFwOjfwazYW+ME9M4h4M6uwCcTOQWvCONPU+XdG2ZZ
	bsCZx8uq90pzJfg0UlMmbYAdLj0yhoreWm7DXSBfzMpUGBS5TVPPei4v
X-Gm-Gg: ATEYQzwyGiQ/Gb09rKXohOQIQffHyURSroA/ue/O/zWe3DpBMRc5zIAJmsHxrRwOeoW
	mopdJZA91LUyB7fKWgm9zu9DNPVlXbramaqbIFBKee3X5VJLAIQnW9L6+4bT333xgQw9945XGKZ
	qd1TGPpjfYSOdhmn0SRak+8YzP3byVjTXNaJB0JUafNyALFQDirTEvJLmUQQulaVoAwH+17MMfo
	PAbmyyc6/HdzYiGfnDiJDUP/Vz3X42vNNFgAfR8dcmYRClJh0jJPlVJhWqmTlPU2qB3Wjf+slMH
	Q3QmHMKH+AGGA1Df52MLl0htiPFouVrFwBTF6zFrTq8N0ZIY3MtFF8/eNeabCTSBGloVhVzkjZ3
	tOxTBh+1YlFGml1yEufh7l4XGNTYEfb6Cf+k34KI2Xk++PO5Nf3yl9c+CmNZVJq7lKcg1gwY/dm
	buKWn2X26730ChDf87D/q8GqA7i+zKIkNXgVenL/tuHNjw7VD1nA==
X-Received: by 2002:a05:6a21:1f88:b0:394:5721:591b with SMTP id adf61e73a8af0-3982e19b2demr1068798637.39.1772609187532;
        Tue, 03 Mar 2026 23:26:27 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c737d395271sm654989a12.19.2026.03.03.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:26:27 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	wangqing7171@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Wed,  4 Mar 2026 15:26:16 +0800
Message-Id: <20260304072616.185060-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a3e5ad.050a0220.3a55be.0056.GAE@google.com>
References: <69a3e5ad.050a0220.3a55be.0056.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0378e83b4099..b1e3e9f59930 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	tracepoint_synchronize_unregister();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
