Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1B57306
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326975; cv=none; b=Pqkc9N/nF3v7J46Vpo7Pji+Ut+F0sAquMyTE0fanqLnscCye4W9ht5LV5OMAfPPyKGbLK+fsRBUru4mu544I6eOax6j2jeBp/CUuYMDqrTUINLb1lQVbu9KYlVBCW5myollWsULl6T91Mc36xeE/IHN3+akrbfw7KcZ1HYawvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326975; c=relaxed/simple;
	bh=7LYvyH+kMuatRbK3+hd5eTn3ke7Rmr09AkuZvFjVoD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3u77MgL1xL1pODS92BFLSl3yQQnv3jiFwQ+2gGn+GQxsW8LRUBssfC5yq6ZpJ3Wy2NH1c9sLclkG192NIGCZSPVphh/iRVad2TfcFK+ddz/QF06VaHCW5LIL8XbYIC2qfdi0Ekr6zzOE2EJwUtlwOEUydxi6lQYmq5h6D3Sh8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by baptiste.telenet-ops.be with bizsmtp
	id tZ2e2B00F1TWuYv01Z2eXq; Fri, 01 Mar 2024 22:02:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024hH-IE;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1e-00D8sT-CV;
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
Subject: [PATCH 20/20] [RFC] sh: dma: Remove unused functionality
Date: Fri,  1 Mar 2024 22:02:34 +0100
Message-Id: <2beb81fdd7592a94329e3c9a6ba56959f6094019.1709326528.git.geert+renesas@glider.be>
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

dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
request_dma_bycap() are unused.  Remove them, and all related code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/drivers/dma/dma-api.c | 116 ----------------------------------
 arch/sh/include/asm/dma.h     |   7 --
 2 files changed, 123 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index f49097fa634c36d4..87e5a892887360f5 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -41,21 +41,6 @@ struct dma_info *get_dma_info(unsigned int chan)
 }
 EXPORT_SYMBOL(get_dma_info);
 
-struct dma_info *get_dma_info_by_name(const char *dmac_name)
-{
-	struct dma_info *info;
-
-	list_for_each_entry(info, &registered_dmac_list, list) {
-		if (dmac_name && (strcmp(dmac_name, info->name) != 0))
-			continue;
-		else
-			return info;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(get_dma_info_by_name);
-
 static unsigned int get_nr_channels(void)
 {
 	struct dma_info *info;
@@ -101,66 +86,6 @@ int get_dma_residue(unsigned int chan)
 }
 EXPORT_SYMBOL(get_dma_residue);
 
-static int search_cap(const char **haystack, const char *needle)
-{
-	const char **p;
-
-	for (p = haystack; *p; p++)
-		if (strcmp(*p, needle) == 0)
-			return 1;
-
-	return 0;
-}
-
-/**
- * request_dma_bycap - Allocate a DMA channel based on its capabilities
- * @dmac: List of DMA controllers to search
- * @caps: List of capabilities
- *
- * Search all channels of all DMA controllers to find a channel which
- * matches the requested capabilities. The result is the channel
- * number if a match is found, or %-ENODEV if no match is found.
- *
- * Note that not all DMA controllers export capabilities, in which
- * case they can never be allocated using this API, and so
- * request_dma() must be used specifying the channel number.
- */
-int request_dma_bycap(const char **dmac, const char **caps, const char *dev_id)
-{
-	unsigned int found = 0;
-	struct dma_info *info;
-	const char **p;
-	int i;
-
-	BUG_ON(!dmac || !caps);
-
-	list_for_each_entry(info, &registered_dmac_list, list)
-		if (strcmp(*dmac, info->name) == 0) {
-			found = 1;
-			break;
-		}
-
-	if (!found)
-		return -ENODEV;
-
-	for (i = 0; i < info->nr_channels; i++) {
-		struct dma_channel *channel = &info->channels[i];
-
-		if (unlikely(!channel->caps))
-			continue;
-
-		for (p = caps; *p; p++) {
-			if (!search_cap(channel->caps, *p))
-				break;
-			if (request_dma(channel->chan, dev_id) == 0)
-				return channel->chan;
-		}
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL(request_dma_bycap);
-
 int request_dma(unsigned int chan, const char *dev_id)
 {
 	struct dma_channel *channel = { 0 };
@@ -213,35 +138,6 @@ void dma_wait_for_completion(unsigned int chan)
 }
 EXPORT_SYMBOL(dma_wait_for_completion);
 
-int register_chan_caps(const char *dmac, struct dma_chan_caps *caps)
-{
-	struct dma_info *info;
-	unsigned int found = 0;
-	int i;
-
-	list_for_each_entry(info, &registered_dmac_list, list)
-		if (strcmp(dmac, info->name) == 0) {
-			found = 1;
-			break;
-		}
-
-	if (unlikely(!found))
-		return -ENODEV;
-
-	for (i = 0; i < info->nr_channels; i++, caps++) {
-		struct dma_channel *channel;
-
-		if ((info->first_channel_nr + i) != caps->ch_num)
-			return -EINVAL;
-
-		channel = &info->channels[i];
-		channel->caps = caps->caplist;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(register_chan_caps);
-
 void dma_configure_channel(unsigned int chan, unsigned long flags)
 {
 	struct dma_info *info = get_dma_info(chan);
@@ -267,18 +163,6 @@ int dma_xfer(unsigned int chan, unsigned long from,
 }
 EXPORT_SYMBOL(dma_xfer);
 
-int dma_extend(unsigned int chan, unsigned long op, void *param)
-{
-	struct dma_info *info = get_dma_info(chan);
-	struct dma_channel *channel = get_dma_channel(chan);
-
-	if (info->ops->extend)
-		return info->ops->extend(channel, op, param);
-
-	return -ENOSYS;
-}
-EXPORT_SYMBOL(dma_extend);
-
 static int dma_proc_show(struct seq_file *m, void *v)
 {
 	struct dma_info *info = v;
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index c8bee3f985a29393..6b6d409956d17f09 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -56,7 +56,6 @@ struct dma_ops {
 	int (*get_residue)(struct dma_channel *chan);
 	int (*xfer)(struct dma_channel *chan);
 	int (*configure)(struct dma_channel *chan, unsigned long flags);
-	int (*extend)(struct dma_channel *chan, unsigned long op, void *param);
 };
 
 struct dma_channel {
@@ -118,8 +117,6 @@ extern int dma_xfer(unsigned int chan, unsigned long from,
 #define dma_read_page(chan, from, to)	\
 	dma_read(chan, from, to, PAGE_SIZE)
 
-extern int request_dma_bycap(const char **dmac, const char **caps,
-			     const char *dev_id);
 extern int get_dma_residue(unsigned int chan);
 extern struct dma_info *get_dma_info(unsigned int chan);
 extern struct dma_channel *get_dma_channel(unsigned int chan);
@@ -128,10 +125,6 @@ extern void dma_configure_channel(unsigned int chan, unsigned long flags);
 
 extern int register_dmac(struct dma_info *info);
 extern void unregister_dmac(struct dma_info *info);
-extern struct dma_info *get_dma_info_by_name(const char *dmac_name);
-
-extern int dma_extend(unsigned int chan, unsigned long op, void *param);
-extern int register_chan_caps(const char *dmac, struct dma_chan_caps *capslist);
 
 /* arch/sh/drivers/dma/dma-sysfs.c */
 extern int dma_create_sysfs_files(struct dma_channel *, struct dma_info *);
-- 
2.34.1

