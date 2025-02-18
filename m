Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C322AE7F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870243; cv=none; b=exC5zHeUTvpa4cpp7t+YauPzPvTcoI4UVlNIdUBKCOass8EdbAfY2sGEmh6Lwr9DhpOh7ewWwTeVVAVQZB/YEyoL2TTRQa9ci5DnpqgDOYsa8qvjfDAsDQ9ysjqv+/KTyM8WZyF8uUPb+SpZhC2qRKm7XGkVcB0ituPjIf5Y4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870243; c=relaxed/simple;
	bh=e9eawh0CQTC6B4XkVXKnBZTw+De/FpP0oA2+UhyUCeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UphX+jg6bS5zApIFeL4+WcoB5oy29C1m0GsVfmAc3OKzS9M1dofbgiXIl1aC/Y/jZ0TJXoDqciJ+WB76EsyJa/ua+7QRdqd06gG99QGzoZhHBDG2FiWa8HxLillCetQH3UIny4+Y0L+sj0W23/Kd7+lF1tkFIRX6U767l8J3bpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkPj8ud3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkPj8ud3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ec5c16e9so83903525ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739870240; x=1740475040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9eawh0CQTC6B4XkVXKnBZTw+De/FpP0oA2+UhyUCeA=;
        b=kkPj8ud3WPOPuoa0aG9XMxegP/Uq+j0KH96YL0HqV29MJuctdCHRzz/bveDcYoCg0V
         ej2vzyGqUpLHMrlTblU6jzAY7CCBO18QKE4bujyzOEvMKVVHOoViJ9SZE0b/6dzfgyAm
         Fuvb400lk8JQSqPhzP7b+yiiVkLghzLZ5GqjsekFQ+zF8OaAX2NQ5C6ct0TN7nqiDSsi
         yyTtM5PRPHySogNoVqsAvTJGuri7vRTWI3ZqHhcME+6pcBBa0Uy3VK1PHRAUP/D5HrSd
         iNKui2VODNumGEgLaQyCD0ZKEXN6EydrMNhW47w7k5TYKA0uWzoSw43SZCjyFqKvDF1c
         3wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739870240; x=1740475040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9eawh0CQTC6B4XkVXKnBZTw+De/FpP0oA2+UhyUCeA=;
        b=OWVx6IUBF6Fl/6bpJJv3rs2fI6iSak2Fdh2Mjdax+IYTZTj99uXI8tSpdmazIYwXdt
         HCvNJcx1ysSJCObpvw43TkNOIj2OPbYX+0Crm0wlh6j6OwvToMRGfaAJG2hLNNakJ2qZ
         PCv4GpPtbA/ncA8ZwxjII4pVLctJBmX76bxU3ypTiCUlR4sfYcmMsQvQYvXQiBzqx7hc
         G95cJpMlzKs7OdfvMVIjLtMgj2Vw/AIrh5ogqXtldfsMCo27EDaBHw+O2y5UG3IwduAH
         TGBRO/mnjQ0C5DhoCVgqfCt/bsbYCZ+nkLQfMT6sU1Bo23HJU6bj6zhO0I5FdxVTNQKw
         8zPw==
X-Forwarded-Encrypted: i=1; AJvYcCWlsPw7GzSz1Oc1ac8bWpTdlgUuoFN634FgPDAgSPbMVZwKunKI+DljdgoZyodSym5xBBnh6S6nBlwzh29YQtAQjD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4cPcHbAygU6HXUVj09B367nV05SVucnx5QUeEycw7gcW1HTN
	J5nBQib9NVBdNi48dRg5TVsx9Hr7/66E0akmnZ1NyI8xvExMdJH5oabzySL45PXF36Vsmg==
X-Google-Smtp-Source: AGHT+IGEUf1IAWU1YfH4BCxWMw3DbzclxHXWfJ0bKoh4oebNPcKR4H3sJDIdZaS1HGUEr9wC1aKrwoRL
X-Received: from pfbdn12.prod.google.com ([2002:a05:6a00:498c:b0:730:92d9:52e3])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124e:b0:732:23ed:9470
 with SMTP id d2e1a72fcca58-73261901144mr18452340b3a.23.1739870240161; Tue, 18
 Feb 2025 01:17:20 -0800 (PST)
Date: Tue, 18 Feb 2025 17:17:16 +0800
In-Reply-To: <CAPDyKFor_kP1hcNC1YwLBjH=eaLG9qSyvOYvj+FQrNu8Piu2Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPDyKFor_kP1hcNC1YwLBjH=eaLG9qSyvOYvj+FQrNu8Piu2Dg@mail.gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218091716.1450623-1-keyz@google.com>
Subject: Re: [PATCH v5 RESEND] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: ulf.hansson@linaro.org
Cc: aarontian@google.com, d-gole@ti.com, daniel.lezcano@linaro.org, 
	keyz@google.com, khilman@baylibre.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> Looks good to me. I left it to Ulf, FWIW:
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Applied for next, thanks!
>
> Kind regards
> Uffe

Thank you for all the review! Excited to see it in the next.

Best regards,
Keita
