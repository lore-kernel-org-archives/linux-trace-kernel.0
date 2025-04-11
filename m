Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1692293B51;
	Fri, 11 Apr 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357092; cv=none; b=b07e/ffP/0fGRysHx9BkmQwrVvFc9PNL/vHb3s4kE8L8rB6g3otUQO/hwHKVKqEToZnRF/2THTYbEetQDskrZRv4AUxjMPl/gaOl0Ean0cMC0ZE0AsS7Xj325sH9LBXB5gOECoaobNuESYw9Wqh6UMqrra9xGNEP/wrvdPN2MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357092; c=relaxed/simple;
	bh=f7duGK5bcDK3aMZHvNBEPh5VOzT2tUDaJ8UXdI0EwFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aeCoadRWbzPTjggn1V9FHKfyeDtucGnsEljUflLudhBn1kv1XzOhE+eJyVJtwHmOoRZgf61dVSUXl98nYGPH1BZ8gol21m9jf/4IHuzaee1pO6cStMFLtj+zqbg3Kp5o5H8f9UEiG+cljCjua2OH1DkKcSky61ZDnO/ay1esQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j4WgbOP1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Ztiwtbz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j4WgbOP1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Ztiwtbz"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7d/dDyIcvRH5FcmNVkXZYOyNYgxW7/2ZD/hww+BXCo=;
	b=j4WgbOP1dFGyFIxQHkdStLjFEJ8/omoY/fLZOVeGeU+Wyudd8KFphHxQ9nXs1ek098/5Ez
	LXR6pMaHYZkZYbtFe3j+Af82nmOiiQF2iprToXxSsiqlEGkyqBDG8nxYM6CBERiSyhin8v
	SaX3rQCgbekunV3ksWK0aiEvhhC2ivnIMo9sWChtKpnpyH4Uns4jkE2ce/Bzp6M+fKuQV7
	hSReMMW6Ipz02kvtLGNggMG8t1H3ybGBaO2dVL4zTH79nHS0zFBm6ZJOxB3GgErYxWJ1QK
	h9AUk25ZbnaEKNZJMIR0MVAMp/2ahyxHjxrUpZfHyZpbNb8eEeuTRRTMu6yZ5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7d/dDyIcvRH5FcmNVkXZYOyNYgxW7/2ZD/hww+BXCo=;
	b=9ZtiwtbzfkdHnZPuQnNa6OoSisLysJZkK+V53b8CauEW8CfJoF3S1FNgBBtfRQCQ/uY+ha
	Onuy8bCgTJamu3CA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 06/22] verification/dot2k: Remove __buff_to_string()
Date: Fri, 11 Apr 2025 09:37:22 +0200
Message-Id: <5e50fa5438830238d92c037c6e609db104503584.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

str.join() can do what __buff_to_string() does. Therefore replace
__buff_to_string() to make the scripts more pythonic.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/dot2/dot2/dot2k.py | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/verification/dot2/dot2/dot2k.py b/tools/verification/dot=
2/dot2/dot2k.py
index dd4b5528a4f2..0922754454b9 100644
--- a/tools/verification/dot2/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2/dot2k.py
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

