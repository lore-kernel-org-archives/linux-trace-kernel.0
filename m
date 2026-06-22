Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A732F749;
	Mon, 22 Jun 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141029; cv=none; b=CTHPEYVefRB2PkaXXQA5AnlGKu7XsAs7s/tzEAeYw3yQJQdYOqlCT6lXGC7SWpKuXUBDXN4DskWnWC9n7uiHjulUpQV9b/gBnbk5/BOPy4Y8ztZPeQcycatLdvA/8QW+ooGDyV/SUaBlRFBz7p5iEggg6NOf0aQ4ltSyVk29Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141029; c=relaxed/simple;
	bh=HdjljSGMNrqygeixSCwW85bIO/KBteoBDET5ZuAqf/Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T36D3gwh9wJ3KsEdAQkepLfjlQOYY6XG7i/1F9Tkw493I1MrJqKh+37Q1fGHN5KQVviPWz0mxFuX08t/zyM05np2gAtqJfN1otqJ2525H347yKDEEkt4cB3xhWSbwFbbHOyHPR+K/zEphcrGTtDbOsYpkw6YQRwWIzsgCtUWifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d0UV3iRk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d0UV3iRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782141020; x=1782745820; i=markus.elfring@web.de;
	bh=a71zOc15zqrvtzB5xubAkTyJP/CMUI/RDsPVoHn63N0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d0UV3iRkNIWcTb1HbpX3TcjlpVUTSAXBJisfojVxDntRCMOQUyDLr2MulA6x5SDo
	 kFQJy8REi7qko5dF4k71dJnWladuDhAIVE44YMCqiBHY9QVcwzpgfzSVNOY7Zqay0
	 wYLB63w/lkwB8DtJF4EwniAq6tTBrWUdcicP27k4ek+yCenYdzubj1/crSMzxcwjU
	 7lhJa2VO3PoHSAVCbKZzRzfzp3yP1pPfoIYrPR+TJXraCOn4XtQ6Qq4iPP9TGwLRL
	 2YW/baq3lPVXlPXkhNgR3Kblw57wdJbXWYlAtxS2skfiy/VQXRYozt3Lsi8E0QCR/
	 JLDz1alpot7alNp7bA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2jaS-1xIh8K1O6W-015mJp; Mon, 22
 Jun 2026 17:10:20 +0200
Message-ID: <6bcaa4da-05c6-4097-90f5-3969f8a1dfbc@web.de>
Date: Mon, 22 Jun 2026 17:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] tracing/user_events: Use seq_putc() in two functions
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
X-Provags-ID: V03:K1:pmRlZM71/CfWD5dd1rOa0cCqjKNYxtubNP9B9sCP5syKbKTO0zU
 G0SK61btwqvXNClgOPvSPvvM/j5Si+B7rEQdekU3UfJnUao0093kFSsDYDa/HXKCcOKoFAy
 7/RySYKGvhsPk60hvPU+yDJv3IDQ93FRXCD83wgt47lX3qe3ENP/J8QvecB8O1Otbe1g578
 1+OTvqvadOn/mQKyR03xQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GwdliHFJZ1I=;gETyYARcrPKJhUWPsC2hfDjDZmp
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 22 Jun 2026 16:37:18 +0200

Single characters should be put into a sequence. Thus use the correspondin=
g
function =E2=80=9Cseq_putc=E2=80=9D for selected calls.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_events_user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_=
user.c
index c4ba484f7b38..a79b7c07dabb 100644
=2D-- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1813,7 +1813,7 @@ static int user_event_show(struct seq_file *m, struc=
t dyn_event *ev)
=20
 	list_for_each_entry_reverse(field, head, link) {
 		if (depth =3D=3D 0)
-			seq_puts(m, " ");
+			seq_putc(m, ' ');
 		else
 			seq_puts(m, "; ");
=20
@@ -1825,7 +1825,7 @@ static int user_event_show(struct seq_file *m, struc=
t dyn_event *ev)
 		depth++;
 	}
=20
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
=20
 	return 0;
 }
@@ -2794,13 +2794,13 @@ static int user_seq_show(struct seq_file *m, void =
*p)
 			busy++;
 		}
=20
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		active++;
 	}
=20
 	mutex_unlock(&group->reg_mutex);
=20
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
=20
=2D-=20
2.54.0

