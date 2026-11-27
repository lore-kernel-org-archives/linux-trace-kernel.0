Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789460;
	b=Glu5N5YrRc/6mSJ4nY/Q+QkGBeJYGOwtyfMo03jwBeiEC+HkLqsFAHn1ycjWHXg3tN+7
	 DeUmPexBV96v5+ExGy9RB5SSabQ/h1FxHYIUGep0Sw5QZICjiyxXAfQhyBQZmVI52ruoW
	 drJERmCFVM2hGl6mZNac4s2mMYNjttyOE/S4OFWpOoaZIjbY/8Qol20NZjjTjDyzAh2QL
	 cUBxIMEkwVTbKdC3ALQWpLoHn5bFAh/MslTDFCE567XIDevfPV/i7RADdKya+G83dFMGU
	 YqhP0/4rIWewwt+ipof5n2qi/23ww+ekTvQl6MdN5c/JQ7m8u2FEpREk15YnVKt0t0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789460;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Wi3l+WyqcEOh6jHsYNxXvDk+Dz0Vf8I2SYD6ccIAFuw=;
	b=a/kUDbqcIC7imAoEBs/DtMHrYXTXp/Rb5aqhzgogTV7sW/as1aFKaGo8alXcUOeeBWjF
	 Z3x5OcAsET6tq4vnSFyUbKmgZGDV908Pck1UPfW4uRpFq/OHpRaKe3/LKMerdoGqcgrDe
	 2Y56ViCnfYHYHWKqVHtIRcSTckyJvwi0xAODS76lWz+2tdPkCsVqOjMAT9+nqishNJ2QF
	 rB+e8JLGhx7nkrkP23MDckCe9j0S4A9qZv2E4Vha56td/OS3Vbw7NVMy8yJQYC4MyD/iC
	 j+e38BBP7K10m4aCChstzwEzeQJ58/3/VxDABeoVL6JRtfGawLG1AFHTG1LQmwoolAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ec+7jskX;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0F606EF0D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF0F606EF0D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ec+7jskX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 13FA11A1836;
	Fri, 27 Nov 2026 14:24:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA4206049C;
	Fri, 27 Nov 2026 14:24:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FCC711E68FFA;
	Fri, 27 Nov 2026 15:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789451; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wi3l+WyqcEOh6jHsYNxXvDk+Dz0Vf8I2SYD6ccIAFuw=;
	b=Ec+7jskXWokFRPY7xVzYFE9KfxVUanpgg89Bxvm9ZWRNHt5Znk78hfIF3L8zORK8xKo3ik
	AkzTaVk/GKF1byguXg1dr56t0ByiSMil2uPvbMdJfp5dDxsDyJMu9rMmb9QELx1vCEzzm0
	FhCB/LEeuZk+mNbR5Zsz27NWUdYQdWhosR++f8WrgSVQfKohdvA/gHK8KYESuNnGJMLCxn
	HDIyoizYlv/m6i2pWUcUK1++jMz+HMq4nrw2ZFSh/DGBmDLqSVh0WnHD8XjAujFDxOjhJd
	Jcx78fBlNuOtj8ZJFJV8pzOJWF35BR6fed5zyCcuhKZBw+G8rRg2s+nBHe2Q0w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:28 +0100
Subject: [PATCH RFC v2 06/35] spi: spi-mem: Add support for dummy cycles
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-6-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The dummy phase is a number of clock cycles, not a number of bytes. SPI
NOR flashes commonly require a number of dummy cycles that is not a
multiple of 8, and the byte-based representation cannot express it.

Add a dummy.ncycles field and make it the primary representation. Keep
dummy.nbytes for the legacy byte-oriented controllers and users. The two
fields are mutually exclusive and spi_mem_check_op() enforces that rule.

Controllers that can program an arbitrary number of cycles advertise the
dummy_cycles capability and consume dummy.ncycles directly. The core
converts the legacy dummy.nbytes to cycles for them, so the users that
still describe the dummy phase in bytes keep working. If the byte count
cannot be expressed as a whole number of cycles, the operation is
rejected.

