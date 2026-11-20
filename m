Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173096;
	b=J5+LnXZehNFfZ2Vj8P8EvRD/qqGglEI5fih1qXu3Q86oeyQ9nhNSYGrvfuv2IN5apm5+
	 k6AUgGBxvsPmJhlGxBOBeMjkFme83eaZTusD9WD+3jLHYtoM6QS9DNJXq1E8ODrIXlBPn
	 /MIegSzrguApvvdpsqR17i5KsS40fwb5zkiaAyexhyUTWyxvHTiqR1D7qNQqLlhZx+c6B
	 up2fRCZeeDF1g8ARoxHFC3uQ2j+zjaXc5c6KjMcYupDZ2WdmtxYcmYkAJx7E/o76vz6dc
	 TU/7HMgJYy1hIyBkTSEvu65xCO9lehl7P2WFMyEvrBCaKKrwA+bS2Dssy/Dd4X/QISw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=4TcCFaZKby/OG3NmAmw+Ono71LXdkW9/MMT5MlG4it4=;
	b=ne6sQLM2xclnR5Q8ljxxKZYR5oIyybFdeVKtA6PFju4opY4TOX9vo4olm2foSokpT/YB
	 bN3qGoihs6uQfTEzB8lDfVqaQoVzmVoL6taLccW5llqq2GuuoGgnqFU3feqNBegJxY+0z
	 CwvZgZrMNIHhkyU6PR5Fi/whs8eKTjrufcY/P8QvXQUCSEx+zv+G8SNTt+S15qNoPRHCc
	 xLTd3J5+6Gzew78y7hGxuoh7dqJcuvheC2NOlOBxVsB3uqfdTP5hK2ixYoc3bnuwil7Cf
	 MWBOI0CbGtzzHgkZtLAgRFyCZlEwCzkLjeOAnpkwBCnksXgkls9z0enzURZGxxvBgiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LzkZk63t;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FE60A261B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 11:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 633FE60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LzkZk63t
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so5299645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 03:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173094; x=1795777894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4TcCFaZKby/OG3NmAmw+Ono71LXdkW9/MMT5MlG4it4=;
        b=LzkZk63tJJEPSFdp9wYESqO+L2+r32U2M5ONXnPzyqIwt8J4Bz/JJHsME4aphwKDGb
         Gh2ESVbopk4VlEiWOC3X40XTgJpV8SB3P6iDJM+K5qsjDey1TMdj55q8u8rllDaZ5vZO
         TrCX/vPXEUgHic8MLSRsPQUrwEhzGwgHlLmfDXUc9keT48wOQpw56TwEC9faVM5UDXyK
         KElNKJnxIF85hSRPtqBGVm555d1x05D/jWU3GzlQR0WahueTayGH6TSd+yurTI7JWFT8
         I7ppXVMOtNv2Sa4MmJpgjJnKv3rktG3oSMnbwwIc1PJbIDXWCI9/smNV0zPBuGXDSINl
         wRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173094; x=1795777894;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4TcCFaZKby/OG3NmAmw+Ono71LXdkW9/MMT5MlG4it4=;
        b=w9dvUfT/Hj1oI5hB39Ph0u9mOVoHn4B1scin7rCcHGCmz94JphR9xm9Zsj7i2T86wj
         K0nIshAKIfxSgJGPqkK1u/OTqoM3NRhjVNsuNGO68fCitK+cKaPoDhmcTiaYHfWKxv+9
         iNS/Q576xxjhLGa0RuDz98jJapPKAl/0Mv9FgzJ+PrTYQfsFrgOsgnxZeEp53wIoLlIb
         a00CjpBEdHW+J8YmIlgh1lj/Q2vU5ee3WXCJpUWSXO5bKve2KmL5WzltFtRoV6rJQWId
         3URAhOXg2aK7+l8ncmtTglWDRb702uV7LgVB/xmM4nYBs23vMoszC71FqSbMZt36QVHd
         1joQ==
