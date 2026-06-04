Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D67436358;
	Thu,  4 Jun 2026 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575136; cv=none; b=kyhUoA9p4sAJ0y6pFCT3oMyIeX3SODp+83hhhp4nrjkmfp+4ZuFnOfudzJpT21YW5BZ9XcOy70qDhYGLnm0/OPmCeKJxNJea+oRJ3PPm3NyTno6J7vA/2pU6SxOulusHAJIifBqgYV+gf8te0IvCONOWEjeW4or+Fd0ZMgRMKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575136; c=relaxed/simple;
	bh=Gh83y6kZv8uAAD4cOxBi2dLCkLdx01o3d9pj59dGbTI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SuH3Z7cQwQTQCNpVYeQfo3fdBT8kMdtOVtmpIAbQbXQVFLM+Jchy9Y9A/l6cUdmaycFJwvIhsw931lYxDa7hi/KA6ShpSNAnGxCkMHVWIPUlbR0VJ3sxGg/VPDE5o1Xl2iVSfbHfj6LJq7KQOSTN62yOBFzYarjbxbU6nmzRt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=udJVmhPH; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="udJVmhPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780575129; x=1781179929; i=markus.elfring@web.de;
	bh=/uhyshOx3+/MqdQ+ef8MvDZkif8gilWXXEFt8ZZVd2M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=udJVmhPH01/8U8fVEQFbdXXwbzM9Doe4QV7msfSCELmbR4KsqGdhQlbLQ2UnXJX9
	 wy6pwL4jdI0oSdFtpyMqPc0YqN58LjQK/crZS+Ktx27fa9sonUDllFvDd1npJ93rW
	 /yzpEF25c8JoIwM9JXSuutRTlzVecZD8X7uio9FGc9Y46oQ88hEArkfx+SK66H/0J
	 3m+3aYjY/HkecowzB/abKVb1Z5XUzSpdehIq4OcCGH7HR4DfTIz2m8RSiRHS/sMKH
	 9WtF1iq2klEHJAM+ZCNepmKy0YcADt5KnzcKAsLaK/qBiIrzpE8K1LnfBy1lHZ2kM
	 BHWwacycAesPE4hFsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vsx-1xHHbc0gHh-00w4qL; Thu, 04
 Jun 2026 14:12:09 +0200
Message-ID: <7d77d5eb-bd79-470a-8b90-1ab65f82de0a@web.de>
Date: Thu, 4 Jun 2026 14:12:07 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] tracing/user_events: Replace a seq_printf() call by
 seq_puts() in user_seq_show()
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
X-Provags-ID: V03:K1:5s37Mq5HaHI5bVJ9NMqby7mPd5vJW/XNoZEU1RMi2VmDY8usOWW
 Xd4JoBpNRuxUVmwBmRxE9NLdV1tS0Trkysh8zgj43aawPONW8dUkNTV70JrXaVHlHmHmEpj
 I+2T9VHVKAhx4AhZo/yB61Xcoz3gGlvM+ARybUJArFocjcfBHVsHHJ+/Mjd7XTkj0+R3AzM
 Q8pEWklJNR4CSFhYTeR/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6yppSTBcT84=;7awPwfin1xD2zV4JUsDWFnOprdZ
 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
 OqM0m1Ao8ov9Pulz9+ugy+njUhiFHMDaWc4+H9O

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 4 Jun 2026 13:45:48 +0200

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
index 1a0569110bfd..57a78de4dc98 100644
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

