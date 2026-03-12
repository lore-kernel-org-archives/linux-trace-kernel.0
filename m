Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38793C0637
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309865; cv=none; b=LdHHxYjav3n1Yzgw65VrePByL54OobWNGA3c8hwteWe6mmjsl7R4BQVg0iDw2zMJ9BoESfFOjvkwTLN2QptWgzpOYTEAGXoIeq58guHIZDBzWayBjCiqX/0EatFKU5QZyeQDvkI7X60m33ud6f72VZoxmWFGiemsy2T66dFwJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309865; c=relaxed/simple;
	bh=sBqoFY/Rv5DTMYj++KN0Sw7vm98e4uLLhQx69umkhKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4Cc3Gd/6yIGrzyDE2XXqcpGjgO4GanweNCHBFlCrvYGFztAjDUqMhwiPhY6VQAqYTJzBQ7e4fvoxQa3IQk7bveZcc8YaypZiJQVI6XU/Us14VaIb/5ZR8e5xbKNdysfRnMzzo/vSe5f8tr2YcgFPV3O1BkL+cMmeJDdpFtS8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nPFpBszh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nPFpBszh"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso665401f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309861; x=1773914661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thO3CTOoToOBK7xy8RWX7tgy+PjuAbGp4xc08ttDkvM=;
        b=nPFpBszhbGckY2T39kNhjRZLqn2FeoSdvwQca2KxEHPTVNTKUM2BBJJAVFxPTlPGti
         19TybGTrmLNtkDi6FkRZJg1g6T87yaCC2TClJLpGecTOH+EAHQDzV/GmdfkbR4AW7HR7
         vhH1AuzTKGOIIJSnjV8aecTWwl9VWDE1UfLJw6PHOZT2il61nvM472D1a8Lmae6DAUtp
         ASmeuxKJnWyM8o4m9TqCAYO70IRD40mBk+pDyoX2iSvHuSoJoL6LI+CZC+AWK47of6S0
         ak8GpnxpvSb923AqGK76YJzu9NUVZfErmIua1aJ7ZvWzz9QDGPProQaX5kuW5myRKR0u
         d7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309861; x=1773914661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thO3CTOoToOBK7xy8RWX7tgy+PjuAbGp4xc08ttDkvM=;
        b=I05xqyVQCkRrFT8jyg+Wbz5pK4JaPULytwDgYgClrwjfgXlWx5NQVP4Otda9NjJ/xC
         oEolaMOAIq8ssdtzV1iY3vBwftv2SIOtkWzKw927mjGffE67q3dT7YAw1FRYxqK4tfE7
         YMPkbstMq/u0qZ4nKR/aCDD/jMdj4hEDZuGlMMPMXtY1kZZvFxmIhQ4LNL8+FZWiC4q4
         MS01dGizPW7JCmnIvw34sjYjLLgudQhCBiV5uVogk3yYeqVPM8Q44gFF1NxjvSYxIvgC
         ZEZQYGV6bvQy5qXuZp6CMOmSgT4gB8+H5dfN7eyzTyuDFqNPPjmpqZGGfF4pZpGqm7kb
         rwYw==
X-Forwarded-Encrypted: i=1; AJvYcCUG5cGn3zks3JpSkyUh+jEQf1OzPAsYT3tSWR5RgOSxeH3aatC8xDY1PHcFXdYJtcrW9+S0Huf5vAlgBOPqi2mKt1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykoi8C7sL3Csv3TTTJER8B8t001vZqX40jg+CsoLDuJIZoL870
	LjwOeCl6OYVUla0dLo6swIuKQdYhBNzof3TFh4xvOjZvjVkI/FHaAAUPAI+cPqLfmDo=
X-Gm-Gg: ATEYQzz+Pov+OU2tXrzPDvfyoMOXaUufNmnnxPo0ZtApEMPSl82tUYkDZN5kHPOxMAf
	9Salf2xkfvarSu4A7B8r4KY+FdFx2RNi4+gW22qIbYiH8IGX8lyrBK5G5x4qAOOuc3hNRfxHoS0
	LP6IEPT7DeFZTOZeD8sLOOm67JfxjtFX5VYc/dPrCQD2MMYw2aiP5xCSgTfuKjLabc0/Br7Qwd0
	ECgv0k3kRqaPCxZX4oQwn6vEOknBneiEFSIy9rh0HJaInxCAigggU+h8xt+8IwVPmYaX/8sS1CG
	hcwnlgZPmmhmjdryp92hDrWBKTJ8RtqFnyd310ouWNAqEWzDudVLkZpefuYw28QTru1K7oE/caS
	+OnWqAEcoVrbuwSm/Flt6VcrkzpFaKjDwJr5UQb36pkV+FOFzZ2qfJL4HTDHm7hrZnCZCm3QQVA
	vUsXP0AxSqlO7p3w==
