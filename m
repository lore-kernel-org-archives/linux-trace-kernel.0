Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAF3382EB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430435; cv=none; b=V+QlEA7mQ6MBLWHppArPsRE97JMVbx+LYsTs+56lMbiFspV8rp8bzEotJEgtVfZu6U730OsOPokNLAsCkNSzDjxx/NW+wMsPTuoFMHwIy22xY0QYq1I4a2iXFP7a7WlrqUEJf2FznjEgKxPPznC6H3VnUcFK+NplKmdDoPllmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430435; c=relaxed/simple;
	bh=C2Yrsx8BEe/uE1erPa1D6nm5Ea5RI97rb+qpPFJ/eTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lhas2KRiZ8AEKNqulXOvj48pIhAomXLdlmseuajzvUbQetDltsh/3gmZLjP5tspmn5PEW5CYLvLrUBv2S+7i+o75E6alVu0zmx8tBndoNcHen55Ne/8WnaFG0YBDt1VHINrw6Gw2W7ZhmKYcQMh6ZuMfCr9h4gyd2bAyUhlGxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffQ048Hz; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffQ048Hz"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6580eb3fe28so4391093a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 04:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769430431; x=1770035231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNPACF7BHJNyZE5O+HEZnoBtnoLj9ZTeWesT6J0q/nQ=;
        b=ffQ048HzFLM10OSXEJikib2HL9/PDR1q2ft7HXWRguAadcW0Q378Z6fpXcRXSxZebr
         z+N9Z3EDMxxsdEytQonhF0hjoisGdWI5YWgLfLeZchjSGScJ+3Qy5AL40kfgD6QTAhpY
         LHPwk4EvVrkuhvhvWNdfkyJQJfpOaj1aObTwek2BomQaI8ltaH9VNn2D357KOEchiU1U
         voPYarssgurvcNSwpEjaXgVeVzoGdBv5EnHSDvSB0gEW+PWSQraO9qpj4km98el70cOS
         3YqBqgvz8CiN0Lk+KCfdEI7AYYFSp/CNYn/TWPDDCXT/AYmNheW0o8nTOHisWipkpFog
         jvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430431; x=1770035231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNPACF7BHJNyZE5O+HEZnoBtnoLj9ZTeWesT6J0q/nQ=;
        b=udiVav8mHxq17Utzfszzz078a5WNpp/adcoPv8Q8pa6sw1FBOPAaN/60nHVWb8lP7z
         Zw1Fw8lknFNgmHI1ewJLOSAR23SMugSEcCE0beTrMdj2150wTxqLEn08bv1h0/iG7rY+
         nxvLUt5pBvRsyBcCVjw1cFAwk9SfWtmM2nbi5/PvWVtD5ngxoItANP0uGL9SOHZFvc1/
         foiRScwiBfGqo1AngLBwQFaKeTRhaPoHMkvQmOc4YyPsoNlKSeljYPSIsKCn5J6tuIH1
         meDGRreODvfLn4G+7+9Q4u4xw39yiwz6uUyyO5+wJdvAykEU15GBC1YaIq7n7YogbCEX
         M3LA==
X-Forwarded-Encrypted: i=1; AJvYcCXT3vSZFpgS/m5Xr5F+/d8V7+Yi1UU6BqfX+xMoEAAaoGeuhWXW8XLrvKCEsgz2bt1gxAt6/DwT8lxevbu4RdI5FoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NlofZtASCJ6H4xBDlU+fq15piW1h91LnxbxkSegEW2Cj8Kry
	THzFN33ZqnLulkCj2sEUeK2RHMuiks+Xlhlzh1Z2Tnx/UjZERwodEvPLMQxhHcqvkUtTXsqfCPn
	QGjAwHLjScIabncYM1g==
X-Received: from ejbbm2.prod.google.com ([2002:a17:906:c042:b0:b7f:fdb3:8310])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:9f91:b0:b88:38e9:8f7e with SMTP id a640c23a62f3a-b8d2e89cc06mr330057866b.46.1769430431676;
 Mon, 26 Jan 2026 04:27:11 -0800 (PST)
Date: Mon, 26 Jan 2026 12:27:10 +0000
In-Reply-To: <20260112115408.48ed4d35@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
 <20260112100006.7db6d31d@gandalf.local.home> <aWUO59edshSRit-Y@google.com> <20260112115408.48ed4d35@gandalf.local.home>
Message-ID: <aXddnjiHCX-XS5S9@google.com>
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Jan 12, 2026 at 11:54:08AM -0500, Steven Rostedt wrote:
> On Mon, 12 Jan 2026 15:10:31 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > > And have the M of the other sections be R here?  
> > 
> > Sure, we can do that.
> > 
> > Are you still willing to pick up the patches? I think that is simpler in
> > case there are any series that touch both the C and Rust parts. (Such as
> > the initial tracepoint series did.)
> 
> Yes. So I guess you can still add me with a 'M:'. But I wanted a separate
> section so that all the Rust expertise is still included.

What about the STATIC BRANCH/CALL subsystem? Should I also leave you or
someone else as 'M:' there? It's unclear to me who usually picks up
patches for STATIC BRANCH/CALL when they are not a dependency to a patch
for somewhere else.

Alice
