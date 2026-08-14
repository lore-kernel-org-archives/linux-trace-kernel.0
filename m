Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F4433059
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694852; cv=none; b=uD3SDuPaAdcPHAAH6xY3hLyjNAWby7utngVEiPnB6IACfrKcgCNpuvH3H+UQrGTKyIaox/PzFyfC4L/h4SZ7KfxK66DQjPTYNpuw3sDTamNl3nTC5qK0s6U3Pe74Jq4fM1WKbdFFvbZZtGnq3jHIi9Bdgeibi8WmqyZEn4F/x5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694852; c=relaxed/simple;
	bh=C0abIehr80Wpjf52fM2FVTg08DwwXZt69KjDeV+3SPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avBue8S6DyoKTEs9MLyeyQj12lH0W7jatuqdbIMvpGdsKGmnnkiM3eL6XkNfZom1rFipz9Q5tbPWMduV1gmQtDRZ/VUS3P8XuxQGapVB5/x0JrSwi8mpKd9feW9SqBAzti0+eO9DIK/tTcw3HPsPSNM6VMDcncGZgdRucs2fmCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YK8N1EKy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK8N1EKy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-496b7622a83so5323725e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786694849; x=1787299649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rvwtzarQ/dYBS7JL1ZitrxFtSPInVeBnSLoYHJJQBl8=;
        b=YK8N1EKy+XWWhoWHL+1teRTm2ilB7Uk+ZvKMSLUtPKQCsMtL8eJ0270DdZvI2weuy4
         AoO9IOolzsS9/knGY5EfG+8Uss9YsmUu6Ygu13AxZCfjJg4reZ3TsSkzHM0GOu2ZNwIT
         a4z8bFQOY2V8FB7wIqSojXZa4pc59Bxu+9ongNYXzWk5kd79v49tz+aFDBX34n0UXXx0
         JbpOJ/CPZGeUXeR6Agg8gNGctw5g1BHuKirM3B/r1r0jEkcSYDTozxGXNNSrRXka/vXh
         oEc3Aov5CosYtc6zWUjm99F4AEIiU+YtEqBxX+7Jdx/wR7y2RdDeLUDpq7jk+usUFx4Q
         Aokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694849; x=1787299649;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvwtzarQ/dYBS7JL1ZitrxFtSPInVeBnSLoYHJJQBl8=;
        b=muZbYTVgmtAoQYpX6fE+yAXq0ma8PH4/rZ1toCRcQVsbX6Q7jl4JWw/jx8wNXC9XF9
         LmBkQ0En+AqdY8LPL+1UAj3tI04Oq2tj6e+nqFj8Z4oW016vR4mD2s8AikgwgiTrbeaW
         bdeXiF4icmbHFHN1mrvQWaO4xO8c8PUVjpko7TFj4RunpUMgC0HFyOPCD+5qkToPEmTP
         DE5L318f93ouLLe+xKgFKlwwF+OwFOpbHc5DQGpeWfERaEV88Ve91XTa74aib36Gkf1Y
         jLYAle4BA9e3VgchpmJ380pK/ScAUY7WpgTI2EituBYtTTL5KzXhHkKL3UIeL/6pvjWL
         vDSA==
X-Forwarded-Encrypted: i=1; AHgh+RozjLeCjfTIIegJP800D4eYCiwIC6FceTHDV7cQUMHTX2C+G1hUwihK1B053Wy3TWOWF9a1jux8AiwigAnO9hPSA7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBXe9Wu02CMTg+nRW923x49K3k3dCjYP/hqnNJU0Nv/Znn979
	hgZEWGLG/ZeOWmxZUaAYR5SDR02ma6kkUuYPKT6g53oK9w+vkHoepIQQKiFssg7KvQ==
X-Gm-Gg: AR+sD12ggMX8uAY6Ipp86VlB4dua7H8V1o2y/QzrPS5b/o0AX7/nmUHKaAFe/6W1fNp
	HosYTGAm03Tb0LpJ0JmcWSDEJoZgu6yVKSY0P7RBFf5CF2NHhekoI/biqHxHrCsveWJXCo4lEH+
	nmKF6Bw61MNqYGfSxPT0xjAapUtmXv5Iv0X3DsQ3W4UDjrqux49n9IBL/CJxFGEH4HIVU2gEdYk
	vQGbXaInTaKTfht4RQcVtYLiMLMc+LTvlc+3b6mkFWgO2jTkYo5fxsiPUIdzJhvbtwp0ntiI2ZF
	8jJcbWV70ygSYHJi/iad/umSPK0n2L2LIHmcwauMc1Q7e3+0SB2FGBP7aiPIp4i1Bb2gAG/jGxu
	qQQ0f3kdBrCZIo63eFJehBb6/HNnfzpCBdLbaU9GjCdM6ziD11C/7vOChi/tnie5wV0NnqdDBLx
	CgQzUkUVVCkjWLc82pyMJqV1poduT57QqanG3LfJVbJgmuRnz5nxgwM+6ekEots2OyXIpm252dy
	QaY5rFufMmV09NDRmk+er2qFgLcHsgI
X-Received: by 2002:a05:600c:c165:b0:499:4892:d022 with SMTP id 5b1f17b1804b1-4998795bca6mr60329945e9.8.1786694848111;
        Fri, 14 Aug 2026 01:07:28 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b27bfsm6056643f8f.23.2026.08.14.01.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:07:27 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:07:23 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] ring-buffer: Make nr_pages unsigned int
Message-ID: <an7Muwh8LgL0_v5h@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-11-vdonnefort@google.com>
 <20260813135526.EF9CF1F000E9@smtp.kernel.org>
 <20260813214156.64d0b21a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813214156.64d0b21a@gandalf.local.home>

On Thu, Aug 13, 2026 at 09:41:56PM -0400, Steven Rostedt wrote:
> On Thu, 13 Aug 2026 13:55:26 +0000
> sashiko-bot@kernel.org wrote:
> 
> > > @@ -3264,7 +3263,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
> > >  			int cpu_id)
> > >  {
> > >  	struct ring_buffer_per_cpu *cpu_buffer;
> > > -	unsigned long nr_pages;
> > > +	unsigned int nr_pages;  
> > 
> > [Severity: Critical]
> > If a huge value is written to buffer_size_kb, could the unsigned
> > difference between nr_pages and cpu_buffer->nr_pages overflow when
> > assigned to the now 32-bit signed cpu_buffer->nr_pages_to_update?
> 
> I agree. I never wanted to limit the size of the ring buffer. If anything,
> I would want to make all references to nr_pages to be long. Otherwise we
> are capping the size of the ring buffer to 8 terabytes per CPU. Yeah, that
> may sound huge, but believe me, in the not so distant future, it may be
> desirable.
> 
> I'm fine with keeping persistent memory and even special case mappings
> limited to MAX_INT pages. But not the ring buffer as a whole.
> 
> -- Steve

So, keeping nr_pages unsigned long everywhere but -E2BIG for the cases where we
are limited to 32-bits, that is persistent buffers, user-mapped buffers and
remotes?

-- 
Vincent
