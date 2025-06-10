Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235028B418;
	Tue, 10 Jun 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548646; cv=none; b=B14ma233J9ijUubTaQ67w7JuZizmjktBtpPXdOFGb/ZR/foHqiwClRLFUOeRfp0hFEWzeunG8tj88bOtVVaFD5loYAbm2Nf23U/C+n756mW8AQAQ7D+g4pkXi2NaWvZ4NIP4o7ZKYNiqSZrZaZgB364Q7GPO4+6jnpIzZymMfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548646; c=relaxed/simple;
	bh=aVeUIsjpf5+mURgHI6IeZ0o4Wu/8m6En9Fdfv4aTkQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHjzEOvP0xqi65HYCd9/tXceWM6xLzZbKRfq7OONgdj2ij6WZ4XV0AqnuV0g2aETSgHJ8G0K5gktxpJ3g5keflrtWeVHnhsQmcU87jyiMBRx+nSff3zOxVjFtLTkIHhKKBvohrGQd/CBgtHLSMzRoeHjhzb+jG/L9OU5pKzBzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBlY/VVK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXXschd1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBlY/VVK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXXschd1"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4kSZNkBr4qhsThf1JTD1KjekceuCjwHrbqUJpIVKQ0=;
	b=FBlY/VVKQ765G2c0UsADZY+RqE+HY+iEu4kCCXJRS9s2em0PI7VoRB+5J99evI+3s4YMja
	JM0pXbZdUapDw6xjeHjO9efakFTkiYNBrjbYHzdfs+8lqCBCsDHblTnDPGHmg2Qqi8aQRt
	+m54mjjBf1O3vswHdFlAbrbeO53H8Ku15X/yhp2u8kkjNH5PPgUMwDZ1Micd99F/Dugr6f
	e+Q7HLoiNkJ3yLuV4gfR2zhsux5mRyeNl5TrICajHRnbGAWXzpnLiXOu1peCgeeToY4qIG
	xHxDDPv3Yfx53cBEC9hd1mes8tbjudO+FBCP46xkd07wiKePEmMZ9Mdz93ggqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4kSZNkBr4qhsThf1JTD1KjekceuCjwHrbqUJpIVKQ0=;
	b=lXXschd1KVrC2pYHHF++S5x2qsCEjvvYFSafNE7LsPk1ROgzj+sUnNEj5cO+m3J8ka+ODD
	P/MrZK6VfO3/geBA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v10 06/19] verification/dot2k: Remove __buff_to_string()
Date: Tue, 10 Jun 2025 11:43:31 +0200
Message-Id: <5706293606df87277702f6165146ca8fc15bc6a1.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

str.join() can do what __buff_to_string() does. Therefore replace
__buff_to_string() to make the scripts more pythonic.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/dot2/dot2k.py | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot=
2k.py
index dd4b5528a4f23..0922754454b9c 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -109,15 +109,6 @@ class dot2k(Dot2c):
         fd.close()
         return content
=20
-    def __buff_to_string(self, buff):
-        string =3D ""
-
-        for line in buff:
-            string =3D string + line + "\n"
-
-        # cut off the last \n
-        return string[:-1]
-
     def fill_monitor_type(self):
         return self.monitor_type.upper()
=20
@@ -148,19 +139,19 @@ class dot2k(Dot2c):
                 buff.append("\tda_%s_%s(%s%s);" % (handle, self.name, even=
t, self.enum_suffix));
             buff.append("}")
             buff.append("")
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
=20
     def fill_tracepoint_attach_probe(self):
         buff =3D []
         for event in self.events:
             buff.append("\trv_attach_trace_probe(\"%s\", /* XXX: tracepoin=
t */, handle_%s);" % (self.name, event))
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
=20
     def fill_tracepoint_detach_helper(self):
         buff =3D []
         for event in self.events:
             buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoin=
t */, handle_%s);" % (self.name, event))
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
=20
     def fill_main_c(self):
         main_c =3D self.main_c
@@ -210,7 +201,7 @@ class dot2k(Dot2c):
         buff =3D self.fill_model_h_header()
         buff +=3D self.format_model()
=20
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
=20
     def fill_monitor_class_type(self):
         if self.monitor_type =3D=3D "per_task":
@@ -242,7 +233,7 @@ class dot2k(Dot2c):
         tp_args_c =3D ", ".join([b for a,b in tp_args])
         buff.append("	     TP_PROTO(%s)," % tp_proto_c)
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
=20
     def fill_monitor_deps(self):
         buff =3D []
@@ -250,7 +241,7 @@ class dot2k(Dot2c):
         if self.parent:
             buff.append("	depends on RV_MON_%s" % self.parent.upper())
             buff.append("	default y")
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
=20
     def fill_trace_h(self):
         trace_h =3D self.trace_h
--=20
2.39.5

