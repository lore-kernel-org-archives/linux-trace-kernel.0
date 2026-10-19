Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434416;
	b=x8FDV4pK3zP5yH/c7t/JE712YwX+MXa3tLl41vr6U3xn3YKLGh7OEqXcuYOaqrqnQ5pB
	 Hvoe7AKnVlyzvc82Rhmb17QZmUdH35Iu13sZCFICLwKOehPV/p/5hpsiPut7mZx705V6W
	 IULOECgxz6C/7NX8VCAlZp46zS9TSvhTe88SfVqyN9ARWDES+IySwoBy5f+gaBiU+iqms
	 JwoymrcsE5V+ebehurA+501MP6MiS/Vv8gZMDaiTEb2N3KRBvoiUZLoG3fpLO2V/1nsXM
	 qe1zQaz0JrcWuOdU/izBF2e6wOb+yAgWhbMizyEr+K8rXhZi/tVaWm92K+Qw56G0hEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434416;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=v291S8zbhrskAiGmXdAZOWpMXFx9rIIut5jk4qgeYts=;
	b=dOqkyRqtOKTMdQxfMQqdiReAHdEbEGCX7jJ5RUZcYmXXAuucbsT4mgHubCOL+59d2KI3
	 0yQAzA1U8dLX/XAYS/SiVRMRyjJeiETLO+5YmgEin/KddOq38b+B/vxez+8HVf3u4+11Z
	 Rkbw/mnCnni536M6kQTp8O0F8w+QWUadmDTJXxfmpaFHM7v1CCml/KPF1AmWzI/GyDfbi
	 5uDdrhFtx7Hi12RDc95OpeiRSEwrOTHpXlOs2w82BTD3K7kakpvWmnZiwPr7yjkBl4FZt
	 GePYbQvXIe9G7h1yUfRY3Zt3HrVfFxDuscCU31cqCuOwiLls2k1WIsMUsxuhv9UeGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=s6JV5Id2;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3C60A3819;
	Mon, 19 Oct 2026 18:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED3C60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=s6JV5Id2
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 97F75A07B7;
	Mon, 19 Oct 2026 18:26:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 30A6D2000E;
	Mon, 19 Oct 2026 18:26:45 +0000 (UTC)
Date: Mon, 19 Oct 2026 14:26:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jisheng Zhang <jszhang@kernel.org>, Radim
 =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6] riscv: mm: Trace TLB flush requests
Message-ID: <20261019142644.5f02d139@gandalf.local.home>
In-Reply-To: <CALsPMBOKENath9-6pUoPrrSRbuudg0V9tc76bLcxsnkQJJkvgQ@mail.gmail.com>
References: <20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com>
	<20261019100029.32a09f71@gandalf.local.home>
	<CALsPMBOKENath9-6pUoPrrSRbuudg0V9tc76bLcxsnkQJJkvgQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ruerfgpgbucf4b3jwz7n6qizwws7h8bn
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 30A6D2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18E2Wu5bbf8/jfPUc7kVTZELQL3bGKLFT8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=v291S8zbhrskAiGmXdAZOWpMXFx9rIIut5jk4qgeYts=; b=s6JV5Id2e/B9xbkn6UsynIYrl6IWQbVzt1lQ0xDqq8vlNwbvooK6DBYllnmyT5fQfx5mXX6ZxTamOjFEGusLDhOSOYqt8AH7+p8yTORkrmrLjZQYfOqZU44iqo0IwLA/cZ9H9yS8+zxmouD0DHy++EepGh0v2AoYX+k4b2ySsPY=
X-HE-Tag: 1792434405-332145
X-HE-Meta: U2FsdGVkX194L7IqHr9CDX8ToVcDNwEj+Uq0XpL8H6bvgrnDgPFFmP89ZZdBbzkE9lafFC6kkBYAyD5FhG9VoI2X3Ka3HO02/0n5P8txrUGJR4iOJCX91fr79dURC6p+Uo/3ScO0E2wX2bafpaYot4VEb8IW0z6MdUyQPcgTz376y6hCuFWd8qvmSGV6yj9jTlbipgcOaG2J0tRZbQxy41rksyZEi0JNlVVtu1y0H5Y1urssWN8MoGLBSAm5pA1ULgHzxmXIMmxVDcUzd1kI6MRwO6CKTYcWAXNgtleiIADNWFrHBnWiHNKX97Yt1jce+mxm7YpC30Jpq42EhdkLnmNPpPA7rFVx

On Mon, 19 Oct 2026 19:24:17 +0200
Roman Storozhenko <romeusmeister@gmail.com> wrote:

> I've renamed the header to arch/riscv/include/asm/tlb_trace.h
> in v7. I prefer this over riscv_trace.h because the latter
> sounds too generic for a header dedicated to TLB tracing.
> 
> Did you have a broader use in mind, such as including other
> RISC-V tracepoints in this header?
> 
> If you still prefer riscv_trace.h, I'm happy to reconsider.

Either riscv_trace.h or tlb_trace.h in the riscv directory is fine with me.
It's more of a decision for the RISCV maintainers. If you plan on having
more RISCV specific trace events, do you want them all in one header, or
will each have their own "trace_*.h" header?

I'm fine either way, as long as they are named with "trace" in them in
order to acknowledge that they define trace events.

-- Steve
