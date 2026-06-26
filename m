Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E33DFC99;
	Fri, 26 Jun 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459417; cv=none; b=UsrNcDRgdGJu/e4K5uE9vcbEwByhiLOIzL5pQka6+aDGhirSv7qSr8UQG+NTwCuQSA3HUYSeHv7XBrVhunFaTs2Hl2sYhAxmhAFG3yDvC7oAGgBbjwaP0QsjtXTR2hMHd9Lgs84MxNPKotePQjlJV37iX4jkVnYAqOsozIUGXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459417; c=relaxed/simple;
	bh=vpx7G/Jb61wWIpvIHlUaBULZ+LZcrkW6RwRnh9ic5Ic=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PefYbreqITLu8L/yONEMyy5gO/tv16OpUhAMWA526RlG99UzoOui3RyDSXAd7E8FT+tAx9sUCwl5LyST022V2HHlUSdw3HgHB/m0PFFGE3oaHOTegw6KvnAW6BK0l+/2vLQy3Ojk0ky0VDhw9/fYBx+pGwGea1/FBXfdMNNexUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U/gg165u; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U/gg165u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782459392; x=1783064192; i=markus.elfring@web.de;
	bh=mQGdo8zXe3df5u3Oa8i4tp9ivFMRDEHb4Q0GI7B6N40=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U/gg165uomxmYVyB8XLVFr6DduUN57yrXhdCuT6e06WxgkCHavk+hC+6qx3vYQfN
	 W7btW+N/cVY6ngKB6tZvS5rlh4+QNQQ3isxw9ilAeoLWqASa9+wpajKAg+4rms1gG
	 f/1xjxAO+bEvyItdFTwfPBa7fImbhZoHB+mpf7aDYH7OjPZLz2raW5gZcdfmJ7f7l
	 MmfpY03erOGSOiiaSAWkEbHefE3NTJPWH9lVKzztrEpxCIqHxi/ndhYYP75xpKcGh
	 mbKzI/b6BUSKsILcg5+rqkiER7acYwcSahfzpennMtxShbko75e47olYg5pRVve2s
	 Ey4Wjxm19xfZ1bjGoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1wPFkQ1x9W-00FCbK; Fri, 26
 Jun 2026 09:36:32 +0200
Message-ID: <d215fa89-9a62-4067-86ec-833290f35c80@web.de>
Date: Fri, 26 Jun 2026 09:36:16 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fgraph: Use trace_seq_putc() in print_graph_return()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C+1E1Y3cd8g2tFwoDC6eTQzWB2C8Szd2KMvwDbwx6rP8QCKZQbj
 pZ33eR0eotuQvC0LT5M65YFwieh/EY9kU2NLpUawk92VF8LjHjb7QuMrJtxfDMF83O6AuTE
 /ct+bB1gLOyfj/fMj9dp3CBe/Hhq0XuykmD4aHjfqicW4g1LRQcAooiS/YeX36RaX6JKp69
 /nEgxGuq9zU+CrefG89NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mS0aysfMx30=;8b3IHAbYW96r0hCumpXxGtSG9NN
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 26 Jun 2026 09:24:18 +0200

A single closing curly bracket should be put into a trace sequence buffer.
Thus use the corresponding function =E2=80=9Ctrace_seq_putc=E2=80=9D.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_functions_graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fun=
ctions_graph.c
index 0d2d3a2ea7dd..ff7cb1a76b95 100644
=2D-- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1349,7 +1349,7 @@ print_graph_return(struct ftrace_graph_ret_entry *re=
tentry, struct trace_seq *s,
 		 * that if the funcgraph-tail option is enabled.
 		 */
 		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-			trace_seq_puts(s, "}");
+			trace_seq_putc(s, '}');
 		else
 			trace_seq_printf(s, "} /* %ps */", (void *)func);
 	}
=2D-=20
2.54.0

