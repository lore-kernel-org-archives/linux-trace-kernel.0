Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB97355029;
	Tue, 21 Oct 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048319; cv=none; b=mgBZSVnRHTuPPYL78oyr5BXPtuOW8WxvwYh5HRcZy8gMKfs78JVQgrk7XgcY+W9Sxr8KNSqjR8wp+WXFQZakHH5A9l/38zcEuH4avujxYzDH9fho8V4yDPr2B1WR1Xd9bhIdZzrkxxCbGRu0ccVcgImkq1TlZFAHNSgqBxD/ZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048319; c=relaxed/simple;
	bh=9gtXGABCKV5C8jBZJ0uyZGTM/sXQP5TWXUnHXdE9AJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pCIzl2ABO1kp2y6cZkdioN9yimhlyfrfE3rZCuI5xKvnqGJmE5+q0wtiQ0CumWwFEAU5HdY4+gI5Gq3K/SWzV30lVhrWYzn53s7BqPSQKPFkIucliuRQnEY6bj3JNFOxd1Qv38YswJ8LCpiYinh40h0Z3Qg9o9djfiPSeekFMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wF9rS8m9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K5ZZt1Nz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wF9rS8m9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K5ZZt1Nz"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761048316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gtXGABCKV5C8jBZJ0uyZGTM/sXQP5TWXUnHXdE9AJg=;
	b=wF9rS8m9WtM7JgxpjncZs01R6QMCSbn+rUj9j///YhUgmZsaJ0gU+vXxu2YhDvRm1z3U/m
	V+f/dPA6kg5Ou7L+ZT8r5zQaYrCGdDXgyV/wUd/VCDnjJ+Lrd0YcBPYLMQuoXrTGYwJfA6
	PeoPRHeBnHIPzhJARB7YtV0msigvROVllCvAadZAvN3ncX5kafIS+58vZYnfWwOdnEOdJb
	06CmaKsE34bBYVtR2dhOTA16TcyJHFWdSdC6SjIiUcrUr5Huy09RobSuSsKoTzMPYCUy0k
	Hv79WXt/AwQy7BsReyokMB3Mj8pJgPMJYtBakQb9haq4cYvq2CCc7coyATFxQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761048316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gtXGABCKV5C8jBZJ0uyZGTM/sXQP5TWXUnHXdE9AJg=;
	b=K5ZZt1NzRTLoFp9t+RJB24PqKPU3L2PqTNoSb+monuxS2Z3B+/mpN/l5EvyQtzSI6QOZ+I
	4lGfyEux9+ixfvBA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/20] rv: Add Hybrid Automata monitor type,
 per-object and deadline monitors
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Date: Tue, 21 Oct 2025 14:05:15 +0200
Message-ID: <87ikg8bguc.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> This RFC contains several related changes, I'm sending them together to
> give the full picture and get early feedback but I'm probably going to
> submit some of them separately.

I'm done reviewing the series, sorry for taking forever (I have other
urgent stuffs going on, and this series is not easy to digest).

Overall looks decent. Thank you for this work!

Nam
