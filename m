Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81F382F29
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518440; cv=none; b=Fd0ZbNfX9/1lxm35jrEOyX2N8R/HzxJammAW3wX+D3OChiDz7va3HxtOYRQJWVHKlH9wZPk1o5i+i97Tf5HSjhFggFxt6G0nlCy7AtTGkHrzNTMp/9f9YGytKF7wcIAjcnGE4KMxr4PxK9R9o2tf7YFdApCzWe8Jf8A0bpAkYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518440; c=relaxed/simple;
	bh=9VBbxDeCBOwEkQqdAXnbqlSFol8sG1Sk8yHeuXnwVc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+XfOu7+7PiiQJhjcGUWX3L4+PFco8H7gNsvXp6HghBSys6W9IhLb2VFlwOJ1b/VgrNmaS8xygS1fBCHvqTEYXCsvH6bhSNzAFFyS52/Y1U8Euhw43lv+PumYxFawR9A4xF2thkm8IkKIKIQaAg6M5VZg2ymCN/jmT3MGVtJulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZgRE2rPw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZgRE2rPw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4816912so35860455ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 22:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518436; x=1773123236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CYLqWK3CZS7x6XnoVJUokrAtWYl16nmLP+jWdmHpw8=;
        b=ZgRE2rPwuTae0hGxG2C2ywFa0J02lqELncNOzg8b0JII/sW4eF9RT9I4Rco4iTmql3
         6UV0+Ob991A3hskKPug+BNWNGkgU94gl2vUqdr6OMgI7winH5zhFH5jaWUYuZEqLAx+L
         dJdjEVad7WChPSwtooyZD3WSz9thGmw72XD/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518436; x=1773123236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CYLqWK3CZS7x6XnoVJUokrAtWYl16nmLP+jWdmHpw8=;
        b=Kk9GvkXYpP8WuKRID/w5RV64/XQlz6qjl9VXyMzs6TfbRYjz+xBa28uEvzMtBH0o/f
         f0UKwG37o7iAl/o2Gp5O9rZoKppqPYtXdOY5BLdlOLjt2pqd5/2QJ/KLcARIL7Tj5em3
         Z7OUiG/p2XMGs6AGunR5afPzdph5VosL+K+N/5yhxfkzwKqCw0O7jPwk0OLTDjLn0N/y
         MBo87Klwfl40kUFmfsOrSq89a8czn/X3m4hwKEksUtNtkKcwev3Ln1PmpJhdyoiW/xOO
         0pn5gIn2c6/FTUt78Wb9mPMWL2hX4JsoL+1XHR+s62YCV+L5KQJ5b1saQwXtmXD3IA42
         Lwyw==
X-Forwarded-Encrypted: i=1; AJvYcCVh+4oVhV7+n9YLuPjAnjsopyt2ACVlMrRFQ+OYRWvZoS9/nBcT7uwV3ID0rOomazAw1b65jaKdF74fSPR4ZBFR+jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNmwUDxoizMvRhliPXg/cEYvLE5Ef63WauSdKpn6qBMJDpOxx
	5/X6XimFBjn6whimyAnA/tmAgmCEZmTEfYeGjVqIETc7O+T6NMYkR3or0ax5GfWxMg==
X-Gm-Gg: ATEYQzwT8+MQP9+n4WGX4D1X1+Fh+T47oVm6znwIAkCbhUaQVbA9SEZiBbq6DMZcKqR
	xwKGEYbcTHxRtTZ37EFOx+1Mw4eaajjTWAsNbvOB3/3Nyb/o5VNBkBRVbJwvbiGiwiLlkWdFBqp
	z3XYvdsGI8qLSfqqlu1hX3Q6LAwvTHdwSqVfpsV+U+kdm9D0vGV1+Jt5claN3O5o3F7PqRojOuE
	9BlmNs70PwPWQ7oCRU2sVCnMjMeorndVXCkN5QRTq/4KgGP013/poe83En4sTnQ4eyokASCQNj0
	U1tl7r2VVFhXMGhALwHAvG8o+2ZppZ0hdGGU3UenW5I1bDKrnfKjMz2UnXltxiVt9l1W/c61kkO
	cmLcDMDiXu2ESJuoo+IpoN/0712lUvRc1+V0/dGf1/6t6xXbfvWBvJTuKqoqOTZRthH9aUBEg3r
	l9HricJPhxM+UZCptyUbzEnXnGcsWvCDgI5Cz+zytUpnY6cbSHvnGr5aKXr/HYfkD4Vp1+yavn/
	1JLk6UsdHX6pm7XESEqrr+kRx1e2bOEKg==
X-Received: by 2002:a17:902:f541:b0:2ab:344e:1413 with SMTP id d9443c01a7336-2ae2e46c080mr134889525ad.34.1772518436078;
        Mon, 02 Mar 2026 22:13:56 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:55 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:13:03 +0000
