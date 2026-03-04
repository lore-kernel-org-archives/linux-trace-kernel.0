Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A813890FC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611680; cv=none; b=cJKe8tG5GhtggUMcJDJ0qcxHu6i7tVIrgw+HrMtHNYspOWn5tLCxIMGKbsmfcwtTy7phK5xZSCPBqHgup0SPstDCwLvXsvbnBUjz5m4ow5fnlPtUF3wyzZWtgGIzy3OMnayZ3Tsf4nQSiyLrWAG6VxfqfZcQ2Hi2KYPOLg8tCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611680; c=relaxed/simple;
	bh=hOeg8/gd726Tdq9mrgEBZ1rywC1S35GTZQRzN2uBWyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXCgQL2iKLWxMaueKmi0BPdEufPEazMaKdVRJvJ0Sepl9T7w2Bw3VahTjvA3OrJB1P+ncjFuoN1UqVNgbCkQb+e7QOSjIZfl3O11p6vWE/vdwskVa8E/YjsU4fHd2B62nZOYFFvLgpPM7qPfN+mOGAeHrH3x7etGoDNt2Pekjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL4LO+O3; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL4LO+O3"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-483a2338616so40581245e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 00:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772611677; x=1773216477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av4UH9SO0/Ch5JZF+nWNZV5yubzeG2c9IUi69Z0bBu0=;
        b=lL4LO+O3BgKMvK84ER6Dau4ujbdXtRyFovQumkZcfOUUtSmEqxcQ2TxbUKVf2N+YIz
         Zh8DAB1fRCRHpUbypxNE/ul4VNkCAJt7rfaXfaarb2RShYfOVCL+6EdXAcBpv8vrr0pq
         mWXOqGrkUVTG7cIaaCMhaBPu7gn+jgd4bPXluqOJO524ZyB3JbVEGWN95As/S/mAwZ09
         cnksew7Hqr5YpwDozi3P59FfhHp2K1CHGXHkNS+4Pm0FY45PqdjOShjBcUO4d/liilP9
         ckIRAYM0IGA2TfyiB4rpe8x/pMjKEPsxbfYNN2bghfeJOoM8DazpYi+fbU0HrzY6FWPF
         yBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611677; x=1773216477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=av4UH9SO0/Ch5JZF+nWNZV5yubzeG2c9IUi69Z0bBu0=;
        b=I6u/WTmFtvqoUSYj1RO3F8AS2qUdXztVVTiJ1Dda0gfdbCg7+H/OCHUtoihDc/2ULv
         q5jRUBuSgNweEJc5Vhe8BsGGApEU9+nyweFg3Seuctg9bDDbU+CmRbXrJh1iDxxzHefh
         2e0/c2ktuU2OkL7Dncq2GqxYuH+fv97jKnaPUOZimxN6+D6oW1va3VgeiYKvT7gADNeP
         pyPboERkxwDGdnDMUacmD7NnjzfVuzwM+378tO9ojWbJ8NfEgITeaEdV5OFQul1lmDiS
         9sFqW0HW+J0OALN/NBQaqWXWqNF/xO1rp/6ycs+KMyctoYSZUBvSxJM5moac4HSVmNlj
         H4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWrapk2p63GfuCY8YEW41rZ7GMsM5XpV3PYgW2w7GWvFXUvtLCOmp5pCrqa69Z+OFmKS+3UVtE44DQ63FXMAW2ub4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37f/uGyBqZqOS9jXxvuq/UdYVFu5DqaHLChLc4B4Gs4ctqIJ4
	yREh5K/n0A5GtqwueYC72qHYw4nNiJzd5QDjhHg0B2lmsTIDuL+ylLO0
X-Gm-Gg: ATEYQzyJZs/VdcH9ou/AxYDnmic0mKRzOWw+34dhoRS2AH228/SP3QqCESsUo/DhbfP
	sDjQhCga06DUI9CPd5dVxGeYYWdmf16QQhKDgnq7SEwMxSratFyLWiaxFYFQ7rt1Zi26hYqQrh9
	XaTSquVVwYRh9Sa8tUD/+1oPHOhmMZX5Wkr49caLUMW7PnN4p7klrLir16ZI+jIzYfO22MREkKx
	Mw+pM8RfgqsRO0K5FwsVmsLmQEXIeNnozNG7qQiPEYRiG5ZTBEZgJbKeqYfwQ49LjccvZ6hKORA
	aZbt9sbIaYWgD2dG+hop+YMsR7sOAoqtQIZ1KDshDNXgVVC5x24GSE2sDS8l3w/7hpckqZONi9R
	t84tSebnVnXiA0zYu7W6kX8Mx8oZ/8sBiE6zecsEnbU0xnp8WKskJ06i1EOIZEUgmZ+LuD1zdYp
	MV+/7nUp6cfqWNZ3qBwNrIHQMVYIvi1UOHfHAWMr9Qfh4H70umSQ==
X-Received: by 2002:a05:600c:1d0e:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-48519888ab3mr17588355e9.17.1772611677114;
        Wed, 04 Mar 2026 00:07:57 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a82c876sm5400915e9.0.2026.03.04.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:07:56 -0800 (PST)
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
Date: Wed,  4 Mar 2026 16:07:39 +0800
Message-Id: <20260304080739.198251-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a7e4df.050a0220.21ae90.0014.GAE@google.com>
References: <69a7e4df.050a0220.21ae90.0014.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 04 Mar 2026 at 15:53, syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
> Tested-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         0031c068 Merge tag 'cgroup-for-7.0-rc2-fixes' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12afb006580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
> dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1566e552580000
> 
> Note: testing is done by a robot and is best-effort only.

It's same as [0].
 [0] https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc

I sent the fixed patch [1] to [0].
 [1] https://lore.kernel.org/all/20260304070927.178464-1-wangqing7171@gmail.com/T/

--
Qing
