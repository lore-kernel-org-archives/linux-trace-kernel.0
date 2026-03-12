Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416B3BFE2E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309868; cv=none; b=uQXZge4zCznKvt2lALIHYKBpvm3ssftcheyx+OkK5eGJzzDANL1tsfzSapJT84G+Bddtpt5p+N7+7hgT3mEBOLVChPj912ny7Asa6Hv7wNb4od8G1+bQShTryO0wMxWw081A1ZyetPnlgEGVdaXvUsDS5tIryAsMCdY6schlEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309868; c=relaxed/simple;
	bh=iIEcsOfgyoQwnVxTEoJrOmuXhZRHf4VmCFe2BWfUG0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7iOsUbNKXy/w1kZdlodwoLwS++iRCbmQZXJOULgOAVEil4sTbCCawAe1GQ9Hdik1/8Py3DTo+gv+OCFtiTffFGd5tlVB192nh92/i8HCHHkjWTO+/fPzaZsKiqLSeCA49gp1Xew/1GwKpFMiJxmyueiWOiLxVk0s/X1ugzRC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p4qXcriz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p4qXcriz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso857850f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309862; x=1773914662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNmgU9ASHSR7+2H948CyENoisRrq7nchFqcl7cGshyU=;
        b=p4qXcrizbc6G2Z9tHRwWnuwJT+obkSovVWOSdtscybGuXc0WP2kvz4f82MFrWjI72Y
         cznDO1U9Aum8+QuTute2P12Sm+CPGur8BDSU11q7FYhnxqqiAnscYxLasRm5UkgwnqoE
         ec+A3ApTDzcG9zOQao52nIumNk4WNkZI9vO6uvjuQzmMYHOgo8CjB1nHkP4iixZwslAa
         Ehp269dqV2Kc5cNQbq/RU5SdC3hxZyMNnJOqqb762+TubTy3YbuUREdV8S62+3aHpuxZ
         Y+4C1EYe9u2/TOo0RXVobTdO01bcyFC9xvG/QA5rhU5gMufyidAFlp2nnXHmShnR42tD
         fK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309862; x=1773914662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNmgU9ASHSR7+2H948CyENoisRrq7nchFqcl7cGshyU=;
        b=H8o2/fwX4hs7WhiRUJEi32mu6o93rNCdaCpbs/BmORRxdbVqKTv+JmCNl7x3BaQgL4
         iIgXMRpTDJq2AF0PYNZLEfQ2McW44K0TrBhkE2zm2vz0Ze81RFJ/3fZ6B7F+AASj43zp
         2OiTSSY6yMY2nFB8T54YTWb/EozBvAYsQk+ZEEdYVOAro7SqWVJ5DhOBXkxygtyMjyED
         +faw8rAbXcFwhtjFBcICddJjEuGHCNq+d5d5beA8AuHrqomFjYZwLMSMdalHrgV6fk1O
         86MYvov5nyUYCmBnZfXMw8ZwwMOV5yPPvkwZrQarjaaWq8ESKpbRmtFw2Tsn7sMrWZlP
         z2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzw2wywAmLlUkzMxz8RWdtS37T0pNOllfo91HosIvhuQxDdxzdh0NYoT7yXGhMtug7ynuMC5sxyYn/sni0xCY9VYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/97D5y19Y9NRxFvfRmxMxukgO+u2/rNzG80gmBgXQ9RwpjQ7
	pTCSehP9BoSb/eZEEkeGhBRyh+zta4dV+kmkg6oNGi0G2xNnzZgHuAMmRtym+Sh9844=
X-Gm-Gg: ATEYQzx8C3zzpL8naDdXy4fz3TXVCkJOvPTDeUcB6duuuRkdIKtomIX+p5V/4tD1V70
	BfMvoTHYUPyTEUYMteq2YVKlHJ2elsoN0HThSbWYVjqsB/NG9kyog4fyyHQISD7udDyf+5pcTdd
	2ROoWUmKTCtERjjvPq8oR4OwYrhJQlsGJA8QpJnQ9Ir6W20bWt88L42McUEBiq5J3iHykFq4T8K
	XUETP57qRPvp9wN5u3o0P8QHMg0lis+oJkQchA9ycXnhym5q6jjJwq+lmQxUhJgm4d6Ug3dxDmv
	V2NgfANGsZfAISN05Yk/MvNgtPiD5qDdS1Bo36ZLBdEEdW8L7TJV83pfU8EOmz8MUyYeRggenni
	LSZ86gDUmI5ZWftoRjSM3HwSJSv1KgbYV6hayhWyztA7ISLszITYh+6kZBAjUex2GSmx6JCmzhA
	LZ76hTrdleSQs/lIhOrou6ztdG
X-Received: by 2002:a05:6000:26d1:b0:439:c42f:10c4 with SMTP id ffacd0b85a97d-439f81c62cdmr10602715f8f.15.1773309862181;
        Thu, 12 Mar 2026 03:04:22 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b899sm7312555f8f.23.2026.03.12.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:21 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 11/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Thu, 12 Mar 2026 11:04:05 +0100
Message-ID: <20260312100407.551173-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is no good object to pin the configuration
knobs on.

Introduce a shared devlink instance, instantiated upon probe of
the first PF and removed during remove of the last PF. The shared
devlink instance is not backed by any device device, as there is
no PCI device related to it.

