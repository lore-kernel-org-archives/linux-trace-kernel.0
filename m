Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212F340A57;
	Wed, 20 May 2026 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300120; cv=none; b=vBrsL/61/DeMfVmZTzzqF3f/ouhjX098KfgeoIsaFLK3liNwTe0xgK4lFh1vbT6Ry3DawP7b1soFrbYzag2iJjdz68laBXfVbUXJeWN/tqAV6wpgW59UmOI1aT0GTaXPUoUTVwbDUcYguSDkpRbjJ+3U9dbYrmIw73oC8BjraAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300120; c=relaxed/simple;
	bh=jdG2Y2XfjnCichlgQ5afAMVixlCKrMBY/ZVKPbS8jNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bdEueiVBfwoX9d02gXcl9Cw4dIDkytwWnSVffSjQTUWwWclfxTtfjlp/sMciXviSRHL44fo0xTSiRlMKOWJaey3TwnCm3ESMnbBSLE6Vw+Y7spOR8CHRfUhhP/dvfd0Ixrmix3vpN44XmxcRVdq9vEivfDBCRlFzZcH6I7mDJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EMYPOwC/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EMYPOwC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779300116;
	bh=jdG2Y2XfjnCichlgQ5afAMVixlCKrMBY/ZVKPbS8jNs=;
	h=From:Date:Subject:To:Cc:From;
	b=EMYPOwC/1+f/ahxT0DeVeyx7Q1FpglrgO5qhRV3PCnmtsr1BeyFX58Jz5Tx767xCs
	 9PbVX53eoExyzVWs6phEjSEQD6meSaTISBMvcfOSus2L1AW8Z3suDsL7w30K+gtVcn
	 oAeYhjt/9uiONoFhVuBWH9FmDTy7EkEFToQHqjnU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 20 May 2026 20:01:55 +0200
Subject: [PATCH] tracing: Create output file from cmd_check_undefined
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-tracing-ringbuffer-check-v1-1-d979cfab1338@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDuQRmtKr1JcJONEp4W0TFQE8
 e7GdvPgW7x/g8wqnOFRbaC8SJZPKrheKqDRp4FR+mKwxrbmZg1O6knSgFomzDGyIo1Mb6x9y66
 597ULDsr9qxxl/aWf3d95Di+m6ezBvh8CVeEQfAAAAA==
X-Change-ID: 20260520-tracing-ringbuffer-check-3a6e748d37b7
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779300115; l=1236;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jdG2Y2XfjnCichlgQ5afAMVixlCKrMBY/ZVKPbS8jNs=;
 b=BOsZ2rI1kkjymJHD1BWmlvDGShNAhxyLR5z2tQ05aSYz1tEXMZYlnAH0+mCZcVFdETAQyl6nm
 Y9yA6t+1nwGCx5MLfyPO+CANdkF8MV6YmR5fY2atKjIB+XneySeY3Iz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As the output file is currently never created, the check will run every
time, even if the inputs have not changed.

Create an empty output file which allows make to skip the execution when
it is not necessary.

Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
Fixes: 58b4bd18390e ("tracing: Adjust cmd_check_undefined to show unexpected undefined symbols")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/trace/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 1decdce8cbef..b5797457f9f4 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -154,7 +154,8 @@ quiet_cmd_check_undefined = NM      $<
               echo "Unexpected symbols in $<:" >&2; \
               echo "$$undefsyms" >&2; \
               false; \
-          fi
+          fi; \
+          touch $@
 
 $(obj)/%.o.checked: $(obj)/%.o $(obj)/undefsyms_base.o FORCE
 	$(call if_changed,check_undefined)

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260520-tracing-ringbuffer-check-3a6e748d37b7

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

