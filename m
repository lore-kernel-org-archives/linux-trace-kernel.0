Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15E351C1F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640033; cv=none; b=khxg6rdV1YnTNR+Q74zyoKe3wVxOcKNAicViXqSdk/Ibk9tpHtKPbW4R3f4IDnrcplOIZvKsG6MF2RGwT6ZEyJ0lAlGtinCKSAq/H4kmJMc26lFhHCi6av2WhO/Pats6gv5nwBBNT/xAJSY9ikCamg1AvtFoROxmI/xWURhF4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640033; c=relaxed/simple;
	bh=BrwM4XM4KMM/lo8saPOgEzUdEI2YOnTiFYCS9aa1d5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTOL8cU+VLPOemEtlN9MBaw9H868ynCok2+y+ZFzr2/5034cE9jPHYfpGYUtGr/Me922CP9q7dQhx866bWONMJMdsN7WS6LZP0BxARiyeROWXf60JYG2VndEzGgREGn2bJWWJB66dztcoN9OZiTgBFSmcZevWRetMK37SJ4mR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BJ5vkHCH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BJ5vkHCH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439afc58ac7so4045725f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640030; x=1773244830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWrXUQ1J7/v/C4aUUHZrL7KMegfL3shCNXRwtxlNqOQ=;
        b=BJ5vkHCH3/tNU+yeej5X0l0Si4c+8PTqOvkhydLzIZJ7ZqZH4XXg4DYeBh9wsJ8qTl
         fnSVze8ba4zXFLBsa4NqvZue2sUjeNsdLGOd2n6bwvpnR595aFeUw5ivHoQl5V30UM4J
         QY6Im1bT4tFOAygAfCwMSVAKryIV7X4dfgyiICVcXoumYoon5BZ592CzyXXPK/6dcTVu
         GVJs6zJhf1WwnBzNyioG/V+DL/P9GR4dKbdVDirv0GKzs0LCbPrkRllxEJwsTEJW9LVa
         aY6kOj73nlGr1XyOwJE0IpXOUAPobaLbdrKg/cbpAooAQAuljnS2HCCc2t/smBTY22Be
         Tp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640030; x=1773244830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWrXUQ1J7/v/C4aUUHZrL7KMegfL3shCNXRwtxlNqOQ=;
        b=sFMrt8bBsgEUXSa4gr0pSrs2LF5c7sCupH3S4mBere2Fmov/sUeSuEg4cpigqc167+
         byFwF30p+lts+Mau75BziRLIBl/+7N2wPYonb3V8DlWwKJBOcY58DcUyZwxfGdnV1gAm
         /AfDChTKjqayd+gWabtNksmvl6TAnsoFyfB/f3g//h6opnnSCz8maiTSkBqASg4vejjE
         jhI3ruJR3b8kjfjaBsE92sGA2X9/EaK19P85nnUnMbS8qfTLPzebsv9jbh5Ss4s0JYvy
         09YxqpL+izXwZaYlRwSaUqjgEvzUiYd5hvBYQ4Z0CPLzF3lPcM9EbV25r7Ua5fpgsv5R
         J36g==
X-Forwarded-Encrypted: i=1; AJvYcCUzhGN9m5fFrHz9JTdeS45qctKyMq84PZ9IRayHjUuyEF2Vv+2JmMJwjwruhMqFuVmSZgWy5rYsUbQC0foyG181jt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgIyqw7Cdaa0GM81fgST9DO9oVHGUd4QHzf6k1PQhCbrlNIZuL
	GfK+J39405tUIEb0fozzELE3G8cwDSitEEVnEOmgnikMWRe6Y71Ts8wgi52AnTbmRlM=