For the other controllers the core converts dummy.ncycles to the legacy
dummy.nbytes representation using the usual maths. If the cycle count
cannot be represented exactly, the operation is rejected instead of
being silently truncated.

Link: https://lore.kernel.org/all/20220911174551.653599-1-sergiu.moga@microchip.com/
Link: https://lore.kernel.org/all/20250115134158.19908-1-pratyush@kernel.org/

Link: https://lore.kernel.org/all/20220911174551.653599-1-sergiu.moga@microchip.com/
Link: https://lore.kernel.org/all/20250115134158.19908-1-pratyush@kernel.org/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c          | 224 ++++++++++++++++++++++++++++++++++++++---
 include/linux/spi/spi-mem.h    |  39 ++++++-
 include/trace/events/spi-mem.h |   5 +-
 3 files changed, 245 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a1f129c47698..1642388b7004 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -12,6 +12,24 @@
 #include <linux/spi/spi-mem.h>
 #include <linux/sched/task_stack.h>
 
+static unsigned int
+spi_mem_get_dummy_nbytes(const struct spi_mem_op *op)
+{
+	u32 bits;
+
+	if (!op->dummy.ncycles)
+		return op->dummy.nbytes;
+
+	if (!op->dummy.buswidth)
+		return 0;
+
+	bits = (u32)op->dummy.ncycles * op->dummy.buswidth;
+	if (op->dummy.dtr)
+		bits *= 2;
+
+	return DIV_ROUND_UP(bits, 8);
+}
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi-mem.h>
 
@@ -252,6 +270,111 @@ static bool spi_mem_buswidth_is_valid(u8 buswidth)
 	return true;
 }
 
