Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339149634;
	Thu, 26 Sep 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361076; cv=none; b=Ny/38HPv3fM5RPkDXl8HQF/TEHH3H2qYguX4JSVN9se/7CjaRwXRGILsDhBeonFAGZFoP42RN1FcXjWAMQgYQdjLf//82g8aRgzO1BZCX54Sj2NTe4rPc+cfIT/gvszYBIInyVMat5JZ7AXX8O8B0hpHgnl2sfRRIFUytHrkpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361076; c=relaxed/simple;
	bh=Sabgc5v/So0A5uVMnvea8Vcf726GDpsoTHPYwvZEF10=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OIkzBUrXBKpUIHTq5TllxA86YhFVilcKQVYlj/ekK5fxEqWaKzcR+tO1SKE51pJkh5LsGJdtRvcTrMaamz8rETnvRd3WdcyVePrMWrc+SIRKc4QlUhEhjj07YB4jmkiYgTf4OBG4q4nTeaTWTtkS8r+8yt2cDtBypn200LvmAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u1geOgDp; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u1geOgDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727361062; x=1727965862; i=markus.elfring@web.de;
	bh=ZJwusmbK4oS5wuQQMMPIHNFuAFmP9yk4XXtmG/UEE+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u1geOgDpbmsLpnIOWkwaQ3NDuZoUuoYFUIp5xGhRSJLZfFuTqeZdjDV0oRdpgcgM
	 mEX+ifQ0ezdVZYLUcyh/MjfttpqnyRrV6V8OB9VzwxXuXV/pRPf/4+Qa1+jdRR1yP
	 Js1fVmbka3yVqMHhWYwx1muUDCNSN7FTuFgij80Lz4bWTWS8SlFJ8m4wzeVmTkzEw
	 lFZQyJQ628wZoPaATC7cnC1CAg1kOfXjfhNNx1whO30kP3nl03K3biQT4bXusw2dM
	 YuNQYZnJeHbpEKtQKCM4IiZWtGjKl5i6wX8nR9ihNEzZO+GrPmE0pm434nSXbgMhb
	 byEc7aNtWnJyYU29hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1sWeN02tV6-00OsAf; Thu, 26
 Sep 2024 16:31:02 +0200
Message-ID: <8dd92d0e-ea93-438b-938b-e966f6039ed0@web.de>
Date: Thu, 26 Sep 2024 16:31:01 +0200
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
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tracing/fprobe: Call trace_probe_log_set_index(0) only once
 in __trace_fprobe_create()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PRkxs00Gtyqm4oEEhKyNnCEpTncC0rnKKNlhLe40FU/wwSK7BDG
 HxEMagkc46Smvl0Tx3ykh6bajxDxjksEUf5RyQAV4LhLlCi0iphPN7wKljeKipgb4tUI+iE
 P3sx++nWFpVxGb3nXQecWY+2Xd7+BiPWTxGIDj2+K5AIAQ8Hw03Oo2hiF/yVmQ0EWgGzJOw
 gQj2HrtTN44h2JigX5DmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QqUJ//M8LFc=;9uFhqoq52RpnuEhNefxoBivKYze
 ehRCFt7llLSmAhurP7LamBQtoNympR7LyIWqwBpTPXu9gHrdTffAA30UXk7gIDyVqD/7dPYZK
 dgB22f1leT9heH6bk4TbnV9tY22M3MLxOelnTn06YTyEVCQ5gI4lSd4ex8bIACSivrvsaHJs3
 zm/YUBSKzW4VXGGgysgOowEIh6ZJuz+py0MeSamWdPIYszzo1rM6rlFN4ekm63RoLAPJ6NPDT
 YIPbPeKl31KGGgPTXnJ1CMZmdbn8xoV46GJCZxICGIO8RB++m/SHNbBEVI8LM0divIb7y/bfL
 EjW7FYbe9x5f+KH04IHs/QrGoJJLNYf4oj95ZtneUJcze0tS1C/ks+bMTSlHNmilxaf6yyPYu
 ALXDfITdWetLUibATdZQro5Xtfc8HLvWFjROBmijAfSc0wjO6hfB/8B8+GlXVGU4w8ZCbXjDQ
 Crna3IliW9vLdPfVfYKzZDSA+CQ6ZIlPrBq0HCaXqUGcdKarZO0X951Zip0IvlWlrnjhcx8le
 NtEB8w8JtLAxItWsmD6XBBhSgXheZOwIjz5AOmH8yTzb9XiKSmYQhm97V84zWWUt1aLtXxAD4
 kU2/y7+qAKDdukCTYawPCItQsR2u46ShOhSNY8tPgzdH5trUfu5uBs7v+VrxiVcXeGHNmlOSo
 YpxFN+6ykPMPPaf1jZc1CeBpsWJn7RMXygpXHH0Q82fWa/nQ5owlKELMIjhUe+XKJjqk8wKH8
 HOQPoHak+bhsnnn34zHDav10CCwJGMT5/aBTzgoBYc39vHZa03InLn7PhhWL0gxKe6pi0IHS6
 3lP1tlKvbpkUXJ7YMBNVC3DQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 16:22:32 +0200

A trace_probe_log_set_index(0) call was immediately used after a condition
check in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/trace/trace_fprobe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 62e6a8f4aae9..752d1f163258 100644
=2D-- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1047,13 +1047,12 @@ static int __trace_fprobe_create(int argc, const c=
har *argv[])
 	if (ret < 0)
 		goto parse_error;

+	trace_probe_log_set_index(0);
 	if (!is_return && maxactive) {
-		trace_probe_log_set_index(0);
 		trace_probe_log_err(1, BAD_MAXACT_TYPE);
 		goto parse_error;
 	}

-	trace_probe_log_set_index(0);
 	if (event) {
 		ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
=2D-
2.46.1

