Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794891664;
	b=TeltMMA9DCNgreiRAoLTDVE/Ldd5Xbdbs4jK+4jz/UtWbgcONs+YLozFQNrPtQ/s6tdX
	 jdox9jFt33OQYJHaBOpYt12bE5CEm8yrUSK1MgSdtzRWYCQSjreshgFvu/B4u6b8iyiuT
	 hG2H7xnwVT/mRldaDnTTsSEFm4Ri4JsWj1ce6LDcULYZ6jvL+e5kLtiBr2d7ZmQiXgtEa
	 NchEP8ivdCwXU3nhgEgJLx0GMSg78yKHhHAhMVCxUNC98qgzRnX92ra1Xgc5OVuk2IAjI
	 yOptykWzbKLDz1oxp+pWwODKnFx4Ybuc7BJ3PEZNY//Hb/VpdRJUpNpjbehHf6NCE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794891664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l38YUj1Dx2pOL17ooAx7fDQRqnz7W9ZjgCY8kMC60Ns=;
	b=0gcGFO3iTg03OniuTLUYxPXwb+74kfdBnkuaoYVhuXKrZ6X6aIQ6aPa6V1+NDmLTZcmk
	 GV1bHRFBFOb4UQGXh2Dt21VgITICCxBSu3v/LC4R7ZD/n15cTU5kRypasE5/k+OAWTht1
	 rnJDHC5ioKOfJGy2gXrCsErXrVQ9q5dVFbHpVxSb+VeyHzYkCpRTMZr4/1BsIJRC3FbOT
	 AZs7Y8K5TDvYrUVuHRu2E7eyg4J/2s58C7zishtZ7aVQMjFcOwp6crEMKgWQiUktQi37I
	 qUCZHEw+szPsOHtCW07BABlzJ9UWKHMeV2gO40nZq/xbZBVTdOMGuik9g26RMxO7lTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMBCuBSi;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8235606A33B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 05:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8235606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMBCuBSi
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso2343743a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 21:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794891663; x=1795496463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l38YUj1Dx2pOL17ooAx7fDQRqnz7W9ZjgCY8kMC60Ns=;
        b=FMBCuBSi0o0iZVslnqf3UELcTJrbpF/yE/5GBAQFI4DZNYb+tKCJuP9Zm/yHgJKM2f
         nbx3+kS5uLsZNC6i2Ad2wpnKWrhRI5E3qIXCadS023dfOElycHXVpdy03GFLCRVTpV1Y
         7bL9hgEdWop6arRUR47GViYq+326skZZK7GncmLpoIuk4RFE6N4rX7xQMlbnJq/zHjH5
         qNUxmrkk0Offg4LQn0YAXBhpv2PEKt+W6k19mKSiJfoGv0xEkHEOp4EpBYz0hVH19pmv
         ecD/JOPLKR7mo0RfLsldF3NqzAnliYbDKInZw3/ETcKvsu7DBpSFgoSA1brXZloBfQU4
         Kltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794891663; x=1795496463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l38YUj1Dx2pOL17ooAx7fDQRqnz7W9ZjgCY8kMC60Ns=;
        b=wFctxdwxBvcz93y0JrXgE5prxoF+NXBNbJoShsQaa5WTnt3NSN40L01Y2ZuOqoMOg6
         X7faqtGdHnIh0sJvm96C9ifbXnPDxI0rgbU7xzBM1zxNTM19O5fTviz6K/gYa5Ntwwv6
         7h5U9W6l8e2dSA9LMfJya2TmHRSDluNLYrlZ4//SVulV+WFX4wKauQ8mFKAk+ozkPvpm
         gALehj2OcOHJec9j2y7oECLAXuADpl6MtypNYwp1myksGhVHh/5cW2pfHwb6h4m94h3A
         5sx57OWA4MawbJhz7stt1e/sRPnQjPdei/9j8ltCMMjZeepOOsSa/GjeVAZQZ/4d3VME
         fI/g==
X-Forwarded-Encrypted: i=1; AL+hErFYL4nUvDQ5v6MRwOmyRPuYevJDtg+W+b0u0c0zY8P028eMBiR8+kg1+JPZy4/SiemIQsig6v6/oAfLZ+lvs9nTWmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9d7A/+/luZmm+T9DTllcX0+GE/zOJGJgBF1q4imwLjIwYI/fGO
	hr1O3k7ndMcg13W/WGJ1b11hl5aLrmBtHwpC88bpWMuQXgEoGA93/LSW
X-Gm-Gg: AZFdTZcu4/fS94kkorRMj6/Wp9loc+gVvmriNr/CH9sfLVyimO6tS+XblzQw2nmyV1S
	i+SYsybot1gkfEQzFf8ya8TKYEtfy3wbBO0c7QeAQmJX6UccFH1TW+3xIJDq5SF+rFX9cQi4xtb
	4ix47t1GLVFPtyLc1cuRFfVx/MYvpWxDHd9zY+OZhRE/a80CEIRxuSqXULs2vl08ZuZiY90PNdB
	XOYb1aQ4HFhVVKM32FQRgmk7e5WVZNt6C+CQXd7wU/1okMZYFUZqhcEQGXoDepRgvtrkvZbqlrn
	ed/rvcskHN3iSYMB35IiFbfxbtqh7oBsRZgen2KwVJWv4+KyN7mt8lOMgnVkZwxz5nVav+JqxTb
	+4/hy/XcgcpkR4GLd8V4itmFMPjX+o1Rv2E4eI+OwrB1sreil6BNmeWlxAkybIlQh6ubPIXgk6k
	2wtrEGTPDUnMMIqXOyyFg8AjOZ9oMZh8n4GoDDbMdxTvbVzh4L4r4l+nLItT+1EWm8U6+REJdqm
	xdnZzsk3VU7MEpsD0W1M9C3kJOFhryCRhevGLymLk25En9b2DIvM93d4MHojAmz8FpTAYKs4PSs
	C0MEQ1gXeETkDazgHLiFDSL7WuP5bPmh5CvqOtS3D4R3QowMVZ5Yy8zUbErgj0tQMuQotQLGdx4
	lYe4Lm3RHveI0WVZjEekwYtW7pZeCJN9G37rdf/kS3VuM/w69jY9gL8+yo6jIgvn83fvimIHpQR
	1IEcfbES5Fdrpmm2pNsktyDxI+O3vNfmCVwi3poaFUojRFcS03g6UPPBtmefaspvcmv8FDTWrs5
	G1jB6jJmjyJvEECQ9GkDxJclH3nLMaqBY1kID3RowIY/BPxKU1WQo7K9Ya3L2nHUiGIbQLelwEK
	KEEQZH9r5A==
X-Received: by 2002:a17:90b:1dc8:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3b1b0b5be93mr12038413a91.41.1794891663081;
        Mon, 16 Nov 2026 21:01:03 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abec8092sm2046720a91.17.2026.11.16.21.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:01:02 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Reject .function on the function trace event
Date: Tue, 17 Nov 2026 15:30:42 +1030
Message-Id: <20261117050042.58677-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
In-Reply-To: <20261114195914.2678414-1-devnexen@gmail.com>
References: 
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 19:59:14 +0000
David Carlier <devnexen@gmail.com> wrote:

> Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")

regex was an embedded struct in filter_pred until cfb58e278c6a
("tracing/filters: Dynamically allocate filter_pred.regex"). Before that the
pattern came out of the zeroed predicate empty and
__ftrace_function_set_filter() returned -EINVAL, so cfb58e278c6a looks like
the tag you want.
