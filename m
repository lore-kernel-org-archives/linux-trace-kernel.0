Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55833A9C4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613985; cv=none; b=UfQ4z7wnm0SLozJJZBxAKhqvYp9KUODnLhPHNOS9wFQw1Mn8Df/cj1hsBVqA5PTYHApPqSdtVe4de2UT06+Q7ruU8wPuUdKHN29/anOaXIyrBJYCAoO0HBiiXCVlCAjTH6jskHnc2oTGtv8dCj8iv9QUQD0fKE6pCx3+goWS0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613985; c=relaxed/simple;
	bh=IRU2W/F7ydrMgwoGdU2UuwMijKY9e9YvoS9hsuSBwsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joKvgIU7E1RRdQeBnRM+h+St/LneiwW0TjKTkTb4E0iwJ7ZIAEn8+NZipP4HCeTaX5CrA3r1SGxECijM5bhlNvJM9KsQmq/S8WO0OZPCtVE7tuPbpAtW2zsRl9/po7XQdItj5hDbi0Y1G/5vKzeZPCPTCeDsFyj0a/x24itPlA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=B4ifmLfH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="B4ifmLfH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so24197645e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790613981; x=1791218781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBVitcn3HaXdH3tAuDPIdNFeAeEbc5tyl1/mlq5F0y8=;
        b=B4ifmLfHelsog9yn1d225BNMcfcAHFRUGm51N5z6rWrGz+7jGXlfRmt31wmuCbIkXj
         OOn/qJf+MJDqoB7v/DxhGZXaB+kxz1lWwjd0x5KOT20+fffs4v/4rQIwcsscbI6P7f8Q
         1IBldWx3fy8ek31MQGyQxXKiR1CLyJYebosScbNT3XJ7pT3tEdMnjWxMvuUQWH2qKn0X
         IONJbpPe+Oo4iPAZq53rljfBlgIwN42ouFGqaQzbWsEkzlLFsL9IU3fcwGEY85hC0b+V
         gHfxIFhWSwiwzYW0y1Q7sn7NE9FgOLB/bIEl0XECGXLVkmaR7rpq1eJgeejZV06R6vLL
         eCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613981; x=1791218781;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBVitcn3HaXdH3tAuDPIdNFeAeEbc5tyl1/mlq5F0y8=;
        b=qRJZo4lKImi2fFXptHSYc3cShbnUQakEAW1IB6djUstsFJygKSJ0WSp5DGT7v78/Zr
         oBYvRmlgVI12AVqC5U2PgsveE/YCj+B2mFNpwtxHMrMitl+UvmNZceWg7pyFJWUp2H9u
         dL1iVnOU1NbYRLXqM8fE96iSj53z7hpWoHzR/7YVypvXpHgfZ1ZcrPSEhQc7mix+sw0V
         PODPNoI2oDV5wbR0PEqSNgpBv6ZsJPuV1/R9C/blywKq8ySBisLhmHnayRQjqxoOYuVu
         EAoarWuHO2LR90PwcnWsHfDVFjvPeiiCgXJmJtwITrcTCK+gOVdxg1LzfKoXpo/2HhBe
         bl9w==
X-Forwarded-Encrypted: i=1; AKwUvBwxvmUfAdyTToJ7GjLOG/5QoItWPSEZb9T2a34GUm0pHA1iVpxJM3P1SyTEN5vtgTh5b558h6kacs0nJUw0kXl2u0U=@vger.kernel.org
X-Gm-Message-State: AFuF++n7pRGxz4S02FmENkSoYvybZ1ZT81YGNBJQE5LyTwafarkm/90Q
	baKUR+PZc4r7IXG20gSjZF/rS3pMtED2i1pF5w5aK0ldyeZHJZEO0RGeo6d+ZBrA8II=
X-Gm-Gg: AYBFou2ZrRTzcevUo3idZoJ6x4/VTjmgP2j/8nxwfPwybDCAkOt6fXHw7Zy5o3W0I9w
	ccoqdi66COYnbbVLKdpke5WZhg8iJCaIxmWxf+BjFUIWPCsrqtY48KqtQqdfcMWzRKzUqf8w5HV
	aEZQDi/zH7nDTyTrPyAzdqH/M7wS86jzajVsdRn5ZBG47TVs56+zxX0lOwI4YhXjH3dsL/YXoMR
	pihltqG84N/jESJsjx0m56q86k2sDrzDFtuhDC1aKgLsHmyWzkpPGgf/WMbDnsvwaaSXrtZCxF3
	KypAJ+BGqwe/aISpe23veUJ56hZ/XAxwwXJyv8IkNS28C9sUpN5DxyapW3/3xVUN0jP3DIzQuM5
	QjkWn2xph1N9P0etTTndELYgPPA0RhMW7GWIn0NhkRooYd5iVohoAL1SQieq3mHYhRQT/82R5Rp
	MXV7Lbn0vgNiprICP3/0isZ47LCRPIqEH8P9dj4RvhOqb1PXFdpec5Jf7oCu34qCutl0/3MlF3w
	Qsc/UKDCXjdEnLkb0Ghu0jUMdQMW2AtzcSoeABjSI+onaPi/0sra+UFIKCMMQ==
