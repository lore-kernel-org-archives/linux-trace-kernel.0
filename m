Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C84375AC6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309853; cv=none; b=tOhDaTX+94PIzjYVBdGo3VO3CzwfKkUsQ1a7S3ep51hjUUA52+viKaexNHVR5a1HFYLIXnXXWa6t4KJ1Zc3R8HS5iiTq25ayiZOAwN35szwcyb9+T0vncu0WKugn77ORvf1GlKJ7/B/3SAYOsFPz3aWQIvNmFZ/FMuUBFaq6ejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309853; c=relaxed/simple;
	bh=6VISSpzlZznNj9au7o+yMu5s+elbPaZGvkqibf2jiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+j6sJFV5ZijsZMZHsvY9dHkgLTnxZ7i8JEHHXRTer3s/PmxEhZpm9pJ1HtQqeghS426bA/mHeap6IvC2dI0C8U0Z/g8GpQymCnApzXymyRIg7NtvVCoXx4cK+NrpBA3Ib8KGbotOq3wtfx8EIZBPAMdU6VJxaEZdg+aglhIfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GNOlJrt4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GNOlJrt4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so6517715e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309848; x=1773914648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyRQtY5fUA7eA4hQxNQZFrII39g5Q1jSYxzqSfKvGA8=;
        b=GNOlJrt47uGW7S28r6cV9gLG1PD6OhoDYrZMB02dqPGuXvVUjSJDTLA3pjnHz+kMdt
         eXTz/9O9g5Gm975t/iye6AslQbT/ga/tkGY6FUDk2UY6y/lvD4ZFXHN+KsrAU7wUICyE
         WmDPefMpZbE4i3wlhDeDDvPzLfkG1sC7Id+LQDwEK2eSOOIiGbrMmGT+bpJ6yraaKftL
         DsX0UYXqPqHUV4jiW1E0yBOVlgn791GBd8ssoTFnnFtjUlRBw7+vfhiPcs3cEgXlcYgZ
         /MJoDMMSXRyn89Gtnfyd2kpIOf5Ix2uKKV7mGrgKCrmXTsu4aG3zngfmtzFCEKgo4Lh8
         9osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309848; x=1773914648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyRQtY5fUA7eA4hQxNQZFrII39g5Q1jSYxzqSfKvGA8=;
        b=j0yBmXmHP/hECagwgDiKFi9dJPMoTZ2JTuFQLoPH4cN+dG3+DVAURO51Q0WJQ83l+u
         ezDFiSjyTn4DjvCTUlmhhMPY1/2yRWRbqNvYVUE6+nzUxfE60ut9P69yF9ZvGHIpm8vX
         /tDAyLCB6L/XI4gVPp1rd6shIIqceQneTac6xvdB0MB7hJ34UNDkDOSD+1RNnqcpJHbV
         WJPwvvuqxx2IDFNbM2A2c7NYtkeLaJKp1BNbQaGnH7fDslqxQ0UjWBu45qX6UFbx8Rte
         /QUbV0vjf+RbQv0A3349VpKgnoiQn2FJD7pOYkT+SH4Nl1bH1ZclybMhApWdYRKOJdkG
         QooQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtcldlcAeLJjpyjdGBCp8VxQcHww/18enYYxEepdhaDFiBkLcSSzaDcIxdSzEsFD30GQlozqpTEieyqQ0d0Z8wqrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/NMu0ACMBHkKfWgNYwhFZb67RPjGHZIju2W/qholMKGisCHR
	tg1V/a0sN5Arfic3SzUgsHLyLdGhVVKu0V9L1YTYoveTdFPkfS/2jw4xBwAwlKabRDo=
X-Gm-Gg: ATEYQzzpyFtfXoAuEE0rzrbt9xWYXqQNAZiX9ebDEv6yDtTm6E7U6wdXBA3PrvwGmKP
	sZpOl2mRPHQviK/OBWrwesh+gm7gJwV34n633DlJWL+/o/fYPLJwBOzeGmHyrKiRimFTRc07QS9
	p+mbGr3t5nExtbDdn+5Rqn3mt55I4aLsMdtkv+qaU4kSODL4pY9pQgPzdA34OUX6qfENGzA/RHV
	j6jUK32fniRnfEaM9F2lhwuUzfq2AbtB8gbAgihoW+rx0GCDKWvDwA/Y0mknUQuxT0cd0/bLvbM
	PVClEstSBfjAi3+TVdeLVMasrZDrLjsUHICpGPwt/9h0H+IqQRwUbwr776P7oKPz91FvwsmnEWi
	RAR2fauts6SClnQvtShK+xi9bOTwiiRYoqAlIBKo9xfbbit/AJpc6UqXE+sYFn85i+Wx7E9qxgW
	CSOZgihKLx1eIo8A==
X-Received: by 2002:a05:600c:3103:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4854b0acb1amr86891245e9.5.1773309848490;
        Thu, 12 Mar 2026 03:04:08 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e92d5sm117363925e9.1.2026.03.12.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:08 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Thu, 12 Mar 2026 11:03:54 +0100
Message-ID: <20260312100407.551173-1-jiri@resnulli.us>
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

 Documentation/netlink/specs/devlink.yaml      |  58 +++
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
 net/devlink/netlink.c                         |  52 ++-
 net/devlink/netlink_gen.c                     | 355 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 161 ++++++++
 19 files changed, 815 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1

