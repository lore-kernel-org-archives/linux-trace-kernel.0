Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803126;
	b=WNDIFLdHs6qvUZ01snVmX4NT9pnJ1nm0SZuHNinTG5IQhuZKkXiqOMCYMS6z3WfYX9et
	 T/ENX58hdK5DNzAymwK971bShSWs4SgbUYv3eTB1ekbslAZlGcR4uU1eSB04ywQX0nOud
	 IATyDV53hS7+6iK3ESOWC+UlALF03cPVWiczRpShmdAs2729wfE0KCe4vYDW+aSckma/o
	 m+8GfM/yKEE4JtxsJbU0EUnNJuEwXD79yrOvUNSRvtT4KHohs2ZTvlTAX5haRq1KPSdfz
	 /IFTeFrxbY2gs+wQWOnQeotcLxd3G5079xyYBTaVaLKQuQMjuumxSzF6GKrj4wQrsqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=y5CfHPIojGcBTJq2jKBECBXBNNkZ+Dle/iLq/yDt0QQ=;
	b=SVvNJXgjLgcD7fj6nb2YU5h60gxetn1gHjsRsHel4nfEh9hqYZpg6nREw9omOuiuFDyE
	 v8xOUyTBs1wf6AZTSwx/KgnUq9DlvrmNdGIKYUs2XspsOW+gvAxmTh9G1wBhMceP6iVcq
	 u5mT5owBLDDUYgJ20abnhXH+e3LyJeCD3GGD1whf4hSZRmdNJx15CW1iIUeditGZskcPs
	 Tq5BsI/tOXeNbwh3rwKxZKDWVPzNAp9+h/QNYdLq0mv0BCeNLn9FHvKJTjLDqSCeYwgAT
	 AgBcQMscF2hM09azL4dfbsTtwMoe5+suR20xh6W8oUNUJnab3gA0R9L2In3lgxb9mGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A6IHT3nk;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E760A2614
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A7E760A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A6IHT3nk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so755672a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803115; x=1793407915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5CfHPIojGcBTJq2jKBECBXBNNkZ+Dle/iLq/yDt0QQ=;
        b=A6IHT3nkS6NpBYLxg4xNJX7C4p2Ya1N1u+lNx1MEiEX154RYdduhdl/aNY5fi9V2GV
         SU3J2mQ5nEbSA62/NW9ZQvcDo2zEdcQnrtyqtgn95GBiUGhSBH/57Dn4nSyqVs1ICYB1
         EFRttOdCSW4G6Hb8KoUifcQQ9i1jEJ+G95Mtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803115; x=1793407915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5CfHPIojGcBTJq2jKBECBXBNNkZ+Dle/iLq/yDt0QQ=;
        b=QZXFgzw4j/kyil0E3tKD62k/nAHonbf2aSR4wzYRt/vINsZbFFC/w6EESKWPrD+4RO
         zNG03UQcZCxDrzswCXoYzsRSexYR1Alg7c/dqyXJpLOQofNs2ekqYX27HOBjxne6Ao/H
         d6vYzu0CO0mf2vV/pecvjnfG0XX6WTuDtjOurF/uFqxP7Vz5UTuamfWwquP/dnjeGMZF
         Dz6r9LOIuz/ji4+bhtq8tfhATU6HxbvcNkd63nePsPpQT0XdhnLsX9wu2nVjmfy4v6zO
         t9BvFB0//Wtx2gbU1CmyvfCsLI+O9QkYWXL9AzQ6/tAgNVxRp8vscwSIthGoaeT2nzJi
         wveg==
X-Forwarded-Encrypted: i=1; AKwUvBzMRnxrXMKXDei3SEOTJoZRybfh6SDM5HpS9EUhylqZ2eqkCoksKCweWhOG7PVdY6iUa6OxoMxyt7xJ2Yy7NjLaMQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJR5qw2YdzWltK5TQHesLcqVWMFDlzYukZIxjwp8NHVpMWQogc
	TnUjg4zfOseg9bV4STXs5AFwKpmAmAGtDMnw+YAK0sNDu693ehppTXZCxPQf9TiH1w==
