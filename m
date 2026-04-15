Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2D345CA5;
	Wed, 15 Apr 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250293; cv=none; b=QsOi+p5X9QsxPs0GQW8QJJsnGJWNFiwE0LhkTfLnBBCeLrmynm9jwlWUd/g0tr0nJvCFEtVgC87UzetWOXaoO4XEx1hKv8xWnxIE4fNr6aUsSYzWVYFjMjaQTXuyPA1vyfNAngGIdeqAJWSoCctbMkEsGb2w0IONF5gAvFg+kTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250293; c=relaxed/simple;
	bh=Vrq31nIEudZ39oK3KYS3QYZ0eIrMaHiveXBTtFLkx6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFoe+y0hqvPHOY09ilJpEVCcu7h5vw7hFfrhzjr9fmQ8PX6J9PL+yL0YdiXpG5TMGDo9adw+GeTBvPMD750qgOxknTPtUZrYSOyFUsGxA5EVha/VNgBj2n3+h0ClTUsfJZOOK6GsRcJtpIvHzcl7CnuYYnFvSCW5nS8bNw5GQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ODD2GqHB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ODD2GqHB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=s3nMnmGrqEtfuwNnCgWOm2YDuOfsDx+syqU0dF2CDoM=; b=ODD2GqHBaoWuq37l1gCCu4SrGG
	PBn0sCQHxX/3/JnD0tprYo1dU3Q4/f9ov+vEgjg0uegcW9BPdQrwGYkGBw9ptmtmO0tlUgYubterp
	G0Zm4hmSeB/GeZ66+lRc5jxXz1LwsFyO9wsNGId9/tn1yM1XjayPTZSs4asq3YiBFhAoy0yTjS1Cx
	x2NZkLM+dfHCIWi93LJ8HEWf0es8pVw88mO33wgXXiyAdqZJmNkiGPdjSGsKHJZQycb6q+K73uzYJ
	Bv4jx4Zk8nSxGhdV2LjvanvNozeK9VZyv+d6lrup1HctUgVc1Xmxe91G7afQZU3j0eLyZif9Bwdze
	Qn3nhD1w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCxqC-00Dmie-10;
	Wed, 15 Apr 2026 10:51:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Apr 2026 03:51:12 -0700
Subject: [PATCH 3/3] init: move embedded bootconfig parsing before
 setup_arch()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-bootconfig_earlier-v1-3-cf160175de5e@debian.org>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
In-Reply-To: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: oss@malat.biz, paulmck@kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4290; i=leitao@debian.org;
 h=from:subject:message-id; bh=Vrq31nIEudZ39oK3KYS3QYZ0eIrMaHiveXBTtFLkx6Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp322h5pS1HJ7mmk52ayT1x24c8M/wIrJjNZeq+
 +YU2JsY0suJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCad9toQAKCRA1o5Of/Hh3
 bTPYD/0T6tZbj7Fu4CyUJmtyODdU3IwlVQPcUx9Nd7woXNrL3zwVKmTgRVxMfQPDBbM2l6+NYkn
 Bl8B3v6vmVv9vvCwrOGMbI8sPhlo7ibB4DSEo8qeFCpHEdZ+kXLG/86Qiuf15wXfwnW5uncIgsZ
 2TwajjdPlMnGRj5gEbqAeqjsUL0zATFecPy/U2v+SXVUWxjFs6ME4Jwft4IeeDgZIUu6WMN0IA0
 T/ENdddGzu9VqYewDlzN7fIuybM7G6hMHJKlBgluTq9LYrebUPV0xujFGN7Vc85pXZ+awva+c0d
 q0eAWnoCEGN9gQmnMYkvqFbG+YLuymLgxB16W3R5fgnR9LVhe+uIjYljEnR6FHNQFXwMCKug1mv
 LYBCJEAF+BtyL2CMCDXaT7kwZYpsVSVEoCxCbdyHpav/5hn4lmrCYZxiPBG3iBfzOgf3s7zkZpU
 nQQvD5XIy6R5xOTcwL3ik2oNjoS4kKWEsigKCjNj9rf0SLWi34JVHWSgsDJhO+fkYYNzr004mWx
 4Fqzi+bFGU7LHbJf7gi2Sld+juVurUyJuUIEg+6LUVxDHM61xqgtmdc9UKAFodvANxwwfPxnnON
 2a/xhdYslKS37sf/dM5/nuOKuxsoJ7aZ7A9n+5/RAO56Of0CFddczDg1QNJZgMBxUsL2r/+hHsg
 F0wGCJHugX2zkQw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Split setup_boot_config() into setup_boot_config_from_embedded() for
