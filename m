Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D8267AF1;
	Mon, 19 May 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641919; cv=none; b=hMrUd3LlYSeM1ijUbiiZwqM6VN4LMbtScqu9L1JxnL2yXi5v+yDOMOb3QmQwkJ9XwNF/uQnBaVKMkDyUndtRpw1zlQy+qtX/NCNoSMtIk2mlMbB/CcFTm7ZmCo3bs5iY00POkLxFYmQtHwDubahi+oFWKBm22J/Oy88Z6OvAm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641919; c=relaxed/simple;
	bh=kLG7ciOJXl0SnR3l4RrUmyY/7CFCcQdQNSB0+J3VE0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjpjzDSQt6yZ3hh7JjVyUh9d4AqxghzHDam1Rywzvq7D6DVKRdyMh9k2Zsb/y63GwsKhJ+xZoZOloQ+++leeOxcLuq3HC0CVKAuFnhCLYvfgHo6TGUMB+Gh6u8xB8ZlK6t3p8sg1dn71OQAJEXiH9gu6ySUB2wmhDfQxo2kWXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lB2vwCS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbKwBp8z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lB2vwCS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbKwBp8z"
Date: Mon, 19 May 2025 10:05:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747641913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXIm6sgXmXlj70dvC8HVvgmJTDV3MncbV/nS/iA9vFg=;
	b=lB2vwCS1qhZDopM9MEZNEI6dl+Eu2xslHLT9bAqz1fv9d2SxXZLL/srJdOj+WrbjPYZIhL
	sfMQU66De59xNI8JcyktCFefJlSkgSLghN4HICBWjAWQVAYUlczdgS9PBFMrW7eY2YXbur
	bD+fAtkttX0EdGmAQOlriHpVsBUxYC1QWjzMKbxP+4zRXyMfmIyYMQDzysLFZRJX/KV78U
	AbAHEce5jSU767SQtWzj6k12sKv0j0QPDHFZ0SQ2eRQGvzoUXZJgF8A4qJqLoxz7cqqBep
	h++sBrXMERUHdvJtJx3UTJlFZIeVp7uQrfrCv090VDSwfVS1RHxOXcEPBnjXSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747641913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXIm6sgXmXlj70dvC8HVvgmJTDV3MncbV/nS/iA9vFg=;
	b=XbKwBp8zWJlqo6GGb1dfmrqIQea02FnWSw92iobK2cb+4qIpF7JHkkEn8zg4TBk1yy7ubQ
	oQX4sVIV5J4ejyCw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 04/12] rv: Remove trailing whitespace from
 tracepoint string
Message-ID: <20250519080512.nWZNfeOa@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-5-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-5-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:06AM +0200, Gabriele Monaco wrote:
> RV event tracepoints print a line with the format:
>     "event_xyz: S0 x event -> S1 "
>     "event_xyz: S1 x event -> S0 (final)"
> 
> While printing an event leading to a non-final state, the line
> has a trailing white space (visible above before the closing ").
> 
> Adapt the format string not to print the trailing whitespace if we are
> not printing "(final)".
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
