Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F934C9AD
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640030; cv=none; b=K/l2Ma4y3VjCnLaNQIeMoViN80JxyG+pykG03z23XzdbOHEjg06gzsjXoapZPlwJ7mTHtn+akkm/UHUzmXej/NSW2re7NM7GVOMxKOBTD8Eu6i9H6GVYaGJHnDAlFfoDo5zxdPeCjFD1zMIrJRcJbisRfkSE57mJbeQfXsxy+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640030; c=relaxed/simple;
	bh=KEeOkJm0EmRV6jqNyOAEXWp0ZZ6RYVxsvyRyrfSxNkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFoalhqsoOhbcQySWJvsA/8V+yIGSFA+GtzAgYjy4BBH2Al3UkdaxpWvYN7+FCbGJnD/sCoc71t0FCxMt5quIdE4JAvnLrLZdQAEbsxcCtVg2m2g1ULtUbA7mIQaNzmhXfGs9usLqurXSVg0OlyOfjm0eOMDKddKmFYF3Qxr3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IGxS4qVu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IGxS4qVu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439c6fc2910so699550f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640025; x=1773244825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OU95bHZuJNtP/VAPwIGit/Pa+QghFNKlhnRH3cB9CJ4=;
        b=IGxS4qVuGVB6ooSFrgfLPbkfALb0ex4ep8cdG7ROwi1Hg+ZbwYXU6KMOfoW6Xd+Ehk
         QTv5gwAKX4qmvsXMcu1w84NJvl/2i/46rktxrKqu5BY7LvGd/MhO8cnWicAa7wLsoEVl
         6qCG/RgEMQPYUdyWvSN3wxY1l37FC+grgQKIlDI/MwiRh5Uxu6aqG9mnAKw4gCmTQHwf
         x0KlDbch2jXuHkGQyd5VQGMQsgdugtR718PY2w/NODfxNvtRp7uF2ZZgSXuWrGRq/o33
         4wBLaBCQKJ4J4BzSXhWLpLNd1tRUC4FGhyli0YXa7QAhn3+Ym7bvxh+2sFiGZfMFvns4
         w5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640025; x=1773244825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU95bHZuJNtP/VAPwIGit/Pa+QghFNKlhnRH3cB9CJ4=;
        b=eN4ZUpvdISg+BFobZuebo62qu9gzRIOOPprDRaSkSImfbG8a4j0b3p68Z9lOLjv7kJ
         J8iELErNeqfUWO6mWcsjSwdnmRgIBPKXe8ZD1Xfe9NUWngbU10sdgsBQJdRAmBPSJrJ0
         NQ00dioAEoBV1ySVvHls/FNQtG7gE6Hk4Jp6jEZ3RRsCJogF/budz0sjKzvpSfBU+eSW
         YHnIe464kYnGNCnN+OhGmIEycrLrXPAi8+YhWd18Wwna4TSiF01WPSwPHevqebZdKghs
         u6v4+3nMZvGYyqzi03y+VXBXYpcX7NzxHvjT/4zJlWryRhh25rfPdVGHENEdr6w/qLXy
         DOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtRbjSE5lRRn7IVR+zuqWloUPLoNsordxs67NdE+NBDJd4byBtaqmyciXlfKzPcYCodhMQ2U0i1qE0Zv4w+NuZpQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGylPguUdfcDWCudKQ2xIP2TrGPSuNl61BKBULUyGEpOVjlQD
	7VX9gvon+kbi7h4kRuPMC2ShSUWiTW8/3LWMBrz1XcdbGaNRvdU5nfP4MZpvDnsxPCk=
