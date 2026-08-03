Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6119DF62
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723687; cv=none; b=It5tB9WNEHrLAPzUGpMRj1SWVrT7QqbCkNqyKPB71WFzWwlaPZ2Y4cYvCVdPQUFCEpNLKBn1o5wnvhlx92OV8zv+vGQwBLFikMNhDK3Ao967sX5fHmXKCKPZ8akSIrDNhcgf9l7f6ddfDNyLXSruATVZnUkNyWBXVGc4KKmAmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723687; c=relaxed/simple;
	bh=ppeOoJOjepa7JurMfBcaDrgM/rYfmShdvP1k92tGKsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVIbip1oYPWXTQ45eOvpDJ1KdJ3LY/NAkQyBvwYp4/irBSO5hFnHmdWpmzbmyKIlUyROyBb/GqV6B+ysp2dGPEOqAq1FU6Drtfn2GBG5N1pftddct7xo1oFgwv7Aq8DWvPjUfyCZGiTUt+OaGPYDfXgrVmWLf9upj+Yugp0JK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpOBdzfh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpOBdzfh"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2843886a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Aug 2026 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785723686; x=1786328486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ppeOoJOjepa7JurMfBcaDrgM/rYfmShdvP1k92tGKsg=;
        b=RpOBdzfhIygWmuEiXZfMALfU3p0mhZVg7+lMtF67kiKLJFM8ggdY7MAhYhxVfdV/Rl
         ybkzk/X8fjS1vCPL7X6inHvAQT6TNaLbB8/eiiwjGOXZvWqu6zFYyBXEzaXDP1O4IJFg
         mMtjNoesz6XBxTktwstv/DDuRGxYuxjUCF8dKAPuZ7uOGd8G6lpOr3w1sEfRUh0KkVEb
         O9Dgq5KLzqgfynr33mbufXKN/CbXCsG7i8v4WDFL4f5dEmpB4RGR5+LQ+3BnueWA2gL9
         lr5yCx66CZPCM2xFIrMZrRr3KxA9kTSZAYVlv5AjqWkQfPIcblRAQ4j7QjFwxGWJFMz/
         UwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785723686; x=1786328486;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppeOoJOjepa7JurMfBcaDrgM/rYfmShdvP1k92tGKsg=;
        b=bRClqMrSRZ+73lja+GyHSbO9gP6SnbFH+MqdaYdTRi/6jhqxQYFH57Jm2Ri/9uwUtD
         XGSwWOxXi3nHI+Bogb2eHERd/oRjfxc1JezHKiqg57/eJmteVO9P/FeLmQNXxSfky4en
         W0QZIS2ixrs2DyudU+3ZVmjYpzL812DJAhEKOYO7lDz6FlVjx/geIHZJUqxTUIyBwbHF
         V+Y5+hh81ecCzwCIlqPrR108A4H4tGHOZECE0Bdbgc/3PUuaGImbj20ICjq5DP7uTrTA
         FnXN4PbPH6F2sdqstN5RLmoUW541+pB4g+CmDo6QZCCXXhGCdEc+ZLRNIM9uCRd4y2em
         BVPA==
X-Gm-Message-State: AOJu0YzR278E0PomqmoSqHmI8ZSpJT1IRFN2ZsEGB3HA4VANrdViIdfE
	xx4wVcVzATtlV9cXB9MMsPTFvVu0Qzp4VU/UfswP4k9YGOYYwn5o4JsY
X-Gm-Gg: AR+sD13GlwzV/9XUx2MOU4k8Zo1kM8MGOkRi0+GTSSU8cmmXLZvQmdLnERaGje/LQ0S
	x2vMfOGXkWimlH+PON3s82czuPyfPSPQi1r7lGXGAuEFIhVz3WVvW+Ayef8KSHKJHWqAhaTBJJp
	cdd3vCZMDgO2Vti5Gja2Qwi2s8MaAQaatGhzdPVxcjKB5qqEN8YX/eFrClbzs3Likhad6+KxM+p
	oUgZyHEWW2zcy7NzeX78A4vvV+Or40YjUCwBwB3p8IGLNnkqs0vCCvXJUJYLHaFkttviXZIcQxM
	I+sc7Dfnb9ZH+Ntm51dvF+aswacePUm05auR1xsaPOy9AFTLI26rrx1ISicbcd9TtsxY+cm8bX3
	CchNUrawOu4aQ397UNzYp3nkIzrAVuuKk3lObHvL6rID+u3mdAFMp7i4WluDLp1mSEYXanwB0l/
	w9nIaMAWCXYcvK2Byz51jiJ++meal/HVXNCRJBpmxzLpsHQFXxLfwyoU2BHAK8weGRZhGBBNNyi
	eOSH1NaDOFHrOC10mb27V31pZVMqw==
X-Received: by 2002:a05:6a21:2e14:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3c92a51def8mr8956941637.12.1785723686000;
        Sun, 02 Aug 2026 19:21:26 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:c22e:5c9d:65ca:13ce])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963e2aasm2935631a12.2.2026.08.02.19.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:21:25 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengfei Li <lipengfei28@xiaomi.com>
Subject: Re: [RFC PATCH v4 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Mon,  3 Aug 2026 10:20:42 +0800
Message-Id: <20260803022042.1272075-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715031245.2571869-1-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com> <20260616064119.438063-2-lipengfei28@xiaomi.com> <20260714171144.4537f163@gandalf.local.home> <20260715031245.2571869-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Hi Steve,

Just a gentle follow-up on the reset question below when you have a
chance.

I've addressed the review comments locally, but have held off on
respinning because this choice affects the reset semantics. Would you
prefer that the traceon race be documented as a best-effort limitation,
or that reset explicitly prevent or recheck tracing being re-enabled
during the clear phase?

I'm happy to implement either approach.

Thanks,
Pengfei
