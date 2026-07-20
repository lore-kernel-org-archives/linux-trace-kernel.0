Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C33EFFAE;
	Mon, 20 Jul 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545422; cv=none; b=QA6TO3VqwIjLYF04zb7+iVN8i2tYUY1JVMm7ix2d7KxdKtXXr3k+FOff6VLWecvv+cZAXSGp8+8Vi7exc/DA13P2EeS0iPVqHbY48H12UsKI2qPhauWMAPBCfQ+no5t+wtHw2kpDMpoEeePKGe6xxYEtaK0o3Ydh+/eEzwPURjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545422; c=relaxed/simple;
	bh=d3Lao4DiPkFf0DAjuSMH6SK9Yst+Ol3pyxm9E4ECnC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSM+4qbNfRMdC/YnKXNiW3vpRvfkg/5YbQYUuwygAlVfjezl8Q15Hf2AGTWm6V+Ra2PwVosfWZPecfkC9XuIFX3y1ouUlD1CdvFJ54r5QZc9OGTcUjS2fBRqvyTxlOUT70QZlRDavHsaRZwHR7oQ6/uLN9HKlPg1uHymnC8nPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iIHmFmtT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EvKc17eU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIHmFmtT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EvKc17eU"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784545416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sG2Ce2AcNyqijAU52tdEQPODuZAh3/q9QCSzM4qVp2Q=;
	b=iIHmFmtTUSAIdeG7nM4OMGSM8oyDo0X6eGxBOVSmYxCjLqp1c9JE4Nq8ZdAg4n89998Vab
	tewQfafZDke+MFVf/hXRZ9KgwG5gQ89P6mmjx4pjXZ9IkRenllBfyhfZtHgQuNnqEKLSX6
	hI13Bo+ND+XBmObwKEFs1YInLYCOm+i3mkeg0aRG5Re2Ghz1XUrTyAZW9PivX89x/7oY0H
	0ukYUXe+PKOBoQWUycwT1KT/0/i5vkY7E5seLLmT/2iulG4IanZ/mSkkTJN/L2lvuvthMt
	lKoSlhVteX/pG71N2BFtqxWftAKpZ0vwdZfafwFXqT21JbG46g07hfJfGh8r/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784545416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sG2Ce2AcNyqijAU52tdEQPODuZAh3/q9QCSzM4qVp2Q=;
	b=EvKc17eUgAoQvjx27OnNXnhySbnAzJZM+iOrS5C7Ep2byhE78An8+S2/PH98G6oml+pGSm
	LLfEOJuA9SmJpyBw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v4 17/17] selftests/verification: Add selftests for
 deadline and stall monitors
In-Reply-To: <20260717154638.220789-18-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
 <20260717154638.220789-18-gmonaco@redhat.com>
Date: Mon, 20 Jul 2026 13:03:35 +0200
Message-ID: <87qzkxexdk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +	stress-ng --cpu 2 --sched deadline --sched-period 100000000 --sched-deadline 100000000 --sched-runtime 20000000 -t 5 &
> +	stress-ng --cpu 2 --sched rr --sched-prio 50 --cyclic 1 --cyclic-policy rr --cyclic-prio 50 -t 5 &

These exceed the 100 column limit.

Other than that:
Reviewed-by: Nam Cao <namcao@linutronix.de>
