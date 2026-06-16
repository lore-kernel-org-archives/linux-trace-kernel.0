Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF6345725;
	Tue, 16 Jun 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642010; cv=none; b=JvRgYB584OO+z87PjSLMXArVHm3S/Xcu8WaCBqMzEkPGQtkZj3npPp75Kmw6xuVA9JRL+RgHskoMHLZa+SkR1OiF86uSxjLUDMPfWW8qcxgDFql+o09vN608eJ24Lq6bL/hh5+lJ/8Mamef8YPW11a2FWOyeNt8mEXdDQ6HZDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642010; c=relaxed/simple;
	bh=oOJT+xBykOcQjOrcemz3CquBn5TWLVgj6R6dt0lfrHs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YIVKtik+3W2geEVdzOCTLzWD1o9B4+SosqG/9+p4Kuu5637eB//iqz1CbJOpW0H8udRdxONyLf7BuoRcaLktAoqBU87+jpFuKlnXPcGrjWzRO1L89pW2Pv6/zu0EEc+JV4NvwyqIL2O16rtynsXBJKar+fmVmmlQbVszm5mknTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EiMI4r6c; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EiMI4r6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781641999; x=1782246799; i=markus.elfring@web.de;
	bh=SJrh7IrKVDGhuUdVMB9RI7EOgvgDKU6nSyp7z/DoubU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EiMI4r6ccvHWz6hrJ3P4CFWSv16qE/RR/N1FzIZZmd08oNcvpoJsd+nfOD2Y8/42
	 phxmd9DfHOkCOp2DCXV2jiTrwtB4qsM+/3WZK/k/rCN/6mMkdixYa0ZIbeCLYjSJd
	 GBI55XmBcO/3NnpnLd32GY7SloKXvQWbhXNCIF2rVwgEqT7VzJ+EMgS5YSBsX4UKS
	 RotZSnhuFMeVBac8A2j+oOvhaaucUN4shun1FUDsPWWFVCjHCqEQSsJJknaz8gdbx
	 6q2TnDh/tfT55l0eeFnBhUBxSYQYS2VEAk/79z1FdZrOnjZ2mDIi4NV03H8i9yERz
	 4t7PrxZ3jKrcLts3/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1x1BrU2pex-00ifUF; Tue, 16
 Jun 2026 22:33:19 +0200
Message-ID: <bddf7714-0b80-4e94-9da8-55a263c270a5@web.de>
Date: Tue, 16 Jun 2026 22:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tracing: Use more common error handling code in
 event_enable_trigger_parse()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6fmUZsLaGdxXHMMMSiQbT4QzKZyYl37+CUkEvO2rzp7m917KvCe
 zFNBJPCNQ4GVL6WLOUOhkpKuF1ru4fvwbDCtY6lo6EOLk83wQVcj/CaYqEpk9hKB3nDGsra
 g/H00plpgj9HdhiwwKIBGuiufnELNYIjXV06YhpcGqUfMx+TZs3qX9byO9XSUFA17X/00yl
 fQdX5Ud7uiQ3xOKKjUJnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5DZboeZoK5k=;WOrtg81gCWjCKwDcbltt0HCQCaD
 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
 kvQocUNATma4LO9sl4=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jun 2026 22:22:52 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_events_trigger.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_even=
ts_trigger.c
index 655db2e82513..7e17dd6d5b50 100644
=2D-- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1789,17 +1789,14 @@ int event_enable_trigger_parse(struct event_comman=
d *cmd_ops,
 	enable_data->file =3D event_enable_file;
=20
 	trigger_data =3D trigger_data_alloc(cmd_ops, cmd, param, enable_data);
-	if (!trigger_data) {
-		kfree(enable_data);
-		return ret;
-	}
+	if (!trigger_data)
+		goto out_free_enable_data;
=20
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
-		kfree(enable_data);
 		ret =3D 0;
-		return ret;
+		goto out_free_enable_data;
 	}
=20
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1837,6 +1834,7 @@ int event_enable_trigger_parse(struct event_command =
*cmd_ops,
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_data);
+out_free_enable_data:
 	kfree(enable_data);
=20
 	return ret;
=2D-=20
2.54.0

