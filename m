Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00812DE70B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266493; cv=none; b=g4as7bKX6Xa8aGfAmd0y8DB+mJO7NvzDphcmAi/KsXtADoKkGiCUC/CwejcStVMEt+WHCJA+YzlMtDDXaXEbqDpSHQKDgGEtiRB9WJgbPHxeuYx/z1RxezcRrL6pR0VNzjLYLtiCUd3zWjkGH7s86TtirzDAfDo4yYaHdNpNCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266493; c=relaxed/simple;
	bh=DXdW2sVJpUEGRsnsDNt3IDY65YC/KG+dJKnnrkCN2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiXO0QjudiZp+kEyED+kGKcHY/xcMqklr5TkkvD1Us02k8f8dj05/OtdXMkeeoH6F8IDocdxEtOj71cIvcRf5Np1Jx9lB6C36dkMD2UIgNET2+muJ1gVT9275YMKwd3zfQUlFmJrDQNruOOozSwny1LIoCG4W2BhJjwg4BatvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vzot2n/f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vzot2n/f"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad21f437eeso15468735ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771266490; x=1771871290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1Yj1yhuptOSylTDyOUs8iyxlJcujGeDn2NjJk0xsTM=;
        b=Vzot2n/f3TKjMdB3hfeRySQcM9ZlEKJ5PMVQqz4/D6yE+pt4EFNWrV7PN9g1WsGFSz
         Yha/xxkHF8k1LxjgLJJLiIgOVCrkKqrIygapjAO39Jgso9o3Zt7eCxm6ZRS37dEPHLQm
         wwpajlsr8iLr4arXLXbT+/mR2oL4d0X2w3FwB7Nht5zPVEO6dunOSGZsFgZU+MJ61vVa
         7izyhQVb3iOqXV3oiwa/7OOItjuG1z+c0VueZFdBDN6YedTJi5NvCrQrS0Tx+8tHslrZ
         H7BPCR+0n6Fr+UCdYBrG09+CbaqdpmCLQbbXngZ+/IGT/32/xkfkP/jSo5+8Z23FdvRS
         GLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771266490; x=1771871290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Yj1yhuptOSylTDyOUs8iyxlJcujGeDn2NjJk0xsTM=;
        b=ry7kfcqeG6YflCO61mY9XYUwqNTWWyCohbdUYMFljkcGh0Jsy4r2TcYWX0YlYYAd+Q
         0B1zGZqmoFHMeJR5Lvx4phWz0cU6LyEjy6BfmU8cb5mdFr90R3PiwQ6HhwBAbkvuewx0
         eXT9LpfBTbGFniHkNDsZcVX1jSv5bhyLzFGRT1/eDAxG870c+yBW1yatsJZ9dgCdimpz
         IXpWP/zasktxSYOxOSTOO8aWn1CmuTzLlxzvT1ojIKHDf12h3HWh+zcF4uD007cd+Hf8
         QmX3QPTuD27Y/l04AhQ2Pvxgi86sPg5lxPlqafBN5A0AjtO5jX2ai1t8VxijfFxnPm6w
         2+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSueiGwYpOdrqdUh5U/TH18VbKl+TWjewqPow55C/AnP7hbNmzBuhRCPhO9oSYOyzyJrW7ld2w2wuqHht1O+J/sbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlG2RnP6DRR7LGC++g55sbg6ZVSbHkn125EAJVzCNZw/ykYWFV
	QQQl3BR4LK0EBjA+9Lir72M/bB4OnZWKLS5F4Nc6bbqQyUy/XMN1bEuT0XSnOo63DVQ=
X-Gm-Gg: AZuq6aIZSvmPh2ge+iggrqY+7/4N9y0NlAapKliA3xDZVvxs3R5SQICSUv4xJDBpCyE
	LMj2v+B71sB944DDpI5E2hhCHFAkMW/dGT91uRF2ImY0gsvL4n5g1azmT3bFoiyzCSTQi9w5QeI
	mgOHSu8oBgywo7h6BqFDt/HPCTotzNB6QvMzAdwBCaw0DcLDGf4/+BrbWm5yzfXDAc09E/j5F1u
	esBI9eenqQzJt3RC1PsfzGyXKI25GRzopIgSn2um8OeoDfCDIephvcUkZhlbgZlhY8e+Bc3pduv
	R7ffBw7cpaR8kAFiClx6AWDR/g/FnhhlK8yCS1d0qHqcsYXYRJDsUOKguCMVYbvm+jZZNemJlck
	osHaj4T5y/98aMNz9XLPEk84qoWKR4TbX3RyheQOfPuUmfV1sM/B2aMSZzH7kk5eav33YemRBEk
	dfkMPFf+HDYM6Jj2LithmBQ+bUAdEDYyv7otfROg==
X-Received: by 2002:a17:902:d50a:b0:2a9:ebae:f3f6 with SMTP id d9443c01a7336-2ac97593413mr94716045ad.20.1771266490130;
        Mon, 16 Feb 2026 10:28:10 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2ad1a9d5df0sm74851785ad.58.2026.02.16.10.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:28:09 -0800 (PST)
Date: Mon, 16 Feb 2026 10:28:08 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, nilay@linux.ibm.com, ming.lei@redhat.com, hch@lst.de,
	yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, kbusch@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Message-ID: <20260216182808.GA1799879-mkhalfella@purestorage.com>
References: <20260214054350.2322436-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214054350.2322436-1-yukuai@fnnas.com>

On Sat 2026-02-14 13:43:50 +0800, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
> 
> Introduce blk_debugfs_lock()/blk_debugfs_unlock() helpers that combine
> the debugfs_mutex with memalloc_noio_save()/restore() to prevent fs
> reclaim from triggering block I/O. Also add blk_debugfs_lock_nomemsave()
> and blk_debugfs_unlock_nomemrestore() variants for callers that don't
> need NOIO protection (e.g., debugfs removal or read-only operations).
> 
> Replace all raw debugfs_mutex lock/unlock pairs with these helpers,
> using the _nomemsave/_nomemrestore variants where appropriate.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Maybe added Fixes: 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")?

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
