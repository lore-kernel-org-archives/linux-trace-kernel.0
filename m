Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45134B1A4;
	Thu,  4 Jun 2026 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574873; cv=none; b=WXyc8b2zMs4n7jiTyxLn4msS9SQuBpVx+t77DjCI6yH/mbWh8ylWsSMFvT+y5humGHEcr1dfLWMhlZxRd14HAE5D45qom8tAusgWLjxvrbMKfvvwDZU3TQHefCR0G552ADFjUxTegXU0fxdP7it2Y3E+heL/EUwPo7KZZuCms5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574873; c=relaxed/simple;
	bh=/CNN1GZa4iwAYnfiDI2vjm+Hq44baDuFLdH3KXts/Nw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TQNvHEo3jwWVIaC4+QVxEbcS3TqCo+dvSXKoV5ovgnZ42JaNVd1rYMfGHHveCt0/eePM8I7xaToORK8492q7NbzARN21iPz8oOdATCuAUfYYqGoRpyrjT2fI5Nsd9FEaWj3pI6OAe2pfFYkMHMeKzbTz8IpOb6loF2YT5+x2W58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KmMZx5mz; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KmMZx5mz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780574867; x=1781179667; i=markus.elfring@web.de;
	bh=HerT2DuG4Qn/kGDEBnCMmjLvDjBN/zSBCgi340VXyWY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KmMZx5mzED8jvV3ITMls++C2xev2b6pmwvk3oW0vbn2oaZkqFDUaMRkBjQH5cnyt
	 eo0RyXYFn4bbWHmy9kZxB5WOkS16oFU+RuiCvqur5BCFvbe3efPGlTxlpiOXjm98u
	 YbYI+RDmQuWIMt8PqSwsf8IckudFImCWBZpY0Hys3lSWXebh0P9X9rnqStL5h7LG8
	 K7NxrNu4EIEDf14oVWJlG/ADiDmlXPaQHwoZ0Yi5SW5Hu4DaFvniZPkbVHzmXEzhW
	 2vrccNK6T2zAPpdO9pyFXBLW1WZtOnUGbsM4FXaPRM7N3DCF3ASOu2IsJZv++Q6FL
	 MMUa+qTmd9LCYkPtNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1wcY2w1Pun-00HYTm; Thu, 04
 Jun 2026 14:07:47 +0200
Message-ID: <b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
Date: Thu, 4 Jun 2026 14:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] tracing/user_events: Simplify data output in
 user_seq_show()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RD/wiVKDsbBVGxYXrheyvQuVZXI18agDYYThFSlQR6dKNnmdHLB
 X0SP471UBMEYxw2T7xhIOyqm6gwMkIMGTZBqIw7/nFK2LVKijifFIqlQ1V9Ol+2aWuXQ3ff
 kgJ2n5v4mqLPDklLCtnuznXTd1RyuT2WWS1W7LeieY7Xz7xQ0QYN8s5H5S7SywfUZgyM9JZ
 3Z3MHHK4B9tOmT7HWwRxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fAJI6t7AtiA=;prBHgNuJ+G5a9ZNtjf4+6FaW/J7
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 4 Jun 2026 13:33:43 +0200

Move the specification for a line break from a seq_puts() call
to a seq_printf() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_events_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_=
user.c
index c4ba484f7b38..a089ac30e407 100644
=2D-- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2800,8 +2800,7 @@ static int user_seq_show(struct seq_file *m, void *p=
)
=20
 	mutex_unlock(&group->reg_mutex);
=20
-	seq_puts(m, "\n");
-	seq_printf(m, "Active: %d\n", active);
+	seq_printf(m, "\nActive: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
=20
 	return 0;
=2D-=20
2.54.0

