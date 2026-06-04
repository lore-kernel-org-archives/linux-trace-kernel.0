Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B4425CE1;
	Thu,  4 Jun 2026 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575033; cv=none; b=YWtJ69IJrCSpAd7mOuiexX6Toja3R0vx9qm0NWnofhqqc+//3Se40QMMczqXt5g/PY+T8a28UDoPLMLvP4h0fkPtTSYHEYNStTYJBgryPqOs70UU/Hw29khWGm3yFi64ZXfeLCPcTb5GrJBrkPsAhClBUtksegDdpA9eHPaj9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575033; c=relaxed/simple;
	bh=oehSx69PmIeeRRFTGrDQNx4DQubMjWPEc1zVCrere5s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OSIasqzBRlQbymjf/0KHcQy5HTxd5UFVdc9aJ4Z0Ep0LCxLKVxavyk+tTZKuEr8qN06vdfYu++GXOnkhUq1M1PR42p4OzTML5cyvGcTFyrX8f45Q0xsY4GNdpFwrD6Fb8J5h5WtUwB4CfDSFApmRSeITYCcdMkoACc58QvlOqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u/H9I8C+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u/H9I8C+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780575010; x=1781179810; i=markus.elfring@web.de;
	bh=G4GkGQzY87Kknc4UA7EKDT5EtN7eGACOtdH2QoXkXmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u/H9I8C+s1lG1t9zTNR585BRXRvVIhS2Bqgvnc6UM408FcqZ3+7I1c2pZCn0f9Dj
	 5cxU/B6XgNrhZ8eQQJvBsA7XFFDwLDRn/LSTV5g4rgfWH2hWcRdUZG6PRtLk4t3W1
	 dpheovWdi/1HWO57330yEu7k7FAR/iTVN1IwvO/XqyyHO1+beOTIGg5v3cm0rpOq2
	 wCu4efe2SEcPHigyxzDJSHEDhgp0kHPSFbFTj57fcj+BhbZhQZTToD5uK0SOOmqTc
	 RvzjwDOpmyZ3cUXljjEMTW9R86AMHJuIfnGy7S/dIoMA8r3Z4B3KtVCIAdQWAbG1w
	 lscCx4He7IH6OrradA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1wUXKp3m2Q-007jeF; Thu, 04
 Jun 2026 14:10:09 +0200
Message-ID: <61b9034c-6a5f-45e2-b1d4-12e5590bee53@web.de>
Date: Thu, 4 Jun 2026 14:10:07 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] tracing/user_events: Use seq_putc() in user_seq_show()
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
X-Provags-ID: V03:K1:v8km2gEweVm/MlftQP0G079YvERfYJVXRICXEBZPSSXgj6iWPIb
 MPnMkyM56lD01STIVHhV9uFOZI0bxSofND5BPvaJdA+vg+h+X4Ox0vuFWAFErFHDC5NLTmw
 GwaLK3n1FcGcfLAyw+T7+cHO1RrmSTvgCF1D4DYwAxazasnjN2sW6r7uZ8HxCN7Nildeyrq
 DJLN5W0qwHJH3L/nhfLWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6ddOzAjRTz4=;Br6j8QPWZeFUDvG/t3eG2SkoFBn
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 4 Jun 2026 13:40:38 +0200

A line break should be put into a sequence within a loop.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one sel=
ected call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_=
user.c
index a089ac30e407..1a0569110bfd 100644
=2D-- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2794,7 +2794,7 @@ static int user_seq_show(struct seq_file *m, void *p=
)
 			busy++;
 		}
=20
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		active++;
 	}
=20
=2D-=20
2.54.0

