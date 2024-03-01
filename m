Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38B56B9F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326973; cv=none; b=mfK6WmZixfozNq0dySqpVK+kT2USAXEL9fgCYkaGNCEMvXg7FoHJGKF3WCjW5k8p4Vj0kiew/M5BfTGYMOi16P7pVhaahkBpMnGHWf+X+KC6FzzYkdSq4wHxN0ZbA7NVCrKR3Mh+TiZ7J4iBhMMx1yagO0v9kI040AixXy03e28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326973; c=relaxed/simple;
	bh=ETPaGFlRq2OiHNcTeFeosvOhUtWliYf8v6XiQQvicHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBQLNtNGd3aVvqwA4pqGTDrQQBBJIq6OIzwXUsJCgwqvg0CaOqPr3Zl0Gu0x2mws7tH8WbdUZKXovvEE16DTXzhidNK2554dtpnqfq/cOVgnyxV/hrdInzTDDXtJlG0AglbJ+EnYZZC2nup6cFU6P7QydwAfUH/4e9Nrg0zBzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by xavier.telenet-ops.be with bizsmtp
	id tZ2e2B0091TWuYv01Z2eDb; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024gm-Cs;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8rp-76;
	Fri, 01 Mar 2024 22:02:38 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 12/20] sh: dma: Remove unused dmac_search_free_channel()
Date: Fri,  1 Mar 2024 22:02:26 +0100
Message-Id: <82d5efdde44f9489c5a7d11d0a19750445116c95.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
References: <cover.1709326528.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/drivers/dma/dma-api.c:164:5: warning: no previous prototype for 'dmac_search_free_channel' [-Wmissing-prototypes]

dmac_search_free_channel() never had a user in upstream, remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
request_dma_bycap() are also unused, but don't trigger warnings
---
 arch/sh/drivers/dma/dma-api.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 89cd4a3b4ccafbe2..f49097fa634c36d4 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -161,33 +161,6 @@ int request_dma_bycap(const char **dmac, const char **caps, const char *dev_id)
 }
 EXPORT_SYMBOL(request_dma_bycap);
 
-int dmac_search_free_channel(const char *dev_id)
-{
-	struct dma_channel *channel = { 0 };
-	struct dma_info *info = get_dma_info(0);
-	int i;
-
-	for (i = 0; i < info->nr_channels; i++) {
-		channel = &info->channels[i];
-		if (unlikely(!channel))
-			return -ENODEV;
-
-		if (atomic_read(&channel->busy) == 0)
-			break;
-	}
-
-	if (info->ops->request) {
-		int result = info->ops->request(channel);
-		if (result)
-			return result;
-
-		atomic_set(&channel->busy, 1);
-		return channel->chan;
-	}
-
-	return -ENOSYS;
-}
-
 int request_dma(unsigned int chan, const char *dev_id)
 {
 	struct dma_channel *channel = { 0 };
-- 
2.34.1

