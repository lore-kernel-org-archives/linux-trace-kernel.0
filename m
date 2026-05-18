Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA71313E3F;
	Mon, 18 May 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093974; cv=none; b=SkC9eEaVrBKQCSv9I8Xb9g353jHE77Ho8Twsgl/fnUOopU8tWvk6ym3AMimsitt+AdAkNzZ6IwptFD2wzVst6w28ujVz6SYiSPykWfhocdW/IS8YZQjcIBP00Iotsvg7lOgWMdM2OTYuVB8XTObLDQ03hKWHxUIFzEel4NxP/bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093974; c=relaxed/simple;
	bh=CaY8SDvF4Sb0atpqZqNmUH8+nwzZ2DK2+Q618O9BXIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHlQa8jbgGn2L01Z1sSSZDm/t5y3EYPTfDP0hNs5n08KTbZIRe66pDdvAAWFyh70d/ezw0A9n7whKOiHbC5cq7f6CQUydRhwYN39c7E/iTyCOnPW036kyJyz3XE3xAijoTjzh8Q+8vg6p7RXXvNOjUcO1FqHRobDlBDWpo/eE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+THo8n+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xA6GP2sU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+THo8n+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xA6GP2sU"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779093969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaY8SDvF4Sb0atpqZqNmUH8+nwzZ2DK2+Q618O9BXIs=;
	b=a+THo8n++n90/soA6x3+nmjotzLsHOCoF0aDhAyZ7x8P1ftT7cW2K3RQEUYXXavAjIBpkO
	CTJ85XpbrRFhRMNYKK2i2QZJpkMeA3KyVcVrkerpxDFVKqYubjwTfotxOcwiNsNOx9T3e8
	ipq9cQNMXk7uWRF9IrPxmyPCwKv9zuK3OBbRHVjEoF5B21bma8W4cGhQlYWYqqvSF0dbV1
	4N61IxhWoiZzsbk+bsBEvs4/8VC6PHSzXcNBHht6qu4NNWHVIOtGZRcJ3SgFp0xrsoOMsw
	hCv0putY1vLEmEoNWWsBljRtJrctigQzeVW+kZQZwJ2c3aQ44J+nzWGjKNLS3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779093969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaY8SDvF4Sb0atpqZqNmUH8+nwzZ2DK2+Q618O9BXIs=;
	b=xA6GP2sUFpCJMbRSwrDEHrS03BUHrRx1BV0iKrmT69ajm85s4hDZeaJtnsQZY081YFFewf
	IfnC3xA3CXdcnXBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 05/14] tools/rv: Add selftests
In-Reply-To: <20260514152055.229162-6-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-6-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:46:08 +0200
Message-ID: <87y0hh6r73.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The rv tool needs automated testing to catch regressions and verify
> correct functionality across different usage scenarios.
>
> Add selftests that validate monitor listing (including containers and
> nested monitors), monitor execution with different configurations
> (reactors, verbose output, tracing), and trace output format for both
> per-task and per-cpu monitors. Error handling paths are also tested.
> Tests use a shared engine for common patterns.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I am not good enough at bash script to review this. But test scripts can
never hurt, so:

Acked-by: Nam Cao <namcao@linutronix.de>
