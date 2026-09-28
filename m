Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369354F3EC4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613984; cv=none; b=WziCjrVw164a8JfK4mi6l4CqGLQfNtF1KmPy+3vz/6ctn4FMSSjMMMLQL0uO38qfFnw9H6sipxg73AawM5iS4+R0gMuBPKv1/KVd9fYQgD8JzZrh4UCzukzeHxpjJcWgqadDQ52+qdBTlCZi7LPw+88Gpty0wh+aulDcFWqyErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613984; c=relaxed/simple;
	bh=UXYAvC32LCckhRQVeoGZ6q1PHOfqqS7yacmTUDqFKNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMEsSG2OaFHPTPDF9Enz5rzSRy7QMngX2MEPtzW54aVeho3kaRYGf/d8BPj+T0SYZ+UOMknd8AEYBKQuqOlgj+TrjN/Ib+Ylss99PCJvLzb5KK5uQxL4Ij3Yk4rPY9/2cd/t/xZkEv3qYYLkKQVQdSvPvy6tqc/CwFtCatphY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fqFDtAVB; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fqFDtAVB"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b926f0so2069866f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790613979; x=1791218779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=96zuwL4yNsNGkrqED2ImS4bE4mZi7CfH5TZ7ZKiMres=;
        b=fqFDtAVB0YmBkbG+JBokojX7EIALCzwqKJAdZl43MUKHfBawMgtzJ0Fsu0x+JNfDEn
         Nuy2O6HrHB4DLkUIRjovxa4hC7h1qUPQdFRKbh/PQvmxWmVdECKLcpVtHkObdtr/ZFzb
         pcsgv4T/fCKNEGWWM6gUbGRBHsE3cQivL9uGvQmAwuWH1wsNI7dhPzgwcKn2ae2p/Vny
         cd23wVf9Dhdf14cKE5HwQWShLArWpFM/xtLDiEhVjjYhkS7h/c+Me+7mlK6YJhNg43E1
         2VU1KTVMD6jJlA0HB8Po9smTI846xqs/GaQRR9W8xjUKOKhQaEqhB7stVZ6iGOwDuBFJ
         +kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613979; x=1791218779;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96zuwL4yNsNGkrqED2ImS4bE4mZi7CfH5TZ7ZKiMres=;
        b=qHk0ztEpdf5AfXmlHAY9hs7CIxgfRiSysZThC/5JrUDAvmSRqyAGEtiaEKwyDVdtja
         uelGlmIueAYF0nyygork/NdBIvotPZV7WPfgRFvNefbg5UHwZ8the0rJ10/SuwjbMeUS
         coq7XBZPzwdBp/SybiSkX/Zc2a/xu7+fZJpmwr3RWNXH1edERoMif7piZcXA0n4LWML5
         x3xX8IC3yp/XewWtz34s2w59BPZ3ldw8MmwrF0i5GaA0QC2AkNFzSvd7WK/kOVtbeI7N
         I+cmmFWWoNpHzWT5XD1LamWR6i2IQZc1l2dOhA5F7LDXX6mXsyqs3cGs16avB4o26Mdh
         fgsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0o0FW6stXjc9cbg2tTt1Qmpzd4AuKId14mckXH/lPrQ451pxH7HPlv7VeaUW0cdPq5C9ILNkZJkPgTRCu5nLLaOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIARzY91xK9DbLqHZmnPm/HIAVhdVQvCPIA2lFWdLiA0VyAiyaL
	5wvXDt1AxR9GUKG6/McoqXyO1BN0I2i9YqndLAFUX1kXkDtm46ScX4JSQrxccMGx5lY=