Subject: [PATCH 11/12] HID: spi-hid: add panel follower support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-11-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=10421;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=9VBbxDeCBOwEkQqdAXnbqlSFol8sG1Sk8yHeuXnwVc8=;
 b=jZHqmh4vIgwl89Ot2YigAOzVXGc+PbFSOe3mkaSX/v16i2WnGSlJIczYjrPpNxw149oHIEuXm
 70WzKA8HtINA03O6OgK0QyBvu2GFsn6i7kFxc3m1WQDPblsHJcn13Kf
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 199 +++++++++++++++++++++++++++++--------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 2 files changed, 163 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 797ba99394f9..893a0d4642d2 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -238,21 +238,21 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
-static void spi_hid_suspend(struct spi_hid *shid)
+static int spi_hid_suspend(struct spi_hid *shid)
 {
 	int error;
 	struct device *dev = &shid->spi->dev;
 
 	guard(mutex)(&shid->power_lock);
 	if (shid->power_state == HIDSPI_OFF)
-		return;
+		return 0;
 
 	if (shid->hid) {
 		error = hid_driver_suspend(shid->hid, PMSG_SUSPEND);
 		if (error) {
 			dev_err(dev, "%s failed to suspend hid driver: %d",
 				__func__, error);
-			return;
+			return error;
 		}
 	}
 
@@ -270,21 +270,22 @@ static void spi_hid_suspend(struct spi_hid *shid)
 			dev_err(dev, "%s: could not power down.", __func__);
 			shid->regulator_error_count++;
 			shid->regulator_last_error = error;
-			return;
+			return error;
 		}
 
 		shid->power_state = HIDSPI_OFF;
 	}
+	return 0;
 }
 
-static void spi_hid_resume(struct spi_hid *shid)
+static int spi_hid_resume(struct spi_hid *shid)
 {
 	int error;
 	struct device *dev = &shid->spi->dev;
 
 	guard(mutex)(&shid->power_lock);
 	if (shid->power_state == HIDSPI_ON)
-		return;
+		return 0;
 
 	enable_irq(shid->spi->irq);
 
@@ -298,7 +299,7 @@ static void spi_hid_resume(struct spi_hid *shid)
 			dev_err(dev, "%s: could not power up.", __func__);
 			shid->regulator_error_count++;
 			shid->regulator_last_error = error;
-			return;
+			return error;
 		}
 		shid->power_state = HIDSPI_ON;
 
@@ -307,10 +308,13 @@ static void spi_hid_resume(struct spi_hid *shid)
 
 	if (shid->hid) {
 		error = hid_driver_reset_resume(shid->hid);
-		if (error)
+		if (error) {
 			dev_err(dev, "%s: failed to reset resume hid driver: %d.",
 				__func__, error);
+			return error;
+		}
 	}
+	return 0;
 }
 
 static void spi_hid_stop_hid(struct spi_hid *shid)
@@ -1171,6 +1175,132 @@ const struct attribute_group *spi_hid_groups[] = {
 };
 EXPORT_SYMBOL_GPL(spi_hid_groups);
 