X-Forwarded-Encrypted: i=1; AL+hErHBBZC0dNdTJK9rVU0Pdbgyi7ormvasNBnX3Y/w/H54sm6xO5yzV3vOkxDXgivgP3uoQX11/cWl2k3/EQrx0cpZ5M4=@vger.kernel.org
X-Gm-Message-State: APuU4Z962pJrXugV1zl7sRBBXYMfH0BVPnCUm7i6eTQMOIpriOK4WXun
	obnJkCAYOKXP9xP7nErvHpO3B8G5V2Wmx8pCCCMJFHVffavkTesjNqjL6lEBzV87kSI=
X-Gm-Gg: AYBFou3iJZGh2RDzeq3c35i+ghcwXdq4hxl2HD/i2Pd6H3lAZcgqiRdoQ2j570i2LVG
	gl4TclVMjANTKlpi987SL1KO8sd3cepa5gbiAx1C+DpJuDcNJiDc5hqCGU7NoknHyBR0CL1Tq9Q
	8BKjIowSQeHzUw/wHpE0IbizyxiOvqaLlOiwboq2PBwNdo/q+jmJIdps7He6z4DQj5KyG8TICwf
	b3fHSIKiZWUAt17hoU4WoYk/RU0CFILPqUKdUfzxnywPyxIoiTcPR3IFCcFOTdi7wT3FFW5uAFR
	ZiqnnKwiPaS1MoRT0HOY7rlum1+B30MvWSC7MwFeGCOvfEC0jBgBm7L63en5EsqrmRpLOT+zp8i
	N7HfobydwvMs7JPKS0rzwAmy+uwLdrRFfVy522+hf+KQeXvkeyZClUv33x5hHb573o/6KuYqI9+
	6nFWOwqnbcq61Z4+Ug4QdJOMlvSqRPA4ZqUgW0e1WVWy4URJRPMivGrobyKp9yKbNkmwcK8tvnP
	wJbp8/7XGhNy/zANBJdctTEjJ355cXwDIuQw6IXGxcmVOHCBqRdHx3HdAZ0sNMPabgfIqtzh+EQ
	8MUqSdBq0E5f+U6mbs/Povv49oKoKhWZ46cuwTuxhUmqWFavcu+cl1RtOHWTNUMPoVOP8N+cmH1
	lp/AbrXEl94tdDWbP
X-Received: by 2002:a05:600c:820c:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4bb887876c0mr67502185e9.0.1795173093676;
        Fri, 20 Nov 2026 03:11:33 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b2c5sm107111565e9.5.2026.11.20.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:33 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	Armin Wolf <W_Armin@gmx.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] driver core: Disable driver overriding by default
Date: Fri, 20 Nov 2026 12:11:02 +0100
Message-ID:  <f7b5c6319203d288a166e6f811c6ea07e12d5f4f.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12838; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=x3PVZ+jfcrLEsTWMUEUcchww2RjVPV4+tDaq3+CblTY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrACrLX2dc7d1KEnYrLU+zxrcxqIPlq/9zSq1Lz BIRG6UwPu+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawAqywAKCRCPgPtYfRL+ TtbCB/9TlcTSYFIcC6+GuaA7bDx0TOPfjqnx95rNFexQdHaDJppeKvACspPAlLgyhYKxpO0D8Vq VCLZSdSqh01jK0pvpm1cgGxq4pT2JUNOGvz6zD552ZKICiQNh6+qEeAj6vui8BMPAIHoZiaf/EB BeEhMopwUSwwZoSGar3PgN/GQiDDDFb1EkvwPgzJMh4Dh83UTISh4BhiL/xSOC/KA4ZIbjBJBPt l41Vtp68bZdJQK1/NjzYwGresY79TozGCFYYlvKqbq7IKLhuZS4WWCs0PBf7WLC91d4nLONfV1t 4mmupS/nRPhmqR9aj9ZmwP91RzJRqajZNjIfVmjurBHHY/Ge
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Driver overriding is useful only in a very limited set of situations
and then only with very few drivers that are designed to support that.

Disallow matching via driver_override unless the driver explicitly
allows it or the safe guard is disabled using the
"allow_driver_override=1" kernel parameter.

