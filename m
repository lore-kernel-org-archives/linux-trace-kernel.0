Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F6293B53;
	Fri, 11 Apr 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357092; cv=none; b=nx1XnH99nnvi/njr5MBY4TcNTaBIIEYLavL/SPdCJFnB3nXTGffLx89U+/axFNUT+O8Grd7Jg+Ajk0+7usfr+GSqXMvgE+BvONqRrRFu/djVAl9OFsbT9isJAV9MHl88efCYA6YExq3oc+mbnLyHQe2asKa17MqkaNnzepiI5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357092; c=relaxed/simple;
	bh=6HIl3mstBTM20CVsCTcNSLtK7XmGc7uceYUfCk7hJ1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXoqw9R0C1hhpItUvGKXyJU8vACB/FHe4dOgg229KQIMGFxN3S2QaRdW+J+zTtKFwoZBKLT8rlaQLbgGMREbTl9Mfeyj3oOrlbHlky4gOHn5CrxSMCWHScMFZnJsICFU8sDi0YALyga2eezYMlpfaosuJPd8Zwg8zlgHOOP3wPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0NHbXlV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/TceHV+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0NHbXlV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/TceHV+q"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EloZIIWoDYqZTgSYqzGcgC3rbep3hk45NBdYaWQv7S0=;
	b=j0NHbXlVM0BpzLCIVVeflFaMsL7Doh/N7ax+kml4rh4cRT3NxhQ/llxhX4J47TM1oHhgyo
	eK2kudBbVOAzcdKiouaT9UZfIzLF3NgiT3glk10TDbTdbIcA63YuwLw61Ddh9VomcRnhrX
	cc8QC0Lr8sHDg1c7yIUAOZrAKh6KhkvwUCtKnAPzTK3s4F0y+8H9Tp2G2K0geJ9WVUCfhi
	15pwJNtGciscikEID211TMTAp1u6LEfGshykzwpBKTGapHScKE4hy15z0Rni4DBFjhP0Ye
	u7PHT7NAwf4XHbqqD/KRvTqZ2o4ePpxqSlDmy3sRDTPWT4o/hujpO80iEB09FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EloZIIWoDYqZTgSYqzGcgC3rbep3hk45NBdYaWQv7S0=;
	b=/TceHV+qG05HZ7uTiBVrhmR85DeYfPgY/ZMcmW0a1Df7q7j15iQNtAU1DGZIXX1bK2rier
	syXN3Z39IGS/EZDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 05/22] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
Date: Fri, 11 Apr 2025 09:37:21 +0200
Message-Id: <45b0fd8fc129cab7bac784fc1eeab9826ee7e241.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A generated container's Kconfig has an incorrect line:

    select DA_MON_EVENTS_IMPLICIT

This is due to container generation uses the same template Kconfig file as
deterministic automaton monitor.

Therefore, make a separate Kconfig template for container which has only
the necessaries for container.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Alternatively, we could also modify the Python scripts. I tried both and
this solution seems cleaner.
---
 tools/verification/dot2/dot2/dot2k.py                     | 3 ++-
 tools/verification/dot2/dot2k_templates/Kconfig_container | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/dot2/dot2k_templates/Kconfig_contain=
er

diff --git a/tools/verification/dot2/dot2/dot2k.py b/tools/verification/dot=
2/dot2/dot2k.py
index 745d35a4a379..dd4b5528a4f2 100644
--- a/tools/verification/dot2/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2/dot2k.py
@@ -35,6 +35,7 @@ class dot2k(Dot2c):
             self.states =3D []
             self.main_c =3D self.__read_file(self.monitor_templates_dir + =
"main_container.c")
             self.main_h =3D self.__read_file(self.monitor_templates_dir + =
"main_container.h")
+            self.kconfig =3D self.__read_file(self.monitor_templates_dir +=
 "Kconfig_container")
         else:
             super().__init__(file_path, extra_params.get("model_name"))
=20
@@ -44,7 +45,7 @@ class dot2k(Dot2c):
             self.monitor_type =3D MonitorType
             self.main_c =3D self.__read_file(self.monitor_templates_dir + =
"main.c")
             self.trace_h =3D self.__read_file(self.monitor_templates_dir +=
 "trace.h")
-        self.kconfig =3D self.__read_file(self.monitor_templates_dir + "Kc=
onfig")
+            self.kconfig =3D self.__read_file(self.monitor_templates_dir +=
 "Kconfig")
         self.enum_suffix =3D "_%s" % self.name
         self.description =3D extra_params.get("description", self.name) or=
 "auto-generated"
         self.auto_patch =3D extra_params.get("auto_patch")
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig_container b/to=
ols/verification/dot2/dot2k_templates/Kconfig_container
new file mode 100644
index 000000000000..a606111949c2
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/Kconfig_container
@@ -0,0 +1,5 @@
+config RV_MON_%%MODEL_NAME_UP%%
+	depends on RV
+	bool "%%MODEL_NAME%% monitor"
+	help
+	  %%DESCRIPTION%%
--=20
2.39.5

