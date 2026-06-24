Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F601E4BE;
	Wed, 24 Jun 2026 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260310; cv=none; b=thWeTR9yHwTMPHuhBOm5yLCtSA0Q99DS7V+0Yoi0ocFgZr+wVYgxj9KcxqWlH+FGiGCEyGGiNX+c5shomDRjHwEC19aV+7XGZZyWT+lG+T20VaaQG2JCyDj9+Ew/vBpWLMttMFEvwyf4guzeFOMCp0NoJo15mqoRNUgiLL5/Yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260310; c=relaxed/simple;
	bh=XzOxuRDnofjdrpT4K4fhZObNEk3P3gYfZ52SiFLtxnA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LFcw7ghXfmX/ZafGEPfNlPGC9By3/8B9k5CNC0m8jK0uTzTm/9x906ljkjF/h0D0q8+rWKluhHnB/X1zvA67bqw3vcfXK+4MTh13ZRQAAKMyZsqQVebWXJfakMaY0TxL7zCTms/8IYexGQhSd+srII5W3ZnAVuLoqBtovVe6nG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OozVl96Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OozVl96Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAAA1F000E9;
	Wed, 24 Jun 2026 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782260308;
	bh=XrdhfGcYgMenD2jjtSGlsm428jv6nMXQm1sX0BzfxKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OozVl96ZTJyZ68ickb8lSlOhTHybBuDoHD49NK8nbpQsVcT2qB8/UhoU8Hbw4kjlj
	 1/V6k6zWOZxt6R8HHLm+83bAQgCANxuhXqMDiSm7yTCS5YdurQXcNHrcPxHUMVTR5l
	 gYcDU+/CSAVvUbThXr0JygEOBufLrsWkQW+hr5YVUqlaT15ovhTS5dK58bE631UPMq
	 2ERNQ+QZzfaq6dJREhJu+6YUsgw9Poc4x6Ey0aPrU3Vr1VrbMabnqnbMT8lhUAKixz
	 qoNo39f62VBlsCZxuHiGslbZ5W94SBDxiBjqVFb3sWsAZqITOHZKKpgkFirkMq993Z
	 jVbpwdKVbUcUQ==
Date: Wed, 24 Jun 2026 09:18:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 03/10] tracing/probes: Support dumping fetcharg
 program for debugging dynamic events
Message-Id: <20260624091824.8208ab77482dd411ca9c7fcc@kernel.org>
In-Reply-To: <96b043ed-c527-4e5d-8eb7-631805da53fd@gmail.com>
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
	<178217907822.643090.14693478306190628970.stgit@devnote2>
	<96b043ed-c527-4e5d-8eb7-631805da53fd@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 19:31:47 +0100
Julian Braha <julianbraha@gmail.com> wrote:

> Hi Masami,
> 
> On 6/23/26 02:44, Masami Hiramatsu (Google) wrote:
> 
> > +config PROBE_EVENTS_DUMP_FETCHARG
> > +	depends on PROBE_EVENTS
> > +	bool "Dump of dynamic probe event fetch-arguments"
> > +	default n
> 
> Sorry, kconfig nitpick: could you match the style used by the rest of
> the config options in this file? E.g. the type and prompt come first in
> the list of attributes?

Ah, good catch! Let me fix it.

Thanks,

> 
> - Julian Braha


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