+/*
+ * At the end of probe we initialize the device:
+ *   0) assert reset, bias the interrupt line
+ *   1) sleep minimal reset delay
+ *   2) request IRQ
+ *   3) power up the device
+ *   4) deassert reset (high)
+ * After this we expect an IRQ with a reset response.
+ */
+static int spi_hid_dev_init(struct spi_hid *shid)
+{
+	struct spi_device *spi = shid->spi;
+	struct device *dev = &spi->dev;
+	int error;
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
+					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
+	if (error) {
+		dev_err(dev, "%s: unable to request threaded IRQ.", __func__);
+		return error;
+	}
+	if (device_may_wakeup(dev)) {
+		error = dev_pm_set_wake_irq(dev, spi->irq);
+		if (error) {
+			dev_err(dev, "%s: failed to set wake IRQ.", __func__);
+			return error;
+		}
+	}
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up.", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = error;
+		return error;
+	}
+
+	shid->ops->deassert_reset(shid->ops);
+
+	return 0;
+}
+
+static void spi_hid_panel_follower_work(struct work_struct *work)
+{
+	struct spi_hid *shid = container_of(work, struct spi_hid,
+					    panel_follower_work);
+	int error;
+
+	if (!shid->desc.hid_version)
+		error = spi_hid_dev_init(shid);
+	else
+		error = spi_hid_resume(shid);
+	if (error)
+		dev_warn(&shid->spi->dev, "Power on failed: %d", error);
+	else
+		WRITE_ONCE(shid->panel_follower_work_finished, true);
+
+	/*
+	 * The work APIs provide a number of memory ordering guarantees
+	 * including one that says that memory writes before schedule_work()
+	 * are always visible to the work function, but they don't appear to
+	 * guarantee that a write that happened in the work is visible after
+	 * cancel_work_sync(). We'll add a write memory barrier here to match
+	 * with spi_hid_panel_unpreparing() to ensure that our write to
+	 * panel_follower_work_finished is visible there.
+	 */
+	smp_wmb();
+}
+
+static int spi_hid_panel_follower_resume(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	/*
+	 * Powering on a touchscreen can be a slow process. Queue the work to
+	 * the system workqueue so we don't block the panel's power up.
+	 */
+	WRITE_ONCE(shid->panel_follower_work_finished, false);
+	schedule_work(&shid->panel_follower_work);
+
+	return 0;
+}
+
+static int spi_hid_panel_follower_suspend(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	cancel_work_sync(&shid->panel_follower_work);
+
+	/* Match with shid_core_panel_follower_work() */
+	smp_rmb();
+	if (!READ_ONCE(shid->panel_follower_work_finished))
+		return 0;
+
+	return spi_hid_suspend(shid);
+}
+
+static const struct drm_panel_follower_funcs
+				spi_hid_panel_follower_prepare_funcs = {
+	.panel_prepared = spi_hid_panel_follower_resume,
+	.panel_unpreparing = spi_hid_panel_follower_suspend,
+};
+
+static int spi_hid_register_panel_follower(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+
+	shid->panel_follower.funcs = &spi_hid_panel_follower_prepare_funcs;
+
+	/*
+	 * If we're not in control of our own power up/power down then we can't
+	 * do the logic to manage wakeups. Give a warning if a user thought
+	 * that was possible then force the capability off.
+	 */
+	if (device_can_wakeup(dev)) {
+		dev_warn(dev, "Can't wakeup if following panel\n");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	return drm_panel_add_follower(dev, &shid->panel_follower);
+}
+
 int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		       struct spi_hid_conf *conf)
 {
@@ -1190,6 +1320,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1202,6 +1333,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->output_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * We need to allocate the buffer without knowing the maximum
@@ -1212,42 +1344,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	if (error)
 		return error;
 
-	/*
-	 * At the end of probe we initialize the device:
-	 *   0) assert reset, bias the interrupt line
-	 *   1) sleep minimal reset delay
-	 *   2) request IRQ
-	 *   3) power up the device
-	 *   4) deassert reset (high)
-	 * After this we expect an IRQ with a reset response.
-	 */
-
-	shid->ops->assert_reset(shid->ops);
-
-	shid->ops->sleep_minimal_reset_delay(shid->ops);
-
-	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
-					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
-	if (error) {
-		dev_err(dev, "%s: unable to request threaded IRQ.", __func__);
-		return error;
-	}
-	if (device_may_wakeup(dev)) {
-		error = dev_pm_set_wake_irq(dev, spi->irq);
+	if (shid->is_panel_follower) {
+		error = spi_hid_register_panel_follower(shid);
 		if (error) {
-			dev_err(dev, "%s: failed to set wake IRQ.", __func__);
+			dev_err(dev, "%s: could not add panel follower.", __func__);
 			return error;
 		}
+	} else {
+		error = spi_hid_dev_init(shid);
+		if (error)
+			return error;
 	}
 
-	error = shid->ops->power_up(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: could not power up.", __func__);
-		return error;
-	}
-
-	shid->ops->deassert_reset(shid->ops);
-
 	dev_dbg(dev, "%s: d3 -> %s.", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
@@ -1261,6 +1369,9 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	if (shid->is_panel_follower)
+		drm_panel_remove_follower(&shid->panel_follower);
+
 	spi_hid_stop_hid(shid);
 
 	shid->ops->assert_reset(shid->ops);
@@ -1274,18 +1385,20 @@ static int spi_hid_core_pm_suspend(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
-	spi_hid_suspend(shid);
+	if (shid->is_panel_follower)
+		return 0;
 
-	return 0;
+	return spi_hid_suspend(shid);
 }
 
 static int spi_hid_core_pm_resume(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
-	spi_hid_resume(shid);
+	if (shid->is_panel_follower)
+		return 0;
 
-	return 0;
+	return spi_hid_resume(shid);
 }
 
 const struct dev_pm_ops spi_hid_core_pm = {
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 2bfdfbe6d7fc..88e9020d37aa 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -7,6 +7,8 @@
 #include <linux/hid-over-spi.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_panel.h>
+
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
 #define SPI_HID_OUTPUT_HEADER_LEN		8
@@ -53,6 +55,10 @@ struct spi_hid {
 	struct spi_hid_input_buf *input;	/* Input buffer. */
 	struct spi_hid_input_buf *response;	/* Response buffer. */
 
+	struct drm_panel_follower panel_follower;
+	bool	is_panel_follower;
+	bool	panel_follower_work_finished;
+
 	u16 response_length;
 	u16 bufsize;
 
@@ -63,6 +69,7 @@ struct spi_hid {
 	unsigned long flags;	/* device flags. */
 
 	struct work_struct reset_work;
+	struct work_struct panel_follower_work;
 
 	/* Control lock to make sure one output transaction at a time. */
 	struct mutex output_lock;

-- 
2.53.0.473.g4a7958ca14-goog