The implementation uses reference counting to manage the lifecycle:
each PF that probes calls devlink_shd_get() to get or create
the shared instance, and calls devlink_shd_put() when it removes.
The shared instance is automatically destroyed when the last PF removes.

Example:

pci/0000:08:00.0: index 0
  nested_devlink:
    auxiliary/mlx5_core.eth.0
devlink_index/1: index 1
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0: index 2
pci/0000:08:00.1: index 3
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1: index 4

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- added __counter_by() for priv
- added *driver arg to devlink_shd_get()
- added ops, priv_size and driver pointer consistency check
v1->v2:
- s/err_kstrdup_id/err_devlink_free/
- fixed kernel-doc comment of devlink_shd_get()
- removed NULL arg check in devlink_shd_get/put()
---
 include/net/devlink.h |   7 ++
 net/devlink/Makefile  |   2 +-
 net/devlink/sh_dev.c  | 161 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/sh_dev.c

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 45dec7067a8e..3038af6ec017 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1647,6 +1647,13 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size,
+				const struct device_driver *driver);
+void devlink_shd_put(struct devlink *devlink);
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a..8f2adb5e5836 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
new file mode 100644
index 000000000000..85acce97e788
--- /dev/null
+++ b/net/devlink/sh_dev.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <net/devlink.h>
+
+#include "devl_internal.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created per identifier (e.g., serial number).
+ */
+struct devlink_shd {
+	struct list_head list; /* Node in shd list */
+	const char *id; /* Identifier string (e.g., serial number) */
+	refcount_t refcount; /* Reference count */
+	size_t priv_size; /* Size of driver private data */
+	char priv[] __aligned(NETDEV_ALIGN) __counted_by(priv_size);
+};
+
+static struct devlink_shd *devlink_shd_lookup(const char *id)
+{
+	struct devlink_shd *shd;
+
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->id, id))
+			return shd;
+	}
+
+	return NULL;
+}
+
+static struct devlink_shd *devlink_shd_create(const char *id,
+					      const struct devlink_ops *ops,
+					      size_t priv_size,
+					      const struct device_driver *driver)
+{
+	struct devlink_shd *shd;
+	struct devlink *devlink;
+
+	devlink = __devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
+				  &init_net, NULL, driver);
+	if (!devlink)
+		return NULL;
+	shd = devlink_priv(devlink);
+
+	shd->id = kstrdup(id, GFP_KERNEL);
+	if (!shd->id)
+		goto err_devlink_free;
+	shd->priv_size = priv_size;
+	refcount_set(&shd->refcount, 1);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+
+	list_add_tail(&shd->list, &shd_list);
+
+	return shd;
+
+err_devlink_free:
+	devlink_free(devlink);
+	return NULL;
+}
+
+static void devlink_shd_destroy(struct devlink_shd *shd)
+{
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	list_del(&shd->list);
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+	devlink_free(devlink);
+}
+
+/**
+ * devlink_shd_get - Get or create a shared devlink instance
+ * @id: Identifier string (e.g., serial number) for the shared instance
+ * @ops: Devlink operations structure
+ * @priv_size: Size of private data structure
+ * @driver: Driver associated with the shared devlink instance
+ *
+ * Get an existing shared devlink instance identified by @id, or create
+ * a new one if it doesn't exist. Return the devlink instance with a
+ * reference held. The caller must call devlink_shd_put() when done.
+ *
+ * All callers sharing the same @id must pass identical @ops, @priv_size
+ * and @driver. A mismatch triggers a warning and returns NULL.
+ *
+ * Return: Pointer to the shared devlink instance on success,
+ *         NULL on failure
+ */
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size,
+				const struct device_driver *driver)
+{
+	struct devlink *devlink;
+	struct devlink_shd *shd;
+
+	mutex_lock(&shd_mutex);
+
+	shd = devlink_shd_lookup(id);
+	if (!shd) {
+		shd = devlink_shd_create(id, ops, priv_size, driver);
+		goto unlock;
+	}
+
+	devlink = priv_to_devlink(shd);
+	if (WARN_ON_ONCE(devlink->ops != ops ||
+			 shd->priv_size != priv_size ||
+			 devlink->dev_driver != driver)) {
+		shd = NULL;
+		goto unlock;
+	}
+	refcount_inc(&shd->refcount);
+
+unlock:
+	mutex_unlock(&shd_mutex);
+	return shd ? priv_to_devlink(shd) : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get);
+
+/**
+ * devlink_shd_put - Release a reference on a shared devlink instance
+ * @devlink: Shared devlink instance
+ *
+ * Release a reference on a shared devlink instance obtained via
+ * devlink_shd_get().
+ */
+void devlink_shd_put(struct devlink *devlink)
+{
+	struct devlink_shd *shd;
+
+	mutex_lock(&shd_mutex);
+	shd = devlink_priv(devlink);
+	if (refcount_dec_and_test(&shd->refcount))
+		devlink_shd_destroy(shd);
+	mutex_unlock(&shd_mutex);
+}
+EXPORT_SYMBOL_GPL(devlink_shd_put);
+
+/**
+ * devlink_shd_get_priv - Get private data from shared devlink instance
+ * @devlink: Devlink instance
+ *
+ * Returns a pointer to the driver's private data structure within
+ * the shared devlink instance.
+ *
+ * Return: Pointer to private data
+ */
+void *devlink_shd_get_priv(struct devlink *devlink)
+{
+	struct devlink_shd *shd = devlink_priv(devlink);
+
+	return shd->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.51.1

