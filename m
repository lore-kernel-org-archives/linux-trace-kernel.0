Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C13BF693
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309862; cv=none; b=s8IOXfqm6SK224YmCHJXQLD4kDUW8nq/yfwXOM2HKj7/WlgEvljsdGbpmUbUb6viTJRDiErEs5/k6KvtU76ZO5J9Ey8LGtpnM2DaVeydFFXcYpnPEhaf7WpZa9S4/WhJul0LbnfsQP8wf8XcWNFtQiAee1+Q/ykmHFQYD+kD63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309862; c=relaxed/simple;
	bh=7DRFVjIY+Ygj/L7QkL1uTDqAGAZViCzf/BNmCHn88Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVqkij2ry8IVjwtgZpR6HGjTSyYkaMYLYOvEWUGe1JvuEcJ+hIrInvkcrypwGgbftRAi/SMb5BPxRRPQVw2LXyDZyzZgT3HjMaHHYDAOl9BQ16lhxl+7b/TTtFXVZ4n0NsXGGxAlhpzKq6FummDC2V/V9qquZEezFZeRULeMxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KSIjSVQq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KSIjSVQq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439fe4985efso678087f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309857; x=1773914657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=KSIjSVQqlLM6E+xIK5q2jBSjB/vBFosH4JkpAltGAax2/BQpY0uh1aIsegW2Nlh6SP
         1oAcecgqEZDMO4kmnlNDXbM57TokOVqNZOnU4mUZx+FdZth5alTWSEkDU29xwIXPcsrw
         ZLubgtFlefLPyEFdGd6n9dzhwTfs8ZsQFixqdmQRp9n3GbdZsGgzxx+z5W8qohb99SVa
         xxeRnv1ri7qvVZImf/lEao+JUZ2xFl0lPgdeu2jdTQl6b94N0SuNcWTQO+VF54T1H8Y5
         mIvPVKelhpj4H/G9kgPcz0aUDLe85NIvTNisS47IdEhrhqGrqlxZmkoKe1CfxakbinCS
         7C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309857; x=1773914657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=M8V61qRon7hifRT+vOhc+WhL0AOpfk0+BKelSjUgxgF99yIkhJmntdsQSUFpE+RSxj
         iYw4zZfCAUA0Kc/pAXfgDzAZcMiFp8yAWNY2IKJj99ApAYh2TKRgLsmpcI+t9fUjqG0g
         txmBTV+kblU0brkAT+xi8gGD6Ls5IiDCqAcGfeaDzeOK7XsailEKfQHqcO0GZverBGYm
         7uJvbhi781a5Yr3eYLhxpSY8AQL+/3eOAHZsHk5tKMWTrY/R1MyzVaDo32fCy7Q5faxn
         ig9ZZXXtPdpRf3Ru0EdfiXBpwtliQ6uczRI0XCJB5LDv60nkh+JEDmO1kHvTJKrJFNyP
         8Q+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9Q29o/EBok47gcL1FlBpojD3OjzZDTLsQ/KUvJ3If2+lhRl8TEXGnTVUyrHm2daWg/96NWaRMlam6Su9ufmL1hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIqANjHk9ri9vOzCjFLj9h37XfLl2TooXVnJwg2ASIBQvq4hh
	4+OGTWIdr5UDLPgq9C2Ypy3Z+Ib0hXObefbYQU1as7V5zbACicl4Em2Qo6WN6uxQbTU=
X-Gm-Gg: ATEYQzx91OabwvFTdSYRVnEthNqtnYutgWfRC8S3M1s8o/0gQrEABOiEDFNGgA655Zu
	LqG6g5n3I4sXGD0kIqyM5pjN6DPwPBMo159sLqhxIcwJkP3fgyFsw/aCxSMcJA4zmr1tr93tDsY
	yXJA9uj/9qnWUi43Ft/oIyZ4JZUJIHPGK4lRtS8YeTPoaM42/+sYZ0fa0pjFZ+xcIkYIzCNwDBs
	8w6QdpDw84vDjNPGn3lHLP4gr/CHwR2eqp9IzKQwORRkT48/KClqFVioo9T4uknA/JPMpH59+0X
	PU7z0KANfhDnwfI3Gz5U8MaMBDsKyB2id4kguJQh5koYEEMwxy8jLl6KT9gsGrlfgtL/0j8BEua
	b7Uzjk85aPYQTi0hCJgMHd4Niqyh/WW0fMGL2cqMtji52q/YZ+OLt58lo6uoZJiUTf73nbe8SEj
	AJdt5dLGGWJO+c8w==
X-Received: by 2002:a05:6000:186a:b0:439:b1c3:84bc with SMTP id ffacd0b85a97d-439f81e297fmr11955825f8f.7.1773309857325;
        Thu, 12 Mar 2026 03:04:17 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b4dasm6982812f8f.18.2026.03.12.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/13] devlink: introduce __devlink_alloc() with dev driver pointer
Date: Thu, 12 Mar 2026 11:04:01 +0100
Message-ID: <20260312100407.551173-8-jiri@resnulli.us>
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

Introduce __devlink_alloc() as an internal devlink allocator that
accepts a struct device_driver pointer and stores it in the devlink
instance. This allows internal devlink code (e.g. shared instances)
to associate a driver with a devlink instance without need to pass dev
pointer.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/core.c          | 40 ++++++++++++++++++++++---------------
 net/devlink/devl_internal.h |  5 +++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 237558abcd63..fcb73d3e56aa 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -418,27 +418,15 @@ void devlink_unregister(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_unregister);
 
-/**
- *	devlink_alloc_ns - Allocate new devlink instance resources
- *	in specific namespace
- *
- *	@ops: ops
- *	@priv_size: size of user private data
- *	@net: net namespace
- *	@dev: parent device
- *
- *	Allocate new devlink instance resources, including devlink index
- *	and name.
- */
-struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
-				 size_t priv_size, struct net *net,
-				 struct device *dev)
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver)
 {
 	struct devlink *devlink;
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops || !dev || !dev_driver);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -453,6 +441,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 
 	devlink->dev = get_device(dev);
 	devlink->ops = ops;
+	devlink->dev_driver = dev_driver;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
@@ -480,6 +469,25 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	kvfree(devlink);
 	return NULL;
 }
+
+/**
+ *	devlink_alloc_ns - Allocate new devlink instance resources
+ *	in specific namespace
+ *
+ *	@ops: ops
+ *	@priv_size: size of user private data
+ *	@net: net namespace
+ *	@dev: parent device
+ *
+ *	Allocate new devlink instance resources, including devlink index
+ *	and name.
+ */
+struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
+				 size_t priv_size, struct net *net,
+				 struct device *dev)
+{
+	return __devlink_alloc(ops, priv_size, net, dev, dev->driver);
+}
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
 /**
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f0ebfb936770..3cc7e696e0fd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,7 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const struct device_driver *dev_driver;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
 	 * port, sb, dpipe, resource, params, region, traps and more.
@@ -66,6 +67,10 @@ struct devlink {
 extern struct xarray devlinks;
 extern struct genl_family devlink_nl_family;
 
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver);
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
-- 
2.51.1

