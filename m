Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4F3C344F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309872; cv=none; b=BPar9rLnWg8EaePoaFJ8CMMpgCkuDOfqZSItefaCAw7a8oSpnOwGrJWfSLfOFS+YLaSHcG6Q+pDTcy59uPAFcSXhO0aFI2uaBJzREiBmf8D9fzUg07mUkSEpHSkyeCihcrgGKipk6vFrR1VPfjwxqfenEWSMwLxj0bidJyawDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309872; c=relaxed/simple;
	bh=nAUS3G3ePSgJTCurwLZklAEdq9FSoOxVlxZL3wKzHh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyAd+vRXf8Scs4yExsFV1fcYulBOIuml+YHHYIjmF/4tNZGVqO5fMEECcbupL5k+9+POdUCwxy2wxsrfVrDC6HkOQyM1CbLGTxiOmsj+Tvgnlt8XqfxRIwQXBi9hE2CV7p2NZqtrNv+I/hyz7Bt9s46STsDgJdR/jNCsd89TvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eorr51LJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eorr51LJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439bcec8613so655873f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309865; x=1773914665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq+BNITtc6p+HH6jh9NI7lkPW1WCKPvQbV7cZpOCkHI=;
        b=eorr51LJ/amQqIc7WsBmHe2J8VmGH6YlOTZGiOhQsNXzd7ovP4ePbTOIEpMRq5CTj4
         AUxT19oCSAZ985fKaZo3oqX/WzDE8vMiLnU6zG3fVJCci2A0W/IWSdo8NGVaTloUa/O7
         JTWfChmQJKcCpEUJVdgahr6WENEcA7DZwX48ThC4Ssq+Rf0ecs6K0KrwUhiYeyc6k4nF
         9RMYt+Ft+bSfO/Xetsh8nPpJLYeLNx8DGiQBqeTOBJu3TOxU2uSDBpDHLrLBz2BFsWZW
         tYruF1xmXRMEyMNu028i+jNWC/+8+OpTS8bEuUrk5ixGaJrWDr5fSX7ikUZ2f7JxxmTN
         OoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309865; x=1773914665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sq+BNITtc6p+HH6jh9NI7lkPW1WCKPvQbV7cZpOCkHI=;
        b=PfUKpC2FRVkqpWrpx5wURBMG86QaM+IgLk4p2HklC3rjds9woel9cIEbo3Yu757L5j
         0+crwkpsTUl+Ei+ap1tO+yY2IKfsRcK6KtaRnagyFmRyM7vj8BcDbvPpPyeWQm8IZj0F
         yR1Il62sj5Wa7YYxx3SaXouLQLGnXxEGwXTjZr5LvvegxY9FZBoX25/8dLS0SKW+l14/
         NEIkc/NI8NRVcRug3WMzFORbjkk3VKH/AxbsXFrDqxBLpP2GZJa7rD62reofC9Y52vbU
         dCGVa2gJmMiQANUBsvPzCL8kZW1g5RwMxFZ3qLFxyK3Cxszhm9UMF+yB6Z9OD3wagy45
         sdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxw4XGVQqR0Qaj+E0hTr7PO3csAlGzGYcmaepQr3hnZWHZCLs5YjTQWELURGUNVefrEWJnlyejJxC4S5l2murMmMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWT+WjCL5obr9RjhPideJgabTTE8F3kaDybZUZDrQDAyt1w0F
	F/QJeW/tknaxYEzmOcQhQKaPkNkrDXWT234H3rRpO46NswNrDQXJVJqlXGfpas4GRek=
X-Gm-Gg: ATEYQzwGSDbqf67WvWKeTe/2qHEJS7XdqVPgN4joqae2czUhvRR7keRRiFIAopHr5YS
	thy5OrOtsmPCof3SQuNVURUCmny2XCHgp4J/gvizRQJD0SzUjH5jALkcPhOswGwOVAy+6BT2YVR
	LZfKgPHLM+lSQvWzD38btdBI1ewvIAFXlXyWDRY8CadFiBQ49C9Z7axewdB5MZ+VmPGUoBQAS+t
	/2VSDufoMUA0b9ccItaONhjLeymibd0r1iOx1tO68jZaX9pQ3gLWLadfa/yrsf35KbkxBvLOxQw
	xdj9gXGbvOqyILDpnDJyNfYHUDJfGkxlyvEu8UKr8v4WFfKaWaGecq/cd9e2hRNLfx3iL9Xnnsk
	/r3G50rGdK6pR+HetiQeYOTXbQFlFkR9AG2koHR7RZpavbPpU+dBsdStj5rwSOK7mcSpuII8KCI
	jzeRtBEuQxCSUexIWGlpazTCSb
X-Received: by 2002:a05:6000:1acb:b0:439:ad2d:99f7 with SMTP id ffacd0b85a97d-439f821a221mr10260693f8f.28.1773309864988;
        Thu, 12 Mar 2026 03:04:24 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2187aasm6340802f8f.30.2026.03.12.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:24 -0700 (PDT)
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
Subject: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Thu, 12 Mar 2026 11:04:07 +0100
Message-ID: <20260312100407.551173-14-jiri@resnulli.us>
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

Use the previously introduced shared devlink infrastructure to create
a shared devlink instance for mlx5 PFs that reside on the same physical
chip. The shared instance is identified by the chip's serial number
extracted from PCI VPD (V3 keyword, with fallback to serial number
for older devices).

Each PF that probes calls mlx5_shd_init() which extracts the chip serial
number and uses devlink_shd_get() to get or create the shared instance.
When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
to release the reference. The shared instance is automatically destroyed
when the last PF is removed.

Make the PF devlink instances nested in this shared devlink instance,
allowing userspace to identify which PFs belong to the same physical
chip.

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
- removed "const" from "sn"
- passing driver pointer to devlink_shd_get()
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
 include/linux/mlx5/driver.h                   |  1 +
 5 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 8ffa286a18f5..d39fe9c4a87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index fdc3ba20912e..1c35c3fc3bb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(dev->shd, devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..bc33f95302df
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/driver.h>
+#include <net/devlink.h>
+
+#include "sh_devlink.h"
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct devlink *devlink;
+	char *sn, *end;
+	int start;
+	int err;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
+		if (start < 0)
+			return -ENOENT;
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn)
+		return -ENOMEM;
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	/* Get or create shared devlink instance */
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
+	kfree(sn);
+	if (!devlink)
+		return -ENOMEM;
+
+	dev->shd = devlink;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+
+	devlink_shd_put(dev->shd);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..8ab8d6940227
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+#include <linux/mlx5/driver.h>
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04dcd09f7517..1268fcf35ec7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -798,6 +798,7 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	struct devlink *shd;
 };
 
 struct mlx5_db {
-- 
2.51.1

