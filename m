Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017866;
	b=QUrTzJQ4vCkhrtL7mkjs0U7JDE4sh64TJPHKX4d+T6WY17DIFWh4ByRrLenOWmdfK0C0
	 rMBEhxgz35ePu3PjYejj1KvPvYl8vsgKrRs46IG09l+OM2oNRUMk1rwH6DLuLl7LGVRec
	 6Y1Gxd0dRAui4kMew+gXchAB0LZRdh7XYHjWj6ksUTUVQ5jFpQVJso0/5fbaqDG/dn/c5
	 IPrhUtOMXP0Wfndpz3cawV4WW+RZIxSh5p6+BO5WT8EZvMv95YJ06CLXnHFL3eDTiDA3i
	 F+b3scRsxDYCwuBTwzqm5E1VK06skOLAyhlxqVJHwklXjOuDmSGhEInCYqCkIsR8+KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017866;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9pu2ynzbB95yFiHyketSIGg1W8mROzR4vW4+FAJ3uMw=;
	b=aGavqWs0Ft5w/hUUuc6Nf7aeR8l1Z6N0qMS5Xuy05lLCFR/J9bCTVX4HjRpNuwT5g9uZ
	 BseJF9kIuKfzrtJQL3XnajnfAqmnyDdNwE0xqopI9AR/lbXWku/fAUhDUgHqR0RMdyBLK
	 A3qfAvhPSZIbDDhOlpvaRf8ESSdBs+yhS9piok23TCBDr3Y3PEaaNpbr1/JiusHTy1abP
	 K8dIQCSjpqSqxeXgv3F0MZ87/cKBq73eHqZY0/5gROl5AMCS6tOd+fI9PevCQfc+m3GU1
	 k/6rSQN695onxZEniBqa9k+xjq5isrjO3K3R9d7nHtJlN/6vGYGjPByfGAwqDrzyXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yyhy1+JV;
	arc=none smtp.remote-ip=91.218.175.65
Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8A606A330
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 16:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BED8A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yyhy1+JV
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tOuesJ5G6ays0gllBTJXa7tBPrShiO0VPzMlajI0i08=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795017863; v=1; x=1795622663;
 b=Yyhy1+JVzMAI3bMTDJGhjnsaPfVxcyUdl+JOVy1q2TbnAT8XY99vE7eZinpKpz5JdCiV+/ZQ
 JmDn1ErSXXSLFOh0o6vk15j2P8C3hHQU/EqfU8n+syTE0Af5kWmywI0i8IubT+MAOSD8s/f0KYe
 IfhpH518STIY1FEhCMJX5iQI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea64e67a7ada2641;
	Wed, 18 Nov 2026 16:04:23 +0000
X-Mizu-Trace-ID: ea64e67a7ada2641
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 16:04:23 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 Thierry Reding <thierry.reding@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Marco Elver <elver@google.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Petr Mladek <pmladek@suse.com>, Pnina Feder <pnina.feder@mobileye.com>,
 Mete Durlu <meted@linux.ibm.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Rio <rioo.tsukatsukii@gmail.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] driver core: Disable driver overriding by default
In-Reply-To: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
References: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
Message-ID: <CC155D9B-1672-43D2-8D0D-5F79CAD1A797@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 November 2026 11:08:52 GMT, "Uwe Kleine-König"
<u.kleine-koenig@baylibre.com> wrote:
>Driver overriding is useful only in a very limited set of situations
>and then only with very few drivers that are designed to support that.
>
>Disallow matching via driver_override unless the driver explicitly
>allows it or the safe guard is disabled using the
>"allow_driver_override=1" kernel parameter.
>
>There are many drivers that don't expect to be force-bound and often
>doing it anyhow results in a NULL pointer exception. To make debugging
>such cases easier, add a new taint if such a forced match happens.
>
>Implementation detail: device_match_driver_override() isn't a static
>inline any more. It grew a certain complexity (e.g. a pr_info()) and so
>was made a regular exported function.

Ooh. Interesting.

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


