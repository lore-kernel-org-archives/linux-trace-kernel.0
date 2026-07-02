Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D535B650;
	Thu,  2 Jul 2026 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001793; cv=none; b=QmvX0ORD7/ZM/IGe4R2ZBdc9nEgCA6BxIjYEp1Ai80+R9nH7+ecjYFb4wXMgInLrD2Tq2ktML8lBZAQ56ZnasGbej/W8TVwM/USlCDHg4x9NwxZiSpCSkpX4MUf6WASdGMDlSd/m+gbywCdxYgGo9JHaYzPy+cbJ1xLFV0EJsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001793; c=relaxed/simple;
	bh=Z85jb+8UqqgBCPAI24/PZnuADNh7evVHcQB21NEnt1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prllZOgr1/+8Viz8oyC/nLKE/KNd8FBNljqZtX02ySxrKkY80qaL38XEZLPymOGcRLuV9O3eVzndH6MMgad3VYpfy9wlDmBNbhbcMJIxD4giCjdZG3tE2e52YrxZ+8txwds3cxdIzoMAS6q7CCmv9lR3ytH87wF0T6uSSRbluPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HcINw7M2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hEzfd/pD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HcINw7M2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hEzfd/pD"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783001789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z85jb+8UqqgBCPAI24/PZnuADNh7evVHcQB21NEnt1Y=;
	b=HcINw7M2iQhX63q8k9zvC+OwfVrNjKd7+9gJA1cYbxTLF6eIZJLRKPlPWLFCPc/A2aFT8N
	pG/XNl3muMzRN31vqWTqUKK5nrGS13Bn+WkRCPLcHxGpb9zdAYs3THruz+UbJ/A1l1aVqb
	zEhf9QBO/rmhxSKkU8GsGxfjJBZ4jEN7EYjgfGF8kjhsEFrmL92jg6+QAT55fQf/sShqeG
	jrPFJ580xbbpfDfKkOLeTCA/RDto3XoJc0ldoYqqEIhoOZ9Qe31gZbN5enXUBPZ55FqFXj
	gUg0nZnCwjNWatUb9Dc0FQZ+hYTPEypJQs5cyBoYduebWvFbXCAPT/AD3xfUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783001789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z85jb+8UqqgBCPAI24/PZnuADNh7evVHcQB21NEnt1Y=;
	b=hEzfd/pDhl6bBNxOMRBIYaLnIEgeNoMo0YYcg90q0H81piU2ixzbV7cL2TlE8DFWGRaNI3
	10PvYzuOau48sXDg==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 03/17] verification/rvgen: Improve rv_dir discovery
 in RVGenerator
In-Reply-To: <20260625121440.116317-4-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-4-gmonaco@redhat.com>
Date: Thu, 02 Jul 2026 16:16:28 +0200
Message-ID: <87pl15iiir.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The RVGenerator class can find the RV directory (kernel/trace/rv) in the
> kernel tree to do some auto patching. This works by assuming PWD is
> either the kernel tree or tools/verification, which isn't always the
> case (e.g. when running from selftests).
>
> Make discovery more robust by relying on the absolute path of the
> current script and traversing backwards the right number of times.
> This should work from any location if rvgen is in the kernel tree.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

With or without Thomas's suggestion:
Reviewed-by: Nam Cao <namcao@linutronix.de>