+/**
+ * spi_mem_dummy_cycles_to_bytes() - Convert the dummy phase cycles to bytes
+ * @op: the SPI memory operation
+ *
+ * Return: the number of dummy bytes on success, a negative error code if the
+ *	   dummy phase cannot be represented as a whole number of bytes.
+ *	   If @op->dummy.ncycles is zero, @op->dummy.nbytes is returned.
+ *
+ * This helper can be used to convert dummy cycles into dummy bytes for
+ * controllers that can only insert a whole number of dummy bytes.
+ */
+static int spi_mem_dummy_cycles_to_bytes(const struct spi_mem_op *op)
+{
+	u32 bits;
+
+	if (!op->dummy.ncycles)
+		return op->dummy.nbytes;
+
+	if (!op->dummy.buswidth)
+		return -EOPNOTSUPP;
+
+	bits = (u32)op->dummy.ncycles * op->dummy.buswidth;
+	if (op->dummy.dtr)
+		bits *= 2;
+
+	if (bits % 8 || bits / 8 > U8_MAX)
+		return -EOPNOTSUPP;
+
+	return bits / 8;
+}
+
+/**
+ * spi_mem_dummy_bytes_to_cycles() - Convert the dummy phase bytes to cycles
+ * @op: the SPI memory operation
+ *
+ * Return: the number of dummy clock cycles on success, a negative error code
+ *	   if the dummy phase cannot be represented as a whole number of clock
+ *	   cycles. If @op->dummy.nbytes is zero, @op->dummy.ncycles is returned.
+ *
+ * This helper can be used to convert inlet operations using dummy bytes
+ * into operations using dummy cycles.
+ */
+static int spi_mem_dummy_bytes_to_cycles(const struct spi_mem_op *op)
+{
+	u32 bits, bits_per_cycle;
+
+	if (!op->dummy.nbytes)
+		return op->dummy.ncycles;
+
+	bits_per_cycle = op->dummy.buswidth;
+	if (op->dummy.dtr)
+		bits_per_cycle *= 2;
+	if (!bits_per_cycle)
+		return -EOPNOTSUPP;
+
+	bits = (u32)op->dummy.nbytes * 8;
+	if (bits % bits_per_cycle)
+		return -EOPNOTSUPP;
+
+	bits /= bits_per_cycle;
+	if (bits > U8_MAX)
+		return -EOPNOTSUPP;
+
+	return bits;
+}
+
+/*
+ * Controllers either program the dummy phase in clock cycles or in whole
+ * bytes. Convert the representation used by the operation to the one the
+ * controller expects.
+ *
+ * Return: 0 if the operation is lossless, -EOPNOTSUPP otherwise.
+ */
+static int spi_mem_convert_dummy(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	int n;
+
+	if (op->dummy.ncycles) {
+		if (spi_mem_controller_is_capable(ctlr, dummy_cycles))
+			return 0;
+
+		n = spi_mem_dummy_cycles_to_bytes(op);
+		if (n < 0)
+			return n;
+
+		op->dummy.nbytes = n;
+		op->dummy.ncycles = 0;
+	} else if (op->dummy.nbytes) {
+		if (!spi_mem_controller_is_capable(ctlr, dummy_cycles))
+			return 0;
+
+		n = spi_mem_dummy_bytes_to_cycles(op);
+		if (n < 0)
+			return n;
+
+		op->dummy.ncycles = n;
+		op->dummy.nbytes = 0;
+
+		return 0;
+	}
+
+	return 0;
+}
+
 static int spi_mem_check_op(const struct spi_mem_op *op)
 {
 	if (!op->cmd.buswidth || !op->cmd.nbytes)
@@ -259,9 +382,13 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 
 	if ((op->addr.nbytes && !op->addr.buswidth) ||
 	    (op->dummy.nbytes && !op->dummy.buswidth) ||
+	    (op->dummy.ncycles && !op->dummy.buswidth) ||
 	    (op->data.nbytes && !op->data.buswidth))
 		return -EINVAL;
 
+	if (op->dummy.nbytes && op->dummy.ncycles)
+		return -EINVAL;
+
 	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
 	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
 	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
@@ -321,6 +448,9 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (spi_mem_check_op(&eval_op))
 		return false;
 
+	if (spi_mem_convert_dummy(mem, &eval_op))
+		return false;
+
 	return spi_mem_internal_supports_op(mem, &eval_op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
@@ -366,6 +496,7 @@ static void spi_mem_access_end(struct spi_mem *mem)
 static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
 				 const struct spi_mem_op *op, int exec_op_ret)
 {
+	int dummy_nbytes = spi_mem_get_dummy_nbytes(op);
 	struct spi_statistics *stats;
 	u64 len, l2len;
 
@@ -382,7 +513,7 @@ static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
 
 	/* Use the sum of all lengths as bytes count and histogram value. */
 	len = op->cmd.nbytes + op->addr.nbytes;
-	len += op->dummy.nbytes + op->data.nbytes;
+	len += dummy_nbytes + op->data.nbytes;
 	u64_stats_add(&stats->bytes, len);
 	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
 	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
@@ -409,31 +540,41 @@ static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
- * @op: the memory operation to execute
+ * @ro_op: the memory operation to execute (shall not be edited)
  *
  * Executes a memory operation.
  *
- * This function first checks that @op is supported and then tries to execute
- * it.
+ * This function first checks that @ro_op is supported and then tries to
+ * execute it.
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *ro_op)
 {
 	unsigned int tmpbufsize, xferpos = 0, totalxferlen = 0;
 	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_op wr_op = *ro_op, *op = &wr_op;
 	struct spi_transfer xfers[4] = { };
 	struct spi_message msg;
 	u8 *tmpbuf;
 	int ret;
 
 	/* Make sure the operation frequency is correct before going futher */
-	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
+	spi_mem_adjust_op_freq(mem, op);
+
+	ret = spi_mem_check_op(op);
+	if (ret)
+		return ret;
+
+	/* Also make sure the dummy phase can be consumed by the controller */
+	ret = spi_mem_convert_dummy(mem, op);
+	if (ret)
+		return ret;
 
 	dev_vdbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%2dB dummy][%4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",
 		 op->cmd.opcode,
 		 op->addr.nbytes, (op->addr.nbytes ? op->addr.val : 0),
-		 op->dummy.nbytes,
+		 spi_mem_get_dummy_nbytes(op),
 		 op->data.nbytes, (op->data.nbytes ? (op->data.dir == SPI_MEM_DATA_IN ? " read" : "write") : "     "),
 		 op->cmd.buswidth, op->cmd.dtr ? 'D' : 'S',
 		 op->addr.buswidth, op->addr.dtr ? 'D' : 'S',
@@ -441,10 +582,6 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 op->data.buswidth, op->data.dtr ? 'D' : 'S',
 		 op->max_freq ? op->max_freq : mem->spi->max_speed_hz);
 
-	ret = spi_mem_check_op(op);
-	if (ret)
-		return ret;
-
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -EOPNOTSUPP;
 
@@ -472,6 +609,22 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 	}
 
