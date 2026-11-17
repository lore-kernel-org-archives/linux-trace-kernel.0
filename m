Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959256;
	b=J7QD87BelJ8YsGiNQiDJU6X51sWizdSTE9SSs2YLBFGM1b0K7sJ7BkV7lTOMLfdKy/YQ
	 ttj/gKL30g/Xz2ORke3mjU6sdfvf/tpVB1qfVpDQckEO9uLmwxrHvApgFn74dBMRjhXyn
	 dnPC7QxkGpBarjCZp/Y819bRJ8F9a0Sobl73tEYcSLF8y53vpkRqh8aI6X+AADkpuVgiD
	 MUWJ6LsiZbaB0ZkK6cjHZJh8uZ2FBRZ3JSDTHeamxSLxjQIkY5cqD2JExeco5PFZumIFM
	 ojGqIoNSeMYl+fw+ydSH6A79frP1X/uC4uQM5NlAzlS0bY2WSialRoxDuM962IV4/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=91MlbPG0tTNZ+SSToURW1kFekPCT8nRm6PjzKH1KAb8=;
	b=egxqVlHruyX2DkASmCW/QPFbHiP3sBjLrX+QKIHri01CmhwgTFiNop7+bObaJ8ZiIja/
	 Fs7aAYSpeog2AL7yrzFpoV7OsS0MFYkt/KoHQsI5YgxOlBEWWAH8FSn/M69WfP7fVenVX
	 W0BbV37pQnz8nF1BlD5jRPzLpBYTgXh0IcOarKbOdBhqPOdqEJORYRAAQfUmsSmAUXz+f
	 iEXkjffUxoc4yIIUKXun2/HjIgDp0zBEZhMmHrF+UKw7TIzVWpg1XVg3LshRRh9tfaRVs
	 1Vh/hcbNjf7ZxMfKNdsd6fJhQ+f8ML3rGv1R8qjjKfJ3iLu7n3yBSH/ROvMC7u8baVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KV+8+/XP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45174606A31C;
	Tue, 17 Nov 2026 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KV+8+/XP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2661F000C5;
	Tue, 17 Nov 2026 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959255;
	bh=91MlbPG0tTNZ+SSToURW1kFekPCT8nRm6PjzKH1KAb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KV+8+/XP1RvRsIjFTIhqs0KLWY7FvqH8PVN4RqYB/GAg9tyGYtpcSjyHJ5GHvTC/0
	 0fuVa/0+K7B9Yz+JtxrZf9/fUts7U7FutIsm/3JwnOOoZ6lBTBa5ew6M3LEy0sSUOS
	 c2XN100PW0RMLNeB3mguAh3rBqsY8n4ITc4WZyGYUCN3SYr93XmtTIOqr4Ptq4FcjU
	 DsVrJof3ZIVFMeWhFIhYf8lwJiK61DEDFUUeODM3i99TzbfBCTLXoK0DO+D7I+Skxc
	 N2RePx1XmE9YgJO6kRxEP+sSG9h2/ce9IHKv6Y5wqFy5ZlWrHeJRFkQCX7+bsU/1uv
	 1Cj5ekLXnYduw==
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
Subject: [PATCH 1/2] bootconfig: Exclude alignment padding from bootconfig max size
Date: Wed, 18 Nov 2026 08:47:30 +0900
Message-ID: <179495925054.237695.2777053796977822521.stgit@devnote2>
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

When attaching a bootconfig to an initrd image, apply_xbc() appends 0-3
null padding bytes to align the total image size to 4 bytes and includes
those padding bytes in the footer size field. As documented in
Documentation/admin-guide/bootconfig.rst, the maximum bootconfig size
(XBC_DATA_MAX, 32767 bytes including the terminal null) is not supposed
to include these padding null characters.

However, both load_xbc_from_initrd() in tools/bootconfig and
get_boot_config_from_initrd() / xbc_init() in the kernel check the raw
footer size directly against XBC_DATA_MAX. As a result, a valid
32766-byte config (size = 32767 with the terminal null) gets a footer
size of 32768..32770 when alignment padding is added, and is rejected
with "bootconfig size is too big" depending on the initrd size.

Define XBC_DATA_MAX_PADDED (XBC_DATA_MAX + BOOTCONFIG_ALIGN - 1) for the
raw trailer size check, and add xbc_exclude_padding() to strip up to
BOOTCONFIG_ALIGN - 1 trailing null padding bytes (keeping the terminal
null byte) before checking the unpadded bootconfig size against
XBC_DATA_MAX and passing it to xbc_init(). Keep using the raw footer
size when truncating or trimming the initrd so that both the bootconfig
and its alignment padding are removed.

Also expand test-bootconfig.sh to verify applying, reading back, and
deleting a maximum-size bootconfig across all 4 alignment paddings.

