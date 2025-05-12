Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D71268685;
	Mon, 12 May 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047080; cv=none; b=PbQ1C/cjkjMK/F5k+W8AOzZZVHipsvEipjUCHpO0oscLfqIK23Cd4z2P6RPTvpYW50QLOVJPvDhS56bo6CMvOsLkOcPlZFSGn0VzTgn9LH3dp2Xqlkhbj4BjQB5cdFXrGaTWIRCe2/gbggmurkq5PYxJD1S2X63PhybxvzMQUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047080; c=relaxed/simple;
	bh=2mK6sinmKtyV1wCugMEgB2iIJSIT6o63JPL6+Fwhw2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+2BfD/sY4u0ze+YfPsQdecZYn2Xf1dPhdqpAPqjdCLau+Vr21H0k8N0orBXW9Sso1YHt1FvHoiApmtLRzw5rqMFTagj5AD088g1j98WGcX9+MeDzbe3zoHF0IMctt0NaUWhA8tDCko7paJgcqtnrDTLSWifZ956/w6MPtjLCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZnGz2q/W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viFfOlIM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZnGz2q/W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viFfOlIM"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WCyvCXKRf/F4qW3dfDg+7ZIfppz2CYPNGxpMfZcwg0=;
	b=ZnGz2q/W9IiBiinljDoOH5n7EVN0HgSXWxNT8EtIwDIGQVHBdgiZeJPnl2jzr8Di542w+C
	UQw7Un3noLhsUPXXvUKs54+hWP3J9GmPvU7ROQFVFa1CP7Egeg9u61UqmL/OLZn4RjhzYg
	6RpztH6IFpc9mUoxjeRWUJBn+kvS1lSwGZp+oAYjc1Io3IVODDNLhJXmrpbdy+p/CpeEN6
	vL+5jqxtfnrjOhiY5S3Bc05Wftmsf4cWz9I7wcYyZRovCl8qwkuip5tIgEtxwQO1C4xAuB
	vrjuu7V553X1vtJXz0u+sXRL1Nalsj8wwmPBK8BWOEw/FYJHb2iq8LEipn4uoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WCyvCXKRf/F4qW3dfDg+7ZIfppz2CYPNGxpMfZcwg0=;
	b=viFfOlIMndAJT4x6tjWVDwVNYyxJL7n2HVLyVXKT77dozPbGvOkZE6bHr+rv2yhXTTL/8O
	iTgkNVnMBNewfaBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v8 06/22] verification/dot2k: Remove __buff_to_string()
Date: Mon, 12 May 2025 12:50:49 +0200
Message-Id: <d7d7d04a29e3b51aeef60eadad531585e724975f.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
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

