Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5C407590;
	Thu,  4 Jun 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574767; cv=none; b=st4Fi65ig0mx2zsrWaTWneIsYO9sQm4P+WpHyCPP9uBIhDJIIOXlC6AScYABuxofNiF4vsldsajez0Q5EWCuEy0YaxbTf+XIgjfzSN+VVsEJ5wIoexXqFxBwTQzKhCbNNuVBXcVSp1jNNSWRjzem20eb21lC1DStEUO/nzU7d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574767; c=relaxed/simple;
	bh=AvW+OD+rktk3SOUWk60xWw7CyvzMn+krbROV5Jtyjkc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=e7drIC/cLNV7m3bUW6cttaJ2eEJ0bE30BD4k/4nhX6zS2g145uX95VAnXJtc7bshQsd7gwmPkyee6Tr9RBrdA9N5OSIwbVJIQkT8k8m83X5qYgnImjGqZo6vX35tX07tCWwust+aAmkFEJKTRdVNIrRLCy9MKigmy/1bnznNQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gzUqzu95; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gzUqzu95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780574742; x=1781179542; i=markus.elfring@web.de;
	bh=rwW7+ZkWES8x3QhN11A0aOirlDokx16WAFQGVhMokgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gzUqzu95eySf6wHXTssGONyplb1NtcSAVoG5uizvpfuNYgVGPIAn+VM7EfLUhvmW
	 HKDZIkBN+YbJ1UhE12fUzt58DeJOzK/PSpAlue/oqCyr4btoqB46XrW6WgTSADm8P
	 O1iBfTuZ/2Ol+btMg1XtFYRoXTWJNSuNXlR3y7iLfg/f9BpBSfevRSMzMjhPRdNFj
	 LH4E/ne+O00l/JzQvSPfqhzMBhashPuLhSdeOiFRfkRb+OaW59JR6Z1SuTM9CBzEr
	 lx+LV+SNHrXH8tV++DMLdSyQDTs8U4XZLuHkkF8pZSB/ctNEM22OIhn0d5/IcQxDq
	 VdtQeMCP9XYhsRPSxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxsD-1wsR051lVX-00WKac; Thu, 04
 Jun 2026 14:05:42 +0200
Message-ID: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
Date: Thu, 4 Jun 2026 14:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] tracing/user_events: More efficient data output in
 user_seq_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g9K3tODlVPTKtK7FtvV+LOZcYHezxbI6ovCSp0FGBG6StT6BiQg
 v3MBcUtH50KrMECOPnMeg9/RzH7VW48kmhsBk6My8jxLu9/r0LND+7RM2rwMMSSyGPzwnm6
 5IIuCzaQYc1DzV2+JLl2iCBdynt+pAgAUYeNCeEirykcmAIayvz6/V2KBe6D2ouQMmX4LSt
 FIE253YIHQwBksRlw6wig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fP5+bX77ux4=;1LCiS1Ccbtfiaa2tcmL+86rE2DQ
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 4 Jun 2026 14:00:56 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Simplify data output
  Use seq_putc()
  Replace a seq_printf() call by seq_puts()

 kernel/trace/trace_events_user.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

=2D-=20
2.54.0

