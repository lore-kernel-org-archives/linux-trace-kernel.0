Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0F1E835D;
	Fri, 11 Apr 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357090; cv=none; b=r/B9+ybgh9IWjPJfjhftakb0Ta66VaQfPOj3U8LqoZbTOslmQvCiEfd05NcrhImXApjV5z3WEEd8YURdx4iIUE65ygXLOCltab0o0az1vt3Kkv/upWic+SRdGWKPjcqn6KmIrfYIljWTQ4HPwYUmVbMUh8uy/ysLylgMw9/+GSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357090; c=relaxed/simple;
	bh=+NsWqENBydJJVCUcaSKkK/2Ec0MupcO5bHTy1v2Bm70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khIwP3Un0wEaHqA6Z0AvkImw/wQfagvNg/ISr0SAW8u1R7oUnoeAPwg81xYREDXz++34BFHoqNbpc3f+yGrp3SXogTARgIKPez92wwwkDEXns1HlGDddsZhD44kkMp8z2sGjEwfCixV4aj5e1Mklgz94t8ayHpXP+iRY6J0KSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aofpIFhz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACUkKnny; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aofpIFhz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACUkKnny"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVDMX84hd6bz/tQD19PBTpbgGiCqzimLkE9uEALU7eQ=;
	b=aofpIFhzZ4WqCwjpm646RqASA4SM1lI2mvnhsFYNGiesCDb66dGeb80Qzrd65GnskDwu1t
	T2vTqvCxHC+ftpdhtoZaKe9CWpoRMvK0Lm5NeobZVTz39U1asskNloLQOgV3X6HlpHvxwG
	mT/zuflC+50nK9VoGZPaLbMCkqHrPW+1qu4UllPsASKz85HlQFtocx9lZr0bcvOZ5BfKa8
	Zs5zuIJla0zmZsioNA6MYqNdne34BP2WiikYJh4OVFe25FzlgJqz85JvSzpapwO87qGqxc
	wGkKlWsrkECnL45qgmE5Qh04O/86ys5QQo/aA9oRuC5uHREQkrU5Qojx9joJKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVDMX84hd6bz/tQD19PBTpbgGiCqzimLkE9uEALU7eQ=;
	b=ACUkKnnyzW9BQJMpyQVizVtDvMOrj8SXSeTwJMixGYzXJYjNe8V61TfpQrfwyU4qn6JpfB
	QJMLgwce+P9xNzCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 04/22] verification/dot2k: Make it possible to invoke dot2k without installation
Date: Fri, 11 Apr 2025 09:37:20 +0200
Message-Id: <caa6a7668f958c68fc7b8a40256e3edf3f11ae99.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without installation, dot2k doesn't work:

namcao@yellow:~/linux/tools/verification$ python3 ./dot2/dot2k
Traceback (most recent call last):
  File "/home/namcao/linux/tools/verification/./dot2/dot2k", line 12, in <m=
odule>
    from dot2.dot2k import dot2k
ModuleNotFoundError: No module named 'dot2'

Installing dot2k to the system is not always desirable. Sometimes it is not
even possible (e.g. no root permission).

Restructure the files to make it work without installing.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/dot2/Makefile               | 6 +++---
 tools/verification/dot2/{ =3D> dot2}/automata.py | 0
 tools/verification/dot2/{ =3D> dot2}/dot2c.py    | 0
 tools/verification/dot2/{ =3D> dot2}/dot2k.py    | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/verification/dot2/{ =3D> dot2}/automata.py (100%)
 rename tools/verification/dot2/{ =3D> dot2}/dot2c.py (100%)
 rename tools/verification/dot2/{ =3D> dot2}/dot2k.py (100%)

diff --git a/tools/verification/dot2/Makefile b/tools/verification/dot2/Mak=
efile
index 021beb07a521..7a2ec30014b0 100644
--- a/tools/verification/dot2/Makefile
+++ b/tools/verification/dot2/Makefile
@@ -16,10 +16,10 @@ clean:
=20
 .PHONY: install
 install:
-	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
-	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
+	$(INSTALL) dot2/automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
+	$(INSTALL) dot2/dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
-	$(INSTALL) dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
+	$(INSTALL) dot2/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
 	$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
=20
 	mkdir -p ${miscdir}/
diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/=
dot2/automata.py
similarity index 100%
rename from tools/verification/dot2/automata.py
rename to tools/verification/dot2/dot2/automata.py
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot=
2/dot2c.py
similarity index 100%
rename from tools/verification/dot2/dot2c.py
rename to tools/verification/dot2/dot2/dot2c.py
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot=
2/dot2k.py
similarity index 100%
rename from tools/verification/dot2/dot2k.py
rename to tools/verification/dot2/dot2/dot2k.py
--=20
2.39.5

