Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977435E93F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640051; cv=none; b=SGweCkZsi3ZGTh00zmiKYl19ji9lXVhD3s6AarOsYcjBy+HC+SSTF2w9QXlp9owrGnBRe7S9sU7biSZ9+Ds569pHRDFcPJ4XBSflQjnLojiEd7fh90sPi0NEYKVp4QD/nMYwMNltBI1j4/KLx84zWKbM5eeituaCG5wrx/f1IF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640051; c=relaxed/simple;
	bh=iIEcsOfgyoQwnVxTEoJrOmuXhZRHf4VmCFe2BWfUG0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5a5oF5dpKOFv0kVHC45BwVKuSxnqc63BNCTkdy+7KjhOC0MoJvxfbhNknzZCMVvk5rG5eYw5X884RK/seoq/UpXv4iPBORWHM2z3vKEeBmue57bUFvAP1fIO0MMKy8gigUHnfRlLXiHsBGzyOOkQk9VWSPsDH4vkCKbDwE+ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ftkhT3Oe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ftkhT3Oe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48379a42f76so58898405e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640048; x=1773244848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNmgU9ASHSR7+2H948CyENoisRrq7nchFqcl7cGshyU=;
        b=ftkhT3OeFhHAf33owxf/YhwRgMLICzVeqazvpP0QrPLaQ3gtmOhem7gNfNfgDo0H56
         19VKp4IAF6XLvhNEmudreQw790iu2yWFhko3uc6sUicgjhxLcxKNC3RLyK4+X2ymlof/
         +vm4OdFV6KHo3lCUvMgu/DoqT3DfV4+FBIhcKdMYVVap/zy4/zdUtKMJWVJiBqQXyqdz
         CuvriifmyubbbbRbqih895MJZiHYoN6EmSWAnEk379SFYq6/tTaUmxrgmwlsWvR3jUnl
         34dDqWa48zo+qJq0Yw1I5QyXOOqPiAubD+9GVLpfJlixGpAmhptUvre3yXa09tgwZqf6
         /oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640048; x=1773244848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNmgU9ASHSR7+2H948CyENoisRrq7nchFqcl7cGshyU=;
        b=JZ2pTVTs/5am2cMN6nHVgEpa5juY/Wrx/v9viLrZkzO6piP57pmJzypDFA7DA3rfMM
         EzEEiS4W375iEi+2/8Fo3wAqiDfsIWpX5QI4S6l73HXbn3yK97EdJC+kucvrN1CIrBts
         4/C70E6OIAyLquwTQ+M97ltAaQUzEQ4363xvookc+OFGsMVcRfnD1uAaoWLW2agtNS/k
         DYJA4MmdACdT+MSov260oxEwHdcOyQsKXLSB2PWzbmeO2gCtPfju3TuuCIAQpcTo3Hi2
         Nc7C1L+Pe5hH4+fXVlPeH5OH2hpSd8EdJdkIFW29v8v5jbmei1jnKcni6qIzw3GG+rGM
         JQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO0wBRlBbLICHxurzEzbivfHhqWWcaBmfOaRyAIlyHj7QrzsJ4kzDpBdQOj+6FxLPo1wqQVmrfnrF3WYL2m1olwQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFGegMatUn4fv5zhzgwxv+iETx6aTwiGQOmQGxFiNv0F8JGaA
	Rrum7qOQ22+8DOwWzjEwCZuP2bNB8BsmNBzxGjsUHykwtdApJiitN7ViySBy06jHfdM=
X-Gm-Gg: ATEYQzxMbx4bl5T7CeO3q0KI/GyML+sDsfHqWTahPmoxdBskDMizXEupbRwuUrHNLdf
	A8kZ0KssuXQtl4d8agMGALX1xkl5n5bQ0Y8Pg0ORLknLwNs/TtXeYWHbRcmOf72j1V1MBt6Dm1E
	bVUUGC8ZjzyRj0y0Ag1d+yuGg9F6V22XzE1DUn3zDfwTVti7DCK3LIdtwph9b2CKp7Hi8BSMEYW
	AMPVVYWXGDgeifIZxKoS7/Fc4AYJxe3OIuXQt3PAjegdl10cizZVJ0ckla6yflOyF8TLkvWQSED
	dYr3X3fyTFtGSU1RDcinpJsfNO3sZww/kKtK2T408cU2qaMbE1Iyc0Orw3r2/8nNOzhN6wVybyk
	ZfxVPgRfZrLVD/P3ii/keimfV5GvH5MngIThlsKNScgcRRTr9wiTiobziJDMCTvwofymQJObKd3
	Y98IDXNVcUMPbf1a8OMJhDuwGyPMSJE9hqHokVR/TNLiZFtw==
X-Received: by 2002:a05:600c:620f:b0:47d:885d:d2ff with SMTP id 5b1f17b1804b1-4851989f6bemr42106725e9.29.1772640047786;
        Wed, 04 Mar 2026 08:00:47 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187b7851sm104855645e9.3.2026.03.04.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:47 -0800 (PST)
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
Subject: [PATCH net-next v3 11/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed,  4 Mar 2026 17:00:20 +0100
Message-ID: <20260304160022.6114-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
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

