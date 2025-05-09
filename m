Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F2274640;
	Fri,  9 May 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778367; cv=none; b=g4mN5Bcla0v1tLAJni0BcmR25IDINzNFx2ipFi/eBm3HhqugLh5kxF+v/Gl/xgUWe3als//y8P7nSht7PyPBsQ0UbhZXZZ3eEFKVLs7YPurKgJ53txNGYMrhbU4uXWhFGSrte5v+KSiAfHcU3Ugj2SdmygEpfmlV1Z7gjdkFbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778367; c=relaxed/simple;
	bh=1tyueKVzM1VJ1WDma6WPKB1nQNEG95uHkefHtTlXLuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rz8R+j71fdwNQOdGqxhP+YsUpGdSQqxVeWt9uYQiBorwD/7sLE84tacI/Jx+WgKSpNcWhHn5oV02WRw+wxsKfrqHI/DPQHalkhH0PB8CqSffR3lTYWEsap+wRQ0+ozjkLkt0Pdm/tY2IdX3D67WR9ujGofdBiXoXRj8mULfWhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcj2rByD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UR2e70C0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcj2rByD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UR2e70C0"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746778361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=tcj2rByDdRTDnh3kSMBf2l4oceAcOgtYp75Us5E4sTtQiBEO8QiBrIhUgZS2PheNqsPAnk
	mjHTILZHNb3xUslwSYAvemwR57Rldkq67OAi0T9yecQMpc25C2Nhfb4XKho2y8Os9ek8PF
	4ajtd7+iarBsrCbkCqCoexeG2IPDQ1Jy42MqZouYageK3Am+ZZAJite0FoaW/BS+5npNSF
	k6SopZHHW1NvOMhDibIFmcpLfH5aHX3Fp6ya2kP8vthxH99hYuuSU67SrK6KnkTv6RbfnK
	OSZNCDxutY47jVHyWIe+HqAz4GijAuDz95ZjUuqyT32EK22GS6Pl+izHj7u1zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746778361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quxmvFOpWEdlDXGAnbEr+RnyianRn/nmBROLE3F3T+I=;
	b=UR2e70C0pz5/36ZPD/Fk2PBlEmip88izoSbgE6d55vQvjL9xI7yoyE9rTiykUoqpP9Or/l
	dtRYGzNMJcEiPPBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v7 05/22] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
Date: Fri,  9 May 2025 10:12:04 +0200
Message-Id: <ad8c0a233c0dfd167530231f2f828d0d5a6af5c9.1746776116.git.namcao@linutronix.de>
In-Reply-To: <cover.1746776116.git.namcao@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
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