X-Gm-Gg: ATEYQzx9DY/6xGlfI47HWFQsCyYC2Ni0YF11Drxoa6QwgbPGwzkJG3G1gyZvhJjuQiJ
	KgAcstxAJiFdfsvfRS42yY32RpLkbZP9j4LpihCTzEIIKXG4KxcjhU5blTSEcOQDYqSUjc8hjwE
	rRkWh506UJFp87qLslb76eJp8Rk47dFVZBIdj4v47jf/Sx9eCDmMxsGmPAPadp+yaCiEK0ioHfq
	XzQfcZscDgd8FtD0w6O+LKkNFT8XcGyjTl6PRbb0myzRsRdDhU0DIR2BoX5oE1g0tIw90qrCUSn
	9E842sTVTWLULEps7Nsky9fboKUxtaXu9CTbQ+JgN0EXreXigdSHZefWnk/ajRrCJvoiaxX5cii
	ABcT+KzNgWJIKweP669MJbwu6QpGIegotl6eyS0ijGtqth1el2On5LZewT52e4ED29mghO7Wl79
	8G+x3uKXXKAzw3rBmJNqNHhEG4YaUl0heFeXB2uUpLKvMV9g==
X-Received: by 2002:a05:600c:608c:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-48519847c92mr38638575e9.1.1772640028394;
        Wed, 04 Mar 2026 08:00:28 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c4489279sm12476015f8f.20.2026.03.04.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:27 -0800 (PST)
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
Subject: [PATCH net-next v3 02/13] devlink: add helpers to get bus_name/dev_name
Date: Wed,  4 Mar 2026 17:00:11 +0100
Message-ID: <20260304160022.6114-3-jiri@resnulli.us>
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

Introduce devlink_bus_name() and devlink_dev_name() helpers and
convert all direct accesses to devlink->dev->bus->name and
dev_name(devlink->dev) to use them.

This prepares for dev-less devlink instances where these helpers
will be extended to handle the missing device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- don't store bus_name/dev_name in devlink struct
---
 include/net/devlink.h          |  2 ++
 include/trace/events/devlink.h | 24 ++++++++++++------------
 net/devlink/core.c             | 12 ++++++++++++
 net/devlink/devl_internal.h    |  8 ++++----
 net/devlink/netlink.c          |  4 ++--
 net/devlink/port.c             |  4 ++--
 6 files changed, 34 insertions(+), 20 deletions(-)

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
index d8e509a669bf..63709c132a7c 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -248,6 +248,18 @@ struct device *devlink_to_dev(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_to_dev);
 
+const char *devlink_bus_name(const struct devlink *devlink)
+{
+	return devlink->dev->bus->name;
+}
+EXPORT_SYMBOL_GPL(devlink_bus_name);
+
+const char *devlink_dev_name(const struct devlink *devlink)
+{
+	return dev_name(devlink->dev);
+}
+EXPORT_SYMBOL_GPL(devlink_dev_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 31fa98af418e..1b770de0313e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -174,9 +174,9 @@ devlink_dump_state(struct netlink_callback *cb)
 static inline int
 devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 {
-	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->dev->bus->name))
+	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink_bus_name(devlink)))
 		return -EMSGSIZE;
-	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
+	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, devlink_dev_name(devlink)))
 		return -EMSGSIZE;
 	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
 		return -EMSGSIZE;
@@ -211,8 +211,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 					    struct devlink *devlink)
 {
 	memset(desc, 0, sizeof(*desc));
-	desc->bus_name = devlink->dev->bus->name;
-	desc->dev_name = dev_name(devlink->dev);
+	desc->bus_name = devlink_bus_name(devlink);
+	desc->dev_name = devlink_dev_name(devlink);
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..56817b85a3f9 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,8 +193,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0) {
+		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
+		    strcmp(devlink_dev_name(devlink), devname) == 0) {
 			devl_dev_lock(devlink, dev_lock);
 			if (devl_is_registered(devlink))
 				return devlink;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1ff609571ea4..fa3e1597711b 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -220,8 +220,8 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 {
 	struct devlink *devlink = devlink_port->devlink;
 
-	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
-	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	return nla_total_size(strlen(devlink_bus_name(devlink)) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(devlink_dev_name(devlink)) + 1) /* DEVLINK_ATTR_DEV_NAME */
 	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
-- 
2.51.1

