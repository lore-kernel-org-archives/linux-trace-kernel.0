Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FA42B317;
	Thu,  2 Jul 2026 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993506; cv=none; b=NWePCuNcSGSRrUYor2K0TtQrscNmXlhty/ID5141Xu31o4n+ItpbyLxGYATCOyFkw5Z/pZuEcDPGeRXWoJa0r4Uo+L6AnWRVaf4cFnpCHURan3k99O7Nfiy5pC4HyvB0SYwiWDYzkV23QX5b722DOQ7Mx2pQBZg2HRWKoPpwezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993506; c=relaxed/simple;
	bh=+kPgQfYMQKOvcV93t0oJpR8DP18Wete2tufZWuwydqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uF+XMShBqeY5aYbP1n8GosRVqYPlwUvrOrFaiHoP4u6FNuEv+Y+BbE6x+p6SE7kF8H+5Dkpaja/hkTpq8vk44t2kep+LlLaLMjgG0H3RxLVZLII892VNHGEZT6qAi4cVw1yc9qNfl79+dJTtNgZg2kqfT7zUDje9OH8jzvDRndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DxDxwTJ6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DxDxwTJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782993497; x=1783598297; i=markus.elfring@web.de;
	bh=+kPgQfYMQKOvcV93t0oJpR8DP18Wete2tufZWuwydqk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DxDxwTJ6w1WLGPfXqnXF81cQNCNxrUmU+UNNUpzDc2L9INmPkwmTH4ovYm21p6AE
	 OHCwGz7AgDYTjSKF5cpbLBMwKL4aw8Nfz2dZvXjuf1JRw84XZVdfkjxMy7w7UpVJU
	 TJFLXWUZktEdYVbcMU8OP2pHJwg8HTvWX/zhOLRAEbsOSvzpLDb24w7Kb+cmFonUy
	 /SyN6sfQOeeL1C7AYouVP8oFI14YjK2HoC8vpSZPHC02lsdAKLiynw7U4S5aBzgb6
	 0hplKGOaqIS0RngIWfJ38rDVeiAMH6vnrewiGBeokWk+Hbvzqb9C04Hv3cnVoLtPs
	 y4T/+sTioXztXSt+Yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNOVK-1wTd3K3pqE-00I7LI; Thu, 02
 Jul 2026 13:58:16 +0200
Message-ID: <b0adce44-36ed-4b2d-9ca4-56665b22d409@web.de>
Date: Thu, 2 Jul 2026 13:58:05 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260701174829.67ab8a33@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260701174829.67ab8a33@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aJID5Vu/A+j0XyXuYoqcjA4lA3wGSOu5wgRF/vdSoYz+gp/ylAP
 7yWNfKJtDsH2DFXskLq+MMpobm2OcJttxeRdhGdpTtY+88wL3cMOUPbK9VJSu1BpM2SfauU
 QluT+Q3lzQlfQFxErow7a1ioJXsQBOs6Q2HTUwsskLLTbs0uRuM60I3tUtZwBqOFNiidOXz
 qt7xT8hyJx1Un7X4Z13ig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wdWnvfSJxR4=;lGZLVKPMfVYo/99gsqgruTUu9Uo
 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
 FU7V4w==

> The enable_data variable gets freed on most error paths in
> event_enable_trigger_parse(). Use free() to free it and just before
> returning normally, call no_free_ptr(enable_data) to keep it from being
> freed.

The conversion is incomplete for the application of scope-based resource management so far.

Regards,
Markus

