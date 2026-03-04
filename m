Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388D33DEFC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595525; cv=none; b=Mfl2ho1v2J8woi5OlzaNpMkg7j/+MZbVACNYBKpTqawp6bVGKCuP6HqZP1AJIYhockWnWTNPYIHNclBPJEQxhsew5X/IHgrmYcRuiJRotvht2zDbVrPowwexUFiAOGYiQjS85bq4enNYXQqqMMTzYyGVe22MODNPRv19IPK0YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595525; c=relaxed/simple;
	bh=8MaJNyR191CxvKCR93XU24t6Fvj192M1OImBTqOldyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9jUPdDEJSaq9JwVWOLxuxV1Xx6IA93bj87L/sbUaU1zjU/Befyun9h0Vj/MaFOu7Mp3Fj9P2d2ujWBngby3Oel6nYDTMl2JM5XFUhSg6Rze0co2MIPqIS1dIMW7wO8rbOOTg2J/15JZTIpiH4lLpNtMHBbDNq/SOSVPP+OC5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBV0hajB; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBV0hajB"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so48554845e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 19:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595517; x=1773200317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=CBV0hajBtlS7icQ1+wP9wj8rZ457M19CW0/iGR2Bx5AKLYrocDWBdn/fKYkrtcRlYg
         z+cPcXF0+6399h8xyYlpGWhs85iEWPYHAOJv5T/QQdbZxydRl+sAiv2Jo/Y6+y/uYRVh
         fYT7Ddvw58EYE+dyQHJD/jN0dv2izjOdtNbrFlo1pE+2y7+jRPWL6t1HI1NnITTbrBSp
         j1ZWv5fsHrMGO72TVZudM3D91BiDjAJJdFBivpdMBDdusyv2D9rcVfSKmvpOXfLphgVf
         fCLldsFETlK13OnYIGv8iLdkaGzvmw26dhiwu9vaIbt1bjS8pORtOaLN/lFZj/BejyJ9
         ZsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595517; x=1773200317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=vSb/E2915rh17hXSX4Ca5ytelVbYYZz8Ro/ZSmfxzTlaZZglbvcKYvcV0olVOrmNf3
         d3YBE0uhFqxE86P81udDJXXYLM5y3hyHdUXg16pU3Tvfz6V8UkKVlFGoj8nV1nVkBTdm
         41lAl4j8qTVHlOYB1bY2qKnklVWgPOB4lgypq9q9p7SeMA6hOZb5nkSh/kG4K7iT01kl
         EhVeVRfEbZN/9ZBus9Gq6NfyWT4t2h8f2vCT5mC2NCD7gYYd7OdMWdhCOdg93G+UsXY4
         J7lBZwUH3JRIvT0nzKFoDp+RYFGi0fD9pazjXi8R5gBQoqvX/sHEL4tSuvnMBo+Kw1nT
         oVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1WMfw1N5f15xnR+mamPLa2I9SYvxicUUN6TKtOFfy/SSUWjfobN8GthJbe6Wo0iq+u9jeezf4qIqM9QD+8eeSPAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcO4iquvnKpEwgiav+DtDuhCt76DwuLZSfITHC1cVMZjQmThm
	0ToOj2eZoUG89GjwUidSn4mF+o61S30ykUMcmWesChBjo1mOj251hMCD
X-Gm-Gg: ATEYQzySLIhBd4Kr+q9/NmiqApXi8twVecw3GYRyejNdxMmyy901PhELEjvgz1AXPF0
	eQPs1GTfoD0tul5yrcs5IGgSF+n63j8keTWGaN705IkBmSG2JeQgYzK0wSf/s8t20/8yrbffOHK
	3oXKHfXkOECGmYIFiBvO0SoHBeWLJ7L2nYhxQPN3+SVA2/ri3s0HQbFuAI6pRfvfbVhLyZLQjwt
	zUhUeyq9QETIcFDPuh7E4t3QCW6UwxsLRVw1pBzj1JvgQJm/XyuwnGEKaEAnRYWMmSR7URiTMk+
	lBTizL09qEARvyudO7P0K1ICQ01lKDpc32tKT0XTdP1IEHocoV2NCOlmojGQWEP+TAMpZ1bgQuM
	SC1OTSuQi1rd5K2XNieT2ieHoeK1OnXuF2xiJHO4w2DV83FjSnSKHU59f60tXlvERcRzFe35ehO
	/QXxDoc1CVItMwAqM8Uk3VpFIPqYE1k0nSWfLX+C1f3dNxu2R6Hg==
X-Received: by 2002:a05:600c:45c6:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-4851984b278mr8723645e9.13.1772595516894;
        Tue, 03 Mar 2026 19:38:36 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm26700792f8f.16.2026.03.03.19.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:38:36 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
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
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run9
Date: Wed,  4 Mar 2026 11:38:22 +0800
Message-Id: <20260304033822.107697-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a7276a.a70a0220.b118c.0011.GAE@google.com>
References: <69a7276a.a70a0220.b118c.0011.GAE@google.com>
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
