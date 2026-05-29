Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A31A6828;
	Fri, 29 May 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060771; cv=none; b=fktJtDar9qlrloS6dWtD/MNLGRjXsfuyqzpRKZOxAac2Wy7dIAzxIVnUDH5Hkm/vjphh75EGwgcQ7n0tq1QyfYmNX1Ahd+FnQUCmIi2vQ1HxDtMDGOARafYiMOMVwmnltoOj4CJ2Pn+In6XcQ/PK8/5FRuS8WDtEAqC2Gs9Nr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060771; c=relaxed/simple;
	bh=IyPfOu6CTM8gV2/ffdDst/rxBasNecPVF9JEh+BnGEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYEF5WXdSzLgZt2ShMzWEnFEtwvr9RhozN45kUk5lHWK3NGlgAI/st5x793NxcAJS1bSwOF0vdlmjzcfJEyTd2G0Tyqn3LzwvJN+18Ne30ihsB/lrBnjPnDzFkAxJp42TkCx9B+eMaPS7OHIq20PW3Lh9tD6eUc0+C8aAwiFNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V01POmJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V01POmJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739851F00893;
	Fri, 29 May 2026 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780060769;
	bh=/NQI2tAddn15J7Pi1oSrb3NfZN0Z1CTk/3Mj2xNKEyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V01POmJN4xTrMRl8/Br919JKcmOzX541UDCMMpFo441kWiNphn8/BUXxc3zrea9Ky
	 zOjxFyFvislwIOvQwx363oKjYsS7UVcmZsCX1zaoWcFReZrTjrNUI5ONwfhNsBHNT0
	 ZvtK0YmMfW0jJ4JTAzC7zRi33oqxYw5UYG3+HeFnHjXV4sKwUgrCwZMpuAqpGTuZ+t
	 2WwNOrQzb0CHUJ5t5/IjXqp5sHvBptLtBhOJyS1tydQRq+t7j5FwsnzN4icvWUSfDV
	 pffmTU23m/CwLm+dfTqNTy4qmxVyA0YVUhtcO6PSZH8KAn01nHRD475/gHT0yKVRR6
	 kBIfgAFeVcxAw==
Date: Fri, 29 May 2026 09:19:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260529091926.52078092@fedora>
In-Reply-To: <20260529132508.2e98cab925fdb1fa7be21a9b@kernel.org>
References: <20260521225033.56458336@fedora>
	<20260529132508.2e98cab925fdb1fa7be21a9b@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 13:25:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Thus, we should report a kernel bug if !ctx->flags & TPARG_FL_TYPECAST
> here. Something like this:
> 
> 		if (WARN_ONCE(!(ctx->flags & TPARG_FL_TYPECAST)))
> 			return -EINVAL;
> 		type = ctx->last_struct;
> 		goto found_type;

OK, will update it in v7.

Thanks,

-- Steve

