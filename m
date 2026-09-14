Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F77368D76
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366144; cv=none; b=aOp5YsoEHragVzBk5TENS+pJu+rpy0Tp5Rgsf8bOZTFoHboVn9T89I02+h6QKeIjLxtkcAUBUZx9hzHZWexFzKIywU5H64V4aiWXblGNm+hjoDEXefdEUOo9mzAAEhG1CpWbUZ9u1+93OWbBRa2gTbyaoCbYcpa6G4ZAaN0nF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366144; c=relaxed/simple;
	bh=vY19FPTkTGgFEXUz7E3y70WuMjZlCOtv+gJ53myAkDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwFU1V9BuPch+EnQ9qrI/KGALRCDl2PQU39vCt3WTPH5x6KcQwjGIo6v62NbU1BHsnAzrgo3fxINZVuwkhVGKd3y88d4P+3T5eh3/Lzdg8EO0/Wf20F2gxGCEZwoSHNjnDvmm2OqL1fEDGkhXYB3iXOgG2yQBGYcLmFYRZrEEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COyYFlfn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COyYFlfn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2877681a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789366142; x=1789970942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vY19FPTkTGgFEXUz7E3y70WuMjZlCOtv+gJ53myAkDg=;
        b=COyYFlfnBHB8v/nx/XshDjDVasJem7bV/4x/RJsm5p94eA6I/IuAUEAEZrD0ztYd0V
         KhmmC/WHUenAv0tXqwTk4jxMeoNPMpN8aqYx3sz6ZO0LzgbomykliekNj1d0CdT5DQB+
         D8zv24mPhrzfPM5wpGzT8Xyns9MlaTALyscP5E15sZxXRqQxWFBx+aAsbnJQOCI+Ra8j
         hLH9qw+OATINzvgrsZ36FV4YoxDYsvS5nERzHwT9gQNMQGmddO23GtgELPDGiNF9M7jY
         8Ev0llDmjFg3ZQ8kydEiMPEU9AP0d8vpZhbU8PoNwpu3nd9NwY31WOnJmrogCkEfVP1z
         UATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789366142; x=1789970942;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vY19FPTkTGgFEXUz7E3y70WuMjZlCOtv+gJ53myAkDg=;
        b=goI8c/CACXdYCLBWYvt5b7rDMWJijlkrVR+7J+WzlB3+f8qNTjaPrQdt9HuBZfRtd8
         +T0FmVO0NLUti4O1LzuQgdWYsxfQxIXyyV+dqi6lojFfA+pYca7b+eNmBaYj13uOfj0G
         9yYNEr9lUwE1dcOGd8b79wbVbLawmsySm38sNBhE/fapHsh7cPYEv2BUTKjbKBdZ0tz6
         kCmE1lNbKejTApa2isH4Gd2tY3qY+DfNsgdlaln9DjF32RFwC0rUQjQbNNeLsdSTEts3
         +WUYtMjzStSai7pRxOmDfY9CqKCjGyUTKo2neJ6q4Hlz3J6kKs0EPOFyqBsRQmF1WmOJ
         NvOw==
X-Forwarded-Encrypted: i=1; AKwUvBzf461aKOZ8zbQg9dWgUU1SwyfdVSPSJ7kBLGL/61+pK02KkfKKk/4nmAERCypt32DoyU8CFCRZOvRbDr+0b8KwE8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nRthVZEE9FPbXPVd5UC2YlR5lOwQxzYgP4spcoXKyy5doHBgSU
	vcEHOlawPNrxQ8ndfWxGfHfFMStTcZgrBJ1Uk63f02DmzsMFLryf6ycJ
X-Gm-Gg: AYBFou3EsuxbzHpgxuePZQzvwOKyIfOiLehkm8e3a+AlrmUJ3Mu3V5n/MXNRWscVpYn
	RAerf4g144aSKt1z5RKZPQLR8yslK9mR6eCQNA3I+80zqm7xIUPi5EQ8l7Y656Ip4DSEYNuT7zS
	tBnzpvZPwX0STADlBpRq5p4+1vRwbGxfPxknskBF7wwR3WZUyC32ir/eLngZKElYDRKXqxslyuV
	Yy0G2WEn32ZiSy7ujs5shQcXcKVyRyc8vrbJiTHAFlEHfilLV6mxiziGJUMXEGR9Pkb2+4gMRjd
	F+ynxZZUXQar5RboB1OgXGEFfHXCBilIb0vOq4h+WUdgjOjan8Vc5k+1Rq8QBf1xMrXVx1gCc8X
	yreZZCuAuDWBxnAJJxPWmfyBr/tQgTEDfnm+C7TLBpMOCh85huZRiqNuf+o3jg3l7nY8Hj/IM4w
	IktRsW+bASLol8jZP+RAd18tYxPOYxR5TbytAuJAMDfeo91Ku1//b95qFuFZr8WI3mF8GBjOmbs
	Dj2pXqNuuebsWSwYc3v7Ty/TyFBxaPxGJtB+4fc
X-Received: by 2002:a17:90b:264d:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39debf6d6cemr2759878a91.5.1789366142037;
        Sun, 13 Sep 2026 23:09:02 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a252:ce11:2d53:3638])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9959ac65sm18651790a91.16.2026.09.13.23.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:09:01 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Pengfei Li <lipengfei28@xiaomi.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v7 08/10] selftests/ftrace: add a stackmap basic functionality test
Date: Mon, 14 Sep 2026 14:08:24 +0800
Message-Id: <20260914060824.4003131-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912090213.C77861F00893@smtp.kernel.org>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com> <20260912083753.3426176-9-lipengfei28@xiaomi.com> <20260912090213.C77861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

> Should the commit message be revised to reflect the actual test logic that
> intentionally skips this comparison?

Yes, the changelog is stale. I dropped that comparison because the writer
resumes as soon as reset() returns, so the counter is not a stable sample,
and I forgot to update the message. Will fix in v8. No code change.

Pengfei
