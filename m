Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125222CBD3;
	Wed, 16 Apr 2025 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786322; cv=none; b=eVv5vCDLWB+MuDOjlg/xz+6AzJkk3dS3sXUuLIMAw1T2CMYS1ryIAtHGm+V88Jm+lUXwe3suOg8ojBVe4FWf2yT5LER3Rz4p8NCgTQ0nKapc0ZZKcBMW7h0F7XJnR8RzaqpGmlO5ACWMm6L34ls8r6ntEWPvRrKmsSGyFbK3n6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786322; c=relaxed/simple;
	bh=1tyueKVzM1VJ1WDma6WPKB1nQNEG95uHkefHtTlXLuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4ZQrWnuG920hM+lnaF507JEyv9e6sr77v41K6VuvXbkBmTVpTEnkt7NApZ8gGTsAhnK1MgYNP/mdICSpEvnbI6b2NNXyVZJN/Z1J/1DXdTVnz4mCAijTGJVDzAvuE5FsYGGgITppV1NXK0rlPNNmH+0KDsj5QpMYqjczteOu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QWTyvB6Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c3MH7OLZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QWTyvB6Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3MH7OLZ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=QWTyvB6ZL9AVCEh+m9wCHlU9Zrgoawfl7HbndLtzl9YvtrStRii4xyBoGvKzNj9GzqDh45
	WOiBjCAo9geJA7AA5I7QtUER67N4aMrNFkQ+ulVM6ByfTQCzb8IrTdFWKYu5Edg76IjK/x
	AtulJIhtDpcz01112piTNTpLOhobm85I8j9CdLW8zcFt2bv93sk574rhD1RCXUpcamf4as
	dFGs9JMO24uHYEl/AAF0Gvz+y4GPX35aNOtwKcT7clY6IuyJMDjB+me4M9f1SlwEPRtr/K
	P6vch1cx7TX3GeUfxFzneK0Wk2zMCwaHcPW1RzMlsccL5md6MrFShfii4/Honw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=c3MH7OLZHr1hbVEeOiTyvrDqEL+XmoNQrMCg8d6mi5k9qQDsSYkwH3CZX14aP0CFKKcwb3
	36fxPXzNLzIDQhCw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 05/22] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
Date: Wed, 16 Apr 2025 08:51:11 +0200
Message-Id: <cce8a4005e10ec43ee8673474f3648b6d0875659.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Alternatively, we could also modify the Python scripts. I tried both and
this solution seems cleaner.
---
 tools/verification/dot2/dot2k.py                          | 3 ++-
 tools/verification/dot2/dot2k_templates/Kconfig_container | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/dot2/dot2k_templates/Kconfig_contain=
er

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot=
2k.py
index 745d35a4a379..dd4b5528a4f2 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
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