+	/*
+	 * spi_mem_convert_dummy() converted the dummy phase to cycles because
+	 * the controller advertised the dummy_cycles capability. The regular
+	 * SPI transfer path below builds spi_transfer segments and can only
+	 * express the dummy phase in bytes, so convert it back. Reject the
+	 * operation if the cycle count cannot be represented exactly.
+	 */
+	if (op->dummy.ncycles) {
+		ret = spi_mem_dummy_cycles_to_bytes(op);
+		if (ret < 0)
+			return ret;
+
+		op->dummy.nbytes = ret;
+		op->dummy.ncycles = 0;
+	}
+
 	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
 
 	/*
@@ -625,12 +778,22 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 	size_t len;
+	int ret;
+
+	ret = spi_mem_convert_dummy(mem, op);
+	if (ret)
+		return ret;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
-		len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+		int dummy_nbytes = spi_mem_dummy_cycles_to_bytes(op);
+
+		if (dummy_nbytes < 0)
+			return dummy_nbytes;
+
+		len = op->cmd.nbytes + op->addr.nbytes + dummy_nbytes;
 
 		if (len > spi_max_transfer_size(mem->spi))
 			return -EINVAL;
@@ -701,9 +864,12 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
 	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
 
-	/* Dummy bytes are optional for some SPI flash memory operations */
-	if (op->dummy.nbytes)
-		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+	/* Dummy cycles are optional for some SPI flash memory operations */
+	if (op->dummy.ncycles)
+		ncycles += op->dummy.ncycles;
+	else if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) /
+			   (op->dummy.dtr ? 2 : 1);
 
 	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
 
@@ -809,6 +975,21 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 	desc->mem = mem;
 	desc->info = *info;
 	desc->info.op_tmpl = &desc->info.primary_op_tmpl;
