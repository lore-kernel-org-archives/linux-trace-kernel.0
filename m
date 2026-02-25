Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0653BFE20
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=oZqUzSbE7roh/V6L3ky/oAdsuP94Ok10gWRXX8GXphKUqk4BoMTG6ZyPIC1h2BruPIi1jbm9XWTmerxMq4bm4C1w83/uh5C4qkTVT5D7HrgDciIbCWqq9HSZw0S82sof1UHDxAGV7uhUuvRLzjx4b2lhQ0VMGlouif0XAmiiiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=zeq1qYaapsId/hMjNxT4XCjJUdeaG/At8G0u37BOTM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKPeRwF91B3WRJr9mBzc+ebLl6rDCIR5+KmuFXNHfVizRhGulpIuSXgX0V+pFeerdaqbkIeMit3A/tz2AIQIhnmMkX7JtXwcFfgecMdRu8ImydrO7C/JokqO6l+wx+mM/OAeHs8UiUSZxYEIAszjgpjK2SoBIlvXZe3J5XQu7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BCZJ2Gcn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BCZJ2Gcn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso8610375e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026467; x=1772631267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX2aUB9g6X7V6jOCUdCUrjVSDVEhvqjbcn21mgNjpkQ=;
        b=BCZJ2Gcn+JTSYzmoLKmiSQwiWZzeE4loMgsAfJd6CBvU5qPCkCsfEYfBzAPvVBr0Cc
         42Vu3eBOTPnbeLSYnWf66rTS5ZjI1ahwueEZ5JRvNGke/X1tQYLUW9u1UvtWYiYrxQgo
         0h1zSAz0sehVcaU7w7gZt9Uxi8fubYmOOhPoS3Mv9EBA7j7HbFY0PMaSBJ2gDijJtovv
         HjJ7QIX9KxWlUZhGsGgslYu1Nz4OS24n/KzH+2uQv7W0Gr1/9vMoCS4UzvVw79yacrV8
         Ougsfj46dCeVybaxbwet4iTLmD05+MiQcD0G8ElMjZA4t221nPzWEPyc6ZDv6iyu+ASa
         xZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026467; x=1772631267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dX2aUB9g6X7V6jOCUdCUrjVSDVEhvqjbcn21mgNjpkQ=;
        b=v7k/TFk8BNq+KC2SylcFBeqqOrRtI8/lBlwsoWOrrqe8H5ghPLrS5NRMrf44HUI5YQ
         n40k6D8qXZ93cnvdmBSLV36rHG3evozzsjLekTCKfdLIF8edECr6Fi16fKh6xaMeYpUE
         7wPuRd7ybKVLWzeQH/VcLtQRSCy9a8C7rkKvoC7GiLHqDE+ZyJscg9qokLBCRhQMX7D4
         dDRuzqz+1rGdMIrPbVew84n65HuuQe3dEi+uzMguVH2JhpD6gocTgqhIqFGB1jDVqLkG
         Gfgid8Bg9IANVF9HvnK6nEpsamU40f1KuF99kIjG0xSITNWa5A8mLZb9ey39V9xgyBIU
         3Jvw==
X-Forwarded-Encrypted: i=1; AJvYcCWRKi4S4wDlwY+Fj1wGD1HmdpuGMHtF4fca706rHcbexS8aUl7U8d0EdzV5xh4i8guTCm1cVDzYWwQw3YLsXu14vCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdb1vl7EhFIBJntEvxwyZrAA7bDCd4I1IG2BH9XYPl3k++Aw88
	F+7U0qPTg+uBOBkvdT6Ld2hfUCnSULc9wDOgvyS2oyLglS+elbvV586FdJgtzuTRSLE=
X-Gm-Gg: ATEYQzzQ4jiHwGLbWGpCqC59Wu7JsSNVInXUo1O365sLp1JKiMHFsLVK/vWl45m4ozF
	ljZv7xF7D/eczpWxbsbS5VRiid0ay6xJBdEha2h+gS9eWzD9VNN7MEZWSDI+L/TWolcIbJ2FD88
	aEJ85TZrwDp0mQPCNpuwFqU8M/8Vc2Ers5OXL50Jlyy2XMvnFU0uwfw94EfHSFsi+y4M4qSI2P3
	g+5roUsyqOykPUMAlEtyJwqIHLYmUw7Jafnfs5waKBzS4ifjRm0oye3/7HboWzv/GypN/R597lx
	cUHdJ4fd5XI6h0IG7XeuAcj8AWvwIcFJ3ZHZZ4WNOo6TcVfG72VlvcONTrZQZFgk5Btvjrvdqnj
	0ldJnFZT4KkgHhP5bpf7Fodx4Sg4OWQivJB5OMdYiPaZemlDqq0MbF7MuQwWBfSaZdTwkDPOqNi
	XV6Mpd7RqU3OyXUA==