X-Gm-Gg: AYBFou1B3O27wLnqTsMoEs49kQp4jsfMlcaV9JXWhBWObiyDi0Nb1MBopBeMJLL2dCH
	n+NuxCmM4VGuuvbwITiLjVY+02CNpYGvWxVDL4T8efKUGuovcuUTUHPsGQ51ifYBCMcry/lqVj0
	bg87wR+ykY76QQ769MiiLnPCtcp4mx0kDSMvbmPR9s4njUFHRT4dWt7emHOK2V8p0i20j0UR1IA
	mLi+n7+ciRd6vadLTx4TFsG/8g79XfrCbcbEaRvg07IJP7lH4R5UA2Kihyqbzv8XLrtm40E4U/p
	m56H5C6f+WvlEdQg01qxmRigjjJjUxwlQzneuI7cumxClEVcVfIXOHNtc5Pu3e5exSD7XYNrUAV
	EW3bpN9lnD5DklK2UjAJ9D7NKy3JJQD4jndO9MIM36VKPZLzqyBupUleo4pZW9KF9Xhp3wf2JYz
	e90SDaUyTtaupn8buzr2/AXZD2U5JQ4f3RIz4FafWOWPNlOu/useo2pEkQDrAzbYCvsBdaNuC9v
	SApaMrJdMyBa4BaiX053f35dbXTtyxLtNIJEZnOzcsc0yVvv5nyafgHEbX9fe48YlA+ZMyaFHEy
	1LlVRXv/1wRz4rycJY5bW1y4kIRWROOJmFBHI1zI2wThKAMzpWVqDqxriBtuAV55Njq6YOPjVnP
	+i0OQXC62
X-Received: by 2002:a17:90b:1805:b0:3ac:b2e6:3181 with SMTP id 98e67ed59e1d1-3adead2ea94mr715949a91.37.1792803114803;
        Fri, 23 Oct 2026 17:51:54 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:54 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:38 +0000
Subject: [PATCH v7 04/11] HID: spi-hid: add spi-hid driver HID layer
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
Message-Id: <20261024-send-upstream-v7-4-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=18187;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=B2zdDjczHromPR35pCKgygD7qcjgLMRwJsQfjiCHO/Y=;
 b=sk2ZWPbq1jyxBp3f9mH9bOH+U3OsyihZ5SHIhs/PgleJOJmuS0DxpsUpeDhZLh1wF1cHf4jzT
 47oo5iYEOsKD8iKn/2WCglSbX4uKviGwdstZlaomXwi/0wxRqHakfWO
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add HID low level driver callbacks to register SPI as a HID driver, and
an external touch device as a HID device.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 588 +++++++++++++++++++++++++++++++++++++
 1 file changed, 588 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 4991dc972cae..54c278ac8803 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -20,13 +20,69 @@
  *  Copyright (c) 2006-2010 Jiri Kosina
  */
 