X-Gm-Gg: ATEYQzz+ufJejPE9EvQoOQsEFEVQe/99hNJx8hcOqpEbtT5HZT2AsAQ5NGVHxN6dzda
	OYA3EMssfRFZSOks2TKB4qWX0YqyvTQxVPNbrM3i8mwpo+LUmoxoN/kyy/bOV59HxVPh/afyNOl
	ZO2P3R8FpN3l/V+U93ErHSJ0X0nlaA7r4DBtU6SDNfCOOJDRqYnfmg2hQo7LlBvYoQs1ZRTv6/v
	Ye8tNTFPdreTLxbrMU3isuLJ1HzFefgrnaxnv3J8emfNFcuHbb6zz4JVm2WyBWcmqb6unfuhlww
	7iQ3RVE7qA27JMoD6MWMP2jiGqNBZnITb6Z+RH50PUPXaoYfEoQl9iAEY3gnL/ac88rKLhFDENG
	KoUFQG+u5i+UPX+e5EJLJXuiGkAP+df0uIxfkisbq+7E7nzUhSukrrHgEOm0pPCtdortGpouIlW
	oTkT3VPBEh2AeSy9piSpBn3nC2pNVsIHbkK3h9tzmPsmbUeA==
X-Received: by 2002:a05:6000:1acf:b0:439:b3ff:9ab9 with SMTP id ffacd0b85a97d-439c7ffcb29mr5150381f8f.48.1772640024040;
        Wed, 04 Mar 2026 08:00:24 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b59723fesm25578351f8f.38.2026.03.04.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:23 -0800 (PST)
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
Subject: [PATCH net-next v3 00/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed,  4 Mar 2026 17:00:09 +0100
Message-ID: <20260304160022.6114-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs on a network adapter often reside on the same physical
chip, running a single firmware. Some resources and configurations
are inherently shared among these PFs - PTP clocks, VF group rates,
firmware parameters, and others. Today there is no good object in
the devlink model to attach these chip-wide configuration knobs to.
Drivers resort to workarounds like pinning shared state to PF0 or
maintaining ad-hoc internal structures (e.g., ice_adapter) that are
invisible to userspace.

This problem was discussed extensively starting with Przemek Kitszel's
"whole device devlink instance" RFC for the ice driver [1]. Several
approaches for representing the parent instance were considered:
using a partial PCI BDF as the dev_name (breaks when PFs have different
BDFs in VMs), creating a per-driver bus, using auxiliary devices, or
using faux devices. All of these required a backing struct device for
the parent devlink instance, which does not naturally exist - there is
no PCI device that represents the chip as a whole.

This patchset takes a different approach: allow devlink instances to
exist without any backing struct device. The instance is identified
purely by its internal index, exposed over devlin netlink. This avoids
fabricating fake devices and keeps the devlink handle semantics clean.

The first ten patches prepare the devlink core for device-less
instances by decoupling the handle from the parent device. The last
three introduce the shared devlink infrastructure and its first user
in the mlx5 driver.

Example output showing the shared instance and nesting:

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

[1] https://lore.kernel.org/netdev/20250219164410.35665-1-przemyslaw.kitszel@intel.com/

---
Decoupled from "devlink and mlx5: Support cross-function rate scheduling"
patchset to maintain 15-patches limit.

See individual patches for changelog.

Jiri Pirko (13):
  devlink: expose devlink instance index over netlink
  devlink: add helpers to get bus_name/dev_name
  devlink: avoid extra iterations when found devlink is not registered
  devlink: allow to use devlink index as a command handle
  devlink: support index-based lookup via bus_name/dev_name handle
  devlink: support index-based notification filtering
  devlink: introduce __devlink_alloc() with dev driver pointer
  devlink: add devlink_dev_driver_name() helper and use it in trace
    events
  devlink: add devl_warn() helper and use it in port warnings
  devlink: allow devlink instance allocation without a backing device
  devlink: introduce shared devlink instance for PFs on same chip
  documentation: networking: add shared devlink documentation
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  56 +++
 .../networking/devlink/devlink-shared.rst     |  97 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  61 +++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  12 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  10 +
 include/trace/events/devlink.h                |  36 +-
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  91 ++++-
 net/devlink/dev.c                             |   8 +-
 net/devlink/devl_internal.h                   |  34 +-
 net/devlink/netlink.c                         |  57 ++-
 net/devlink/netlink_gen.c                     | 350 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 161 ++++++++
 19 files changed, 813 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1

