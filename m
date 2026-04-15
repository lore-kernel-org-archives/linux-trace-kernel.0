Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E23264D4;
	Wed, 15 Apr 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250289; cv=none; b=YONtQxT1sGu5a0FRPGh5nWWyst0C7A5QXKLTFLcGqT3SWh70TvzMabu7+cOlcRdmWHfXXxnzbSCkSp5ZAIXRbQ59B3uZCbxrXIU3UH1aIy7S0r3hI8oBPfJ/MD9tN67A6gzOTXKcoCaulmPON+ypmNeIFxEziUxGZCUwKfsez7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250289; c=relaxed/simple;
	bh=zi24MZoteh0rhRLPTwI2OS/Ab2wiJlBSZaMNEDXiZ7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k35ZdjHqsfngtT5Mt7QIxHkQLv+mTW+HRbfa8wYzoxtxhWnSLrIxJD7XwAZmUu+cwrgInWArHnuQE5S6TPGvNkQWkcGX2vZdr+xlIGziATXmsAC0iEACpgg9bz9wNsZKU6Vepxol6rZofZcOWvDhcpClOX4xR2WN1h4tOje1zEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gRbPPBj3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gRbPPBj3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ILyrpCqpMl/TMd2NGrJVJqAJH7iOYKWbcki7NhdcRHQ=; b=gRbPPBj3EYyCmbKWrKjwNJSjLt
	xQR8mSe0UGEyYBedaAvQ1Srx/o1jMK2H1jxSOlO0rLEziwHyezhpyZ10z8F+IbkiZ62P0sPxrqUK6
	upOwjLfcPH5tWT9p0MbrxIvkEpEGAYSouoqSQE0qlCWCujdcLMhf83Un3alf9QSVCguaR+Wk8Emdf
	VkxPF0/l8iyCrT3LQg9/ctqSFa7+W/9gPaa4Z7HDxGhjmqlR03OL6rEp+ZdBk06sf7TDu3JQAbp/+
	08eDneA0LSayuVs5ORd5oU193TcZJ7DKz5TJXL0Qs1bIgTqkOt0lmiWLAHU9atu09dDudXbdMXuQQ
	czZnjf5w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCxq8-00DmiU-2N;
	Wed, 15 Apr 2026 10:51:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Apr 2026 03:51:11 -0700
Subject: [PATCH 2/3] init: use static buffers for bootconfig extra command
 line
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-bootconfig_earlier-v1-2-cf160175de5e@debian.org>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
In-Reply-To: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: oss@malat.biz, paulmck@kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=leitao@debian.org;
 h=from:subject:message-id; bh=zi24MZoteh0rhRLPTwI2OS/Ab2wiJlBSZaMNEDXiZ7Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp322huQaEmgvJMOssvu5k5UoUVPkweG3PLAegd
 1kxIxEHXz2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCad9toQAKCRA1o5Of/Hh3
 bfBkEACiIyjKxEXP/uZrxtzpo4ZmAdtu12NEeV+P+i4YVg6TzCKZ0CYDfNVdmH8WK2Onw1f4pbj
 45IimlOgCQeD+XexC1dtkBWEoGq6+btQg9UdkZRghXUnvgLyvRNada41CnsyH4UcqZZYZr5cTe6
 UWsx51pQCE0fgkgO8V55cx3vAPrhd1IbBHuBnDdWZSoLVkpDjLFZJOWzmPhX+784pyUA467D261
 boVg+hcd1GsBjQOzrUmCK4YkymfiS33NyyNCCeRlwU5khhm9g44ACqaS7DctoZ6wvZ0MgkB1SQT
 oLH8flrPWjFB2mELYvR8R/tzJlwr/kZ69p88Fom3ghCevuaqKwDcJfJdkuRgISq3voT6fUTJOZz
 JYH84GblJQAjPao5LWkmeqtILswdeXM+3Ygjmef153K8np/+wuEcP0DXk13wUOGpRLNbhRUf1s3
 SdfUMAokeIjRsJuKTzhUNpEum7rFYmL5US6Bv/K6xPujYZoFCX2Y1C0YGE990a8i+rKtDMPs6r9
 Hnqbg1PcCKkgmEZ5l1j8oIlDZGKMcB9rP2bpAR7RXl8NLjtf6B6Iox2ABlltSXWj3yxHpSKUCO9
 UdpIDRctohW39ZJGByuY0uXzFR+QjNgaN3qm4vuBeT8Hz99BNQodSs0/s95IGU79dZbyfnl+Lqy
 avVoANYklgR0cRA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Replace memblock_alloc/memblock_free in xbc_make_cmdline() with
static __initdata buffers. This removes the last memblock dependency
from the bootconfig loading path, completing the prerequisite for
running bootconfig parsing before memblock is available.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 init/main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/init/main.c b/init/main.c
index 96f93bb06c490..b9feca55e01f9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -369,11 +369,18 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 }
 #undef rest
 
+/*
+ * Static buffers for bootconfig-generated command line parameters.
+ * Two separate buffers are needed because both "kernel" and "init"
+ * parameters are stored simultaneously.
+ */
+static char extra_cmdline_buf[COMMAND_LINE_SIZE] __initdata;
+static char extra_initargs_buf[COMMAND_LINE_SIZE] __initdata;
+
 /* Make an extra command line under given key word */
-static char * __init xbc_make_cmdline(const char *key)
+static char * __init xbc_make_cmdline(const char *key, char *new_cmdline)
 {
 	struct xbc_node *root;
-	char *new_cmdline;
 	int ret, len = 0;
 
 	root = xbc_find_node(key);
@@ -382,19 +389,12 @@ static char * __init xbc_make_cmdline(const char *key)
 
 	/* Count required buffer size */
 	len = xbc_snprint_cmdline(NULL, 0, root);
-	if (len <= 0)
+	if (len <= 0 || len >= COMMAND_LINE_SIZE)
 		return NULL;
 
-	new_cmdline = memblock_alloc(len + 1, SMP_CACHE_BYTES);
-	if (!new_cmdline) {
-		pr_err("Failed to allocate memory for extra kernel cmdline.\n");
-		return NULL;
-	}
-
 	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
-		memblock_free(new_cmdline, len + 1);
 		return NULL;
 	}
 
@@ -467,9 +467,9 @@ static void __init setup_boot_config(void)
 		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
-		extra_command_line = xbc_make_cmdline("kernel");
+		extra_command_line = xbc_make_cmdline("kernel", extra_cmdline_buf);
 		/* Also, "init." keys are init arguments */
-		extra_init_args = xbc_make_cmdline("init");
+		extra_init_args = xbc_make_cmdline("init", extra_initargs_buf);
 	}
 	return;
 }

-- 
2.52.0

