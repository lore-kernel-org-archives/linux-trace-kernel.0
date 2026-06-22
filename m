Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2F32B9BB;
	Mon, 22 Jun 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140839; cv=none; b=DMFw+3bOIO+whvuE9rRI8GsCXRRAmw6D859RIBVtZHJWG6zEMk8verEDSDqZL05eas91nVooHlPrH68C1bT7mg5OuVFS49LJnHQj0BcXn2/MfcywPghs+vaPk6L0JrQPxTqLUPCXJuYidBEoE0L7UUVmIydZG8gRniD6RErFlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140839; c=relaxed/simple;
	bh=vB4JAoppr20GGaLTk/11vin8Mzg+CQ3c2eR92eYiV8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rm3wBg+kdTQI/skYe5faET/j42tqMsWewOab9XYKXfdLNItxrG3FCsOMepMOpmDLrHwrlOKlCtEwRhJfwxQf1n84dn65rOO/axbljm8WSQxnjuHNRlkPTqolj+A5HokVk/ACnTJNA+A5BuWtn5C/9jK7z5svaHCfVsYz6LoaVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Sm87vkc1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Sm87vkc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782140827; x=1782745627; i=markus.elfring@web.de;
	bh=RD76tjPFovGNla16xOQVCeof3m/pUThLWOhuyqBDBR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sm87vkc1aPnS01uw7kXpNuIcOuVrRL1UkZVumH2CLFiSSOqkBQVP6Zz0Sbkr97eX
	 cJQUdBdQ65aLxwbBCIfo48e7iIVYFRZ3FCnmiCyBs4W1pUso4oU355xUnbhd3dnX8
	 fdl3/tt0co68cNhJbdwulyEfFVKGWH9RAzoMFabdDgcb3LDIvaMjOB1fmb2QbBP42
	 RXc2Ggf4iBJ9amCB7L8Jz6Yi3OsOaK/89TOFG3SRAQNDAH8uuMTEBWxyJPA55aHRb
	 3tBpytvQl2hQbX/CLOIm9f3prTpHzKwuQSPvRbhx8/l/dIBCOugW5lywQnY5XH3vk
	 lT/soiqk1uxIZi6HHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1xJDPx1wXG-00t0Yb; Mon, 22
 Jun 2026 17:07:07 +0200
Message-ID: <6a37c46d-588d-406f-88fa-2f8562709e5f@web.de>
Date: Mon, 22 Jun 2026 17:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/2] tracing/user_events: More efficient data output in two
 functions
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
 <b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
 <20260609121348.303ca675@fedora>
 <6762145e-3e51-43b8-8bca-a9dd200b54e2@web.de>
 <20260611085949.59017a55@gandalf.local.home>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260611085949.59017a55@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GGY2scM2gzH9TUrKe6qZgRd8I/L3/wXX1lrAaVHAxgWaimTDeJA
 zvu2201B38xL+tdCttOy53eTCU4xXG38fnyD4TvdfqJxQf1flP3THFBNPWDL1TNDdKiiETt
 nt1RL/sRUuP1FdYsExz/CS8lmPWBk5SiCwpkgklDyyz11HltvLyvqlOMs/H322xIOiyCY/U
 uhdtoyN7VFuZW5Ap/ZjWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yLPltGAEOYY=;g9PpTA73AF1bIPaFUiJMv7pfvGd
 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
 9jHkiCm5n4yqYnRfUk=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 22 Jun 2026 16:58:32 +0200

Two update suggestions were taken into account from static source code ana=
lysis.

Markus Elfring (2):
  Use seq_putc() in two functions
  Replace a seq_printf() call by seq_puts() in user_seq_show()


v2:
Steven Rostedt requested to use seq_putc() calls more often.


 kernel/trace/trace_events_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

=2D-=20
2.54.0