X-Received: by 2002:a05:600c:8b56:b0:483:7b99:131d with SMTP id 5b1f17b1804b1-483bd75e26emr68403175e9.16.1772026466481;
        Wed, 25 Feb 2026 05:34:26 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm80756235e9.9.2026.02.25.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:26 -0800 (PST)
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
Subject: [PATCH net-next v2 02/10] devlink: store bus_name and dev_name pointers in struct devlink
Date: Wed, 25 Feb 2026 14:34:14 +0100
Message-ID: <20260225133422.290965-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, bus_name and dev_name are obtained from the parent dev
instance every time they are needed.

In preparation to dev-less devlinks, store bus_name and dev_name
pointers in struct devlink during devlink_alloc_ns() and use them
throughout.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h          |  2 ++
 include/trace/events/devlink.h | 24 ++++++++++++------------
 net/devlink/core.c             | 14 ++++++++++++++
 net/devlink/devl_internal.h    | 10 ++++++----
 net/devlink/netlink.c          |  4 ++--
 net/devlink/port.c             |  4 ++--
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..0afb0958b910 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1611,6 +1611,8 @@ struct devlink_ops {
 void *devlink_priv(struct devlink *devlink);
 struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
+const char *devlink_bus_name(const struct devlink *devlink);
+const char *devlink_dev_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index f241e204fe6b..32304ce9ad15 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -21,8 +21,8 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_ARGS(devlink, incoming, type, buf, len),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(bool, incoming)
 		__field(unsigned long, type)
@@ -55,8 +55,8 @@ TRACE_EVENT(devlink_hwerr,
 	TP_ARGS(devlink, err, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(int, err)
 		__string(msg, msg)
@@ -85,8 +85,8 @@ TRACE_EVENT(devlink_health_report,
 	TP_ARGS(devlink, reporter_name, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
@@ -116,8 +116,8 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_ARGS(devlink, reporter_name, health_state, time_since_last_recover),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
@@ -150,8 +150,8 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_ARGS(devlink, reporter_name, new_state),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
@@ -181,8 +181,8 @@ TRACE_EVENT(devlink_trap_report,
 	TP_ARGS(devlink, skb, metadata),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index da56e2b8afc1..49f856beb8b2 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -248,6 +248,18 @@ struct device *devlink_to_dev(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_to_dev);
 
+const char *devlink_bus_name(const struct devlink *devlink)
+{
+	return devlink->bus_name;
+}
+EXPORT_SYMBOL_GPL(devlink_bus_name);
+
+const char *devlink_dev_name(const struct devlink *devlink)
+{
+	return devlink->dev_name;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
@@ -428,6 +440,8 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 		goto err_xa_alloc;
 
 	devlink->dev = get_device(dev);
+	devlink->bus_name = dev->bus->name;
+	devlink->dev_name = dev_name(dev);
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 31fa98af418e..d43819c6b452 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -32,6 +32,8 @@ struct devlink_dev_stats {
 
 struct devlink {
 	u32 index;
+	const char *bus_name;
+	const char *dev_name;
 	struct xarray ports;
 	struct list_head rate_list;
 	struct list_head sb_list;
@@ -174,9 +176,9 @@ devlink_dump_state(struct netlink_callback *cb)
 static inline int
 devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 {
-	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->dev->bus->name))
+	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->bus_name))
 		return -EMSGSIZE;
-	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
+	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, devlink->dev_name))
 		return -EMSGSIZE;
 	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
 		return -EMSGSIZE;
@@ -211,8 +213,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 					    struct devlink *devlink)
 {
 	memset(desc, 0, sizeof(*desc));
-	desc->bus_name = devlink->dev->bus->name;
-	desc->dev_name = dev_name(devlink->dev);
+	desc->bus_name = devlink->bus_name;
+	desc->dev_name = devlink->dev_name;
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..3f73ced2d879 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,8 +193,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0) {
+		if (strcmp(devlink->bus_name, busname) == 0 &&
+		    strcmp(devlink->dev_name, devname) == 0) {
 			devl_dev_lock(devlink, dev_lock);
 			if (devl_is_registered(devlink))
 				return devlink;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1ff609571ea4..1d4a79c6d4d3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -220,8 +220,8 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 {
 	struct devlink *devlink = devlink_port->devlink;
 
-	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
-	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	return nla_total_size(strlen(devlink->bus_name) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(devlink->dev_name) + 1) /* DEVLINK_ATTR_DEV_NAME */
 	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
-- 
2.51.1

