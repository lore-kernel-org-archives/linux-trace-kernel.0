Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA126FD93;
	Mon,  3 Aug 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772854; cv=none; b=h7K4cUx+D4z80ULP3nN+V3V+DQuLAAASvzbD6yJm5RugzqXulbfi6ZYeAdoIyS6ypKTEX18Da000bJFK2dmor2WKw5yb+Mg16bi6hdi8bZeXGjxr2bro2fb5N5YaeTlREH/J2DMbTZPdoH7v5fS7t2iCJQP7cNhf8aO8V01gyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772854; c=relaxed/simple;
	bh=5royt46sB2EApVX7lNdh4bb6KePS6qMXeTl3J2Aw6/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cnZDr+jc8NZN/QOGXlhHIIfpC8sMZe7MyNKwY0z1q79z//6oQ00AEYtouNEo7JzVU8ZNy25EjvCwu0AkRjZEDf4NPQPC2mOmqAfu9tr6Lz17YlgHhIqqJe27rnfp5icH26D7BsOvokVAOJ8dkBHbwpU6z5aqnLp/lG2dNDGzKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b=CSEMl0Fv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mavick.dev header.i=@mavick.dev header.b="CSEMl0Fv"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hDLxQ09bwzMlDb;
	Mon, 03 Aug 2026 18:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavick.dev; s=MBO0001;
	t=1785772842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5royt46sB2EApVX7lNdh4bb6KePS6qMXeTl3J2Aw6/A=;
	b=CSEMl0FvXjgg5rH2tEQ4H0KlBTTB+pvEiSLP//gNLi4BAHeLvCxiBaWWj9PcwTOy9Pnq8g
	H32SNxwD81JajS7NQ1CB6g3uD+l4tX6Ia0Z1tu6/ynmdVkBBSsYBfmVSVUWKD3+FTfq92w
	19oEutkvJ4fYYyR8OWlwK4yRJR3YBru5+U7OnaD97G8yHhQT5yF1xIwAgBp1ISr2gf/QFZ
	tw3q+/rZ4EjbWb/oFTJjoTvcwUgU0S/AyMo0Y5Rwuc0G34662Z2H+LxzNYIkmOEVEPJeV7
	Q9nog+1Vp7tUCOqMZY2wmhDg/9v2P4rhjVe1BTcGyIiq4s/2Mepp4d1uUJoGfg==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 00:00:02 +0800
Message-Id: <DKFFMJZBB5MU.3G8Y73IDRTTC3@mavick.dev>
Cc: "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Gary Guo" <gary@garyguo.net>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Christoph Lameter" <cl@gentwo.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/5] tracing: add ref_trace_final_put tracing
From: "Eugene Mavick" <m@mavick.dev>
To: "Peter Zijlstra" <peterz@infradead.org>, "Eugene Mavick" <m@mavick.dev>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
 <20260803083750.GA49951@noisy.programming.kicks-ass.net>
In-Reply-To: <20260803083750.GA49951@noisy.programming.kicks-ass.net>

On Mon Aug 3, 2026 at 4:37 PM +08, Peter Zijlstra wrote:
> I'm not sure this Changelog is convincing me. To me this just looks like
> more weight / bloat without benefit.
The overhead is negligible; like other TRACE_EVENTS this is an if
statement when disabled.

Knowledge of when an object is considered
end-of-usable-life by the refcount implementation is one of the
first steps in UAF debugging. Alternatives to obtain this
information (GDB, watchpoints, manual instrumentation)
require live analysis.

When debugging from static information of remote origin,
like syzbot, this may not be practical. Live analysis requires bug
reproduction and manual effort.

Bug reproduction, especially in rare timing-sensitive UAFs that
thus require many iterations, may require significant
time/hardware resources.

This tracepoint eliminates significant effort/time cost, and
removes a hardware barrier for a common debugging scenario at a
negligible performance cost.
