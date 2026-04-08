Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A52F4A18;
	Wed,  8 Apr 2026 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678909; cv=none; b=mg8116OZ7BRbwu+UOUuxp+S7abT+ddaDy1cvti4YlnsySZ239MZLF767CzD4efGpnCorW0Lbu5fn1eNlBudM3mX2HBhQPpJzBn8/v/ggqvVuzF6SyRafGTZPlXKxetfy2kEbeXJvwlH13a4p259vtUPIGpa9+njVlJVYHbQZaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678909; c=relaxed/simple;
	bh=7ADR1Pew6O6jN0rrcwJdgCfKxMgy0ANJIf0jv2xB2bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKEfdwKWU+3uyvBVUcgzX7eCXSF7WNU/O/BdEmxTZwnNgqBVNJWbouY4HoVPJZ66DkSjw7t6bGspotocQtZsBmyvvQLw+WhHTL2Iu+oFhlP+0UTvNKLIUgpJA4GMsNLXNRrJShLgr/bM+DePdpFamzBLfiZuzwCBj05wBIvWd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id DD4191399CC;
	Wed,  8 Apr 2026 20:08:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 02E781C;
	Wed,  8 Apr 2026 20:08:19 +0000 (UTC)
Date: Wed, 8 Apr 2026 16:09:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: export seq_buf_putmem_hex() and add KUnit
 tests
Message-ID: <20260408160928.32ce8554@gandalf.local.home>
In-Reply-To: <20260408144449.57375-1-shuvampandey1@gmail.com>
References: <20260406033728.25998-1-shuvampandey1@gmail.com>
	<20260408144449.57375-1-shuvampandey1@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w3tkjfcq5dxgoorg3omis3h3b86bqbmu
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 02E781C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+1wc4s2kTWsC4mPH+ePcHnMu5D6wkSsUQ=
X-HE-Tag: 1775678899-127594
X-HE-Meta: U2FsdGVkX19VAaFXT4co0/x07rzezdTQr/8ifguHJdMGHizfhzvRJcrh42IUMowluc+rP+YxNT8qh71ms0vcsL5LfDqSRHY60x4LwmEwNA0BnT3KNfPpbL93NwHbnY3QCxeDQfR62wpqr1pECU3st3T0Rrb/PzbH224fuohLdCr2lT/tOuAnBrHrVRsvAg4GLjOQi5EfGBE5Kl8MkCCxC5//VYcXByS6JJLiViLgmntsHTs5ZNG6QWPOfxj+xVY1rBFviUpCPZ3Dhm75UaorXxLqAYyaZR8eQ3XL722WEnjtg/6sd0AVRxmx6NQ8g4TF/Y5d8VfbhB8JCMmg/4dd+gNMtu8HAJf8khzqZ7fQBRTGwGlFdOMR9qFif8U4w3k+NMDyiNdh9Xkd6jnJEUcdeHOYduzxIQA+RRB39RXZ6EQ=
Message-ID: <20260408200936.G-vcbA7Rjvx1RRAj9Kg62Q_PjcWlxaEiHKNp01MpdII@z>

On Wed,  8 Apr 2026 20:29:49 +0545
Shuvam Pandey <shuvampandey1@gmail.com> wrote:

> seq_buf: export seq_buf_putmem_hex() and add KUnit tests
> 
> The seq_buf KUnit suite does not exercise seq_buf_putmem_hex().
> 
> Add one test for the len > 8 chunking path and one overflow test
> where a later chunk no longer fits in the buffer.
> 
> Export seq_buf_putmem_hex() as well so SEQ_BUF_KUNIT_TEST=m links
> cleanly. Without the export, modpost reports seq_buf_putmem_hex as
> undefined when seq_buf_kunit is built as a module.
> 

Please always send a new version as its own thread and not as a reply to
the old version.

Also, for tracing and seq_buf, use capital letters in the subject:

  seq_buf: Export seq_buf_putmem_hex() and add KUnit tests

> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
> v2:

This should be:

 Changes since v1: https://lore.kernel.org/all/20260406033728.25998-1-shuvampandey1@gmail.com/


> - export seq_buf_putmem_hex() so SEQ_BUF_KUNIT_TEST=m links cleanly
> - validate with a fresh arm64 build using CONFIG_KUNIT=y and CONFIG_SEQ_BUF_KUNIT_TEST=m
> 
>  lib/seq_buf.c             |  1 +
>  lib/tests/seq_buf_kunit.c | 34 ++++++++++++++++++++++++++++++++++

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

