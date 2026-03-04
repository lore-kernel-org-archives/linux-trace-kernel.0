Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F749364946
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595254; cv=none; b=la4sbNs8MsyrrQRxGoa8xMfU+2n0S69ck0i3bbGO1y82JWPXxPJqtWQITJV4AfSJhL79Rtww/bYp8LII0voi1TQ/8x5t0Ov2QS4mb0ElbaVkzkQLveISwUc4NOPzIUecTMGHFKbCcI2NxidPW8tlOFy2H4LMU+ZqWJiA/nsIJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595254; c=relaxed/simple;
	bh=qTZPgwQFfZF726H2LsPRAZjxMzMORAsQg3BbKIyncXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsliYnR+LntpKOBzQip9yERwAGExDERDeromoOYAuoZUNUJDqodtfGRrpZFvSN2X0ZUTEfphU6pX0t67tC+c47Iz2owROFEHDH0IhHg3wtATIHps5XUEQRmq03w0a+ls6anjf1QNQwlld128rzR5tf4iXI+CSt+4Jtkh/mx0LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bloeOm4E; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bloeOm4E"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48371bb515eso95708795e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 19:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595252; x=1773200052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VhA+A0/NyLxM6CBEmmYDuFUudcfDtb7OxH4QUWLpnc=;
        b=bloeOm4E79dDRogp+SDtf2SvOsQnyEGMGZ4hW7xv2AVagVIBzfkKqVBN9kVrGPcg6L
         5J34TmjiC/fOOOX9sgV2C6EdfBTJG5at7iVV/pNYNijrEfWE6gPnpTa1LW7aMW2Q/r9m
         tJ2QMUkYvBZT4mUaJGFaUESFa+U8VkIRSBp3Jj5lPX0h4x/mRW8v19XVVvOY5HvSIe/d
         jPB4adVjuAn/2TGbwmszNfxkXhScpD/f7MLXzZYr+a+OtfS+ykgC+GQCJpEAXucmqju4
         S4vqhl5rUb0/NRhz5EaWAsBaZfwxiHt9IeO1T/l6N/A0C9Zt24Xv0q7aLS5O9DtsOe2o
         41LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595252; x=1773200052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VhA+A0/NyLxM6CBEmmYDuFUudcfDtb7OxH4QUWLpnc=;
        b=F61WU+O1EEcNU6BBVAWX+d5ht6HyjKO8vBi1/CBusRL71SbPSeTpM7TiS+3E/Gch9C
         k1oBxjuI2E03IZi6iBb/F9w3yaVihfzM+zNG53laStlNdvr5Me2PFTMdwW75EUICbtWd
         O79EBCG93wKQnnWahVGA365JSQ7pkIBz+77RDzjZ6nDOeWpHAZkjA0tztuntd0HY6mtk
         RTKaXq0vZS7dqfdDEr1AX7r4wkajXw82VJJm0Fm1aRXws/jAwwfP9BspsyuvShZoE0Pv
         5CYuAI8BAjZehjXf4supWeX2EVHMpQ6fF78IYt49x8EGsXWx9K02eZlgCoiW0x39IGff
         dPlg==
X-Forwarded-Encrypted: i=1; AJvYcCXWL9eFZ2+u3HNQJtYJuV1azBhDUiTu0Z6KRElJdJQRulREMNbCR9rs1uaJEDkcZj3WLGq5rV0Lqa7CLFEUdv/87Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WjG02dQSXKCQsfD2w8xcD5N0aBTjTBCWg1BNNBVJB90okp73
	e4VbruGGfLslAqk0/5w90mnKGnoDhCn27QitCnOGn554D+/MTFhKG9Pd
X-Gm-Gg: ATEYQzyEB/wbuaUpV3pzgXKIZyupQpbphQ3iPu9LOBExYR07E7NUeG2h2MYJf2qjDLs
	OvUqtJwl5L5/8D2TU/T26nN56B2zB/WZbsNnGELgbckOgvMP4tAiRa3dZnTUY2U8L57QC/qS2Oi
	TexjDn1HPpOh6/zox4DcmhP7hir+dcbQ/KasyWUFstuSBPXUK83HZdDzfNYi0e3siF8uQ81ZHN8
	VRLODTBqz5+iz5KDNzI0XvGNAolW+DnBSB9ReYPy6dftD1e65pMuOHO49hs/blvZo19LYpAZ7DM
	w8PwWih97Iss0ayiObqUI4p+0ci+dWpceTiNj64iqfQvro8iqkYl2AEtvnZF1ROlKVaC+K4Vbk9
	8ZsJCrjNaweJ7x4MxJlKS2bhSPlvNP5hLoqzNghwJR/OMiOhbnp6gYWjSktZ4087xCPOavubtZK
	N4GM+Zd+pKZE88fXdifFM0QPY/qk5aR97IKy3jjCM5Jgim7SZVoCTquwOhV+PR
X-Received: by 2002:a05:600c:1d06:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-4851983c5fdmr7534685e9.2.1772595251618;
        Tue, 03 Mar 2026 19:34:11 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm23654265f8f.2.2026.03.03.19.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:34:11 -0800 (PST)
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
Date: Wed,  4 Mar 2026 11:33:57 +0800
Message-Id: <20260304033357.105915-1-wangqing7171@gmail.com>
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