+#include <linux/completion.h>
+#include <linux/crc32.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/hid-over-spi.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/unaligned.h>
+
+#define SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST	0x00
+
+#define SPI_HID_RESP_TIMEOUT	1000
+
+/* Protocol message size constants */
+#define SPI_HID_OUTPUT_HEADER_LEN		8
+
+/* flags */
+/*
+ * ready flag indicates that the FW is ready to accept commands and
+ * requests. The FW becomes ready after sending the report descriptor.
+ */
+#define SPI_HID_READY	0
+
+/* Raw input buffer with data from the bus */
+struct spi_hid_input_buf {
+	u8 header[HIDSPI_INPUT_HEADER_SIZE];
+	u8 body[HIDSPI_INPUT_BODY_HEADER_SIZE];
+	u8 content[];
+};
+
+/* Raw output report buffer to be put on the bus */
+struct spi_hid_output_buf {
+	u8 header[SPI_HID_OUTPUT_HEADER_LEN];
+	u8 content[];
+};
+
+/* Data necessary to send an output report */
+struct spi_hid_output_report {
+	u8 report_type;
+	u16 content_length;
+	u8 content_id;
+	u8 *content;
+};
+
+/* Processed data from a device descriptor */
+struct spi_hid_device_descriptor {
+	u16 hid_version;
+	u16 report_descriptor_length;
+	u16 max_input_length;
+	u16 max_output_length;
+	u16 max_fragment_length;
+	u16 vendor_id;
+	u16 product_id;
+	u16 version_id;
+	u8 no_output_report_ack;
+};
 
 /* struct spi_hid_conf - Conf provided to the core */
 struct spi_hid_conf {
@@ -61,9 +117,45 @@ struct spi_hid {
 	struct spihid_ops	*ops;
 	struct spi_hid_conf	*conf;
 
+	struct spi_hid_device_descriptor desc;	/* HID device descriptor. */
+	struct spi_hid_output_buf *output;	/* Output buffer. */
+	struct spi_hid_input_buf *input;	/* Input buffer. */
+	struct spi_hid_input_buf *response;	/* Response buffer. */
+
+	u16 response_length;
+	u16 bufsize;
+
 	enum hidspi_power_state power_state;
+
+	u8 reset_attempts;	/* The number of reset attempts. */
+
+	unsigned long flags;	/* device flags. */
+
+	/* Control lock to make sure one output transaction at a time. */
+	struct mutex output_lock;
+	struct completion output_done;
+
+	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
 };
 
+static struct hid_ll_driver spi_hid_ll_driver;
+
+static void spi_hid_populate_output_header(u8 *buf,
+					   const struct spi_hid_conf *conf,
+					   const struct spi_hid_output_report *report)
+{
+	buf[0] = conf->write_opcode;
+	put_unaligned_be24(conf->output_report_address, &buf[1]);
+	buf[4] = report->report_type;
+	put_unaligned_le16(report->content_length, &buf[5]);
+	buf[7] = report->content_id;
+}
+
+static int spi_hid_output(struct spi_hid *shid, const void *buf, u16 length)
+{
+	return spi_write(shid->spi, buf, length);
+}
+
 static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state)
 {
 	switch (power_state) {
@@ -78,11 +170,489 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
+static void spi_hid_stop_hid(struct spi_hid *shid)
+{
+	struct hid_device *hid = shid->hid;
+
+	shid->hid = NULL;
+	clear_bit(SPI_HID_READY, &shid->flags);
+
+	if (hid)
+		hid_destroy_device(hid);
+}
+
+static int __spi_hid_send_output_report(struct spi_hid *shid,
+					struct spi_hid_output_report *report)
+{
+	struct spi_hid_output_buf *buf = shid->output;
+	struct device *dev = &shid->spi->dev;
+	u16 report_length;
+	u16 padded_length;
+	u8 padding;
+	int error;
+
+	if (report->content_length > shid->desc.max_output_length ||
+	    report->content_length > shid->bufsize) {
+		dev_err(dev, "Output report too big, content_length 0x%x\n",
+			report->content_length);
+		return -E2BIG;
+	}
+
+	spi_hid_populate_output_header(buf->header, shid->conf, report);
+
+	if (report->content_length)
+		memcpy(&buf->content, report->content, report->content_length);
+
+	report_length = sizeof(buf->header) + report->content_length;
+	padded_length = round_up(report_length, 4);
+	padding = padded_length - report_length;
+	memset(&buf->content[report->content_length], 0, padding);
+
+	error = spi_hid_output(shid, buf, padded_length);
+	if (error)
+		dev_err(dev, "Failed output transfer: %d\n", error);
+
+	return error;
+}
+
+static int spi_hid_send_output_report(struct spi_hid *shid,
+				      struct spi_hid_output_report *report)
+{
+	guard(mutex)(&shid->output_lock);
+	return __spi_hid_send_output_report(shid, report);
+}
+
+static int __spi_hid_sync_request(struct spi_hid *shid,
+				  struct spi_hid_output_report *report)
+{
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	reinit_completion(&shid->output_done);
+
+	error = __spi_hid_send_output_report(shid, report);
+	if (error)
+		return error;
+
+	error = wait_for_completion_interruptible_timeout(&shid->output_done,
+							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
+	if (error == 0) {
+		dev_err(dev, "Response timed out\n");
+		return -ETIMEDOUT;
+	}
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int spi_hid_sync_request(struct spi_hid *shid,
+				struct spi_hid_output_report *report)
+{
+	guard(mutex)(&shid->output_lock);
+	return __spi_hid_sync_request(shid, report);
+}
+
+/*
+ * This function returns the length of the report descriptor, or a negative
+ * error code if something went wrong.
+ */
+static int spi_hid_report_descriptor_request(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = REPORT_DESCRIPTOR,
+		.content_length = 0,
+		.content_id = SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
+		.content = NULL,
+	};
+	int ret;
+
+	ret =  spi_hid_sync_request(shid, &report);
+	if (ret) {
+		dev_err(dev,
+			"Expected report descriptor not received: %d\n", ret);
+		return ret;
+	}
+
+	ret = shid->response_length;
+	if (ret != shid->desc.report_descriptor_length) {
+		ret = min_t(unsigned int, ret, shid->desc.report_descriptor_length);
+		dev_err(dev, "Received report descriptor length doesn't match device descriptor field, using min of the two: %d\n",
+			ret);
+	}
+
+	if (!ret) {
+		dev_err(dev, "Empty report descriptor\n");
+		return -EPROTO;
+	}
+
+	return ret;
+}
+
+static int spi_hid_create_device(struct spi_hid *shid)
+{
+	struct hid_device *hid;
+	struct device *dev = &shid->spi->dev;
+	int error;
+
+	hid = hid_allocate_device();
+	error = PTR_ERR_OR_ZERO(hid);
+	if (error) {
+		dev_err(dev, "Failed to allocate hid device: %d\n", error);
+		return error;
+	}
+
+	hid->driver_data = shid->spi;
+	hid->ll_driver = &spi_hid_ll_driver;
+	hid->dev.parent = &shid->spi->dev;
+	hid->bus = BUS_SPI;
+	hid->version = shid->desc.hid_version;
+	hid->vendor = shid->desc.vendor_id;
+	hid->product = shid->desc.product_id;
+
+	snprintf(hid->name, sizeof(hid->name), "spi %04X:%04X",
+		 hid->vendor, hid->product);
+	strscpy(hid->phys, dev_name(&shid->spi->dev), sizeof(hid->phys));
+
+	shid->hid = hid;
+
+	error = hid_add_device(hid);
+	if (error) {
+		dev_err(dev, "Failed to add hid device: %d\n", error);
+		/*
+		 * We likely got here because report descriptor request timed
+		 * out. Let's disconnect and destroy the hid_device structure.
+		 */
+		spi_hid_stop_hid(shid);
+		return error;
+	}
+
+	return 0;
+}
+
+static int spi_hid_get_request(struct spi_hid *shid, u8 content_id,
+			       u8 *buf, size_t len)
+{
+	struct device *dev = &shid->spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = GET_FEATURE,
+		.content_length = 0,
+		.content_id = content_id,
+		.content = NULL,
+	};
+	u16 content_len;
+	int error, ret;
+
+	/* buf[0] holds the report ID, so there must be room for at least that. */
+	if (!len)
+		return -EINVAL;
+
+	guard(mutex)(&shid->output_lock);
+
+	error = __spi_hid_sync_request(shid, &report);
+	if (error) {
+		dev_err(dev,
+			"Expected get request response not received! Error %d\n",
+			error);
+		return error;
+	}
+
+	/* Content Length counts only the payload, not the Content ID. */
+	content_len = get_unaligned_le16(&shid->response->body[1]);
+	if (content_len > shid->bufsize) {
+		dev_err(dev, "Get report response too big: %u > %u\n",
+			content_len, shid->bufsize);
+		return -EPROTO;
+	}
+
+	/* buf[0] holds the report ID, the payload follows. */
+	ret = min_t(size_t, len - 1, content_len);
+	buf[0] = shid->response->body[3];
+	memcpy(&buf[1], shid->response->content, ret);
+
+	return ret + 1;
+}
+
+static int spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 arg_len,
+			       u8 content_id)
+{
+	struct spi_hid_output_report report = {
+		.report_type = SET_FEATURE,
+		.content_length = arg_len,
+		.content_id = content_id,
+		.content = arg_buf,
+	};
+
+	return spi_hid_sync_request(shid, &report);
+}
+
+/* This is a placeholder. Will be implemented in the next patch. */
 static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 {
 	return IRQ_HANDLED;
 }
 
+static int spi_hid_alloc_buffers(struct spi_hid *shid, size_t report_size)
+{
+	struct device *dev = &shid->spi->dev;
+	int inbufsize = round_up(sizeof(shid->input->header) +
+				 sizeof(shid->input->body) + report_size, 4);
+	int outbufsize = round_up(sizeof(shid->output->header) + report_size, 4);
+	void *tmp;
+
+	tmp = devm_krealloc(dev, shid->output, outbufsize, GFP_KERNEL | __GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->output = tmp;
+
+	tmp = devm_krealloc(dev, shid->input, inbufsize, GFP_KERNEL | __GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->input = tmp;
+
+	tmp = devm_krealloc(dev, shid->response, inbufsize, GFP_KERNEL | __GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->response = tmp;
+
+	if (!shid->output || !shid->input || !shid->response)
+		return -ENOMEM;
+
+	shid->bufsize = report_size;
+
+	return 0;
+}
+
+static int spi_hid_get_report_length(struct hid_report *report)
+{
+	return DIV_ROUND_UP(report->size, 8) +
+		report->device->report_enum[report->type].numbered + 2;
+}
+
+/*
+ * Traverse the supplied list of reports and find the longest
+ */
+static void spi_hid_find_max_report(struct hid_device *hid, u32 type,
+				    u16 *max)
+{
+	struct hid_report *report;
+	u16 size;
+
+	/*
+	 * We should not rely on wMaxInputLength, as some devices may set it to
+	 * a wrong length.
+	 */
+	list_for_each_entry(report, &hid->report_enum[type].report_list, list) {
+		size = spi_hid_get_report_length(report);
+		if (*max < size)
+			*max = size;
+	}
+}
+
+/* hid_ll_driver interface functions */
+
+static int spi_hid_ll_start(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	int error = 0;
+	/*
+	 * HID_MIN_BUFFER_SIZE is the minimum transport buffer size, not a
+	 * requirement on the device's report sizes. Use it as a floor so
+	 * devices with small reports are still supported.
+	 */
+	u16 bufsize = HID_MIN_BUFFER_SIZE;
+
+	spi_hid_find_max_report(hid, HID_INPUT_REPORT, &bufsize);
+	spi_hid_find_max_report(hid, HID_OUTPUT_REPORT, &bufsize);
+	spi_hid_find_max_report(hid, HID_FEATURE_REPORT, &bufsize);
+
+	if (bufsize > shid->bufsize) {
+		guard(disable_irq)(&shid->spi->irq);
+
+		error = spi_hid_alloc_buffers(shid, bufsize);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+static void spi_hid_ll_stop(struct hid_device *hid)
+{
+	hid->claimed = 0;
+}
+
+static int spi_hid_ll_open(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void spi_hid_ll_close(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+
+	shid->reset_attempts = 0;
+}
+
+static int spi_hid_ll_power(struct hid_device *hid, int level)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	int error = 0;
+
+	guard(mutex)(&shid->output_lock);
+	if (!shid->hid)
+		error = -ENODEV;
+
+	return error;
+}
+
+static int spi_hid_ll_parse(struct hid_device *hid)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	unsigned int rsize = shid->desc.report_descriptor_length;
+	int error, len;
+
+	if (rsize > HID_MAX_DESCRIPTOR_SIZE) {
+		dev_err(dev,
+			"Report descriptor size %d is greater than HID_MAX_DESCRIPTOR_SIZE %d\n",
+			rsize, HID_MAX_DESCRIPTOR_SIZE);
+		return -EINVAL;
+	}
+
+	if (rsize > shid->bufsize) {
+		error = spi_hid_alloc_buffers(shid, rsize);
+		if (error)
+			return error;
+	}
+
+	len = spi_hid_report_descriptor_request(shid);
+	if (len < 0) {
+		dev_err(dev, "Report descriptor request failed, %d\n", len);
+		return len;
+	}
+
+	/*
+	 * FIXME: below call returning 0 doesn't mean that the report descriptor
+	 * is good. We might be caching a crc32 of a corrupted r. d. or who
+	 * knows what the FW sent. Need to have a feedback loop about r. d.
+	 * being ok and only then cache it.
+	 */
+	error = hid_parse_report(hid, (u8 *)shid->response->content, len);
+	if (error) {
+		dev_err(dev, "failed parsing report: %d\n", error);
+		return error;
+	}
+	shid->report_descriptor_crc32 = crc32_le(0,
+						 (unsigned char const *)shid->response->content,
+						 len);
+
+	set_bit(SPI_HID_READY, &shid->flags);
+
+	return 0;
+}
+
+static int spi_hid_ll_output_report(struct hid_device *hid, __u8 *buf,
+				    size_t len)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	struct spi_hid_output_report report = {
+		.report_type = OUTPUT_REPORT,
+		.content_length = len - 1,
+		.content_id = buf[0],
+		.content = &buf[1],
+	};
+	int error;
+
+	if (!test_bit(SPI_HID_READY, &shid->flags)) {
+		dev_err(dev, "%s called in unready state\n", __func__);
+		return -ENODEV;
+	}
+
+	if (shid->desc.no_output_report_ack)
+		error = spi_hid_send_output_report(shid, &report);
+	else
+		error = spi_hid_sync_request(shid, &report);
+
+	if (error) {
+		dev_err(dev, "failed to send output report\n");
+		return error;
+	}
+
+	return len;
+}
+
+static int spi_hid_ll_raw_request(struct hid_device *hid,
+				  unsigned char reportnum, __u8 *buf,
+				  size_t len, unsigned char rtype, int reqtype)
+{
+	struct spi_device *spi = hid->driver_data;
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int ret;
+
+	switch (reqtype) {
+	case HID_REQ_SET_REPORT:
+		if (buf[0] != reportnum) {
+			dev_err(dev, "report id mismatch\n");
+			return -EINVAL;
+		}
+
+		if (rtype == HID_OUTPUT_REPORT)
+			return spi_hid_ll_output_report(hid, buf, len);
+
+		if (rtype != HID_FEATURE_REPORT)
+			return -EINVAL;
+
+		ret = spi_hid_set_request(shid, &buf[1], len - 1,
+					  reportnum);
+		if (ret) {
+			dev_err(dev, "failed to set report\n");
+			return ret;
+		}
+
+		ret = len;
+		break;
+	case HID_REQ_GET_REPORT:
+		/*
+		 * Only feature reports for now: GET_INPUT_REPORT is not
+		 * supported.
+		 */
+		if (rtype != HID_FEATURE_REPORT)
+			return -EOPNOTSUPP;
+
+		ret = spi_hid_get_request(shid, reportnum, buf, len);
+		if (ret < 0) {
+			dev_err(dev, "failed to get report\n");
+			return ret;
+		}
+		break;
+	default:
+		dev_err(dev, "invalid request type\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static struct hid_ll_driver spi_hid_ll_driver = {
+	.start = spi_hid_ll_start,
+	.stop = spi_hid_ll_stop,
+	.open = spi_hid_ll_open,
+	.close = spi_hid_ll_close,
+	.power = spi_hid_ll_power,
+	.parse = spi_hid_ll_parse,
+	.output_report = spi_hid_ll_output_report,
+	.raw_request = spi_hid_ll_raw_request,
+};
+
 int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		       struct spi_hid_conf *conf)
 {
@@ -104,6 +674,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 
 	spi_set_drvdata(spi, shid);
 
+	mutex_init(&shid->output_lock);
+	init_completion(&shid->output_done);
+
+	/*
+	 * we need to allocate the buffer without knowing the maximum
+	 * size of the reports. Let's use HID_MAX_DESCRIPTOR_SIZE, then we do the
+	 * real computation later.
+	 */
+	error = spi_hid_alloc_buffers(shid, HID_MAX_DESCRIPTOR_SIZE);
+	if (error)
+		return error;
+
 	/*
 	 * At the end of probe we initialize the device:
 	 *   0) assert reset, bias the interrupt line
@@ -136,6 +718,10 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
+	error = spi_hid_create_device(shid);
+	if (error)
+		return error;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
@@ -146,6 +732,8 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	spi_hid_stop_hid(shid);
+
 	shid->ops->assert_reset(shid->ops);
 	error = shid->ops->power_down(shid->ops);
 	if (error)

-- 
2.56.0.257.gf7497c7d27-goog