X-Received: by 2002:a05:6000:3113:b0:436:1b1:6cbd with SMTP id ffacd0b85a97d-439f81bd9dfmr10491594f8f.6.1773309860923;
        Thu, 12 Mar 2026 03:04:20 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19abbasm6336477f8f.6.2026.03.12.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 10/13] devlink: allow devlink instance allocation without a backing device
Date: Thu, 12 Mar 2026 11:04:04 +0100
Message-ID: <20260312100407.551173-11-jiri@resnulli.us>
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

Allow devlink_alloc_ns() to be called with dev=NULL to support
device-less devlink instances. When dev is NULL, the instance is
identified over netlink using "devlink_index" as bus_name and
the decimal index value as dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of __devlink_alloc() introduction
- removed dev check before dev_warn (devl_warn is used now)
- rebased on top of devlink->bus_name and devlink->dev_name removal
- rebased on top of devlink->dev_driver addition
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition to patch #5
- added comment to dev arg that it can be NULL
- fixed the index sprintf for dev-less
---
 net/devlink/core.c          | 23 ++++++++++++++++++-----
 net/devlink/dev.c           |  8 ++++----
 net/devlink/devl_internal.h |  5 +++--
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 34eb06d88544..eeb6a71f5f56 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -250,13 +250,13 @@ EXPORT_SYMBOL_GPL(devlink_to_dev);
 
 const char *devlink_bus_name(const struct devlink *devlink)
 {
-	return devlink->dev->bus->name;
+	return devlink->dev ? devlink->dev->bus->name : DEVLINK_INDEX_BUS_NAME;
 }
 EXPORT_SYMBOL_GPL(devlink_bus_name);
 
 const char *devlink_dev_name(const struct devlink *devlink)
 {
-	return dev_name(devlink->dev);
+	return devlink->dev ? dev_name(devlink->dev) : devlink->dev_name_index;
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
@@ -329,7 +329,10 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
-	put_device(devlink->dev);
+	if (devlink->dev)
+		put_device(devlink->dev);
+	else
+		kfree(devlink->dev_name_index);
 	kvfree(devlink);
 }
 
@@ -432,7 +435,7 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev || !dev_driver);
+	WARN_ON(!ops || !dev_driver);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -445,7 +448,14 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = get_device(dev);
+	if (dev) {
+		devlink->dev = get_device(dev);
+	} else {
+		devlink->dev_name_index = kasprintf(GFP_KERNEL, "%u", devlink->index);
+		if (!devlink->dev_name_index)
+			goto err_kasprintf;
+	}
+
 	devlink->ops = ops;
 	devlink->dev_driver = dev_driver;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
@@ -471,6 +481,8 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 
 	return devlink;
 
+err_kasprintf:
+	xa_erase(&devlinks, devlink->index);
 err_xa_alloc:
 	kvfree(devlink);
 	return NULL;
@@ -492,6 +504,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 				 size_t priv_size, struct net *net,
 				 struct device *dev)
 {
+	WARN_ON(!dev);
 	return __devlink_alloc(ops, priv_size, net, dev, dev->driver);
 }
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index e3a36de4f4ae..57b2b8f03543 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -453,7 +453,8 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	 * (e.g., PCI reset) and to close possible races between these
 	 * operations and probe/remove.
 	 */
-	device_lock_assert(devlink->dev);
+	if (devlink->dev)
+		device_lock_assert(devlink->dev);
 
 	memcpy(remote_reload_stats, devlink->stats.remote_reload_stats,
 	       sizeof(remote_reload_stats));
@@ -854,7 +855,7 @@ int devlink_info_version_running_put_ext(struct devlink_info_req *req,
 }
 EXPORT_SYMBOL_GPL(devlink_info_version_running_put_ext);
 
-static int devlink_nl_driver_info_get(struct device_driver *drv,
+static int devlink_nl_driver_info_get(const struct device_driver *drv,
 				      struct devlink_info_req *req)
 {
 	if (!drv)
@@ -872,7 +873,6 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 		     enum devlink_command cmd, u32 portid,
 		     u32 seq, int flags, struct netlink_ext_ack *extack)
 {
-	struct device *dev = devlink_to_dev(devlink);
 	struct devlink_info_req req = {};
 	void *hdr;
 	int err;
@@ -892,7 +892,7 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto err_cancel_msg;
 	}
 
-	err = devlink_nl_driver_info_get(dev->driver, &req);
+	err = devlink_nl_driver_info_get(devlink->dev_driver, &req);
 	if (err)
 		goto err_cancel_msg;
 
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index cb2ffef1ac2d..7dfb7cdd2d23 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,7 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const char *dev_name_index;
 	const struct device_driver *dev_driver;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
@@ -119,7 +120,7 @@ static inline bool devl_is_registered(struct devlink *devlink)
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 {
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_lock(devlink->dev);
 	devl_lock(devlink);
 }
@@ -127,7 +128,7 @@ static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 {
 	devl_unlock(devlink);
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_unlock(devlink->dev);
 }
 
-- 
2.51.1

