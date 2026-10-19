Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436503;
	b=0ztH2tGDZoYMqMx9UKjgezLzMjfVj3acFunUVGEbH/OYVdNlloht0+FqfAUeKR6fGqN9
	 /7rmcwBZOxUZ84lJ4Jlp9oEIPccQdIv3m/W4OgFX+mw0jcjA7D/V6M/EvsHlxOdv/GnAn
	 F0JR0Nh3st4vvaV7bZ3H3/lCDn1QkPiApCsgmygxYQ7Y+qqKsGNJvLPPdqPiDKrvbk9i/
	 tX/90v6A4CpMdTylhiI0sHknGyRoxcpg7SwQGUviB0qsm27oiBNnPqyJ85b99lo9fGwMB
	 Uzqi8uZeKKa6xn16GtvQDf825/JITB8z8AV7UALOnp/zrSwIiEhipqgr3cR9FSslgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2eRPlR+94fvNn1alXmS2n5Fk1SOjjMjgPURYDu+7Ovc=;
	b=SsuuXRaMe0cK5g48cRLmPnrDEMRwKKSoHxHrQCL9IWltd9B9rySJtj1Z5nYGnoMFxOCr
	 3LuUF+4DLF9fDTQz7i64g6+fy3t/ohXK/eqelUu3gQPutScnWYv/yFKG6qPLNSyQHm+mW
	 JYd5WBfWv3Ioke7YrRY2pVKvKPkwCAmCxM8dT0YwKpTmCPUi6nds0Khpo2zfKZZTRQOTE
	 iTDJA0zI4i1woVxKZpfch3oPCcs0sQ91OLg3X6wHmhLrHtY3uBF9l4RZkvl6yI2VfaGmp
	 ISdoFmYny2bT0prQL/64OJ3j407reEpNq7X1+I/m1BVkb8KOLDf5MARz13dQtDmb2Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kgfy37ar;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F843606A31B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F843606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kgfy37ar
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9995ce866so18324125ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436503; x=1793041303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eRPlR+94fvNn1alXmS2n5Fk1SOjjMjgPURYDu+7Ovc=;
        b=kgfy37arOgukMush81hl8Cvp2zXkH5KiGTxemT+8tr9EVicIaww9Q/8DpPeOzNHVhZ
         lZSL/oyrfqm2p/xSZMYXNcS91rM6S1ssKl0mzRopkxjyPaq2xgCjcuJsKkpE4yJuMrsn
         bmJUZL9odEefHHhQGJFubDZhjnd5frTuhlSl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436503; x=1793041303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2eRPlR+94fvNn1alXmS2n5Fk1SOjjMjgPURYDu+7Ovc=;
        b=xQ2y0en/we2g48+T/Nd3ePjLVQkI1Y046xKJqnMoSgwfijOIdkt8gyJZ9i3cw9kEIL
         D/1Jx+riMAbVHFKDr2nr4NBEsW5LkPmhAjk2lrc+hq5gOa5aesmMeRkHo/VOiWASVurZ
         72YvJRgZTu9OZk5nuf47qcZVm2X/pP2tm0XfJcsLmFu+TjHLWuj0HH8CjBzvkrSQNE7/
         F0pnonqVNriWMpiZS/JhlGbwkHMjDr+MBz/yc4NC+iPrTYBfZey/OPD2V462rkUwWu7p
         po26Hkwkm4AUavdPLZugE9V3dHIg9/Fzh63bEjeeBiJklXKwyfQ6GboXxfbkUI/oNmrT
         PVRw==
X-Forwarded-Encrypted: i=1; AKwUvBwkY6JdD/Dzx0440D7uhPmSB6qf6lLuWaFOMyFoRTrQH3Wjm/BHdEv3KTDdup2F8/5W/NKGe2mAB6NeA54wbDclfH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdF5+uFYSClorCPeo1RejmdphBqV7Q52FY59k8UpLEI8ZCYs9c
	bRAFtpOGwOX6MsM5R6jdldHGcV/lDKN6fpx83DwVp9hUqsn0O317AsleZEntGuqOIg==
