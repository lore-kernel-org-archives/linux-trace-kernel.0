Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7624E01E7;
	Mon, 28 Sep 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616380; cv=none; b=XsIFG5HuqDeI2IZRIOkw7xCJqOf/v+VIutECa1at0Q4e86/yxirODMqgkVHGwH/4wNfjZYFczNVf8UEBrYZe1Kr4EVZRQI1jwD3rTeu0aursE6NzwQ5nv6UIucWWdZGmUrIh2t9fO+MwB1QIrYJFGtV+EZmDKfpZRyTGldCB0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616380; c=relaxed/simple;
	bh=T7OC4nRKMqVmwsULaxUEz3joufpd8djcs976zl8/Xqs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eaMIZTbVdiaIVUJVpxwmGLeizNarCCH+UkhDGs9ldivfmBhZWnh6lD/75977FvTSTObsW6uaoOMFfGpj27/p1ByI2SHPoXwnaLxIN5+SWVZohHW6D+UDS1mmhPcLXCeAvWe/pxwYXbxxTQEOl3kGhRtiQmKecdubexikZMaVXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kEDemRW4; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LZiEExpp; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kEDemRW4";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LZiEExpp"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790616362; bh=Rq2Uefl/uDCN7yy0qsArfdj
	su0GCBTJ02syOpjDKKZk=; b=kEDemRW4+UXB9cS1f9DM3xfwhqwsotLmJb1c13CLs/dKj4hFUh
	YSmnhZwF4d4o6YcwFGtyLrf31AkqrbKsRnniTXgHngHhwnHFPQ7cAYCDIZ9kqnHI4LBLOhhDGA7
	/IzNjxkBfeeka7I7MzrvQkWUBVROUkR/0SIqtThKFcvKFeROwfhXYIxmP5K/SRRq5FF02qknkcm
	wtuQA9PgO2jZeKKRGLvXIdKvZ2Q5F79WJjgYbJub11udAmD/0B0nNcwFUHaYSqZFhN4KXkCGJHf
	BDgfD3KJtrClVWqiJR4OP6gM4A3Ngz+9ad2J4ZC/CJ8S7wtyEN5kUvzVpwPuQsxgNUw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790616362; bh=Rq2Uefl/uDCN7yy0qsArfdj
	su0GCBTJ02syOpjDKKZk=; b=LZiEExpp7DcwHYhootugj93yJytnQtp+LJx/MmLanZOOVipSDt
	en8Mn2d2YcS4yvm54Sc/INR5wOmKiN8TpmDg==;
Date: Mon, 28 Sep 2026 18:26:03 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] driver core: Disable driver overriding by default
In-Reply-To: <0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com> <0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1790612298.git.u.kleine-koenig@baylibre.com>
Message-ID: <F984EAAA-9F4F-4BB9-AD6A-E19888014738@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 September 2026 17:46:04 BST, "Uwe Kleine-König"
<u.kleine-koenig@baylibre.com> wrote:
>Driver overriding is useful only in a very limited set of situations
>and then only with very few drivers that are designed to support that.
>
>Disallow matching via driver_override unless the driver explicitly
>allows it or the safe guard is disabled using the
>"allow_driver_override" kernel parameter.
>
>Implementation detail: device_match_driver_override() isn't a static
>inline any more. It grew a certain complexity (e.g. a pr_info()) and so
>was made a regular exported function.
>
>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>---
> drivers/base/bus.c            | 43 +++++++++++++++++++++++++++++++++++
> include/linux/device.h        | 26 ++-------------------
> include/linux/device/driver.h |  2 ++
> 3 files changed, 47 insertions(+), 24 deletions(-)
>
>diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>index c51ad96d4de4..d294c198ab0c 100644
>--- a/drivers/base/bus.c
>+++ b/drivers/base/bus.c
>@@ -606,6 +606,49 @@ int bus_add_device(struct device *dev)
> 	return error;
> }
> 
>+static int __read_mostly allow_driver_override;
>+
>+static int __init allow_driver_override_setup(char *str)
>+{
>+	allow_driver_override = 1;
>+
>+	return 1;
>+}
>+__setup("allow_driver_override", allow_driver_override_setup);
>+
>+/**
>+ * device_match_driver_override() - Match a driver against the device's driver_override.
>+ * @dev: device to check
>+ * @drv: driver to match against
>+ *
>+ * Returns > 0 if a driver override is set and matches the given driver, 0 if a
>+ * driver override is set but does not match, or < 0 if a driver override is not
>+ * set at all.
>+ */

Nice!

Reviewed-by: Bradley Morgan <brads@mainlining.org>

I mean, others may provide nits, but I'm rarely a nit guy

>+int device_match_driver_override(struct device *dev,
>+				 const struct device_driver *drv)
>+{
>+	guard(spinlock)(&dev->driver_override.lock);
>+	if (dev->driver_override.name) {
>+		int ret = !strcmp(dev->driver_override.name, drv->name);
>+
>+		if (ret > 0) {
>+			if (!allow_driver_override && !drv->support_driver_override) {
>+				pr_info("Suppress driver override binding. Allow %ps to do overriding or boot with allow_driver_override on cmdline\n",
>+					drv);
>+				return -1;
>+			}
>+
>+			add_taint_module(drv->owner,
>+					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>+		}
>+
>+		return ret;
>+	}
>+	return -1;
>+}
>+EXPORT_SYMBOL_GPL(device_match_driver_override);
>+
> /**
>  * bus_probe_device - probe drivers for a new device
>  * @dev: device to probe
>diff --git a/include/linux/device.h b/include/linux/device.h
>index 4dac5e09b74c..a142bf384f1e 100644
>--- a/include/linux/device.h
>+++ b/include/linux/device.h
>@@ -892,30 +892,8 @@ static inline bool device_has_driver_override(struct device *dev)
> 	return !!dev->driver_override.name;
> }
> 
>-/**
>- * device_match_driver_override() - Match a driver against the device's driver_override.
>- * @dev: device to check
>- * @drv: driver to match against
>- *
>- * Returns > 0 if a driver override is set and matches the given driver, 0 if a
>- * driver override is set but does not match, or < 0 if a driver override is not
>- * set at all.
>- */
>-static inline int device_match_driver_override(struct device *dev,
>-					       const struct device_driver *drv)
>-{
>-	guard(spinlock)(&dev->driver_override.lock);
>-	if (dev->driver_override.name) {
>-		int ret = !strcmp(dev->driver_override.name, drv->name);
>-
>-		if (ret > 0)
>-			add_taint_module(drv->owner,
>-					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>-
>-		return ret;
>-	}
>-	return -1;
>-}
>+int device_match_driver_override(struct device *dev,
>+				 const struct device_driver *drv);
> 
> /**
>  * device_iommu_mapped - Returns true when the device DMA is translated
>diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
>index 29fbc01ef06f..0153cfcbe1b9 100644
>--- a/include/linux/device/driver.h
>+++ b/include/linux/device/driver.h
>@@ -56,6 +56,7 @@ enum probe_type {
>  * @bus:	The bus which the device of this driver belongs to.
>  * @owner:	The module owner.
>  * @mod_name:	Used for built-in modules.
>+ * @support_driver_override: driver_override only works if this is true.
>  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>  * @of_match_table: The open firmware table.
>@@ -104,6 +105,7 @@ struct device_driver {
> 	struct module		*owner;
> 	const char		*mod_name;	/* used for built-in modules */
> 
>+	bool support_driver_override;
> 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> 	enum probe_type probe_type;
> 
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
