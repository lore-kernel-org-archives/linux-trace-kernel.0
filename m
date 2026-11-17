Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959266;
	b=YalJ4/RkOrQeGj5wxLo5UQQ7R9jr/R/61NibJRBHHi5VELDxCcCF3HdxynsjMJ8+Xze7
	 VCB1M+m2Z2JikseqPNyF/Y0OSmn3ZlJitFrbRXfvRm5Uxoj4OlyH5acOnADY+Ao5Nu75r
	 C2R6G1YY3Ebei0IdDvTzLshDEjdSeg1hHjy6fhJQTLxEGJTcQ9GRMJKGHSxlPxUEQtOuH
	 TjS1ynnSi0/hu0iJ2XCWVumIpdQBBoUeVQb36cJU0rHlCmJcfFkOUXLjaiG7rSwoPcyfv
	 XE5rLl4F5tJwhBw8twa94BEdD5+9QvfJKozFQindUiuzOCS79X6rLz/7DZ1AG/WV6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959266;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=clyVU1pMhAE22NFzfWb5IrI08JmIOkEfpu4rJ6NQt6k=;
	b=IB08brbXwbT9FpQsqfKxT4HDfEIQ+AZFF9MAorgQbMnzPBEQvzG2AYbyKJ9lFSZmSv7q
	 iamOvcR1QG30tBBrMWUe6pPTBy+7KNHud2fY/LGU3qzzG928AsRhSq6ewbKNz4SxOxcaj
	 EqBaobv4sQnb/qpQRX/Pc8PUBBucR53gmJ4Ew/jMscSPIUm28LF7ylk2OAJIfRRnsRc3s
	 geTHhl7wc4tayctvdBQNVjQoXBTq/0+ceXsXN1B4cuuA9l2AeGueNiTERMxTMLSQPm+zQ
	 wVDGR0MmPCmF+uKvaXygS8+zcHZS8EVE+FfwdCn521G014xA0tsS6F88x0Yd8FC4JWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfOihrId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D7606A32C;
	Tue, 17 Nov 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfOihrId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4821F000C5;
	Tue, 17 Nov 2026 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959266;
	bh=clyVU1pMhAE22NFzfWb5IrI08JmIOkEfpu4rJ6NQt6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SfOihrId0GRPuKiiehrSbXc8kTD81uHZ8r0pgtOO6qF6NeuAfAwkD9yejoFIfXb79
	 BnWghAwQ2iixy01tdbMLXiUXD3s7o11ihBdyyGchXf6RN4UlPQfFdPz68S+a6n45C2
	 TM2L6fU8WnuuaDkSo+nsEOEJ8+JqReJhPLTKl31/g3aMt2oW17OVL9uNqZ+496Nx7Y
	 dbxpJEimYD7SgfZ1axHvLDEdtlnFAda0uarJ/fGD4+CFe6MmjHFQDSuajw6cl2jXch
	 KQc4Gl9QKKxHFZNxGPqRDaKjb6kxviMBCcBblzwPHFdW4xWSs/gUNrg2BfY3BVUgOW
	 w7lhBDCP6H78A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Breno Leitao <leitao@debian.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] bootconfig: Free the initrd memory used by bootconfig
Date: Wed, 18 Nov 2026 08:47:40 +0900
Message-ID: <179495926058.237695.12800083196053168375.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179495924003.237695.10973676765152260584.stgit@devnote2>
References: <179495924003.237695.10973676765152260584.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

get_boot_config_from_initrd() removes the bootconfig from the initrd by
decrementing initrd_end in place. However, the whole initrd including
the bootconfig is reserved, e.g. reserve_initrd_mem() reserves
[initrd_start, PAGE_ALIGN(original initrd_end)), and do_populate_rootfs()
frees it with free_initrd_mem(initrd_start, initrd_end). Thus the full
pages in [PAGE_ALIGN(new initrd_end), PAGE_ALIGN(original initrd_end))
are never freed. This leaks up to 8 pages for a 32KB bootconfig.

Save the original initrd_end in initrd_mem_end when trimming the
bootconfig, and restore initrd_end before freeing the initrd memory.
The bootconfig data has already been copied by xbc_init() at that point.
The trimmed initrd_end is kept when the initrd is retained, so that
/sys/firmware/initrd does not expose the bootconfig.

Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/initrd.h |    2 ++
 init/initramfs.c       |   10 ++++++++++
 init/main.c            |    8 +++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 7e5d26c8136f..3086a462da76 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -17,6 +17,8 @@ extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
 #ifdef CONFIG_BLK_DEV_INITRD
+/* initrd_end before trailing data (e.g. bootconfig) was trimmed off */
+extern unsigned long initrd_mem_end;
 extern void __init reserve_initrd_mem(void);
 extern void wait_for_initramfs(void);
 #else
diff --git a/init/initramfs.c b/init/initramfs.c
index ebddde9c8f0d..11030cc1f35d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -582,6 +582,7 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 }
 
 static int __initdata do_retain_initrd;
+unsigned long initrd_mem_end __initdata;
 
 static int __init retain_initrd_param(char *str)
 {
@@ -750,6 +751,15 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 		security_initramfs_populated();
 	}
 
+	/*
+	 * The bootconfig loader trims the bootconfig off initrd_end. Restore
+	 * it to free the memory used by the bootconfig too, unless the initrd
+	 * is retained (which must not expose the bootconfig).
+	 */
+	if (!do_retain_initrd && initrd_start && initrd_end < initrd_mem_end)
+		initrd_end = initrd_mem_end;
+	initrd_mem_end = 0;
+
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
diff --git a/init/main.c b/init/main.c
index 9471ece3d7d5..f14780345051 100644
--- a/init/main.c
+++ b/init/main.c
@@ -323,7 +323,13 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 		return NULL;
 	}
 
-	/* Remove bootconfig from initramfs/initrd */
+	/*
+	 * Remove bootconfig from initramfs/initrd. Since the initrd memory
+	 * (including the bootconfig) is freed with initrd_end, save the
+	 * original end to free the whole region later.
+	 */
+	if (!initrd_mem_end)
+		initrd_mem_end = initrd_end;
 	initrd_end = (unsigned long)data;
 	if (_size)
 		*_size = size;