embedded bootconfig and setup_boot_config_from_initrd() for initrd
bootconfig.

The embedded bootconfig data lives in .init.rodata (compiled into the
kernel via bootconfig-data.S), so it requires no memory allocation to
access. Combined with the previous patches that replaced memblock
allocations with static buffers, this allows embedded bootconfig to
be parsed before setup_arch(), making bootconfig parameters available
during architecture-specific setup.

The initrd bootconfig path remains at its original position since it
needs initrd_start/initrd_end set up by setup_arch().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 init/main.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/init/main.c b/init/main.c
index b9feca55e01f9..20fded9bfbdd0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -416,20 +416,17 @@ static int __init warn_bootconfig(char *str)
 	return 0;
 }
 
-static void __init setup_boot_config(void)
+/*
+ * Parse bootconfig data and extract kernel/init command line parameters.
+ * Shared by both the early embedded path and the late initrd path.
+ */
+static void __init __boot_config_load(const char *data, size_t size)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
-	const char *msg, *data;
+	const char *msg;
 	int pos, ret;
-	size_t size;
 	char *err;
 
-	/* Cut out the bootconfig data even if we have no bootconfig option */
-	data = get_boot_config_from_initrd(&size);
-	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!data)
-		data = xbc_get_embedded_bootconfig(&size);
-
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
 			 bootconfig_params);
@@ -471,7 +468,50 @@ static void __init setup_boot_config(void)
 		/* Also, "init." keys are init arguments */
 		extra_init_args = xbc_make_cmdline("init", extra_initargs_buf);
 	}
-	return;
+}
+
+/*
+ * Load embedded bootconfig before setup_arch(). This runs before memblock
+ * is available, relying on static buffers in the bootconfig parser.
+ * The embedded data lives in .init.rodata so no allocation is needed
+ * to access it.
+ */
+static void __init setup_boot_config_from_embedded(void)
+{
+	const char *data;
+	size_t size;
+
+	data = xbc_get_embedded_bootconfig(&size);
+	if (!data)
+		return;
+
+	pr_info("Load embedded bootconfig early\n");
+	__boot_config_load(data, size);
+}
+
+/*
+ * Load bootconfig from initrd. This MUST run after setup_arch() when initrd
+ * boundaries are known. If initrd bootconfig exists, it overrides any embedded
+ * bootconfig that was loaded early, preserving the original priority (initrd
+ * > embedded).
+ */
+static void __init setup_boot_config_from_initrd(void)
+{
+	const char *data;
+	size_t size;
+
+	/* Cut out the bootconfig data even if we have no bootconfig option */
+	data = get_boot_config_from_initrd(&size);
+
+	/* No initrd bootconfig — keep embedded if already loaded */
+	if (!data)
+		return;
+
+	/* Initrd overrides embedded — tear down and re-parse */
+	if (xbc_get_info(NULL, NULL) == 0)
+		_xbc_exit(true);
+
+	__boot_config_load(data, size);
 }
 
 static void __init exit_boot_config(void)
@@ -481,7 +521,9 @@ static void __init exit_boot_config(void)
 
 #else	/* !CONFIG_BOOT_CONFIG */
 
-static void __init setup_boot_config(void)
+static void __init setup_boot_config_from_embedded(void) { }
+
+static void __init setup_boot_config_from_initrd(void)
 {
 	/* Remove bootconfig data from initrd */
 	get_boot_config_from_initrd(NULL);
@@ -1036,13 +1078,14 @@ void start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	setup_boot_config_from_embedded();
 	setup_arch(&command_line);
 	mm_core_init_early();
 	/* Static keys and static calls are needed by LSMs */
 	jump_label_init();
 	static_call_init();
 	early_security_init();
-	setup_boot_config();
+	setup_boot_config_from_initrd();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();

-- 
2.52.0

