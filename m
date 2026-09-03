Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5384B66D2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456183; cv=none; b=BeS6Fj3Y6TIyMube4FyoTpBFG6kyCEIyjGWzswsrhONWoMYtflA6mX2pEdKbN2aqfwBFGkbwsVCwFF3aE4jNMRW4wG516rFlI3nUsZEXEublN96ApLu7kEO4Zq2+HmjxD4QH7tsgVX99CY/5gCtLYVuMwZH/GUR+dEFjFBwxAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456183; c=relaxed/simple;
	bh=L8avaB3vz50XsE5RZy/q+KtmSrZY7E0I4tFrIpp9dYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMRw00ZMfBD1mUIEke/s33U7KL4Fzd8NVYQJwEyP3p/WCoAIbCt6SoyupUDGDwwG2jJ1+/b4g4uDXIgH0bmmQ659MAhrZAYorq6qWf792HPaUy6P0/Sy7pOEsZ9ynbH0t6k3Zs+d5ONGDqBxlRUt6X9+lE9L0LY9+d0t2BPyxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=eZAm/W/t; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="eZAm/W/t"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 966441A0606;
	Thu,  3 Sep 2026 17:22:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id E96F92000E;
	Thu,  3 Sep 2026 17:22:51 +0000 (UTC)
Date: Thu, 3 Sep 2026 13:23:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Message-ID: <20260903132355.4a8d2209@gandalf.local.home>
In-Reply-To: <20260901164836.D962D1F000E9@smtp.kernel.org>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-5-vdonnefort@google.com>
	<20260901164836.D962D1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zjgdrqqydd3nitpwkzhsdqytqsnpx69w
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: E96F92000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/GGQr6NM3jvmYXuhXhyVmerfxljqbx03k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=QXAEomfLwf93YfKqQJqiQUhttw7hpor21nTM2BOdgBY=; b=eZAm/W/trM3AFYMIcddQMKKYeTncGh6AIFJEhV51jinzYn9z+dyS/bANX8RJc5bX4huHue3LE/vEgfguDV/JqJ0d/57WkZBqcJoagkmPEtDHO/V65uW/GEOSkyFQrL25KLDmzIJt+0AmxCsoC1iI9uNhTjGVYwIGnex4oDPDlng=
X-HE-Tag: 1788456171-947340
X-HE-Meta: U2FsdGVkX18mJ7KLrw1YiqV7/+PpjJdm++PQHZLII+iMhBjjTsX6dHAc1XArlyGztVpT1+RcsNRaDhea/EBLtHi7tusjSo1wx8nUR8sP5HrOiaJjhowTbq3g/UAte9klUsnFnYGtNu5my2+Wf/UPb8KGpfBhDefFrxpBGsJmeyx3DIV2KyKXGxlILWKx3EMQ3o+47OIv3B4oLfFdrH5+T3pEfRpZqiSBDlE5NiHxx5C7g375aQhYNCbrlLQNgDnV2D6nSVt9GdWTl8bVfGX6R84S7/0OOERusZ8j4A6fCXZG54ipLlGtwBerRzQkh5cssMA8BOYlyGlT5XikJsncasQCLf86a2P5

On Tue, 01 Sep 2026 16:48:36 +0000
sashiko-bot@kernel.org wrote:

> [Severity: High]
> This is a pre-existing issue, but does this function overflow the
> subbuf_mask bitmap?
> 
> The size of subbuf_mask is allocated as nr_pages + 1 bits in
> rb_range_meta_init(). However, this function unconditionally uses
> meta->nr_subbufs from the persistent memory mapped region without
> validating it against nr_pages + 1.

Sounds like another validation check. Make sure what's in the meta data
matches nr_pages + 1. I'll add this:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ef66f726e2e2..748d4ae8badf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1869,6 +1869,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 		return false;
 	}
 
+	if (meta->nr_subbufs != nr_pages + 1) {
+		pr_info("Ring buffer boot meta [%d] invalid nr_subbufs\n", cpu);
+		return false;
+	}
+
 	buffers_start = meta->first_buffer;
 	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
 
-- Steve
