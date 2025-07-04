Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EC2FC3DA;
	Fri,  4 Jul 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635236; cv=none; b=Wutr8FtAyEwktFHVwCeyrPsjVWZ4tT1vDmNqokJfwu9f4xqmWlGmL2forDG8nrOh0ybSjABigSlPxD0MglKHUYoPNPXx+791qNRDR/XmD+En3nTNJ+So++NmF3xVx8CKqHSoZTDkx0PVVLDhxUG7hitxh8n/y/ShvLp3Qx1QfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635236; c=relaxed/simple;
	bh=1tyueKVzM1VJ1WDma6WPKB1nQNEG95uHkefHtTlXLuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6+MJpiUnN0QuOk8cQQykJUt/yZSCPPPbcbd/zPmAVK8m75C/2Hw7nZmTHM8CqJ6pF+vqwF1aW2Aqt6mZkdZne/Y5ZHkV7TTRHinNyxcrXIuv0ZFlkqJVRM6RibjetzbU3+VYpjRJ4vg68GNzcQYvdg5IIV14AqLwesLnPViPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B268iHKV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7NSSG9lH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B268iHKV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7NSSG9lH"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=B268iHKV5vbhNOKPH3U1IHBYWgMwoiK7hk2tzXbWoAXU+yZ50zE2Oq3JsZGG1DnjWOP9U/
	f8XLN090hhRVIJreb385k1XyUPdNipSlDBMqe3x2EEWUGUSiDduk6Zm3iImypBScy5XWoj
	g85Yu5bYMp2ljexo/eAtqyMxFrQLzV1BnXcE7jS4zW4FJxw/4fSNLk0fIqWOY8dJhVWLHT
	0HV1hBAQCN2hnepJ3KLHG+E0m+7K8iCEItRAxSr/XiSy/KnhsiddDLibVoGTvyWISdA/08
	jpyqklmeBE9Zp3/ccEofAbL584E3JQCKQfIzQwv5NQyjBhWKaa1A3J9yQePlBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=7NSSG9lH8jJ1Hy/7l4y/FN8IsIinvYjrWw2Kd/smLlMErRTPmTHeV3SM1+PNnKZeKA5MCG
	vyYGtIFWzIuy9OAQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 05/21] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
Date: Fri,  4 Jul 2025 15:19:57 +0200
Message-Id: <d54fd7ee120785bec5695220e837dbbd6efb30e5.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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

