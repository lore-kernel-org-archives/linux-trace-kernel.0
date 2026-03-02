Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7D37FF40
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431362; cv=pass; b=GVDlOlQCzm57h6d43ajmFkvNs3tOvqsesVM1Bgde5v4ShIiEV4W2luequxKOeQtuuKWlvr2IBrT0K7UTFAlMzNYxsj14QZNY9VN5+2zhzeR9wdoptiKWdJ/tPn5NDyBKm4RAAFXqxOFDf6nXTnkCDtCyzcjd1RGyvhtlJ4o2saE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431362; c=relaxed/simple;
	bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYldnEBIIWKEs0PnaIpNwHfpQoHazfKZXLK1J4ioxQfRsRTc+KEvzUC4kI6XfzIyLEekgifGLiFeoCLe8SsFWu/cOtNOaRmyRnYPqFAgWraTaS2IvxPRSSt74JQI3HBXSb6IA6zB7IMOU5oTC8oQtZgo74BkvJkzT3wAELkWNU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JNqmYRkE; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JNqmYRkE"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3801509eec.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 01 Mar 2026 22:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772431354; cv=none;
        d=google.com; s=arc-20240605;
        b=bQfoncFNbZgH7RSDucboEkASdvl2z05QcoFm+kM11R0ZRMO95iB0il1n1xsfsrVkqw
         b4L2tIoG0z4yNruJteJ51Y3XSfVKMaRKc9FPzrYHGzn7LP1BKKN2cn5Nh82sp+Cib8lv
         M33KNxZTE9b0+t6OXt4SeqZaHjnX2deg2r56DvuEtyBEozhNHq9TrQ2PUsQSPqyDQa4j
         iU3OXhjc0ktae1Bwe+d4lBqgbiq7qr6CCp7veeTJQKomSNuQtsf0HBHQ5mPW+bPaWUpV
         BhZsNkE4mnR8ijjiZ++SVLxSgCQ8CChLm8WJG7zCW59LQUrIUoql9qIzVr61v3HMQlPe
         i4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
        fh=9EiFDIlBGnkfg61RYbtEM55WsSGAJm8ZnXHPoOoLTWk=;
        b=dU5wQqoxBmzPOraIIY2Qbx4EP03PKIkcqbTfdFiCZjorPHoSigtQNKV8Xhs27X1Zdk
         8FexvjgfRsFr+ZgFfcKYsFEZm7vxdbAuTOJOQi35rAXl1iCR6NINHom7bwrkPdsvDjsm
         sEokAlnTzNeEmi3esU6fwQQwHJElkIHqbnxMn6FwUWptGOTKHfZI0R87CH01fZMhD1yV
         nC/RtmXmKGoGACc06+w1oWvpwWVo9so+KY2DU6lFrqsf4Dmt3LKiIATWkdTTbXO6bxqG
         CPOiWrFxcpyXNQUTBwG6BBhTp7mSWDkSUhI5NTOsD9rWioslbF/+QayiYyGOcTzB5Gpm
         IIBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772431354; x=1773036154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
        b=JNqmYRkEqX0bev5ZtyCq2ZhWTXrynvV9z1AhVO6s1tjrVZ1IVD+y8BKm1FoZlO9nb/
         CkMJDUgHS+mUvMbZNR+bu3KqPQDc1ufJ5xWrDmVOG5S5JHwwMWgPFp4qPPY35jpSihdV
         GsXPyQbQ/Mf2hlmjXCCF3VzZweTHLlX4h3Usqb0zZfSs1cHWPVWxVq9BY69NBJ6VYBp2
         4SAKoaRkKtNZErTvgN/Dc8kojmpU8v9EGc7c8raqcopRQPSn3jagSHnxBFQ87MxeLxNt
         Ol34550Yb8hhz8AIVH+rf9sWwd4Lm/FRnvEl+8bdeEJRaMQ/OtI/rP2+vKPwragU0zs/
         PCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772431354; x=1773036154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
        b=hFih2rd8UZJ7mhr4BdbVoDj6W9G2/3Sh9LV35E3Qo+XIjIxUoPetEH6f+jf1r7qvzl
         L0043NlutFFEpncF+rUnNRinGrBc0zR5zRydMy/BevIzaCooUhkHOfleLEuH86lzREYS
         ynDEX88L/M5xVYqvCP990WyJy1jLVSDAs1Lt+ftBMd5Zs9gZpOzv9MDgHRcHtULHglkD
         gEv81y9q3eu+GOpc0y/O6vt3P6utI8BkxodXWSAtKn3TS2HU41pW/LONujicMc5FxXKP
         K+NN2EgyTzgSrgDgnE8yw1s/ua0huFbfXueOI+2QJRKD5Gr61lXUvxL/KDdYz/u1jItr
         gPAA==
X-Forwarded-Encrypted: i=1; AJvYcCU7/YNbk/ayTiq4gpcLcCmiN+/x7ZfLcZU2/Xr3kpCQyRjz2ss0OJZ3CuhmsXS4NhVI3TZzmC1dCmZnQjX2dYH2oY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEiou9YxHApS7BCm7p3xrbz1Lv+0O363fRyCeAir1upB/vwoK
	Gcp+JlaeW5BKWJKXcNQDLSkOFcJ/RSHCPj6hrrdrZleArLV9h9SDkwsEVyZRO8wvBTThGL4qTxP
	8RFxkp1fJg053Coqx9/KVvPXkqZ1XtBa8IaoqDv/wSw==
X-Gm-Gg: ATEYQzyfrj8SsIVdlDLBhwQ6Ye21JEE+eBRO8hb3w6Cns5SwjzmvHBtrnPF8/Ay/P6C
	Uv0ixWwtdlSn/zJTcmkURqSqFwLll4jZPiz8XX4P/YNDjArLBohwSku1YcUK9k3VGwReQ7DLlvB
	8ROsumnvbLYClSrRNRE9vK7uK+jn1nTClfvB2d/BrgcQoMP8JdL5w9GGKeELq8lCQYiULaTg/Mz
	u0NPr4iRCs2wh2okTTkwftknk2fhEj08YiYQG+pEOfoOAHki0cZwy9c4JCEJcf+WrRoJrj6G5/z
	n7M2Kkiexnh4RHW/PfL9bfNJpJKnxLnEgBrf9A7iZ6Cn/b8d6zvq86WQjcPSOsGFXvc6rUhXlXp
	t1A==
X-Received: by 2002:a05:7300:214f:b0:2ba:7069:686c with SMTP id
 5a478bee46e88-2bde1be2e31mr3755376eec.17.1772431354342; Sun, 01 Mar 2026
 22:02:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002207.12165-1-kch@nvidia.com>
In-Reply-To: <20260302002207.12165-1-kch@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 1 Mar 2026 23:02:22 -0700
X-Gm-Features: AaiRm52BMKBF_6fnIy2o9_Eq51EwXNhN6II0seQLIeXaZHlpvQk2HcLdy7tiHTQ
Message-ID: <CAKb3OG_1yUUhLK8uHUxrYtnpph8jNr_j1kjivEWQ9VtkP-fRpQ@mail.gmail.com>
Subject: Re: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible context
To: Chaitanya Kulkarni <kch@nvidia.com>, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 3/1/26 5:22 PM, Chaitanya Kulkarni wrote:
> Fixes: 7ffbd48d5cab ("tracing: Cache comms only after an event occurred")

I don't understand, this dates back to 2012?

--
Jens Axboe
