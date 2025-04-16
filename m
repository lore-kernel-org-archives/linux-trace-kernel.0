Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E022CBD5;
	Wed, 16 Apr 2025 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786322; cv=none; b=iNzL4fsmpS0h6/irRVgjVbYDGs+pKAnSaR2rTY3DRZWcM5wzUjyqeE3OUAUiuD1dU24HDeTbbeZu0bxVYuKaafBhG6VcMsrqY4PZ+Xf+vDK/CrwTDS+TN0DzYvrcC+Zh++/Pbk2SmV6LFPQp5MFhgjrVY8PGC9MBCmzzkm/5cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786322; c=relaxed/simple;
	bh=2mK6sinmKtyV1wCugMEgB2iIJSIT6o63JPL6+Fwhw2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1Iw6xJRkortUnba5NSmniTF6NgD3+BR2xsq/pu61unWIl/VFkKuWFBlIE19UPUDtKAWV4rWEf6DMDSe+mshSskChLg9U6sauE/LvHTlc+dOX5og0LeybWk1gNOOSG5+5jEy32TQMoRlJnte0o7sqMWbdfk/thva/Y6XHFNHATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2TG4IX4p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwAbu3V2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2TG4IX4p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwAbu3V2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WCyvCXKRf/F4qW3dfDg+7ZIfppz2CYPNGxpMfZcwg0=;
	b=2TG4IX4pSW5rww4LBT8QE1T79EhXpR1+BCmZxyDNCG6B8dfevcW8AabJcHtn7kY5g3xW4Z
	gJiQzYPxdXoGHd/AYi0SyFGxoq8sIbVfjrtQlPF0ca/FDoRmKVerJO+c8p9PRIMz+Ns/vw
	xP9APwVM9mP9WhOub3HRaSBbkQUDnirRQ/t+cV3EudNtn7+oMH0jRtccJJgUjjzNhpsaAj
	vu+jbNltjFGRcf9cTvcDTt8IY8NeiWoJRWAMoBl/2m7I860KNUywWyx1Iu1zlTnL3pXt3f
	aOtZgyLaSs4R6/gc1JSSViveZ+fK49JqmwqnTQda57wVgEp8fXhlxoK70ejwfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WCyvCXKRf/F4qW3dfDg+7ZIfppz2CYPNGxpMfZcwg0=;
	b=CwAbu3V2O4Cn8Wly3PGQqijfWwEZLCW7RYJcla9DCPIQjft/iVR3CgXfkmAPX278pkGo22
	ENYE80VtyWlEBpBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 06/22] verification/dot2k: Remove __buff_to_string()
Date: Wed, 16 Apr 2025 08:51:12 +0200
Message-Id: <51fc3da305876a6b328e887996f16a31733f2572.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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
index dd4b5528a4f2..0922754454b9 100644
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

