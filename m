Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84A3B9600
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=aOe++wrz4OEsscibTe+wZ56eksCI6Y0s6WSzVMLAlCBVCr3Z7nQSG5NxeIHdpigkxRJB0iJEnis3KFyvRbqiXds9BKpvbI0vrTwKQ+DRuA133d0MeI2K12eYElE/9yX9hfent53V257WBpZrjFgHm1QHwFdSAfbnKo2gIj4vBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=9Xz+6VxPCwoVZU0iO1RTKRbG6dMJCxhC3xLfrYIRCTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBZRm3A3v76tYXr6svEEssNsrdyaBOvaay4x2npx+udjPC5JbxOAgMciEzlGCIpiEVhAVwtMwepUlPvOyZu1wAtHH3p6pWVDhOg0QgyZrZSITlYiX6JLq7mfELXmqF9XTzwJ1+lGmkvViClipIqZUJS7Hpxa7oWbz68sBx6L9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y39Gkj4P; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y39Gkj4P"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43945763558so4305949f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026465; x=1772631265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWW7/I/6Js+wUg3YiqGf7C70f+o6TdnB97onUwiUnHc=;
        b=y39Gkj4PkxQF6Io4z8RqIwVg5bxxFbJxqYQwhSdB8toAtBk7xKMhSe8aM9bL2dUf+f
         ikmhgj7eq/NgjWGfHIzMzmXmNPXkauJyNla8sPh2klQ4RAk+XZ7P1/t2rXqkROVT4hh9
         hl7EMYleQ6kut2Ks6QRAKDeqnOqDekrcPTYnTnrWXERkSJ0fAKcO187aWExzu/EZMEg5
         fozXHhJ5Djxu2ZGbUtlzdmw6/w3O/ee83V+u4FGuen9QHv9Q7Euglfwjum/jtMf8UDfg
         GSyOXrktF68q+kPbUq1VXM0oVzU2dqueotrM5EAIjf2xGGHwdEXwrGHwvMKik4FIYrzU
         NEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026465; x=1772631265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWW7/I/6Js+wUg3YiqGf7C70f+o6TdnB97onUwiUnHc=;
        b=ai0+/txbh5iMNhGEQ1kNEOl279PqRH9DBe4LNeW8OeybgNvuvj6fBKcrXsC7vanSBm
         eYQtvBO1uUgw75m/snUWbKaRnnQPDZP9H9DeuxL9Ng5lPAAdt2gJXQIcM4MG76AdUVPL
         pE1PiRkLwOymzPZehM4ChQOMJa2w6jAHHCIvyDLPZpNwtTHspRRe54tPCR164OSjbEg+
         Th9CToGnyhnawgU6GCWBqmBTl0BgfFZVb5yiy0DFbNnJR1KHAan+dJA8zV4JGBnTccIu
         kkB8JhvectLPxMz8JxNOxEE+XVZ7ydRgmrUwwaW+3aChnC9DWr6AS3Q39YSYROZV9PxV
         R9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUOX1iCX4oqGLY9SMPQgq5ini2Ez/fWOxwQJ92uVKyvegn6Qo/vHvIjEQg+c8AxEoSWk9o8QRT43jm5i/nOyRKRXJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mYykG6bAOKwSC9e71yHH+dCviuYv5VeJdtPk2eOGnj+29+yD
	ZHG17r2/UkbQPuu6rcJBwibpPtpwvsLiNjfgysLMIBL1BrR+M4c3sjxkoglqm+VUwSM=
X-Gm-Gg: ATEYQzxOw1Et0ozzbUY/GUUClMCkHCTnjDX80kqAMWp7ngv1LcIzdNyBJxkirRwg0VM
	SmX0b3GJuYJszplyp3G+fsWv5MA9pYDjmD2iHAjsRJqfOjd6VzuHoqqyXTOuFYCVmNpDY+XSF/0
	NRs65kytoXUHxDwYiPzSyJslnW25CMBqbPSjQ6QkjGZiUWAV+y7gSqi7f2SSx4OoLLNGGvvq7Ge
	gXpt+YJQQ9XFxJQo6RNstY2XPQVyTY5U+MlSvYqn5D6aHbeUB22wCdmMsLxlGosUprN3ebPOufu
	WlquxH+LOLLuUvNSmunDJIE2CeZwZ/bOM6rzUMrYqxQYCWmxY0ejn7MmlcnNjZQRChb6oO5/ti1
	xGRKgFpuQ2hM5Q/V5fcmGRwrLHqno2r1aWy4o4F7VxcKwTTRxRZP+AvUK5QlUh4+lmYUhSsbsRn
	yexjePfdIufOg7GQ==
X-Received: by 2002:a5d:5888:0:b0:436:1951:21f2 with SMTP id ffacd0b85a97d-4396f16e3d7mr27778818f8f.12.1772026463906;
        Wed, 25 Feb 2026 05:34:23 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff6dsm36040237f8f.25.2026.02.25.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:23 -0800 (PST)
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
Subject: [PATCH net-next v2 00/10] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed, 25 Feb 2026 14:34:12 +0100
Message-ID: <20260225133422.290965-1-jiri@resnulli.us>
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

The first seven patches prepare the devlink core for device-less
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

Jiri Pirko (10):
  devlink: expose devlink instance index over netlink
  devlink: store bus_name and dev_name pointers in struct devlink
  devlink: avoid extra iterations when found devlink is not registered
  devlink: allow to use devlink index as a command handle
  devlink: support index-based lookup via bus_name/dev_name handle
  devlink: add devlink_dev_driver_name() helper and use it in trace
    events
  devlink: allow devlink instance allocation without a backing device
  devlink: introduce shared devlink instance for PFs on same chip
  documentation: networking: add shared devlink documentation
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  56 +++
 .../networking/devlink/devlink-shared.rst     |  89 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  62 ++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  12 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |   9 +
 include/trace/events/devlink.h                |  36 +-
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  59 ++-
 net/devlink/dev.c                             |  11 +-
 net/devlink/devl_internal.h                   |  17 +-
 net/devlink/netlink.c                         |  38 +-
 net/devlink/netlink_gen.c                     | 350 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 142 +++++++
 19 files changed, 738 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1