There are many drivers that don't expect to be force-bound and often
doing it anyhow results in a NULL pointer exception. To make debugging
such cases easier, add a new taint if such a forced match happens.

Implementation detail: device_match_driver_override() isn't a static
inline any more. It grew a certain complexity (e.g. a pr_info()) and so
was made a regular exported function.

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 Documentation/admin-guide/tainted-kernels.rst | 54 ++++++++++---------
 drivers/base/bus.c                            | 51 ++++++++++++++++++
 include/linux/device.h                        | 19 +------
 include/linux/device/driver.h                 |  2 +
 include/linux/panic.h                         |  3 +-
 include/trace/events/module.h                 |  3 +-
 kernel/panic.c                                |  3 +-
 tools/debugging/kernel-chktaint               |  9 ++++
 9 files changed, 105 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8228c9acc530..ed505e362b1d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -424,6 +424,12 @@ Kernel parameters
 			do not want to use tracing_snapshot_alloc() as it needs
 			to be done where GFP_KERNEL allocations are allowed.
 
+	allow_driver_override
+			Allow matching drivers without
+			.support_driver_override = true to devices using
+			driver_override. This is a dangerous operation in
+			general allowing root to oops the kernel.
+
 	allow_mismatched_32bit_el0 [ARM64,EARLY]
 			Allow execve() of 32-bit applications and setting of the
 			PER_LINUX32 personality on systems where only a strict
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index fcb8b9734548..f4ddb63dc704 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -74,35 +74,36 @@ a particular type of taint. It's best to leave that to the aforementioned
 script, but if you need something quick you can use this shell command to check
 which bits are set::
 
-	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
+	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
 
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-===  ===  ======  ========================================================
-Bit  Log  Number  Reason that got the kernel tainted
-===  ===  ======  ========================================================
-  0  G/P       1  proprietary module was loaded
-  1  _/F       2  module was force loaded
-  2  _/S       4  kernel running on an out of specification system
-  3  _/R       8  module was force unloaded
-  4  _/M      16  processor reported a Machine Check Exception (MCE)
-  5  _/B      32  bad page referenced or some unexpected page flags
-  6  _/U      64  taint requested by userspace application
-  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
-  8  _/A     256  ACPI table overridden by user
-  9  _/W     512  kernel issued warning
- 10  _/C    1024  staging driver was loaded
- 11  _/I    2048  workaround for bug in platform firmware applied
- 12  _/O    4096  externally-built ("out-of-tree") module was loaded
- 13  _/E    8192  unsigned module was loaded
- 14  _/L   16384  soft lockup occurred
- 15  _/K   32768  kernel has been live patched
- 16  _/X   65536  auxiliary taint, defined for and used by distros
- 17  _/T  131072  kernel was built with the struct randomization plugin
- 18  _/N  262144  an in-kernel test has been run
- 19  _/J  524288  userspace used a mutating debug operation in fwctl
-===  ===  ======  ========================================================
+===  ===  =======  ========================================================
+Bit  Log   Number  Reason that got the kernel tainted
+===  ===  =======  ========================================================
+  0  G/P        1  proprietary module was loaded
+  1  _/F        2  module was force loaded
+  2  _/S        4  kernel running on an out of specification system
+  3  _/R        8  module was force unloaded
+  4  _/M       16  processor reported a Machine Check Exception (MCE)
+  5  _/B       32  bad page referenced or some unexpected page flags
+  6  _/U       64  taint requested by userspace application
+  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
+  8  _/A      256  ACPI table overridden by user
+  9  _/W      512  kernel issued warning
+ 10  _/C     1024  staging driver was loaded
+ 11  _/I     2048  workaround for bug in platform firmware applied
+ 12  _/O     4096  externally-built ("out-of-tree") module was loaded
+ 13  _/E     8192  unsigned module was loaded
+ 14  _/L    16384  soft lockup occurred
+ 15  _/K    32768  kernel has been live patched
+ 16  _/X    65536  auxiliary taint, defined for and used by distros
+ 17  _/T   131072  kernel was built with the struct randomization plugin
+ 18  _/N   262144  an in-kernel test has been run
+ 19  _/J   524288  userspace used a mutating debug operation in fwctl
+ 20  _/Z  1048576  A device was matched using driver_override to a driver not supporting that
+===  ===  =======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
 easier.
