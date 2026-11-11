Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392503;
	b=E/PjzpMATdjNcrnFwoKhK/+cjFnsxiko0v9X/2T4ncEH6FJ2pUBsTZN65LsW22pUnrkY
	 wbZXYTsa3EiSTwfeP/s+16Joz3jXKhLlh73s/VyDl65N+O/4PoIvXYi5k0XrXNvpScDGg
	 KRn8R3ar83GrqaVBeOGWbkm6V664b1n75nMsmIzMY/WGIbIDAKQ4MJIA/KaRcp+KYjEu5
	 TsYqtiZWO7MKw4r471nxRf9rLRFg2vHEsts+eEhmoXVobbjh7nR5ilLpT3yN7mN+IWwq3
	 X8EIU0J0OQzIBJ/khcSRGp0Yx1VsLbBYFQJOazrxFGlGcpnYyOjNY6ClRc/ifjGrM/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392503;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=JtrPYK+FM9dETXT0UUIo4WchhydeZWLFCoX5Dma6wiA=;
	b=5ay+0tmNK4iYoxp5brdHGVrXcXRAhYA1e7ae7khaeHjcY2lrrM8QzVa9SkUTNvj8IRC8
	 zNC3j3IFxrRvkka3Wd9ueLjVlDzEYpLXF5ImwCW1QS0CHJsxFwiVCxxodyMYJmTNjugcG
	 wKADWVtE8ipXvDiZ7LOsnmgCxC6l+JfAs8jlh/g2BV/asyVPsrABbDsyBDZ3bSf3gdRvI
	 RYuRIegIxz/QxtkumeiiHHnr0P7H+Q5j/e9KsfYP+jOqASmV7cJF3b5H3HhdcRlFcF6/w
	 6fg6JB4edSHxJ8yOYwD86sbB9OzgOtkupfB0SKnujONP0XwFbkfjzetlhM3/xIAxzcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ZyDiGjKa;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7F606A326;
	Wed, 11 Nov 2026 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B7F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ZyDiGjKa
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 685051C2B74;
	Wed, 11 Nov 2026 10:21:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 4AAB72002D;
	Wed, 11 Nov 2026 10:21:31 +0000 (UTC)
Date: Wed, 11 Nov 2026 05:21:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261111052127.218225f9@fedora>
In-Reply-To: <20261111050322.49bbebfa@fedora>
References: <20261111050322.49bbebfa@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Stat-Signature: 36rqcuoqkzb9dqa4rhamztxf7jmarezr
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4AAB72002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/E2exMzSYLvMVJ8EmszwVO4UN8f/gcFAs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JtrPYK+FM9dETXT0UUIo4WchhydeZWLFCoX5Dma6wiA=; b=ZyDiGjKagsGpySSFbZ5vN6vRq+IPYhrQh21CYhS+KzkVlgOEzld5AwZMsqle6b6rbIzf6klITkHsjI+GQLZGmttUkhokRBnuGVv6RwnH211kVS3egmvBEralwk4LrGonNX8SNcSWrubsefa8MrhoZiGKrR8BjHzcm3Pxnx9/D28=
X-HE-Tag: 1794392491-33375
X-HE-Meta: U2FsdGVkX1+m/N+bfEgKFwLOz7ed298zl64XcvzUNBZqafH5fmtVoWOzrImpljfSyz1fgnvHhcNHa8w90fNN7nYO24yZ48JTjpSyv0Q8B4hO60W0xjJnKsY+wyPEiMzMqGmZ0It8EBf4DvUU+OpSnkfzbPY1UPQjBnssnN9DSuOpv/1Yytk+MkY+rCDjz292a5pHDm2KPYRl6TdeyBh3yninjDTcF1r769/RCfzds8XFjoOWLLIyx9YS6q/X9qS+WKLyZPzyRGoLNRiZvIrWpJ9bM6KaztYCgdTLY7BluhG4LYiCccM/9/0AbbYEFgK92QLfQ8BPaaG3Sk0+GNpa0rcCc3ig5T//XNKWHO0DtXmuBOtv1A10CyqCg0t4a1Mr6gf7m/mrWiq0I3tvGA+YVQ==

On Wed, 11 Nov 2026 05:03:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Now all gdb are zero when mm is zero.

That's supposed to be: Now all pgd are zero ...

-- Steve
