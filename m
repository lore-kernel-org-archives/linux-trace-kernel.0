Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615C2C0F7C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503457; cv=none; b=E0R59N+u+wDRrixkUcVzZ5l/XsfaOcX+v+7Prl4eQugsZWV3mB203KUSS+uwJrT3l2ekzqwQspiNcAPU5THnU/IZAg6ny+yY4qmaBEH+M2JMBEmbMStXcRQM7YO6VPrZL0GcHApTuVjLCy4n/9Isbtu9Pn9o0UggVmO6fSGYp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503457; c=relaxed/simple;
	bh=3MJ2ii/ye0pMb2Bh2DBm54/4dM3YA6Zg5p8ode956TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZUedrKUwCiQwpUCnGZjgHQ/7DvQ9TpZZqHZVP4zSUouQQ/Tt/QA6aSxK6OBxnDimUUJjuTE7QrODq1WA49QCYkrRfZdQLfvfUFrmTv3bxS/g1SjvTvbuShht1FrkZ2p6lERXWeLYvQwI9gQEEGgd1Vv9zBzBP+yvYSKiUrjfbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3cVbeAd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3cVbeAd"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so45825565e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 00:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769503453; x=1770108253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAXyvcgq4gapK4XzgbxiTztA7SACwP1oODA1FepPFTs=;
        b=J3cVbeAdx91LVRkSQ915QVQsZOuytIo0TSSSyHL587WhgEjXJ9eVSnarn7ocpAUR/b
         N2zC8T8XRK8QvzLXry/ebzdetorcHNh4sOxfrFHk52LJ0o+L9m2bwo0jJoI4V9/9Axz7
         OzrGJ8gWwvb1r+jvBAdbegw7lw4eRKdgqCqTkUsJdYrIBaC7LjlhD7r1hv2tb+Ckdfue
         B37huXFZ9Hrth5fhvxhe5DM2MOpHpo+Y8UGBDHuYHovQ48PHF1QldZBPxGuAzGw2ELXn
         oFMjNuTLupGsxyFfFy9+mh96I2LI//0et2ZHyCIwMlk2v7nHPRnAdyZHvJaLk7lY5rel
         2GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769503453; x=1770108253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAXyvcgq4gapK4XzgbxiTztA7SACwP1oODA1FepPFTs=;
        b=dYWueLVlFRrvJEf+Dk0XSFedFe8egTshiXqlFkmTQBV2smRPdMGkoWsbtQtpyOXt3B
         d680G+Qh5n+32HXA4lhHvaeMSMxTYzfC+ipbBEBjc95dtUX0FBmGh63ZWmDbzz2Ua1kA
         0pNvS04LjagdgHZaEnF8uj1WVdWdj/qO8LAz6p805xSPgtkFZozI1lfBSpWTLhUSuH/z
         Gl8So2xdYc/Wzt2RdN/L7zsk5B0qDE0Dcmzx0Es78TANX8N0JG5yeqbhpDzvEH3Jil4U
         xkVyw9V3C9deg2pWthU0n+xyHQlTqFxORVpoISqQuhGeftKhRTUiTtFTGrzSv8UkYYXC
         BbLw==
X-Forwarded-Encrypted: i=1; AJvYcCXP/i6UTuRuCseWP6mXds2/EzbuwJ4ZHchdvuNJC/zo344OucHkiUuRdaB9fNR+mJl/YTVRf7evQ7psdZ5DEkW1P1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKxc5ADYtvAePXMMIZRUzl8+HG5fpQETRXuefvKn8XB8WoEyX
	b7xFhsD+S9o5g/OhJTfaf2O3Lts07OCJfIyKLS1dssL/on0CO6v2pRUEeBjXFzyzIG4qL8GeDDd
	vcksYevDrGuBzKG1TZg==
X-Received: from wmbei16.prod.google.com ([2002:a05:600c:3f10:b0:47e:dc0c:276f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1994:b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-48069c78895mr11471285e9.28.1769503453365;
 Tue, 27 Jan 2026 00:44:13 -0800 (PST)
Date: Tue, 27 Jan 2026 08:44:12 +0000
In-Reply-To: <20260127083543.GU171111@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127-jump-label-rust-maintainers-v2-1-11b7c30b11d9@google.com>
 <20260127083543.GU171111@noisy.programming.kicks-ass.net>
Message-ID: <aXh63MOsTulaQc4E@google.com>
Subject: Re: [PATCH v2] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
From: Alice Ryhl <aliceryhl@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jan 27, 2026 at 09:35:43AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 27, 2026 at 08:30:01AM +0000, Alice Ryhl wrote:
> > I realized that these files were never listed in MAINTAINERS when they
> > were added in commit ad37bcd965fd ("rust: add tracepoint support").
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Works for me; Steve were you taking this or should I?
> 
> In case Steve wants to route this:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter!

By the way, in case you didn't see it, there is a patch for the STATIC
BRANCH/CALL side:
https://lore.kernel.org/all/20260105-define-rust-helper-v2-9-51da5f454a67@google.com/

Alice