X-Gm-Gg: AYBFou2m9WdjeuASjpP++k14osZrwo9t65Yiw3a9/3g3auCIMu9J8vVUidnIiP5zZCx
	/aawHfxEezuCwPDxPZp/GFrOXTU4aX+PkII6hb52s+upmlzDH1x899Fv67HyNHM19q/z0RcF0ia
	Ej+Vx7yFyTo7XRLSNdVDQ0XqdSPmzWdYvd6Ex5ucXz5IX0oRi3hdg9EAQMSuKOwolaVTdGtjllE
	ceyZ21YGitQj0mLnUdmie1C+YqhL8P+Op371oLfOC+xWDrKMPuF/YxrtO7HkZY3qsk1ymzzUPFS
	rNc8Ye+eA8W+KYzCBRgOU3mbcyr+UlFtgi9R9Qx92RXiGaGdqAy2ZbwFN9COMy4JYdoOMH+ySxs
	H0FBrekjWySNbMj5STe3NU80AFzH+qNyMmO3ASbpwfSiA7iHiN5bzMnuCfT3a9jNiw4FRVuy9tK
	W7Lks0KOLs3iWxo7z2Id8JaJ1fos8aQswPIRtvDgUSCDa5FCb+HhOJArnahCF7Wrl9xIoyP1Mpy
	iRd/RnIMELg7Q8f2Hm6AVcZ2RZQQGLwKUuNB9HYUrWETHDTPzZEtssDbW56Rw==
X-Received: by 2002:a05:6000:40dc:b0:487:ff2:12f4 with SMTP id ffacd0b85a97d-488717781c4mr25081476f8f.40.1790613979245;
        Mon, 28 Sep 2026 09:46:19 -0700 (PDT)
Received: from localhost (p200300f65f19a90433f74747aea68541.dip0.t-ipconnect.de. [2003:f6:5f19:a904:33f7:4747:aea6:8541])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4887a3625ccsm30486585f8f.22.2026.09.28.09.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:46:18 -0700 (PDT)
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
Subject: [PATCH v3 2/3] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
Date: Mon, 28 Sep 2026 18:46:03 +0200
Message-ID:  <a92a69151266129e20abc4a8ec543d4f4438324e.1790612298.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6161; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=UXYAvC32LCckhRQVeoGZ6q1PHOfqqS7yacmTUDqFKNY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqupnOsZGCdwOP/36prQI52IMHUcizIzASEtonB SwwHoljC4qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarqZzgAKCRCPgPtYfRL+ TgxgB/0QjXNC/MCC7hgAvjxBa3u+FMMQ/chG9YCPUXb/o57CndXZwSK1BIWcDSDWwcLCE/EF4Nk mZIoeLoIal4Fp1qWpi3ScFQ/jdQ8dgfxSE4RjyOkmhZNNa6WqLPdWDYC5BzJ9QckcaG2uEe4yat DJuJZVW25g1GpPqRAuYBf/O9rvMHH5UtRoSLB8T9agi5hXJRrgB0KktwIuO93QPhuU4/eq8kesv wUiDA+iunisyja/G5dqfNiu8EUnVOxrcVl63MAWSfOM8Vxfw2nDZTjGYP7ABjZf/PoM2tLZe1W2 C8Ei5EkcESpwY/VEmv5bs5CjjZRggqEg1JBkDSpneOx/cTro
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
userspace manually messes with devices and drivers") introduced a taint
for usage of bind/unbind sysfs files that manually trigger driver probe
and remove respectively.

For drivers that do their resource management correctly (which is also
needed for module unloading) bind and unbind for matching devices are
not critical operations. The thing that makes bind and unbind unsafe is
that drivers can be forced on devices that originally don't match using
driver_override. The result is that e.g. of_device_get_match_data()
returns NULL despite all .of_match_table entries having a non-NULL
.driver_data member which yields a NULL pointer exception for several
drivers. And given that after setting a driver_override a manual bind is
only one way a driver can be bound to an unexpected device, a separate
taint for such an override is justified.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel.org/
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/admin-guide/tainted-kernels.rst |  6 +++++-
 include/linux/device.h                        | 11 +++++++++--
 include/linux/panic.h                         |  3 ++-
 include/trace/events/module.h                 |  3 ++-
 kernel/panic.c                                |  3 ++-
 tools/debugging/kernel-chktaint               |  8 ++++++++
 6 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index a208811ad525..9ccac96b1f75 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
 script, but if you need something quick you can use this shell command to check
 which bits are set::
 
