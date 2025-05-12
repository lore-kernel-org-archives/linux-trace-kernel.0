Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97620267F5D;
	Mon, 12 May 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047080; cv=none; b=Pq4byoxzIZBlHADtCWw3cHKzpsYQJA4X819OcdyZBg+Or8Y490JIA/v2g4QiuSznvwFMO4D29uxkMtRLpa7QimDU1WXnJpNCeQRldJjcSxj4th7K567nbq4L10+2PZClt8iwh3sX2T58kPtRkKU4h0v3G/VkraAV0VHnq4I2nK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047080; c=relaxed/simple;
	bh=1tyueKVzM1VJ1WDma6WPKB1nQNEG95uHkefHtTlXLuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXinZj5Oo27rCThWt48m1zaV4r3aDGSSl61MmTbbb1iOl4oZr1TBKJ7NQnPHOzeU4/bK/fq6PKzp7H3OjAK6auYiYkMZWUEIDDwY7SWTY2O3Oc+j9jOzd1Nt+0A5xHD4uLtObx11U0gIoEp04o0HPSrOE9JFTPqMuP/5/pIDHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPQzcBat; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dn0MNf5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPQzcBat";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dn0MNf5b"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=yPQzcBat+VPHUdjaIEBWgK4veGelpIcsYY8ejamLEoQTozCb5zv+EneNe8iGDkE36odlqQ
	jNFpsoa3Pzlyipo7tdTEFKnT+CKBPf2YOygQQabq1pR3szPcteYFQsK6pKUf5IHWGlF79i
	2+HgjWcO9gRPpjczMchHNRCebYJNVtSxJOcYR/MGda+YgJOZa6vffIprgKLmiloD7rG9Sd
	yopDbCkgZ1e8d7M8eoCzTZCE8DWC503eB6yeZFYuaG8sDF2/lhMKn0TPE38XXWtecPs86x
	oN0xUjIP6xDHvd/LQzw/+qgi1g5vPcE2CgAQlcL/cBUEJ3iItwaO9azfPPnHew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=dn0MNf5bBh9A4KmqF9I2xFqKe6a+CJ2PTEcPpogAl2WX/TfhWUVo4qw5K5lk3j69IeooKQ
	XSGxUlOKMMSHQSAw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v8 05/22] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
Date: Mon, 12 May 2025 12:50:48 +0200
Message-Id: <ad8c0a233c0dfd167530231f2f828d0d5a6af5c9.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
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

