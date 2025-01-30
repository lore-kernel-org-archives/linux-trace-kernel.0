Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4681F2C3D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258608; cv=none; b=a2czQ8pCZtxKEe43XEKpiFej+rbv3v/gWh7Pzq588iSz+qQr5KaaqR94uNauz/I5yeRUikjqOw91m6gKL2d/xXYPCrGu9DeubgEBLpZ2JE+Zn3Hdak4fpY+J+tvpIbCfv3SZ826NpbJJFEPFgcM0nNfjFFVHby7cnL+E4aEvnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258608; c=relaxed/simple;
	bh=fEvX637Z7c33Zk5WCEhwiVVgzZ0aKNk8OcHlF0sVoOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pf6dUsg0DX08lNz8V2r1aidXfTbsb2jlt8WWF86u1v+9a89uC8OmhFbDGDpgBLNonlbw/vhDn93vBzP4lW/YWL6VOuz4owOHqY2iIircMx3kxRaRB0D5oAP2U+2QJnf7rcDHvnwyBgIxLN4Mp2VfAsSKBrBVJSOSivGjRww+yUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166022c5caso16785615ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 09:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738258605; x=1738863405;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wba71lrlJHRpHNYwCSUOMwjfSnFCdMmwKcitB9A/Re8=;
        b=h9g98gs6K42hXgS9KrYpRe6pwy4b2b5T9dMYl5/xfbDppPRCLenkkT4TQsmNBIsU6y
         sLK7YdpddSaAh9HL1bp8N7lf9pa0h6oQLBJkeKAtANEx8R48ZoDuvrXRnEaaX9dEWPdd
         abPr5i1jHiGGePkD/HyqufPFo+LWAUThuaza3U/+y030zDdCR/XmNhvYP77Kn8VOKfJQ
         BUxkMn69TCBMEH8BaUwOWdRH+q1G9D487r2DKf1RcM3JVWUbV9sK9tDjR2T9+iJw5NyS
         /NcK1Slek646IOCI1DyEVCfg+MSt697ay9GFNAmrPOjU0Wo9zNxIwbkxHRWOJZKVuPNq
         j5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9TpLYKqi+VW2dWdrUSY7YrjBCI4h8GeIvBZa1aIz5/n7GdXTmfcIrqrqTR+szKqbf09nNYxSQn0t32Gw+E95PIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwaTpc7FzzLbhJ5Fj7MqBoOov/g0P213Va0+p1AX3xGd9Ou8c+
	J80WpOcoJhjBsACH5oTis0ALaEfN1xT6zc5CbepX6CtXU3Tu8AtJmdcS9y3Izwc=
X-Gm-Gg: ASbGncs9ixXzP8GH1c0c/i6RsmS7WqkHSh6bl9L/cj2fXLQOMt0aKQo6IID6Azu0JB/
	uliWrYzyIMsRYVp63pQTjSOc5q4qrDgcE4FHccj17NgUE/IUTns8QDQTNt2UldyyxparGeiZ1ZS
	Rq7cAdNR9TFYMxGcS14CsvL1nSDtR0j0rr9quJTJVRgVAAZ75jIgpFnJTJnqqO/Jqmj3hY3nhyQ
	KR/0LUVk3XXPXECtt8TeaaSmsUtOHkCMSHics8JZ3Rl1hdfBkjxietv7ZV0yRpEeHh2PRzrkAEB
	NshPjeCFIE14kA==
X-Google-Smtp-Source: AGHT+IHPgtyksfxV717Ovby5/EZ85xi1T/C77gVscvPLkijnPA2Hto/kR8guWoggO+GeixLtqrCFiA==
X-Received: by 2002:a05:6a20:7345:b0:1e1:c03c:b420 with SMTP id adf61e73a8af0-1ed7a6b820dmr14182766637.31.1738258605613;
        Thu, 30 Jan 2025 09:36:45 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe384272sm1423838a12.18.2025.01.30.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:36:45 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Keita Morisaki <keyz@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: aarontian@google.com, yimingtseng@google.com, Keita Morisaki
 <keyz@google.com>
Subject: Re: [PATCH v3] cpuidle: psci: Add trace for PSCI domain idle
In-Reply-To: <20250125013145.1664062-1-keyz@google.com>
References: <20250125012734.1661860-1-keyz@google.com>
 <20250125013145.1664062-1-keyz@google.com>
Date: Thu, 30 Jan 2025 09:36:44 -0800
Message-ID: <7hy0ysi4pf.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keita Morisaki <keyz@google.com> writes:

> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
>
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.
>
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
>
> Signed-off-by: Keita Morisaki <keyz@google.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Kevin Hilman <khilman@baylibre.com>

I've been using some local trace_printk() to do exactly this, so I fully
support having some official tracepoints here. 

For my local hacks, I was trackin the state index as well as the state
value since for quick debug, I find the index to more human readable
than the state value, which I have to compare with the
arm,psci-suspend-pararm from the DT.

Anyways, thanks for submitting this!

Kevin