X-Gm-Gg: AYBFou17HkyuZQfqX2Esc3PxJHOmiSkMoIt7paAEa0J4tmf4gsVH45OwnV9PuD9U+Hi
	OE9T+0xGdq4eHL+yTG7W7JbkZtAnTOUkqmE4e9ulF7vAFL32JDdnbH/LbgFQf87G4KBoy53pz/C
	JHCzTtbJx3lpaa958s6jHbvux9ESdvblyu9eqcDRiH5hyM6cU0jLRi083JzLKab9fX/2Xq6021x
	MzJg4zbsZknNMGxo+hTWMqEZOJOqOVWm+pzebGz9IkSZQ0mWqW56gvAcZ4BqUiwq1KPyjc6wbxY
	Uxyzw1gkWfE/3kATKZFxz05CDZhP8niEQj2NduB4nueR1KbjvRH9qJAtmZBocvJCE6GQMw092Vg
	2n8ZMKKwB8g8yQCeANTKnq+7ieEIi4yvxUyNTY82CPvLgVK+M3ft4GQ8C84V07giIWczxRHKqBo
	ePyWSSs/mKwE0Lvs86ZHFYv4Lsb8xouADrv6SLfiJMsNBmpAMVSP/tYuZtdah7YMGg4JMYLfFGN
	aLdzkkWf7yOT+6wW/D0nAVfTKOdcEaV5csT45teB3BSkgXfx8d7dIGaBMg/dawyBG90H1TQ3J7D
	dX971g==
X-Received: by 2002:a17:902:ceca:b0:2e9:6788:9369 with SMTP id d9443c01a7336-2e9a6c022cfmr75916075ad.34.1792436502524;
        Mon, 19 Oct 2026 12:01:42 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:22 +0000
Subject: [PATCH v6 10/11] HID: spi-hid: add power management implementation
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
Message-Id: <20261019-send-upstream-v6-10-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=10211;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=m94MWGytMIFKEIezc7FTaFXVcCvwAj2XLUeozobMJ/s=;
 b=A+6JFay6un/HkAbi5tw4lTm65PxTGJTWv7/Cwr6mBHKvSwv1hdxuoMO1xwxyeIerZvbcibnDW
 mdovjb5iyEnAVydTvQdfbyidX7hF67oMdMQVoqLP1aaIMTH/aeOtNkj
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Implement HID over SPI driver power management callbacks.

Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-acpi.c |   1 +
 drivers/hid/spi-hid/spi-hid-core.c | 185 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h |   2 +
 drivers/hid/spi-hid/spi-hid-of.c   |   1 +
 drivers/hid/spi-hid/spi-hid.h      |   1 +
 5 files changed, 190 insertions(+)

diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
index 31ca3fa336cd..a52cafe86c05 100644
--- a/drivers/hid/spi-hid/spi-hid-acpi.c
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -246,6 +246,7 @@ static struct spi_driver spi_hid_acpi_driver = {
 	.driver = {
 		.name	= "spi_hid_acpi",
 		.owner	= THIS_MODULE,
+		.pm	= &spi_hid_core_pm,
 		.acpi_match_table = spi_hid_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.dev_groups = spi_hid_groups,
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 96805c10bfe3..c2232d5959b8 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -36,6 +36,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/string.h>
@@ -60,6 +62,7 @@
 
 #define SPI_HID_MAX_RESET_ATTEMPTS	3
 #define SPI_HID_RESP_TIMEOUT		1000
+#define SPI_HID_RESET_TIMEOUT		1000
 
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
@@ -91,6 +94,11 @@
  * ll_close. Input reports are only forwarded while this flag is set.
  */
 #define SPI_HID_STARTED	6
+/*
+ * dead indicates that the device was powered off after too many failed
+ * resets. It stays off until the driver is rebound, even across resume.
+ */
+#define SPI_HID_DEAD	7
 
 /* Processed data from input report header */
 struct spi_hid_input_header {
@@ -242,6 +250,148 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
+/*
+ * Wait for the device descriptor response after reset; the device then takes
+ * requests. Set READY here: the report descriptor check that normally sets it
+ * needs power_lock, which callers hold.
+ */
+static void spi_hid_wait_for_reset(struct spi_hid *shid)
+{
+	unsigned long timeout = msecs_to_jiffies(SPI_HID_RESET_TIMEOUT +
+						 SPI_HID_RESP_TIMEOUT);
+
+	if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
+		dev_warn(&shid->spi->dev,
+			 "Device descriptor not received after reset\n");
+		return;
+	}
+
+	set_bit(SPI_HID_READY, &shid->flags);
+}
+
+static int spi_hid_suspend(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+
+	/* HID driver suspend may talk to the device; responses need the IRQ. */
+	scoped_guard(mutex, &shid->power_lock) {
+		if (shid->power_state != HIDSPI_OFF && shid->hid) {
+			error = hid_driver_suspend(shid->hid, PMSG_SUSPEND);
+			if (error) {
+				dev_err(dev, "%s failed to suspend hid driver: %d\n",
+					__func__, error);
+				return error;
+			}
+		}
+	}
+
+	/*
+	 * disable_irq() waits for a running IRQ thread, so no new reset_work
+	 * can be queued after it returns. Then wait for any queued or running
+	 * instance. Must not hold power_lock here: reset_work takes it.
+	 */
+	disable_irq(shid->spi->irq);
+	cancel_work_sync(&shid->reset_work);
+
+	guard(mutex)(&shid->power_lock);
+	if (!device_may_wakeup(dev)) {
+		if (shid->power_state != HIDSPI_OFF) {
+			/* Device is fully reset on resume; drop stale state. */
+			clear_bit(SPI_HID_READY, &shid->flags);
+			clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
+			clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
+			clear_bit(SPI_HID_ERROR, &shid->flags);
+			set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+
+			shid->ops->assert_reset(shid->ops);
+
+			error = shid->ops->power_down(shid->ops);
+			if (error) {
+				dev_err(dev, "%s: could not power down\n", __func__);
+				shid->regulator_error_count++;
+				shid->regulator_last_error = error;
+				/*
+				 * Undo partial suspend before returning error.
+				 * Complete the reset; RESET_PENDING stays set
+				 * until the device sends its reset response.
+				 */
+				shid->ops->sleep_minimal_reset_delay(shid->ops);
+				reinit_completion(&shid->reset_done);
+				shid->ops->deassert_reset(shid->ops);
+				enable_irq(shid->spi->irq);
+				if (shid->hid) {
+					spi_hid_wait_for_reset(shid);
+					hid_driver_reset_resume(shid->hid);
+				}
+				return error;
+			}
+
+			shid->power_state = HIDSPI_OFF;
+		}
+	}
+	return 0;
+}
+
+static int spi_hid_resume(struct spi_hid *shid)
+{
+	int error;
+	struct device *dev = &shid->spi->dev;
+	bool was_reset = false;
+
+	guard(mutex)(&shid->power_lock);
+	if (test_bit(SPI_HID_DEAD, &shid->flags)) {
+		/* Stay off; only balance disable_irq() in suspend. */
+		enable_irq(shid->spi->irq);
+		return 0;
+	}
+
+	if (!device_may_wakeup(dev)) {
+		if (shid->power_state == HIDSPI_OFF) {
+			shid->ops->assert_reset(shid->ops);
+
+			shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+			error = shid->ops->power_up(shid->ops);
+			if (error) {
+				dev_err(dev, "%s: could not power up\n", __func__);
+				shid->regulator_error_count++;
+				shid->regulator_last_error = error;
+				/* Suspend runs next even if resume fails. */
+				enable_irq(shid->spi->irq);
+				return error;
+			}
+			shid->power_state = HIDSPI_ON;
+			reinit_completion(&shid->reset_done);
+			shid->ops->deassert_reset(shid->ops);
+			was_reset = true;
+		}
+	}
+
+	enable_irq(shid->spi->irq);
+
+	/*
+	 * For devices that may wake up, process work that was pending when
+	 * suspend cancelled reset_work. Otherwise suspend already dropped it.
+	 */
+	if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
+	    test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
+	    test_bit(SPI_HID_ERROR, &shid->flags))
+		schedule_work(&shid->reset_work);
+
+	if (shid->hid) {
+		if (was_reset)
+			spi_hid_wait_for_reset(shid);
+		error = hid_driver_reset_resume(shid->hid);
+		if (error) {
+			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
+				__func__, error);
+			return error;
+		}
+	}
+	return 0;
+}
+
 static void spi_hid_stop_hid(struct spi_hid *shid)
 {
 	struct hid_device *hid;
@@ -280,6 +430,7 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 			shid->regulator_last_error = error;
 		}
 		shid->power_state = HIDSPI_OFF;
