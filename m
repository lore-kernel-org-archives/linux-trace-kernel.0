Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760522C326F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295916; cv=none; b=Mqm/eHr1xunHnTJZx1fr0t92IqKl3jAJy8FbWiFDCjnny+hsz9GEfGDDRuYMzBdhvtxLchlRsuGD7XsR16MEfWUtUoT82XEeBawdqRQWQxQTHxtTq/DVwm2Gpdl9OnKjPijDGKKne1xlBXfz+M1YyyviXmfndBSbefnQ2G4yrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295916; c=relaxed/simple;
	bh=RjAh6wiNsClEbI71kFEJdR7kYGUmF9EpaxPPYzMb8XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3tKVb5tldS2RVWXVndWlDxBsm6drzVunN8vaek6s8QNPinh4ge9A/ocBF6oYjlYNd2CI2zqaYEZo5Oj2/6eKaudiD8IDTjU8w4vsNdQwyu/Xlqoj0eMVycmctwIY5fqxb3Tl8PNVMmRVageKA/MBjFhZl93lhTWdbJH15oefJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FajTkBPs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FajTkBPs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so7620255e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782295914; x=1782900714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC2QMtKOaQEwM4fJDcgBWK5+8cNMR3gbSQC9QJtusS4=;
        b=FajTkBPsl+7xTwi4M7rHVC+8ZU5MOt8p5LpPtC1r9wnR2wGk7ka65VjIiFbotDCZvH
         us5nO4ki9fpdKRp7Y8nRC2w5F4G0jjBMA8jANu6MdCpdQRzNcIt+6r0hO9BqHP/SW3bp
         L2gXA5ghbQfDTA5oz+XnvdMlim1NhZee+ZCebbP8mrNxtAjLeGTrSNql/WHaO+1a98Zv
         4dmUyX7SH5J8ce5ak6Cedm3rR3VyTGxq8P5bx/Cbnxbc+fTOjz8mkt5ztNT4L4ZE/zSK
         uvmWlY6HGCF5mqAsegpPsl1N+L602oacAVPIEgFtNDobdHRTcBG+gmPogn1kq3ZELvfs
         9orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295914; x=1782900714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YC2QMtKOaQEwM4fJDcgBWK5+8cNMR3gbSQC9QJtusS4=;
        b=bPItFb3fggkF2z5LozFsOd5s/GbZc9BGIw2/m5nkgz2JLKy9w8p1mD4pgh5FdFV2bu
         5DhyRrh2VwVlcyBqKWZaAJqLsJdwIWh3tgEA5GGR+3quN1zuZk4+g7JmvJsaAebK3mwS
         4KvqvLXGnVHabF7ZC0k2OnhdXpQMkjgD0Hm0KWLd/SkSZgoqe3INmb8t2tsFyTbD5FGQ
         nOUfDzwiAITKEtqobvd1Xgla6Od51sWmD8hRo+NHh3V4i6eAxj2o3/jI7Su5gSmhGn+a
         0zt+5ceNjEO4yf4uAPmm/cHi7LHyeqkMSudPTtuFs938wZL5kGbIxwUpiHyXnFrxrDOY
         gvHA==
X-Forwarded-Encrypted: i=1; AFNElJ8Nl72iC/24Xm49nllbynO59gO1+iuodBuw281jPCvDXWS4+HTUckoLKTn2QS27NrBEYAcVSf9ScIJ9o51eZ31PWFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno6Mcrl7NLZLZyxMNpRnOfJN1v2aoYUCYcBcorbGQbyrEtIlb
	3Zq2OpvXLzdwBFcHD5oi9oWWs4a6m0iD59yIbQS7nghbXTrffEgpAaq/
X-Gm-Gg: AfdE7cnShW5Kk9b7TNIl+xDPt4cBVM/obecTmYskEkcaiptyrtcJMHCbVVL7uPhWpaY
	338OEq/qhiumW5vSFjfJNpdu9k5cbUBXI60Zm6s+l2lWarOPMr94fkcIogsBeO2rbyj2vTWS5K7
	RmIvyxTxI1dYGs3vJ88scZjaJMDjap/JzWUYbPHyauDPqgNbm9L5kwjlXGTm3OknXelVJ03gQVR
	290Ll5kxCLoJm3VaSRffI8fitlDtGNMY+hWdMLig+QqZykgsdb6N64sUlIrin8yurKGa+BvmrKs
	QR5ltkkzlslMAKY1zeaA8I9A1jpCZrZFoSqNT6QbXyierVhnAAMmY3WEdMit4TD4Y08tKdVpKSp
	x3jzos64QALekWyyT9ZOmkxS+ldsJgUmN6VI8uRXILMbBb3TWByorLGdOCxJIMNZI9ZRN/2nBwM
	og2XhFVdvuSmlS4sSJFy4Jc4F9C47ENK/EbndRLqyaqiel4XjB7A==
X-Received: by 2002:a05:600c:4443:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-4925a09d65emr103410135e9.4.1782295913770;
        Wed, 24 Jun 2026 03:11:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260915286sm105571575e9.1.2026.06.24.03.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:11:53 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:11:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260624111152.75476a46@pumpkin>
In-Reply-To: <20260624081948.301578807@kernel.org>
References: <20260624081806.120105649@kernel.org>
	<20260624081948.301578807@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 04:18:08 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There have been complaints about trace_printk.h causing more build time
> for being in kernel.h. Move it out of kernel.h and place it in the headers
> and C files that use it.
> 
> Link: https://lore.kernel.org/all/CAHk-=wikCBeVFjVXiY4o-oepdbjAoir5+TcAgtL12c4u1TpZLQ@mail.gmail.com/

That is all about changes to the file causing everything to be rebuilt,
not the contents of the file slowing down builds.
The two are different.

The part you are moving out of normal builds is just a few #defines.
They won't have a significant effect on build times either.

So there is no point splitting out trace_controls.h.

	David