>
>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>---
>Hello,
>
>this is a rebase to current next of the series
>https://lore.kernel.org/all/cover.1790612298.git.u.kleine-koenig@baylibre.com/
>. It combines the functionality of former patches #2 and #3 (#1 was a
>fix that was already applied). I also addressed sashiko's comments. I
>think
>this matches what most people want in the previous discussion.
>
>As the rebase wasn't trivial and I merged the two patches, I didn't
>apply the review tags I already received for v3.
>
>If this patch is accepted, a number of drivers that are supposed to be
>force-bound need to get their .support_driver_override property set. I'm
>aware of the following:
>
> - spidev_spi_driver in drivers/spi/spidev.c
> - stub_driver in drivers/pci/pci-stub.c
> - uio_dmem_genirq in drivers/uio/uio_dmem_genirq.c
> - uio_pci_driver in drivers/uio/uio_pci_generic.c
> - uio_pdrv_genirq in drivers/uio/uio_pdrv_genirq.c
> - vfio_amba_driver in drivers/vfio/platform/vfio_amba.c
> - vfio_ccw_sch_driver in drivers/s390/cio/vfio_ccw_drv.c
> - vfio_pci_driver in drivers/vfio/pci/vfio_pci.c
> - vfio_platform_driver in drivers/vfio/platform/vfio_platform.c
>
>This is not needed for the userspace i2c driver.
>
>As the flag to set is only introduced in this patch and assuming this
>patch is accepted, I suggest to create an immutable branch for it to
>allow setting the needed flags in driver trees. Alternatively let all
>these go together via a single tree or branch.
>
>Best regards
>Uwe
>
> .../admin-guide/kernel-parameters.txt         |  6 +++
> Documentation/admin-guide/tainted-kernels.rst | 54 ++++++++++---------
> drivers/base/bus.c                            | 50 +++++++++++++++++
> include/linux/device.h                        | 19 +------
> include/linux/device/driver.h                 |  2 +
> include/linux/panic.h                         |  3 +-
> include/trace/events/module.h                 |  3 +-
> kernel/panic.c                                |  3 +-
> tools/debugging/kernel-chktaint               |  9 ++++
> 9 files changed, 104 insertions(+), 45 deletions(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index 85804cfe7ef6..aabc97feef9b 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -424,6 +424,12 @@ Kernel parameters
> 			do not want to use tracing_snapshot_alloc() as it needs
> 			to be done where GFP_KERNEL allocations are allowed.
> 
>+	allow_driver_override=
>+			When set to 1 allow matching drivers without
>+			.support_driver_override = true to devices using
>+			driver_override. This is a dangerous operation in
>+			general allowing root to oops the kernel.
>+
> 	allow_mismatched_32bit_el0 [ARM64,EARLY]
> 			Allow execve() of 32-bit applications and setting of the
> 			PER_LINUX32 personality on systems where only a strict
>diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>index fcb8b9734548..e6bab575ccef 100644
>--- a/Documentation/admin-guide/tainted-kernels.rst
>+++ b/Documentation/admin-guide/tainted-kernels.rst
>@@ -74,35 +74,36 @@ a particular type of taint. It's best to leave that to the aforementioned
> script, but if you need something quick you can use this shell command to
> check
> which bits are set::
> 
>-	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
>+	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
> 
> Table for decoding tainted state
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>-===  ===  ======  ========================================================
>-Bit  Log  Number  Reason that got the kernel tainted
>-===  ===  ======  ========================================================
>-  0  G/P       1  proprietary module was loaded
>-  1  _/F       2  module was force loaded
>-  2  _/S       4  kernel running on an out of specification system
>-  3  _/R       8  module was force unloaded
>-  4  _/M      16  processor reported a Machine Check Exception (MCE)
>-  5  _/B      32  bad page referenced or some unexpected page flags
>-  6  _/U      64  taint requested by userspace application
>-  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
>-  8  _/A     256  ACPI table overridden by user
>-  9  _/W     512  kernel issued warning
>- 10  _/C    1024  staging driver was loaded
>- 11  _/I    2048  workaround for bug in platform firmware applied
>- 12  _/O    4096  externally-built ("out-of-tree") module was loaded
>- 13  _/E    8192  unsigned module was loaded
>- 14  _/L   16384  soft lockup occurred
>- 15  _/K   32768  kernel has been live patched
>- 16  _/X   65536  auxiliary taint, defined for and used by distros
>- 17  _/T  131072  kernel was built with the struct randomization plugin
>- 18  _/N  262144  an in-kernel test has been run
>- 19  _/J  524288  userspace used a mutating debug operation in fwctl
>-===  ===  ======  ========================================================
>+===  ===  =======  ========================================================
>+Bit  Log   Number  Reason that got the kernel tainted
>+===  ===  =======  ========================================================
>+  0  G/P        1  proprietary module was loaded
>+  1  _/F        2  module was force loaded
>+  2  _/S        4  kernel running on an out of specification system
>+  3  _/R        8  module was force unloaded
>+  4  _/M       16  processor reported a Machine Check Exception (MCE)
>+  5  _/B       32  bad page referenced or some unexpected page flags
>+  6  _/U       64  taint requested by userspace application
>+  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
>+  8  _/A      256  ACPI table overridden by user
>+  9  _/W      512  kernel issued warning
>+ 10  _/C     1024  staging driver was loaded
>+ 11  _/I     2048  workaround for bug in platform firmware applied
>+ 12  _/O     4096  externally-built ("out-of-tree") module was loaded
>+ 13  _/E     8192  unsigned module was loaded
>+ 14  _/L    16384  soft lockup occurred
>+ 15  _/K    32768  kernel has been live patched
>+ 16  _/X    65536  auxiliary taint, defined for and used by distros
>+ 17  _/T   131072  kernel was built with the struct randomization plugin
>+ 18  _/N   262144  an in-kernel test has been run
>+ 19  _/J   524288  userspace used a mutating debug operation in fwctl
>+ 20  _/Z  1048576  a driver was forced on a non-matching device
>+===  ===  =======  ========================================================
> 
> Note: The character ``_`` is representing a blank in this table to make reading
> easier.
>@@ -189,3 +190,6 @@ More detailed explanation for tainting
>  19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>      to use the devices debugging features. Device debugging features could
>      cause the device to malfunction in undefined ways.
>+
>+ 20) ``Z`` if a device was matched using the `driver_override` sysfs property
>+     to a driver that didn't explicitly allow that.
>diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>index 396097fdb316..5344b20488fd 100644
>--- a/drivers/base/bus.c
>+++ b/drivers/base/bus.c
>@@ -603,6 +603,56 @@ int bus_add_device(struct device *dev)
> 	return error;
> }
> 
>+static bool __read_mostly allow_driver_override;
>+
>+static int __init allow_driver_override_setup(char *str)
>+{
>+	if (!str || kstrtobool(str, &allow_driver_override) < 0)
>+		allow_driver_override = true;
>+
>+	return 1;
>+}
>+__setup("allow_driver_override=", allow_driver_override_setup);
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
>+int device_match_driver_override(struct device *dev,
>+				 const struct device_driver *drv)
>+{
>+	guard(spinlock)(&dev->driver_override.lock);
>+	if (dev->driver_override.name) {
>+		int ret = !strcmp(dev->driver_override.name, drv->name);
>+
>+		if (ret > 0 && !drv->support_driver_override) {
>+			if (allow_driver_override) {
>+				add_taint_module(drv->owner,
>+						 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>+			} else {
>+				/*
>+				 * If you hit this warning and you need to
>+				 * quickly workaround this check, boot with
>+				 * allow_driver_override=1 on the kernel
>+				 * commandline. The right fix is to set the
>+				 * driver's .support_driver_override property.
>+				 */
>+				dev_warn(dev, "Suppressed driver override binding to %s.\n", drv->name);
>+				return -1;
>+			}
>+		}
>+
>+		return ret;
>+	}
>+	return -1;
>+}
>+EXPORT_SYMBOL_GPL(device_match_driver_override);
>+
> static void __bus_probe_device(struct device *dev)
> {
> 	struct subsys_private *sp = bus_to_subsys(dev->bus);
>diff --git a/include/linux/device.h b/include/linux/device.h
>index 6b082c638d45..05413c1a9454 100644
>--- a/include/linux/device.h
>+++ b/include/linux/device.h
>@@ -907,23 +907,8 @@ static inline bool device_has_driver_override(struct device *dev)
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
>-	if (dev->driver_override.name)
>-		return !strcmp(dev->driver_override.name, drv->name);
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
>diff --git a/include/linux/panic.h b/include/linux/panic.h
>index 17e61b61c45f..009232511cc7 100644
>--- a/include/linux/panic.h
>+++ b/include/linux/panic.h
>@@ -89,7 +89,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
> #define TAINT_RANDSTRUCT		17
> #define TAINT_TEST			18
> #define TAINT_FWCTL			19
>-#define TAINT_FLAGS_COUNT		20
>+#define TAINT_DRIVER_OVERRIDE		20
>+#define TAINT_FLAGS_COUNT		21
> #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> 
> struct taint_flag {
>diff --git a/include/trace/events/module.h b/include/trace/events/module.h
>index e5a006be9dc6..d54ce3c7572b 100644
>--- a/include/trace/events/module.h
>+++ b/include/trace/events/module.h
>@@ -26,7 +26,8 @@ struct module;
> 	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
> 	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
> 	{ (1UL << TAINT_CRAP),			"C" },		\
>-	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
>+	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
>+	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
> 
> TRACE_EVENT(module_load,
> 
>diff --git a/kernel/panic.c b/kernel/panic.c
>index 91e48d33b7db..81ea9ef9afb0 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -825,6 +825,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
> 	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
> 	TAINT_FLAG(TEST,			'N', ' '),
> 	TAINT_FLAG(FWCTL,			'J', ' '),
>+	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
> };
> 
> #undef TAINT_FLAG
>@@ -861,7 +862,7 @@ static void print_tainted_seq(struct seq_buf *s, bool verbose)
>  * exact size is allocated dynamically; the initial buffer remains
>  * as a fallback if allocation fails.
>  *
>- * The verbose taint string currently requires up to 327 characters.
>+ * The verbose taint string currently requires up to 348 characters.
>  */
> #define INIT_TAINT_BUF_MAX 350
> 
>diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
>index e1571c04afb5..56215e0f5112 100755
>--- a/tools/debugging/kernel-chktaint
>+++ b/tools/debugging/kernel-chktaint
>@@ -211,6 +211,15 @@ else
> 	addout "J"
> 	echo " * fwctl's mutating debug interface was used (#19)"
> fi
>+
>+T=`expr $T / 2`
>+if [ `expr $T % 2` -eq 0 ]; then
>+	addout " "
>+else
>+	addout "Z"
>+	echo " * A device was matched using driver_override to a driver not supporting that (#20)"
>+fi
>+
> echo "Raw taint value as int/string: $taint/'$out'"
> 
> # report on any tainted loadable modules
>
>base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
>

--- Thanks!