+		set_bit(SPI_HID_DEAD, &shid->flags);
 		/* Dead device: leave the IRQ permanently disabled. */
 		return;
 	}
@@ -561,6 +712,8 @@ static int spi_hid_dev_desc_response(struct spi_hid *shid,
 	shid->reset_attempts = 0;
 	set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
 	schedule_work(&shid->reset_work);
+	/* The device can take requests now; see spi_hid_wait_for_reset(). */
+	complete(&shid->reset_done);
 
 	return 0;
 }
@@ -1381,6 +1534,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	mutex_init(&shid->power_lock);
 	mutex_init(&shid->io_lock);
 	init_completion(&shid->output_done);
+	init_completion(&shid->reset_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
 
@@ -1414,6 +1568,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return error;
 	}
 
+	/*
+	 * Use device_can_wakeup(), not device_may_wakeup(): power/wakeup can
+	 * change after probe, and the PM core checks it at suspend time.
+	 */
+	if (device_can_wakeup(dev)) {
+		error = devm_pm_set_wake_irq(dev, spi->irq);
+		if (error) {
+			dev_err(dev, "%s: failed to set wake IRQ\n", __func__);
+			return error;
+		}
+	}
+
 	error = shid->ops->power_up(shid->ops);
 	if (error) {
 		dev_err(dev, "%s: could not power up\n", __func__);
@@ -1454,6 +1620,25 @@ void spi_hid_core_remove(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
 
+static int spi_hid_core_pm_suspend(struct device *dev)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return spi_hid_suspend(shid);
+}
+
+static int spi_hid_core_pm_resume(struct device *dev)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return spi_hid_resume(shid);
+}
+
+const struct dev_pm_ops spi_hid_core_pm = {
+	SYSTEM_SLEEP_PM_OPS(spi_hid_core_pm_suspend, spi_hid_core_pm_resume)
+};
+EXPORT_SYMBOL_GPL(spi_hid_core_pm);
+
 MODULE_DESCRIPTION("HID over SPI transport driver");
 MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 1d8356f787f3..0b3248aedfce 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -92,6 +92,8 @@ struct spi_hid {
 	struct mutex io_lock;
 
 	struct completion output_done;
+	/* Completed once the device descriptor is received after a reset. */
+	struct completion reset_done;
 
 	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */
 
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
index 24215ffaaafd..71b230c1000a 100644
--- a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -225,6 +225,7 @@ static struct spi_driver spi_hid_of_driver = {
 	.driver = {
 		.name = "spi_hid_of",
 		.owner = THIS_MODULE,
+		.pm = &spi_hid_core_pm,
 		.of_match_table = spi_hid_of_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.dev_groups = spi_hid_groups,
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index f5a5f4d54beb..17b2fdf192ed 100644
--- a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -41,5 +41,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 void spi_hid_core_remove(struct spi_device *spi);
 
 extern const struct attribute_group *spi_hid_groups[];
+extern const struct dev_pm_ops spi_hid_core_pm;
 
 #endif /* SPI_HID_H */

-- 
2.56.0.212.g129ede20d9-goog

