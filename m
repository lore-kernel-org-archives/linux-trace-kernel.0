Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D76387369;
	Mon,  1 Jun 2026 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300603; cv=none; b=HPDLmuoNEoCRZeHHbvKyupCQp4vKK4DL5gBV9RB1LUncEI2dpJltefntGZ3lJSax651QBcy40N9d5JTCb8W2BOmZbAJuDg62jx4i+cvUotGmx/tIvKsgByA5LD3jLCCgYtzpcpn5u/xKfhLKAStgOAe6jaED0xNOugi90etvRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300603; c=relaxed/simple;
	bh=h6PBYFVllnHl1fmo2yw2+wO+ZO8WP4OGsaUkUubsmGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIFklGh7ZAVvxLARAmUfyWJWZ3yzRqa6RmK4wOc0upGiRbN+cJZBIe6YMmbPUmedtKJy7ZAcGeZjO6Am7YsRO/OPwy4HuTC8/dhqQvt2yFLzik6sJGl+yRWLPvCWv7Ytgn39UdvP2dzrp2/YG0l2hkGdAZ05EoUGMAQ/VBkqHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uIPcp9/5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fDdIfigo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uIPcp9/5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDdIfigo"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780300601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6PBYFVllnHl1fmo2yw2+wO+ZO8WP4OGsaUkUubsmGY=;
	b=uIPcp9/5kvv9AP39h1dvHWAK8SIZhomF4T9BTikwWwdqkN5F6qpaV247vP8BgVTfKxFF4a
	M3RfnYZ9ZL7rF7C+lt9C+QFMsR696E2Elt3TGQ8IxeCPAJK6bYoPfwxDdoA905rkD/YyHe
	70sO5Lc/l2M0idfK6bHSnodbw/dCGTLsaE8klE3DNPFOaOt9Tt3c8ZxQlGQnDw0GK8nk0p
	puPAoyBQsTwV3neIKYXs0g7hqeYQQqk3IRpGU8/FGuQSGKwBVMh2vO/4cKfAOLcm/oNu1/
	jxj2VDPR3LtQv70E573SzxWKoi0dw4zUTFjI1ck6mSx+A5dhXl30h5Ozhs2wYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780300601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6PBYFVllnHl1fmo2yw2+wO+ZO8WP4OGsaUkUubsmGY=;
	b=fDdIfigoyjtDp4DySLqdy80UX9XEJAi9LBOjpHBjGhLj2Ir0qJpqDEwnkWpx2RIEJxb8NC
	1UlC4yTN7l9ZoyBg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 10/13] rv: Use 0 to check preemption enabled in opid
In-Reply-To: <20260530141652.58084-11-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-11-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 09:56:40 +0200
Message-ID: <871peqy9qf.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Tracepoint handlers no longer run with preemption disabled by default
> since a46023d5616 ("tracing: Guard __DECLARE_TRACE() use of
> __DO_TRACE_CALL() with SRCU-fast"), the opid monitor should now count 1
> in the preemption count as preemption disabled.
>
> Change the rule for preempt_off to preempt > 0.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
