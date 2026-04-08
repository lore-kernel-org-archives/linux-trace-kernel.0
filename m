Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F62F4A18;
	Wed,  8 Apr 2026 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678897; cv=none; b=l910CrR4LVjXh8ui7FIDJGzIh/nmCPBkl73xDUdWM6SjL0v2CuSZA+3xyO2/w1zd5X3fI3qxp2NVW9HWXGtftvQysN/NgauUDebBNtmfDn/82ytgSNfF4IG2yx7NtPet8zyMigAyCmSw71k6nRD5NuU9swoniAREpNAB7d+YOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678897; c=relaxed/simple;
	bh=7ADR1Pew6O6jN0rrcwJdgCfKxMgy0ANJIf0jv2xB2bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL2uscwEtYDJ3XQ5uOWtRhGtkHeWmZSHaRjU+D/jwMMrxPVKwf2GXzWwD/8ZfCXNDGspWonjdsWEFjrYXLyjefd0PyudG4psD7sKXx4eGsPwGzK3uaX+L6O7vECgN0DwjzSMR2kUcfK9LtM1csCp419l7xrAB5BWKVcWn3R8zVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0F7D38995A;
	Wed,  8 Apr 2026 20:08:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 1E1492002D;
	Wed,  8 Apr 2026 20:08:12 +0000 (UTC)
Date: Wed, 8 Apr 2026 16:09:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, David Gow
 <david@davidgow.net>
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
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1E1492002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OLIf7+LLa01mK1PVoEuBUaKFpGPnJd0E=
X-HE-Tag: 1775678892-179200
X-HE-Meta: U2FsdGVkX19nlF8YRnpqOg/L/OyjX8ZSy6DV0uNVPvpN7u3vJtaePTB4SzQXC4ozQI5xtFD33+wLDF4fSsbk8hlAwwmel50MgbD/letXco9wOV8Qx/rG0yb4w78si8gMlff5JwMEOe0ihK1KquEWXWES2Gck1I1HaCjXzRmukeL6aVGY7fR3w283IMr02GChyt0Hti5pfUEHws2wU6xef86+EiCqJk/Gb74YTtLysA8WZp5LQnrFLVEXsqzAUbdcttqJYYcvQdZe+9hrVi5RtOY1p9xlPFv4kKLI/kn7vEuMBSQUi5jPSFugFOubS0j/S/3AdJkwpt6t2SMcvNv+Ej0EpzS2sTS4oy0S6eWxVeEiBSmYZ0D80/KgV/Qg6AxKwr+7zINctacxET5hpCRZUVLkoPsaXrEJUpi9vnPxdwQ=

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

