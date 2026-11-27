Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791072;
	b=yCq31YHn/ndMNUGXLzfozoZ6cZGHXvTqt2+5hidWNvLhC3CgXxWeiCpiEJYuEPy0mgtE
	 VxCq+wtdcOx7yXpRG7g++nIZ6BP5t6TxFHxLs/8OtvK7K3hFHG+ybWgZg5PNM26vk6yQM
	 NoD0g1BX6CpRqHTGHDjXTErWuTOaQ9rpB/yfDfKYjK0d2xxCrNfUV/7XCpcBiov6qeyj3
	 rpPB+tw/qQ/4/LVgMcqiR3bIuop7Dutm6dCr0De8YJ83t2tj66rF9MyG/kHPhefscefdp
	 yMiqWAKoIpwsFm9x+AeeXBhzfnuGVknWIsE5/lrmkHtRdar1B04wJ/yTOU1uR4D9KhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791072;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YL46yvQ9poLX1kSEE49xavNhFztVC1FrOtM1rrXuJsA=;
	b=hhbOGDHlQfE3JzZvItc1U+l6AsrBeUjhmRGKMkm9G2vhSG3kH3BFrSz/cuyrQRQLxR/i
	 6lTQoH76/4wvJe0Td+p4Qs/8UOlObl/3VBzVONmShx2kZlMbhC5aDPzoG1pvbMktKhbHx
	 drCnWQsjc8SRGxua+shvI2lOWOcR0Gp5GZkKNt5VqEdAWsZ1QVmh/nxoaaJuYTZx1ux69
	 q2+giFuwkw0U5UL5PxMhwb5Y5gAge/pX5jd8n61pvd223LD5CDLDD2vHNxqYX4JED4OD6
	 QwV9ttz6Ybz/OUQiNX87/jUWlNpUDWFq6N8Xv0kCnwV8pMp3Y2tJaSB8rzGqd2F5ROw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lyO3/vnj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8B606A31C;
	Fri, 27 Nov 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyO3/vnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987541F00897;
	Fri, 27 Nov 2026 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791071;
	bh=YL46yvQ9poLX1kSEE49xavNhFztVC1FrOtM1rrXuJsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lyO3/vnj1/YKcbgazIgmJbyqN95CX0seZd/8VEEzUjGm0g8vs9Q77couje8eGBEX2
	 N6SwcmIL2AO1Fv0XWEbVInpt9hFvuiTFM7L7WsQ8ttJ+1qHqPzdUjyOsDQqlJIMXIn
	 maMOEOXa3BZf22cyDvl97IfNoorkgcybcvrs6k1AbmyySPn0yo6CjItUWcK5r0M/X3
	 /ZccS8mBrVviqbbo5WwFVHmj3ynTAzfVkMvT0Ss91kODguW1YG07FchtemNNFuBuLE
	 Axon0yXb3KUSV9cK6gFhuhUW2gY0oZR5bwo6sH4hhFYV4KXzCgyl9RajDHIYt0386J
	 BGs+deh7P+zkA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: snambakam@microsoft.com, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 3/5] tools/bootconfig: Support multiple named bootconfigs with -i option
Date: Fri, 27 Nov 2026 14:46:17 +0000
Message-ID: <20261127144614.61194-4-mhiramat@kernel.org>
X-Mailer: UndineD 0.1
In-Reply-To: <20261127144614.61194-1-mhiramat@kernel.org>
References: <20261127144614.61194-1-mhiramat@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Update tools/bootconfig to attach, inspect, and delete multiple stacked
bootconfigs in an initrd image via the "-i <id[,...]>" option:

- Apply ("-a <config> [-i <id>] <initrd>"):
  When "-i <id>" is given, validate <id> and replace the matching block
  in place or append a new named block at the tail (up to XBC_CONFIG_MAX
  = 32). When "-i" is omitted, always place or move the unnamed block to
  index 0 so the unnamed config is guaranteed to be the default block.
  When attaching or replacing either a named overlay or the default
  block [0], test-merge each overlay with block [0] and emit a warning
  if a plain "=" redefinition conflict is detected.
- Delete ("-d [-i <spec>] <initrd>"):
  Delete all stacked trailers when "-i" is omitted, or selectively
  delete matching IDs/indices and repack the remaining blocks.
- Show / List / Cmdline ("[-l | -C] [-i <spec>] <path>"):
  Preserve legacy output when an initrd has a single unnamed block; show
  each block with its index and #BOOTCONFIG-ID header when multiple or
  named blocks exist; or merge and render the selected subset when
  "-i <spec>" is given.