+
+	ret = spi_mem_convert_dummy(mem, &desc->info.primary_op_tmpl);
+	if (ret) {
+		kfree(desc);
+		return ERR_PTR(ret);
+	}
+
+	if (desc->info.secondary_op_tmpl.cmd.opcode) {
+		ret = spi_mem_convert_dummy(mem, &desc->info.secondary_op_tmpl);
+		if (ret) {
+			kfree(desc);
+			return ERR_PTR(ret);
+		}
+	}
+
 	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create) {
 		ret = spi_mem_access_start(mem);
 		if (ret) {
@@ -819,6 +1000,8 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 		ret = ctlr->mem_ops->dirmap_create(desc);
 
 		spi_mem_access_end(mem);
+	} else {
+		ret = -EOPNOTSUPP;
 	}
 
 	if (ret) {
@@ -1065,6 +1248,7 @@ int spi_mem_poll_status(struct spi_mem *mem,
 			u16 timeout_ms)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_op eval_op = *op;
 	int ret = -EOPNOTSUPP;
 	int read_status_ret;
 	u16 status;
@@ -1074,11 +1258,19 @@ int spi_mem_poll_status(struct spi_mem *mem,
 		return -EINVAL;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->poll_status && !spi_get_csgpiod(mem->spi, 0)) {
+		ret = spi_mem_check_op(&eval_op);
+		if (ret)
+			return ret;
+
+		ret = spi_mem_convert_dummy(mem, &eval_op);
+		if (ret)
+			return ret;
+
 		ret = spi_mem_access_start(mem);
 		if (ret)
 			return ret;
 
-		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
+		ret = ctlr->mem_ops->poll_status(mem, &eval_op, mask, match,
 						 initial_delay_us, polling_delay_us,
 						 timeout_ms);
 
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 0cce6b57242a..fc9f75c0609f 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -11,6 +11,7 @@
 #ifndef __LINUX_SPI_MEM_H
 #define __LINUX_SPI_MEM_H
 
+#include <linux/math.h>
 #include <linux/spi/spi.h>
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
@@ -75,6 +76,12 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DUMMY_CYCLES(__ncycles, __buswidth)		\
+	{							\
+		.ncycles = __ncycles,				\
+		.buswidth = __buswidth,				\
+	}
+
 #define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\
@@ -82,6 +89,13 @@
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY_CYCLES(__ncycles, __buswidth)	\
+	{							\
+		.ncycles = __ncycles,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
@@ -154,10 +168,18 @@ enum spi_mem_data_dir {
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
  * @dummy: data for dummy operation
- * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
- *		  be zero if the operation does not require dummy bytes
- * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
- * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
+ * @dummy.ncycles: number of dummy clock cycles to insert after an opcode or
+ *		   address. Can be zero if the operation does not require
+ *		   dummy cycles. Mutually exclusive with @dummy.nbytes.
+ * @dummy.nbytes: legacy number of dummy bytes to send after an opcode or
+ *		  address. Can be zero if the operation does not require dummy
+ *		  bytes. Mutually exclusive with @dummy.ncycles.
+ * @dummy.buswidth: number of IO lanes used during the dummy phase. It is
+ *		    also used to convert @dummy.ncycles to bytes for controllers
+ *		    that can only insert a whole number of dummy bytes.
+ * @dummy.dtr: whether the dummy phase is clocked in DTR mode. This only
+ *	       describes the pin state and does not change the number of
+ *	       clock cycles.
  * @data: the data attributes
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
@@ -191,6 +213,7 @@ struct spi_mem_op {
 	} addr;
 
 	struct {
+		u8 ncycles;
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
@@ -392,6 +415,11 @@ struct spi_controller_mem_ops {
  *                   is a pause in the transfer (eg. internal bus contention or
  *                   DMA arbitration on an interconnect). Features such as NAND
  *                   continuous reads shall not be leveraged.
+ * @dummy_cycles: Supports programming the exact number of dummy clock cycles.
+ *                When set, the core converts the legacy @dummy.nbytes to clock
+ *                cycles. When unset, the core converts @dummy.ncycles to whole
+ *                dummy bytes for the controller and rejects operations that
+ *                cannot be converted exactly.
  */
 struct spi_controller_mem_caps {
 	bool dtr;
@@ -400,6 +428,7 @@ struct spi_controller_mem_caps {
 	bool per_op_freq;
 	bool secondary_op_tmpl;
 	bool no_cs_assertion;
+	bool dummy_cycles;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\
@@ -473,7 +502,7 @@ bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
 int spi_mem_exec_op(struct spi_mem *mem,
-		    const struct spi_mem_op *op);
+		    const struct spi_mem_op *ro_op);
 
 const char *spi_mem_get_name(struct spi_mem *mem);
 
diff --git a/include/trace/events/spi-mem.h b/include/trace/events/spi-mem.h
index d13f0bcff5e7..9df571d7799d 100644
--- a/include/trace/events/spi-mem.h
+++ b/include/trace/events/spi-mem.h
@@ -22,7 +22,8 @@ TRACE_EVENT(spi_mem_start_op,
 
 	TP_STRUCT__entry(
 		__string(name, mem->name)
-		__dynamic_array(u8, op, 1 + op->addr.nbytes + op->dummy.nbytes)
+		__dynamic_array(u8, op, 1 + op->addr.nbytes +
+				    spi_mem_get_dummy_nbytes(op))
 		__dynamic_array(u8, data, op->data.dir == SPI_MEM_DATA_OUT ?
 					  min(op->data.nbytes, 64) : 0)
 		__field(u32, data_len)
@@ -53,7 +54,7 @@ TRACE_EVENT(spi_mem_start_op,
 				op->addr.val >> (8 * (op->addr.nbytes - i - 1));
 
 		memset(((u8 *)__get_dynamic_array(op)) + op->addr.nbytes + 1,
-		       0xff, op->dummy.nbytes);
+		       0xff, spi_mem_get_dummy_nbytes(op));
 
 		__entry->data_len = op->data.nbytes;
 		__entry->data_buswidth = op->data.buswidth;

-- 
2.56.0