@@ -189,3 +190,6 @@ More detailed explanation for tainting
  19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
      to use the devices debugging features. Device debugging features could
      cause the device to malfunction in undefined ways.
+
+ 20) ``Z`` if a device was matched using the `driver_override` sysfs property
+     to a driver that didn't explicitly allow that.
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 396097fdb316..1b4dd98a1286 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -603,6 +603,57 @@ int bus_add_device(struct device *dev)
 	return error;
 }
 
+static bool __read_mostly allow_driver_override;
+
+static int __init allow_driver_override_setup(char *str)
+{
+	if (!str || *str != '\0')
+		return 0;
+
+	allow_driver_override = true;
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
+ * driver override is set but does not match or is ignored, or < 0 if a driver
+ * override is not set at all.
+ */
+int device_match_driver_override(struct device *dev,
+				 const struct device_driver *drv)
+{
+	guard(spinlock)(&dev->driver_override.lock);
+	if (dev->driver_override.name) {
+		int ret = !strcmp(dev->driver_override.name, drv->name);
+
+		if (ret && !drv->support_driver_override) {
+			if (allow_driver_override) {
+				add_taint_module(drv->owner,
+						 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
+			} else {
+				/*
+				 * If you hit this warning and you need to
+				 * quickly workaround this check, boot with
+				 * allow_driver_override=1 on the kernel
+				 * commandline. The right fix is to set the
+				 * driver's .support_driver_override property.
+				 */
+				dev_warn(dev, "Denied matching to %s via driver override.\n", drv->name);
+				return 0;
+			}
+		}
+
+		return ret;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_GPL(device_match_driver_override);
+
 static void __bus_probe_device(struct device *dev)
 {
 	struct subsys_private *sp = bus_to_subsys(dev->bus);
diff --git a/include/linux/device.h b/include/linux/device.h
index 6b082c638d45..05413c1a9454 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -907,23 +907,8 @@ static inline bool device_has_driver_override(struct device *dev)
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
-	if (dev->driver_override.name)
-		return !strcmp(dev->driver_override.name, drv->name);
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
 
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 17e61b61c45f..009232511cc7 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -89,7 +89,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
 #define TAINT_FWCTL			19
-#define TAINT_FLAGS_COUNT		20
+#define TAINT_DRIVER_OVERRIDE		20
+#define TAINT_FLAGS_COUNT		21
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/include/trace/events/module.h b/include/trace/events/module.h
index e5a006be9dc6..d54ce3c7572b 100644
--- a/include/trace/events/module.h
+++ b/include/trace/events/module.h
@@ -26,7 +26,8 @@ struct module;
 	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
 	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
 	{ (1UL << TAINT_CRAP),			"C" },		\
-	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
+	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
+	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
 
 TRACE_EVENT(module_load,
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 91e48d33b7db..81ea9ef9afb0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -825,6 +825,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
 	TAINT_FLAG(TEST,			'N', ' '),
 	TAINT_FLAG(FWCTL,			'J', ' '),
+	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
 };
 
 #undef TAINT_FLAG
@@ -861,7 +862,7 @@ static void print_tainted_seq(struct seq_buf *s, bool verbose)
  * exact size is allocated dynamically; the initial buffer remains
  * as a fallback if allocation fails.
  *
- * The verbose taint string currently requires up to 327 characters.
+ * The verbose taint string currently requires up to 348 characters.
  */
 #define INIT_TAINT_BUF_MAX 350
 
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index e1571c04afb5..56215e0f5112 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -211,6 +211,15 @@ else
 	addout "J"
 	echo " * fwctl's mutating debug interface was used (#19)"
 fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "Z"
+	echo " * A device was matched using driver_override to a driver not supporting that (#20)"
+fi
+
 echo "Raw taint value as int/string: $taint/'$out'"
 
 # report on any tainted loadable modules
-- 
2.56.0.rc1

