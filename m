Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0AF330D43;
	Mon, 22 Jun 2026 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141150; cv=none; b=ruj+rLC0/K/3yls9KiX4ZETeG4AD9Y44OjUyWih7cjcuGSNvaKhOVNstyfw+WAwCeGMcvuiAyk7VVm7aYp/vb8cr8lr4W1gfOq0QJOap6ruzTIxfLSrjwCy7GuBHglvWGo9DDYE4F5wvJYpDGzeEigfriO+Z5ztRdMCZZnhOYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141150; c=relaxed/simple;
	bh=LhtQnROcLUX8ZQyMD8OSmwdzjH6NDyqeXVU8C8B5CGI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xak6a/2Jn3p5yYg/CaekjHyCgS6LybKvNzf8KG4F3KMI2M1huH4qE8nJe5eZ5LE52++xxY4cUt2sUIWZ1yTdxk+yZNRBMDhlfFihVs9KkXNkkq+wcinNAWHUwjjonT3d/lsG4Zcx1pGgbgJ7Nfkn+JM8YfKNV7pOa9L2LId6Nvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=btHlrJLp; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="btHlrJLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782141116; x=1782745916; i=markus.elfring@web.de;
	bh=TNN/wGWINftGdYqmBBHxmW0PXRlaDbc30U5H3LxpIlQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=btHlrJLpYVRdl8ISBKhhtjQqN7bXReBJGiMbOtKvnCDFk7ZCrK2srOdiTCUO0wWg
	 xYNmIQ6aAWyAcp5WL78vEvSFab8f8noHrIcatbXPr++n7l2L3PF5JHf3fWKa74vNd
	 sr4PqrKjSpvZV4QYLSKcCDtTnXTOsCktgIHI3fsIHbeEfllbTBqY3m/IF/oJP+Yme
	 1RCeDIXTcMmWgdSv75ySVHnOYa99O24/N44+hfhl0tNEZQDpXJzRHUZUmrFE5LrgG
	 wVfy7CC/c64v73bb+tK27Y+V4kj8UjCzxfpAoXWC+FEHvCiKZNh6I5CtgHruZkksi
	 hwLUnmpSxKTGmfwVEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgNS-1wP3Fe2LC6-00BAeR; Mon, 22
 Jun 2026 17:11:56 +0200
Message-ID: <1cf327f0-49a6-477f-a06f-2b22a167db24@web.de>
Date: Mon, 22 Jun 2026 17:11:54 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] tracing/user_events: Replace a seq_printf() call by
 seq_puts() in user_seq_show()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
 <b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
 <20260609121348.303ca675@fedora>
 <6762145e-3e51-43b8-8bca-a9dd200b54e2@web.de>
 <20260611085949.59017a55@gandalf.local.home>
 <6a37c46d-588d-406f-88fa-2f8562709e5f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6a37c46d-588d-406f-88fa-2f8562709e5f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FUvwCEvcbobzdkmKh9k2ODb2CdNjlBkiXkzcdnKsTPmC6tfT85X
 o92DtU1a6ZQnJzft6gLF/nuel9ZbkuMdSTR3cwJHYPfRJITM62nDJhH3ySG112dVuWGo9Fh
 jywBgpTV3l6RdEu5TRNl3K1bqRJc7gGvaE+OtFt6Q/KxfzSMw7mIDfcMigeYY/p4iT0vDJI
 Qks3UE4S1xTwRdAKnpeWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OsPi6wZbeRo=;iEpyYDGAntjwU//OojR/rbKQNXO
 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
 7g1OG9v6ivnGABzoAE=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 22 Jun 2026 16:42:07 +0200

A single string should be put into a sequence within a loop.
Thus use the corresponding function =E2=80=9Cseq_puts=E2=80=9D for one sel=
ected call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_=
user.c
index a79b7c07dabb..ba9cc168280d 100644
=2D-- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2781,7 +2781,7 @@ static int user_seq_show(struct seq_file *m, void *p=
)
 	hash_for_each(group->register_table, i, user, node) {
 		status =3D user->status;
=20
-		seq_printf(m, "%s", EVENT_TP_NAME(user));
+		seq_puts(m, EVENT_TP_NAME(user));
=20
 		if (status !=3D 0) {
 			seq_puts(m, " # Used by");
=2D-=20
2.54.0