Fixes: e1cef2d4c379 ("tools/bootconfig: Align the bootconfig applied initrd image size to 4")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/bootconfig.h          |   24 ++++++++++++++++++++++++
 init/main.c                         |   23 +++++++++++++++--------
 tools/bootconfig/main.c             |   14 ++++++++++----
 tools/bootconfig/test-bootconfig.sh |   17 +++++++++++++++--
 4 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 260a6f46042e..f745068c07cd 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -63,6 +63,30 @@ struct xbc_node {
 #define XBC_VALUE	(1 << 15)
 /* Maximum size of boot config is 32KB - 1 */
 #define XBC_DATA_MAX	(XBC_VALUE - 1)
+/* Maximum size of padded boot config in initrd trailer */
+#define XBC_DATA_MAX_PADDED	(XBC_DATA_MAX + BOOTCONFIG_ALIGN - 1)
+
+/**
+ * xbc_exclude_padding() - Exclude trailing null padding bytes from size
+ * @data: Bootconfig data (including padding).
+ * @size: The size of @data from the bootconfig footer.
+ *
+ * Exclude up to BOOTCONFIG_ALIGN - 1 trailing null padding bytes while
+ * keeping the terminal null byte of the bootconfig data, and return the
+ * unpadded bootconfig size.
+ */
+static inline __init uint32_t xbc_exclude_padding(const char *data, uint32_t size)
+{
+	int i;
+
+	for (i = 0; i < BOOTCONFIG_ALIGN - 1; i++) {
+		if (size <= 1 || data[size - 1] != '\0' || data[size - 2] != '\0')
+			break;
+		size--;
+	}
+
+	return size;
+}
 
 #define XBC_NODE_MAX	8192
 #define XBC_KEYLEN_MAX	256
diff --git a/init/main.c b/init/main.c
index 7b0c8c34e6a9..9471ece3d7d5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -268,7 +268,7 @@ early_param("loglevel", loglevel);
 #ifdef CONFIG_BLK_DEV_INITRD
 static void * __init get_boot_config_from_initrd(size_t *_size)
 {
-	u32 size, csum;
+	u32 size, raw_size, csum;
 	char *data;
 	u8 *hdr;
 	int i;
@@ -294,24 +294,31 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	if ((unsigned long)hdr < initrd_start)
 		return NULL;
 
-	size = get_unaligned_le32(hdr);
+	raw_size = get_unaligned_le32(hdr);
 	csum = get_unaligned_le32(hdr + 4);
 
-	if (size > XBC_DATA_MAX) {
+	if (raw_size > XBC_DATA_MAX_PADDED) {
 		pr_err("bootconfig size %u is greater than max size %d\n",
-			size, XBC_DATA_MAX);
+			raw_size, XBC_DATA_MAX);
 		return NULL;
 	}
 
-	if (size > ((unsigned long)hdr - initrd_start)) {
+	if (raw_size > ((unsigned long)hdr - initrd_start)) {
 		pr_err("bootconfig size %u is greater than initrd size %lu\n",
-			size, initrd_end - initrd_start);
+			raw_size, initrd_end - initrd_start);
 		return NULL;
 	}
 
-	data = ((void *)hdr) - size;
+	data = ((void *)hdr) - raw_size;
+
+	size = xbc_exclude_padding(data, raw_size);
+	if (size > XBC_DATA_MAX) {
+		pr_err("bootconfig size %u is greater than max size %d\n",
+			size, XBC_DATA_MAX);
+		return NULL;
+	}
 
-	if (xbc_calc_checksum(data, size) != csum) {
+	if (xbc_calc_checksum(data, raw_size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return NULL;
 	}
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index d3f840c5adce..c32fb1e2140c 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -182,7 +182,7 @@ static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;
 
-	if (size < 0 || size > XBC_DATA_MAX)
+	if (size < 0 || size > XBC_DATA_MAX_PADDED)
 		return -EINVAL;
 
 	*buf = malloc(size + 1);
@@ -237,7 +237,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
-	uint32_t size = 0, csum = 0, rcsum;
+	uint32_t size = 0, data_size, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
 
 	ret = fstat(fd, &stat);
@@ -269,7 +269,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (size > XBC_DATA_MAX ||
+	if (size > XBC_DATA_MAX_PADDED ||
 	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
@@ -283,6 +283,12 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return ret;
 
+	data_size = xbc_exclude_padding(*buf, size);
+	if (data_size > XBC_DATA_MAX) {
+		pr_err("bootconfig size is too big\n");
+		return -E2BIG;
+	}
+
 	/* Wrong Checksum */
 	rcsum = xbc_calc_checksum(*buf, size);
 	if (csum != rcsum) {
@@ -290,7 +296,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return -EINVAL;
 	}
 
-	ret = init_xbc_with_error(*buf, size);
+	ret = init_xbc_with_error(*buf, data_size);
 
 	return ret < 0 ? ret : size;
 }
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index f584f7637e12..e03301ad76c4 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -118,10 +118,23 @@ dd if=/dev/urandom bs=768 count=32 | base64 -w0 >> $TEMPCONF
 printf "\"\n" >> $TEMPCONF
 xfail $BOOTCONF -a $TEMPCONF $INITRD
 
+dd if=$TEMPCONF of=$OUTFILE bs=1 count=32765
+cp $OUTFILE $TEMPCONF
+printf "\"\n" >> $TEMPCONF	# 32767 bytes + terminal ('\0') = 32768 (> max)
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+
 dd if=$TEMPCONF of=$OUTFILE bs=1 count=32764
 cp $OUTFILE $TEMPCONF
-printf "\"\n" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
-xpass $BOOTCONF -a $TEMPCONF $INITRD
+printf "\"\n" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0') = 32767
+# Test max size across all 4 alignment paddings (0..3 bytes)
+for sz in 4096 4097 4098 4099; do
+  dd if=/dev/zero of=$INITRD bs=1 count=$sz 2>/dev/null
+  xpass $BOOTCONF -a $TEMPCONF $INITRD
+  $BOOTCONF -l $INITRD > $OUTFILE
+  xpass cmp $TEMPCONF $OUTFILE
+  xpass $BOOTCONF -d $INITRD
+  xpass test $(wc -c < $INITRD) -eq $sz
+done
 
 echo "Adding same-key values"
 cat > $TEMPCONF << EOF