X-Received: by 2002:a05:600c:34c3:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49fe66abcebmr238472845e9.3.1790613980612;
        Mon, 28 Sep 2026 09:46:20 -0700 (PDT)
Received: from localhost (p200300f65f19a90433f74747aea68541.dip0.t-ipconnect.de. [2003:f6:5f19:a904:33f7:4747:aea6:8541])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm7840575e9.1.2026.09.28.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:46:20 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] driver core: Disable driver overriding by default
Date: Mon, 28 Sep 2026 18:46:04 +0200
Message-ID:  <0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4517; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=IRU2W/F7ydrMgwoGdU2UuwMijKY9e9YvoS9hsuSBwsA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqupnQXtmetdwonLbuWV3cp3DItvNYU+nxUZMPs Drb2kiCLtqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarqZ0AAKCRCPgPtYfRL+ TtC1B/9PRFfnE52MTB+mR2lBFxb6IxKPVxuYEvwJ7YvS1EzIcolMOKEKUVvnfEe5jXfTK5B0Cro A/zfdE8VAxurLtwvIv732TsBtjiV+Lh2n+IM85NNZZSYHjClpZzVi+EboG8XYsTe0xKfzvQN21j KeeBhZsfXDXOL69lNvmETkApIsPNMAoAreOdS5WX7Yn2OYom/6q706iW4ovd1vwPdxnifEOuHJw 56XzQg29bz0NNel3KiUl5hpgdK9hhz6iyxm0o+Wa5SkRBJFoqVTYU9D0J+QPHZViidcNNBiR+Tx yucsf5jhFsMKgqkArIKDasDwmC0a25IXdPuFRMGFSJm6qPi2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Driver overriding is useful only in a very limited set of situations
and then only with very few drivers that are designed to support that.

Disallow matching via driver_override unless the driver explicitly
allows it or the safe guard is disabled using the
"allow_driver_override" kernel parameter.

Implementation detail: device_match_driver_override() isn't a static
inline any more. It grew a certain complexity (e.g. a pr_info()) and so
was made a regular exported function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/base/bus.c            | 43 +++++++++++++++++++++++++++++++++++
 include/linux/device.h        | 26 ++-------------------
 include/linux/device/driver.h |  2 ++
 3 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index c51ad96d4de4..d294c198ab0c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -606,6 +606,49 @@ int bus_add_device(struct device *dev)
 	return error;
 }
 
+static int __read_mostly allow_driver_override;
+
+static int __init allow_driver_override_setup(char *str)
+{
+	allow_driver_override = 1;
+
+	return 1;
+}
+__setup("allow_driver_override", allow_driver_override_setup);
+
+/**
+ * device_match_driver_override() - Match a driver against the device's driver_override.
+ * @dev: device to check
+ * @drv: driver to match against
+ *
+ * Returns > 0 if a driver override is set and matches the given driver, 0 if a
+ * driver override is set but does not match, or < 0 if a driver override is not
+ * set at all.
+ */
+int device_match_driver_override(struct device *dev,
+				 const struct device_driver *drv)
+{
+	guard(spinlock)(&dev->driver_override.lock);
+	if (dev->driver_override.name) {
+		int ret = !strcmp(dev->driver_override.name, drv->name);
+
+		if (ret > 0) {
+			if (!allow_driver_override && !drv->support_driver_override) {
+				pr_info("Suppress driver override binding. Allow %ps to do overriding or boot with allow_driver_override on cmdline\n",
+					drv);
+				return -1;
+			}
+
+			add_taint_module(drv->owner,
+					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
+		}
+
+		return ret;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_GPL(device_match_driver_override);
+
 /**
  * bus_probe_device - probe drivers for a new device
  * @dev: device to probe
diff --git a/include/linux/device.h b/include/linux/device.h
index 4dac5e09b74c..a142bf384f1e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -892,30 +892,8 @@ static inline bool device_has_driver_override(struct device *dev)
 	return !!dev->driver_override.name;
 }
 
-/**
- * device_match_driver_override() - Match a driver against the device's driver_override.
- * @dev: device to check
- * @drv: driver to match against
- *
- * Returns > 0 if a driver override is set and matches the given driver, 0 if a
- * driver override is set but does not match, or < 0 if a driver override is not
- * set at all.
- */
-static inline int device_match_driver_override(struct device *dev,
-					       const struct device_driver *drv)
-{
-	guard(spinlock)(&dev->driver_override.lock);
-	if (dev->driver_override.name) {
-		int ret = !strcmp(dev->driver_override.name, drv->name);
-
-		if (ret > 0)
-			add_taint_module(drv->owner,
-					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
-
-		return ret;
-	}
-	return -1;
-}
+int device_match_driver_override(struct device *dev,
+				 const struct device_driver *drv);
 
 /**
  * device_iommu_mapped - Returns true when the device DMA is translated
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 29fbc01ef06f..0153cfcbe1b9 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -56,6 +56,7 @@ enum probe_type {
  * @bus:	The bus which the device of this driver belongs to.
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
+ * @support_driver_override: driver_override only works if this is true.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
@@ -104,6 +105,7 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
+	bool support_driver_override;
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
 
-- 
2.47.3