To prevent a partial write or ENOSPC error from wiping out unrelated
stacked configs, write_xbc_blocks() backs up the existing trailer region
and serializes the new trailer tail in memory before writing, rolling
back to the original trailer bytes on failure.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/main.c             | 777 ++++++++++++++++++++++------
 tools/bootconfig/test-bootconfig.sh | 116 +++++
 2 files changed, 726 insertions(+), 167 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6f68e02f6385..f3c7321e29d0 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -19,7 +19,7 @@ static void show_xbc_error(const char *data, const char *msg, int pos)
 {
 	int lin = 1, col, i;
 
-	if (pos < 0) {
+	if (pos < 0 || !data) {
 		pr_err("Error: %s.\n", msg);
 		return;
 	}
@@ -36,7 +36,7 @@ static void show_xbc_error(const char *data, const char *msg, int pos)
 
 }
 
-static int init_xbc_with_error(char *buf, int len)
+static int init_xbc_with_error(const char *buf, int len)
 {
 	const char *msg;
 	int ret, pos;
@@ -235,72 +235,168 @@ static int pr_errno(const char *msg, int err)
 	return err;
 }
 
-static int load_xbc_from_initrd(int fd, char **buf)
+struct xbc_block {
+	struct xbc_config cfg;
+	char *raw_buf;
+};
+
+static void free_xbc_blocks(struct xbc_block *blocks, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		free(blocks[i].raw_buf);
+		blocks[i].raw_buf = NULL;
+	}
+}
+
+static int load_xbc_list_from_initrd(int fd, struct xbc_block *blocks,
+				     int max_blocks, off_t *base_size)
 {
 	struct stat stat;
-	int ret;
+	int ret, total = 0, i;
 	uint32_t size = 0, data_size, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
+	char *buf = NULL;
+	ssize_t rlen;
+	off_t end;
+
+	memset(blocks, 0, sizeof(*blocks) * max_blocks);
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
-		return 0;
+	end = stat.st_size;
+	while (end >= (off_t)BOOTCONFIG_FOOTER_SIZE) {
+		if (lseek(fd, end - (off_t)BOOTCONFIG_MAGIC_LEN, SEEK_SET) < 0) {
+			ret = pr_errno("Failed to lseek for magic", -errno);
+			goto err;
+		}
+		rlen = read(fd, magic, BOOTCONFIG_MAGIC_LEN);
+		if (rlen != BOOTCONFIG_MAGIC_LEN) {
+			ret = pr_errno("Failed to read",
+				       rlen < 0 ? -errno : -EIO);
+			goto err;
+		}
 
-	if (lseek(fd, -(off_t)BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
-		return pr_errno("Failed to lseek for magic", -errno);
+		/* Check the bootconfig magic bytes */
+		if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
+			break;
 
-	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
-		return pr_errno("Failed to read", -errno);
+		if (lseek(fd, end - (off_t)BOOTCONFIG_FOOTER_SIZE, SEEK_SET) < 0) {
+			ret = pr_errno("Failed to lseek for size", -errno);
+			goto err;
+		}
+		rlen = read(fd, &size, sizeof(uint32_t));
+		if (rlen != sizeof(uint32_t)) {
+			ret = pr_errno("Failed to read size",
+				       rlen < 0 ? -errno : -EIO);
+			goto err;
+		}
+		size = le32toh(size);
 
-	/* Check the bootconfig magic bytes */
-	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
-		return 0;
+		rlen = read(fd, &csum, sizeof(uint32_t));
+		if (rlen != sizeof(uint32_t)) {
+			ret = pr_errno("Failed to read checksum",
+				       rlen < 0 ? -errno : -EIO);
+			goto err;
+		}
+		csum = le32toh(csum);
+
+		/* Wrong size error */
+		if (size > XBC_DATA_MAX_PADDED ||
+		    (off_t)size > end - (off_t)BOOTCONFIG_FOOTER_SIZE) {
+			pr_err("bootconfig size is too big\n");
+			ret = -E2BIG;
+			goto err;
+		}
 
-	if (lseek(fd, -(off_t)BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
-		return pr_errno("Failed to lseek for size", -errno);
+		if (lseek(fd, end - (off_t)(size + BOOTCONFIG_FOOTER_SIZE),
+			  SEEK_SET) < 0) {
+			ret = pr_errno("Failed to lseek", -errno);
+			goto err;
+		}
 
-	if (read(fd, &size, sizeof(uint32_t)) < 0)
-		return pr_errno("Failed to read size", -errno);
-	size = le32toh(size);
+		ret = load_xbc_fd(fd, &buf, size);
+		if (ret < 0)
+			goto err;
 
-	if (read(fd, &csum, sizeof(uint32_t)) < 0)
-		return pr_errno("Failed to read checksum", -errno);
-	csum = le32toh(csum);
+		data_size = xbc_exclude_padding(buf, size);
+		if (data_size > XBC_DATA_MAX) {
+			pr_err("bootconfig size is too big\n");
+			free(buf);
+			ret = -E2BIG;
+			goto err;
+		}
 
-	/* Wrong size error  */
-	if (size > XBC_DATA_MAX_PADDED ||
-	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
-		pr_err("bootconfig size is too big\n");
-		return -E2BIG;
+		/* Wrong Checksum */
+		rcsum = xbc_calc_checksum(buf, size);
+		if (csum != rcsum) {
+			pr_err("checksum error: %u != %u\n", csum, rcsum);
+			free(buf);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		total++;
+		if (total > max_blocks) {
+			pr_err("Too many bootconfigs in initrd (max %d)\n",
+			       max_blocks);
+			free(buf);
+			ret = -E2BIG;
+			goto err;
+		}
+
+		if (xbc_parse_id_header(buf, data_size,
+					&blocks[max_blocks - total].cfg) < 0) {
+			pr_err("Invalid bootconfig ID header\n");
+			free(buf);
+			ret = -EINVAL;
+			goto err;
+		}
+		blocks[max_blocks - total].raw_buf = buf;
+		end -= (off_t)(size + BOOTCONFIG_FOOTER_SIZE);
 	}
 
-	if (lseek(fd, stat.st_size - (size + BOOTCONFIG_FOOTER_SIZE),
-		  SEEK_SET) < 0)
-		return pr_errno("Failed to lseek", -errno);
+	if (total > 0 && total < max_blocks)
+		memmove(blocks, &blocks[max_blocks - total],
+			total * sizeof(*blocks));
 
-	ret = load_xbc_fd(fd, buf, size);
-	if (ret < 0)
-		return ret;
+	for (i = 0; i < total; i++) {
+		int j;
 
-	data_size = xbc_exclude_padding(*buf, size);
-	if (data_size > XBC_DATA_MAX) {
-		pr_err("bootconfig size is too big\n");
-		return -E2BIG;
+		if (!blocks[i].cfg.name_len)
+			continue;
+		for (j = i + 1; j < total; j++) {
+			if (blocks[i].cfg.name_len == blocks[j].cfg.name_len &&
+			    !memcmp(blocks[i].cfg.name, blocks[j].cfg.name,
+				    blocks[i].cfg.name_len)) {
+				pr_err("Duplicate bootconfig ID '%.*s' in initrd\n",
+				       (int)blocks[i].cfg.name_len,
+				       blocks[i].cfg.name);
+				ret = -EINVAL;
+				goto err_all;
+			}
+		}
 	}
 
-	/* Wrong Checksum */
-	rcsum = xbc_calc_checksum(*buf, size);
-	if (csum != rcsum) {
-		pr_err("checksum error: %u != %u\n", csum, rcsum);
-		return -EINVAL;
-	}
+	if (base_size)
+		*base_size = end;
 
-	ret = init_xbc_with_error(*buf, data_size);
+	return total;
 
-	return ret < 0 ? ret : size;
+err:
+	if (total > 0) {
+		int n = total > max_blocks ? max_blocks : total;
+
+		free_xbc_blocks(&blocks[max_blocks - n], n);
+	}
+	return ret;
+
+err_all:
+	free_xbc_blocks(blocks, total);
+	return ret;
 }
 
 static int show_xbc_kernel_cmdline(void)
@@ -337,11 +433,27 @@ static int show_xbc_kernel_cmdline(void)
 	return 0;
 }
 
-static int show_xbc(const char *path, bool list, bool render_cmdline)
+static int render_xbc_output(bool list, bool render_cmdline)
 {
-	int ret, fd;
+	if (render_cmdline)
+		return show_xbc_kernel_cmdline();
+	if (list)
+		xbc_show_list();
+	else
+		xbc_show_compact_tree();
+	return 0;
+}
+
+static int show_xbc(const char *path, bool list, bool render_cmdline,
+		    const char *id_spec)
+{
+	struct xbc_block blocks[XBC_CONFIG_MAX];
+	struct xbc_config cfgs[XBC_CONFIG_MAX];
+	int ret, fd, count, i, err_idx = -1, pos;
+	const char *msg;
 	char *buf = NULL;
 	struct stat st;
+	bool seeded = false;
 
 	ret = stat(path, &st);
 	if (ret < 0) {
@@ -357,41 +469,283 @@ static int show_xbc(const char *path, bool list, bool render_cmdline)
 		return ret;
 	}
 
-	ret = load_xbc_from_initrd(fd, &buf);
+	count = load_xbc_list_from_initrd(fd, blocks, XBC_CONFIG_MAX, NULL);
 	close(fd);
-	if (ret < 0) {
-		pr_err("Failed to load a boot config from initrd: %d\n", ret);
-		goto out;
+	if (count < 0) {
+		pr_err("Failed to load a boot config from initrd: %d\n", count);
+		return count;
+	}
+
+	/* Assume a bootconfig file if no trailer and small enough */
+	if (count == 0) {
+		if (id_spec) {
+			pr_err("No bootconfig found in %s\n", path);
+			return -ENOENT;
+		}
+		if (st.st_size <= XBC_DATA_MAX) {
+			int len = load_xbc_file(path, &buf);
+
+			if (len < 0) {
+				pr_err("Failed to load a boot config: %d\n", len);
+				return len;
+			}
+			if (init_xbc_with_error(buf, len) >= 0) {
+				ret = render_xbc_output(list, render_cmdline);
+				xbc_exit();
+			} else {
+				ret = len ? -EINVAL : 0;
+			}
+			free(buf);
+			return ret > 0 ? 0 : ret;
+		}
+		return render_xbc_output(list, render_cmdline);
 	}
-	/* Assume a bootconfig file if it is enough small */
-	if (ret == 0 && st.st_size <= XBC_DATA_MAX) {
-		ret = load_xbc_file(path, &buf);
+
+	for (i = 0; i < count; i++)
+		cfgs[i] = blocks[i].cfg;
+
+	if (id_spec || render_cmdline) {
+		if (id_spec) {
+			bool any_enabled = false;
+
+			if (*id_spec == '\0') {
+				pr_err("Error: Empty bootconfig ID specification.\n");
+				ret = -EINVAL;
+				goto out_blocks;
+			}
+			ret = xbc_enable_configs(cfgs, count, id_spec, &seeded);
+			if (ret < 0)
+				goto out_blocks;
+			for (i = 0; i < count; i++) {
+				if (cfgs[i].enabled) {
+					any_enabled = true;
+					break;
+				}
+			}
+			if (!any_enabled) {
+				ret = -ENOENT;
+				goto out_blocks;
+			}
+		} else {
+			cfgs[0].enabled = true;
+		}
+		ret = xbc_init_configs(cfgs, count, &msg, &pos, &err_idx);
 		if (ret < 0) {
-			pr_err("Failed to load a boot config: %d\n", ret);
-			goto out;
+			if (err_idx >= 0)
+				pr_err("Error in bootconfig [%d%s%.*s]:\n",
+				       err_idx,
+				       cfgs[err_idx].name_len ? ":" : "",
+				       (int)cfgs[err_idx].name_len,
+				       cfgs[err_idx].name);
+			show_xbc_error(err_idx >= 0 ? cfgs[err_idx].data : NULL,
+				       msg, pos);
+			goto out_blocks;
+		}
+		ret = render_xbc_output(list, render_cmdline);
+		xbc_exit();
+	} else if (count == 1 && !cfgs[0].name_len) {
+		ret = init_xbc_with_error(cfgs[0].data, cfgs[0].size);
+		if (ret >= 0) {
+			ret = render_xbc_output(list, false);
+			xbc_exit();
+		}
+	} else {
+		for (i = 0; i < count; i++) {
+			if (cfgs[i].name_len)
+				printf("# [%d] #BOOTCONFIG-ID: %.*s\n",
+				       i, (int)cfgs[i].name_len, cfgs[i].name);
+			else
+				printf("# [%d] (default)\n", i);
+			ret = init_xbc_with_error(cfgs[i].data, cfgs[i].size);
+			if (ret < 0)
+				goto out_blocks;
+			ret = render_xbc_output(list, false);
+			xbc_exit();
+			if (ret < 0)
+				goto out_blocks;
 		}
-		if (init_xbc_with_error(buf, ret) < 0)
-			goto out;
 	}
-	if (render_cmdline)
-		ret = show_xbc_kernel_cmdline();
-	else if (list)
-		xbc_show_list();
-	else
-		xbc_show_compact_tree();
-	if (ret > 0)
-		ret = 0;
-out:
-	free(buf);
 
+out_blocks:
+	free_xbc_blocks(blocks, count);
+	return ret > 0 ? 0 : ret;
+}
+
+static ssize_t serialize_xbc_blocks(char **out, off_t base_size,
+				    struct xbc_block *blocks, int count)
+{
+	struct {
+		uint32_t size;
+		uint32_t csum;
+		char magic[BOOTCONFIG_MAGIC_LEN];
+	} footer;
+	size_t total_len = 0;
+	off_t cur_off = base_size;
+	char *buf = NULL, *dst;
+	int i;
+
+	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE,
+		      "bootconfig footer size mismatch");
+
+	*out = NULL;
+	if (count == 0)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+		size_t hdr_len = 0, body_len = blocks[i].cfg.size;
+		size_t unpadded, total_size, padded, write_size;
+		int pad;
+
+		if (blocks[i].cfg.name_len)
+			hdr_len = BOOTCONFIG_ID_PREFIX_LEN +
+				  blocks[i].cfg.name_len + 1;
+
+		unpadded = hdr_len + body_len;
+		if (body_len == 0 || blocks[i].cfg.data[body_len - 1] != '\0')
+			unpadded++;
+
+		total_size = (size_t)cur_off + unpadded + BOOTCONFIG_FOOTER_SIZE;
+		pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
+		padded = unpadded + pad;
+		write_size = padded + BOOTCONFIG_FOOTER_SIZE;
+		total_len += write_size;
+		cur_off += (off_t)write_size;
+	}
+
+	buf = calloc(total_len, 1);
+	if (!buf)
+		return -ENOMEM;
+
+	dst = buf;
+	cur_off = base_size;
+	for (i = 0; i < count; i++) {
+		size_t hdr_len = 0, body_len = blocks[i].cfg.size;
+		size_t unpadded, total_size, padded, write_size;
+		uint32_t csum;
+		int pad;
+
+		if (blocks[i].cfg.name_len) {
+			memcpy(dst, BOOTCONFIG_ID_PREFIX,
+			       BOOTCONFIG_ID_PREFIX_LEN);
+			memcpy(dst + BOOTCONFIG_ID_PREFIX_LEN,
+			       blocks[i].cfg.name, blocks[i].cfg.name_len);
+			hdr_len = BOOTCONFIG_ID_PREFIX_LEN +
+				  blocks[i].cfg.name_len;
+			dst[hdr_len++] = '\n';
+		}
+
+		if (body_len)
+			memcpy(dst + hdr_len, blocks[i].cfg.data, body_len);
+
+		unpadded = hdr_len + body_len;
+		if (body_len == 0 || blocks[i].cfg.data[body_len - 1] != '\0')
+			unpadded++;
+
+		csum = xbc_calc_checksum(dst, unpadded);
+
+		total_size = (size_t)cur_off + unpadded + BOOTCONFIG_FOOTER_SIZE;
+		pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
+		padded = unpadded + pad;
+
+		footer.size = htole32((uint32_t)padded);
+		footer.csum = htole32(csum);
+		memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
+		memcpy(dst + padded, &footer, BOOTCONFIG_FOOTER_SIZE);
+
+		write_size = padded + BOOTCONFIG_FOOTER_SIZE;
+		dst += write_size;
+		cur_off += (off_t)write_size;
+	}
+
+	*out = buf;
+	return (ssize_t)total_len;
+}
+
+static int write_xbc_blocks(int fd, off_t base_size, struct xbc_block *blocks,
+			    int count, const char *path)
+{
+	struct stat st;
+	char *old_tail = NULL, *new_tail = NULL;
+	ssize_t old_len = 0, new_len, rlen, wlen;
+	int ret = 0;
+
+	if (fstat(fd, &st) < 0)
+		return pr_errno("Failed to stat initrd", -errno);
+
+	if (st.st_size > base_size) {
+		old_len = st.st_size - base_size;
+		old_tail = malloc(old_len);
+		if (!old_tail)
+			return -ENOMEM;
+		rlen = pread(fd, old_tail, old_len, base_size);
+		if (rlen != old_len) {
+			free(old_tail);
+			return pr_errno("Failed to backup existing bootconfigs",
+					rlen < 0 ? -errno : -EIO);
+		}
+	}
+
+	new_len = serialize_xbc_blocks(&new_tail, base_size, blocks, count);
+	if (new_len < 0) {
+		free(old_tail);
+		return (int)new_len;
+	}
+
+	if (new_len > 0) {
+		wlen = pwrite(fd, new_tail, new_len, base_size);
+		if (wlen != new_len) {
+			ret = wlen < 0 ? -errno : -ENOSPC;
+			pr_err("Failed to apply a boot config: %d\n", ret);
+			goto out_rollback;
+		}
+	}
+
+	if (ftruncate(fd, base_size + new_len) < 0) {
+		ret = -errno;
+		pr_err("Failed to truncate initrd: %d\n", ret);
+		goto out_rollback;
+	}
+
+	free(new_tail);
+	free(old_tail);
+	return 0;
+
+out_rollback:
+	if (old_len > 0) {
+		wlen = pwrite(fd, old_tail, old_len, base_size);
+		if (wlen != old_len) {
+			int rerr = wlen < 0 ? -errno : -ENOSPC;
+
+			pr_err("Failed to rollback the write error: %d\n", rerr);
+			pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
+			goto out_free;
+		}
+	}
+	if (ftruncate(fd, base_size + old_len) < 0) {
+		int rerr = -errno;
+
+		pr_err("Failed to rollback the write error: %d\n", rerr);
+		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
+	}
+out_free:
+	free(new_tail);
+	free(old_tail);
 	return ret;
 }
 
-static int delete_xbc(const char *path)
+static int delete_xbc(const char *path, const char *id_spec)
 {
-	struct stat stat;
-	int ret = 0, fd, size;
-	char *buf = NULL;
+	struct xbc_block blocks[XBC_CONFIG_MAX];
+	struct xbc_block kept[XBC_CONFIG_MAX];
+	struct xbc_config cfgs[XBC_CONFIG_MAX];
+	off_t base_size = 0;
+	int ret = 0, fd, count, kept_count = 0, i;
+	bool seeded = false;
+
+	if (id_spec && (*id_spec == '\0' || *id_spec == '+')) {
+		pr_err("Invalid delete ID specification '%s'\n", id_spec);
+		return -EINVAL;
+	}
 
 	fd = open(path, O_RDWR);
 	if (fd < 0) {
@@ -400,140 +754,224 @@ static int delete_xbc(const char *path)
 		return ret;
 	}
 
-	size = load_xbc_from_initrd(fd, &buf);
-	if (size < 0) {
-		ret = size;
+	count = load_xbc_list_from_initrd(fd, blocks, XBC_CONFIG_MAX, &base_size);
+	if (count < 0) {
+		ret = count;
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
-	} else if (size > 0) {
-		ret = fstat(fd, &stat);
-		if (!ret)
-			ret = ftruncate(fd, stat.st_size
-					- size - BOOTCONFIG_FOOTER_SIZE);
-		if (ret)
+		goto out;
+	}
+
+	if (count == 0) {
+		if (id_spec) {
+			pr_err("No bootconfig found in %s\n", path);
+			ret = -ENOENT;
+		}
+		goto out;
+	}
+
+	if (!id_spec) {
+		if (ftruncate(fd, base_size) < 0)
 			ret = -errno;
-	} /* Ignore if there is no boot config in initrd */
+		goto out_free;
+	}
 
-	close(fd);
-	free(buf);
+	for (i = 0; i < count; i++)
+		cfgs[i] = blocks[i].cfg;
+
+	ret = xbc_enable_configs(cfgs, count, id_spec, &seeded);
+	if (ret < 0)
+		goto out_free;
+
+	for (i = 0; i < count; i++) {
+		if (!cfgs[i].enabled)
+			kept[kept_count++] = blocks[i];
+	}
+
+	ret = write_xbc_blocks(fd, base_size, kept, kept_count, path);
 
+out_free:
+	free_xbc_blocks(blocks, count);
+out:
+	close(fd);
 	return ret;
 }
 
-static int apply_xbc(const char *path, const char *xbc_path)
+static int apply_xbc(const char *path, const char *xbc_path, const char *id)
 {
-	struct {
-		uint32_t size;
-		uint32_t csum;
-		char magic[BOOTCONFIG_MAGIC_LEN];
-	} footer;
-	char *buf, *data;
-	size_t total_size;
-	struct stat stat;
-	uint32_t size, csum;
-	int pad;
-	int ret, fd;
+	struct xbc_block blocks[XBC_CONFIG_MAX];
+	char *buf = NULL;
+	off_t base_size = 0;
+	size_t hdr_len = 0, body_size, block_size;
+	uint32_t csum;
+	int ret, fd, count, i, target = -1;
+
+	if (id && !xbc_valid_id(id, strlen(id))) {
+		pr_err("Invalid bootconfig ID '%s'\n", id);
+		return -EINVAL;
+	}
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
 		pr_err("Failed to load %s : %d\n", xbc_path, ret);
 		return ret;
 	}
-	size = ret;
-	if (size == 0 || buf[size - 1] != '\0')
-		size++;
-	csum = xbc_calc_checksum(buf, size);
+	body_size = ret;
+	if (body_size >= BOOTCONFIG_ID_PREFIX_LEN &&
+	    !memcmp(buf, BOOTCONFIG_ID_PREFIX, BOOTCONFIG_ID_PREFIX_LEN)) {
+		pr_err("Input file %s must not contain %s header; use -i <id>\n",
+		       xbc_path, BOOTCONFIG_ID_PREFIX);
+		free(buf);
+		return -EINVAL;
+	}
+
+	if (body_size == 0 || buf[body_size - 1] != '\0')
+		body_size++;
 
-	/* Verify the data format */
-	ret = init_xbc_with_error(buf, size);
+	if (id)
+		hdr_len = BOOTCONFIG_ID_PREFIX_LEN + strlen(id) + 1;
+	block_size = hdr_len + body_size;
+	if (block_size > XBC_DATA_MAX) {
+		pr_err("%s size is too big%s\n", xbc_path,
+		       id ? " with ID header" : "");
+		free(buf);
+		return -E2BIG;
+	}
+
+	/* Verify the data format standalone */
+	ret = init_xbc_with_error(buf, body_size);
 	if (ret < 0) {
 		free(buf);
 		return ret;
 	}
 
-	/* Backup the bootconfig data */
-	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
-	if (!data) {
-		free(buf);
-		return -ENOMEM;
+	csum = xbc_calc_checksum(buf, body_size);
+	if (id) {
+		char hdr[BOOTCONFIG_ID_PREFIX_LEN + BOOTCONFIG_ID_MAX + 2];
+
+		snprintf(hdr, sizeof(hdr), "%s%s\n", BOOTCONFIG_ID_PREFIX, id);
+		csum += xbc_calc_checksum(hdr, hdr_len);
 	}
-	memcpy(data, buf, size);
 
 	printf("Apply %s to %s\n", xbc_path, path);
+	if (id)
+		printf("\tID: %s\n", id);
 	xbc_get_info(&ret, NULL);
 	printf("\tNumber of nodes: %d\n", ret);
-	printf("\tSize: %u bytes\n", (unsigned int)size);
+	printf("\tSize: %zu bytes\n", block_size);
 	printf("\tChecksum: %u\n", (unsigned int)csum);
 
 	/* TODO: Check the options by schema */
 	xbc_exit();
-	free(buf);
 
-	/* Remove old boot config if exists */
-	ret = delete_xbc(path);
-	if (ret < 0) {
-		pr_err("Failed to delete previous boot config: %d\n", ret);
-		free(data);
-		return ret;
-	}
-
-	/* Apply new one */
-	fd = open(path, O_RDWR | O_APPEND);
+	fd = open(path, O_RDWR);
 	if (fd < 0) {
 		ret = -errno;
 		pr_err("Failed to open %s: %d\n", path, ret);
-		free(data);
+		free(buf);
 		return ret;
 	}
-	/* TODO: Ensure the @path is initramfs/initrd image */
-	if (fstat(fd, &stat) < 0) {
-		ret = -errno;
-		pr_err("Failed to get the size of %s\n", path);
-		goto out;
-	}
-
-	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + BOOTCONFIG_FOOTER_SIZE;
-	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
-	size += pad;
-
-	/* Add a footer */
-	footer.size = htole32(size);
-	footer.csum = htole32(csum);
-	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE,
-		      "bootconfig footer size mismatch");
-	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
 
-	total_size = size + BOOTCONFIG_FOOTER_SIZE;
+	count = load_xbc_list_from_initrd(fd, blocks, XBC_CONFIG_MAX, &base_size);
+	if (count < 0) {
+		ret = count;
+		pr_err("Failed to load existing boot configs: %d\n", ret);
+		free(buf);
+		close(fd);
+		return ret;
+	}
 
-	ret = write(fd, data, total_size);
-	if (ret < 0) {
-		ret = -errno;
-		pr_err("Failed to apply a boot config: %d\n", ret);
-		goto out;
+	if (!id) {
+		for (i = 0; i < count; i++) {
+			if (!blocks[i].cfg.name_len) {
+				target = i;
+				break;
+			}
+		}
+		if (target >= 0) {
+			free(blocks[target].raw_buf);
+			if (target > 0)
+				memmove(&blocks[1], &blocks[0],
+					target * sizeof(*blocks));
+			target = 0;
+		} else {
+			if (count >= XBC_CONFIG_MAX) {
+				pr_err("Too many bootconfigs in %s (max %d)\n",
+				       path, XBC_CONFIG_MAX);
+				ret = -E2BIG;
+				goto out_err;
+			}
+			if (count > 0)
+				memmove(&blocks[1], &blocks[0],
+					count * sizeof(*blocks));
+			target = 0;
+			count++;
+		}
+		blocks[target].cfg.name = "";
+		blocks[target].cfg.name_len = 0;
+	} else {
+		size_t id_len = strlen(id);
+
+		for (i = 0; i < count; i++) {
+			if (blocks[i].cfg.name_len == id_len &&
+			    !memcmp(blocks[i].cfg.name, id, id_len)) {
+				target = i;
+				break;
+			}
+		}
+		if (target >= 0) {
+			free(blocks[target].raw_buf);
+		} else {
+			if (count >= XBC_CONFIG_MAX) {
+				pr_err("Too many bootconfigs in %s (max %d)\n",
+				       path, XBC_CONFIG_MAX);
+				ret = -E2BIG;
+				goto out_err;
+			}
+			target = count++;
+		}
+		blocks[target].cfg.name = id;
+		blocks[target].cfg.name_len = id_len;
 	}
-	if ((size_t)ret != total_size) {
-		pr_err("Failed to apply a boot config: %d\n", ret);
-		goto out_rollback;
+
+	blocks[target].raw_buf = buf;
+	blocks[target].cfg.data = buf;
+	blocks[target].cfg.size = body_size;
+	blocks[target].cfg.enabled = false;
+	buf = NULL;
+
+	if (count > 1) {
+		int lo = target ? target : 1;
+		int hi = target ? target + 1 : count;
+
+		for (i = lo; i < hi; i++) {
+			struct xbc_config pair[2] = {
+				blocks[0].cfg,
+				blocks[i].cfg,
+			};
+			const char *emsg = NULL;
+			int epos = -1, eidx = -1;
+
+			pair[0].enabled = true;
+			pair[1].enabled = true;
+			if (xbc_init_configs(pair, 2, &emsg, &epos, &eidx) < 0)
+				fprintf(stderr,
+					"Warning: merging [%d%s%.*s] with default config [0]: %s\n",
+					i, blocks[i].cfg.name_len ? ":" : "",
+					(int)blocks[i].cfg.name_len,
+					blocks[i].cfg.name,
+					emsg ? emsg : "merge conflict");
+			else
+				xbc_exit();
+		}
 	}
-	ret = 0;
 
-out:
-	close(fd);
-	free(data);
+	ret = write_xbc_blocks(fd, base_size, blocks, count, path);
 
+out_err:
+	free(buf);
+	free_xbc_blocks(blocks, count);
+	close(fd);
 	return ret;
-
-out_rollback:
-	/* Map the partial write to -ENOSPC */
-	if (ret >= 0)
-		ret = -ENOSPC;
-	if (ftruncate(fd, stat.st_size) < 0) {
-		ret = -errno;
-		pr_err("Failed to rollback the write error: %d\n", ret);
-		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
-	}
-	goto out;
 }
 
 static int usage(void)
@@ -544,6 +982,7 @@ static int usage(void)
 		" Options:\n"
 		"		-a <config>: Apply boot config to initrd\n"
 		"		-d : Delete boot config file from initrd\n"
+		"		-i <id[,...]> : Specify boot config ID or index\n"
 		"		-l : list boot config in initrd or file\n"
 		"		-C : render the kernel.* subtree as a flat cmdline\n"
 		"		     string (suitable for embedding in a kernel image)\n"
@@ -556,11 +995,12 @@ int main(int argc, char **argv)
 {
 	char *path = NULL;
 	char *apply = NULL;
+	char *id = NULL;
 	bool render_cmdline = false;
 	bool delete = false, list = false;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hda:lC")) != -1) {
+	while ((opt = getopt(argc, argv, "hda:i:lC")) != -1) {
 		switch (opt) {
 		case 'd':
 			delete = true;
@@ -568,6 +1008,9 @@ int main(int argc, char **argv)
 		case 'a':
 			apply = optarg;
 			break;
+		case 'i':
+			id = optarg;
+			break;
 		case 'l':
 			list = true;
 			break;
@@ -593,9 +1036,9 @@ int main(int argc, char **argv)
 	path = argv[optind];
 
 	if (apply)
-		return apply_xbc(path, apply);
+		return apply_xbc(path, apply, id);
 	else if (delete)
-		return delete_xbc(path);
+		return delete_xbc(path, id);
 
-	return show_xbc(path, list, render_cmdline);
+	return show_xbc(path, list, render_cmdline, id);
 }
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a93a40d11d27..597beadc5ce3 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -279,6 +279,122 @@ for i in samples/good-* ; do
   xpass diff $x $TEMPCONF
 done
 
+echo "=== multiple bootconfig tests ==="
+dd if=/dev/zero of=$INITRD bs=4097 count=1 2>/dev/null
+orig_size=$(wc -c < $INITRD)
+
+printf 'kernel.root = /dev/sda1\nfoo = a\n' > $TEMPCONF
+echo "ID validation tests"
+xfail $BOOTCONF -i "0bad" -a $TEMPCONF $INITRD
+xfail $BOOTCONF -i "9" -a $TEMPCONF $INITRD
+xfail $BOOTCONF -i "a,b" -a $TEMPCONF $INITRD
+xfail $BOOTCONF -i "+a" -a $TEMPCONF $INITRD
+xfail $BOOTCONF -i "bad id" -a $TEMPCONF $INITRD
+xfail $BOOTCONF -i "12345678901234567890123456789012" -a $TEMPCONF $INITRD
+xfail $BOOTCONF -i "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" -a $TEMPCONF $INITRD
+xpass $BOOTCONF -i "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" -a $TEMPCONF $INITRD
+xpass $BOOTCONF -d $INITRD
+xpass test $orig_size -eq $(wc -c < $INITRD)
+
+echo "Apply named and default bootconfigs"
+printf 'kernel.loglevel = 5\nfoo = base\nbar = one\n' > $TEMPCONF
+xpass $BOOTCONF -i _alpha -a $TEMPCONF $INITRD
+printf 'kernel.loglevel := 7\nfoo := debug\nbar += two\n' > $TEMPCONF
+xpass $BOOTCONF -i beta-1.0 -a $TEMPCONF $INITRD
+printf 'kernel.quiet\nfoo = def\nbar = zero\n' > $TEMPCONF
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q '\[0\][[:space:]](default)' $OUTFILE
+xpass grep -q '\[1\][[:space:]]#BOOTCONFIG-ID:[[:space:]]_alpha' $OUTFILE
+xpass grep -q '\[2\][[:space:]]#BOOTCONFIG-ID:[[:space:]]beta-1.0' $OUTFILE
+
+echo "Replace existing named bootconfig in place"
+printf 'kernel.loglevel = 4\nfoo = alpha_v2\nbar = one\n' > $TEMPCONF
+xpass $BOOTCONF -i _alpha -a $TEMPCONF $INITRD 2> $OUTFILE
+xpass grep -q 'Warning:[[:space:]]merging' $OUTFILE
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q 'alpha_v2' $OUTFILE
+xpass grep -q '\[1\][[:space:]]#BOOTCONFIG-ID:[[:space:]]_alpha' $OUTFILE
+xpass grep -q '\[2\][[:space:]]#BOOTCONFIG-ID:[[:space:]]beta-1.0' $OUTFILE
+
+echo "Select and merge by ID, index, and +append"
+$BOOTCONF -l -i _alpha,beta-1.0 $INITRD > $OUTFILE
+xpass grep -q 'foo[[:space:]]=[[:space:]]"debug"' $OUTFILE
+xpass grep -q 'bar[[:space:]]=[[:space:]]"one",[[:space:]]"two"' $OUTFILE
+xpass grep -q 'kernel.loglevel[[:space:]]=[[:space:]]"7"' $OUTFILE
+
+$BOOTCONF -l -i 1,2 $INITRD > $TEMPCONF
+xpass cmp $OUTFILE $TEMPCONF
+
+$BOOTCONF -C -i _alpha,beta-1.0 $INITRD > $OUTFILE
+xpass grep -q 'loglevel=7' $OUTFILE
+
+$BOOTCONF -l -i ,beta-1.0 $INITRD > $OUTFILE
+xpass grep -q 'kernel.quiet[[:space:]]=[[:space:]]""' $OUTFILE
+xpass grep -q 'foo[[:space:]]=[[:space:]]"debug"' $OUTFILE
+xpass grep -q 'bar[[:space:]]=[[:space:]]"zero",[[:space:]]"two"' $OUTFILE
+
+$BOOTCONF -l -i +beta-1.0 $INITRD > $TEMPCONF
+xpass cmp $OUTFILE $TEMPCONF
+
+echo "Missing ID / index error and cross-file redefinition error"
+xfail $BOOTCONF -l -i missing $INITRD
+xfail $BOOTCONF -l -i 9 $INITRD
+xfail $BOOTCONF -l -i ,_alpha $INITRD
+$BOOTCONF -l -i ,_alpha $INITRD 2> $OUTFILE || true
+xpass grep -q 'Error[[:space:]]in[[:space:]]bootconfig[[:space:]]\[1:_alpha\]' $OUTFILE
+
+echo "Selective delete and delete all"
+xfail $BOOTCONF -d -i missing $INITRD
+xpass $BOOTCONF -d -i _alpha $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q '\[0\][[:space:]](default)' $OUTFILE
+xpass grep -q '\[1\][[:space:]]#BOOTCONFIG-ID:[[:space:]]beta-1.0' $OUTFILE
+xfail grep -q '_alpha' $OUTFILE
+
+xpass $BOOTCONF -d -i 0 $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q '\[0\][[:space:]]#BOOTCONFIG-ID:[[:space:]]beta-1.0' $OUTFILE
+xfail grep -q 'quiet' $OUTFILE
+
+xpass $BOOTCONF -d $INITRD
+xpass test $orig_size -eq $(wc -c < $INITRD)
+
+echo "Max stacked configs (32) limit check"
+i=0
+while [ $i -lt 32 ]; do
+  printf "k_%d = v_%d\n" $i $i > $TEMPCONF
+  if ! $BOOTCONF -i "cfg_$i" -a $TEMPCONF $INITRD > /dev/null; then
+    break
+  fi
+  i=$((i + 1))
+done
+xpass test $i -eq 32
+printf "k_extra = 1\n" > $TEMPCONF
+xfail $BOOTCONF -i cfg_32 -a $TEMPCONF $INITRD
+$BOOTCONF -l -i 31 $INITRD > $OUTFILE
+xpass grep -q 'k_31[[:space:]]=[[:space:]]"v_31"' $OUTFILE
+xpass $BOOTCONF -d $INITRD
+xpass test $orig_size -eq $(wc -c < $INITRD)
+
+echo "Total stacked size > 32KB with valid per-selection size"
+printf "big1 = \"" > $TEMPCONF
+dd if=/dev/zero bs=1 count=20000 2>/dev/null | tr '\0' 'a' >> $TEMPCONF
+printf "\"\n" >> $TEMPCONF
+xpass $BOOTCONF -i big1 -a $TEMPCONF $INITRD
+printf "big2 = \"" > $TEMPCONF
+dd if=/dev/zero bs=1 count=20000 2>/dev/null | tr '\0' 'b' >> $TEMPCONF
+printf "\"\n" >> $TEMPCONF
+xpass $BOOTCONF -i big2 -a $TEMPCONF $INITRD
+$BOOTCONF -l -i big1 $INITRD > $OUTFILE
+xpass grep -q 'big1[[:space:]]=' $OUTFILE
+$BOOTCONF -l -i big2 $INITRD > $OUTFILE
+xpass grep -q 'big2[[:space:]]=' $OUTFILE
+xfail $BOOTCONF -l -i big1,big2 $INITRD
+xpass $BOOTCONF -d $INITRD
+xpass test $orig_size -eq $(wc -c < $INITRD)
+
 
 echo
 echo "=== Summary ==="
-- 
2.43.0