-	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
+	$ for i in $(seq 0 21); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
 
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -103,6 +103,7 @@ Bit  Log  Number   Reason that got the kernel tainted
  18  _/N   262144  an in-kernel test has been run
  19  _/J   524288  userspace used a mutating debug operation in fwctl
  20  _/Y  1048576  device was manually bound or unbound from a driver
+ 21  _/Z  2097152  a driver was forced on a non-matching device
 ===  ===  =======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -193,3 +194,6 @@ More detailed explanation for tainting
 
  20) ``Y`` If userspace wrote to the `bind` or `unbind` sysfs files and
      successfully bound or removed a device from a driver.
+
+ 21) ``Z`` If userspace wrote to a `driver_override` sysfs file opening the gate
+     for unexpected driver binding.
diff --git a/include/linux/device.h b/include/linux/device.h
index 879eb758b5ee..4dac5e09b74c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -905,8 +905,15 @@ static inline int device_match_driver_override(struct device *dev,
 					       const struct device_driver *drv)
 {
 	guard(spinlock)(&dev->driver_override.lock);
-	if (dev->driver_override.name)
-		return !strcmp(dev->driver_override.name, drv->name);
+	if (dev->driver_override.name) {
+		int ret = !strcmp(dev->driver_override.name, drv->name);
+
+		if (ret > 0)
+			add_taint_module(drv->owner,
+					 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
+
+		return ret;
+	}
 	return -1;
 }
 
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 23976b1dfdb6..e6e24d8afcf7 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -90,7 +90,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_TEST			18
 #define TAINT_FWCTL			19
 #define TAINT_FORCED_BIND		20
-#define TAINT_FLAGS_COUNT		21
+#define TAINT_DRIVER_OVERRIDE		21
+#define TAINT_FLAGS_COUNT		22
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/include/trace/events/module.h b/include/trace/events/module.h
index 19df3e39bba4..c7cdb1f53bc6 100644
--- a/include/trace/events/module.h
+++ b/include/trace/events/module.h
@@ -27,7 +27,8 @@ struct module;
 	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
 	{ (1UL << TAINT_CRAP),			"C" },		\
 	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
-	{ (1UL << TAINT_FORCED_BIND),		"Y" })
+	{ (1UL << TAINT_FORCED_BIND),		"Y" },		\
+	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
 
 TRACE_EVENT(module_load,
 
diff --git a/kernel/panic.c b/kernel/panic.c
index b824b68fcb08..a5d8743df496 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -826,6 +826,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(TEST,			'N', ' '),
 	TAINT_FLAG(FWCTL,			'J', ' '),
 	TAINT_FLAG(FORCED_BIND,			'Y', ' '),
+	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
 };
 
 #undef TAINT_FLAG
@@ -862,7 +863,7 @@ static void print_tainted_seq(struct seq_buf *s, bool verbose)
  * exact size is allocated dynamically; the initial buffer remains
  * as a fallback if allocation fails.
  *
- * The verbose taint string currently requires up to 344 characters.
+ * The verbose taint string currently requires up to 365 characters.
  */
 #define INIT_TAINT_BUF_MAX 370
 
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index d8628be37214..14d8febd6b16 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -219,6 +219,14 @@ else
 	addout "Y"
 	echo " * device was manually bound or unbound from a driver (#20)"
 fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "Z"
+	echo " * a driver was forced on a non-matching device (#21)"
+fi
 echo "Raw taint value as int/string: $taint/'$out'"
 
 # report on any tainted loadable modules
-- 
2.47.3

